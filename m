Return-Path: <linux-kernel+bounces-115817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB2F88981D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEF91C313D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F813767D2;
	Mon, 25 Mar 2024 03:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZE8DFqN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A40145FF0;
	Sun, 24 Mar 2024 23:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322052; cv=none; b=s4ETVM/EK6V1oO3lNLWjwJnVM1kFI+dqr+eimuMdgGDHlY61bjMpiSpQljSADUx6w434lRyyj8wXB4JnSeQ1WMh0ekQUmQLxkk3QI7s2gc2GlqLVl8wSr5pL+YwyzJPcIBVIwULojsJo6jk5aoPOkPaL/AqItf4b06oWdFuMEQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322052; c=relaxed/simple;
	bh=cO8Qa5P52IwUw7y2XVzyhPTq2BP7NDyu8h+bcAxkZlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWF+cwlDZ2RwJfqCScS5zhNKasd16u+e2qgJuTwJWb/dIgG9OsHm5wTOLM5HnfxW+X9c23DKuc8EUMjStJmsd2KIpL+dLtfmqvcH3hTk3xehAFB20qm9u+A36wZ7ynvS3SXfyqWAH7JmERwH0Z8VkQcA/lFMWPY2D//NUkcHUT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZE8DFqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18F3C433F1;
	Sun, 24 Mar 2024 23:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322052;
	bh=cO8Qa5P52IwUw7y2XVzyhPTq2BP7NDyu8h+bcAxkZlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZE8DFqNssYwJc439GJ3Aq1siggls1f48+TjUMCT+f3ELaM/8WTbvz7/E+hIbbggu
	 bB5myAv3HuBRspAaz/40tK+eNb8e3ySM3bYNAjngUFfZzEXoJCkScvqePAtXxLcdKG
	 LSFvx5+4KIqS3aOnMVG3vzlLEPGRHTGxXFzRXS3U21ipp6walSH4Cz0237uRVTlp3Y
	 0TnWJheL1JqwBvkyv76g31bry1wFNy2MoAvDEgQag24WDGVzPPu4m4rVyDI1PhpZA5
	 lBNt7tHIEWU6KOlTdo6RK2VSbhPoSB+oC1CLLLtaY6I3lo8q0+SiBVxherXs9hn6xi
	 UBL9BkKJK0rtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	kernel test robot <lkp@intel.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 125/451] wifi: ath11k: initialize rx_mcs_80 and rx_mcs_160 before use
Date: Sun, 24 Mar 2024 19:06:41 -0400
Message-ID: <20240324231207.1351418-126-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 21c6b36dc6ebb..51fc77e93de5c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2112,6 +2112,8 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 	mcs_160_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
 	mcs_80_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
 
+	/* Initialize rx_mcs_160 to 9 which is an invalid value */
+	rx_mcs_160 = 9;
 	if (support_160) {
 		for (i = 7; i >= 0; i--) {
 			u8 mcs_160 = (mcs_160_map >> (2 * i)) & 3;
@@ -2123,6 +2125,8 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 		}
 	}
 
+	/* Initialize rx_mcs_80 to 9 which is an invalid value */
+	rx_mcs_80 = 9;
 	for (i = 7; i >= 0; i--) {
 		u8 mcs_80 = (mcs_80_map >> (2 * i)) & 3;
 
-- 
2.43.0


