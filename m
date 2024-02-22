Return-Path: <linux-kernel+bounces-77363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D4860468
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8981F24FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A0412D20F;
	Thu, 22 Feb 2024 21:09:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E429073F3D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636171; cv=none; b=BayNmovntvROCIFQ+fq57izo4jP5WZ9fyhrh7yFQhtNUdRtxgeWcqdcGfpP++Q/rNfFP3rHMv8+IXhtxwfWNNcpK6rAbHqPukfMOQaC8j2gud52L5D0uE2dtx1Wi07Finfz152Z3AHwwrVgJwm8+lTpXG8H8Vzjxdr4BEQGmDz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636171; c=relaxed/simple;
	bh=jJBEyKL9gND32kj54k1i3vG+7Q/PclKg2QPivadtkVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/K1/9P8WFLs1SrgLxq5b3rG51hMYGCRznaqOtZ59MitgVK9gB4OVYvCQbgyqHoV59QycCGMhifAUOQKc+94H8U/sraWCcuWSq8asK/xJDQmJSJ1kNT+aofiHRRpQeT/VjC2GNcpE10ZtETTN0CdqBVfGi8/7tq72+UIAskalAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rdGJZ-0000lo-Be; Thu, 22 Feb 2024 22:09:09 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	heikki.krogerus@linux.intel.com,
	jun.li@nxp.com
Cc: devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 4/4] usb: typec: tcpci: add support to set connector orientation
Date: Thu, 22 Feb 2024 22:09:03 +0100
Message-Id: <20240222210903.208901-5-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222210903.208901-1-m.felsch@pengutronix.de>
References: <20240222210903.208901-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This add the support to set the optional connector orientation bit which
is part of the optional CONFIG_STANDARD_OUTPUT register 0x18 [1]. This
allows system designers to connect the tcpc orientation pin directly to
the 2:1 ss-mux.

[1] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v3:
- no changes
v2:
- Make use of fallthrough 

 drivers/usb/typec/tcpm/tcpci.c | 44 ++++++++++++++++++++++++++++++++++
 include/linux/usb/tcpci.h      |  8 +++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 7118551827f6..73a52e7f95c2 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -67,6 +67,18 @@ static int tcpci_write16(struct tcpci *tcpci, unsigned int reg, u16 val)
 	return regmap_raw_write(tcpci->regmap, reg, &val, sizeof(u16));
 }
 
+static bool tcpci_check_std_output_cap(struct regmap *regmap, u8 mask)
+{
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(regmap, TCPC_STD_OUTPUT_CAP, &reg);
+	if (ret < 0)
+		return ret;
+
+	return (reg & mask) == mask;
+}
+
 static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -301,6 +313,28 @@ static int tcpci_set_polarity(struct tcpc_dev *tcpc,
 			   TCPC_TCPC_CTRL_ORIENTATION : 0);
 }
 
+static int tcpci_set_orientation(struct tcpc_dev *tcpc,
+				 enum typec_orientation orientation)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+	unsigned int reg;
+
+	switch (orientation) {
+	case TYPEC_ORIENTATION_NONE:
+		/* We can't put a single output into high impedance */
+		fallthrough;
+	case TYPEC_ORIENTATION_NORMAL:
+		reg = TCPC_CONFIG_STD_OUTPUT_ORIENTATION_NORMAL;
+		break;
+	case TYPEC_ORIENTATION_REVERSE:
+		reg = TCPC_CONFIG_STD_OUTPUT_ORIENTATION_FLIPPED;
+		break;
+	}
+
+	return regmap_update_bits(tcpci->regmap, TCPC_CONFIG_STD_OUTPUT,
+				  TCPC_CONFIG_STD_OUTPUT_ORIENTATION_MASK, reg);
+}
+
 static void tcpci_set_partner_usb_comm_capable(struct tcpc_dev *tcpc, bool capable)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -808,6 +842,9 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	if (tcpci->data->vbus_vsafe0v)
 		tcpci->tcpc.is_vbus_vsafe0v = tcpci_is_vbus_vsafe0v;
 
+	if (tcpci->data->set_orientation)
+		tcpci->tcpc.set_orientation = tcpci_set_orientation;
+
 	err = tcpci_parse_config(tcpci);
 	if (err < 0)
 		return ERR_PTR(err);
@@ -851,6 +888,13 @@ static int tcpci_probe(struct i2c_client *client)
 	if (err < 0)
 		return err;
 
+	err = tcpci_check_std_output_cap(chip->data.regmap,
+					 TCPC_STD_OUTPUT_CAP_ORIENTATION);
+	if (err < 0)
+		return err;
+
+	chip->data.set_orientation = err;
+
 	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
 	if (IS_ERR(chip->tcpci))
 		return PTR_ERR(chip->tcpci);
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index 467e8045e9f8..f2bfb4250366 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -47,6 +47,9 @@
 #define TCPC_SINK_FAST_ROLE_SWAP	BIT(0)
 
 #define TCPC_CONFIG_STD_OUTPUT		0x18
+#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_MASK		BIT(0)
+#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_NORMAL	0
+#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_FLIPPED	1
 
 #define TCPC_TCPC_CTRL			0x19
 #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
@@ -127,6 +130,7 @@
 #define TCPC_DEV_CAP_2			0x26
 #define TCPC_STD_INPUT_CAP		0x28
 #define TCPC_STD_OUTPUT_CAP		0x29
+#define TCPC_STD_OUTPUT_CAP_ORIENTATION	BIT(0)
 
 #define TCPC_MSG_HDR_INFO		0x2e
 #define TCPC_MSG_HDR_INFO_DATA_ROLE	BIT(3)
@@ -198,12 +202,16 @@ struct tcpci;
  *		Chip level drivers are expected to check for contaminant and call
  *		tcpm_clean_port when the port is clean to put the port back into
  *		toggling state.
+ * @set_orientation:
+ *		Optional; Enable setting the connector orientation
+ *		CONFIG_STANDARD_OUTPUT (0x18) bit0.
  */
 struct tcpci_data {
 	struct regmap *regmap;
 	unsigned char TX_BUF_BYTE_x_hidden:1;
 	unsigned char auto_discharge_disconnect:1;
 	unsigned char vbus_vsafe0v:1;
+	unsigned char set_orientation:1;
 
 	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
 	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
-- 
2.39.2


