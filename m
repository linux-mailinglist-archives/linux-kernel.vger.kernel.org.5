Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310757AD1D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjIYHgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjIYHgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:36:19 -0400
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B42DA;
        Mon, 25 Sep 2023 00:36:10 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4RvF492VnMz9xk16;
        Mon, 25 Sep 2023 15:34:01 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 25 Sep
 2023 15:35:59 +0800
Date:   Mon, 25 Sep 2023 15:35:58 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <stone.xulei@xfusion.com>
Subject: [PATCH] padata: Fix the UAF issue related to parallel_data
Message-ID: <ZRE4XvOOhz4HSOgR@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00601.xfusion.com (10.32.135.241) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a high-load arm64 environment, the pcrypt_aead01 test in LTP can lead to
system UAF (Use-After-Free) issues. Due to the lengthy analysis of the
pcrypt_aead01 function call, I'll describe the problem scenario using a
simplified model:

Suppose there's a user of padata named `user_function` that adheres to
the padata requirement of calling `padata_free_shell` after `serial()`
has been invoked, as demonstrated in the following code:

```c
struct request {
    struct padata_priv padata;
    struct completion *done;
};

void parallel(struct padata_priv *padata) {
    do_something();
}

void serial(struct padata_priv *padata) {
    struct request *request = container_of(padata, struct request, padata);
    complete(request->done);
}

void user_function() {
    DECLARE_COMPLETION(done)
    padata->parallel = parallel()
    padata_do_parallel();
    wait_for_completion(&done);
    padata_free_shell();
}
```

In the corresponding padata.c file, there's the following code:

```c
static void padata_serial_worker(struct work_struct *serial_work) {
    ...
    cnt = 0;

    while (!list_empty(&local_list)) {
        ...
        padata->serial(padata);
        cnt++;
    }

    local_bh_enable();

    if (refcount_sub_and_test(cnt, &pd->refcnt))
        padata_free_pd(pd);
}
```

Because of the high system load and the accumulation of unexecuted
softirq at this moment, `local_bh_enable()` in padata takes longer
to execute than usual. Subsequently, when accessing `pd->refcnt`,
`pd` has already been released by `padata_free_shell()`, resulting
in a UAF issue with `pd->refcnt`.

The fix is straightforward: add `refcount_dec_and_test` before calling
`padata_free_pd` in `padata_free_shell`.

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 kernel/padata.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 222d60195de6..15dbcf7ce623 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -1107,7 +1107,8 @@ void padata_free_shell(struct padata_shell *ps)
 
 	mutex_lock(&ps->pinst->lock);
 	list_del(&ps->list);
-	padata_free_pd(rcu_dereference_protected(ps->pd, 1));
+	if (refcount_dec_and_test(&ps->pd->refcnt))
+		padata_free_pd(rcu_dereference_protected(ps->pd, 1));
 	mutex_unlock(&ps->pinst->lock);
 
 	kfree(ps);
-- 
2.40.0

