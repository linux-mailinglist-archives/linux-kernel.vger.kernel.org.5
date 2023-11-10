Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440DC7E82B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjKJTYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjKJTYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:24:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3D338EB4;
        Fri, 10 Nov 2023 06:29:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA8BC433C7;
        Fri, 10 Nov 2023 14:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699626596;
        bh=nLlP5zYhWe9W91LWYdUOANl7JYKJxORxVdmkjcwH0Fs=;
        h=From:To:Cc:Subject:Date:From;
        b=qxa3WiwlZU/JYQmPYD4XnuPogZqrblGFEefjgDc/LBLt0n3SAtxDGBwMrw5zi5QeQ
         /ze1SQmOpav4e+VBgWN97fcnudCWzsL6zaqzYT+SWuUF3Q0ba7KXIhANddvQkKm2VA
         lj9rGCIVCEGuIej00dRE1LiXkyc4f5OsOeCVM44z1tUXAIVM7laGJOOrDdsnUj8iFD
         NvjlJt1XfuXm52Zu8yUdBbTZdg8xObKvFgVqPUdLyqZhv3GCTmZxIwQPRp4nXi8rfJ
         e3KAEvn6G3hX06UVnBv1maxNmFjqvVRrDhSuCPB0jNeNSdMzsDBkm8luHnTiyqWtOj
         ZK8D1eHHtqdLA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: mt7996: fix mt7996_mcu_all_sta_info_event struct packing
Date:   Fri, 10 Nov 2023 15:29:30 +0100
Message-Id: <20231110142948.3841137-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

The internal struct and union inside mt7996_mcu_all_sta_info_event is
marked as being aligned, which conflicts with it being unaligned
within that structure:

drivers/net/wireless/mediatek/mt76/mt7996/mcu.h:165:2: error: field  within 'struct mt7996_mcu_all_sta_info_event' is less aligned than 'union mt7996_mcu_all_sta_info_event::(anonymous at ../drivers/net/wireless/mediatek/mt76/mt7996/mcu.h:165:2)' and is usually due to 'struct mt7996_mcu_all_sta_info_event' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]

Mark all three as being packed as well to ensure byte packing for
the entire thing.

Fixes: adde3eed4a75 ("wifi: mt76: mt7996: Add mcu commands for getting sta tx statistic")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index a88f6af323da..e20c38f17827 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -168,15 +168,15 @@ struct mt7996_mcu_all_sta_info_event {
 			u8 rsv[2];
 			__le32 tx_bytes[IEEE80211_NUM_ACS];
 			__le32 rx_bytes[IEEE80211_NUM_ACS];
-		} adm_stat[0];
+		} adm_stat[0] __packed;
 
 		struct {
 			__le16 wlan_idx;
 			u8 rsv[2];
 			__le32 tx_msdu_cnt;
 			__le32 rx_msdu_cnt;
-		} msdu_cnt[0];
-	};
+		} msdu_cnt[0] __packed;
+	} __packed;
 } __packed;
 
 enum mt7996_chan_mib_offs {
-- 
2.39.2

