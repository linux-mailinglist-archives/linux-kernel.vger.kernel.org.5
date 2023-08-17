Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B54277F602
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244390AbjHQMFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350720AbjHQMFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:05:04 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4663599;
        Thu, 17 Aug 2023 05:04:39 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qWbjj-0001mN-0l;
        Thu, 17 Aug 2023 12:04:23 +0000
Date:   Thu, 17 Aug 2023 13:04:06 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Alexander Couzens <lynxis@fe80.eu>,
        Daniel Golle <daniel@makrotopia.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: pcs: lynxi: fully reconfigure if link is down
Message-ID: <e9831ec99acd5a8ab03c76fce87fa750c7041e60.1692273723.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MT7988 When switching from 10GBase-R/5GBase-R/USXGMII to one of the
interface modes provided by mtk-pcs-lynxi we need to make sure to
always perform a full configuration of the PHYA.
As the idea behind not doing that was mostly to prevent an existing link
going down without any need for it to do so. Hence we can just always
perform a full confinguration in case the link is down.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/pcs/pcs-mtk-lynxi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index b0f3ede945d96..788c2ccde064e 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -108,8 +108,8 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				bool permit_pause_to_mac)
 {
 	struct mtk_pcs_lynxi *mpcs = pcs_to_mtk_pcs_lynxi(pcs);
-	bool mode_changed = false, changed;
-	unsigned int rgc3, sgm_mode, bmcr;
+	bool mode_changed = false, changed, link;
+	unsigned int bm, rgc3, sgm_mode, bmcr;
 	int advertise, link_timer;
 
 	advertise = phylink_mii_c22_pcs_encode_advertisement(interface,
@@ -117,6 +117,10 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	if (advertise < 0)
 		return advertise;
 
+	/* Check if link is currently up */
+	regmap_read(mpcs->regmap, SGMSYS_PCS_CONTROL_1, &bm);
+	link = !!(FIELD_GET(SGMII_BMSR, bm) & BMSR_LSTATUS);
+
 	/* Clearing IF_MODE_BIT0 switches the PCS to BASE-X mode, and
 	 * we assume that fixes it's speed at bitrate = line rate (in
 	 * other words, 1000Mbps or 2500Mbps).
@@ -137,7 +141,10 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		bmcr = 0;
 	}
 
-	if (mpcs->interface != interface) {
+	/* Do a full reconfiguration only if the link is down or the interface
+	 * mode has changed
+	 */
+	if (mpcs->interface != interface || !link) {
 		link_timer = phylink_get_link_timer_ns(interface);
 		if (link_timer < 0)
 			return link_timer;
-- 
2.41.0
