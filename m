Return-Path: <linux-kernel+bounces-117363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B811088AA71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5719A1F63A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDD16CDA5;
	Mon, 25 Mar 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UiLdwfHn"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7526D1B5;
	Mon, 25 Mar 2024 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380463; cv=none; b=ZkAAplME+UZs+xI9Mjgz+hbdVoFf1cpMLw/yb3aIAn2/KqkdgG6FX4RZpKTVmxdsK67MdjCQxjB7J/c3P9zMFxUdRNhMM3QHRPfVGMFNtsTUPu1Ch/mjxVxBz49Ech8kpoMbLJKheRaSAHbSgibDBrQTJ9vYs0Bb822osrHiR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380463; c=relaxed/simple;
	bh=xeCJhhkfOqR0/lYcw66pUQaVeJ2E9uNUlDvPgWtGRRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMadZpZUpTJwQzG814vdGiF+UMEJJrEcqtQ7MAvSMTSNzz0o3ED9H0o/ssnQDs08lgdT57q3K2VmeQGcB12RvyI92S1p3vOW/Qsjt81z4EbwCiEP1/PTMebVK2EsxY6FkWTJapVxKFwhidmXv3wfmzr/GmZIkvai44tRbj1glsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UiLdwfHn; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91A6D240008;
	Mon, 25 Mar 2024 15:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711380458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GfMOxpWRXLDXkXWQTgxb0njMa5htX2S/fZtS26Kk3Z4=;
	b=UiLdwfHnU5NRNZtqPh1TqkAkfPQF0gugqOgtH/H8AiQaVVinunCILHj3NKgsoLsSadibcV
	He6tvM6WOZR+erZ7BkxlTMHFbOSf7FdhmCm7k1BEWnPKLDrTFsiIVj2NRjxBQjF5gd4ih6
	GfcMyBerVaivFUPHtVqPa5+l26W5ltm/1aY72PwUpDH+UH6iIS2R7EbPtnMfa7K1NpDTQo
	Cu8R4lgatYIQSlYLydh9+YJkHNEriZDeKKRAALs/8kczJOM3Bww16WsMUVkyJOqitRzJyQ
	5Gm4bIluNp707Pct5hTvA04IkVVqjz0oyffNOlwCX+8T8Uu1Lwd0FxYqb9YueA==
From: thomas.perrot@bootlin.com
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [PATCH net-next] net: macb: allow MTU change when the interface is up
Date: Mon, 25 Mar 2024 16:27:35 +0100
Message-ID: <20240325152735.1708636-1-thomas.perrot@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.perrot@bootlin.com

From: Thomas Perrot <thomas.perrot@bootlin.com>

The macb_change_mtu callback doesn't allow MTU changes when the
interface is up because the MTU is used to set the buffer size on
GEM.

So, to be able to change the MTU from userspace it is necessary to
explicitly down then to up the interface, which is problematic in
some cases.

Then we suggest to reset the interface when the interface is already
up to allow to change the MTU, regardless of if the interface is up
or not.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 898debfd4db3..5c20b162c5da 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3019,11 +3019,19 @@ static int macb_close(struct net_device *dev)
 
 static int macb_change_mtu(struct net_device *dev, int new_mtu)
 {
-	if (netif_running(dev))
-		return -EBUSY;
+	int reset = 0;
+
+	/* On GEM the buffer size is based on the MTU */
+	if (netif_running(dev)) {
+		macb_close(dev);
+		reset = 1;
+	}
 
 	dev->mtu = new_mtu;
 
+	if (reset)
+		macb_open(dev);
+
 	return 0;
 }
 
-- 
2.44.0


