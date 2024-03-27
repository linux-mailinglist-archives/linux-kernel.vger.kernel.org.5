Return-Path: <linux-kernel+bounces-120217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830FB88D48E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239291F300FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D43A219E1;
	Wed, 27 Mar 2024 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYoJy9vw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3444420B0F;
	Wed, 27 Mar 2024 02:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506595; cv=none; b=HmODh4xTuhjLCX5s6mrkgODPXXygsJe98uRe9LB4GOxcie4WNxJunRDy4CKq/zdzylb4AztoBXKkVtj9DAsh5q9+iVz0gdAldb3/nW7ZO7LuiGEKPlHM5ex0+LPXo7kYEUrlygicYeqLgzufF193KGV+WoFh9/mN37g0VQipoO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506595; c=relaxed/simple;
	bh=iGtT6jSeuSKi2wZy+guCtvd6Kk3jk1aGH4lQCxNk5nk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EOGxgWu9W8kjVfHxEtmp01BQGUvM3317KxtF6BTyfYiENGUPfr2Pyb5fkk44g06tOiEkovxFWzznbgwazkhdZwhhRq3rN4mgRW4BE3qfU0/HC5/JYtoSbUs4ld9t0SxIBsNQdAS81Spcsr/FsGGaBjs9t6GCbDsCPBMQ4GKSIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYoJy9vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A566C433C7;
	Wed, 27 Mar 2024 02:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711506594;
	bh=iGtT6jSeuSKi2wZy+guCtvd6Kk3jk1aGH4lQCxNk5nk=;
	h=Date:From:To:Cc:Subject:From;
	b=QYoJy9vwN2OcLc9T/LrDxZy2Jc1KRy/Maoi5ufvzLgU8JPYZnJJsczxIn3iF98Cwz
	 ZmT+WTbD4SKQtKs0fqKy4sjdBN6kQssLg8ywj3W+XFbWoaB0gLMgjVu8E/IBX5kGzi
	 cYbGOmE80CNzUHKZAHaBDN8cfAkDYhFJF9tWy5+gvch6OEOV0hfxVDRDb1bOWmTDXw
	 eJYlBy//mDp9D+Ft6q73VHr1qYWd65h77z0XL5Ju5d1BzEqfLbiV+r3kgPsMCaLu9f
	 dCod5ALAEOvMjujfGGACgZyleAoXmnImNDOJJMNiwFIqdR7+/oGGepvx1NZSUXOGMb
	 xca7PUapcB31A==
Date: Tue, 26 Mar 2024 20:29:52 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: wil6210: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <ZgOEoCWguq3n1OqQ@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use the `DEFINE_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:
drivers/net/wireless/ath/wil6210/wmi.c:4018:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 6fdb77d4c59e..cc0ad70f0d01 100644
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
+		      sizeof(*cmd), WMI_SET_LINK_MONITOR_EVENTID,
 		      &reply, sizeof(reply), WIL_WMI_CALL_GENERAL_TO_MS);
 	if (rc) {
 		wil_err(wil, "WMI_SET_LINK_MONITOR_CMDID failed, rc %d\n", rc);
-- 
2.34.1


