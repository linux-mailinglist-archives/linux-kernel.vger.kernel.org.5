Return-Path: <linux-kernel+bounces-93265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAA7872D43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F64E1C25F20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6EB134BF;
	Wed,  6 Mar 2024 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WiG5bB37"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E25DF44
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694477; cv=none; b=RQ9NzSsa7Nu9fth9KBKNyE/00RlnYnqjDulSydTAd7JpqZbG46O6Z5fVp0iSk++B/CBjmb1TJB2QfGmHIFNSLycnAy/5k/XTHwtQhhJeDKOsLs1oqKyWTuf0K3qT6gJ7JLhKN7HFX6nWVdDmzNvGX+arNRtBCivUv+WNFJ9/c0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694477; c=relaxed/simple;
	bh=rQ4HSBtJq4l4wg78LRafhWAkcPU1REZOPCnYnWYSXBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BdwmqZEhdxbrdAcUvG4k3rk/GczxNZ1rEJV06J5fy5gND/Y/+Eu4Ehf0SfIeES5t7/6qa0l+97C8HGXY8XFTeTxb9noAkLnuD0RGKrnb3VPrYvWJEfUVUVbKpQZsx1TRlWo7QIRaeU12ogiU7ljAAjGyrOq3EdRT7NPbzIW5Zgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WiG5bB37; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709694473;
	bh=rQ4HSBtJq4l4wg78LRafhWAkcPU1REZOPCnYnWYSXBs=;
	h=From:To:Cc:Subject:Date:From;
	b=WiG5bB372O0BYCJJfKRV5VbsJ5cz187TZ1XzzYVqx0fZBiHXyFzzK4DgSyY4fXWdA
	 FNfoNY3vnbq5w7d0wMl3UXakJFeVpPqdxwZaiqnoi28WNQtjgZ4wm+F+InINmFxQQl
	 2ZMEVdSxbSs+oXEDOkJevdMcromjFpPz9lWhig3E59PsM5+01xtztzS9EyI2Pdirlb
	 cNkMpxfnTOc7QgqLo9Ms9So0Od4Y6KfkdVhbqU3QAoTw6LcqVzPVTqMUg+ApL5w/xW
	 JR6Q6MVPnZnSsN+kE9GxH1gVpXr7uUlG31Q4XCIILvpZyk9EvD9esNJH6DWN7Udoii
	 2xjVodD+s8mpQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 31D5A3780624;
	Wed,  6 Mar 2024 03:07:49 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	emma@anholt.net,
	robdclark@gmail.com,
	david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	hamohammed.sa@gmail.com,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	mairacanal@riseup.net,
	mcanal@igalia.com,
	linux-mediatek@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/11] drm/ci: Add support for GPU and display testing
Date: Wed,  6 Mar 2024 08:36:38 +0530
Message-Id: <20240306030649.60269-1-vignesh.raman@collabora.com>
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

Uprev mesa and IGT in drm-ci and add amd, v3d, vc4 and vgem specific
tests to testlist. Have testlist.txt per driver and include a base
testlist so that the driver specific tests will run only on those hardware
and add testlists to the MAINTAINERS file.

This series also includes patch to add vkms testing to drm-ci.

Working pipeline link,
https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1119859

Vignesh Raman (11):
  drm/ci: arm64.config: Enable CONFIG_DRM_ANALOGIX_ANX7625
  drm/ci: uprev mesa version
  drm/ci: uprev IGT and update testlist
  drm/ci: amdgpu: update xfails
  drm/ci: mediatek: Refactor existing mediatek jobs
  drm/ci: mediatek: Add job to test panfrost and powervr GPU driver
  drm/ci: meson: Refactor existing meson jobs
  drm/ci: meson: Add job to test panfrost GPU driver
  drm/ci: rockchip: Refactor existing rockchip jobs
  drm/ci: rockchip: Add job to test panfrost GPU driver
  drm/ci: add tests on vkms

 MAINTAINERS                                   |  14 ++
 drivers/gpu/drm/ci/arm64.config               |   1 +
 drivers/gpu/drm/ci/build.sh                   |   1 -
 drivers/gpu/drm/ci/container.yml              |   6 +-
 drivers/gpu/drm/ci/gitlab-ci.yml              |  13 +-
 drivers/gpu/drm/ci/igt_runner.sh              |  28 ++--
 drivers/gpu/drm/ci/image-tags.yml             |   5 +-
 drivers/gpu/drm/ci/test.yml                   | 136 +++++++++++++---
 drivers/gpu/drm/ci/testlist-amdgpu.txt        | 151 ++++++++++++++++++
 drivers/gpu/drm/ci/testlist-msm.txt           |  50 ++++++
 drivers/gpu/drm/ci/testlist-panfrost.txt      |  17 ++
 drivers/gpu/drm/ci/testlist-v3d.txt           |  73 +++++++++
 drivers/gpu/drm/ci/testlist-vc4.txt           |  49 ++++++
 drivers/gpu/drm/ci/testlist.txt               |  84 ++++------
 drivers/gpu/drm/ci/x86_64.config              |   1 +
 .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |  26 ++-
 .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |  10 +-
 .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt |  17 +-
 .../drm/ci/xfails/mediatek-mt8173-fails.txt   |  15 --
 .../drm/ci/xfails/mediatek-mt8173-flakes.txt  |  13 ++
 .../drm/ci/xfails/mediatek-mt8183-fails.txt   |  21 ++-
 .../drm/ci/xfails/mediatek-mt8183-flakes.txt  |   8 +
 .../gpu/drm/ci/xfails/meson-g12b-fails.txt    |   5 -
 .../gpu/drm/ci/xfails/panfrost-g12b-fails.txt |   1 +
 .../gpu/drm/ci/xfails/panfrost-g12b-skips.txt |   2 +
 .../drm/ci/xfails/panfrost-mt8183-fails.txt   |   1 +
 .../drm/ci/xfails/panfrost-mt8183-skips.txt   |   2 +
 .../drm/ci/xfails/panfrost-rk3288-fails.txt   |   1 +
 .../drm/ci/xfails/panfrost-rk3288-skips.txt   |   2 +
 .../drm/ci/xfails/panfrost-rk3399-fails.txt   |   1 +
 .../drm/ci/xfails/panfrost-rk3399-skips.txt   |   2 +
 .../drm/ci/xfails/rockchip-rk3288-fails.txt   |  58 ++-----
 .../drm/ci/xfails/rockchip-rk3288-flakes.txt  |  20 +++
 .../drm/ci/xfails/rockchip-rk3288-skips.txt   |  54 +------
 .../drm/ci/xfails/rockchip-rk3399-fails.txt   |  38 +++--
 .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |  28 +++-
 .../drm/ci/xfails/rockchip-rk3399-skips.txt   |   5 +-
 .../drm/ci/xfails/virtio_gpu-none-fails.txt   |   1 -
 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt |  33 ++++
 .../gpu/drm/ci/xfails/vkms-none-flakes.txt    |  20 +++
 drivers/gpu/drm/ci/xfails/vkms-none-skips.txt |  16 ++
 41 files changed, 784 insertions(+), 245 deletions(-)
 create mode 100644 drivers/gpu/drm/ci/testlist-amdgpu.txt
 create mode 100644 drivers/gpu/drm/ci/testlist-msm.txt
 create mode 100644 drivers/gpu/drm/ci/testlist-panfrost.txt
 create mode 100644 drivers/gpu/drm/ci/testlist-v3d.txt
 create mode 100644 drivers/gpu/drm/ci/testlist-vc4.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-mt8183-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-mt8183-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-skips.txt

-- 
2.40.1


