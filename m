Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2747FD004
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjK2HjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjK2HjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:39:16 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC9A219BC;
        Tue, 28 Nov 2023 23:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=sY8yr857R8VHDvrkt0
        s1ifvVPgK5Ibl5ySBhctpkUvE=; b=J9DwR28aKP99aETr2iBC7oR7gBkMMQst+K
        sXG6Z+jQzFoHx4sIu49JJVYJq+cdWQtxh6ZhJCCnQWXinzsUL732E96L/mYMrFIg
        A29fJN+hk2EuHRz6pU3HUXNowoLVxfnknzc+KjsgdMgF9CFKGAXMTBlB0vf7ggJa
        dftVvvx6U=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wD3H5Nc6mZlRNtgBQ--.14956S2;
        Wed, 29 Nov 2023 15:38:06 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     ysato@users.sourceforge.jp
Cc:     dalias@libc.org, glaubitz@physik.fu-berlin.de,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [sh/highlander] psw: Add error handling in psw_irq_handler
Date:   Tue, 28 Nov 2023 23:38:02 -0800
Message-Id: <20231129073802.31874-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3H5Nc6mZlRNtgBQ--.14956S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyruF4fZFWrJF1DWF4rXwb_yoWDXFb_Xa
        s7Zws7uwn3AwsavF1akF9xG34xA3s2qFyYqa48Xr12yrWUKrn5Xa4Iyr4kJr18WF4jyr4U
        JrykC39Fy3ya9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMpBTJUUUUU==
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiwh83glc661bqDwAAsd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index d445c54f74e4..fa18a56a0894 100644
--- a/arch/sh/boards/mach-highlander/psw.c
+++ b/arch/sh/boards/mach-highlander/psw.c
@@ -21,6 +21,12 @@ static irqreturn_t psw_irq_handler(int irq, void *arg)
 	unsigned int l, mask;
 	int ret = 0;
 
+	if (!psw) {
+		pr_err("psw_irq_handler: No push_switch data associated "
+			"with platform_device\n");
+		return IRQ_NONE;
+	}
+
 	l = __raw_readw(PA_DBSW);
 
 	/* Nothing to do if there's no state change */
-- 
2.17.1

