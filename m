Return-Path: <linux-kernel+bounces-46354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A252C843E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52BB1C225EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD63074E24;
	Wed, 31 Jan 2024 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XhT2sK5+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38861E522
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700884; cv=none; b=PZQ+JksFFJdzZQQ7Xj8jQ56kcfleJAt2kzSQEVheG8LsNNI8EifhDBsBDwN4QwIzWzTpzCV+NWRmGPJXMMDNDOY6mGwLFxMZZg1LIS7bjGEvhUjtmYRNnWcjiw9C+VOXJ/MeC5eJWImsMnNF7+/ye90Zbd/ozExDk2mM4YoGI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700884; c=relaxed/simple;
	bh=szOUEWIekbHFv2ysEIzLFfxkSV4iQ7hF2ZVTmP3Cfbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SXTQ6BqGvY19Hs+9I1uaAPcC/m5caSIp9EXZqk/djbnuBJRk2QuuiJekKrqmlARyVHQhFvF9939YG2nNxz2vX3mlbbBERP8THAm5zW8HEBK815K94wJsdjMvaLrbeB25cLV0XRqH+5Q7oAJg0lD5lFDk5qJwQ8Q/NHFUHy/fXiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XhT2sK5+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706700880;
	bh=szOUEWIekbHFv2ysEIzLFfxkSV4iQ7hF2ZVTmP3Cfbg=;
	h=From:To:Cc:Subject:Date:From;
	b=XhT2sK5+x7A6MrmX55bmRBBSKIslbgDwWP/R1kW8wOSsaJTXkuqh8LmHuxDI7GM/u
	 lX7+F4OYh/12DCdtK3bIR7Dv+uZvzB4s4+BkzH/iIAJhDuh8eWbZUG6sH3kNypCpj+
	 ZqsHuxvDaSXs38XVyd4nmBeOPneYYOt/TCR992V6WHcMyH6J2fOEqWqMbWL3Wxto3p
	 86CiZUAN5b/B2kd4T9lo1y5W1GTEEiX6gdwgU25aSg6jmGUs2sWPBtK237YrZV9U2R
	 GuSacIFWXaRvXdH/f6P+hOkzviXzEZ9zFizoiHsJTvOB69CD6YMlCF6YqlGT8Ralc8
	 egc+3GS5Tf8Vw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0C8A13780C22;
	Wed, 31 Jan 2024 11:34:39 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: fshao@chromium.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v3 0/7] MediaTek DRM - DSI driver cleanups
Date: Wed, 31 Jan 2024 12:34:27 +0100
Message-ID: <20240131113434.241929-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
 - Rebased over next-20240131
 - Added bitfield.h inclusion in patch 3
 - Added three more cleanup commits to the mix to simplify
   the probe function and remove gotos.

Changes in v2:
 - Rebased over next-20231213

This series performs some cleanups for mtk_dsi, enhancing human
readability, using kernel provided macros where possible and
also reducing code size.

Tested on MT8173 and MT8192 Chromebooks (using a DSI<->DP bridge)
and on MT6795 Sony Xperia M5 (DSI video mode panel).

AngeloGioacchino Del Regno (7):
  drm/mediatek: dsi: Use GENMASK() for register mask definitions
  drm/mediatek: dsi: Cleanup functions mtk_dsi_ps_control{_vact}()
  drm/mediatek: dsi: Use bitfield macros where useful
  drm/mediatek: dsi: Replace open-coded instance of HZ_PER_MHZ
  drm/mediatek: dsi: Register DSI host after acquiring clocks and PHY
  drm/mediatek: dsi: Simplify with dev_err_probe and remove gotos
  drm/mediatek: dsi: Compress of_device_id entries and add sentinel

 drivers/gpu/drm/mediatek/mtk_dsi.c | 284 ++++++++++++-----------------
 1 file changed, 117 insertions(+), 167 deletions(-)

-- 
2.43.0


