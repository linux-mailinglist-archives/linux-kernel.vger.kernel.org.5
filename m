Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E4D77B59F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbjHNJhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbjHNJgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:36:49 -0400
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 589481702;
        Mon, 14 Aug 2023 02:36:32 -0700 (PDT)
Received: from localhost.biz (unknown [10.81.81.211])
        by gw.red-soft.ru (Postfix) with ESMTPA id 76E433E0CA5;
        Mon, 14 Aug 2023 12:36:27 +0300 (MSK)
From:   Artem Chernyshev <artem.chernyshev@red-soft.ru>
To:     Jonas Gorski <jonas.gorski@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>
Cc:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH v2] brcm80211: brcmsmac: phy: Remove unreachable code
Date:   Mon, 14 Aug 2023 12:36:21 +0300
Message-Id: <20230814093621.289754-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <CAOiHx==NiPG2GdZNrJn5hPEdi70Spe9Kc9CHO5NjnATAjCgUsg@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 179219 [Aug 14 2023]
X-KLMS-AntiSpam-Version: 5.9.59.0
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 526 526 7a6a9b19f6b9b3921b5701490f189af0e0cd5310, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;localhost.biz:7.1.1;red-soft.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/08/14 08:36:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/08/14 07:11:00 #21604839
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wlc_phy_txpwr_srom_read_nphy() in wlc_phy_attach_nphy() can not 
return false, so it's impossible to get true value in this
if-statement. Also change those functions return types to void
since no one using it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
V1->V2 Change return types to void

 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c         |  3 +--
 .../broadcom/brcm80211/brcmsmac/phy/phy_int.h         |  2 +-
 .../wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c  | 11 +++--------
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
index ccc621b8ed9f..07f83ff5a54a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
@@ -551,8 +551,7 @@ wlc_phy_attach(struct shared_phy *sh, struct bcma_device *d11core,
 		if (!pi->phycal_timer)
 			goto err;
 
-		if (!wlc_phy_attach_nphy(pi))
-			goto err;
+		wlc_phy_attach_nphy(pi);
 
 	} else if (ISLCNPHY(pi)) {
 		if (!wlc_phy_attach_lcnphy(pi))
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_int.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_int.h
index 8668fa5558a2..70a9ec050717 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_int.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_int.h
@@ -941,7 +941,7 @@ void wlc_phy_papd_decode_epsilon(u32 epsilon, s32 *eps_real, s32 *eps_imag);
 void wlc_phy_cal_perical_mphase_reset(struct brcms_phy *pi);
 void wlc_phy_cal_perical_mphase_restart(struct brcms_phy *pi);
 
-bool wlc_phy_attach_nphy(struct brcms_phy *pi);
+void wlc_phy_attach_nphy(struct brcms_phy *pi);
 bool wlc_phy_attach_lcnphy(struct brcms_phy *pi);
 
 void wlc_phy_detach_lcnphy(struct brcms_phy *pi);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
index 8580a2754789..cd9b502a6a9f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -14546,7 +14546,7 @@ static void wlc_phy_txpwr_srom_read_ppr_nphy(struct brcms_phy *pi)
 	wlc_phy_txpwr_apply_nphy(pi);
 }
 
-static bool wlc_phy_txpwr_srom_read_nphy(struct brcms_phy *pi)
+static void wlc_phy_txpwr_srom_read_nphy(struct brcms_phy *pi)
 {
 	struct ssb_sprom *sprom = &pi->d11core->bus->sprom;
 
@@ -14595,11 +14595,9 @@ static bool wlc_phy_txpwr_srom_read_nphy(struct brcms_phy *pi)
 		pi->phycal_tempdelta = 0;
 
 	wlc_phy_txpwr_srom_read_ppr_nphy(pi);
-
-	return true;
 }
 
-bool wlc_phy_attach_nphy(struct brcms_phy *pi)
+void wlc_phy_attach_nphy(struct brcms_phy *pi)
 {
 	uint i;
 
@@ -14645,10 +14643,7 @@ bool wlc_phy_attach_nphy(struct brcms_phy *pi)
 	pi->pi_fptr.chanset = wlc_phy_chanspec_set_nphy;
 	pi->pi_fptr.txpwrrecalc = wlc_phy_txpower_recalc_target_nphy;
 
-	if (!wlc_phy_txpwr_srom_read_nphy(pi))
-		return false;
-
-	return true;
+	wlc_phy_txpwr_srom_read_nphy(pi);
 }
 
 static s32 get_rf_pwr_offset(struct brcms_phy *pi, s16 pga_gn, s16 pad_gn)
-- 
2.37.3

