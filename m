Return-Path: <linux-kernel+bounces-129617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ECB896D70
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525971C2577F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCBB1411F6;
	Wed,  3 Apr 2024 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXdoFXuU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779CE135A5F;
	Wed,  3 Apr 2024 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141790; cv=none; b=LjgL6qbzD1HD4zafXBlW/K3EbsyLhfx7j8Z2ds+dFA/+d1DKNiminJT4XEhHyV0N4TEvIr4obAcJI51qxd3nxcmVQbG24EBfREG06O9/8NfBGqpCf/QKqj6f5Rmdbl6CrW25AoknlCTKW9SXvNktxGgCmhDZVb2BOGP3LricHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141790; c=relaxed/simple;
	bh=XdIwcCPhuveqD8bBR+019+3CwCmU7ZniwCgd3MFtbCc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rLTqTpNLKdjNvNRjdT+CPGm15tlLwhoLjbRuply88lW/TyvVvOl9QT/6aZ9qYPD0TLrNlDVGwBvECtg2QNksrJ8YHJbY3ukd2nohIcWDOsfyu/fYaYA9+3oaDsmB5JcZHzRR49a+d5QrUfhB2v7FM3cbXr6yU+HqPkAuHHhBIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXdoFXuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB03C433F1;
	Wed,  3 Apr 2024 10:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712141790;
	bh=XdIwcCPhuveqD8bBR+019+3CwCmU7ZniwCgd3MFtbCc=;
	h=From:Subject:Date:To:Cc:From;
	b=DXdoFXuUW+8Nq2JfxVf2S9TcNFhcA/R86O0iwT+pSi0YDqlykbUFe6VbYwW8I6sXL
	 L/oRZ8dYQHJhgNK4aSVG/t/OKisTgy+xoRpkCauk2WOm1szJ6DdHl/C3NkIMfYHUYq
	 0B0dZRKLbcMhNfqQrsDgHBk3MSKVGcJVi5I6b0Z1RweJ6iM63rGTgyUJNsytq+uf4f
	 /QBWsaWc0s09kqgWF6dWH3YG450QqyqP4WyDEDcS7WLWKvQGgscWjOaHSs+xy5WF4/
	 FUvjSL4tnDhuxLPQgc4hMqMliIz4wqsAanBSdKgrefSt6bCpJSeFFUNlVexZzFUJoK
	 SI62ew7f/7d4w==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 0/7] drm/display: Fix display helpers depends on fallouts
Date: Wed, 03 Apr 2024 12:56:18 +0200
Message-Id: <20240403-fix-dw-hdmi-kconfig-v1-0-afbc4a835c38@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANI1DWYC/x2MQQqAIBAAvxJ7bkEtKvpKdLBcdYksFCqQ/p50H
 JiZDIkiU4KxyhDp4sRHKCDrClavgyNkUxiUUK1oRYOWHzQ3erMzbusRLDsU3bBIJYk09VDKM1L
 R/us0v+8HNAX6m2UAAAA=
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Mark Brown <broonie@kernel.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-sunxi@lists.linux.dev, linux-mips@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=mripard@kernel.org;
 h=from:subject:message-id; bh=XdIwcCPhuveqD8bBR+019+3CwCmU7ZniwCgd3MFtbCc=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGYNNdOgCj7VWN3K5T28OX9gNdW2mEeuJ7JXTIM7EEcijqtbF
 YiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmYNNdMACgkQJ1/OGaI9vnaKUAGAsmkB
 dfB4R9+KjUzCcpEypmjcJd/rkeSmjBxvX8hqAKlQGjxl8SMRtNrxTDjMqYCWAYCSvqJ20Wh3gmK
 8H4YFGkCAg8wkZolIwWoyNIB94It5sLotonDUNhddTFPaPwLp+nk=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Hi,

Here's a series addressing the various regressions that were reported
after the Kconfig rework for the DRM display helpers.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Maxime Ripard (7):
      drm/display: Select DRM_KMS_HELPER for DP helpers
      drm/bridge: dw-hdmi: Make DRM_DW_HDMI selectable
      ARM: configs: imx_v6_v7: Enable DRM_DW_HDMI
      ARM: configs: multi_v7: Enable DRM_DW_HDMI
      ARM: configs: sunxi: Enable DRM_DW_HDMI
      arm64: defconfig: Enable DRM_DW_HDMI
      mips: configs: ci20: Enable DRM_DW_HDMI

 arch/arm/configs/imx_v6_v7_defconfig    | 1 +
 arch/arm/configs/multi_v7_defconfig     | 1 +
 arch/arm/configs/sunxi_defconfig        | 1 +
 arch/arm64/configs/defconfig            | 1 +
 arch/mips/configs/ci20_defconfig        | 1 +
 drivers/gpu/drm/bridge/synopsys/Kconfig | 2 +-
 drivers/gpu/drm/display/Kconfig         | 1 +
 7 files changed, 7 insertions(+), 1 deletion(-)
---
base-commit: 727900b675b749c40ba1f6669c7ae5eb7eb8e837
change-id: 20240403-fix-dw-hdmi-kconfig-068b121eeae7

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>


