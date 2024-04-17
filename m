Return-Path: <linux-kernel+bounces-148277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A459A8A802C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61592282BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC4E13A259;
	Wed, 17 Apr 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HJPwhTvt"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54062207A;
	Wed, 17 Apr 2024 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347703; cv=none; b=iXKuW9u+QsB520lTfc0aXHGQ17xP8B8HB/zGFh9nYg9BaHmSwDGo0nLbIyZslofLM9ha7Wsy3vRXifQzpCvYE3ksRg3BLkneH7oCIJ9F6DGSKteglwosQx45qiVQde3XmQ9SV2WzTkhwlphAcHj9J/BISMYHYd8nITEySStQ8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347703; c=relaxed/simple;
	bh=JlnfYvxKQVsKU+a5E01G9fuAf4OwPy0l1HUe6pgpowI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YQ2MxARLNAIzs7GOTpIy10GTCLs6aiPUEwFtlz9Ts3wJ11nKJ34BY1mPF9OH59XqkVtAWSQLqb8Yac2wNgZynr6mZ6K2Pi6AQVnkNEcgsNf+BkLj3ZZzHYxrqGGHY4UBGh26NmPno9gV4s8C5pNAl4HIvOhTFqTiYfZsTQXWVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HJPwhTvt; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43H9sUsO049786;
	Wed, 17 Apr 2024 04:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713347670;
	bh=42szbn/JKNKxbraPXd7JD5FF4kFxy+kYXLBy8GFxv5g=;
	h=From:To:CC:Subject:Date;
	b=HJPwhTvtrQCrpkrWpsVu4jWNljaK1CW4Qpczkf7At3QMGjEvI/+Dps9yRxoJLP7yu
	 l50CymYrK7p3mEi1hPKGHh8/k+Pi7TqxMblA/ZQG0QkresXOKXzKMtN0x24aLpmb+D
	 O/TfhpDYhSyjDT3J2L74s95mQWghL1mBkHWwpFBA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43H9sUsn022608
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Apr 2024 04:54:30 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Apr 2024 04:54:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Apr 2024 04:54:30 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43H9sPoJ085723;
	Wed, 17 Apr 2024 04:54:26 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <rogerq@kernel.org>, <dan.carpenter@linaro.org>,
        <robh@kernel.org>, <jpanis@baylibre.com>,
        <u.kleine-koenig@pengutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <spatton@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: cleanup DMA Channels before using them
Date: Wed, 17 Apr 2024 15:24:25 +0530
Message-ID: <20240417095425.2253876-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The TX and RX DMA Channels used by the driver to exchange data with CPSW
are not guaranteed to be in a clean state during driver initialization.
The Bootloader could have used the same DMA Channels without cleaning them
up in the event of failure. Thus, reset and disable the DMA Channels to
ensure that they are in a clean state before using them.

Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
Reported-by: Schuyler Patton <spatton@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Hello,

This patch is based on commit:
96fca68c4fbf Merge tag 'nfsd-6.9-3' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
of mainline Linux.

Regards,
Siddharth.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index bfba883d4fc4..259d7cb13f6e 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3260,6 +3260,8 @@ static void am65_cpsw_unregister_devlink(struct am65_cpsw_common *common)
 
 static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 {
+	struct am65_cpsw_rx_chn *rx_chan = &common->rx_chns;
+	struct am65_cpsw_tx_chn *tx_chan = common->tx_chns;
 	struct device *dev = common->dev;
 	struct am65_cpsw_port *port;
 	int ret = 0, i;
@@ -3272,6 +3274,22 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 	if (ret)
 		return ret;
 
+	/* The DMA Channels are not guaranteed to be in a clean state.
+	 * Reset and disable them to ensure that they are back to the
+	 * clean state and ready to be used.
+	 */
+	for (i = 0; i < common->tx_ch_num; i++) {
+		k3_udma_glue_reset_tx_chn(tx_chan[i].tx_chn, &tx_chan[i],
+					  am65_cpsw_nuss_tx_cleanup);
+		k3_udma_glue_disable_tx_chn(tx_chan[i].tx_chn);
+	}
+
+	for (i = 0; i < AM65_CPSW_MAX_RX_FLOWS; i++)
+		k3_udma_glue_reset_rx_chn(rx_chan->rx_chn, i, rx_chan,
+					  am65_cpsw_nuss_rx_cleanup, !!i);
+
+	k3_udma_glue_disable_rx_chn(rx_chan->rx_chn);
+
 	ret = am65_cpsw_nuss_register_devlink(common);
 	if (ret)
 		return ret;
-- 
2.40.1


