Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F987E3F5E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjKGM46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbjKGM4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:56:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA134C17;
        Tue,  7 Nov 2023 04:13:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88695C433CD;
        Tue,  7 Nov 2023 12:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359180;
        bh=hcB/HlXH/JmzLDhh5gcECvx78cB7rLc/o4shKSOUy+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9v41jATOklwl9xk2Nv8yqCP2Y94WXYYhUhOTRL161vRtafa/Sxfc0a7AWa6VXeSc
         LMVDZwM4gmf3dLb8rrTxRob090OK/Lz/Z3J43ZYFpackiVRPAV+R+PR2Fpb5jc7YfR
         uynt42+71wT11IXqh7kr/w9Yh/YHWEZpBVDMS31O7bd6E60UljypMFev8GT1dgNrMV
         Jrn2+HE790bGDG6nZ0oRbigsXqXsAs2CJkK4EROyFQ2qAVmOb3k4tcVBH9XxlwsJqZ
         lqx6wUZNuPm8UXUos+ki2tzvJRQ/AqnKwN9oRUShF2BhhO2YgWxCvRRT4bOQSLb+sL
         l9yz4XY1MCt0g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Zong-Zhe Yang <kevin_yang@realtek.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/9] wifi: mac80211: don't return unset power in ieee80211_get_tx_power()
Date:   Tue,  7 Nov 2023 07:12:45 -0500
Message-ID: <20231107121256.3758858-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121256.3758858-1-sashal@kernel.org>
References: <20231107121256.3758858-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
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
index 9e3bff5aaf8b8..6428c0d371458 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2581,6 +2581,10 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
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

