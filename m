Return-Path: <linux-kernel+bounces-24680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A9E82C0CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98E62828BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2D86D1A1;
	Fri, 12 Jan 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uz1bjXYH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51459B4D;
	Fri, 12 Jan 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705065670;
	bh=N49cN0M7bvB/ub5EP9AcuTijLYZG5qsI/dJkk5dugrA=;
	h=From:To:Cc:Subject:Date:From;
	b=uz1bjXYHA1bE4HFkpLIXMDhPQhkzVSx2oCCDlhCzkpe5DSFhXckci/NSupTYQI2D2
	 9RZhwp+nliPfAiB0M3mMmHDGRZLsbYqJUHs0CS7A4VeUSHpUvcbMacoveirsqOni8L
	 bx18j3TvRBwgpqtWWWj2j16CBY1Ioni1yexK8Y4xVaUqwhq/FWxJyIq6OIhPjsiAph
	 FlAnNQCt+Mpr+PAwsq1Jc5WdiK8Cgr2/+g/ZjUD5KIigc/PpHH2FheG+N6nIunZl4I
	 uASvtagGFPuB3kO8jDDf25ZNeC+QeCyRZup/Xn0tDMxutyQkaC8HZNx4k5MskpEmSj
	 BGoGMs83S6CIw==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A7EDF3781FE5;
	Fri, 12 Jan 2024 13:21:01 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chrome-platform@lists.linux.dev,
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
	linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] Allow coreboot modules to autoload and enable cbmem in the arm64 defconfig
Date: Fri, 12 Jan 2024 10:18:29 -0300
Message-ID: <20240112131857.900734-1-nfraprado@collabora.com>
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

Changes in v2:
- Added commits for vpd, memconsole and framebuffer drivers to add them
  to the module device table

Nícolas F. R. A. Prado (7):
  firmware: coreboot: Generate modalias uevent for devices
  firmware: coreboot: Generate aliases for coreboot modules
  firmware: google: cbmem: Add to module device table
  firmware: google: vpd: Add to module device table
  firmware: google: memconsole: Add to module device table
  firmware: google: framebuffer: Add to module device table
  arm64: defconfig: Enable support for cbmem entries in the coreboot
    table

 arch/arm64/configs/defconfig                   |  3 +++
 drivers/firmware/google/cbmem.c                |  7 +++++++
 drivers/firmware/google/coreboot_table.c       |  9 +++++++++
 drivers/firmware/google/framebuffer-coreboot.c |  7 +++++++
 drivers/firmware/google/memconsole-coreboot.c  |  7 +++++++
 drivers/firmware/google/vpd.c                  |  7 +++++++
 include/linux/mod_devicetable.h                |  8 ++++++++
 scripts/mod/devicetable-offsets.c              |  3 +++
 scripts/mod/file2alias.c                       | 10 ++++++++++
 9 files changed, 61 insertions(+)

-- 
2.43.0


