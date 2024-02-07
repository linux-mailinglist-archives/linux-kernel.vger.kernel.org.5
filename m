Return-Path: <linux-kernel+bounces-56659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B587984CD48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A68B2770A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CFD7E77E;
	Wed,  7 Feb 2024 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XFzFNkTF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB547CF03
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317597; cv=none; b=FJFHgTp1XyyVuvYRtRPgXLGkMCRqJ+i2bBeWI1dTZcXQcVI/jH1XWx/9O7adK097MOKotC1dM/1oBcUpJooxkXzQO9IrDye67zCgInE6RlZUmej+/48zj/8zTDooZ+f225yQw1WGXnA7ezIRfqj5xYli2/MCrnnXOReUsFrKsjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317597; c=relaxed/simple;
	bh=7dhx+O2PyaDEDeGc1HBTFc5NQvFFIflUo1Mzmg6Ym7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxpYOR/ZifxaFz/v4T9x23rU5e3+Y3Z4AFMZ+q9IhkcYqTgxR1TTd9EgfjfLb7Mj2AOAyqnCTfHVuxpSRdoyVafyR8b1fByl7GTTggOHQtMyqNTaszgQLU6aMpBhJu6ZesC5UdUqudWzYmMmflvAKLESFMC83UbUfbI0NuwqjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XFzFNkTF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707317594;
	bh=7dhx+O2PyaDEDeGc1HBTFc5NQvFFIflUo1Mzmg6Ym7U=;
	h=From:To:Cc:Subject:Date:From;
	b=XFzFNkTFM1aH23cD74LkWG3zPLnD/HBJr9y4S6RvFGQimYbG20ztzBGPyq0S1HKw/
	 Az8LXxflEtm+V9AK7gIAtY9M/PdzthysoHX0YBvtAiycfa8fXBIrENQn83KTRgSkH3
	 eeUCLDrHrJWMiwm46p0w0uydiq2FYbKqIm5rYe/9FPi6lGza5N4QHinfYOZLNdHeP+
	 pj/vP3wHY9lCUEN7LweLzugDIHXqpCQaYZkb10g77w5/E3uoH1mQxSDFtx7xcl6EcA
	 eynQlhkUCiIOVJQj2D1McyAZPyh2285nXFJd7+c9fZi2NcXlkhTjubO5hxE5ZVSRjg
	 PXDZv9bJKWSRg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 778283782059;
	Wed,  7 Feb 2024 14:53:13 +0000 (UTC)
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
Subject: [PATCH v5 0/9] MediaTek DRM - DSI driver cleanups
Date: Wed,  7 Feb 2024 15:52:58 +0100
Message-ID: <20240207145307.1626009-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v5:
 - Changed patch 1 to not fix the DSI_PS_SEL mask for newer SoCs

Changes in v4:
 - Added a fix for RGB666 formats setting and for wrong register
   definitions for packed vs loosely packed formats
 - Added a commit to make use of mipi_dsi_pixel_format_to_bpp() helper
   instead of open coding the same

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


AngeloGioacchino Del Regno (9):
  drm/mediatek: dsi: Use GENMASK() for register mask definitions
  drm/mediatek: dsi: Fix DSI RGB666 formats and definitions
  drm/mediatek: dsi: Cleanup functions mtk_dsi_ps_control{_vact}()
  drm/mediatek: dsi: Use bitfield macros where useful
  drm/mediatek: dsi: Replace open-coded instance of HZ_PER_MHZ
  drm/mediatek: dsi: Register DSI host after acquiring clocks and PHY
  drm/mediatek: dsi: Simplify with dev_err_probe and remove gotos
  drm/mediatek: dsi: Compress of_device_id entries and add sentinel
  drm/mediatek: dsi: Use mipi_dsi_pixel_format_to_bpp() helper function

 drivers/gpu/drm/mediatek/mtk_dsi.c | 310 ++++++++++++-----------------
 1 file changed, 126 insertions(+), 184 deletions(-)

-- 
2.43.0


