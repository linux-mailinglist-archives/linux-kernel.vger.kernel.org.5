Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FB980F139
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376996AbjLLPiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376867AbjLLPiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:38:08 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A49B2D3;
        Tue, 12 Dec 2023 07:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qsmI3
        BAXasvewu+CYpkdlcE7gVxCdWmIXccJmzg6HwU=; b=dHEGU4krs8j/d5YbMC6Di
        0YJoYkMmcuVDi7s/xyjLEmmWErkV7g4yMivF0uGBtEBU32QfEJyVjJwLJo6ZRnuM
        WTz4uke6QWkcirLoE615ZxE9q3eYmsnHBby5NTHJ8cSV1JR7jrthoqZBcTjEg3KB
        uyGFjJFeATbbcIvnrkPkfU=
Received: from ubuntu22.localdomain (unknown [117.176.219.50])
        by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3n1RDfnhl5xpkBA--.32155S2;
        Tue, 12 Dec 2023 23:37:39 +0800 (CST)
From:   chenguanxi11234@163.com
To:     rafael@kernel.org
Cc:     pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Haonan <chen.haonan2@zte.com.cn>
Subject: [PATCH linux-next v2] kernel/power: Use kmap_local_page() in snapshot.c
Date:   Tue, 12 Dec 2023 23:37:36 +0800
Message-Id: <b2fd8c52429b51fc0c060753e6b616f1edf81d92.1702020689.git.chen.haonan2@zte.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3n1RDfnhl5xpkBA--.32155S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1fKFWkZF18tF1fCr43GFg_yoW8WFy8pF
        45AFyDG3yFvFy8t34IqF1v9ry5WwnxA3yfJFW3A3WfZrnIgwnFvr1Iqa1Ut3W3trW7JFWr
        ZrZrtayvkFs5KwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jtgAwUUUUU=
X-Originating-IP: [117.176.219.50]
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/xtbBhglE+lc666MZSAAAsF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Haonan <chen.haonan2@zte.com.cn>

kmap_atomic() has been deprecated in favor of kmap_local_page().

kmap_atomic() disables page-faults and preemption (the latter 
only for !PREEMPT_RT kernels).The code between the mapping and 
un-mapping in this patch does not depend on the above-mentioned 
side effects.So simply replaced kmap_atomic() with kmap_local_page().

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 kernel/power/snapshot.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 50a15408c3fc..feef0d4d3288 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1487,11 +1487,11 @@ static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 	s_page = pfn_to_page(src_pfn);
 	d_page = pfn_to_page(dst_pfn);
 	if (PageHighMem(s_page)) {
-		src = kmap_atomic(s_page);
-		dst = kmap_atomic(d_page);
+		src = kmap_local_page(s_page);
+		dst = kmap_local_page(d_page);
 		zeros_only = do_copy_page(dst, src);
-		kunmap_atomic(dst);
-		kunmap_atomic(src);
+		kunmap_local(dst);
+		kunmap_local(src);
 	} else {
 		if (PageHighMem(d_page)) {
 			/*
@@ -1499,9 +1499,9 @@ static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 			 * data modified by kmap_atomic()
 			 */
 			zeros_only = safe_copy_page(buffer, s_page);
-			dst = kmap_atomic(d_page);
+			dst = kmap_local_page(d_page);
 			copy_page(dst, buffer);
-			kunmap_atomic(dst);
+			kunmap_local(dst);
 		} else {
 			zeros_only = safe_copy_page(page_address(d_page), s_page);
 		}
-- 
2.25.1

