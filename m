Return-Path: <linux-kernel+bounces-28143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4E782FAC3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E9D1F27DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B341115AAA7;
	Tue, 16 Jan 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArIYpXUM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC3315A4B3;
	Tue, 16 Jan 2024 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435263; cv=none; b=CX+OFL1cCsY9zJqIyq0GnMVCFZ9GiPq7DyNbAe5K0px6SKElRHBFfDqMgAcKSHAL8ofTN3YExll9XUQk9mGWyLg3Fy7BFmLDVfC12t7TjTizeIgy8u/YTg22jOmr9WedHMqueFboLWlsLejStjVYYYjxdJuUnjr4YkEU+4W67YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435263; c=relaxed/simple;
	bh=M7gN1vdU9segqQpvEQ8KJ2OuiMDmNZrOwDL0uSAx7Vg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=cfxFjEXrkvtI442QQte5ySHJHjwZtzI6p1Zmkvn+0wSyVkPWPT1EeZAdqAhi2ZvB8NTl8LpfuNH5uFhv1yN3QdGij83R9qrbE+s6HUEQYVo9q3TqsWbxTuraA0Zlq7Ps103pWpcogfq3A+B3JQNwwBKlio4VTl+wINZWtdFrvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArIYpXUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEDCC433F1;
	Tue, 16 Jan 2024 20:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435261;
	bh=M7gN1vdU9segqQpvEQ8KJ2OuiMDmNZrOwDL0uSAx7Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ArIYpXUMMwVVUYnevE5dCDa9wHBzAZa84J9QZECLLt0XLYekt9FwZGSIhromSbm2B
	 4MetCFFXyjBEP/HU+Yb5V1ZXnRQ3osZmzbQciKNOSwSk9QddpkBnepsXrEbpyk/lB3
	 bFqkLOhYBOSaWfYpdEzcWHfdC8QbpK2/PeEJE+U/7cfx3ndCQpEWlaIKquJaV82FHF
	 tI6kY2rLRZ+A0wNTx7nnLaMYt5zywwPZaYVWZJA6XDbhZjKVxa8Bql6zcVaxSrZ2pP
	 qE5l1DkCSAT7MkSWjwLYmQCv5TxnwQZCUha+3M4S78uFK8aSs/X9He0/iNSyer6wal
	 RbsG8LFRNMvJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liam Kearney <liam.kearney@morsemicro.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 07/44] wifi: ieee80211: fix PV1 frame control field name
Date: Tue, 16 Jan 2024 14:59:36 -0500
Message-ID: <20240116200044.258335-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Liam Kearney <liam.kearney@morsemicro.com>

[ Upstream commit d3ca4ab4f16eb81dc3e7721251adcba49b229d54 ]

Update PV1 frame control field TODS to FROMDS to match 802.11 standard

Signed-off-by: Liam Kearney <liam.kearney@morsemicro.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Link: https://lore.kernel.org/r/20231025002755.1752983-1-liam.kearney@morsemicro.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ieee80211.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 770408b2fdaf..b49f6ff79b2c 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -170,11 +170,11 @@
 #define IEEE80211_SN_MODULO		(IEEE80211_MAX_SN + 1)
 
 
-/* PV1 Layout 11ah 9.8.3.1 */
+/* PV1 Layout IEEE 802.11-2020 9.8.3.1 */
 #define IEEE80211_PV1_FCTL_VERS		0x0003
 #define IEEE80211_PV1_FCTL_FTYPE	0x001c
 #define IEEE80211_PV1_FCTL_STYPE	0x00e0
-#define IEEE80211_PV1_FCTL_TODS		0x0100
+#define IEEE80211_PV1_FCTL_FROMDS		0x0100
 #define IEEE80211_PV1_FCTL_MOREFRAGS	0x0200
 #define IEEE80211_PV1_FCTL_PM		0x0400
 #define IEEE80211_PV1_FCTL_MOREDATA	0x0800
-- 
2.43.0


