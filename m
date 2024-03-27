Return-Path: <linux-kernel+bounces-121870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD5C88EEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4544029E34B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A3A1514C5;
	Wed, 27 Mar 2024 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9g2nfQj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9973914E2CB;
	Wed, 27 Mar 2024 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565986; cv=none; b=OAOIaFLWhhC6o85rJD6Wv1+g+GsdMMuO18+K0yukcVeaYxXZ+W4R+SZHaHkBZJP5F2KqioPfiD1N16byngfB7RXvJPoVPFY/inScPLwdGspUzBf0c/ieQJUMl+Vu5fXdJWJ6vtc+u1Q34KrJ77i+jIWMj4dMtSrgnWXG9NRaR98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565986; c=relaxed/simple;
	bh=cXrwspHU/V3K7TasxHTuJGZaWysuCjg28RanyamMKIo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qyn710ZW59CFrMt+8hIcri9Fe8JY+3e4lF9BhOibUmcZXSRHGFa6Oi22O+DqTsA+6OaWiYDic3lfdFhL/h+PRifoXm6HoTZwya3ie/WXkUFYmc/2J0cuw1sECcefVnmPgS3n2ECt5939JUKgmUwyqx8lblgJ+kdZ1JZV5/YyuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9g2nfQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8220C433F1;
	Wed, 27 Mar 2024 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711565986;
	bh=cXrwspHU/V3K7TasxHTuJGZaWysuCjg28RanyamMKIo=;
	h=Date:From:To:Cc:Subject:From;
	b=m9g2nfQj70CkWHkSnTxGX2mPs71CmEF2LQKeyyxu6J3k8h3YnDcPM4vUvPRk2syMI
	 O3RBJW7aWbXkYTpbh3WeKc6pwP4e+1PzfaK4/rlCduY1q6Ew97Vd1NwtoN2rWVLrvl
	 Qlm8OyJyFQV5hYl6rBh3Ey3KHGut5KHEZ2Ol6AeKnejLOweH8wJMv6tqCBetaIuN4J
	 a5ZpEiQyJ63Fygy2Qy2s6dSwA920KX1zGj114u6VdRou7BcS7cWyZBJS/tVHS77YPZ
	 kXjZrLteebLhUqzwOL7vQN40VjhnKB2IqdEs7/ZZBzhvRuZ6y0cQkz62iB1FgH/qIV
	 TuUf5tdqVjtjw==
Date: Wed, 27 Mar 2024 12:59:43 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: wil6210: wmi: Use __counted_by() in struct
 wmi_set_link_monitor_cmd and avoid -Wfamnae warning
Message-ID: <ZgRsn72WkHzfCUsa@neat>
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
 drivers/net/wireless/ath/wil6210/wmi.c | 19 +++++++------------
 drivers/net/wireless/ath/wil6210/wmi.h |  2 +-
 2 files changed, 8 insertions(+), 13 deletions(-)

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


