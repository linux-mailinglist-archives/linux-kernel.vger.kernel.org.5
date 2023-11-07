Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2117E3CAD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbjKGMSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbjKGMRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:17:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EEA49DF;
        Tue,  7 Nov 2023 04:12:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EA1C433CC;
        Tue,  7 Nov 2023 12:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359158;
        bh=pTtMVMf5yz+QF+lficp01mw9DSUcGqK1R83bMxhYSUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=txROMMVolM5Plc4jJR5gK86iRxCPz366aUa+/ZNLjSUTyeXBIP5dk8I1Kd3yyOl+F
         VJUxbL9QzChSPEPn8SJIflof1U1Xdw3EAISFWDPdzk2wZVdEvzn5XCj8AyLjRsn4af
         uz7yEvi9XWSur5v3gsl2EvrPRXDpk89hfyPaV+FMicAxyvhTiPuk+G2w3t1YIX/CK1
         QC9OUUiRlNgFSSYhqIi+i1yNgchgkwx7gEIEkxLoTxve7DTMvOwK8lV7L15z+NSayb
         8ewShaeCSjSre45bFvy2T9T0ME+QqTV4eu4+2WvXQs25sKMbo9ji+RGW15kfnVJ8JU
         F33u1YiBfEEtw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-wireless@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 04/11] wifi: ath9k: fix clang-specific fortify warnings
Date:   Tue,  7 Nov 2023 07:12:19 -0500
Message-ID: <20231107121230.3758617-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121230.3758617-1-sashal@kernel.org>
References: <20231107121230.3758617-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
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

[ Upstream commit 95f97fe0ac974467ab4da215985a32b2fdf48af0 ]

When compiling with clang 16.0.6 and CONFIG_FORTIFY_SOURCE=y, I've
noticed the following (somewhat confusing due to absence of an actual
source code location):

In file included from drivers/net/wireless/ath/ath9k/debug.c:17:
In file included from ./include/linux/slab.h:16:
In file included from ./include/linux/gfp.h:7:
In file included from ./include/linux/mmzone.h:8:
In file included from ./include/linux/spinlock.h:56:
In file included from ./include/linux/preempt.h:79:
In file included from ./arch/x86/include/asm/preempt.h:9:
In file included from ./include/linux/thread_info.h:60:
In file included from ./arch/x86/include/asm/thread_info.h:53:
In file included from ./arch/x86/include/asm/cpufeature.h:5:
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

In file included from drivers/net/wireless/ath/ath9k/htc_drv_debug.c:17:
In file included from drivers/net/wireless/ath/ath9k/htc.h:20:
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

The compiler actually complains on 'ath9k_get_et_strings()' and
'ath9k_htc_get_et_strings()' due to the same reason: fortification logic
inteprets call to 'memcpy()' as an attempt to copy the whole array from
it's first member and so issues an overread warning. These warnings may
be silenced by passing an address of the whole array and not the first
member to 'memcpy()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230829093856.234584-1-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/debug.c         | 2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index 859a865c59950..8d98347e0ddff 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -1284,7 +1284,7 @@ void ath9k_get_et_strings(struct ieee80211_hw *hw,
 			  u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *ath9k_gstrings_stats,
+		memcpy(data, ath9k_gstrings_stats,
 		       sizeof(ath9k_gstrings_stats));
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index c55aab01fff5d..e79bbcd3279af 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -428,7 +428,7 @@ void ath9k_htc_get_et_strings(struct ieee80211_hw *hw,
 			      u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *ath9k_htc_gstrings_stats,
+		memcpy(data, ath9k_htc_gstrings_stats,
 		       sizeof(ath9k_htc_gstrings_stats));
 }
 
-- 
2.42.0

