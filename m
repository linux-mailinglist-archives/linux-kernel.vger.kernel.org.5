Return-Path: <linux-kernel+bounces-61173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D96B850E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3260280195
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF48210E4;
	Mon, 12 Feb 2024 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mJYxtgBx"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF44EAEA;
	Mon, 12 Feb 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724637; cv=none; b=kK9DBVgMoIjcvlQcjX6fK6suTrR8IdgVy3RmfdMapdBu8Ej+MZrfBFowB6HPwiMq+2jfA73bw+f7i0kbhZsbQvzSkNi0mQU5Kjc4UbmtvaEV+Ln6U/Jq9exVhLxtjypo28nJLqaZpfPN2kBzg9ivsJz59ycZkWk/X21wuM2r6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724637; c=relaxed/simple;
	bh=JFtFcS1VHW8uz9WV52OuBJeyIDw8KBqSgMRDBSqSSCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lguerWSX8jYSNXW4z97avqjQgmDJLa5I2j1HJt4yVlVpMFP7nb4L1KrvsjmFrk90WkNoxe+zb2Ii5LOxlgjjF8b/HHQ1kFkzzEkmu0I0Gb3UTFgKArEIl4tSv33Y+ylpHXjd8FzGO5fAeE/qChXZjMDSdolrAkJjkIMfnNZqIn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mJYxtgBx; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 4D38740017;
	Mon, 12 Feb 2024 07:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707724632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mnr/8SaId4TQmwlcsvncrRDg9MKoU24/PP9bl0L71cE=;
	b=mJYxtgBxYSvd2ntfFhlCHjjL7bJgSHce4Rgot5RMXvdYQytt62mz8nFDdjGPcKyS+TTM2r
	sS+ClJfEldALRsKIrDAjDeQdBUhz+piPC71RZix3Ts+jmzV9eIK9FkkGcoILpNytJm/V/7
	9aJKeGD7kYsX4R+5qiH/vBM+O74FsVQk4FHmyBPCFG9IiChUbKNR01/SbW3AudoAPDUDPS
	io4ps/cNw0xQTVXmo8+az5QdvMoUJLFbgSY7g53GXTAI8gSBWWjvN8XhIY7Hc25sCafJX8
	+SLEWrcg/w4N5v874W1T0wlH0hckIL4Sz0EqK11hAZGDRpMsBzJY+06yCYOXUA==
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
Subject: [RESEND PATCH v3 5/6] net: wan: fsl_qmc_hdlc: Add runtime timeslots changes support
Date: Mon, 12 Feb 2024 08:56:40 +0100
Message-ID: <20240212075646.19114-13-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212075646.19114-1-herve.codina@bootlin.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

QMC channels support runtime timeslots changes but nothing is done at
the QMC HDLC driver to handle these changes.

Use existing IFACE ioctl in order to configure the timeslots to use.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/wan/fsl_qmc_hdlc.c | 152 ++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdlc.c
index 835500910d1b..b25d918d5e4e 100644
--- a/drivers/net/wan/fsl_qmc_hdlc.c
+++ b/drivers/net/wan/fsl_qmc_hdlc.c
@@ -7,6 +7,7 @@
  * Author: Herve Codina <herve.codina@bootlin.com>
  */
 
+#include <linux/bitmap.h>
 #include <linux/dma-mapping.h>
 #include <linux/hdlc.h>
 #include <linux/module.h>
@@ -32,6 +33,7 @@ struct qmc_hdlc {
 	struct qmc_hdlc_desc tx_descs[8];
 	unsigned int tx_out;
 	struct qmc_hdlc_desc rx_descs[4];
+	u32 slot_map;
 };
 
 static struct qmc_hdlc *netdev_to_qmc_hdlc(struct net_device *netdev)
@@ -206,6 +208,144 @@ static netdev_tx_t qmc_hdlc_xmit(struct sk_buff *skb, struct net_device *netdev)
 	return ret;
 }
 
+static int qmc_hdlc_xlate_slot_map(struct qmc_hdlc *qmc_hdlc,
+				   u32 slot_map, struct qmc_chan_ts_info *ts_info)
+{
+	DECLARE_BITMAP(ts_mask_avail, 64);
+	DECLARE_BITMAP(ts_mask, 64);
+	DECLARE_BITMAP(map, 64);
+
+	/* Tx and Rx available masks must be identical */
+	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
+		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
+			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
+		return -EINVAL;
+	}
+
+	bitmap_from_u64(ts_mask_avail, ts_info->rx_ts_mask_avail);
+	bitmap_from_u64(map, slot_map);
+	bitmap_onto(ts_mask, map, ts_mask_avail, 64);
+
+	if (bitmap_weight(ts_mask, 64) != bitmap_weight(map, 64)) {
+		dev_err(qmc_hdlc->dev, "Cannot translate timeslots %*pb -> (%*pb, %*pb)\n",
+			64, map, 64, ts_mask_avail, 64, ts_mask);
+		return -EINVAL;
+	}
+
+	bitmap_to_arr64(&ts_info->tx_ts_mask, ts_mask, 64);
+	ts_info->rx_ts_mask = ts_info->tx_ts_mask;
+	return 0;
+}
+
+static int qmc_hdlc_xlate_ts_info(struct qmc_hdlc *qmc_hdlc,
+				  const struct qmc_chan_ts_info *ts_info, u32 *slot_map)
+{
+	DECLARE_BITMAP(ts_mask_avail, 64);
+	DECLARE_BITMAP(ts_mask, 64);
+	DECLARE_BITMAP(map, 64);
+	u32 array32[2];
+
+	/* Tx and Rx masks and available masks must be identical */
+	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
+		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
+			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
+		return -EINVAL;
+	}
+	if (ts_info->rx_ts_mask != ts_info->tx_ts_mask) {
+		dev_err(qmc_hdlc->dev, "tx and rx timeslots mismatch (0x%llx, 0x%llx)\n",
+			ts_info->rx_ts_mask, ts_info->tx_ts_mask);
+		return -EINVAL;
+	}
+
+	bitmap_from_u64(ts_mask_avail, ts_info->rx_ts_mask_avail);
+	bitmap_from_u64(ts_mask, ts_info->rx_ts_mask);
+	bitmap_off(map, ts_mask, ts_mask_avail, 64);
+
+	if (bitmap_weight(ts_mask, 64) != bitmap_weight(map, 64)) {
+		dev_err(qmc_hdlc->dev, "Cannot translate timeslots (%*pb, %*pb) -> %*pb\n",
+			64, ts_mask_avail, 64, ts_mask, 64, map);
+		return -EINVAL;
+	}
+
+	bitmap_to_arr32(array32, map, 64);
+	if (array32[1]) {
+		dev_err(qmc_hdlc->dev, "Slot map out of 32bit (%*pb, %*pb) -> %*pb\n",
+			64, ts_mask_avail, 64, ts_mask, 64, map);
+		return -EINVAL;
+	}
+
+	*slot_map = array32[0];
+	return 0;
+}
+
+static int qmc_hdlc_set_iface(struct qmc_hdlc *qmc_hdlc, int if_iface, const te1_settings *te1)
+{
+	struct qmc_chan_ts_info ts_info;
+	int ret;
+
+	ret = qmc_chan_get_ts_info(qmc_hdlc->qmc_chan, &ts_info);
+	if (ret) {
+		dev_err(qmc_hdlc->dev, "get QMC channel ts info failed %d\n", ret);
+		return ret;
+	}
+	ret = qmc_hdlc_xlate_slot_map(qmc_hdlc, te1->slot_map, &ts_info);
+	if (ret)
+		return ret;
+
+	ret = qmc_chan_set_ts_info(qmc_hdlc->qmc_chan, &ts_info);
+	if (ret) {
+		dev_err(qmc_hdlc->dev, "set QMC channel ts info failed %d\n", ret);
+		return ret;
+	}
+
+	qmc_hdlc->slot_map = te1->slot_map;
+
+	return 0;
+}
+
+static int qmc_hdlc_ioctl(struct net_device *netdev, struct if_settings *ifs)
+{
+	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
+	te1_settings te1;
+
+	switch (ifs->type) {
+	case IF_GET_IFACE:
+		ifs->type = IF_IFACE_E1;
+		if (ifs->size < sizeof(te1)) {
+			if (!ifs->size)
+				return 0; /* only type requested */
+
+			ifs->size = sizeof(te1); /* data size wanted */
+			return -ENOBUFS;
+		}
+
+		memset(&te1, 0, sizeof(te1));
+
+		/* Update slot_map */
+		te1.slot_map = qmc_hdlc->slot_map;
+
+		if (copy_to_user(ifs->ifs_ifsu.te1, &te1, sizeof(te1)))
+			return -EFAULT;
+		return 0;
+
+	case IF_IFACE_E1:
+	case IF_IFACE_T1:
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+
+		if (netdev->flags & IFF_UP)
+			return -EBUSY;
+
+		if (copy_from_user(&te1, ifs->ifs_ifsu.te1, sizeof(te1)))
+			return -EFAULT;
+
+		return qmc_hdlc_set_iface(qmc_hdlc, ifs->type, &te1);
+
+	default:
+		return hdlc_ioctl(netdev, ifs);
+	}
+}
+
 static int qmc_hdlc_open(struct net_device *netdev)
 {
 	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
@@ -332,13 +472,14 @@ static const struct net_device_ops qmc_hdlc_netdev_ops = {
 	.ndo_open       = qmc_hdlc_open,
 	.ndo_stop       = qmc_hdlc_close,
 	.ndo_start_xmit = hdlc_start_xmit,
-	.ndo_siocwandev	= hdlc_ioctl,
+	.ndo_siocwandev = qmc_hdlc_ioctl,
 };
 
 static int qmc_hdlc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct qmc_hdlc *qmc_hdlc;
+	struct qmc_chan_ts_info ts_info;
 	struct qmc_chan_info info;
 	hdlc_device *hdlc;
 	int ret;
@@ -368,6 +509,15 @@ static int qmc_hdlc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ret = qmc_chan_get_ts_info(qmc_hdlc->qmc_chan, &ts_info);
+	if (ret) {
+		dev_err(qmc_hdlc->dev, "get QMC channel ts info failed %d\n", ret);
+		return ret;
+	}
+	ret = qmc_hdlc_xlate_ts_info(qmc_hdlc, &ts_info, &qmc_hdlc->slot_map);
+	if (ret)
+		return ret;
+
 	qmc_hdlc->netdev = alloc_hdlcdev(qmc_hdlc);
 	if (!qmc_hdlc->netdev) {
 		dev_err(qmc_hdlc->dev, "failed to alloc hdlc dev\n");
-- 
2.43.0


