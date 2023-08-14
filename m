Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A1977B28F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjHNHdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjHNHdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5900B10EB;
        Mon, 14 Aug 2023 00:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC25E63FC5;
        Mon, 14 Aug 2023 07:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FDCC433C9;
        Mon, 14 Aug 2023 07:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691998386;
        bh=oMrRrOgkXSkt1HkEn3EB2rPFU8IDxpcIDKwVgYNNvdw=;
        h=From:To:Cc:Subject:Date:From;
        b=VTgGRjUyjEGGy0kmNfgMxIoTWJq+BK4NPhgHFu/yvZy8c5xaZE3zpFYkVzmUXCDyN
         WDxf5vFDX/nQ1fLfar3q0tRT5WlSsYDKxJ/0iBGOXWpL+ES8e6We5G3cvhEJje6YA9
         gZ+81x9QbuwKGYQgTP2wBm0E1yJ5N3+l26ArtBBkBjop4PPk7as3IcTxGC8jScuS7+
         0fmXKVMXbyZHg0//zUjHz4IaTEnLcpKKX0cL1PHiWc5JXVHAAg4r0zDaxt027FzFfR
         NYEd0ObVyUAOV0BldiJ1uzeZcFNnLGHJHicSd2Xl6gdaJ0gOgKpx5F0tBjID8Hp610
         huK5qhIA5P2XQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Aloka Dixit <quic_alokad@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        Karthik M <quic_karm@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] wireless: ath: remove unused-but-set parameter
Date:   Mon, 14 Aug 2023 09:32:23 +0200
Message-Id: <20230814073255.1065242-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This has never been used since the driver was merged, but it now causes
a W=1 warning in recent clang versions

drivers/net/wireless/ath/ath9k/main.c:1566:21: error: parameter 'changed_flags' set but not used [-Werror,-Wunused-but-set-parameter]
drivers/net/wireless/ath/ath9k/htc_drv_main.c:1258:25: error: parameter 'changed_flags' set but not used [-Werror,-Wunused-but-set-parameter]
drivers/net/wireless/ath/ath5k/mac80211-ops.c:367:62: error: parameter 'changed_flags' set but not used [-Werror,-Wunused-but-set-parameter]

Remove the bit manipulation on the otherwise unused parameter.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/ath/ath12k/mac.c         | 5 ++---
 drivers/net/wireless/ath/ath5k/mac80211-ops.c | 1 -
 drivers/net/wireless/ath/ath9k/htc_drv_main.c | 1 -
 drivers/net/wireless/ath/ath9k/main.c         | 1 -
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 91453624fd842..354ed66e6d13b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5666,7 +5666,6 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 
 	mutex_lock(&ar->conf_mutex);
 
-	changed_flags &= SUPPORTED_FILTERS;
 	*total_flags &= SUPPORTED_FILTERS;
 	ar->filter_flags = *total_flags;
 
@@ -5684,8 +5683,8 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 			    "fail to set monitor filter: %d\n", ret);
 	}
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
-		   "changed_flags:0x%x, total_flags:0x%x, reset_flag:%d\n",
-		   changed_flags, *total_flags, reset_flag);
+		   "total_flags:0x%x, reset_flag:%d\n",
+		   *total_flags, reset_flag);
 
 	mutex_unlock(&ar->conf_mutex);
 }
diff --git a/drivers/net/wireless/ath/ath5k/mac80211-ops.c b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
index 11ed30d6b595a..c630343ca4f9b 100644
--- a/drivers/net/wireless/ath/ath5k/mac80211-ops.c
+++ b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
@@ -382,7 +382,6 @@ ath5k_configure_filter(struct ieee80211_hw *hw, unsigned int changed_flags,
 	mfilt[1] = multicast >> 32;
 
 	/* Only deal with supported flags */
-	changed_flags &= SUPPORTED_FIF_FLAGS;
 	*new_flags &= SUPPORTED_FIF_FLAGS;
 
 	/* If HW detects any phy or radar errors, leave those filters on.
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 51766de5ec3b6..6eeaa9011a168 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -1264,7 +1264,6 @@ static void ath9k_htc_configure_filter(struct ieee80211_hw *hw,
 	u32 rfilt;
 
 	mutex_lock(&priv->mutex);
-	changed_flags &= SUPPORTED_FILTERS;
 	*total_flags &= SUPPORTED_FILTERS;
 
 	if (test_bit(ATH_OP_INVALID, &common->op_flags)) {
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 6360d3356e256..1494feedb27db 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1571,7 +1571,6 @@ static void ath9k_configure_filter(struct ieee80211_hw *hw,
 	struct ath_chanctx *ctx;
 	u32 rfilt;
 
-	changed_flags &= SUPPORTED_FILTERS;
 	*total_flags &= SUPPORTED_FILTERS;
 
 	spin_lock_bh(&sc->chan_lock);
-- 
2.39.2

