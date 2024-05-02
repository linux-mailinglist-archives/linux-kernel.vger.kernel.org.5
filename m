Return-Path: <linux-kernel+bounces-166412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D6A8B9A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9F31F22814
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5FC757EE;
	Thu,  2 May 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aDM5WyZk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D245EE97;
	Thu,  2 May 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714650995; cv=none; b=HYXWOgod3pnzoiGdMrhJ+nIJxW2ZteEjDV4IBJgO5CiKbaT7bc4k+Tb+cwmfksms64fd6iqZshSsbQg9KrbVGTXSZKLgkry3+6aiVtoPGpmZYHPxBv7uqFqhRINunSXRwijWoi1ENOQ+aLps1x2jesCCmY0SWgbftUE9tU7MUQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714650995; c=relaxed/simple;
	bh=QLeN9lmVuHF4/2sYBRVtEjDdi+4aVijYksoMcIrmdkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meVKnkjFBQ/mm360Il18LEM10Us7SyA/nlrXjNtnLjrXjrEb0oNdSyVrX6zy5PUzNcquzHgUYaC1Nbx5T3klAV1kYF3uuvThr7ZHUmjbr2iG0cV4gt9AMqqwQ15dWiAF+XGEOudoUxbcfiBFHd2I6k4zMu6Fy2GRPG5WoJKiNOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aDM5WyZk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714650991;
	bh=QLeN9lmVuHF4/2sYBRVtEjDdi+4aVijYksoMcIrmdkY=;
	h=From:To:Cc:Subject:Date:From;
	b=aDM5WyZk1iKx2d9C9ODxeac2BGFUmQv/25fPdq18Zi9b0bfaJgM4bJkiQ3CpT4t7r
	 3uUU1vAn/pqYKyHRxnPECCOW0kgepeQiLFwtTRHoWhh1nE7SrNXJHH71gqiN1CEcV7
	 6w7mzzILxnHTUUflP3TyawYHCKGnvQ9cdI+kEdO6DoDMN4XEiTGfgKR6OhK+8O/lTN
	 4kmW7xK2zCPwM78Fd61ym0FGl/S5R9mSyunso18ztH7H2NCBf3YUJmOysGKBWNVadC
	 woWuKMo7u+9hXh4LkB2CdkIaNIb0CNUeDB/5209OqkaZoWAj6ISyGHq53U3JF5Is7i
	 aUzTW7drSxm7w==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3EEC8378143B;
	Thu,  2 May 2024 11:56:30 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	shawn.sung@mediatek.com,
	yu-chang.lee@mediatek.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	wenst@chromium.org,
	kernel@collabora.com
Subject: [PATCH v3 0/3] drm/mediatek: Add support for OF graphs
Date: Thu,  2 May 2024 13:56:19 +0200
Message-ID: <20240502115622.248456-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
 - Rebased on next-20240502 because of renames in mediatek-drm

Changes in v2:
 - Fixed wrong `required` block indentation in commit [2/3]


The display IPs in MediaTek SoCs are *VERY* flexible and those support
being interconnected with different instances of DDP IPs (for example,
merge0 or merge1) and/or with different DDP IPs (for example, rdma can
be connected with either color, dpi, dsi, merge, etc), forming a full
Display Data Path that ends with an actual display.

This series was born because of an issue that I've found while enabling
support for MT8195/MT8395 boards with DSI output as main display: the
current mtk_drm_route variations would not work as currently, the driver
hardcodes a display path for Chromebooks, which have a DisplayPort panel
with DSC support, instead of a DSI panel without DSC support.

There are other reasons for which I wrote this series, and I find that
hardcoding those paths - when a HW path is clearly board-specific - is
highly suboptimal. Also, let's not forget about keeping this driver from
becoming a huge list of paths for each combination of SoC->board->disp
and... this and that.

For more information, please look at the commit description for each of
the commits included in this series.

Please don't mind about the missing OVL_ADAPTOR support for OF graphs
in this series: that needs a bit more thinking and a bit more work, and
will come in a second series that will go on top of this a bit later,
as the OF graph support for *at least* the primary display is essential
*right now* to enable support for the MT8195/8395 EVK, Kontron SoM,
Radxa NIO-12L and all of the other non-Chromebook boards to co-exist
with Chromebooks.

Besides, this is also a valid option for MT8188 Chromebooks which might
have different DSI-or-eDP displays depending on the model (as far as I
can see from the mtk_drm_route attempt for this SoC that is already
present in this driver).

This series was tested on MT8195 Cherry Tomato and on MT8395 Radxa
NIO-12L with both hardcoded paths, OF graph support and partially
hardcoded paths (meaning main display through OF graph and external
display hardcoded, because of OVL_ADAPTOR).

AngeloGioacchino Del Regno (3):
  dt-bindings: display: mediatek: Add OF graph support for board path
  dt-bindings: arm: mediatek: mmsys: Add OF graph support for board path
  drm/mediatek: Implement OF graphs support for display paths

 .../bindings/arm/mediatek/mediatek,mmsys.yaml |  23 ++
 .../display/mediatek/mediatek,aal.yaml        |  40 +++
 .../display/mediatek/mediatek,ccorr.yaml      |  21 ++
 .../display/mediatek/mediatek,color.yaml      |  22 ++
 .../display/mediatek/mediatek,dither.yaml     |  22 ++
 .../display/mediatek/mediatek,dpi.yaml        |  25 +-
 .../display/mediatek/mediatek,dsc.yaml        |  24 ++
 .../display/mediatek/mediatek,dsi.yaml        |  27 +-
 .../display/mediatek/mediatek,ethdr.yaml      |  22 ++
 .../display/mediatek/mediatek,gamma.yaml      |  19 ++
 .../display/mediatek/mediatek,merge.yaml      |  23 ++
 .../display/mediatek/mediatek,od.yaml         |  22 ++
 .../display/mediatek/mediatek,ovl-2l.yaml     |  22 ++
 .../display/mediatek/mediatek,ovl.yaml        |  22 ++
 .../display/mediatek/mediatek,postmask.yaml   |  21 ++
 .../display/mediatek/mediatek,rdma.yaml       |  22 ++
 .../display/mediatek/mediatek,ufoe.yaml       |  21 ++
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  16 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        | 255 ++++++++++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   2 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  10 +-
 21 files changed, 645 insertions(+), 36 deletions(-)

-- 
2.45.0


