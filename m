Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA9D75C783
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGUNTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjGUNTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764662130
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689945504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3RZSzIkl7Lg2t6SJUFm5Lmk6ZzRLZxYILlnvYuCsuFM=;
        b=aZ/TL7VthrpYJswHCVw9Fbv+oEl2nq9+mHRl5s4tVzozTUs+sVb4zv5UOoqQ+y7+RfQaoX
        D2R09/ABXFqE313maF+3DAAZ4ibLkvGieWzW0Wee1KcoBgqCufK33cKGtjTuTczKtSmto9
        iShav6UWmp8VVPChHpFcDPGmrV7r7rs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-A6k7ExN7MsehoQtAg3USbQ-1; Fri, 21 Jul 2023 09:18:22 -0400
X-MC-Unique: A6k7ExN7MsehoQtAg3USbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6879A8F184A;
        Fri, 21 Jul 2023 13:18:22 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DF6540C2073;
        Fri, 21 Jul 2023 13:18:17 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, mawupeng1@huawei.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/3] mm/percpu.c: print error message too if atomic alloc failed
Date:   Fri, 21 Jul 2023 21:18:00 +0800
Message-Id: <20230721131800.20003-4-bhe@redhat.com>
In-Reply-To: <20230721131800.20003-1-bhe@redhat.com>
References: <20230721131800.20003-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'err' is assgigned to an error message if atomic alloc
failed, while it has no chance to be printed if is_atomic is true.

Here change to print error message too if atomic alloc failed, while
avoid to call dump_stack() if that case.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/percpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index c25b058a46ad..74f75ef0ad58 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1890,13 +1890,15 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 fail:
 	trace_percpu_alloc_percpu_fail(reserved, is_atomic, size, align);
 
-	if (!is_atomic && do_warn && warn_limit) {
+	if (do_warn && warn_limit) {
 		pr_warn("allocation failed, size=%zu align=%zu atomic=%d, %s\n",
 			size, align, is_atomic, err);
-		dump_stack();
+		if (is_atomic)
+			dump_stack();
 		if (!--warn_limit)
 			pr_info("limit reached, disable warning\n");
 	}
+
 	if (is_atomic) {
 		/* see the flag handling in pcpu_balance_workfn() */
 		pcpu_atomic_alloc_failed = true;
-- 
2.34.1

