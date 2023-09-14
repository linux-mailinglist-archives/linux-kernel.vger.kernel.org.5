Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629A879F95E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbjINEFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjINEF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:05:28 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 145211FC6;
        Wed, 13 Sep 2023 21:05:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 9B255606080EF;
        Thu, 14 Sep 2023 12:05:18 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org, quic_jjohnson@quicinc.com, toke@toke.dk
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH wireless-next 6/9] wifi: ath10k: Remove unnecessary (void*) conversions
Date:   Thu, 14 Sep 2023 12:05:17 +0800
Message-Id: <20230914040517.1170024-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct htt_rx_ring_setup_ring32 *),
(struct htt_rx_ring_setup_ring64 *), (struct ath_softc *)
or (struct ath_hw *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/ath/ath10k/htt_tx.c | 6 ++----
 drivers/net/wireless/ath/ath9k/pci.c     | 6 +++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index bd603feb7953..31f08db8a42f 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -798,16 +798,14 @@ static int ath10k_htt_send_frag_desc_bank_cfg_64(struct ath10k_htt *htt)
 
 static void ath10k_htt_fill_rx_desc_offset_32(struct ath10k_hw_params *hw, void *rx_ring)
 {
-	struct htt_rx_ring_setup_ring32 *ring =
-			(struct htt_rx_ring_setup_ring32 *)rx_ring;
+	struct htt_rx_ring_setup_ring32 *ring = rx_ring;
 
 	ath10k_htt_rx_desc_get_offsets(hw, &ring->offsets);
 }
 
 static void ath10k_htt_fill_rx_desc_offset_64(struct ath10k_hw_params *hw, void *rx_ring)
 {
-	struct htt_rx_ring_setup_ring64 *ring =
-			(struct htt_rx_ring_setup_ring64 *)rx_ring;
+	struct htt_rx_ring_setup_ring64 *ring = rx_ring;
 
 	ath10k_htt_rx_desc_get_offsets(hw, &ring->offsets);
 }
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index 0633589b85c2..e655cd8bbf94 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -781,7 +781,7 @@ static const struct pci_device_id ath_pci_id_table[] = {
 /* return bus cachesize in 4B word units */
 static void ath_pci_read_cachesize(struct ath_common *common, int *csz)
 {
-	struct ath_softc *sc = (struct ath_softc *) common->priv;
+	struct ath_softc *sc = common->priv;
 	u8 u8tmp;
 
 	pci_read_config_byte(to_pci_dev(sc->dev), PCI_CACHE_LINE_SIZE, &u8tmp);
@@ -799,7 +799,7 @@ static void ath_pci_read_cachesize(struct ath_common *common, int *csz)
 
 static bool ath_pci_eeprom_read(struct ath_common *common, u32 off, u16 *data)
 {
-	struct ath_hw *ah = (struct ath_hw *) common->ah;
+	struct ath_hw *ah = common->ah;
 
 	common->ops->read(ah, AR5416_EEPROM_OFFSET + (off << AR5416_EEPROM_S));
 
@@ -820,7 +820,7 @@ static bool ath_pci_eeprom_read(struct ath_common *common, u32 off, u16 *data)
 /* Need to be called after we discover btcoex capabilities */
 static void ath_pci_aspm_init(struct ath_common *common)
 {
-	struct ath_softc *sc = (struct ath_softc *) common->priv;
+	struct ath_softc *sc = common->priv;
 	struct ath_hw *ah = sc->sc_ah;
 	struct pci_dev *pdev = to_pci_dev(sc->dev);
 	struct pci_dev *parent;
-- 
2.30.2

