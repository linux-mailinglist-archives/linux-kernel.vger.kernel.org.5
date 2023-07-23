Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4302D75E05B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 09:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjGWHzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 03:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWHzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 03:55:18 -0400
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D85BCB1;
        Sun, 23 Jul 2023 00:55:16 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.174.92.167])
        by mail-app3 (Coremail) with SMTP id cC_KCgDX3w_O3LxkGlx_Cw--.18759S4;
        Sun, 23 Jul 2023 15:54:54 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org, martin.lau@kernel.org,
        yhs@fb.com, andrii@kernel.org, void@manifault.com,
        houtao1@huawei.com, laoar.shao@gmail.com, inwardvessel@gmail.com,
        kuniyu@amazon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v1] bpf: Add length check for SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
Date:   Sun, 23 Jul 2023 15:54:52 +0800
Message-Id: <20230723075452.3711158-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgDX3w_O3LxkGlx_Cw--.18759S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZw43WF17XFyDXr4UGFyrXrb_yoWDtrg_ua
        1UXa48Z3WjgFWUX3W5Gay3Xr1xKr15ZFn5C3s8tFW7Kws0vay8XF48ArZIvFy7Gr4YvF17
        Jr98ZFyxXa1a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUbqNt7UUUUU==
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nla_for_each_nested parsing in function bpf_sk_storage_diag_alloc
does not check the length of the nested attribute. This can lead to an
out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
be viewed as a 4 byte integer.

This patch adds additional check before the execution of nla_get_u32 to
make sure the attribute has enough length.

Fixes: 1ed4d92458a9 ("bpf: INET_DIAG support in bpf_sk_storage")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 net/core/bpf_sk_storage.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d4172534dfa8..6f1afbb394a6 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -511,6 +511,11 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
 		if (nla_type(nla) != SK_DIAG_BPF_STORAGE_REQ_MAP_FD)
 			continue;
 
+		if (nla_len(nla) < sizeof(map_fd)) {
+			err = -EINVAL;
+			goto err_free;
+		}
+
 		map_fd = nla_get_u32(nla);
 		map = bpf_map_get(map_fd);
 		if (IS_ERR(map)) {
-- 
2.17.1

