Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929AB77A866
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjHMQBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjHMQBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353281719;
        Sun, 13 Aug 2023 09:01:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3794261F63;
        Sun, 13 Aug 2023 16:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC76EC433C8;
        Sun, 13 Aug 2023 16:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942445;
        bh=6vpI4hncf8p7sj5smIbF2U7rTxg/8La1G1cZO1nKrAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0ax7+WEGhOH1biErRsan8ZfstjLds1sYOYrsFiwAegEZpV/E6bF7YbPTc7wvtyaZ
         /xQLuhzQNSs09GaJ+jTzzpvP6o+Xsmxzw1oMmxF1LcQ8dE20P1GzgPfAcq08Omamic
         hZMHTVI7vRyv0nxhHBStau+phhN/lbYG1bN5qAeHR6ix3U8OPe+MIUk2J2yynjviI2
         4zZnppWqrdwMgb66hQR5Cy3tZ69KWKFr07X0+w+xVhZCb2FKDi6FkX2ore8E2oqvcX
         BI1q6cEuU25JVgJ4i0DOE3nK5wHtGymBJKNX9L9o9sX99gMCXRtC1n78b7+Y/jMK5d
         SIkr19x9VAEaA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Xu <xuwd1@hotmail.com>, Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/47] platform/x86: serial-multi-instantiate: Auto detect IRQ resource for CSC3551
Date:   Sun, 13 Aug 2023 11:59:01 -0400
Message-Id: <20230813160006.1073695-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Xu <xuwd1@hotmail.com>

[ Upstream commit 676b7c5ecab36274442887ceadd6dee8248a244f ]

The current code assumes that the CSC3551(multiple cs35l41) always have
its interrupt pin connected to GPIO thus the IRQ can be acquired with
acpi_dev_gpio_irq_get. However on some newer laptop models this is no
longer the case as they have the CSC3551's interrupt pin connected to
APIC. This causes smi_i2c_probe to fail on these machines.

To support these machines, a new macro IRQ_RESOURCE_AUTO was introduced
for cs35l41 smi_node, and smi_get_irq function was modified so it tries
to get GPIO irq resource first and if failed, tries to get
APIC irq resource for cs35l41.

This patch affects only the cs35l41's probing and brings no negative
influence on machines that indeed have the cs35l41's interrupt pin
connected to GPIO.

Signed-off-by: David Xu <xuwd1@hotmail.com>
Link: https://lore.kernel.org/r/SY4P282MB18350CD8288687B87FFD2243E037A@SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/x86/serial-multi-instantiate.c   | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 5362f1a7b77c5..85c9eabd85c08 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -21,6 +21,7 @@
 #define IRQ_RESOURCE_NONE	0
 #define IRQ_RESOURCE_GPIO	1
 #define IRQ_RESOURCE_APIC	2
+#define IRQ_RESOURCE_AUTO   3
 
 enum smi_bus_type {
 	SMI_I2C,
@@ -52,6 +53,18 @@ static int smi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
 	int ret;
 
 	switch (inst->flags & IRQ_RESOURCE_TYPE) {
+	case IRQ_RESOURCE_AUTO:
+		ret = acpi_dev_gpio_irq_get(adev, inst->irq_idx);
+		if (ret > 0) {
+			dev_dbg(&pdev->dev, "Using gpio irq\n");
+			break;
+		}
+		ret = platform_get_irq(pdev, inst->irq_idx);
+		if (ret > 0) {
+			dev_dbg(&pdev->dev, "Using platform irq\n");
+			break;
+		}
+		break;
 	case IRQ_RESOURCE_GPIO:
 		ret = acpi_dev_gpio_irq_get(adev, inst->irq_idx);
 		break;
@@ -308,10 +321,10 @@ static const struct smi_node int3515_data = {
 
 static const struct smi_node cs35l41_hda = {
 	.instances = {
-		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
-		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
-		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
-		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
+		{ "cs35l41-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l41-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l41-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l41-hda", IRQ_RESOURCE_AUTO, 0 },
 		{}
 	},
 	.bus_type = SMI_AUTO_DETECT,
-- 
2.40.1

