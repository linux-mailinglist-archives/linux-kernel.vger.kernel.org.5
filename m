Return-Path: <linux-kernel+bounces-61840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0459885174D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A541C212F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EF43B79C;
	Mon, 12 Feb 2024 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sZSBT+30"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7381EB2C;
	Mon, 12 Feb 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749482; cv=none; b=X7HvQZXZ2fC+OSnzGqhyinxNk0CAdFeiuZywbvDsiloh0xlCvwGyYcdEgzUv3Dr/QFN9qCr/W7xrRfBF3xuitGWDhBpkXqMVCprRsDDBV5ApoQZQqMrCyb5GgiJgzQX4O8rmGgQZbyvPIzbf9Yl7/KWrfDaSswDaBAkRJH9zIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749482; c=relaxed/simple;
	bh=vqF5jYZNYl0NbSJPxgA2LFrHafN5yO7/CK4g758qgCI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uAEmbW1F3z3+s7kf8p52aFbvNxQ2Xz2PTFc8kg2+d7WgYE2osxSeI65P6QUGJtZ/hZ/6aj0Vl+IbOwUWax32tpvrhY+I/iECf64q8axPKYy/1irAk43sE3WqzuOPqWoEdWBtmfG9UaJOo4CbvfFPLTC44B3u4MM41I41stNhaHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=sZSBT+30; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707749479;
	bh=vqF5jYZNYl0NbSJPxgA2LFrHafN5yO7/CK4g758qgCI=;
	h=From:Subject:Date:To:Cc:From;
	b=sZSBT+30hs5/PAbWzzLzqCmM2iDuayDfRj/GoXrGtp4GC1VV/75p/UEwVKtOBJc3Q
	 gIhNy5ZDlFlVWvMl5Y/pjM884z/4/7dvciBseo3PGG6wdwswsh05crvQLH47Kpcnf6
	 i8iFLJ1K9z1ueGWWAqE7nZ4HaS0v51rolYY2v5EQm8dS6p4507xyTkV1aqIw2UQWtz
	 umSFjAzY7LzyWauRsHoc773dbLGDlkvaWP5nzVHKXA6z+lt4hOfT/DpDAUU2xHfXtO
	 9PS996okVK9LOkztw9zdT8+vqhqUsrSzT9WfT+8bltnM1YkHXRjOL+6Zyyxm1nV2Hz
	 kc4JarBoC5CWQ==
Received: from [192.168.1.30] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 536913780C22;
	Mon, 12 Feb 2024 14:51:15 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v4 0/4] Allow coreboot modules to autoload and enable cbmem
 in the arm64 defconfig
Date: Mon, 12 Feb 2024 09:50:04 -0500
Message-Id: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABwwymUC/4XOywrCMBCF4VeRrJ2Sxnpd6cq1CIKKiySdtANtR
 ye1KNJ3t/YFXP6L83E+KqIQRrWZfJRgR5G4GSKbTpQvbVMgUD60MtpkOk2X4FnQMbdQcw45Bs9
 NoAJWZuF0iiYz+VoN47tgoNcIX29DB+Ea2lLQjtzFHk5HfzC78+O5h4tsY00VJoESalqsEs/1T
 ykptizv8V03+1l/j3Qz0KCz9Xwxt2bpnN16rirrWOyo3vq+/wKAYDKB9gAAAA==
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@collabora.com, 
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

Changes in v4:
- Added driver_data to device_id struct
- Link to v3: https://lore.kernel.org/r/20240117-coreboot-mod-defconfig-v3-0-049565a27bba@collabora.com

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
 include/linux/mod_devicetable.h                | 10 ++++++++++
 scripts/mod/devicetable-offsets.c              |  3 +++
 scripts/mod/file2alias.c                       | 10 ++++++++++
 10 files changed, 75 insertions(+), 6 deletions(-)
---
base-commit: 0f067394dd3b2af3263339cf7183bdb6ee0ac1f8
change-id: 20240117-coreboot-mod-defconfig-826b01e242d9

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


