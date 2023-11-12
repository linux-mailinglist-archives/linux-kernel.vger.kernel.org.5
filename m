Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDFA7E8F06
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 08:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjKLHo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 02:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjKLHoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 02:44:24 -0500
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011332D77
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 23:44:21 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 258kraxZkSnL0258kru9kF; Sun, 12 Nov 2023 08:44:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1699775060;
        bh=CMJ7mtbkQ6wr2X7EyGA8oyEfbM3Nf5YejXN8k/sc2Rw=;
        h=From:To:Cc:Subject:Date;
        b=ersE2zY+Kx3K9M/oDZf/q2qmZMRggYKp7QWd9xNoylpaz16so9XmICfsr/zPUKeKY
         S0qRxmbdBHCHwWbc/mxfzJ6H+0XJtRb6jeRafZ6A5Ge7FQfHJZFJdbIs62JNplMPRG
         ur+wLFZyn4k7hhL+2mS3wzTLnXfl2E0Qg4nfvGaNVE7OmT1dIjcmRuOIlGJFJKvXZL
         1ZB44QWXHDqZSQcVWnaNTuhCEEvOj452lDib40/Sp4w1QoznsFBfe726kUG44yy2nW
         jxVmCAXxlRmD6ATPfV9CghnQ6G8GhFAn2zBgn3POK1SY2Tsu0Sy2AaTmTzl0z6+5RP
         R9+27WG5NGlWg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 12 Nov 2023 08:44:20 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86/dell: alienware-wmi: Use kasprintf()
Date:   Sun, 12 Nov 2023 08:44:15 +0100
Message-Id: <f2b2c9e5d80550e480a627c1b2139d5cc9472ffa.1699775015.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kasprintf() instead of hand writing it.
This saves the need of an intermediate buffer.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/platform/x86/dell/alienware-wmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index a9477e5432e4..f5ee62ce1753 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -429,7 +429,6 @@ static DEVICE_ATTR(lighting_control_state, 0644, show_control_state,
 static int alienware_zone_init(struct platform_device *dev)
 {
 	u8 zone;
-	char buffer[10];
 	char *name;
 
 	if (interface == WMAX) {
@@ -466,8 +465,7 @@ static int alienware_zone_init(struct platform_device *dev)
 		return -ENOMEM;
 
 	for (zone = 0; zone < quirks->num_zones; zone++) {
-		sprintf(buffer, "zone%02hhX", zone);
-		name = kstrdup(buffer, GFP_KERNEL);
+		name = kasprintf(GFP_KERNEL, "zone%02hhX", zone);
 		if (name == NULL)
 			return 1;
 		sysfs_attr_init(&zone_dev_attrs[zone].attr);
-- 
2.34.1

