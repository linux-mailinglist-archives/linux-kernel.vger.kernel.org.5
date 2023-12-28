Return-Path: <linux-kernel+bounces-12550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8432F81F6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311A128565D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B780B6AB0;
	Thu, 28 Dec 2023 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="CEN9LCHO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB463B1;
	Thu, 28 Dec 2023 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id E1B8C28C555;
	Thu, 28 Dec 2023 11:02:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1703757739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6XwUXQfO1QaOrvjh7oAdNoHW7l3I81ivVGMpPCfOktI=;
	b=CEN9LCHOHu/V+kGH9xSMlq+r/2Xq2J5MfdCfRgfXXhcEgVP4AfynZ75eK8s5qaDX2VrhCG
	yAGfZgbzFJQSSYckKm7zPseiO0u2gGMC2AyrVAXAKcYDSahJSogm6qeYpXrhIQ6NkViwqH
	TnRk9vUT2Wt5t92hN4RcFtqGz8uTQWU=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id BA7F14423CE;
	Thu, 28 Dec 2023 11:02:19 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH 0/5] regulator: support for Marvell 88PM886 LDOs and bucks
Date: Thu, 28 Dec 2023 10:39:09 +0100
Message-ID: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
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

the following adds the regulators driver for Marvell 88PM88X PMICs
implementing only the 88PM886 specific parts - however extension for
88PM880 should be trivial. The series adding MFD driver for these PMICs
is available here [1]. Please note that this series depends on that
one.

The motivation and testing platform for this is the
samsung,coreprimevelte smartphone for which the initial support efforts
are ongoing here [2]. This PMIC is also found in at least two other
devices with the PXA1908 SoC, such as samsung,xcover3lte and
samsung,grandprimevelte.

As the only reference for this driver served the smartphone's downstream
kernel tree which is available here [3].

Please note that the first patch of this series is just a joining step
with respect to series [1] and will be amalgated with future versions of
it and dropped here. Also please note that that this series has the same
defects as the MFD one and thus please only review the new parts.
Lastly, as I would like to get some feedback on whether the approach I
have taken here is OK, I have only defined descriptions for three
regulators so far, the remaining eighteen will be defined in the same
style and will of course be added when this series leaves the RFC state
at the latest.

[1] https://lore.kernel.org/all/20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz/
[2] https://lore.kernel.org/all/20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole.hr/
[3] https://github.com/CoderCharmander/g361f-kernel

Thank you,
K. B.

Karel Balej (5):
  mfd: 88pm88x: differences with respect to the PMIC RFC series
  mfd: 88pm88x: initialize the regulators regmaps
  dt-bindings: regulator: add documentation entry for 88pm88x-regulator
  regulator: add 88pm88x regulators driver
  MAINTAINERS: add entries for the 88pm88x regulators driver

 .../bindings/mfd/marvell,88pm88x.yaml         |  17 ++
 .../regulator/marvell,88pm88x-regulator.yaml  |  28 +++
 MAINTAINERS                                   |   2 +
 drivers/mfd/88pm88x.c                         |  62 ++++-
 drivers/regulator/88pm88x-regulator.c         | 214 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   6 +
 drivers/regulator/Makefile                    |   1 +
 include/linux/mfd/88pm88x.h                   |  17 ++
 8 files changed, 341 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml
 create mode 100644 drivers/regulator/88pm88x-regulator.c

-- 
2.43.0


