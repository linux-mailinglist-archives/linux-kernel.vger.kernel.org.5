Return-Path: <linux-kernel+bounces-119515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC8D88C9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCF71F82B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814B1CAAD;
	Tue, 26 Mar 2024 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X6UxlCv/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415961BDDC;
	Tue, 26 Mar 2024 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471957; cv=none; b=QZdA+eP17skFBUREJ46v0d0TnARqSbkRrSTnbonMaTJIWRBDkdL0f3JKh4K8wJHdXm8O3RuMfdxktqYZdd7/n47ijClse9hlMD/GCxN7Ke7NLjZRsupFhrfZCVrQ2UlFE/yb142v/9yoYz+mANTnhhyVeA4SR9ei4qHz2yYSNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471957; c=relaxed/simple;
	bh=nSq4r4RjZUrOs5YaJtXgzlCcDxFx7tzP4v13Qcx6tx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sGmU2BwgdzsVoh1lVzRpiB71B123C+MqQFG868TmUkj99VDiXk+g00wNYyqvhzMgpi7oVpgWFaMdH5A1+qff2tar8sE5HvLu8s0473J9Kydj6vXnlPug6JlEUpZJsFND9wovTCVutSkq1DLa/KCcAPEC28/DbesXE73AsJqAn+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X6UxlCv/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711471953;
	bh=nSq4r4RjZUrOs5YaJtXgzlCcDxFx7tzP4v13Qcx6tx0=;
	h=From:To:Cc:Subject:Date:From;
	b=X6UxlCv/gMLrh81SBwmVexV45x4sbYNlTNqsCcTuzTw22jN4JyCQEDouBR8dl8IIZ
	 PYogZy++HKCN7tLFAsAYE4d9TUEWZyCM2aT5TLcEkwL9H7dLEvyDXs2I5PFOjRONhN
	 IRrwPloXlPs81ae1Px7SDcHHauT9uHFu/SwyeqhKB1VHD5UvevcNbosOkh+4pSm72t
	 W3Mga5EA9ZUuR2zLAo8XfrIfS0eUQmn5vq/BxI26T4JAhCCkBojVxA2OSGptnEdJPm
	 28kitJIB75lFndepd5q8p5L26OfHSb2ye0QikIS7F9ZZvJ1Whg0wSbMPc8C9VkfEJA
	 djMhOPc2D9QBA==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 69B8F378203E;
	Tue, 26 Mar 2024 16:52:33 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 106E94800CD; Tue, 26 Mar 2024 17:52:33 +0100 (CET)
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
Subject: [PATCH v2 0/4] RK3588 GPU support
Date: Tue, 26 Mar 2024 17:52:04 +0100
Message-ID: <20240326165232.73585-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Panthor has landed in linux-next including the DT bindings, so it is
time to add the necessary DT changes to support the GPU on RK3588.
This adds support at SoC level and support for the EVB1 as well as
the Rock 5B, which covers both variants found in RK3588 boards:

1. Having dedicated regulators for GPU core and GPU memory. This
   is handled by coupling both regulators.
2. Having a shared regulator for GPU core and GPU memory.

I prepared a branch with the GPU DT changes (and the panthor driver
changes for testing, consdering they do not clash) based on Heiko's
for-next branch:

https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commits/rk3588-gpu

Changes since PATCHv1:
 - https://lore.kernel.org/all/20240325153850.189128-1-sebastian.reichel@collabora.com/
 - remove always-on from the GPU regulator in the Rock 5B patch
 - add comment to the always-on for the GPU regulators in the EVB1 patch
 - add explanation for the always-on in the EVB1 commit description

Greetings,

-- Sebastian

Boris Brezillon (3):
  arm64: dts: rockchip: rk3588: Add GPU nodes
  arm64: dts: rockchip: rk3588-rock5b: Enable GPU
  arm64: dts: rockchip: rk3588-evb1: Enable GPU

Sebastian Reichel (1):
  arm64: defconfig: support Mali CSF-based GPUs

 .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 14 +++++
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |  5 ++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 56 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 4 files changed, 76 insertions(+)

-- 
2.43.0


