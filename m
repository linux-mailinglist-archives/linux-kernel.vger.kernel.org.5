Return-Path: <linux-kernel+bounces-28181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC78E82FB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815D41F2863B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90440208B0;
	Tue, 16 Jan 2024 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H68tAaI7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF9162E33;
	Tue, 16 Jan 2024 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435393; cv=none; b=KUJVEmCzmjaTj0XWEylyuuBCLAt1bNDw+Ap70DoBdanyC609wc4b42+o8TjbdSiptpbH2ZRV0TMypv22fQjaS+0S1ZBsrPe4mZHBTID4FZ4KMxwtKHxbIkkymJ8E8umSUAYwY29YHRO237kTLEij5uk92KdXkAyCmdtKggsTQbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435393; c=relaxed/simple;
	bh=bL2TTO0opeE6hdG1ijW9igPA7Kj3xrx8gfgfSS3fAPM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:X-stable:X-Patchwork-Hint:X-stable-base:
	 Content-Transfer-Encoding; b=myIrUo43qw0d37arPPaM6yEq/7qq8pfAlxzlGz1nUqOXIxZbocP4caLYxYlaj2xX7aIQspr3wjKyZ15az5qJWNId1FhrgjDorlmxPUkwkAyPh0zhPzZBJMOj/x/YrKJkoGfrb8/hrbAJsASZSuxtEfiy9Q+EjS537FOrwkdS5Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H68tAaI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91370C433C7;
	Tue, 16 Jan 2024 20:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435393;
	bh=bL2TTO0opeE6hdG1ijW9igPA7Kj3xrx8gfgfSS3fAPM=;
	h=From:To:Cc:Subject:Date:From;
	b=H68tAaI7ry/wdhlzirqIx6zwbJwg2fcVmz48mc7oEcTz5WFs73QiGhabezM9bWjZV
	 BkmmQmwTnE+bZDbHlUoFdi6OfN0si9nRZrcmI5kTq/4dhBUDnWnGyhrPad9k4+bqk0
	 aqVwhifKpc0nz0OY4TBz1rOXq4OzNQPaFMqMehxTsm6do4FP1VVjrrYr7M/I4wUQbJ
	 ZNT0CYBflHY87fF5TV2bHygDg5IIquJT7VVLWDxlhv081VgqNE/WSCjSvaL7ckY2ET
	 5itEWeSWrL1hRmzLuKJYB+OtTKhs9+XTZUoAGDFAvkrikj/CRWcvSdY4Yp9XygMS5n
	 oNhg7ZJ2txoHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiji Yang <yangshiji66@outlook.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 01/31] wifi: rt2x00: restart beacon queue when hardware reset
Date: Tue, 16 Jan 2024 15:02:10 -0500
Message-ID: <20240116200310.259340-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index c3eab767bc21..f504f3529407 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -101,6 +101,7 @@ void rt2x00lib_disable_radio(struct rt2x00_dev *rt2x00dev)
 	rt2x00link_stop_tuner(rt2x00dev);
 	rt2x00queue_stop_queues(rt2x00dev);
 	rt2x00queue_flush_queues(rt2x00dev, true);
+	rt2x00queue_stop_queue(rt2x00dev->bcn);
 
 	/*
 	 * Disable radio.
@@ -1283,6 +1284,7 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 	rt2x00dev->intf_ap_count = 0;
 	rt2x00dev->intf_sta_count = 0;
 	rt2x00dev->intf_associated = 0;
+	rt2x00dev->intf_beaconing = 0;
 
 	/* Enable the radio */
 	retval = rt2x00lib_enable_radio(rt2x00dev);
@@ -1310,6 +1312,7 @@ void rt2x00lib_stop(struct rt2x00_dev *rt2x00dev)
 	rt2x00dev->intf_ap_count = 0;
 	rt2x00dev->intf_sta_count = 0;
 	rt2x00dev->intf_associated = 0;
+	rt2x00dev->intf_beaconing = 0;
 }
 
 static inline void rt2x00lib_set_if_combinations(struct rt2x00_dev *rt2x00dev)
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index beb20c5faf5f..a0fb167b58fe 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -578,6 +578,17 @@ void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
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


