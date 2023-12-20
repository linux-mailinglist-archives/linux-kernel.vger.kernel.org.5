Return-Path: <linux-kernel+bounces-6866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD13819EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B01F22F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DAF2230A;
	Wed, 20 Dec 2023 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EvcVbVMW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B137D22303
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703074290;
	bh=+josEhuJGZUwIjK128hAQWpYf0mrcfPybBEAagNclmI=;
	h=From:To:Cc:Subject:Date:From;
	b=EvcVbVMWlwNXOErBeYWIsdzjdB0YsnlTkWIZtpas9p0ovFLiljNyZm3NajqSCFMJC
	 s9wqXrwikzH/T6hCko36Eu9zOSz3L1/Nz2AVc5T2QU61m8vC5ClXzH3Gukuzt6cngC
	 x6CRvSxmuuyX6adJldss3c+LYk4LpPZI3X8UBKtlBMUWNQCtlsBb8kq9QWK4x3vXpb
	 NnvOblR/NYoCj2WH8a2si0v/lWxwvx71/NMw8uAMJt9juUPfCbgFF/F0Sc9ExWGUwn
	 ivohO2NPXyasfd6NhyFXRE+FXACvF1vXLdht3tzJfVQ3Ay8oCPqB7XHFJseVgUwV2m
	 NxUPfopUNpNMg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C35443781FD5;
	Wed, 20 Dec 2023 12:11:25 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	daniels@collabora.com
Cc: david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	emma@anholt.net,
	robdclark@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/8] drm/ci: Add support for GPU and display testing
Date: Wed, 20 Dec 2023 17:41:02 +0530
Message-Id: <20231220121110.1441160-1-vignesh.raman@collabora.com>
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

This series depends on,
https://lore.kernel.org/dri-devel/e747581b-d5e0-4622-827b-48fb51fa9711@collabora.com/T/#t

Vignesh Raman (8):
  drm/ci: arm64.config: Enable CONFIG_DRM_ANALOGIX_ANX7625
  drm/ci: mediatek: Test both GPU and display drivers
  drm/ci: rockchip: Test both GPU and display drivers
  drm/ci: meson: Test both GPU and display drivers
  drm/ci: Do not set IGT_FORCE_DRIVER based on driver name
  MAINTAINERS: drm/ci: xfails: add entry for panfrost
  drm/ci: Rename xfails file
  drm/ci: Update xfails

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


