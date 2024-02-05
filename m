Return-Path: <linux-kernel+bounces-52807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B853C849CE5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8B51C220E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFD728E26;
	Mon,  5 Feb 2024 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EjjiEbib"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B59171C4;
	Mon,  5 Feb 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142967; cv=none; b=smvgV2a/ATYlOL4buhAvG5C91+YO2x8OctMC2kAofS64H3eyJqBOzDQ1vcxdTVyIMoeLd5uWyyZ6G42n4p+urGTEaEOklwAnqo0/j6m8+kTdsz3Bd8Z6M5QMNNuNovAxfh+VJVr3rPhN6fXujxE2MW5Oj0URLsSfSW7P+5wHpdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142967; c=relaxed/simple;
	bh=Y5W76+pPsN/JxMVthrgYscIGdiw39poUbsBHrzzva+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kOm73w1+4sg4uTo3ZB3bkrRR9TAgTRLZkYdB/n0Oj60wVbX9/ToCKMHFkxwBCsmqFbREvmqqgqevcd6cS6WUDaqYjaMT1Xxov+HJ+B0n8jJfwaJPdhm6PuKNBSGyTi/uBPAsamed011ZC1Ek+5by89z3RHhZgKICr/9YvoydJD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EjjiEbib; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 241511C000F;
	Mon,  5 Feb 2024 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707142963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tzX2G5dJNWQgfsOBNquj7qgw3LHc/tAZOaqHWcdjwR8=;
	b=EjjiEbibQwefHsgq1F7pT3S9634ZhYuxLsW/fXoKss8RYUn8aDj7u2gsmhtnfSSKL/OXT7
	oq3E0yycI8ekonpuIXqiRvdecJTwK5RsYw6c2uBgq2OAkkpJkUSX1VuvqNDQUgIFvg8jHW
	h+JbgYhQ1nn4GaWMQsyPzhP9Rz3QiPh+GpTIOFp8J2OpDVY4l++CZp3JhvyeuAEbfNoBfb
	6gAv+QG2um0PvOKXJyXNWujnhbQFUh+brelnV5PMN3d1qzPQVd3meeT2mlEDrPOm4FKASu
	P6WDuQGl5FY8U9kivTGV5vrvtB01gFKqYmC6IV5aMqzstRBsCSMa/2cu8j8LxQ==
From: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
To: theo.lebrun@bootlin.com,
	Mark Brown <broonie@kernel.org>,
	Apurva Nandan <a-nandan@ti.com>,
	Dhruva Gole <d-gole@ti.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: [PATCH v2 0/5] spi: cadence-qspi: Fix runtime PM and system-wide suspend
Date: Mon,  5 Feb 2024 15:22:34 +0100
Message-ID: <20240205-cdns-qspi-pm-fix-v2-0-c59ac6996428@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

This fixes runtime PM and system-wide suspend for the cadence-qspi
driver. Seeing how runtime PM and autosuspend are enabled by default, I
believe this affects all users of the driver.

The initial change has been split into three commits and a fourth commit
is added to add system-wide suspend/resume callbacks.

The MIPS platform at hand, used for debugging and testing, is currently
not supported by the driver. It is the Mobileye EyeQ5 [0]. No code
changes are required for support, only a new compatible and appropriate
match data + flags. That will come later, with some performance-related
patches.

TODO: changelog below

Thanks all,
Théo

[0]: https://lore.kernel.org/lkml/20240118155252.397947-1-gregory.clement@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v2:
- EDxxITME: describe what is new in this series revision.
- EDxxITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20240202-cdns-qspi-pm-fix-v1-1-3c8feb2bfdd8@bootlin.com

---
Théo Lebrun (5):
      spi: cadence-qspi: put runtime in runtime PM hooks names
      spi: cadence-qspi: fix pointer reference in runtime PM hooks
      spi: cadence-qspi: remove system-wide suspend helper calls from runtime PM hooks
      spi: cadence-qspi: add system-wide suspend and resume callbacks
      WIP: spi: cadence-qspi: add debug logs for PM

 drivers/spi/spi-cadence-quadspi.c | 45 ++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 12 deletions(-)
---
base-commit: 13acce918af915278e49980a3038df31845dbf39
change-id: 20240202-cdns-qspi-pm-fix-29600cc6d7bf

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


