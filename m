Return-Path: <linux-kernel+bounces-63987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E415885382A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991031F2A45E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D1A60243;
	Tue, 13 Feb 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jx06xnCv"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8155FF0D;
	Tue, 13 Feb 2024 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845629; cv=none; b=DEvsE6z4gMKWDIeykqB4A3NKdLU9reeW+i6ffvTCC3+4jIuUfqK1RBhXsbK88eElSVfPwS4aFR+ssoc1DJmd1IknOg32RUj3VuFoD2SL7K+TOWyjJXaZkSdVm2qnItnxO38LJe2jV+Ow0Y1v92gUO7+K2aRNMaRyQJm+++qJNBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845629; c=relaxed/simple;
	bh=+IbLm9MJxyBRjvcQtpRgNGFwNLxIam1/AeyzZaiIC90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=shmEYdkuB5K7U2H7Zl0cfspH/NJo+2BK/oVev0SDMSCDD5NDH/c+jY0747GgKMRHnzG/D4MgY04ZE5UsiqI0dv9nMMk1tPfME6PluahCu/Xx3XQvGx7QQVbnt4faOClEQI6AursjjlxvPfc4hYRoccZku5qnfxac5KlENR4lYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jx06xnCv; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B2304C005FFD;
	Tue, 13 Feb 2024 09:33:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B2304C005FFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1707845620;
	bh=+IbLm9MJxyBRjvcQtpRgNGFwNLxIam1/AeyzZaiIC90=;
	h=From:To:Cc:Subject:Date:From;
	b=Jx06xnCviIukYYI6tAxq0wkYGV8+XYvrmVl6xhTtxo5gQRblaOUoPv/W3nhEP+d6f
	 4GOrnwSuTNVxouVjncnL4KElJgw7SjgdWN6Vn4aeoMQCMzIHgFywLlOgwouYgAZkWL
	 MbDZIB1PNsL7V6TckHto8HyD8WcISh2dElMASfGA=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 2476618041CAC4;
	Tue, 13 Feb 2024 09:33:39 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Justin Chen <justin.chen@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM ASP 2.0 ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: bcmasp: Handle RX buffer allocation failure
Date: Tue, 13 Feb 2024 09:33:39 -0800
Message-Id: <20240213173339.3438713-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buffer_pg variable needs to hold an order-5 allocation (32 x
PAGE_SIZE) which, under memory pressure may fail to be allocated. Deal
with that error condition properly to avoid doing a NULL pointer
de-reference in the subsequent call to dma_map_page().

In addition, the err_reclaim_tx error label in bcmasp_netif_init() needs
to ensure that the TX NAPI object is properly deleted, otherwise
unregister_netdev() will spin forever attempting to test and clear
the NAPI_STATE_HASHED bit.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 53e542881255..f59557b0cd51 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -684,6 +684,8 @@ static int bcmasp_init_rx(struct bcmasp_intf *intf)
 
 	intf->rx_buf_order = get_order(RING_BUFFER_SIZE);
 	buffer_pg = alloc_pages(GFP_KERNEL, intf->rx_buf_order);
+	if (!buffer_pg)
+		return -ENOMEM;
 
 	dma = dma_map_page(kdev, buffer_pg, 0, RING_BUFFER_SIZE,
 			   DMA_FROM_DEVICE);
@@ -1092,6 +1094,7 @@ static int bcmasp_netif_init(struct net_device *dev, bool phy_connect)
 	return 0;
 
 err_reclaim_tx:
+	netif_napi_del(&intf->tx_napi);
 	bcmasp_reclaim_free_all_tx(intf);
 err_phy_disconnect:
 	if (phydev)
-- 
2.34.1


