Return-Path: <linux-kernel+bounces-121852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2C388EE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D89FB209EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B791C1509AA;
	Wed, 27 Mar 2024 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlbUqpRC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087A12A144;
	Wed, 27 Mar 2024 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565456; cv=none; b=PLVhESmaZnBS+5k5lePMyoN5X73x2tYeQBUcutPt66S6zj21x2VWbZ3GjjNVB+jNCFJGj9TeUNQlqTA5G2yQFTI3F6CAZJAZZ9eUTN4fSioQebZE3HN2bCenlSnI5qHaKQZBfE1uWOPIAlSPXk6WaENG2gZJeOIw10vVgD/yB0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565456; c=relaxed/simple;
	bh=qpmpb6mRaGuhJK5sjkD5qbyw9yG7+XNJ/p3wzxWXdp4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pez9bN5cyhtTzrUUSeWQuRfnVhbAOGpgZFybg9HSi258IjDgc62RbiBA0t1C1RiekjPgkurKv2X5ZYFiipYCLGC0Y12wvMqlRM/rRd8hoMG12ddDxOuJJRJevfK6fw6ppD/fVOsAYL4wLcyyofcjbCqPc+NyNHChNk1Jxtc1LXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlbUqpRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03846C433F1;
	Wed, 27 Mar 2024 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711565455;
	bh=qpmpb6mRaGuhJK5sjkD5qbyw9yG7+XNJ/p3wzxWXdp4=;
	h=Date:From:To:Cc:Subject:From;
	b=JlbUqpRCa0HYhHCaPC01tZxS1z3riWCuuqj0Gj5voTcCiRcnkO6npEAZhB5cYr16S
	 ZN5CvTgdrZ3sy35aJ/dPqwZ259M5fRAVol3IH5FabkQvuksxwks99Un/DpNB8SpNTk
	 BJE3iQwA1wK6GaLB+he1Z+SeoKNqKjrbrKkV0ziANrof44oTWv1mABDVwn6c3A5+H2
	 li/AInDIe0O20xgfbu4L6hA/HABidjyxvJktEZ5kJ4EQuMwoZmMVAkh303x0jzvGeU
	 ROwCTJiB7e3qYiTD1XACxAG/tpWBEUprWf9t1VyKWrz2IXOe5f/HEcUqKWFUatyyVh
	 22TDrIykc0wAg==
Date: Wed, 27 Mar 2024 12:50:52 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: cfg80211: Use __counted_by() in struct
 wmi_start_scan_cmd and avoid -Wfamnae warning
Message-ID: <ZgRqjGShTl3y5FFB@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare for the coming implementation by GCC and Clang of the
__counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time
via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
(for strcpy/memcpy-family functions).

Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
getting ready to enable it globally.

So, use the `DEFINE_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:
drivers/net/wireless/ath/wil6210/cfg80211.c:896:43: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c | 22 ++++++++++-----------
 drivers/net/wireless/ath/wil6210/wmi.h      |  2 +-
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index dbe4b3478f03..836b49954171 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -892,10 +892,8 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
 	struct wireless_dev *wdev = request->wdev;
 	struct wil6210_vif *vif = wdev_to_vif(wil, wdev);
-	struct {
-		struct wmi_start_scan_cmd cmd;
-		u16 chnl[4];
-	} __packed cmd;
+	DEFINE_FLEX(struct wmi_start_scan_cmd, cmd,
+		    channel_list, num_channels, 4);
 	uint i, n;
 	int rc;
 
@@ -977,9 +975,9 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
 	vif->scan_request = request;
 	mod_timer(&vif->scan_timer, jiffies + WIL6210_SCAN_TO);
 
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.cmd.scan_type = WMI_ACTIVE_SCAN;
-	cmd.cmd.num_channels = 0;
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->scan_type = WMI_ACTIVE_SCAN;
+	cmd->num_channels = 0;
 	n = min(request->n_channels, 4U);
 	for (i = 0; i < n; i++) {
 		int ch = request->channels[i]->hw_value;
@@ -991,7 +989,8 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
 			continue;
 		}
 		/* 0-based channel indexes */
-		cmd.cmd.channel_list[cmd.cmd.num_channels++].channel = ch - 1;
+		cmd->num_channels++;
+		cmd->channel_list[cmd->num_channels - 1].channel = ch - 1;
 		wil_dbg_misc(wil, "Scan for ch %d  : %d MHz\n", ch,
 			     request->channels[i]->center_freq);
 	}
@@ -1007,16 +1006,15 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
 	if (rc)
 		goto out_restore;
 
-	if (wil->discovery_mode && cmd.cmd.scan_type == WMI_ACTIVE_SCAN) {
-		cmd.cmd.discovery_mode = 1;
+	if (wil->discovery_mode && cmd->scan_type == WMI_ACTIVE_SCAN) {
+		cmd->discovery_mode = 1;
 		wil_dbg_misc(wil, "active scan with discovery_mode=1\n");
 	}
 
 	if (vif->mid == 0)
 		wil->radio_wdev = wdev;
 	rc = wmi_send(wil, WMI_START_SCAN_CMDID, vif->mid,
-		      &cmd, sizeof(cmd.cmd) +
-		      cmd.cmd.num_channels * sizeof(cmd.cmd.channel_list[0]));
+		      cmd, struct_size(cmd, channel_list, cmd->num_channels));
 
 out_restore:
 	if (rc) {
diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
index 71bf2ae27a98..b47606d9068c 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.h
+++ b/drivers/net/wireless/ath/wil6210/wmi.h
@@ -474,7 +474,7 @@ struct wmi_start_scan_cmd {
 	struct {
 		u8 channel;
 		u8 reserved;
-	} channel_list[];
+	} channel_list[] __counted_by(num_channels);
 } __packed;
 
 #define WMI_MAX_PNO_SSID_NUM	(16)
-- 
2.34.1


