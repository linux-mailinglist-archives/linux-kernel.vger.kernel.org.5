Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE8B801CE8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjLBNJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjLBNJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:09:35 -0500
X-Greylist: delayed 558 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Dec 2023 05:09:39 PST
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C26311D;
        Sat,  2 Dec 2023 05:09:39 -0800 (PST)
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 01E0128BDEE;
        Sat,  2 Dec 2023 14:00:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
        s=gen1; t=1701522045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dlwa5psbH4GuBlFOgG5dQBJEh+/E3KdGiPUq4tEBZPw=;
        b=I8HEMqrCNV63kBxXZ+OeFCG+1g7cW9Pf5/KgMCjocGqRX+DFupxcT+R7CZyrxfqVDOCUFz
        XmBbUa/UozgbVwJOMhx8kMwY0nH0gC+Nb7U7dYEXYlY4j7ENIWOHRyLQ3SghteYQicNVAR
        D/8JSwirogd25XzlX0T0Gq3ZQpe0ork=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: karelb)
        by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id D53FA4443E5;
        Sat,  2 Dec 2023 14:00:44 +0100 (CET)
From:   Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>
Subject: [PATCH v3 5/5] input/touchscreen: imagis: add support for IST3032C
Date:   Sat,  2 Dec 2023 13:48:36 +0100
Message-ID: <20231202125948.10345-6-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202125948.10345-1-karelb@gimli.ms.mff.cuni.cz>
References: <20231202125948.10345-1-karelb@gimli.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karel Balej <balejk@matfyz.cz>

IST3032C is a touchscreen chip used for instance in the
samsung,coreprimevelte smartphone, with which this was tested. Add the
chip specific information to the driver.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 drivers/input/touchscreen/imagis.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 84a02672ac47..41f28e6e9cb1 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -35,6 +35,8 @@
 #define IST3038B_REG_CHIPID		0x30
 #define IST3038B_WHOAMI			0x30380b
 
+#define IST3032C_WHOAMI			0x32c
+
 struct imagis_properties {
 	unsigned int interrupt_msg_cmd;
 	unsigned int touch_coord_cmd;
@@ -363,6 +365,13 @@ static int imagis_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
 
+static const struct imagis_properties imagis_3032c_data = {
+	.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
+	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
+	.whoami_cmd = IST3038C_REG_CHIPID,
+	.whoami_val = IST3032C_WHOAMI,
+};
+
 static const struct imagis_properties imagis_3038b_data = {
 	.interrupt_msg_cmd = IST3038B_REG_STATUS,
 	.touch_coord_cmd = IST3038B_REG_STATUS,
@@ -380,6 +389,7 @@ static const struct imagis_properties imagis_3038c_data = {
 
 #ifdef CONFIG_OF
 static const struct of_device_id imagis_of_match[] = {
+	{ .compatible = "imagis,ist3032c", .data = &imagis_3032c_data },
 	{ .compatible = "imagis,ist3038b", .data = &imagis_3038b_data },
 	{ .compatible = "imagis,ist3038c", .data = &imagis_3038c_data },
 	{ },
-- 
2.43.0

