Return-Path: <linux-kernel+bounces-113682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401AB8885FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782C61C23F71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C281E0E40;
	Sun, 24 Mar 2024 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siSNM6HH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A1E1D8BC5;
	Sun, 24 Mar 2024 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320645; cv=none; b=seFJyvjwDJNHxDV2gRndf0QkDzhxxjZUTyPNHFZFHaCM9bIqFBvYYwRtCn984scA8oVO71puMIUsxyPzikP0bXkymeE+g1jIYbUBDIS9EO7unizQGFVX6LToPhxxj7hDCVapkvmai7w83HWNFAJOddfSbZmDiaCG/CThNw1MUAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320645; c=relaxed/simple;
	bh=IjhCCsBYDRk59ErJJBfFAuXUot+zVTutag8G8d+U7us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FREFJmCZgkedqTSfiEIgLfWjkXLIsfd/+LsgGvdkKTP4+m9Op6+RGLWY+7fs9zel5+s4T0D4cbigT19rvAsexlqgt2LwZ4/FIaCHEQf+wc6YYn6uUaWbKFPORh7G9oMG5Lisy+qpVnTYwYHrgKhQrGC96Lj9S+nxDAEZAA77MSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siSNM6HH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B76C43394;
	Sun, 24 Mar 2024 22:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320643;
	bh=IjhCCsBYDRk59ErJJBfFAuXUot+zVTutag8G8d+U7us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=siSNM6HH7GfMEnlGZoDqs5bdqH0Bp03UObkIHxQrkrmPxzgQbFhF7grLmsUTUjYqD
	 mAb1nrbBwnMf+Evy1kCOuxU8T+hQPLUTN8qwi1MxVbapIHp6nc1yjhid3kV3qsh5XB
	 N74n+NaguSQzFkdUWotCcIQrypyPyfgwG03Dkwg1QLqu7cxljtaKjrGwxWEZenmlZi
	 DSCwMuH2taZPhGitSIS4EBGVW6QGXbh3krCanvusn3yRahaQrfCZn5BkCbRfIEc1h2
	 Dhs5fYbxS6Ehc2w+C/a8ZrR68VZNN6OW0UTrDhkur1Vykp66/3GjSdrmQmvE4/JkXl
	 hz6fOpA/r4GIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	kernel test robot <lkp@intel.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 205/713] wifi: ath11k: initialize rx_mcs_80 and rx_mcs_160 before use
Date: Sun, 24 Mar 2024 18:38:51 -0400
Message-ID: <20240324224720.1345309-206-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit b802e7b7e771dee3377d071418281f8b64d2d832 ]

Currently in ath11k_peer_assoc_h_he() rx_mcs_80 and rx_mcs_160
are used to calculate max_nss, see
	if (support_160)
		max_nss = min(rx_mcs_80, rx_mcs_160);
	else
		max_nss = rx_mcs_80;

Kernel test robot complains on uninitialized symbols:
drivers/net/wireless/ath/ath11k/mac.c:2321 ath11k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_80'.
drivers/net/wireless/ath/ath11k/mac.c:2321 ath11k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_160'.
drivers/net/wireless/ath/ath11k/mac.c:2323 ath11k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_80'.

This is because there are some code paths that never set them, so
the assignment of max_nss can come from uninitialized variables.
This could result in some unknown issues since a wrong peer_nss
might be passed to firmware.

Change to initialize them to an invalid value at the beginning. This
makes sense because even max_nss gets an invalid value, due to either
or both of them being invalid, we can get an valid peer_nss with
following guard:
	arg->peer_nss = min(sta->deflink.rx_nss, max_nss)

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Fixes: 3db26ecf7114 ("ath11k: calculate the correct NSS of peer for HE capabilities")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401311243.NyXwWZxP-lkp@intel.com/
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240202023547.11141-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e09b21a82c20f..1c4613b1bd225 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2297,6 +2297,8 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 	mcs_160_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
 	mcs_80_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
 
+	/* Initialize rx_mcs_160 to 9 which is an invalid value */
+	rx_mcs_160 = 9;
 	if (support_160) {
 		for (i = 7; i >= 0; i--) {
 			u8 mcs_160 = (mcs_160_map >> (2 * i)) & 3;
@@ -2308,6 +2310,8 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 		}
 	}
 
+	/* Initialize rx_mcs_80 to 9 which is an invalid value */
+	rx_mcs_80 = 9;
 	for (i = 7; i >= 0; i--) {
 		u8 mcs_80 = (mcs_80_map >> (2 * i)) & 3;
 
-- 
2.43.0


