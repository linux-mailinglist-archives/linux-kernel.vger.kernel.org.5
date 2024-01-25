Return-Path: <linux-kernel+bounces-39025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D383C9CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08231F2A40B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011B14F611;
	Thu, 25 Jan 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TLymDIki"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA067131E2C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203125; cv=none; b=Jaq8L7EGw1c8ofhikrDzoIOo7k8IIk6V1wDWXA800AzPZjSrQUKAmXVbOJQdVSDR1BLQ3HMjSl45RvzhHNr7gVf6toBEUapKvtDVK2JuKfRFo8ssaNZmiawdATDcUGrQP4ApDFxAZOtPqqKt2eNmmqq9MHcuVFtMr2YpBuaoUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203125; c=relaxed/simple;
	bh=sF05Yy+d5ZaxIGAlWjRsAJJDf8Q9jJLY3pcKpcNli+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G0Sljsw/SvK+CRyeDXGl2rVKjcFFBAAn6sv0ctwF0M5h/0cgSwwPpwWjUWkL6k0jjbNtMSUmHiqCqoCbwnu66ZNsBcctD25gmYrD8xL5teNK7HVqqoaRVXyMkBSw+VbyPVK1vMpMhK+V8O/NiBkslQNgkDMUkGKf7wfdwBfKmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TLymDIki; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9362920003;
	Thu, 25 Jan 2024 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706203115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M3w/v9oEuYlkPL4C5kh7T1VxbhDjpPY1oFMPL7Ii+tg=;
	b=TLymDIkiKJiBhJzkLiN12QBT7u1FHgvghk103/R4JrrlkXq220kOYkho7k6V6QnW8UYRcI
	GRzm3FPVbO1h46mQwSqJT+qWV6TOc9X8LmaklPnnsrU5GI6OYzGQMfyIJrPMiRfO+nbsFf
	8piTxBJGnoVzusL13EhQofWSNV5HcJOOhIXSU7ZCmKR3mSaMUf89nLvDa/oLQvsgIOh0PD
	56sx5qChrNmwIou6OVgKOaHWjE10xZQE08koPG/Xu+f4GdV1HM5IQzslN3x7LbHyiUIGEk
	aJdLsDyXTdyQnqMpxttPwztAwaQTdmLrxdHnP0obqUoS+x3U4VuXGr/o2aU9zQ==
From: Thomas Richard <thomas.richard@bootlin.com>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregory.clement@bootlin.com,
	thomas.petazzoni@bootlin.com,
	theo.lebrun@bootlin.com,
	u-kumar1@ti.com,
	Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH] phy: ti: gmii-sel: add resume support
Date: Thu, 25 Jan 2024 18:17:54 +0100
Message-Id: <20240125171754.773909-1-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

The resume callback restores the submode of each PHY.

It uses the submode stored in struct phy_gmii_sel_phy_priv (variable
phy_if_mode). The submode was saved by the set_mode PHY operation.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 555b323f45da..c62790937313 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -491,11 +491,35 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int phy_gmii_sel_resume_noirq(struct device *dev)
+{
+	struct phy_gmii_sel_priv *priv = dev_get_drvdata(dev);
+	struct phy_gmii_sel_phy_priv *if_phys = priv->if_phys;
+	int ret, i;
+
+	for (i = 0; i < priv->num_ports; i++) {
+		if (if_phys[i].phy_if_mode) {
+			ret = phy_gmii_sel_mode(if_phys[i].if_phy,
+						PHY_MODE_ETHERNET, if_phys[i].phy_if_mode);
+			if (ret) {
+				dev_err(dev, "port%u: restore mode fail %d\n",
+					if_phys[i].if_phy->id, ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static DEFINE_NOIRQ_DEV_PM_OPS(phy_gmii_sel_pm_ops, NULL, phy_gmii_sel_resume_noirq);
+
 static struct platform_driver phy_gmii_sel_driver = {
 	.probe		= phy_gmii_sel_probe,
 	.driver		= {
 		.name	= "phy-gmii-sel",
 		.of_match_table = phy_gmii_sel_id_table,
+		.pm = pm_sleep_ptr(&phy_gmii_sel_pm_ops),
 	},
 };
 module_platform_driver(phy_gmii_sel_driver);
-- 
2.39.2


