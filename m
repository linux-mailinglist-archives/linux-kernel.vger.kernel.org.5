Return-Path: <linux-kernel+bounces-27212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E7382EC4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD23B22787
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FB913FE9;
	Tue, 16 Jan 2024 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kUhMUzsr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B2013AD5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705398933;
	bh=Br3uGw698JM/9pMD4T/qIt8jhsL/ZVXJur8i5VSo5mA=;
	h=From:To:Cc:Subject:Date:From;
	b=kUhMUzsrw1vmK+qacsxwDUYmr4rGABBLTRQS0y8kE2/LrieDRkb5D9GaSq+GpPnGa
	 w03euI1BQuv0ZFC0Au8IrxLvh3k9KtPqCmVu/mx6mw3qUR6B6OWQrimKh0kZUiJyPJ
	 bFP5++AjL2OxONjb1UVZjm4UxciDokO5zF0zg+S+XRGo09ot4FpCD0yZvQWCDyog1A
	 CJWQIEysMbT3DuoZBJeqvjGTd+uBH6qQ7Hf/9UFYCafc6N2R/fga2WXBHWUohdGr4R
	 OF6b3391CjsOAbSKeL6+fBAs0CS/VO9TTjvbfNWtXCys0PsUM0K69eM74stPcsPYuD
	 3ELywJPSeaDSA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 12A5F3782066;
	Tue, 16 Jan 2024 09:55:28 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniel@fooishbar.org,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] drm/ci: Add support for GPU and display testing
Date: Tue, 16 Jan 2024 15:24:32 +0530
Message-Id: <20240116095439.107324-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some ARM SOCs have a separate display controller and GPU, each with
different drivers. For mediatek mt8173, the GPU driver is powervr,
and the display driver is mediatek. In the case of mediatek mt8183,
the GPU driver is panfrost, and the display driver is mediatek.
With rockchip rk3288/rk3399, the GPU driver is panfrost, while the
display driver is rockchip. For amlogic meson, the GPU driver is
panfrost, and the display driver is meson.

IGT tests run various tests with different xfails and can test both
GPU devices and KMS/display devices. Currently, in drm-ci for MediaTek,
Rockchip, and Amlogic Meson platforms, only the GPU driver is tested.
This leads to incomplete coverage since the display is never tested on
these platforms. This commit series adds support in drm-ci to run tests
for both GPU and display drivers for MediaTek, Rockchip, and Amlogic
Meson platforms.

Vignesh Raman (7):
  drm/ci: arm64.config: Enable CONFIG_DRM_ANALOGIX_ANX7625
  drm/ci: mediatek: Rename exisitng job
  drm/ci: mediatek: Add job to test panfrost and powervr GPU driver
  drm/ci: meson: Rename exisitng job
  drm/ci: meson: Add job to test panfrost GPU driver
  drm/ci: rockchip: Rename existing job
  drm/ci: rockchip: Add job to test panfrost GPU driver

 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/ci/arm64.config               |   1 +
 drivers/gpu/drm/ci/igt_runner.sh              |  10 --
 drivers/gpu/drm/ci/test.yml                   | 107 ++++++++++++++----
 ....txt => mediatek-mt8173-display-fails.txt} |   0
 .../xfails/mediatek-mt8173-display-flakes.txt |  13 +++
 .../xfails/mediatek-mt8183-display-fails.txt  |   7 ++
 .../xfails/mediatek-mt8183-display-flakes.txt |   8 ++
 .../ci/xfails/meson-g12b-display-fails.txt    |  13 +++
 ...-fails.txt => panfrost-g12b-gpu-fails.txt} |   0
 ...ails.txt => panfrost-mt8183-gpu-fails.txt} |   0
 ...ails.txt => panfrost-rk3288-gpu-fails.txt} |   0
 ...kips.txt => panfrost-rk3288-gpu-skips.txt} |   0
 ...ails.txt => panfrost-rk3399-gpu-fails.txt} |   0
 ...kes.txt => panfrost-rk3399-gpu-flakes.txt} |   0
 ...kips.txt => panfrost-rk3399-gpu-skips.txt} |   0
 .../xfails/rockchip-rk3288-display-fails.txt  |  15 +++
 .../xfails/rockchip-rk3288-display-flakes.txt |  13 +++
 .../xfails/rockchip-rk3288-display-skips.txt  |   8 ++
 .../xfails/rockchip-rk3399-display-fails.txt  |  69 +++++++++++
 .../xfails/rockchip-rk3399-display-flakes.txt |  20 ++++
 .../xfails/rockchip-rk3399-display-skips.txt  |   6 +
 22 files changed, 261 insertions(+), 30 deletions(-)
 rename drivers/gpu/drm/ci/xfails/{mediatek-mt8173-fails.txt => mediatek-mt8173-display-fails.txt} (100%)
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-display-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-display-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-display-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-display-fails.txt
 rename drivers/gpu/drm/ci/xfails/{meson-g12b-fails.txt => panfrost-g12b-gpu-fails.txt} (100%)
 rename drivers/gpu/drm/ci/xfails/{mediatek-mt8183-fails.txt => panfrost-mt8183-gpu-fails.txt} (100%)
 rename drivers/gpu/drm/ci/xfails/{rockchip-rk3288-fails.txt => panfrost-rk3288-gpu-fails.txt} (100%)
 rename drivers/gpu/drm/ci/xfails/{rockchip-rk3288-skips.txt => panfrost-rk3288-gpu-skips.txt} (100%)
 rename drivers/gpu/drm/ci/xfails/{rockchip-rk3399-fails.txt => panfrost-rk3399-gpu-fails.txt} (100%)
 rename drivers/gpu/drm/ci/xfails/{rockchip-rk3399-flakes.txt => panfrost-rk3399-gpu-flakes.txt} (100%)
 rename drivers/gpu/drm/ci/xfails/{rockchip-rk3399-skips.txt => panfrost-rk3399-gpu-skips.txt} (100%)
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-display-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-display-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-display-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-display-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-display-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-display-skips.txt

-- 
2.40.1


