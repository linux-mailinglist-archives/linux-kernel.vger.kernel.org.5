Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336C27E3BAD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbjKGMIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjKGMIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:08:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B212510D3;
        Tue,  7 Nov 2023 04:07:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F1FC433C8;
        Tue,  7 Nov 2023 12:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358870;
        bh=6gwu+odNl+aqXisUwCqknnGvlBvMjl2uK0UlmaVeAC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJwE9g/HIPygxZg50mV5Fqq6cOy+Bx0G4J+uABsZwZelt+euU1n9YP4Fk504FCjsK
         cqJ1MpLn0IHrJ2rha63NhQmRwA/Eh4MHDIgPP1z4UQG6FAGSD95MHPF8Uf+yt3rh87
         jYuRPUGrRb6SqXlMq7XNPYMzoXFxzMdRZS5273LBQPxlkP4uldDWNIiuGbTzQ4/C0V
         mOiD5BsnP7ivniQZD8YeK56MoEV3xY3Rp7ilrb/18x1uVeM9ltp3Fasqn4fbgNE2IK
         u+aBy66XQCbuVfecyojJ0A4Hox6pC0vA56g88dceT8xAxod4xcWZii4bkTcKqf8GNp
         jVX0LQGSUsIeA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>, lorenzo@kernel.org,
        ryder.lee@mediatek.com, kvalo@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, nathan@kernel.org,
        ndesaulniers@google.com, shayne.chen@mediatek.com,
        chui-hao.chiu@mediatek.com, howard-yh.hsu@mediatek.com,
        rany_hany@riseup.net, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 14/31] wifi: mt76: fix clang-specific fortify warnings
Date:   Tue,  7 Nov 2023 07:06:01 -0500
Message-ID: <20231107120704.3756327-14-sashal@kernel.org>
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

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 03f0e11da7fb26db4f27e6b83a223512db9f7ca5 ]

When compiling with clang 16.0.6 and CONFIG_FORTIFY_SOURCE=y, I've
noticed the following (somewhat confusing due to absence of an actual
source code location):

In file included from drivers/net/wireless/mediatek/mt76/mt792x_core.c:4:
In file included from ./include/linux/module.h:13:
In file included from ./include/linux/stat.h:19:
In file included from ./include/linux/time.h:60:
In file included from ./include/linux/time32.h:13:
In file included from ./include/linux/timex.h:67:
In file included from ./arch/x86/include/asm/timex.h:5:
In file included from ./arch/x86/include/asm/processor.h:23:
In file included from ./arch/x86/include/asm/msr.h:11:
In file included from ./arch/x86/include/asm/cpumask.h:5:
In file included from ./include/linux/cpumask.h:12:
In file included from ./include/linux/bitmap.h:11:
In file included from ./include/linux/string.h:254:
./include/linux/fortify-string.h:592:4: warning: call to '__read_overflow2_field'
declared with 'warning' attribute: detected read beyond size of field (2nd
parameter); maybe use struct_group()? [-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);

In file included from drivers/net/wireless/mediatek/mt76/mt7915/main.c:4:
In file included from ./include/linux/etherdevice.h:20:
In file included from ./include/linux/if_ether.h:19:
In file included from ./include/linux/skbuff.h:15:
In file included from ./include/linux/time.h:60:
In file included from ./include/linux/time32.h:13:
In file included from ./include/linux/timex.h:67:
In file included from ./arch/x86/include/asm/timex.h:5:
In file included from ./arch/x86/include/asm/processor.h:23:
In file included from ./arch/x86/include/asm/msr.h:11:
In file included from ./arch/x86/include/asm/cpumask.h:5:
In file included from ./include/linux/cpumask.h:12:
In file included from ./include/linux/bitmap.h:11:
In file included from ./include/linux/string.h:254:
./include/linux/fortify-string.h:592:4: warning: call to '__read_overflow2_field'
declared with 'warning' attribute: detected read beyond size of field (2nd
parameter); maybe use struct_group()? [-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);

In file included from drivers/net/wireless/mediatek/mt76/mt7996/main.c:6:
In file included from drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h:9:
In file included from ./include/linux/interrupt.h:8:
In file included from ./include/linux/cpumask.h:12:
In file included from ./include/linux/bitmap.h:11:
In file included from ./include/linux/string.h:254:
./include/linux/fortify-string.h:592:4: warning: call to '__read_overflow2_field'
declared with 'warning' attribute: detected read beyond size of field (2nd
parameter); maybe use struct_group()? [-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);

The compiler actually complains on 'mt7915_get_et_strings()',
'mt792x_get_et_strings()' and 'mt7996_get_et_strings()' due to the same
reason: fortification logic inteprets call to 'memcpy()' as an attempt
to copy the whole array from its first member and so issues an overread
warning. These warnings may be silenced by passing an address of the whole
array and not the first member to 'memcpy()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 8ebbf186fab23..53348dd80c3b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1386,7 +1386,7 @@ void mt7915_get_et_strings(struct ieee80211_hw *hw,
 	if (sset != ETH_SS_STATS)
 		return;
 
-	memcpy(data, *mt7915_gstrings_stats, sizeof(mt7915_gstrings_stats));
+	memcpy(data, mt7915_gstrings_stats, sizeof(mt7915_gstrings_stats));
 	data += sizeof(mt7915_gstrings_stats);
 	page_pool_ethtool_stats_get_strings(data);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 46be7f996c7e1..81f316ddc1115 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -358,7 +358,7 @@ void mt792x_get_et_strings(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (sset != ETH_SS_STATS)
 		return;
 
-	memcpy(data, *mt792x_gstrings_stats, sizeof(mt792x_gstrings_stats));
+	memcpy(data, mt792x_gstrings_stats, sizeof(mt792x_gstrings_stats));
 
 	data += sizeof(mt792x_gstrings_stats);
 	page_pool_ethtool_stats_get_strings(data);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index c3a479dc3f533..2405ec1a663fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1192,7 +1192,7 @@ void mt7996_get_et_strings(struct ieee80211_hw *hw,
 			   u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *mt7996_gstrings_stats,
+		memcpy(data, mt7996_gstrings_stats,
 		       sizeof(mt7996_gstrings_stats));
 }
 
-- 
2.42.0

