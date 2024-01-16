Return-Path: <linux-kernel+bounces-27909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B4A82F7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3059E2882EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAFC22631;
	Tue, 16 Jan 2024 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql+LeEAl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2F225DF;
	Tue, 16 Jan 2024 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434553; cv=none; b=IfbIMnbXSZ/o+WeC4Y+vG/fGo08gxtHSVOKCBdERnNqYCSY9E4RhFK+Gb0xwGswpHNQic+4ZmJC7Va5Sv+fvXzy3+ggzBFOT/vrA4ryzWlPa6ZmyQhu9yBvHy98fKqxZgCj0IV3Fx9AwqHoHZpxfV5M6OhoVCfjoFXpIE+COUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434553; c=relaxed/simple;
	bh=RBuW1qtIP+8yR6BzG/iV6Mdofn4HV5LNk6kOhd0NS4Y=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=qzQUgJdt6TOHBDBZsx7UwimxF1SWtY8yTuQt3r9nTkcCUx+UqcbIOZTzps0PTWhNYlShGd5RVPe5xF0rv+dRmgpflh+9FZGJuJKUxBhfUfnpL35/dPoD5B6aIvM05FbqRgb6oNfmxAEjF5EFvHFcU2tcMzUvyDHXD2FblT0c8VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql+LeEAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770ADC433F1;
	Tue, 16 Jan 2024 19:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434553;
	bh=RBuW1qtIP+8yR6BzG/iV6Mdofn4HV5LNk6kOhd0NS4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ql+LeEAlWPUqQnrjZXM3AiaG0cFwpDW08eLSLYlFxqeZSU0CmlXwyO+hm0uNO7XVG
	 9bMcFhYUE0qXopbj3Ses7P2YpiwLxb+Rt9n/2E/7fM32JSQa75xSLeUwQAFC9hn1Bg
	 KbLSi9m8CBufLchInz/NSzQDrkHiTLuivjSJOv8gDs136I51ZEKGw4j6IDSn182ytA
	 o7Uen3MttxPJWsno3BQTRGU7pCk3RE2mPL0B8ONRsxfC/dK9vr+PcfIpHPWJ4/BTzc
	 g8N1HRhQitVEBLtlRzxjEAmtua4kxPdZIqnTZymMdUSHw+HToRSDni9ms7h0HNtJ8/
	 uWnpU9sUeKUCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiji Yang <yangshiji66@outlook.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 002/104] wifi: rt2x00: restart beacon queue when hardware reset
Date: Tue, 16 Jan 2024 14:45:28 -0500
Message-ID: <20240116194908.253437-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Shiji Yang <yangshiji66@outlook.com>

[ Upstream commit a11d965a218f0cd95b13fe44d0bcd8a20ce134a8 ]

When a hardware reset is triggered, all registers are reset, so all
queues are forced to stop in hardware interface. However, mac80211
will not automatically stop the queue. If we don't manually stop the
beacon queue, the queue will be deadlocked and unable to start again.
This patch fixes the issue where Apple devices cannot connect to the
AP after calling ieee80211_restart_hw().

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/TYAP286MB031530EB6D98DCE4DF20766CBCA4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c |  3 +++
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 9a9cfd0ce402..00b945053e19 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -101,6 +101,7 @@ void rt2x00lib_disable_radio(struct rt2x00_dev *rt2x00dev)
 	rt2x00link_stop_tuner(rt2x00dev);
 	rt2x00queue_stop_queues(rt2x00dev);
 	rt2x00queue_flush_queues(rt2x00dev, true);
+	rt2x00queue_stop_queue(rt2x00dev->bcn);
 
 	/*
 	 * Disable radio.
@@ -1286,6 +1287,7 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 	rt2x00dev->intf_ap_count = 0;
 	rt2x00dev->intf_sta_count = 0;
 	rt2x00dev->intf_associated = 0;
+	rt2x00dev->intf_beaconing = 0;
 
 	/* Enable the radio */
 	retval = rt2x00lib_enable_radio(rt2x00dev);
@@ -1312,6 +1314,7 @@ void rt2x00lib_stop(struct rt2x00_dev *rt2x00dev)
 	rt2x00dev->intf_ap_count = 0;
 	rt2x00dev->intf_sta_count = 0;
 	rt2x00dev->intf_associated = 0;
+	rt2x00dev->intf_beaconing = 0;
 }
 
 static inline void rt2x00lib_set_if_combinations(struct rt2x00_dev *rt2x00dev)
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index 4202c6517783..75fda72c14ca 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -598,6 +598,17 @@ void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
 	 */
 	if (changes & BSS_CHANGED_BEACON_ENABLED) {
 		mutex_lock(&intf->beacon_skb_mutex);
+
+		/*
+		 * Clear the 'enable_beacon' flag and clear beacon because
+		 * the beacon queue has been stopped after hardware reset.
+		 */
+		if (test_bit(DEVICE_STATE_RESET, &rt2x00dev->flags) &&
+		    intf->enable_beacon) {
+			intf->enable_beacon = false;
+			rt2x00queue_clear_beacon(rt2x00dev, vif);
+		}
+
 		if (!bss_conf->enable_beacon && intf->enable_beacon) {
 			rt2x00dev->intf_beaconing--;
 			intf->enable_beacon = false;
-- 
2.43.0


