Return-Path: <linux-kernel+bounces-122024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8702688F0EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27306B20EED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B415358B;
	Wed, 27 Mar 2024 21:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXdDYTfS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1DB131E4F;
	Wed, 27 Mar 2024 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575040; cv=none; b=YRI45Aclxgn1d0OzIipZwhVBhVtHjiyre0vs/xMiVVXVG7osVtDuBeCiUD/8Lsq0gaXGZghbjVcfeVhVYAGuIAGrHzCI/5lSrwesi1wHF+r2psxKJ+wQiak0ylzX2tT8/c4Z46ls14GMNp1LEHNkL4nj2uwfOlGWypDndSxpFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575040; c=relaxed/simple;
	bh=ypAjf9tfLt0HgUbUSI8OPc5348AAdmlvPUdNZeWiYxU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YXlfvB/gYHHvXdmEQuYQ787X5ELaOMZkxEgfZQ6qSCcDY3qSpvj99hcem8sJqM+u/4Y6BWJspxzgK4//cKRyBAGJdaVQ8c2yMhn6NQNtd24fNBO6ibF4JUIe1Jx+af+WhxIBYvvtI7ujzpyCKFes4pWK381WduNa8L4PwHYBnIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXdDYTfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F5FC433F1;
	Wed, 27 Mar 2024 21:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711575039;
	bh=ypAjf9tfLt0HgUbUSI8OPc5348AAdmlvPUdNZeWiYxU=;
	h=Date:From:To:Cc:Subject:From;
	b=EXdDYTfSHHtqS1sBIZX2opyAzUCrur1QFMKXNVGuk1Z8sCKr+rZXG3PutBkGZwXtl
	 9Th3OmqadPwFS2ygS+k5vTXzTjIuMWjTLq0WiQ6Mue6OX/9Qoz8l2UsKPUB6OvThs9
	 bJ+y1wTMsSdfnCOxtjp7+YysWZaoLaO11TJGmRC2XXf8ZjNWzirxC8R0HGJmIqccez
	 OEBn07fT/HzTPQorrympn8riRAMZEK0ZurWAmOw/TZEh3r/inD68c5T9M7cPRGAkDB
	 QOuMlmvFs0447IvZBxMyc3zdM9Jml8JR/DDa05Cy/WdJ0NHF0BhbXMajLWHBgZEIcN
	 uxCVYPrYHKhNQ==
Date: Wed, 27 Mar 2024 15:30:36 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] wifi: wil6210: cfg80211: Use __counted_by() in
 struct wmi_start_scan_cmd and avoid some -Wfamnae warnings
Message-ID: <ZgSP/CMSVfr68R2u@neat>
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
Changes in v2:
 - Remove redundant memset(). (Jeff Johnson)
 - Update Subject line: add missing wil6210: (Kalle Valo)

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZgRqjGShTl3y5FFB@neat/

 drivers/net/wireless/ath/wil6210/cfg80211.c | 21 +++++++++------------
 drivers/net/wireless/ath/wil6210/wmi.h      |  2 +-
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index dbe4b3478f03..99f7f4db48fc 100644
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
 
@@ -977,9 +975,8 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
 	vif->scan_request = request;
 	mod_timer(&vif->scan_timer, jiffies + WIL6210_SCAN_TO);
 
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.cmd.scan_type = WMI_ACTIVE_SCAN;
-	cmd.cmd.num_channels = 0;
+	cmd->scan_type = WMI_ACTIVE_SCAN;
+	cmd->num_channels = 0;
 	n = min(request->n_channels, 4U);
 	for (i = 0; i < n; i++) {
 		int ch = request->channels[i]->hw_value;
@@ -991,7 +988,8 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
 			continue;
 		}
 		/* 0-based channel indexes */
-		cmd.cmd.channel_list[cmd.cmd.num_channels++].channel = ch - 1;
+		cmd->num_channels++;
+		cmd->channel_list[cmd->num_channels - 1].channel = ch - 1;
 		wil_dbg_misc(wil, "Scan for ch %d  : %d MHz\n", ch,
 			     request->channels[i]->center_freq);
 	}
@@ -1007,16 +1005,15 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
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


