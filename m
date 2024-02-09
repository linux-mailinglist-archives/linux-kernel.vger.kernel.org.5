Return-Path: <linux-kernel+bounces-59381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D02F84F626
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5900928581E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F0C3F9D3;
	Fri,  9 Feb 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UXE/0/sG"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D26B3D0C5;
	Fri,  9 Feb 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486357; cv=none; b=TI33GyMHkiJdvG3i5NPt40V3RuK4ZYa5yITny/mytOZTTD1sPeUEFrZoZfW1+4+seWMIP/j4M2A9fIm5EPn44kXMqAKcoImE4dCllQzjZBiqeQLPOJMqO2yHNeM9J511O/q6/+pX9M8VxLonRJPhj4oRanU5ZsBnqC56fc96LVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486357; c=relaxed/simple;
	bh=oWetB+WYKsiEYuWZkCPLaYSNXBZo0AsmwsiyUa7og2o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aQCoaioRIhAEEzKww1xDlFZUtOrlVKFn8UiyK1IC9HOpe5qBgDg19YAzgnk05pfFqcFrrHwDsLRZA7/jWCPNKg3q4H8dtm4rO/PNMay+PCXnSY6/aczJIKPlX1Uy3HJZjMqFGZXQNyYHNFdpihS/3HV6RPCueeuahLr5rlPHP+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UXE/0/sG; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49ECDE0010;
	Fri,  9 Feb 2024 13:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707486352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EIHjn3zdB4ZhB1RGLWDwTs8+hgBYlE9S5vEUi/JfTDI=;
	b=UXE/0/sGiyOjQ40tvkjBUm7iV0wz3Bdt1jFvjbTmMmimO/ilC1bcceHbJV55r4C4yOgmdK
	FiwJ8kNeGSIjEhendltZPpNdP1vjzaRiAzPsZrwedJ0ajPk1ehoOTMQXRuKKAhQ/OGiMA7
	noKrf613x3X84J+HvA5i0n6QBAk/ZWHb+gGtcu8V+ob44nZePOnzc4pZajW9vMyPoU0N5M
	qTVddeB7748/OlsaRHl6xc2YTQ3ZI5tR7AQTejQQE3l68STV5qJbgEezCjrNd7hwgEJmOI
	4MtSnKjJKrAWgxhhqnwo5x1RHjdZOE4IWNp7TpHO8dI88irt+3rScuufIcx/0A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH 0/4] spi: cadence-quadspi: correct chip-select logic
Date: Fri, 09 Feb 2024 14:45:29 +0100
Message-Id: <20240209-cdns-qspi-cs-v1-0-a4f9dfed9ab4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHksxmUC/x3MMQqAMAxA0atIZgNtFEWvIg7appql1gZEEO9uc
 XzD/w8oZ2GFsXog8yUqRyywdQVuX+LGKL4YyFBryAzofFQ8NQk6xY7sGrgPDfUBSpIyB7n/3TS
 /7wetga23XgAAAA==
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dhruva Gole <d-gole@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

Here are three independent patches that relate to the handling of
chip-select and the number of those in the spi-cadence-quadspi.c
driver.

 - First one is about checking each flash node reg (ie CS) against the
   ->num_chipselect value instead of the hardcoded max constant. That
   means it checks against the num-cs DT prop if it existed. Previously
   num-cs==1 with 2 flash nodes would have lead to no error,
   a ->num_chipselect==1 and 2 flashes.

 - Second, we lower the max CS constant from 16 to 4. The hardware only
   supports 4 anyway, and that makes for less memory used. This got
   discovered on v6.8-rc2 when the SPI subsystem imposed a max CS of 4.
   The change got reverted later.

 - Lastly, we adjust the ->num_chipselect value reported to the actual
   number of chip-selects. Previously, it reported either the num-cs DT
   prop or the max value (if no num-cs was provided).

There is also a small fix to move to modern names and avoid using the
legacy compatibility layer (slave, etc).

Thanks,
Théo

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (4):
      spi: cadence-qspi: assert each subnode flash CS is valid
      spi: cadence-qspi: set maximum chip-select to 4
      spi: cadence-qspi: report correct number of chip-select
      spi: cadence-qspi: switch from legacy names to modern ones

 drivers/spi/spi-cadence-quadspi.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)
---
base-commit: 19b50f80b3a4865bd477aa5c026dd234d39a50d2
change-id: 20240209-cdns-qspi-cs-621bfe7f327f

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


