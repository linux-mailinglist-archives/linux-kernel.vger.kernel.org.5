Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6499F7F885D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 05:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjKYE4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 23:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYE4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 23:56:42 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819E81707;
        Fri, 24 Nov 2023 20:56:48 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r6kiU-0002Af-1d;
        Sat, 25 Nov 2023 04:56:31 +0000
Date:   Sat, 25 Nov 2023 04:56:20 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Woudstra <ericwouds@gmail.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH net] net: phylink: set phy_state interface when attaching SFP
Message-ID: <8abed37d01d427bf9d27a157860c54375c994ea1.1700887953.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assume 'usxgmii' being set as initial interface mode in DTS. Now plug
a 2.5GBase-T SFP module with exposed PHY. Currently this results in
a rather bizare situation:

RTL8221B-VB-CG 2.5Gbps PHY (C45) i2c:sfp1-wan:11: rtl822x_c45_get_features: supported=00,00000000,00008000,000080ef
mtk_soc_eth 15100000.ethernet eth2: requesting link mode phy/2500base-x with support 00,00000000,00008000,0000e0ef
mtk_soc_eth 15100000.ethernet eth2: switched to phy/2500base-x link mode   <<< !!!!!!
mtk_soc_eth 15100000.ethernet eth2: major config usxgmii    <<< !!!!!!
mtk_soc_eth 15100000.ethernet eth2: phylink_mac_config: mode=phy/usxgmii/none adv=00,00000000,00000000,00000000 pause=00
mtk_soc_eth 15100000.ethernet eth2: PHY [i2c:sfp1-wan:11] driver [RTL8221B-VB-CG 2.5Gbps PHY (C45)] (irq=POLL)
mtk_soc_eth 15100000.ethernet eth2: phy: 2500base-x setting supported 00,00000000,00008000,0000e0ef advertising 00,00000000,00008000,0000e0ef

Then the link seemingly comes up (but is dead) because no subsequent
call to phylink_major_config actually configured MAC and PCS for
2500base-x mode.

This is because phylink_mac_initial_config() considers
pl->phy_state.interface if in MLO_AN_PHY mode while
phylink_sfp_set_config() only sets pl->link_config.interface.

Also set pl->phy_state.interface in phylink_sfp_set_config().

Fixes: 31eb8907aa5b ("net: phylink: allow attaching phy for SFP modules on 802.3z mode")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/phylink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index aa842634d5c2c..21ef77e4fe720 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3056,6 +3056,7 @@ static void phylink_sfp_set_config(struct phylink *pl, u8 mode,
 	    pl->link_config.interface != state->interface) {
 		pl->cur_link_an_mode = mode;
 		pl->link_config.interface = state->interface;
+		pl->phy_state.interface = state->interface;
 
 		changed = true;
 
-- 
2.42.1

