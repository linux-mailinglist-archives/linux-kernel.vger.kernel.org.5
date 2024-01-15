Return-Path: <linux-kernel+bounces-26156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA32882DC14
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F385DB213C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B608C17BCF;
	Mon, 15 Jan 2024 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DUVyiaxL"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FDC179B7;
	Mon, 15 Jan 2024 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id CD0D8C646A;
	Mon, 15 Jan 2024 14:59:20 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D897FF805;
	Mon, 15 Jan 2024 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705330753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qUQFLny0OJogecoJQ6XqtWgWxGYqMWpFkFbyJn8U9iw=;
	b=DUVyiaxLVcCQGvgki9t3xNTv8GyWblnTcZhvz4bwUksdLH++0leG6dGavwjxpuGjuXmFQo
	AtpUp3KdZ5ca5Q5GBW/O5IdK5X+Ji5HN9f9Hd1FZmMqycOtJFi00CfxpxqVEogkGynnEYc
	gYVu5cF29DpkofadmoGsTjxKllPp2aMsKbxA5EN45TFimjykjtuqydiJUMbse7nH6b+J6k
	1cwwXy7sFTN78n84yRwUF+GZfILWRWpyRj4ivqIW6IrLMgk/kWq2xhCdMtgIdWsUzR268u
	EUAT96Afx6Roxd2AWcce9OVrmRouRfODQarR7qs347kTnnbd6oCfbarp00bcPw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Mon, 15 Jan 2024 15:56:31 +0100
Subject: [PATCH 2/5] wifi: wilc1000: fix driver_handler when committing
 initial configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240115-wilc_1000_fixes-v1-2-54d29463a738@bootlin.com>
References: <20240115-wilc_1000_fixes-v1-0-54d29463a738@bootlin.com>
In-Reply-To: <20240115-wilc_1000_fixes-v1-0-54d29463a738@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 David Mosberger-Tang <davidm@egauge.net>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

From: Ajay Singh <ajay.kathat@microchip.com>

During firmware initial configuration in wilc_init_fw_config, the special
driver_handler 0 should be used instead of targeting a specific virtual
interface (either 1 or 2)
The issue does not seem to have real consequence (both virtual interfaces
seems to answer correctly to a Add Block Ack request with the Immediate
policy), but lets make everything homogeneous

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 8923eb64c964..f3b9709f8730 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -416,7 +416,7 @@ static int wilc_init_fw_config(struct net_device *dev, struct wilc_vif *vif)
 
 	b = 1;
 	if (!wilc_wlan_cfg_set(vif, 0, WID_11N_IMMEDIATE_BA_ENABLED, &b, 1,
-			       1, 1))
+			       1, 0))
 		goto fail;
 
 	return 0;

-- 
2.42.1


