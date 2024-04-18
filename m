Return-Path: <linux-kernel+bounces-149339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA928A8FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5435C28260F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759A417D2;
	Thu, 18 Apr 2024 00:07:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DC310F2;
	Thu, 18 Apr 2024 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713398872; cv=none; b=S9EiULo1IC8M6pM77LP1lLDLEMvIk6M58TC98Qno0crjKwoWMk3XgC9gjl4xljL6V1tq5zNishzsUxYD/bWRqnrVtstk/OecaAE8zEoq35r0/YPv9Bi3dcQ1DST5fq/XYXNEF8qjQ26rFhprY6kwyF2cQTSeBP5ebrFr86OFQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713398872; c=relaxed/simple;
	bh=KCFtt4+CJgY99XrUpZ/t3/3glu1QWpH5Pg1MJ7tRmVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lESyRCvu7gV15hljmHlnBeB85M7g3wVILdbJu6H2el7Kno6JhSz7+6UOgvBRgC7lDv+Mq0BIuc/MCLl5/QqYYBzU0swjXGEJVPWDJaqOKjhqIRZv930mkM4YFDKOdO/c6Ok/OXoJ10XvHC1P9R/diKpqtb1DnneAAklbgzMbkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82804339;
	Wed, 17 Apr 2024 17:08:16 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCFD43F64C;
	Wed, 17 Apr 2024 17:07:46 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: [PATCH v2 0/5] regulator: Fix AXP717 PMIC support
Date: Thu, 18 Apr 2024 01:07:31 +0100
Message-Id: <20240418000736.24338-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the fixes to the AXP717 PMIC support series. Lee put the
original patches in an immutable branch already, so these here go on top.
Patch 1 is new in v2, and adds the IRQ status and acknowledge registers
to the writable range. Thanks to Chris for pointing this out.
Patch 2 contains fixes to the regulator descriptions: the LDOs had the
wrong supply source, and two numbers were wrong. The datasheet describes
the voltage ranges and register values differently from what our macros
expect, in a way that literally begs for off-by-ones, so here you go.
Also there is an actual wrong number in the datasheet, add a comment to
document this.
I don't know if that's still feasible, but those two patches would be a
good candidate to squash into the patches that they fix.

The other three patches add the "boost" regulator, which is meant to
provide the 5V USB VBUS power when operating from the battery. It's the
usual trinity of binding/mfd/regulator patches.
Again this could be squashed into the respective patches from the
original series, if people agree.

Please have a look and test!

Based on mfd/ib-mfd-regulator-6.10, as detailed below.

Cheers,
Andre

Changelog v1 .. v2:
- add tags
- add patch to add missing IRQ ack register range
- add comment to document bug in datasheet

Andre Przywara (5):
  mfd: axp20x: AXP717: Fix missing IRQ status registers range
  regulator: axp20x: AXP717: fix LDO supply rails and off-by-ones
  dt-bindings: mfd: x-powers,axp152: add boost regulator
  mfd: axp20x: AXP717: Add support for boost regulator
  regulator: axp20x: AXP717: Add boost regulator

 .../bindings/mfd/x-powers,axp152.yaml         |  2 +-
 drivers/mfd/axp20x.c                          |  3 ++
 drivers/regulator/axp20x-regulator.c          | 37 ++++++++++++-------
 include/linux/mfd/axp20x.h                    |  3 ++
 4 files changed, 30 insertions(+), 15 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
prerequisite-patch-id: 2b5fb10f68e0994071fc4c7dce73db7047c23220
prerequisite-patch-id: 5d0735de888d155b2c1cdb814e852a5852a17ec7
prerequisite-patch-id: 29c30894b4bf0b9e1e71de065cabbd842505e248
prerequisite-patch-id: 0ab87cbf7362b6dc2d577d2264eb9574be47b5f6
-- 
2.35.8


