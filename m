Return-Path: <linux-kernel+bounces-29345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD42830D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D091F21C41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7545249E0;
	Wed, 17 Jan 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zwEWMCFd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED919241E0;
	Wed, 17 Jan 2024 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705518351; cv=none; b=BtQOJFXf/ZVfLqC3Ks/vmUqje5bQR3i1UabLkNS0Tk00EP9BHEfwdx/D2PsaGwWDdHYpAeAFxcSGVmrCbexU7jBi9Ai7xbymQxHlqJhgQcruqMlvXkyZSvRhP4rmBFhsBZm8x4pcZS+4trUX9BdgUSkh2E26wnOz9nbFNP0Cqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705518351; c=relaxed/simple;
	bh=2p7PxDeWr9PiIww3WFCI2erGr5A6HQLNiCFMet8yz3w=;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:
	 X-Mailer; b=ZKhlHF9FT3JOGEnl1L5FxfvlyDT22w/kbWy8cPqpZYQRV8zPbpwBP9v8G4MUcXCwwKkjzSfJ1cw3rLILiqrmapCnDYRM5BvoDyqPLriu1vuJmxJ5FJI7+eXd7Gvrgl3f2J52d3pPe1iLiI81+aVkXr/bSJ+7iS+W7T3wo3VAGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zwEWMCFd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705518347;
	bh=2p7PxDeWr9PiIww3WFCI2erGr5A6HQLNiCFMet8yz3w=;
	h=From:Subject:Date:To:Cc:From;
	b=zwEWMCFd4TnrY+iOA9adVVxxZGPSNRHRA3y3ik9rtmousM99awysSOVuMa+oglkZB
	 76PH+dJ6m0/7dtZLEUKVL+Gyul2auVmolGUKia6dZxHLLzmQ2gaeIqE/R9pf67FE0C
	 JTEzCQp03C4lBo3ci9BqULZhkRg1xIxuKYjmxj88ZeCGYpDHJyfW0Loiu0f1r1xFFD
	 kiGALPZtSLVQNDoaBCuMuNYriRuqlmjn7cs5L0JPShDdYmJw9x3LnaSrXEZO4tSFgi
	 aqEKc1m8uBzskyfJvd8Nw8BVYbS9ujH7+y8a1r72R54ORsdrLwNhbr/rAy7sp9g8QD
	 dC5O1//+04ZnQ==
Received: from [192.168.0.47] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BD792378000E;
	Wed, 17 Jan 2024 19:05:41 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v3 0/4] Allow coreboot modules to autoload and enable cbmem
 in the arm64 defconfig
Date: Wed, 17 Jan 2024 16:03:21 -0300
Message-Id: <20240117-coreboot-mod-defconfig-v3-0-049565a27bba@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHkkqGUC/x3MPQvCMBCA4b9SbjaljcWvSSfnIghWHNrk0h40O
 b1UEUr/u8HxGd53hohCGOGQzSD4oUgcEtarDMzQhh4V2WTQha6Kstwqw4Id86Q8W2XRGQ6OerX
 Tm64oUVfa7iHFT0FH3//4/kh2wl5Ng2D73zVtfb2YWp9ur/dZNXKMnkbMHeUUJhxzwx6W5Qehc
 0D8ngAAAA==
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, kernel@collabora.com, 
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

This series adds the missing pieces to the coreboot bus and the module
alias generation to allow coreboot modules to be automatically loaded
when matching devices are detected.

The configs for cbmem coreboot entries are then enabled in the arm64
defconfig, as modules, to allow reading logs from coreboot on arm64
Chromebooks, which is useful for debugging the boot process.

Changes in v3:
- Merged all "add to module device table" commits into a single commit
  which also changes the coreboot_driver struct to contain an id table
  and avoid unused variable warnings for the id tables.

Changes in v2:
- Added commits for vpd, memconsole and framebuffer drivers to add them
  to the module device table

---
Nícolas F. R. A. Prado (4):
      firmware: coreboot: Generate modalias uevent for devices
      firmware: coreboot: Generate aliases for coreboot modules
      firmware: coreboot: Replace tag with id table in driver struct
      arm64: defconfig: Enable support for cbmem entries in the coreboot table

 arch/arm64/configs/defconfig                   |  3 +++
 drivers/firmware/google/cbmem.c                |  8 +++++++-
 drivers/firmware/google/coreboot_table.c       | 20 +++++++++++++++++++-
 drivers/firmware/google/coreboot_table.h       |  3 ++-
 drivers/firmware/google/framebuffer-coreboot.c |  8 +++++++-
 drivers/firmware/google/memconsole-coreboot.c  |  8 +++++++-
 drivers/firmware/google/vpd.c                  |  8 +++++++-
 include/linux/mod_devicetable.h                |  8 ++++++++
 scripts/mod/devicetable-offsets.c              |  3 +++
 scripts/mod/file2alias.c                       | 10 ++++++++++
 10 files changed, 73 insertions(+), 6 deletions(-)
---
base-commit: 0f067394dd3b2af3263339cf7183bdb6ee0ac1f8
change-id: 20240117-coreboot-mod-defconfig-826b01e242d9

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


