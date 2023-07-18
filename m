Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D84F7574CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjGRHAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjGRHAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:00:14 -0400
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1BC1B3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:00:13 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230718070011902d68a3f5230ab2e4
        for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 09:00:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PD8Cxd3iso0BrKXzIfhGSHXoX5NHvZZ/NAIdVFvY1is=;
 b=NyFcNb5AdnTHf4Xa5Ttpy3Oiqe9zg5XKrAIUes29aSwCaeKUQESmjkTztDsir2MolSEfL4
 H6vrq09M3qNDIbZ70j5WCukaifIUN/keDVQTDrZMkyTyMITZoiE4Hvd5aMm5u2o+5GqqEjON
 4CRIF6ZXBtX2P+nOWGJ7r+KfiknIc=;
From:   "M. Haener" <michael.haener@siemens.com>
To:     netdev@vger.kernel.org
Cc:     Michael Haener <michael.haener@siemens.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v3 2/3] net: dsa: mv88e632x: Refactor serdes write
Date:   Tue, 18 Jul 2023 08:59:30 +0200
Message-ID: <20230718065937.10713-3-michael.haener@siemens.com>
In-Reply-To: <20230718065937.10713-1-michael.haener@siemens.com>
References: <20230718065937.10713-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Haener <michael.haener@siemens.com>

To avoid code duplication, the serdes write functions
have been combined.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
Changelog:
v3: rebased onto main branch
v2: rebased onto Russell Kings series dsa/88e6xxx/phylink

 drivers/net/dsa/mv88e6xxx/chip.c   |  4 ++++
 drivers/net/dsa/mv88e6xxx/chip.h   |  2 ++
 drivers/net/dsa/mv88e6xxx/serdes.c |  6 +++---
 drivers/net/dsa/mv88e6xxx/serdes.h | 11 +++++++++++
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 81fa66568e25..7e8aaa1383c6 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4379,6 +4379,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
 	.gpio_ops = &mv88e6352_gpio_ops,
@@ -4480,6 +4481,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -4751,6 +4753,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -5164,6 +5167,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index bbf1e7f6f343..7e9b6eb11216 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -595,6 +595,8 @@ struct mv88e6xxx_ops {
 
 	int (*serdes_read)(struct mv88e6xxx_chip *chip, int lane, int device,
 			   int reg, u16 *val);
+	int (*serdes_write)(struct mv88e6xxx_chip *chip, int lane, int reg,
+			    u16 val);
 
 	/* SERDES interrupt handling */
 	unsigned int (*serdes_irq_mapping)(struct mv88e6xxx_chip *chip,
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 5696b94c9155..b988d47ecbdd 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -25,8 +25,8 @@ int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane,
 				       reg, val);
 }
 
-static int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int reg,
-				  u16 val)
+int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int lane, int reg,
+			   u16 val)
 {
 	return mv88e6xxx_phy_page_write(chip, MV88E6352_ADDR_SERDES,
 					MV88E6352_SERDES_PAGE_FIBER,
@@ -549,5 +549,5 @@ int mv88e6352_serdes_set_tx_amplitude(struct mv88e6xxx_chip *chip, int port,
 	ctrl &= ~MV88E6352_SERDES_OUT_AMP_MASK;
 	ctrl |= reg;
 
-	return mv88e6352_serdes_write(chip, MV88E6352_SERDES_SPEC_CTRL2, ctrl);
+	return mv88e6xxx_serdes_write(chip, lane, MV88E6352_SERDES_SPEC_CTRL2, ctrl);
 }
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index 9b3a5ece33e7..d3e83c674ef7 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -124,6 +124,8 @@ int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
 			  int reg, u16 *val);
 int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
 			  int reg, u16 *val);
+int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int lane, int reg,
+			   u16 val);
 unsigned int mv88e6352_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
 					  int port);
 unsigned int mv88e6390_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
@@ -166,6 +168,15 @@ static inline int mv88e6xxx_serdes_read(struct mv88e6xxx_chip *chip, int lane,
 	return chip->info->ops->serdes_read(chip, lane, device, reg, val);
 }
 
+static inline int mv88e6xxx_serdes_write(struct mv88e6xxx_chip *chip, int lane,
+					 int reg, u16 val)
+{
+	if (!chip->info->ops->serdes_write)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->serdes_write(chip, lane, reg, val);
+}
+
 static inline unsigned int
 mv88e6xxx_serdes_irq_mapping(struct mv88e6xxx_chip *chip, int port)
 {
-- 
2.41.0

