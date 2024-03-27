Return-Path: <linux-kernel+bounces-120211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98C788D480
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B102E5F46
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB68320DC4;
	Wed, 27 Mar 2024 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfCiw42j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E506B1D558;
	Wed, 27 Mar 2024 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506280; cv=none; b=Dgu6aTGe6Nn3GZOu4jpIBYc5gqvPIvbXV1F+l22nRdOikzGhx1nQx8UqjAjUEvPBxo0+ZOjqlvMOe53Ad1bdX+QOLEGrFvwg5GF+0dBz+DePj1uCTwKLMV47ZHGT9X02Fl/3Tl2NCHxniN94xcqPdcgf6ngRge6vbihXjDETEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506280; c=relaxed/simple;
	bh=cpRe0I624W4PyDCoKNNY5T363n+NwNGTXK8OdWcxSxg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N8XdS5nAc0TkwwyzcleNOyPuPJnl/K3o4NNTPAHl6D66tFhNBJGe0KfD2cfNX6oVamjVSFhevFlIvM91WEEsg6f4bvEPeXdIIayIBmLyaS896Bf9HIYf1rOyiJ+1pYK5nYIno07jI3Re/o19SACnWLLdy2MupkkOvSsIeGd7ctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfCiw42j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4013C433C7;
	Wed, 27 Mar 2024 02:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711506279;
	bh=cpRe0I624W4PyDCoKNNY5T363n+NwNGTXK8OdWcxSxg=;
	h=Date:From:To:Cc:Subject:From;
	b=LfCiw42jEQuYzJPv+ZRPpfcJ5fxsiood1r6awmH8kHA5HEOeP5agOA7zvLdUsma//
	 IGj1ELM3Y2kp20BtVP4KQ7LzNmxzQ7YQYExxdjlfizxoQbAEB9J+vAxrwN2/9LZg37
	 sAfPj6e6CnkV8BOR6wX0QeR25zneNxwITLTMtwW5kX9eiyDLyFeb+mfBhjuNtQNJDU
	 p2HpN8OsskC3OXnXSgBZU435oDDZQHvFUamoxPagMZdCSpC2I6KUntyA7pSGewTwjX
	 vEEmSbqt9YuanODT361aRy27u7OILvpC/5VTelQ7HFmUeUT5wMj9Fmgy5KID4f39tj
	 hVpcdVMl3KJeg==
Date: Tue, 26 Mar 2024 20:24:36 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: wil6210: Annotate struct
 wmi_set_link_monitor_cmd with __counted_by()
Message-ID: <ZgODZOB4fOBvKl7R@neat>
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
 drivers/net/wireless/ath/wil6210/wmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
index 71bf2ae27a98..6813f9e0bcf7 100644
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


