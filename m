Return-Path: <linux-kernel+bounces-36465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024C683A139
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989E11F2599F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB45E575;
	Wed, 24 Jan 2024 05:17:57 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B55DDD0;
	Wed, 24 Jan 2024 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073476; cv=none; b=Fha3yk8saVAEAAQvyK3MgjROC7S7cLB+0wbZyr8QfDGvGwPQr9I9G9hPAUiv4sGkSFCZpg/G+Awz1bCBQAAv3DU5/Ir9mjBTQ6rC6lBGVBb041chy81GNtn8P/JH2gJ2WVHXtavkvR+2jC+mN9bIJ/jwu/aMDYmtCqeChS7Rdy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073476; c=relaxed/simple;
	bh=D4U+G3+No+qUuQObL6c1NR2hyUkPlZqGZyAIN1w4kis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QkasSzyHwDHe5FeRJ6BerUnFDB5cB2qhYzYlsWBOpQ0N20ISLjat0QcwSDD4eTtkXW1tm1fIBn/NmTW2b8nIynH8oP756gpWjeHo8lcmoOV038XPGW9xa2iz175aFcqBktcEGr3FvUBQRL+C1ukyp4Wf2gB7NCGRWvxKEni4dzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rSVdj-00010p-1D;
	Wed, 24 Jan 2024 05:17:32 +0000
Date: Wed, 24 Jan 2024 05:17:25 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: John Crispin <john@phrozen.org>
Subject: [PATCH net] net: dsa: mt7530: fix 10M/100M speed on MT7988 switch
Message-ID: <a5b04dfa8256d8302f402545a51ac4c626fdba25.1706071272.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Setup PMCR port register for actual speed and duplex on internally
connected PHYs of the MT7988 built-in switch. This fixes links with
speeds other than 1000M.

Fixes: ("110c18bfed414 net: dsa: mt7530: introduce driver for MT7988 built-in switch")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mt7530.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index f8ecc354630b0..fbd52ff7cbd6e 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2843,8 +2843,7 @@ static void mt753x_phylink_mac_link_up(struct dsa_switch *ds, int port,
 	/* MT753x MAC works in 1G full duplex mode for all up-clocked
 	 * variants.
 	 */
-	if (interface == PHY_INTERFACE_MODE_INTERNAL ||
-	    interface == PHY_INTERFACE_MODE_TRGMII ||
+	if (interface == PHY_INTERFACE_MODE_TRGMII ||
 	    (phy_interface_mode_is_8023z(interface))) {
 		speed = SPEED_1000;
 		duplex = DUPLEX_FULL;
-- 
2.43.0


