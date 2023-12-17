Return-Path: <linux-kernel+bounces-2611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D1B815F6C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC871F2201E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA974437D;
	Sun, 17 Dec 2023 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="D1/q7tLg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3544379;
	Sun, 17 Dec 2023 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 63C3028C341;
	Sun, 17 Dec 2023 14:19:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1702819199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mcphuoLJD5YV2j+1XZvlO20/5rV+jn37j0Ofr9Ge1UA=;
	b=D1/q7tLg4K1YnC/lDT8haKfDphMurp5pRh6ZlLYOOTukl/xGHTyxCyvlil5E5dbzMT8EHt
	up0LLf03CXEkb6sAp19Oa+S9mT+AbVlqHVjpI8+tnxS+TYlWTmEbLt4hu9ZGPf3g4gZeT5
	dRRGQAuFz2GqxTk7N2ZSyvuzjpasmqQ=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 3A39B44AF99;
	Sun, 17 Dec 2023 14:19:59 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH 0/5] support for Marvell 88PM886 PMIC
Date: Sun, 17 Dec 2023 14:16:58 +0100
Message-ID: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
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
[2]. The onkey driver is based on the latter. I am not in possesion of
the datasheet.

The vendor version of this driver includes support for a similar chip:
88PM880. While that is not included here it was written with it in mind
and it should be quite straighforward to add it.

[1] https://lore.kernel.org/all/1434098601-3498-1-git-send-email-yizhang@marvell.com/
[2] https://github.com/CoderCharmander/g361f-kernel

Thank you and kind regards,
K. B.

Karel Balej (5):
  dt-bindings: mfd: add entry for the Marvell 88PM88X PMICs
  mfd: add 88pm88x driver
  dt-bindings: input: add entry for 88pm88x-onkey
  input: add onkey driver for Marvell 88PM88X PMICs
  MAINTAINERS: add myself for Marvell 88PM88X PMICs

 .../bindings/input/marvell,88pm88x-onkey.yaml |  30 +++
 .../bindings/mfd/marvell,88pm88x.yaml         |  59 ++++++
 MAINTAINERS                                   |   9 +
 drivers/input/misc/88pm88x-onkey.c            | 103 +++++++++
 drivers/input/misc/Kconfig                    |  10 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/mfd/88pm88x.c                         | 199 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 include/linux/mfd/88pm88x.h                   |  60 ++++++
 10 files changed, 483 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
 create mode 100644 drivers/input/misc/88pm88x-onkey.c
 create mode 100644 drivers/mfd/88pm88x.c
 create mode 100644 include/linux/mfd/88pm88x.h

-- 
2.43.0


