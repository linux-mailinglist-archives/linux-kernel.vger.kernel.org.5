Return-Path: <linux-kernel+bounces-115430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38738893DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87B41F30288
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF3520F245;
	Mon, 25 Mar 2024 02:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZOlgMBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E41DE11E;
	Sun, 24 Mar 2024 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320736; cv=none; b=oVtF465VFWUjWatt8LjLnlOw++ux6K8HGtv04GMOrpZmy4c5fUwnJg4LrJhFYQcpzmhrZ04zuTLLKgqlRtg+o+kLPR+RzRf3reMTZkGpBnx9K0ulmyEUlieGlMtBRW1CugSu/Tz/TWdkMvD9cO9SiIlhIrQzltm0VVyUrqoXUfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320736; c=relaxed/simple;
	bh=DIaY63F6+qP+Kys6KjDibBgqTTc6/AjrEVqel/3Y1lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxt5Kxf1j8bRqhkCVdXD8gYcJZVXSb+eG3kdnhuRZaWLskPzOB5gEpeDXGqN5Mp1nRW9Abz+5Y/bMPURdTYIdtuaHchA+7aTaCDxicQONVGW3jf/xyHFbU7FipvBYQTDWktB3MjQeGG60fqQuJW2DGYuPRwGhhnjZHuquQY8YO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZOlgMBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F307C433F1;
	Sun, 24 Mar 2024 22:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320736;
	bh=DIaY63F6+qP+Kys6KjDibBgqTTc6/AjrEVqel/3Y1lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZOlgMBRiyT0N4CI0Ax3rwxAYoo+BMzZEi76uz0HBSFdDuZ/e2Cv/VmrA0ST13i4w
	 kx1Oxs8FPlshKfP2WjmnQXb3Mw70oCN7mbTsAnSL8GjStsVa2tC/5OPq4RHCy+Ig+L
	 BLKvzo8D5lgRiP3BaASbdJjnqIE4AJHA4NqsyeJWpcOBjaNRsWiBn06JE/9r3YGaDw
	 WR+HpTtUKDWtRKhzhJGCnadQSFxmc8pLfaUfa0e3dnXPtBQN/79QjRsbx65IregdUk
	 NLrzw/1G421XJw368b4cygjCdryYCBJeq6UwLNuRyGO8EkOnXIq/AFVwtPhDOpj6hw
	 1Ie3crAQHER4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gen Xu <genxu6@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 299/713] wifi: mt76: mt792x: fix ethtool warning
Date: Sun, 24 Mar 2024 18:40:25 -0400
Message-ID: <20240324224720.1345309-300-sashal@kernel.org>
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

From: Gen Xu <genxu6@gmail.com>

[ Upstream commit 7b4f9cd6a5fc221895b1d9be83ee3c13c00d09ab ]

Add a missing EHT related field to fix the following ethtool warning:
[98179.287352] mt7921e 0003:01:00.0: ei: 74  SSTATS_LEN: 73

Fixes: c74df1c067f2 ("wifi: mt76: mt792x: introduce mt792x-lib module")
Signed-off-by: Gen Xu <genxu6@gmail.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 502be22dbe367..fb35eff6dc7b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -354,6 +354,7 @@ static const char mt792x_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_bw_40",
 	"v_tx_bw_80",
 	"v_tx_bw_160",
+	"v_tx_bw_320",
 	"v_tx_mcs_0",
 	"v_tx_mcs_1",
 	"v_tx_mcs_2",
-- 
2.43.0


