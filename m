Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E225077A7C2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjHMPuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjHMPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE1610E3;
        Sun, 13 Aug 2023 08:49:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42A4963118;
        Sun, 13 Aug 2023 15:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A934C43391;
        Sun, 13 Aug 2023 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941789;
        bh=8uB1v67bkBVObBSr+qym6h7qFhZyrSOMdwf3QcukEuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JghscDe2OsXehmDmK1R6eMSk7nmywWBTPutdVWzAgcv+fb6ek1wqSWdEZH2LdHp2q
         CVYvdBYtnnW0rYr53BXprwAGu8hvd/G/Tf0GuURSEXYsCHrSeuLXT7d3yA6WCD1rop
         AZDoCOBG72R0eDm7Fsb69g7AVui4cBcOYKa+2MguuoajEikkFhOBZgN3ScFdlKiSM+
         z+2QfpBJGiJGsjMY3NpYE022K3oJ8TDytDakYZ2XvUlbDhU9Ogj96oDXFAWToXZhmA
         7/hpMNalPFr6X2XDdofEMX7OpiicGbCitniIvvPl8/nDvuDZKPk8nwFnDJan4f9+Oj
         cWG4mUN80eolA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Xu <xuwd1@hotmail.com>, Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 08/54] platform/x86: serial-multi-instantiate: Auto detect IRQ resource for CSC3551
Date:   Sun, 13 Aug 2023 11:48:47 -0400
Message-Id: <20230813154934.1067569-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index f3dcbdd72fec7..2c2abf69f049f 100644
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
@@ -307,10 +320,10 @@ static const struct smi_node int3515_data = {
 
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

