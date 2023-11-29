Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123A77FCF46
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344518AbjK2Gip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjK2Gio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:38:44 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52315170B;
        Tue, 28 Nov 2023 22:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=GG6HhlQP9nDGltk5Zu
        JY29M8VLSt3lTWUXWJisYqeaw=; b=clQb5MA1av1RwF+U/rELPz3wRAyob3DRP2
        xoUjrByk+x+nNcHZQQCwy5EqRQEGFCLQH8LCF9fQ4bOnXGcs9zFGzzFTUtvYV7+0
        QxC8uk/dogawbJ6qPlQ/R4rlXOcyt9JgalrVITsz1aTZqTpXpeVG6x/pKoCzv4DC
        eEBeabQ3s=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g3-3 (Coremail) with SMTP id _____wDXDZMs3GZlqeoVCw--.42552S2;
        Wed, 29 Nov 2023 14:37:34 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     ysato@users.sourceforge.jp
Cc:     dalias@libc.org, glaubitz@physik.fu-berlin.de,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [sh/highlander] psw: Add error handling in psw_irq_handler
Date:   Tue, 28 Nov 2023 22:37:30 -0800
Message-Id: <20231129063730.31184-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDXDZMs3GZlqeoVCw--.42552S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyruF4fZFWrJF1DWF4rXwb_yoWDXrg_Xa
        s3Zws7Cw1fAwsIvF1akF9xG34fA3s7XFyYqa48Xr12yrWUKrnYqas7tr4kJr48Wr4jyrW7
        Jryku39Fy3ya9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_VWl3UUUUU==
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBcgU3gletj4wvsgAAsm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds error handling for the platform_get_drvdata call
within the psw_irq_handler function in
arch/sh/boards/mach-highlander/psw.c. Previously, the absence of
error checking could lead to unexpected behavior if
platform_get_drvdata returned a null pointer.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 arch/sh/boards/mach-highlander/psw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/boards/mach-highlander/psw.c b/arch/sh/boards/mach-highlander/psw.c
index d445c54f74e4..e079215e50e3 100644
--- a/arch/sh/boards/mach-highlander/psw.c
+++ b/arch/sh/boards/mach-highlander/psw.c
@@ -21,6 +21,12 @@ static irqreturn_t psw_irq_handler(int irq, void *arg)
 	unsigned int l, mask;
 	int ret = 0;
 
+	if (!psw) {
+		pr_err("psw_irq_handler: No push_switch data associated
+			with platform_device\n");
+		return IRQ_NONE;
+	}
+
 	l = __raw_readw(PA_DBSW);
 
 	/* Nothing to do if there's no state change */
-- 
2.17.1

