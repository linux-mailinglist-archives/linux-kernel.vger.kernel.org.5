Return-Path: <linux-kernel+bounces-48169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA3845835
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD681C27E23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03631EEE8;
	Thu,  1 Feb 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eYf4a29f"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3298663B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791995; cv=none; b=If+r8+gTmYaFUzuVOYU+981LGWzS3A2MV7KKJU2K0uQhQTjgfJDMvuw+usi3oOknYnMgUBMB4yXn3xYWlLqZ2LEElRttiXnWvJIQRlVRR7Zf2Ig6nCwaDFLH2niwlbs0oe9UHb0im7QL4BFVnNmjPdxRYrkCF3ORvYHqJaqGCuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791995; c=relaxed/simple;
	bh=AiYqxfdfmN8jEke9jGAUzoN6GSbkaeqahTRB/bnjbXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+onzIF5G7L1D/4LQFpVcg+6qj9QGZLikVmuQbXj8JhQ6DHyGw9rxoep37OijM4/1HTH1Jp9A0uYgB07w6555zsg57WpKMknPkMtgtRstn+00Ugwh2H3zcmn1hApolML1HxZCnNARcJ8Gk9LSpJGDPilf8TeKmEWeoniMqMeFD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eYf4a29f; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706791991;
	bh=AiYqxfdfmN8jEke9jGAUzoN6GSbkaeqahTRB/bnjbXA=;
	h=From:To:Cc:Subject:Date:From;
	b=eYf4a29fl7BlgqPMXrORpEyZup6lT/KKme8ccW3IGZkpZ2xSBehBh8MFFv09N7mh9
	 JwPXb3xTHwmkcHVYo7LY6fQexTrliD0QAvcJQCFC3I+6C1RfpchwQNa2icK2HCQh+O
	 mUFmWV9cXvYPybkckWot0cjw47IEiXUEQzuPkzTJv5kaK4MmxAhjtH0iy2vRJu9Pxj
	 0ORfdgPpePj8pFFCUepfGUBOkTh64idLcx12YHp/5oCAcbx008BelXX3DadZd8IuIy
	 BSUuVa2jc/bk3kTdU1rj3UwE5HnJsKNrvOTA5xZM64Jn8B7qujwW8JKXtogEroim5f
	 Ml5HwSh5mWcVg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B6D44378047F;
	Thu,  1 Feb 2024 12:53:10 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	nancy.lin@mediatek.com,
	nathan.lu@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org
Subject: [PATCH 0/3] drm/mediatek: Fixes for DDP component search/destroy
Date: Thu,  1 Feb 2024 13:53:01 +0100
Message-ID: <20240201125304.218467-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series performs some cleanups for DDP component CRTC search and
correctly iounmaps the previously of_iomap() calls from drm_ddp_comp.

Tested on MT8195 Cherry Tomato

AngeloGioacchino Del Regno (3):
  drm/mediatek: drm_ddp_comp: Fix and cleanup DDP component CRTC search
  drm/mediatek: Perform iounmap on simple DDP component destruction
  drm/mediatek: drm_ddp_comp: Add mtk_ddp_is_simple_comp() internal
    helper

 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 113 +++++++++++++-------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   4 +-
 3 files changed, 80 insertions(+), 38 deletions(-)

-- 
2.43.0


