Return-Path: <linux-kernel+bounces-59390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C984F63A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847951C216A0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43EE4D59B;
	Fri,  9 Feb 2024 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NKfMpnno"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D94D11B;
	Fri,  9 Feb 2024 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486974; cv=none; b=F7LiEy5bo+Ku+gCAptKSgfEK/8FWpW8ysDnB+ho+MirX7XGwPuEC42FpEjx8sQK/v5x3gyOJzAk5Y/zqgoyLdyePbp4CIW3cVCTvXt4XT9EfTMP0OJyY6TXttsLRo5H+XIqww/NPInKJv7F7+r4uEO7K985dBA+bO4YPhqiHb3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486974; c=relaxed/simple;
	bh=q3WWcXRBxiS9POf55jZdpXHtSVHQ32Mz7FXZ97im8JA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kFOwjsLxqEXE3bEBNbDOLxFZ4YsF/LLV3UJ8e8FbHN2t76quvR4Urk8WRhOZbcAseBDFA06E0AI+FMvPyMEFzYEuXGJwu7Mn/b4by6t4HB72HJ/B+LwSL8S0A3leFhwEdrtZEHfAlLyA+sBqmpBWEVKfLsMSt8LsAwBMFiEWvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NKfMpnno; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C6E81BF20B;
	Fri,  9 Feb 2024 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707486964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K2Ajf63ac1ZCRPlzKX21YZIuRaT9NuCc0/Fe29HC9tg=;
	b=NKfMpnnoA/QCpuq7yKAIHS3NYgtyYrD9NnLHNd9gspZ9/2bPpoxYyaLosqrFrtcclu6Lco
	7zSpMFlXjRx68rPOXporfOgMil5Dy8X/0OHfxL22GEXSZN3BLXAWvEkGvxZhyCc2csGodN
	/c/G0MnotPeDF/UjSjQUBWM0nsTHnFOpklM3KpEzsJi1cvEGvg9d+4yzGqNVRoR3FQ5OEM
	UNZBL75+0AIiRjW+2lwtro1ISQUqBS2aTBX4snMRfXC58k168DFQxIw8occBFuVme39anj
	CN6ZyCvtqVWDcAeqhot+f20pkoFrED8iQFYaDY/NdIc2rWqzqmX6kZlsJWI3Gw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v3 0/4] spi: cadence-qspi: Fix runtime PM and system-wide
 suspend
Date: Fri, 09 Feb 2024 14:55:49 +0100
Message-Id: <20240209-cdns-qspi-pm-fix-v3-0-540ac222f26b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOUuxmUC/33NywrCMBAF0F8pWTuSTmtfK/9DXDQvO2CTmpSgl
 P67aVcK4mbgXrhnFha0Jx1Yly3M60iBnE2hOGRMDr29aSCVMkOOJU8HpLIBHmEimEYw9ARsK86
 lrFQtDEuzyetU7+TlmvJAYXb+tX+I+db+wWIOORSyMVqgMEo1Z+HcfCd7lG5kGxfxkzj9IBA4o
 K6F6FXZ9mX1Tazr+gbD6lmN9QAAAA==
To: Mark Brown <broonie@kernel.org>, Apurva Nandan <a-nandan@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

This fixes runtime PM and system-wide suspend for the cadence-qspi
driver. Seeing how runtime PM and autosuspend are enabled by default, I
believe this affects all users of the driver.

This series has been tested on both Mobileye EyeQ5 hardware and the TI
J7200 EVM board, under s2idle.

Thanks all,
Théo

[0]: https://lore.kernel.org/lkml/20240118155252.397947-1-gregory.clement@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
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


