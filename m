Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5214A7CA663
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjJPLOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjJPLOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:14:10 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94000F5;
        Mon, 16 Oct 2023 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+lDdM
        FEigMrqHpaFKAPZrvj/+p5FNluVPO9zqeyMo1g=; b=A8WyhgO0E+RtKNNjoLxYd
        q+i+YxS8dD0kJCwuyb53BPcn5a6MsNWdRqr/T98tcGfEen97w6K2+2O9hv1TzUx3
        S4xhIGqDq7thy/SrV5/HyTNNZHMJy5lFaegN+dF2VasRSFAXQEDD3wIFIag3W7h7
        IDJ1zAdehVZvqKsd8EH1bY=
Received: from localhost.localdomain (unknown [106.13.245.201])
        by zwqz-smtp-mta-g1-3 (Coremail) with SMTP id _____wDXz5_lGi1lA1vjAg--.43446S2;
        Mon, 16 Oct 2023 19:13:43 +0800 (CST)
From:   gaoyusong <a869920004@163.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gaoyusong <a869920004@163.com>
Subject: [PATCH] fs: Fix typo in access_override_creds()
Date:   Mon, 16 Oct 2023 11:13:40 +0000
Message-Id: <20231016111340.785413-1-a869920004@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXz5_lGi1lA1vjAg--.43446S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFy7GFW3Kr43Zr43Zr4kCrg_yoWxCwc_Cw
        4Iyr48Grs8tryIywn8WanYyF1Sg34FyF1rG34xJry3KryfZ3ZxuryDKrn7JrWUWr47K3s8
        Xrn8ZFWDZF4I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNdb1DUUUUU==
X-Originating-IP: [106.13.245.201]
X-CM-SenderInfo: zdywmmasqqiki6rwjhhfrp/1tbiRQkL6WDu2Q2VAwAAsi
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in access_override_creds(), modify
non-RCY to non-RCU.

Signed-off-by: gaoyusong <a869920004@163.com>
---
 fs/open.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 98f6601fbac6..72eb20a8256a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -442,7 +442,7 @@ static const struct cred *access_override_creds(void)
 	 * 'get_current_cred()' function), that will clear the
 	 * non_rcu field, because now that other user may be
 	 * expecting RCU freeing. But normal thread-synchronous
-	 * cred accesses will keep things non-RCY.
+	 * cred accesses will keep things non-RCU.
 	 */
 	override_cred->non_rcu = 1;
 
-- 
2.34.1

