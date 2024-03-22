Return-Path: <linux-kernel+bounces-111211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9D8886937
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADA21C23E76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5492E20B2E;
	Fri, 22 Mar 2024 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0p9FIKda"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3DD1CA8F;
	Fri, 22 Mar 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099747; cv=none; b=YhQB1iVEYBil8h2n8KCIMnUGydRKejsTp6oKdHCCcVoopoj/YrdWCLdHyIuVVC6DqLJwHblh8KOHar2NZCc+7O73PhFH75UFOWbNNFm727ZQTOQ1Jxqg9hI2rRHdi0n14+Fm95Yx0ZdE89er9r9F7ZbNSA37DvBeidpi8QIeZaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099747; c=relaxed/simple;
	bh=0NfFN1FxYYtX3onU0k0PdRUebLFtOBg0d8UxrwfqgXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mfVEttPhetSpZlnhf3tx3by5wVOgU72KI4sh7GeHWjudl3M0ALV5uJt9dUxzDB4K2wXcMj7GwL6122mC6s/vvIeJGKCrrDguuHml3s7/GjQ97g7fN2zdrzj0aSXbLEkxVUWNvuiPatXTPAd5ncKEzuWCYpyfygjUvfGMTTK1M9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0p9FIKda; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711099744;
	bh=0NfFN1FxYYtX3onU0k0PdRUebLFtOBg0d8UxrwfqgXU=;
	h=From:To:Cc:Subject:Date:From;
	b=0p9FIKdaxjrot2UBo5UNH+oPfbe9HJC8nSlTqi4OGlA9FURnNiQbFRxrbO9oD2b6r
	 Dr+9oqI2jbDuVTlOxcf9ozXJqczioMWgLwlJhOaEkHdRszN9UfblUoVkswAQB8YdeY
	 KDFY9EtEpsdbN/K9SjU1OaJGQ1E8yTiPvJidwTMg7lB6Q1LNVtt2cshSMJv9pkGkNR
	 iNS7Mrza4KkjavrzK63IGDnQcSPtzaX+BPMKHK/Vr7zwX9ikD8/P8zFhx0Dpd+VTPR
	 tMPnamxb7yKPQ2Zk3SNucyXWHfD0hJ0168orFt5D5sN36CvQKBUsuxCQ/JMO9Q4e1r
	 h600t/+svT0VQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E893437820AC;
	Fri, 22 Mar 2024 09:29:02 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	amergnat@baylibre.com,
	moudy.ho@mediatek.com,
	hverkuil-cisco@xs4all.nl,
	sebastian.fricke@collabora.com,
	u.kleine-koenig@pengutronix.de,
	chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 0/4] Support MediaTek MT8188 Media Data Path 3 (MDP3)
Date: Fri, 22 Mar 2024 10:28:41 +0100
Message-ID: <20240322092845.381313-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds code to support for the MDP3 block found in the
MediaTek MT8188 SoC, including the necessary bits for mtk-mutex
and platform data for the MDP3 driver.

This is mostly compatible with MT8195, with a few differences
"here and there", with the former having less instances of some
of the MDP3 IPs compared to the latter.


AngeloGioacchino Del Regno (4):
  dt-bindings: soc: mediatek: Add support for MT8188 VPPSYS
  soc: mediatek: mtk-mutex: Add support for MT8188 VPPSYS
  dt-bindings: media: mediatek: mdp3: Add support for MT8188 RDMA
  media: platform: mtk-mdp3: Add support for MT8188 MDP3 components

 .../bindings/media/mediatek,mdp3-rdma.yaml    |   1 +
 .../bindings/soc/mediatek/mediatek,mutex.yaml |   1 +
 .../platform/mediatek/mdp3/mdp_cfg_data.c     | 280 ++++++++++++++++++
 .../platform/mediatek/mdp3/mtk-img-ipi.h      |   1 +
 .../platform/mediatek/mdp3/mtk-mdp3-cfg.h     |   1 +
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    |   3 +
 drivers/soc/mediatek/mtk-mutex.c              |  41 +++
 7 files changed, 328 insertions(+)

-- 
2.44.0


