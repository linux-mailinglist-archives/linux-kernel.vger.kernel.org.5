Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741B07DB1FB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 03:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjJ3CIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 22:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJ3CIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 22:08:46 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 305D293;
        Sun, 29 Oct 2023 19:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+VA8C
        3toqulyIQ9z4C4kVFnJqVDDWinh7lJNiszMwjo=; b=gMK2eaXESLtSQTyTAPdNs
        PdoIQB4r5/rhsEeDD4bmIBloQZYFkeM1PDiui/Oz7EU+MHVUKjGUNPTXlp3pyFrP
        SpkdD8/ViICUNihTRXn9Ugjc4D4tYntbUB/VgLXI1koaYfmKLauI9QeILKKAvZkn
        MWGBMT9FqfAH12TsAgz7LU=
Received: from localhost.localdomain (unknown [106.13.245.201])
        by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wDnr09jDD9lkS9xBw--.63664S2;
        Mon, 30 Oct 2023 09:52:40 +0800 (CST)
From:   gaoyusong <a869920004@163.com>
To:     brauner@kernel.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] fs: Fix typo in access_override_creds()
Date:   Mon, 30 Oct 2023 01:52:35 +0000
Message-Id: <20231030015235.840410-1-a869920004@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnr09jDD9lkS9xBw--.63664S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFy7GFW3Kr43Zr43Zr4kCrg_yoWxKrX_uw
        40yr48Grs8tFyIv3s8WanYyF1Sg34rAF1rC3WfJrZxKryfZFnxuryDKrn7JrWUWr47K3s8
        Xrn8ZFZrXF4I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0Mq2tUUUUU==
X-Originating-IP: [106.13.245.201]
X-CM-SenderInfo: zdywmmasqqiki6rwjhhfrp/xtbBEQ0Z6VaEQlFWngAAsl
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yusong Gao <a869920004@163.com>

Fix typo in access_override_creds(), modify non-RCY to non-RCU.

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

