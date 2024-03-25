Return-Path: <linux-kernel+bounces-117388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A804088B268
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9028CBC5701
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFE0131199;
	Mon, 25 Mar 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wJ3Mm+NC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0C9134A8;
	Mon, 25 Mar 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381152; cv=none; b=Tr3HyeJztwlEhS0JunxsTqDEnRB9Sfs6SJsONrXyVBv+rG62g7HG6StlRcLkrgMCAtTSU+dbDRaybU55OQv3VtDstybbyw/Z31BEQzHUf34rDGBR5zdmmqSbeMo6yVs3UALDWQ6xpj53cRxmfJH5iUnlb+KBkZezKAA5OfJUAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381152; c=relaxed/simple;
	bh=eDSWSlvCFCBCqyz3tM1ndbJv6u/boDrdUsa0Ff2ETvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwQclTeNHSONQfr1670Su/hx2fyAYiOtZ9Z8pHhwskvoymac4UrUJCEcnsk7PkEhG3zp7p8SWSU8uciN6hfMM+lOP0kOQhnCOgl/sgLwgpJ1E+BbWy3SjxqZZ2uklK8TxWxuui0Fv1vt7uKxXN7fci/8kAZq8ew5dkU+2HESGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wJ3Mm+NC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711381148;
	bh=eDSWSlvCFCBCqyz3tM1ndbJv6u/boDrdUsa0Ff2ETvw=;
	h=From:To:Cc:Subject:Date:From;
	b=wJ3Mm+NCKbuphV/C/MRynrkovxSVrxe8f1FZnRmKED8N2GsnZXIOGlGu4Ux+DZZNV
	 JTFIpWrqSNYQJFWZhvSYajh6iTFR9sNViWTrCkEidiTzf/c1w5z2cVAMl2WhNPu6Yb
	 o+Dac1r4VOnEQbGl27HHiqEn4yORL+BbP5Au+1VKGbyfGnyPUmmehAacuUU5sQItZi
	 R1T4gbmt8NT+VQ7NQ31aq1lEtlm+LcwheSDT5xBQm8z63EUhGc2yfuYx2wn2OyEPNd
	 N2P1ntytpcjihj85j1zV5qIOcPYe3IvN1wWfuYcfSlADxgH8cJc+4C5yo/1OvxtgB4
	 H4txtPW40J57w==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DADF937820D9;
	Mon, 25 Mar 2024 15:39:07 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 6E7C84800CD; Mon, 25 Mar 2024 16:39:07 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 0/4] RK3588 GPU support
Date: Mon, 25 Mar 2024 16:37:17 +0100
Message-ID: <20240325153850.189128-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Panthor has landed in drm-misc-next including the DT bindings, so
let's add the necessary DT changes to support the GPU on RK3588.
This adds support at SoC level and support for the EVB1 as well as
the Rock 5B, which covers both variants found in RK3588 boards:

1. Having dedicated regulators for GPU core and GPU memory. This is
   handled by coupling both regulators.
2. Having a shared regulator for GPU core and GPU memory.

I prepared a branch with just the GPU DT changes (and the panthor driver
changes) based on Heiko's for-next branch:

https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commits/rk3588-gpu

Greetings,

-- Sebastian

Boris Brezillon (3):
  arm64: dts: rockchip: rk3588: Add GPU nodes
  arm64: dts: rockchip: rk3588-rock5b: Enable GPU
  arm64: dts: rockchip: rk3588-evb1: Enable GPU

Sebastian Reichel (1):
  arm64: defconfig: support Mali CSF-based GPUs

 .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 12 ++++
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |  6 ++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 56 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 4 files changed, 75 insertions(+)

-- 
2.43.0


