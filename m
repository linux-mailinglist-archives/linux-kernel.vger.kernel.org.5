Return-Path: <linux-kernel+bounces-76696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2185FB1D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672431C23F98
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10C814E2E8;
	Thu, 22 Feb 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JQjKPhm7"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7155814AD19;
	Thu, 22 Feb 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611760; cv=none; b=ongzF0z812SqFVFCS0Au/d4S34EnolKzTF9neVwwJGyDu0GxhRqqWjCwDElJZi2Px8tCbG9VUZD4Px0mOg8GxowK3ou7xtODjrp24hvpURGezo2vIj6sdmWHVrvom+OzSIENcIzJnP4pFgBs4dT/p3Ahwg3e2p/HJfffNy5cNLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611760; c=relaxed/simple;
	bh=wKXLCmypanClItDXV0Is9v2QLevnUITrYP63Ewanc7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbwAbFEPi53l4YR/kJ907zsbHq4TwCttL/vQAKe9cmkWTo4Uc9kPpjPCWf9dgcpIiS11wObsCHnbfgho903KjHRLP4REHI3c7tNIK47hCOk6E1+tXVOfl3126FtoedF7fci240GCvbR+YxnnJ5aPCI3EF3n3qzxFuepmt2V8hoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JQjKPhm7; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 105CD1BF20A;
	Thu, 22 Feb 2024 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708611756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZV96oR0ttn77M94x5ZLQMI275eNHpAHzNZXTUCT4pQ=;
	b=JQjKPhm7wKuDpcWZ3Akdxq0jcY4JgMwqpiI0feljQIpj10vbSjANglllGzamZWWht/9Sdd
	cconNGI5NkuXTtxJZDj+jnvaUFG4pibWRVgKFrxUpx3oZ5HalrjnaFtjNhfth854QTiFQr
	zQsGHmjGgOOIZZ2Y1Uc1YWwvm5fKlS6QeTdPVaFhwCERVqzzeSKZWiFr+XqPtUQPcucIxt
	LF9UIaa58dx56pB/G338mZxcKVTdggHJquZaUJDwwgqVbFd6oLla7x/B/SkxEQ2gPdqI4u
	Uhi431ydf6dIpOrE5b/ZgHp6+IBw4hbOs6fYlDnla6c/k8mGZLguZtiAqMh9cg==
From: Herve Codina <herve.codina@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 5/5] net: wan: fsl_qmc_hdlc: Add framer support
Date: Thu, 22 Feb 2024 15:22:18 +0100
Message-ID: <20240222142219.441767-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222142219.441767-1-herve.codina@bootlin.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Add framer support in the fsl_qmc_hdlc driver in order to be able to
signal carrier changes to the network stack based on the framer status
Also use this framer to provide information related to the E1/T1 line
interface on IF_GET_IFACE and configure the line interface according to
IF_IFACE_{E1,T1} information.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/net/wan/fsl_qmc_hdlc.c | 239 ++++++++++++++++++++++++++++++++-
 1 file changed, 235 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdlc.c
index 1b7f1d5af273..5e80d3ce4e51 100644
--- a/drivers/net/wan/fsl_qmc_hdlc.c
+++ b/drivers/net/wan/fsl_qmc_hdlc.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/dma-mapping.h>
+#include <linux/framer/framer.h>
 #include <linux/hdlc.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -28,6 +29,9 @@ struct qmc_hdlc {
 	struct device *dev;
 	struct qmc_chan *qmc_chan;
 	struct net_device *netdev;
+	struct framer *framer;
+	spinlock_t carrier_lock; /* Protect carrier detection */
+	struct notifier_block nb;
 	bool is_crc32;
 	spinlock_t tx_lock; /* Protect tx descriptors */
 	struct qmc_hdlc_desc tx_descs[8];
@@ -41,6 +45,195 @@ static struct qmc_hdlc *netdev_to_qmc_hdlc(struct net_device *netdev)
 	return dev_to_hdlc(netdev)->priv;
 }
 
+static int qmc_hdlc_framer_set_carrier(struct qmc_hdlc *qmc_hdlc)
+{
+	struct framer_status framer_status;
+	unsigned long flags;
+	int ret;
+
+	if (!qmc_hdlc->framer)
+		return 0;
+
+	spin_lock_irqsave(&qmc_hdlc->carrier_lock, flags);
+
+	ret = framer_get_status(qmc_hdlc->framer, &framer_status);
+	if (ret) {
+		dev_err(qmc_hdlc->dev, "get framer status failed (%d)\n", ret);
+		goto end;
+	}
+	if (framer_status.link_is_on)
+		netif_carrier_on(qmc_hdlc->netdev);
+	else
+		netif_carrier_off(qmc_hdlc->netdev);
+
+end:
+	spin_unlock_irqrestore(&qmc_hdlc->carrier_lock, flags);
+	return ret;
+}
+
+static int qmc_hdlc_framer_notifier(struct notifier_block *nb, unsigned long action,
+				    void *data)
+{
+	struct qmc_hdlc *qmc_hdlc = container_of(nb, struct qmc_hdlc, nb);
+	int ret;
+
+	if (action != FRAMER_EVENT_STATUS)
+		return NOTIFY_DONE;
+
+	ret = qmc_hdlc_framer_set_carrier(qmc_hdlc);
+	return ret ? NOTIFY_DONE : NOTIFY_OK;
+}
+
+static int qmc_hdlc_framer_start(struct qmc_hdlc *qmc_hdlc)
+{
+	struct framer_status framer_status;
+	int ret;
+
+	if (!qmc_hdlc->framer)
+		return 0;
+
+	ret = framer_power_on(qmc_hdlc->framer);
+	if (ret) {
+		dev_err(qmc_hdlc->dev, "framer power-on failed (%d)\n", ret);
+		return ret;
+	}
+
+	/* Be sure that get_status is supported */
+	ret = framer_get_status(qmc_hdlc->framer, &framer_status);
+	if (ret) {
+		dev_err(qmc_hdlc->dev, "get framer status failed (%d)\n", ret);
+		goto framer_power_off;
+	}
+
+	qmc_hdlc->nb.notifier_call = qmc_hdlc_framer_notifier;
+	ret = framer_notifier_register(qmc_hdlc->framer, &qmc_hdlc->nb);
+	if (ret) {
+		dev_err(qmc_hdlc->dev, "framer notifier register failed (%d)\n", ret);
+		goto framer_power_off;
+	}
+
+	return 0;
+
+framer_power_off:
+	framer_power_off(qmc_hdlc->framer);
+	return ret;
+}
+
+static void qmc_hdlc_framer_stop(struct qmc_hdlc *qmc_hdlc)
+{
+	if (!qmc_hdlc->framer)
+		return;
+
+	framer_notifier_unregister(qmc_hdlc->framer, &qmc_hdlc->nb);
+	framer_power_off(qmc_hdlc->framer);
+}
+
+static int qmc_hdlc_framer_set_iface(struct qmc_hdlc *qmc_hdlc, int if_iface,
+				     const te1_settings *te1)
+{
+	struct framer_config config;
+	int ret;
+
+	if (!qmc_hdlc->framer)
+		return 0;
+
+	ret = framer_get_config(qmc_hdlc->framer, &config);
+	if (ret)
+		return ret;
+
+	switch (if_iface) {
+	case IF_IFACE_E1:
+		config.iface = FRAMER_IFACE_E1;
+		break;
+	case IF_IFACE_T1:
+		config.iface = FRAMER_IFACE_T1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (te1->clock_type) {
+	case CLOCK_DEFAULT:
+		/* Keep current value */
+		break;
+	case CLOCK_EXT:
+		config.clock_type = FRAMER_CLOCK_EXT;
+		break;
+	case CLOCK_INT:
+		config.clock_type = FRAMER_CLOCK_INT;
+		break;
+	default:
+		return -EINVAL;
+	}
+	config.line_clock_rate = te1->clock_rate;
+
+	return framer_set_config(qmc_hdlc->framer, &config);
+}
+
+static int qmc_hdlc_framer_get_iface(struct qmc_hdlc *qmc_hdlc, int *if_iface, te1_settings *te1)
+{
+	struct framer_config config;
+	int ret;
+
+	if (!qmc_hdlc->framer) {
+		*if_iface = IF_IFACE_E1;
+		return 0;
+	}
+
+	ret = framer_get_config(qmc_hdlc->framer, &config);
+	if (ret)
+		return ret;
+
+	switch (config.iface) {
+	case FRAMER_IFACE_E1:
+		*if_iface = IF_IFACE_E1;
+		break;
+	case FRAMER_IFACE_T1:
+		*if_iface = IF_IFACE_T1;
+		break;
+	}
+
+	if (!te1)
+		return 0; /* Only iface type requested */
+
+	switch (config.clock_type) {
+	case FRAMER_CLOCK_EXT:
+		te1->clock_type = CLOCK_EXT;
+		break;
+	case FRAMER_CLOCK_INT:
+		te1->clock_type = CLOCK_INT;
+		break;
+	default:
+		return -EINVAL;
+	}
+	te1->clock_rate = config.line_clock_rate;
+	return 0;
+}
+
+static int qmc_hdlc_framer_init(struct qmc_hdlc *qmc_hdlc)
+{
+	int ret;
+
+	if (!qmc_hdlc->framer)
+		return 0;
+
+	ret = framer_init(qmc_hdlc->framer);
+	if (ret) {
+		dev_err(qmc_hdlc->dev, "framer init failed (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void qmc_hdlc_framer_exit(struct qmc_hdlc *qmc_hdlc)
+{
+	if (!qmc_hdlc->framer)
+		return;
+
+	framer_exit(qmc_hdlc->framer);
+}
+
 static int qmc_hdlc_recv_queue(struct qmc_hdlc *qmc_hdlc, struct qmc_hdlc_desc *desc, size_t size);
 
 #define QMC_HDLC_RX_ERROR_FLAGS (QMC_RX_FLAG_HDLC_OVF | \
@@ -300,6 +493,12 @@ static int qmc_hdlc_set_iface(struct qmc_hdlc *qmc_hdlc, int if_iface, const te1
 
 	qmc_hdlc->slot_map = te1->slot_map;
 
+	ret = qmc_hdlc_framer_set_iface(qmc_hdlc, if_iface, te1);
+	if (ret) {
+		dev_err(qmc_hdlc->dev, "framer set iface failed %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -307,11 +506,16 @@ static int qmc_hdlc_ioctl(struct net_device *netdev, struct if_settings *ifs)
 {
 	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
 	te1_settings te1;
+	int ret;
 
 	switch (ifs->type) {
 	case IF_GET_IFACE:
-		ifs->type = IF_IFACE_E1;
 		if (ifs->size < sizeof(te1)) {
+			/* Retrieve type only */
+			ret = qmc_hdlc_framer_get_iface(qmc_hdlc, &ifs->type, NULL);
+			if (ret)
+				return ret;
+
 			if (!ifs->size)
 				return 0; /* only type requested */
 
@@ -321,6 +525,11 @@ static int qmc_hdlc_ioctl(struct net_device *netdev, struct if_settings *ifs)
 
 		memset(&te1, 0, sizeof(te1));
 
+		/* Retrieve info from framer */
+		ret = qmc_hdlc_framer_get_iface(qmc_hdlc, &ifs->type, &te1);
+		if (ret)
+			return ret;
+
 		/* Update slot_map */
 		te1.slot_map = qmc_hdlc->slot_map;
 
@@ -354,10 +563,17 @@ static int qmc_hdlc_open(struct net_device *netdev)
 	int ret;
 	int i;
 
-	ret = hdlc_open(netdev);
+	ret = qmc_hdlc_framer_start(qmc_hdlc);
 	if (ret)
 		return ret;
 
+	ret = hdlc_open(netdev);
+	if (ret)
+		goto framer_stop;
+
+	/* Update carrier */
+	qmc_hdlc_framer_set_carrier(qmc_hdlc);
+
 	chan_param.mode = QMC_HDLC;
 	/* HDLC_MAX_MRU + 4 for the CRC
 	 * HDLC_MAX_MRU + 4 + 8 for the CRC and some extraspace needed by the QMC
@@ -407,6 +623,8 @@ static int qmc_hdlc_open(struct net_device *netdev)
 	}
 hdlc_close:
 	hdlc_close(netdev);
+framer_stop:
+	qmc_hdlc_framer_stop(qmc_hdlc);
 	return ret;
 }
 
@@ -442,6 +660,7 @@ static int qmc_hdlc_close(struct net_device *netdev)
 	}
 
 	hdlc_close(netdev);
+	qmc_hdlc_framer_stop(qmc_hdlc);
 	return 0;
 }
 
@@ -490,6 +709,7 @@ static int qmc_hdlc_probe(struct platform_device *pdev)
 
 	qmc_hdlc->dev = &pdev->dev;
 	spin_lock_init(&qmc_hdlc->tx_lock);
+	spin_lock_init(&qmc_hdlc->carrier_lock);
 
 	qmc_hdlc->qmc_chan = devm_qmc_chan_get_bychild(qmc_hdlc->dev, np);
 	if (IS_ERR(qmc_hdlc->qmc_chan)) {
@@ -518,10 +738,19 @@ static int qmc_hdlc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	qmc_hdlc->framer = devm_framer_optional_get(qmc_hdlc->dev, "fsl,framer");
+	if (IS_ERR(qmc_hdlc->framer))
+		return PTR_ERR(qmc_hdlc->framer);
+
+	ret = qmc_hdlc_framer_init(qmc_hdlc);
+	if (ret)
+		return ret;
+
 	qmc_hdlc->netdev = alloc_hdlcdev(qmc_hdlc);
 	if (!qmc_hdlc->netdev) {
 		dev_err(qmc_hdlc->dev, "failed to alloc hdlc dev\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto framer_exit;
 	}
 
 	hdlc = dev_to_hdlc(qmc_hdlc->netdev);
@@ -537,11 +766,12 @@ static int qmc_hdlc_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, qmc_hdlc);
-
 	return 0;
 
 free_netdev:
 	free_netdev(qmc_hdlc->netdev);
+framer_exit:
+	qmc_hdlc_framer_exit(qmc_hdlc);
 	return ret;
 }
 
@@ -551,6 +781,7 @@ static int qmc_hdlc_remove(struct platform_device *pdev)
 
 	unregister_hdlc_device(qmc_hdlc->netdev);
 	free_netdev(qmc_hdlc->netdev);
+	qmc_hdlc_framer_exit(qmc_hdlc);
 
 	return 0;
 }
-- 
2.43.0


