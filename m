Return-Path: <linux-kernel+bounces-66444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E9B855CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EF8B26AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E8C14286;
	Thu, 15 Feb 2024 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RyN4iV6k"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4D14012
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987203; cv=none; b=itXTXmXkGEfMmxiydDqTFA+uIYsk7vZocQm/OXea/cm8b8fIGLYtDI9T6SgEH8MyZgyeMX03YimCz22p74aaC5pmcbfMwCnpOoh5dTFGM2KRwlYu9waepYBkoSXt0xmULpmL/sLcFWr/NLNr84BBsNAfglKSxTtsZwJ3Kv169Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987203; c=relaxed/simple;
	bh=gSl7FFAcyFkyZu86fmPgJX2VEBYzcNb/7gsEn+fDq54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3i/2cMU8zTZkmrAKuSIDX724tindpcdxf832KDNzV9/X/sFF5yxJH0F2SpkF/BEbQ903EnaVngmFFzoCwPlnUGfu/4hsN47zqRKB8+mAf7cFPgHF3b96bfT3jnL0hOomisJgEyP62h9ve51uOr5JSv936rPGkbIWY+0RiUwEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RyN4iV6k; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707987199;
	bh=gSl7FFAcyFkyZu86fmPgJX2VEBYzcNb/7gsEn+fDq54=;
	h=From:To:Cc:Subject:Date:From;
	b=RyN4iV6kEyFZUZDDqUO4zfb0Xu1xdQ2OGWpN3LWM5Vhl1h/PF1pPWYFYYDxyyUMjr
	 qZyqHYtqOmcQ9y+ZJ+DR9RgpArK1ZI4oXnCIQHBn5eTwYDXamGZn1sT5mtGdnbHvqc
	 H2neXE64sulCGzppMw/hejt50qtRNSMAztVuG+640OyJgbF+sdvebK9IcLXRFZ2Mzx
	 mT9A+HlxzyQcqktgAPoObRiQU0Msj40xW7qvqmKjdL3SZApQGJ0e4DqDSC7WD/377l
	 iXGSqrGbHQdIcR6kqVjpzmXOcMdGBhqBpYkqsDJE1QLCPz0HT9n2S271+mSSuCHA7t
	 vzggWxfanXisw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E41AB37813FD;
	Thu, 15 Feb 2024 08:53:18 +0000 (UTC)
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
Subject: [PATCH v6 0/9] MediaTek DRM - DSI driver cleanups
Date: Thu, 15 Feb 2024 09:53:07 +0100
Message-ID: <20240215085316.56835-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v6:
 - Moved default case from patch [4/9] to patch [3/9]

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


