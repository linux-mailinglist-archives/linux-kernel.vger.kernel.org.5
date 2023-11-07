Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73427E3D48
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjKGM1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjKGM0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:26:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DFF3583;
        Tue,  7 Nov 2023 04:10:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B55EC433C8;
        Tue,  7 Nov 2023 12:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359017;
        bh=J61bFAhNYJImoXP4iAcz5dX9zulW1SGBjxGSdZh2ENw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5i4AnjM5ajfOA5nRqe7THWO6Fjn6usIS3cKmwV+SKLIE/D9KN7QvWE4pypPN5nVI
         Kk61ZkL082BdHCY3iuaJa/doxxC+cdi1W8rzxDS3tghuUriF0AiayJwuALyCVTHxRN
         1D3YzR9obnJTLUtPNVr1O2ZjODDeVsUGvw1TrUOQOW9DXS2lPtq4b/fmy2bg5GIZPa
         Gm2NJoqMI/7VaefFppNeqyIwwRe70Xd7eaEKbzDCevQeCzn/iQDj2go3SyAyVSRy/a
         Gh8RTTQYU5U2D9/7I+nztvVC5xw9D8JYLX1tTFSLFal5lLtEHf8HxpmMi2a8ZBJODU
         MT4dxt2eUtlKg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux@armlinux.org.uk,
        andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 19/30] net: sfp: add quirk for FS's 2.5G copper SFP
Date:   Tue,  7 Nov 2023 07:08:34 -0500
Message-ID: <20231107120922.3757126-19-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120922.3757126-1-sashal@kernel.org>
References: <20231107120922.3757126-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

[ Upstream commit e27aca3760c08b7b05aea71068bd609aa93e7b35 ]

Add a quirk for a copper SFP that identifies itself as "FS" "SFP-2.5G-T".
This module's PHY is inaccessible, and can only run at 2500base-X with the
host without negotiation. Add a quirk to enable the 2500base-X interface mode
with 2500base-T support and disable auto negotiation.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Link: https://lore.kernel.org/r/20230925080059.266240-1-Raju.Lakkaraju@microchip.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 338b9769d91a1..f411ded5344a8 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -468,6 +468,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault),
 
+	// FS 2.5G Base-T
+	SFP_QUIRK_M("FS", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+
 	// Lantech 8330-262D-E can operate at 2500base-X, but incorrectly report
 	// 2500MBd NRZ in their EEPROM
 	SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),
-- 
2.42.0

