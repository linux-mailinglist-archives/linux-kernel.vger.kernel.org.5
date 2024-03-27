Return-Path: <linux-kernel+bounces-122044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B1188F124
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599F3B23F88
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E67153833;
	Wed, 27 Mar 2024 21:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SK7ULyYn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704B5153815;
	Wed, 27 Mar 2024 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575821; cv=none; b=J2ZD3XhLAZKnEMC4v6CQcvw5OlIxzY5KeX4yCOXkgkwmfaV7i0avpeDhV1i5bu8kxl+eEOtg0HwWGpdquIe0QYy+TxXZz76WTWFBvljbc0OKsyY6VqiGhtCBo33FeAD2GjaowJdwFr8Dm/QzrCE38hCBDilvt+KLPRNdeKD0VWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575821; c=relaxed/simple;
	bh=PSse2mxqcEYbaUCSj79+mEwcPvos9bsukayrKlgAVaU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qaEYBnDv1l2OLS5XjYAJ9lTMORbAMvbsAoL1n864qETxYkDCmU8lvHMMfTkYLm0juhPthHwbDlFVHXr9gwJjGVHq/CxoF95f1jXQ+TjjP+2HyTgvps1aATZlbgReOwvppjXLYisxcwPgb+bSM1l6CucOwvmOPAJWUIO0suS7zr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SK7ULyYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6F3C43390;
	Wed, 27 Mar 2024 21:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711575821;
	bh=PSse2mxqcEYbaUCSj79+mEwcPvos9bsukayrKlgAVaU=;
	h=Date:From:To:Cc:Subject:From;
	b=SK7ULyYnSUSpL1DcbuSq2UB9hb3NI8yisEWk7jsj+w3QAP7lP4KrIyQov3O/+nfrY
	 ANb2AWFal9Mqce/MAvFOOxIp08T5NjverE/J90XIUvoxd6cXl5OBBy52FGOawlkpPA
	 129w4dmPoYhXLcFiNuIeFxQ+qfIhBXqj0Ua2FC59tWki/cD9mAh0GzMa9BbNL5MpGJ
	 /YCp0HXlZeK6jcx1nv4EhouYcSDTr87YysGtTVx2DmjcWcwQgrFV1J2ofw46YFYRG1
	 9pTrAJHAzlqfIPzN5wP19YfckMbYifARA+qJdO34595UtgmqKZc+qy+Pv55CeNXcrm
	 xnYiohBSxZvCw==
Date: Wed, 27 Mar 2024 15:43:38 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] wifi: wil6210: wmi: Use __counted_by() in struct
 wmi_set_link_monitor_cmd and avoid -Wfamnae warning
Message-ID: <ZgSTCmdP+omePvWg@neat>
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
drivers/net/wireless/ath/wil6210/wmi.c:4018:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use __struct_size() to get the compile-time size of the flex-struct
   instance.

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZgRsn72WkHzfCUsa@neat/

 drivers/net/wireless/ath/wil6210/wmi.c | 19 +++++++------------
 drivers/net/wireless/ath/wil6210/wmi.h |  2 +-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 6fdb77d4c59e..8ff69dc72fb9 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -4014,28 +4014,23 @@ int wmi_set_cqm_rssi_config(struct wil6210_priv *wil,
 	struct net_device *ndev = wil->main_ndev;
 	struct wil6210_vif *vif = ndev_to_vif(ndev);
 	int rc;
-	struct {
-		struct wmi_set_link_monitor_cmd cmd;
-		s8 rssi_thold;
-	} __packed cmd = {
-		.cmd = {
-			.rssi_hyst = rssi_hyst,
-			.rssi_thresholds_list_size = 1,
-		},
-		.rssi_thold = rssi_thold,
-	};
 	struct {
 		struct wmi_cmd_hdr hdr;
 		struct wmi_set_link_monitor_event evt;
 	} __packed reply = {
 		.evt = {.status = WMI_FW_STATUS_FAILURE},
 	};
+	DEFINE_FLEX(struct wmi_set_link_monitor_cmd, cmd,
+		    rssi_thresholds_list, rssi_thresholds_list_size, 1);
+
+	cmd->rssi_hyst = rssi_hyst;
+	cmd->rssi_thresholds_list[0] = rssi_thold;
 
 	if (rssi_thold > S8_MAX || rssi_thold < S8_MIN || rssi_hyst > U8_MAX)
 		return -EINVAL;
 
-	rc = wmi_call(wil, WMI_SET_LINK_MONITOR_CMDID, vif->mid, &cmd,
-		      sizeof(cmd), WMI_SET_LINK_MONITOR_EVENTID,
+	rc = wmi_call(wil, WMI_SET_LINK_MONITOR_CMDID, vif->mid, cmd,
+		      __struct_size(cmd), WMI_SET_LINK_MONITOR_EVENTID,
 		      &reply, sizeof(reply), WIL_WMI_CALL_GENERAL_TO_MS);
 	if (rc) {
 		wil_err(wil, "WMI_SET_LINK_MONITOR_CMDID failed, rc %d\n", rc);
diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
index b47606d9068c..38f64524019e 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.h
+++ b/drivers/net/wireless/ath/wil6210/wmi.h
@@ -3320,7 +3320,7 @@ struct wmi_set_link_monitor_cmd {
 	u8 rssi_hyst;
 	u8 reserved[12];
 	u8 rssi_thresholds_list_size;
-	s8 rssi_thresholds_list[];
+	s8 rssi_thresholds_list[] __counted_by(rssi_thresholds_list_size);
 } __packed;
 
 /* wmi_link_monitor_event_type */
-- 
2.34.1


