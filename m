Return-Path: <linux-kernel+bounces-121712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1139988ECD7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4293C1C2813D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781AA14E2D8;
	Wed, 27 Mar 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab/XZ32i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D7142E9E;
	Wed, 27 Mar 2024 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561421; cv=none; b=fTn3SLGLrgP9kkvnBWMEI73+uq6+cvdjOvPHnsdghQzXqEcuyGsjlGVBMVkbWoUxiD2mATGf7Vk6cq1as9FXq7LDgYm/ztrBGOAEOfl5MCOPYpiZMqHkT2VlyFxjWzWqf+5QvEGu/37t2EsCmi7wq9RzEGSFRXQP/9rxrio+kmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561421; c=relaxed/simple;
	bh=ZyctGTIpRZDmHcL8VpKW/j9XRl6gQ/zGsuOghb9KmJs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KyTodRAV4nNw/rmsVwc6EWHJ/NBSUdtvqKgSYSvQgrVgIivEdi4v3ZAK/BHZrYgFfAJpZyDpxMPeIIeQfbkbpHcG6m5J0bQC0jtNgWhaZ3SRFhmJPfQMHCScw+mKyjJmVlh5klkTP/oar52BnMQhL5n24tFzQRFyoNrI4xe9pu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab/XZ32i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5A1C433F1;
	Wed, 27 Mar 2024 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711561421;
	bh=ZyctGTIpRZDmHcL8VpKW/j9XRl6gQ/zGsuOghb9KmJs=;
	h=Date:From:To:Cc:Subject:From;
	b=ab/XZ32iXTl0u1mXUWGif3sqrvLxqybsTviiEHPNiDpBFmr7r6EG5/eZ55xD0pa9i
	 1+/oE+cZT2FSLsy6uUdfW9OIRZEktL/0WwyOaPO4E/L3Z//Rhc6KIBKDFXqiyAAXDX
	 wiwa6SheazC98VXvZbv3qrPTOqw0xfJKnLxwQN1ZUbaFE7l6HbHkhBTaBW01Z3ERlI
	 MhA6SFNvAsOplmDFWCR4HYovh9u5EmHmcIuXCEd7xVbnlkBtScMLYluLhQSaTCpGai
	 wiJuO0Ewv/CdHGmHhXZM405AWdQUBUSqmP1pnu/xiqjtAbSTBw3jla0J5BzpyhjZa4
	 CRX12JvhMhFag==
Date: Wed, 27 Mar 2024 11:43:38 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] wifi: wil6210: Annotate a couple of structs with
 __counted_by()
Message-ID: <ZgRayuCJ0gQinMvr@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Annotate one more struct.
 - Update Subject line.

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZgODZOB4fOBvKl7R@neat/

 drivers/net/wireless/ath/wil6210/wmi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
index 71bf2ae27a98..38f64524019e 100644
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


