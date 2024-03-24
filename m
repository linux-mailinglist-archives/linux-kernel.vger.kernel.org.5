Return-Path: <linux-kernel+bounces-113033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F38880F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DD21F234FF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6D813B784;
	Sun, 24 Mar 2024 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5CR40BO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E73813B29F;
	Sun, 24 Mar 2024 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319843; cv=none; b=ByjM58N2PfcUm+rtfLP5tBB7uA2JEWcQzN3aelfWY97XbSDueGHs6pSG3GUJPoURNPI7RZaFgS4d62u6m4Iz28UJwpHgfKCCxxF1E2V8Lf/hf4d/50UfGAF3x9+iJK6smIjm8kJC0/cCV/bazatx1SwWrTjQZr1VyVHMFf9whkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319843; c=relaxed/simple;
	bh=7yg7GgPd0ZDeUdmhMXbVBOY/7e+30tl6Ej6hje7XTFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmTejbDVVF8Sfd77bcqQ99HRiZapTiYcM3VMoY3bM9WsB0foOaMDVd6mXJFgUhYw66ODRR/13qEogKRM2z6Apkz2mnwK/utoVJXFwJo+rORXo68qHTrDtMPlzeumaJq25QmMXlu7dcz1nwkHA9FMGVZmgF4mKy8XjYSLk+g1tHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5CR40BO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674C8C433C7;
	Sun, 24 Mar 2024 22:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319843;
	bh=7yg7GgPd0ZDeUdmhMXbVBOY/7e+30tl6Ej6hje7XTFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5CR40BOMmiF1QxmiD9Q0xp/p+QIHGmqNeCig2vQqPQlPmRhTDtDm5DWuS7jgNewo
	 rEr6IeplnYTGWseTDtGcR3GgKmvL9UIbmmX/+JfQa9MEd5eCrKw8Ctxa5l206hgbEX
	 2mq7QaFC2giz11B6cLZd08LFqEUwMy6LZBDkGDp+owcsLHh6A4DyXWlGbLUTg24L8e
	 0k+VaHNJQIo81LZzDE2OCXHv8yFFX2CN0TcUpDAPvH32Idw2/R4X2NwODN9rDAwt5W
	 opUNgoTK7DslDujV1fc9uKJr1EUKpcsqnLobsS6DBe31TUwcBD6+U6hMlXso20xFcB
	 rh0qc3ls01WHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	kernel test robot <lkp@intel.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 146/715] wifi: ath11k: initialize rx_mcs_80 and rx_mcs_160 before use
Date: Sun, 24 Mar 2024 18:25:25 -0400
Message-ID: <20240324223455.1342824-147-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index b6b474a7f1c9c..cc80310088ce1 100644
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


