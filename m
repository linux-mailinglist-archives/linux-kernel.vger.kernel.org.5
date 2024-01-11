Return-Path: <linux-kernel+bounces-23773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2C182B180
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728B31C21E90
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE194C60C;
	Thu, 11 Jan 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3im6bRcD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD84C3D7;
	Thu, 11 Jan 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704986078;
	bh=b+8qG4K5TQjYoC7fpfd4f7Sk/NAtLJcrKL8iFcCbdz4=;
	h=From:To:Cc:Subject:Date:From;
	b=3im6bRcD2+PvwFdsdu72Gg227f+Rg6ZqKp5Q+zo7Rjr57AfpmO0aUczzj1dMulno4
	 +lUlcsMDuSyNayNxUTjLTGeh1vkZ0+PPf4xWyM2rb2sLvChAm9wFxqyJiifsLVwoVV
	 r5U86f1YHXaHPUHsm5E+nuhN6q1qVLP3lkhsw2qBE1EdzHncO62YYc97Smg2LeR6Rl
	 AFjHwRiYuJxN9p3ZVc2fVRl9t6iRllxqtxK99oAOk5JHVrouLz7v+7rX0/6FGG8Z1O
	 ApzbZluzOBJ39zpr56q0yfl9Ar92mlxOD+GTEMmdRVGZpvfTlL30pz0wSUO962z1Wg
	 EbGCNab7YpbTA==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 777703781492;
	Thu, 11 Jan 2024 15:14:30 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Brian Norris <briannorris@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julius Werner <jwerner@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Will Deacon <will@kernel.org>,
	chrome-platform@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Allow coreboot modules to autoload and enable cbmem in the arm64 defconfig
Date: Thu, 11 Jan 2024 12:11:45 -0300
Message-ID: <20240111151226.842603-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This series adds the missing pieces to the coreboot bus and the module
alias generation to allow coreboot modules to be automatically loaded
when matching devices are detected.

The configs for cbmem coreboot entries are then enabled in the arm64
defconfig, as modules, to allow reading logs from coreboot on arm64
Chromebooks, which is useful for debugging the boot process.


Nícolas F. R. A. Prado (4):
  firmware: coreboot: Generate modalias uevent for devices
  firmware: coreboot: Generate aliases for coreboot modules
  firmware: google: cbmem: Add to module device table
  arm64: defconfig: Enable support for cbmem entries in the coreboot
    table

 arch/arm64/configs/defconfig             |  3 +++
 drivers/firmware/google/cbmem.c          |  7 +++++++
 drivers/firmware/google/coreboot_table.c |  9 +++++++++
 include/linux/mod_devicetable.h          |  8 ++++++++
 scripts/mod/devicetable-offsets.c        |  3 +++
 scripts/mod/file2alias.c                 | 10 ++++++++++
 6 files changed, 40 insertions(+)

-- 
2.43.0


