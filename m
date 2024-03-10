Return-Path: <linux-kernel+bounces-98065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFE98774AC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB7A1F213E0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2CC1374;
	Sun, 10 Mar 2024 01:02:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD11E7FE;
	Sun, 10 Mar 2024 01:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710032560; cv=none; b=jySmh+JiZaB3ecVWm+4GQtJeNntJmL9YYHEBO4f2gSeT/dtssuav78uFHy5wBF0yxcs/vCNXzQt2hmfz4aYBB97Lu0qjU7cfj11U804loFRbiVrP4mw5gjPaQXdG42ij735pJrap0QEwDdRO+Y9OK4wud5MMFClqnvQwe7FRUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710032560; c=relaxed/simple;
	bh=9dx8jZPUSeMi8ixwiSo2dmMXQdjJUvVJtzxtmxRaMZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TVmlVjFNE9cKw/Dsn8IXRIGyruXvNpOha7t+L0Zh9y4SzcrLUlO476giAiFqAkKLIwso/Ga+4UMFWJyQqV0hSn6+CkmSTD6ylJy4IqzCWLzFDK1psCKOa9V89izzn7PF6IJK/jqS2iJ8oHql+eyTn7SVcFWTf/AbVRvXyXErqgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EDEB113E;
	Sat,  9 Mar 2024 17:03:07 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E7663F73F;
	Sat,  9 Mar 2024 17:02:29 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 0/4] regulator: Add X-Powers AXP717 PMIC support
Date: Sun, 10 Mar 2024 01:02:07 +0000
Message-Id: <20240310010211.28653-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the X-Powers AXP717 PMIC, which is 
used recently on new boards with Allwinner SoCs.
Allwinner's BSP code often speaks of the AXP2202, this seems to be the
same chip, at least a boot0 AXP2202 driver happily drove a chip labelled
AXP717.

Patch 1 fixes a typo in some macro names for the AXP313a PMIC, I just
realised that during some copy&paste action. It's just an identifier
rename, so not a backport candidate, I'd say.
Patch 2 adds the compatible string to the binding document.
Patch 3 is the MFD part, describing the regmap and all the interrupts.
So far we support the regulator and power key devices, the USB and
charging devices will follow later.
Patch 4 adds the voltage regulator rails, this part is crucial to enable
any board using this PMIC, as we depend on those rails even for basic
devices.

Please note that I could not test this driver myself, but had success
messages from others. It would be good to hear from Ryan and Chris
here on the list, with a Tested-by: tag.

This series is based on next-20240308 for now. I will send a rebased
update after the merge window, but wanted to start discussion and review
now.

Please have a look!

Cheers,
Andre

Andre Przywara (4):
  regulator: axp20x: fix typo-ed identifier
  dt-bindings: mfd: x-powers,axp152: document AXP717
  mfd: axp20x: add support for AXP717 PMIC
  regulator: axp20x: add support for the AXP717

 .../bindings/mfd/x-powers,axp152.yaml         |  2 +
 drivers/mfd/axp20x-i2c.c                      |  2 +
 drivers/mfd/axp20x-rsb.c                      |  1 +
 drivers/mfd/axp20x.c                          | 90 +++++++++++++++++
 drivers/regulator/axp20x-regulator.c          | 94 +++++++++++++++++-
 include/linux/mfd/axp20x.h                    | 98 ++++++++++++++++++-
 6 files changed, 277 insertions(+), 10 deletions(-)

-- 
2.35.8


