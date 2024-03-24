Return-Path: <linux-kernel+bounces-113137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021958881C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE5E283476
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC44A13C3D0;
	Sun, 24 Mar 2024 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7QdrSZ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9D84D3F;
	Sun, 24 Mar 2024 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319944; cv=none; b=Wa408Fw74XeouYQTW0skJv7HCDeoAJZH4Juxhca6PSYLvs8H3z9g75VR6jLR3AxL1Afc516t3ZoN+RmeL8rm8UrCASSXil3f81EPj5ilURifk580PXC3C8iL5doiP2n0jDnJjoKD1YGEEsGjV10eBba7/L9ZvI3X7pFNRhPbkhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319944; c=relaxed/simple;
	bh=IaFRpmeld72c6LkomiAk4EHfxlt6SMG/fVgjVIcW9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTX5xMJXqZXfUVmmSDg8O0KjwJkymagJHbFUq8DoO7jxTpSaKaGJl9bkmbtVzKiSPssMrnfiw19Ow1D58pOfLlTnmg/fvMJVQaNiZIvGgtHSfNMhkIDp35BR7ly3bsoP1xtFrs2oH3sd5jIHfWv1UlWOP1LHRtk8e/6wzdR4sq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7QdrSZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17F0C433F1;
	Sun, 24 Mar 2024 22:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319944;
	bh=IaFRpmeld72c6LkomiAk4EHfxlt6SMG/fVgjVIcW9cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7QdrSZ4JOds5Lesq/pDpD0ipMJ8DFaFeE9YTlSijxaqudXRQQsdmFfHEGuVKCDEW
	 TnfkoXoZ7JjLg3iT+fUswLfANjBViDzymXi/vHcqPrwfW14MyW/rrMezBvSX2+RA6T
	 zUXgQO1wb2q0bQhaaxvzBWx/24MfZgxlCpjsu7pIipEsMT31/9niaJpyuHf/jPms89
	 BVa7u37IEYtRzb8ov2dLDSbjpk8weH7I3s4peOsjRGZHmun10ofP9IoaANhiD826m1
	 Yscfs7GTH34OfpZV6lkC+7Oj6m4azxaxcwbRC6wu//iIyZdGmROWeW9/2OUVJTDxSy
	 +JRBDDXjMG9ow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gen Xu <genxu6@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 250/715] wifi: mt76: mt792x: fix ethtool warning
Date: Sun, 24 Mar 2024 18:27:09 -0400
Message-ID: <20240324223455.1342824-251-sashal@kernel.org>
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
index c42101aa9e45e..9ac5161dfff8c 100644
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


