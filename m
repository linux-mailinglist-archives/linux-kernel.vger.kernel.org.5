Return-Path: <linux-kernel+bounces-37206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B014183AC89
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F7A1F256A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391B27C085;
	Wed, 24 Jan 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="X6wbqruh"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84323C9;
	Wed, 24 Jan 2024 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107889; cv=none; b=e2LBfMknXpok0VWdvJCwahO5nr56ZhePnwBFVf/TD+0Q3FjgXoSf+WQORxg4tZd3quHklYd7up7dd4oF1oOGlIUu4wDUjqmTlh3ryrVpgg4thcUwenNWr3HtVnUkO2dnx6lqSMK/ncWfab/1Tc/7OyRBEqXSeboezcg/UXLhQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107889; c=relaxed/simple;
	bh=24wJJWVUh2cZb1nXQXw4kmreJhJJdyXf+GeakqvGMdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EEEPdYI1vRDAkO/KUnsfGs6J8mx02qniAdGXqrfpJH0K+CdzPjovQd520B/VS4tgdvQVC32zfbPSN/ZJzW4ShiJCbW8PdnWsc51CW1o4HwalDCHCWar3MMtis1X4a6mYspj111+RW3hXzntxTQHm2igQabwZMGv9wmNUgQLTIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=X6wbqruh; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=s48UK9/txojh0jP006gnClU0QGtWU0AZknMA7NCP1qs=; b=X6wbqruhAC9y80cXiNvdROZnFE
	slorrNyyr70EfUee+kPi1OzkuDOHpdN1b+iXK95JJ7d04D7rqY5sGiZS/Hzq9Uk0yyk/ofm9SHaV7
	Zybr9hEvECyWPnkrui/U2iGj4W4B+0xtuzYI/cfufrKSOLZ7MLjicm6lgTSeIRq9+BC4NIaSGjfe/
	65m9cGr+KUz2Tk/eVAhtH8ZMal8vWAfmupnLtX+CHewTTCuz7GGLwOjTrRGLKK7Px3H5WEcn04cjX
	MQMqSuarP3Fs9fOZc984VQbsTPH1Roq2kk44sRaM5Phl9iIePsVrEYWUXJHRx1fpb7KJ1H0Qlcx7c
	0lrqTswQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rSeJF-000NYX-2A; Wed, 24 Jan 2024 15:32:57 +0100
Received: from [87.49.43.79] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rSeJE-0006ur-80; Wed, 24 Jan 2024 15:32:56 +0100
From: Esben Haabendal <esben@geanix.com>
To: netdev@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] net: stmmac: do not clear TBS enable bit on link up/down
Date: Wed, 24 Jan 2024 15:32:55 +0100
Message-ID: <b365dc6f756a3fad4dfaa2675c98f4078aba8a55.1706105494.git.esben@geanix.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27164/Wed Jan 24 10:45:32 2024)

With the dma conf being reallocated on each call to stmmac_open(), any
information in there is lost, unless we specifically handle it.

The STMMAC_TBS_EN bit is set when adding an etf qdisc, and the etf qdisc
therefore would stop working when link was set down and then back up.

Fixes: ba39b344e924 ("net: ethernet: stmicro: stmmac: generate stmmac dma conf before open")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a0e46369ae15..691bf3ef5e30 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3932,6 +3932,9 @@ static int __stmmac_open(struct net_device *dev,
 	priv->rx_copybreak = STMMAC_RX_COPYBREAK;
 
 	buf_sz = dma_conf->dma_buf_sz;
+	for (int i = 0; i < MTL_MAX_TX_QUEUES; i++)
+		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
+			dma_conf->tx_queue[i].tbs = priv->dma_conf.tx_queue[i].tbs;
 	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
 
 	stmmac_reset_queues_param(priv);
-- 
2.43.0


