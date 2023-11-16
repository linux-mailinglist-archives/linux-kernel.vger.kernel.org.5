Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56B37EE88E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjKPU5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPU5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:57:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ADDD4A;
        Thu, 16 Nov 2023 12:57:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB93C433C7;
        Thu, 16 Nov 2023 20:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700168248;
        bh=EjMKx5nsjR7WnKWGm9tsxjc3r1t11YJJEx0o24R8FgU=;
        h=Date:From:To:Cc:Subject:From;
        b=PMUVa2AIRiGi8EJ9pjFjU+974IoHgg3yEfJ31Q9eTjA5HYvoe/4QP4QL2J9Tenblg
         5FJZRhqYP3RWZ47tL7qcdk86sP+MG/N68JJSpgBITaZCaL4u2XJD3hoyQ8OmoUFH3V
         PfBT1Z4KSpHLm75VCOe7WRYrDcFtVAimRoIy3l7MqTJR+ZygB6jkZl3egpJ0iD1O2M
         LIGs67TT1sWFvI9fzCfybzPrXyytxkGjPQnYIO0qiXtkBNS5Uo3FfSIBSWoig8xcJ9
         wWRMUUL/LbjCZS/zA53qqnm+OsCno8mT/vBa1PQu13Q+yLWPTMzAp+izmKxXO9XRfO
         zmU8iEHtVjnxw==
Date:   Thu, 16 Nov 2023 14:57:24 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and fix
 -Warray-bounds warnings
Message-ID: <ZVaCNAohuieMmdq9@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transform zero-length arrays `adm_stat` and `msdu_cnt` into proper
flexible-array members in anonymous union in `struct
mt7996_mcu_all_sta_info_event` via the DECLARE_FLEX_ARRAY()
helper; and fix multiple -Warray-bounds warnings:

drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:483:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:490:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:492:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:469:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:477:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:479:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]

This results in no differences in binary output, helps with the ongoing
efforts to globally enable -Warray-bounds.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index a88f6af323da..9f516f796d63 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -163,19 +163,19 @@ struct mt7996_mcu_all_sta_info_event {
 	u8 rsv3[2];
 
 	union {
-		struct {
+		DECLARE_FLEX_ARRAY(struct {
 			__le16 wlan_idx;
 			u8 rsv[2];
 			__le32 tx_bytes[IEEE80211_NUM_ACS];
 			__le32 rx_bytes[IEEE80211_NUM_ACS];
-		} adm_stat[0];
+		}, adm_stat);
 
-		struct {
+		DECLARE_FLEX_ARRAY(struct {
 			__le16 wlan_idx;
 			u8 rsv[2];
 			__le32 tx_msdu_cnt;
 			__le32 rx_msdu_cnt;
-		} msdu_cnt[0];
+		}, msdu_cnt);
 	};
 } __packed;
 
-- 
2.34.1

