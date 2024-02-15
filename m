Return-Path: <linux-kernel+bounces-67696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FE6856F55
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61351F23C59
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D35145B03;
	Thu, 15 Feb 2024 21:29:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6723A13DB87
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032553; cv=none; b=TsostEogm+Sjpeg5wSRXhv4bWcnhrnkrLRX+1ob7NzjcNVKq9iqJhshdBXjevuJ94ISQS+e1j7UW7KH3vZ258lw9+bJJQqKt1v0rZ0TDQ/7QaVcy1nIoHTXvHn/OE8JHiDtmgvJrEginjGrseOLq2Icgg5TSivjzVEm9pVzih/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032553; c=relaxed/simple;
	bh=vck8aRHuxSoYaBFUbbPNie10ullAPmiqdjueyrw4+/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWopR9lJNm0RttN7xCGrP6wqQeslnlMzVgxkObuAR84DPRcM/BfUXQJzwwkG6ZAeLPqr1H2OHu0qD4aHdJZTRIf2kXngP7LNTJNcdhvT2J5ybn0nOlonZMJhyTjI9xRGgzkDyGJrJ5HrElj0lkQbvZGCKbcYRY89K22vM/xPwNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rajHr-0001xh-IV; Thu, 15 Feb 2024 22:28:55 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	heikki.krogerus@linux.intel.com,
	jun.li@nxp.com
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v2 3/4] usb: typec: tcpm: add support to set tcpc connector orientatition
Date: Thu, 15 Feb 2024 22:28:51 +0100
Message-Id: <20240215212852.1202339-4-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215212852.1202339-1-m.felsch@pengutronix.de>
References: <20240215212852.1202339-1-m.felsch@pengutronix.de>
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

This adds the support to set the connector orientation value
accordingly. This is part of the optional CONFIG_STANDARD_OUTPUT
register 0x18, specified within the USB port controller spsicification
rev. 2.0 [1].

[1] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v2:
- no changes

 drivers/usb/typec/tcpm/tcpm.c | 6 ++++++
 include/linux/usb/tcpm.h      | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5945e3a2b0f7..85ca26687324 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1099,6 +1099,12 @@ static int tcpm_set_roles(struct tcpm_port *port, bool attached,
 	if (ret < 0)
 		return ret;
 
+	if (port->tcpc->set_orientation) {
+		ret = port->tcpc->set_orientation(port->tcpc, orientation);
+		if (ret < 0)
+			return ret;
+	}
+
 	port->pwr_role = role;
 	port->data_role = data;
 	typec_set_data_role(port->typec_port, data);
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 65fac5e1f317..93b681ff3ef9 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -133,6 +133,8 @@ struct tcpc_dev {
 		      enum typec_cc_status *cc2);
 	int (*set_polarity)(struct tcpc_dev *dev,
 			    enum typec_cc_polarity polarity);
+	int (*set_orientation)(struct tcpc_dev *dev,
+			       enum typec_orientation orientation);
 	int (*set_vconn)(struct tcpc_dev *dev, bool on);
 	int (*set_vbus)(struct tcpc_dev *dev, bool on, bool charge);
 	int (*set_current_limit)(struct tcpc_dev *dev, u32 max_ma, u32 mv);
-- 
2.39.2


