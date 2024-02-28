Return-Path: <linux-kernel+bounces-85153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C9086B133
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CE91C22EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965C51534F4;
	Wed, 28 Feb 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCFN+cZr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6FF73519;
	Wed, 28 Feb 2024 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129060; cv=none; b=CtTsr8k9bYdacoitHZpeSiBbHlfY4l1HqY39LB/SHJPYiElTeFNiBGc9qjjEFUfYIKEIwx/ctyl2bZNX1zRmCbgeVYZiazHqz23WHNH+wPLa6xB5pxFpyUfIodlarAMoeG8Ptp+JWmAoiVt51mr3mre6V5RPj9XPCZ3u9QLTLds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129060; c=relaxed/simple;
	bh=5ZN5lb9qZh+wr9R+euAaAWQtDY1Ld9pqoFz7FSR7nU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bSSYhR0715qTp3tD/JM4m4cnSw8vK6dkDlXBd0I9hcoukkfLEFbMQzD4/Gxu0k3HAn9hQX4EfYnaK9b2I3C+/k8fSFIRCFlfWApxi4uO0cRmMRWELq0Y2nnDcGTD2BSU+oMPkCu0kKKHEsTi/DHmpoqEOdnPT5t5Dj608uxz9Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCFN+cZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2803C433F1;
	Wed, 28 Feb 2024 14:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709129059;
	bh=5ZN5lb9qZh+wr9R+euAaAWQtDY1Ld9pqoFz7FSR7nU4=;
	h=From:To:Cc:Subject:Date:From;
	b=YCFN+cZrz77OSYi3x49AK08LMrEZTz1xtiWB12Kz3FE7haRPxCTQL5LArbfAgRCwq
	 pkc38JPw97vWJ/Ss5MDO7rynTPqLcae8421fO+1apsLr4p3jJzOZ9h8n2eauIAGgmL
	 kDDvEcuDe9+WU8kDT0orjDmylaAwLEXOxNsw8iXsXna3/ttxD2yY2TywkWg/jb0qSt
	 nalk09LUf/Q1Y5+ZBreRv07wkrxo8y5ypvOMiwQFbNFGuQ514/+rLwF4MRuz5owzFe
	 Cv1VLVu1+EL2w8DQnylxiG3Do8GLHp5QLN8Ks3BWS6aiE1yr4QmPWK3al8KxhNsgRp
	 BML2iZ2MeCidA==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Roger Quadros <rogerq@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: ti: am65-cpsw-qos: fix non-bql configs
Date: Wed, 28 Feb 2024 15:03:10 +0100
Message-Id: <20240228140413.1862310-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

It is now possible to disable BQL, but that causes cpsw to break:

drivers/net/ethernet/ti/am65-cpsw-nuss.c:297:28: error: no member named 'dql' in 'struct netdev_queue'
  297 |                    dql_avail(&netif_txq->dql),

Add an #ifdef check for CONFIG_BQL around this usage.

Fixes: ea7f3cfaa588 ("net: bql: allow the config to be disabled")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 9d2f4ac783e4..3a3ec9959ee2 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -294,7 +294,11 @@ static void am65_cpsw_nuss_ndo_host_tx_timeout(struct net_device *ndev,
 		   txqueue,
 		   netif_tx_queue_stopped(netif_txq),
 		   jiffies_to_msecs(jiffies - trans_start),
+#ifdef CONFIG_BQL
 		   dql_avail(&netif_txq->dql),
+#else
+		   0,
+#endif
 		   k3_cppi_desc_pool_avail(tx_chn->desc_pool));
 
 	if (netif_tx_queue_stopped(netif_txq)) {
-- 
2.39.2


