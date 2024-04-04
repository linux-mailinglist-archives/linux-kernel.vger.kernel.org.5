Return-Path: <linux-kernel+bounces-131061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01D789829D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38817B233B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F2F5D72F;
	Thu,  4 Apr 2024 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NX6sNIxx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A45D461
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217481; cv=none; b=I8HEQWJ85udG+IIAW6T0V3W6Bn+I55QsA514dydBbqOtqqcGgT2NXCRFmHSR66Y5woQQpNnFTBGa32+MSz9pNh6kfaGqq/eH/35redHJuTcPZDj7aFPK99V/goxWZwibgEr8q1zxY+b+d5jIF2yooIN6CnJSd5dggncLUPU/Pf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217481; c=relaxed/simple;
	bh=JR03O6DqtWABDbF+UOdTpqbBb6MC16JinmCC+MPaEF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y25tFg1tdsjUV/qC52J7DONyFQSpeviTFu4IASiWiWh9brLdjQOonypbYLGRiXCXqpWM32u+lAcNVkXG9RFFC+3ZEpTMMS9pfZDWJjWkbJCAvkR7L5U17uonnxVlWiX54irmH0B+rzocOXWCEW7g+YknRPW/9Xsceg7Ehn2U2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NX6sNIxx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712217477;
	bh=JR03O6DqtWABDbF+UOdTpqbBb6MC16JinmCC+MPaEF8=;
	h=From:To:Cc:Subject:Date:From;
	b=NX6sNIxxfrVG0gUBHik5LbRQh3vPBIVl+iz/L8TLewL2G9Zr5eU+16R/ZPZQ8U1f/
	 417XkgyZ9trxK6wGGymLro2RJ8Emegg5FvEDpcwLhl+SNhpChMFIuBrMsvisR5kNJ+
	 XOLai6pqtm4XYbxlsnRKoWIR7ITgdE9/aSOjZSvIFCoLO8DSOssa9ppH+LN3+WAUbk
	 CYG9rDEk0sEdJdjlAn3cmVMZYyIUM4KcUTGypSaEjo/87DaeWXwxOhSnNcLb01GZAP
	 PGRsa7eCaO+TLwsm3YkJFGzmfGDK9ScyLmHZv+HtD1kyQVf7EQKef+a9ptAOZ3PetT
	 j4tj8H2HPMrcw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DD48D378209A;
	Thu,  4 Apr 2024 07:57:56 +0000 (UTC)
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
Subject: [PATCH v2 0/3] drm/mediatek: Fixes for DDP component search/destroy
Date: Thu,  4 Apr 2024 09:57:51 +0200
Message-ID: <20240404075754.83455-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Fixed patch [2/3]

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
2.44.0


