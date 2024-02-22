Return-Path: <linux-kernel+bounces-76299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A989385F560
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD0A1F2280B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ECD3B290;
	Thu, 22 Feb 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JA0FAOaV"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC139867;
	Thu, 22 Feb 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596757; cv=none; b=KNG1YdQRoxXb7tp5rSqhTX8OWmV86im/Pw3ofzMub+5lKSSygebwpBPFAl05k+XhiSNYA75qCibcsrguHCQ74HqNmc2kUyEbli+C1NHvlNzB/ysm02EgS+PlLDphCG4Jou8IZ4+CfLmgKnpsZXyZUdHJFKWzVWQNmmZjnFR51L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596757; c=relaxed/simple;
	bh=roIxjecpP/8DxCcjT0Gc9PACGeN4BQzA4Cmr5z1pWmk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TB/weGn7xhUJGqGBHnwcyGbFdxwyBIu6+jgTGBjhbpwx0XjwmqxbGVe52+06TNjVU401kyLwux0gyHlz0Wiub9ytordhgjIKLt1XD1xVWFGDirjMrZnRvU9OHDK2UyJhWdCaSstEPs5IjnxDXYWEzQrIf8BQ+CYvhIIQX2ZsR6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JA0FAOaV; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41F4D20014;
	Thu, 22 Feb 2024 10:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708596750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uEtrp1hJ8l8g9RQ2Sx4SLv4ASiAqlpUXE/wBmGapgZU=;
	b=JA0FAOaVYo1LbgUm6xqtARBie2nRJv+5vowT6WoZ8BMPtdLALJRWNwoeprLo8+3XRtb0+1
	tXOri8yXZuH/g/fWwCrQc8EfwdJ7uNE8R4XrZcREMtw1PqQfTP+/hRrEYJ9nHMZFGlKlHV
	pqKHpQdJ+J4tRUm8cx8rKOCzZoZcckJKAs40Qx3NWk9qcsPLrAFfsMycgjFJowyJ4ehRBU
	AYQyF0G5/1rxUpFTAqEwBDocLFemDxw1CrPvuY+1re6B93eK0x/WX0tSO1NJty6PBYHWv+
	XYk//oSUxT6N0vRo7mMK7l9k8u/0Rou+xnHtGoFrYVfzjn5Z4CHaIgqqs2Qm8A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v4 0/4] spi: cadence-qspi: Fix runtime PM and system-wide
 suspend
Date: Thu, 22 Feb 2024 11:12:28 +0100
Message-Id: <20240222-cdns-qspi-pm-fix-v4-0-6b6af8bcbf59@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAwe12UC/33NTQ6CMBAF4KuYrh1ThlLAlfcwLuifNJEWW0I0h
 LtbWGEkbiZ5L3nfTCTqYHUk58NEgh5ttN6lwI4HItvG3TVYlTJBioymA1K5CM/YW+g7MPYFWHN
 KpeSqFIakWR90qlfyeku5tXHw4b1+GLOl/YONGWSQy8pogcIoVV2E98PDupP0HVm4EbdEsUMgU
 EBdCtEoVjeM/xL5lqh3iDwRBaONRESDXHwT8zx/ABu3ecQ4AQAA
To: Mark Brown <broonie@kernel.org>, Apurva Nandan <a-nandan@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

This fixes runtime PM and system-wide suspend for the cadence-qspi
driver. Seeing how runtime PM and autosuspend are enabled by default, I
believe this affects all users of the driver.

This series has been tested on both Mobileye EyeQ5 hardware and the TI
J7200 EVM board, under s2idle.

Thanks all,
Théo

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v4:
- Take Reviewed-by Dhruva Gole on patch 1/4.
- Fix struct dev_pm_ops declaration to avoid -Wunused-function warning
  when CONFIG_PM_SLEEP=n. Replace SET_*_PM_OPS() by *_PM_OPS(). See
  kernel test robot warning:
  https://lore.kernel.org/oe-kbuild-all/202402221505.712Q7MSU-lkp@intel.com/
- Link to v3: https://lore.kernel.org/r/20240209-cdns-qspi-pm-fix-v3-0-540ac222f26b@bootlin.com

Changes in v3:
- Move both bugfix patches to the start of the series.
- Remove Fixes: trailer from the function renaming patch.
- Link to v2: https://lore.kernel.org/r/20240205-cdns-qspi-pm-fix-v2-0-2e7bbad49a46@bootlin.com

Changes in v2:
- Split the initial change into three separate commits, to make intents
  clearer.
- Mark controller as suspended during the system-wide suspend.
- Link to v1: https://lore.kernel.org/r/20240202-cdns-qspi-pm-fix-v1-1-3c8feb2bfdd8@bootlin.com

---
Théo Lebrun (4):
      spi: cadence-qspi: fix pointer reference in runtime PM hooks
      spi: cadence-qspi: remove system-wide suspend helper calls from runtime PM hooks
      spi: cadence-qspi: put runtime in runtime PM hooks names
      spi: cadence-qspi: add system-wide suspend and resume callbacks

 drivers/spi/spi-cadence-quadspi.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)
---
base-commit: 13acce918af915278e49980a3038df31845dbf39
change-id: 20240202-cdns-qspi-pm-fix-29600cc6d7bf

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


