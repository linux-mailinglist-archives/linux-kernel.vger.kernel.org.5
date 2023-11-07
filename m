Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D327E3CA4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjKGMS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjKGMRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:17:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11AB26A9;
        Tue,  7 Nov 2023 04:12:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFE4C43395;
        Tue,  7 Nov 2023 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359155;
        bh=cYmZsL8f0x/yljOBP/ipObqQSXEDxf1vk1TY8G4z8PU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZ9ET1w1FG3szWTOS6kkvkAMYVguI5GW50SsNyZN4msWZxsLmUeiC+V1++kZwBDwC
         S2Kzm22pLOrU2oee80jUzeMpGMMoN40rIjH5fck/XTSH75y1GDActSSxKUFQIRwPxa
         bIeNW9gye96ZDoJ3zO6nP+7a1ZOd5g2M8b4igqBiUUnc/O2xvyEbEBNuXCp+CMuXrA
         Ych/nA5LK8pkRaj0zkeyKzhIip7PSD9ZuPCVmbJW3D8K9mfqPSYxaDLH3e2I3taxpc
         Z4+uG0A+/b/ZDCn8p1myVh93CIS5Fu5pL8CY2BAk7OEaos9l8zA1Z47RHVu2IeCcK/
         dnV9IgXiUaZxA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Zong-Zhe Yang <kevin_yang@realtek.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/11] wifi: mac80211: don't return unset power in ieee80211_get_tx_power()
Date:   Tue,  7 Nov 2023 07:12:17 -0500
Message-ID: <20231107121230.3758617-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121230.3758617-1-sashal@kernel.org>
References: <20231107121230.3758617-1-sashal@kernel.org>
MIME-Version: 1.0
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

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit e160ab85166e77347d0cbe5149045cb25e83937f ]

We can get a UBSAN warning if ieee80211_get_tx_power() returns the
INT_MIN value mac80211 internally uses for "unset power level".

 UBSAN: signed-integer-overflow in net/wireless/nl80211.c:3816:5
 -2147483648 * 100 cannot be represented in type 'int'
 CPU: 0 PID: 20433 Comm: insmod Tainted: G        WC OE
 Call Trace:
  dump_stack+0x74/0x92
  ubsan_epilogue+0x9/0x50
  handle_overflow+0x8d/0xd0
  __ubsan_handle_mul_overflow+0xe/0x10
  nl80211_send_iface+0x688/0x6b0 [cfg80211]
  [...]
  cfg80211_register_wdev+0x78/0xb0 [cfg80211]
  cfg80211_netdev_notifier_call+0x200/0x620 [cfg80211]
  [...]
  ieee80211_if_add+0x60e/0x8f0 [mac80211]
  ieee80211_register_hw+0xda5/0x1170 [mac80211]

In this case, simply return an error instead, to indicate
that no data is available.

Cc: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://lore.kernel.org/r/20230203023636.4418-1-pkshih@realtek.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c6a7f1c99abc5..45bb6f2755987 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2726,6 +2726,10 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
 	else
 		*dbm = sdata->vif.bss_conf.txpower;
 
+	/* INT_MIN indicates no power level was set yet */
+	if (*dbm == INT_MIN)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.42.0

