Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6517574CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGRHAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjGRHAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:00:12 -0400
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EFA1AC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:00:10 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202307180700083fa545f811991f7306
        for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 09:00:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qH2oRz+nW/o4Ld7F/+gE5d0dZsWI4RDGrNJjVlHaIHg=;
 b=UXOXHNlytmiNA2QaCGtPP1rIeg082CmubIzPQFADoTKDUljF+ohFGT9d7lIr+egRzZ0lye
 OAbJPzIXNzmPBECSPeecY/VckqLqqLA1wOSGn9dqtzqmhylIyJnVM+/Z/Gw2xZT1ledyU1p7
 MGuvjIl0SZdhQRrcEoVpVmK/JM/Bk=;
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
Subject: [PATCH v3 1/3] net: dsa: mv88e632x: Refactor serdes read
Date:   Tue, 18 Jul 2023 08:59:29 +0200
Message-ID: <20230718065937.10713-2-michael.haener@siemens.com>
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

To avoid code duplication, the serdes read functions
have been combined.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
Changelog:
v3: rebased onto main branch
v2: rebased onto Russell Kings series dsa/88e6xxx/phylink

 drivers/net/dsa/mv88e6xxx/chip.c   | 13 +++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h   |  3 +++
 drivers/net/dsa/mv88e6xxx/serdes.c | 31 +++++++++++++++++-------------
 drivers/net/dsa/mv88e6xxx/serdes.h | 13 +++++++++++++
 4 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 6174855188d9..81fa66568e25 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4195,6 +4195,7 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.phylink_get_caps = mv88e6341_phylink_get_caps,
 	.pcs_ops = &mv88e6390_pcs_ops,
 };
@@ -4377,6 +4378,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.serdes_read = mv88e6352_serdes_read,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
 	.gpio_ops = &mv88e6352_gpio_ops,
@@ -4477,6 +4479,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.serdes_read = mv88e6352_serdes_read,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -4577,6 +4580,7 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.phylink_get_caps = mv88e6390_phylink_get_caps,
 	.pcs_ops = &mv88e6390_pcs_ops,
@@ -4635,6 +4639,7 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.phylink_get_caps = mv88e6390x_phylink_get_caps,
 	.pcs_ops = &mv88e6390_pcs_ops,
@@ -4691,6 +4696,7 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.avb_ops = &mv88e6390_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6390_phylink_get_caps,
@@ -4744,6 +4750,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.serdes_read = mv88e6352_serdes_read,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -4850,6 +4857,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6390_avb_ops,
 	.ptp_ops = &mv88e6390_ptp_ops,
@@ -5009,6 +5017,7 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.phylink_get_caps = mv88e6341_phylink_get_caps,
 	.pcs_ops = &mv88e6390_pcs_ops,
 };
@@ -5154,6 +5163,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.serdes_read = mv88e6352_serdes_read,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
@@ -5226,6 +5236,7 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.phylink_get_caps = mv88e6390_phylink_get_caps,
 	.pcs_ops = &mv88e6390_pcs_ops,
 };
@@ -5285,6 +5296,7 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6390_avb_ops,
 	.ptp_ops = &mv88e6390_ptp_ops,
@@ -5345,6 +5357,7 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.stu_loadpurge = mv88e6390_g1_stu_loadpurge,
 	.serdes_get_lane = mv88e6393x_serdes_get_lane,
 	.serdes_irq_mapping = mv88e6390_serdes_irq_mapping,
+	.serdes_read = mv88e6390_serdes_read,
 	/* TODO: serdes stats */
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6390_avb_ops,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 44383a03ef2f..bbf1e7f6f343 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -593,6 +593,9 @@ struct mv88e6xxx_ops {
 	/* SERDES lane mapping */
 	int (*serdes_get_lane)(struct mv88e6xxx_chip *chip, int port);
 
+	int (*serdes_read)(struct mv88e6xxx_chip *chip, int lane, int device,
+			   int reg, u16 *val);
+
 	/* SERDES interrupt handling */
 	unsigned int (*serdes_irq_mapping)(struct mv88e6xxx_chip *chip,
 					   int port);
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 3b4b42651fa3..5696b94c9155 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -17,8 +17,8 @@
 #include "port.h"
 #include "serdes.h"
 
-static int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int reg,
-				 u16 *val)
+int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane,
+			  int device, int reg, u16 *val)
 {
 	return mv88e6xxx_phy_page_read(chip, MV88E6352_ADDR_SERDES,
 				       MV88E6352_SERDES_PAGE_FIBER,
@@ -33,8 +33,8 @@ static int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int reg,
 					reg, val);
 }
 
-static int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip,
-				 int lane, int device, int reg, u16 *val)
+int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip,
+			  int lane, int device, int reg, u16 *val)
 {
 	return mv88e6xxx_phy_read_c45(chip, lane, device, reg, val);
 }
@@ -109,7 +109,6 @@ int mv88e6xxx_pcs_decode_state(struct device *dev, u16 bmsr, u16 lpa,
 
 	return 0;
 }
-
 struct mv88e6352_serdes_hw_stat {
 	char string[ETH_GSTRING_LEN];
 	int sizeof_stat;
@@ -150,14 +149,16 @@ int mv88e6352_serdes_get_strings(struct mv88e6xxx_chip *chip,
 	return ARRAY_SIZE(mv88e6352_serdes_hw_stats);
 }
 
-static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip,
+static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip, int port,
 					  struct mv88e6352_serdes_hw_stat *stat)
 {
 	u64 val = 0;
 	u16 reg;
 	int err;
+	int lane;
 
-	err = mv88e6352_serdes_read(chip, stat->reg, &reg);
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
+	err = mv88e6xxx_serdes_read(chip, lane, 0, stat->reg, &reg);
 	if (err) {
 		dev_err(chip->dev, "failed to read statistic\n");
 		return 0;
@@ -166,7 +167,7 @@ static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip,
 	val = reg;
 
 	if (stat->sizeof_stat == 32) {
-		err = mv88e6352_serdes_read(chip, stat->reg + 1, &reg);
+		err = mv88e6xxx_serdes_read(chip, lane, 0, stat->reg + 1, &reg);
 		if (err) {
 			dev_err(chip->dev, "failed to read statistic\n");
 			return 0;
@@ -194,7 +195,7 @@ int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
 
 	for (i = 0; i < ARRAY_SIZE(mv88e6352_serdes_hw_stats); i++) {
 		stat = &mv88e6352_serdes_hw_stats[i];
-		value = mv88e6352_serdes_get_stat(chip, stat);
+		value = mv88e6352_serdes_get_stat(chip, port, stat);
 		mv88e6xxx_port->serdes_stats[i] += value;
 		data[i] = mv88e6xxx_port->serdes_stats[i];
 	}
@@ -226,13 +227,15 @@ void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p)
 	u16 reg;
 	int err;
 	int i;
+	int lane;
 
 	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
 	if (err <= 0)
 		return;
 
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
 	for (i = 0 ; i < 32; i++) {
-		err = mv88e6352_serdes_read(chip, i, &reg);
+		err = mv88e6xxx_serdes_read(chip, lane, 0, i, &reg);
 		if (!err)
 			p[i] = reg;
 	}
@@ -418,7 +421,7 @@ static uint64_t mv88e6390_serdes_get_stat(struct mv88e6xxx_chip *chip, int lane,
 	int err, i;
 
 	for (i = 0; i < 3; i++) {
-		err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+		err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 					    stat->reg + i, &reg[i]);
 		if (err) {
 			dev_err(chip->dev, "failed to read statistic\n");
@@ -502,7 +505,7 @@ void mv88e6390_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p)
 		return;
 
 	for (i = 0 ; i < ARRAY_SIZE(mv88e6390_serdes_regs); i++) {
-		err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+		err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 					    mv88e6390_serdes_regs[i], &reg);
 		if (!err)
 			p[i] = reg;
@@ -521,6 +524,7 @@ int mv88e6352_serdes_set_tx_amplitude(struct mv88e6xxx_chip *chip, int port,
 	u16 ctrl, reg;
 	int err;
 	int i;
+	int lane;
 
 	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
 	if (err <= 0)
@@ -537,7 +541,8 @@ int mv88e6352_serdes_set_tx_amplitude(struct mv88e6xxx_chip *chip, int port,
 	if (!found)
 		return -EINVAL;
 
-	err = mv88e6352_serdes_read(chip, MV88E6352_SERDES_SPEC_CTRL2, &ctrl);
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
+	err = mv88e6xxx_serdes_read(chip, lane, 0, MV88E6352_SERDES_SPEC_CTRL2, &ctrl);
 	if (err)
 		return err;
 
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index aac95cab46e3..9b3a5ece33e7 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -120,6 +120,10 @@ int mv88e6341_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390x_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6393x_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
+int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
+			  int reg, u16 *val);
+int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
+			  int reg, u16 *val);
 unsigned int mv88e6352_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
 					  int port);
 unsigned int mv88e6390_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
@@ -153,6 +157,15 @@ static inline int mv88e6xxx_serdes_get_lane(struct mv88e6xxx_chip *chip,
 	return chip->info->ops->serdes_get_lane(chip, port);
 }
 
+static inline int mv88e6xxx_serdes_read(struct mv88e6xxx_chip *chip, int lane,
+					int device, int reg, u16 *val)
+{
+	if (!chip->info->ops->serdes_read)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->serdes_read(chip, lane, device, reg, val);
+}
+
 static inline unsigned int
 mv88e6xxx_serdes_irq_mapping(struct mv88e6xxx_chip *chip, int port)
 {
-- 
2.41.0

