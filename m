Return-Path: <linux-kernel+bounces-60681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3038850862
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802572839A2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC43659B4D;
	Sun, 11 Feb 2024 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="iwmkOnKM"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565FA168B7;
	Sun, 11 Feb 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707644829; cv=none; b=eEJ4KjgNT5BbQAa1TQUmweImMJLkz8xo3lpnn0fviRn68qJYuwcvQjRsl2QJwHye4HDaw5DjFNLVOcUoFnF7F0iR1tSSTcJlFjVZo9tUQJ0u9kjcPWzymC37b0PG4vqvdOPNJAplbgS8AbDYnteQr9ILnPCGUMv88YAdr91YIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707644829; c=relaxed/simple;
	bh=gofBdZ13iHj3dO08IZKMEUeaH7TfVhVD1JVNFZuvo/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XrhuWM0Ja5SgoP+iJ3+vpy6D7qph5YV6NW5jwIV9w0NaXuRlT8cptX2xI1ZpPaXvtSVM6z8igoGuEjkQ2hNdv0AqsAg701DxXpGPxj+Z+VOkseTW868ojBFfV2q/GKmz2fP16o3AkVYcgeOvwIYOcoO1lAwJBQmDYpg7qnDtZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=iwmkOnKM; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 3F1C52811B8;
	Sun, 11 Feb 2024 10:46:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1707644817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=js79tpGeOwdjmy7kNEGOcRh7dlNGXI2Hu08nML2wVQU=;
	b=iwmkOnKM1VkVuFcfldLGCycvw6PoDVgAYTljFLpBOjyoLczIV0iyAwSjNGcqs0VXonbSfT
	tH7mvL/CBOid+nIfr+srxlvLFgOj2MXS1GilpvBUvEIF6pkwBSWbyS5x1ddfBeA/t3Hpzf
	nNIoB/R+4lFXTEmGoTC8Ph2odvQf1+Q=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 1327F457D27;
	Sun, 11 Feb 2024 10:46:57 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH v2 0/6] support for Marvell 88PM886 PMIC
Date: Sun, 11 Feb 2024 10:35:50 +0100
Message-ID: <20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

Hello,

the following implements basic support for Marvell's 88PM886 PMIC which
is found for instance as a component of the samsung,coreprimevelte
smartphone which inspired this and also serves as a testing platform.

The code for the MFD is based primarily on this old series [1] with the
addition of poweroff based on the smartphone's downstream kernel tree
[2]. The onkey and regulators drivers are based on the latter. I am not
in possesion of the datasheet.

[1] https://lore.kernel.org/all/1434098601-3498-1-git-send-email-yizhang@marvell.com/
[2] https://github.com/CoderCharmander/g361f-kernel

Thank you and kind regards,
K. B.
---
RFC v2:
- Merge with the regulators series to have multiple devices and thus
  justify the use of the MFD framework.
- Rebase on v6.8-rc3.
- Reorder patches.
- MFD RFC v1: https://lore.kernel.org/all/20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz/
- regulators RFC v1: https://lore.kernel.org/all/20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz/

Karel Balej (6):
  dt-bindings: mfd: add entry for Marvell 88PM886 PMIC
  mfd: add driver for Marvell 88PM886 PMIC
  regulator: add regulators driver for Marvell 88PM886 PMIC
  dt-bindings: input: add entry for Marvell 88PM88X PMICs onkey
  input: add onkey driver for Marvell 88PM88X PMICs
  MAINTAINERS: add myself for Marvell 88PM886 PMIC

 .../bindings/input/marvell,88pm88x-onkey.yaml |  32 +++
 .../bindings/mfd/marvell,88pm88x.yaml         |  82 +++++++
 .../regulator/marvell,88pm88x-regulator.yaml  |  28 +++
 MAINTAINERS                                   |  11 +
 drivers/input/misc/88pm88x-onkey.c            |  95 ++++++++
 drivers/input/misc/Kconfig                    |   7 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/mfd/88pm88x.c                         | 211 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   1 +
 drivers/regulator/88pm88x-regulator.c         | 206 +++++++++++++++++
 drivers/regulator/Kconfig                     |   6 +
 drivers/regulator/Makefile                    |   1 +
 include/linux/mfd/88pm88x.h                   |  46 ++++
 14 files changed, 739 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml
 create mode 100644 drivers/input/misc/88pm88x-onkey.c
 create mode 100644 drivers/mfd/88pm88x.c
 create mode 100644 drivers/regulator/88pm88x-regulator.c
 create mode 100644 include/linux/mfd/88pm88x.h

-- 
2.43.0


