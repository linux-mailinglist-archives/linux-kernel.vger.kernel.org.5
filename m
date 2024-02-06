Return-Path: <linux-kernel+bounces-54858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD5A84B48C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34CB7B2722B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B1E12F396;
	Tue,  6 Feb 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ORy0tUp0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BF631A60
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221276; cv=none; b=dKOURaYNAWEj2O425LaSu9BpGCswrO5qi414g3RnwCyw0J55s1DaR/hfPhDyaY+cKdsFa6jdmfZteVWOooZGQ3i9UWCRdYAyuirQO+wBiFQlnWlW5gzeOcs1ivqwt5/6xFblJijv6gGbpVGEUehHSGx0Q30tf3bIwAZZVB2+V3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221276; c=relaxed/simple;
	bh=Mv6zf86XoMmKd7NcYaO5kG+cRiZYMBMgYxftUMxYBJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HXH7yZ/JwXYlh4N04Xala6TnuMgF5B6aYr7ijcpCz7ENuK/lJ4WQLgXN2QLxgGQQkNc6vJE0lC4mvQXfUpNtIP3NKOeKwKI/ciMz/5rMnJkZFfYTN930BQKCUoEb5DYFTOG2FS4FXh9oyXc7aK0cQkdKGDIg9Ev/KcDPGLI5jEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ORy0tUp0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707221272;
	bh=Mv6zf86XoMmKd7NcYaO5kG+cRiZYMBMgYxftUMxYBJE=;
	h=From:To:Cc:Subject:Date:From;
	b=ORy0tUp0WLvNg2y025fU0e1/OBcibOUv+i13OzSeb+EpmrAgEFen9ZCVyeHqx+cJP
	 81dwl8H1W9dPWiOtLMAbuVC3bPH0sdv4MNAtfJ0XfLSBbZ0huLbvwDenbjz7U9vxxS
	 10hrbxkb1qOFkOBKa17Y393/WEHrKHWTcMyU5E70DkAUugg01RKjQKt4KfE1kSom1t
	 5+mtVQwQTuc4YnaIN55KJLyTdnm7TRkvaWgdy0s/lLob2D83ypjiJPV1Lsq2Vl2Rdg
	 ApXKcBmTbyXw9ydDjUuBsdOuYCM8bF88ffDeFouow+OIZHPtrFcyEWyX9UF+gCdSr6
	 SB/gZ3EIswHNA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CBA4B3781F8E;
	Tue,  6 Feb 2024 12:07:51 +0000 (UTC)
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
Subject: [PATCH v4 0/9] MediaTek DRM - DSI driver cleanups
Date: Tue,  6 Feb 2024 13:07:39 +0100
Message-ID: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


