Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6F79F958
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbjINEFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjINEFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:05:09 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D55AD1BE3;
        Wed, 13 Sep 2023 21:05:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 91E4A606080E2;
        Thu, 14 Sep 2023 12:05:01 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     jirislaby@kernel.org, mickflemm@gmail.com, mcgrof@kernel.org,
        kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH wireless-next 4/9] wifi: ath5k: remove unnecessary (void*) conversions
Date:   Thu, 14 Sep 2023 12:04:59 +0800
Message-Id: <20230914040459.1169785-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void *) to (struct ath5k_hw *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/ath/ath5k/base.c | 4 ++--
 drivers/net/wireless/ath/ath5k/pci.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
index c59c14483177..597d1f916dfd 100644
--- a/drivers/net/wireless/ath/ath5k/base.c
+++ b/drivers/net/wireless/ath/ath5k/base.c
@@ -230,13 +230,13 @@ ath5k_chip_name(enum ath5k_srev_type type, u_int16_t val)
 }
 static unsigned int ath5k_ioread32(void *hw_priv, u32 reg_offset)
 {
-	struct ath5k_hw *ah = (struct ath5k_hw *) hw_priv;
+	struct ath5k_hw *ah = hw_priv;
 	return ath5k_hw_reg_read(ah, reg_offset);
 }
 
 static void ath5k_iowrite32(void *hw_priv, u32 val, u32 reg_offset)
 {
-	struct ath5k_hw *ah = (struct ath5k_hw *) hw_priv;
+	struct ath5k_hw *ah = hw_priv;
 	ath5k_hw_reg_write(ah, val, reg_offset);
 }
 
diff --git a/drivers/net/wireless/ath/ath5k/pci.c b/drivers/net/wireless/ath/ath5k/pci.c
index 86b8cb975b1a..b51fce5ae260 100644
--- a/drivers/net/wireless/ath/ath5k/pci.c
+++ b/drivers/net/wireless/ath/ath5k/pci.c
@@ -54,7 +54,7 @@ MODULE_DEVICE_TABLE(pci, ath5k_pci_id_table);
 /* return bus cachesize in 4B word units */
 static void ath5k_pci_read_cachesize(struct ath_common *common, int *csz)
 {
-	struct ath5k_hw *ah = (struct ath5k_hw *) common->priv;
+	struct ath5k_hw *ah = common->priv;
 	u8 u8tmp;
 
 	pci_read_config_byte(ah->pdev, PCI_CACHE_LINE_SIZE, &u8tmp);
@@ -76,7 +76,7 @@ static void ath5k_pci_read_cachesize(struct ath_common *common, int *csz)
 static bool
 ath5k_pci_eeprom_read(struct ath_common *common, u32 offset, u16 *data)
 {
-	struct ath5k_hw *ah = (struct ath5k_hw *) common->ah;
+	struct ath5k_hw *ah = common->ah;
 	u32 status, timeout;
 
 	/*
-- 
2.30.2

