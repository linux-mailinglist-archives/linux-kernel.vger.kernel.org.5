Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E567E3BBD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjKGMJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjKGMIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:08:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD342113;
        Tue,  7 Nov 2023 04:08:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C021DC433C7;
        Tue,  7 Nov 2023 12:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358891;
        bh=FcoNM3XJcP4DwFFhQmlw06GnbCF28OSKtSvDxuhdixM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBYs3nMJEQ5seGgjAoEluHNXFBtQ7nbQkpyOjf0WZpdk2pqP2OEkIESZsAESEGxUf
         SJ+m6j/f/jrSVTHVvlYW+T7OWJkZnGVeynbQRrPB8Jr4Z3qczwm7LX7msPpaGeUDhh
         XKIZ1WlgQxVt9sKrILbcYyAq/XyIbaDaqCYMlYLoGEzJ2o99BB52KXHOxfnk0ojyfp
         GiKtI41r3VcXPdb2PlxfZfpsJcuuwQuhkwyCOGLQBjYGiUex2aQ7etHcGeH6VItgpy
         O8KPo5QHw09IlKCHzttx+YBWI9KI18eNUlC4K/Nnw2N5o/onRRu/MSiS5hka3KgmgU
         cALE2fAIGks2A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux@armlinux.org.uk,
        andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 20/31] net: sfp: add quirk for FS's 2.5G copper SFP
Date:   Tue,  7 Nov 2023 07:06:07 -0500
Message-ID: <20231107120704.3756327-20-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120704.3756327-1-sashal@kernel.org>
References: <20231107120704.3756327-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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
index a50038a452507..3679a43f4eb02 100644
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

