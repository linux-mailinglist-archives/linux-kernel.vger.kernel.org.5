Return-Path: <linux-kernel+bounces-89697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396D86F44B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61C31C20A3F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BD7BA4B;
	Sun,  3 Mar 2024 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="GjUcTofE"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C585EB642;
	Sun,  3 Mar 2024 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709460935; cv=none; b=gZcw27mNfJusZnYT4v67IVeo4iovN6D83HbdPiv/OFVG6fueyYzVD4MbFLPqC/ZQcoIcKMkxUdeq3fPBks8WmSCwTY/FaS5ybn+0N8pJW718/u/Rz60fI6xnMCStQ/21LkOeElhrigyOLd8sQnlk9zpm/SoV5Kt2Set6XMzo5s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709460935; c=relaxed/simple;
	bh=y4upltIYbr5815lbbJcq3QZupeGcFF1aeW5dMLuiP8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dt2oKd4Q9fs2dxrQKalNhwvJV4dHQnQzTQawczIrp/hUiu+Ib49KOPyl5U3SUlJw+2VigPpe+acsNdQArCYQIWumnBeflDUgTfZXTu06A6RexFQmFSL+ILpQ9tiF+QtM0ZqcKPPk/lW4TLV2emJ0MIGttI/5lrd2LphSFIFUsSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=GjUcTofE; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id F2C5328428C;
	Sun,  3 Mar 2024 11:15:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1709460924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lZvjtksvf4qK4UfszmybD7ivOvG0abGJuHgkrZ/Ur8E=;
	b=GjUcTofEQJxcRwBtKVE1oi06Oetf0EvQXf90RKJyGa9n817Mr+dCjUHO5HxDMnINtIbUKg
	kVi1QN4POB05+nF+3vfbjsoqnmdibc3YUqEIGH0so2j7LjSlXlGF3ji0O2kmiqFWsVfULv
	6+ouhuW9+uqkzuGAmM5e5zG5iLMPj70=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id CEED2456F3E;
	Sun,  3 Mar 2024 11:15:23 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH v3 0/5] initial support for Marvell 88PM886 PMIC
Date: Sun,  3 Mar 2024 11:04:21 +0100
Message-ID: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.44.0
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
RFC v3:
- Address Rob's feedback:
  - Drop onkey bindings patch.
- Rename PM88X -> PM886 everywhere.
- RFC v2: https://lore.kernel.org/all/20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz/
RFC v2:
- Merge with the regulators series to have multiple devices and thus
  justify the use of the MFD framework.
- Rebase on v6.8-rc3.
- Reorder patches.
- MFD RFC v1: https://lore.kernel.org/all/20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz/
- regulators RFC v1: https://lore.kernel.org/all/20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz/

Karel Balej (5):
  dt-bindings: mfd: add entry for Marvell 88PM886 PMIC
  mfd: add driver for Marvell 88PM886 PMIC
  regulator: add regulators driver for Marvell 88PM886 PMIC
  input: add onkey driver for Marvell 88PM886 PMIC
  MAINTAINERS: add myself for Marvell 88PM886 PMIC

 .../bindings/mfd/marvell,88pm886-a1.yaml      |  76 +++++++
 MAINTAINERS                                   |   9 +
 drivers/input/misc/88pm886-onkey.c            |  92 ++++++++
 drivers/input/misc/Kconfig                    |   7 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/mfd/88pm886.c                         | 210 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   1 +
 drivers/regulator/88pm886-regulator.c         | 195 ++++++++++++++++
 drivers/regulator/Kconfig                     |   6 +
 drivers/regulator/Makefile                    |   1 +
 include/linux/mfd/88pm886.h                   |  46 ++++
 12 files changed, 656 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
 create mode 100644 drivers/input/misc/88pm886-onkey.c
 create mode 100644 drivers/mfd/88pm886.c
 create mode 100644 drivers/regulator/88pm886-regulator.c
 create mode 100644 include/linux/mfd/88pm886.h

-- 
2.44.0


