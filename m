Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC15A75C5CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjGULWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjGULWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:22:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09752198D;
        Fri, 21 Jul 2023 04:22:20 -0700 (PDT)
Received: from dggpeml100024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R6nDL6hbYzVjlR;
        Fri, 21 Jul 2023 19:20:50 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml100024.china.huawei.com (7.185.36.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 19:22:17 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] audit: correct audit_filter_inodes() definition
Date:   Fri, 21 Jul 2023 11:21:01 +0000
Message-ID: <20230721112101.176222-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.26]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100024.china.huawei.com (7.185.36.115)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After changes in commit 0590b9335a1c ("fixing audit rule ordering mess,
part 1"), audit_filter_inodes() returns void, so if CONFIG_AUDITSYSCALL
not defined, it should be do {} while(0).

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/audit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 94738bce40b2..a60d2840559e 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -334,7 +334,7 @@ static inline int audit_signal_info_syscall(struct task_struct *t)
 	return 0;
 }
 
-#define audit_filter_inodes(t, c) AUDIT_STATE_DISABLED
+#define audit_filter_inodes(t, c) do { } while (0)
 #endif /* CONFIG_AUDITSYSCALL */
 
 extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
-- 
2.34.1

