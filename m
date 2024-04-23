Return-Path: <linux-kernel+bounces-155753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 312418AF6A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8B51F2689E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFACD140E4D;
	Tue, 23 Apr 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XGslnqNG"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A023775;
	Tue, 23 Apr 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897229; cv=none; b=Nem7SzPdoWIc29fRYzdd2g9yOpNtpqvf+k7yjZbQXKrjYWirc6E7UL+PHJ8r8qz0y0t/XH4HZwKXiek0UzFqW8Zz+FRSQaVCl3ufBKoaE/NgxSBB9Tuyu/+kJJYWOkWHwxSDAkpgThAkB/xy071LEhsPZjwM7ILrDikszFQJJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897229; c=relaxed/simple;
	bh=WXA2ZfSFb7CbPUJRrqZdpAtOjK+DU+4PHhQxaWIgaCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZ1W7i6EwjN5F1lE0tOEhB3FP0JQ4aiw/hWPigMq7wPwTwkMCpmQXRgfSHUjXsM98r84YRpeCB+de+QnyiHUrb3zA6fVU76JJFNmRzOuMPhjRFgFrixdQLwSjUzJzqvJBC7YcDGTnCtuXlpsw8gF+qtRHgEbiGiC7yiK+XA+3bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XGslnqNG; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B8930C00281B;
	Tue, 23 Apr 2024 11:33:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B8930C00281B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713897221;
	bh=WXA2ZfSFb7CbPUJRrqZdpAtOjK+DU+4PHhQxaWIgaCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGslnqNGknPdxUopqHaujYiNG7PSj7tAYSIJWW3hxfn1BvxoydIbxS0FMYcTR8H8q
	 j71rzh++YAIEFODroVXXXmtIsr256j1MJ5UTXeCASix5AScNJYzGeqN9K45zuTAR7Q
	 EE2j3zRl5LDTN6OViWWDwONQXRrfDqdVERxgf66w=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id D1E7C18041CAC7;
	Tue, 23 Apr 2024 11:33:39 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 6/8] net: dsa: b53: Call b53_eee_init() from b53_mac_link_up()
Date: Tue, 23 Apr 2024 11:33:37 -0700
Message-Id: <20240423183339.1368511-7-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423183339.1368511-1-florian.fainelli@broadcom.com>
References: <20240423183339.1368511-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And make sure this is done for the MLO_AN_PHY case, where it actually
makes sense, contrary to b53_adjust_link() which only did it for
fixed-PHY configurations where it does not make sense.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 18b87e903943..a4b50ee97f87 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1481,9 +1481,13 @@ static void b53_phylink_mac_link_up(struct dsa_switch *ds, int port,
 				    bool tx_pause, bool rx_pause)
 {
 	struct b53_device *dev = ds->priv;
+	struct ethtool_keee *p = &dev->ports[port].eee;
 
-	if (mode == MLO_AN_PHY)
+	if (mode == MLO_AN_PHY) {
+		/* Re-negotiate EEE if it was enabled already */
+		p->eee_enabled = b53_eee_init(ds, port, phydev);
 		return;
+	}
 
 	if (mode == MLO_AN_FIXED) {
 		/* Force flow control on BCM5301x's CPU port */
-- 
2.34.1


