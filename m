Return-Path: <linux-kernel+bounces-125533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2988927E6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33B7B22855
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D30413E40E;
	Fri, 29 Mar 2024 23:50:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988DB1D699;
	Fri, 29 Mar 2024 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756251; cv=none; b=FhODccU1LT3mlTU2kcAfv5kI0yUOzluZiZraJ37pGBd+xdgcHixAOjHftXLD+qf0bq5Yu6VB4LZqqHrTOZPlFx66Y057CpXXMcbOH4ieAgqxBLlG+yr23yvvuXFOkbs94GSvp9HfSXL0Aq1XIdVBDb9Tf+fYDV4JKwn2MXU+VFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756251; c=relaxed/simple;
	bh=TZ3uiNo5q8a7erClyx5Zij7cZ7jestMo9ToWhp0UMHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AujyNsoGprMuTojsKKp6/l+STYlYF+4fNvuMLvciGTysbRkE8lcGu/RFJT2JnT4GE6G7db2DteZQpb8KGqPm0YMry83yRNLpsqC/6M2ikaSEaMIiLncKZrwqarLYY3BQJ/ZeFDV7zwAgmeXclgp1hxv/DxKqVHXFPuU4tbCD8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1EE9FEC;
	Fri, 29 Mar 2024 16:51:20 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D59093F64C;
	Fri, 29 Mar 2024 16:50:45 -0700 (PDT)
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
Subject: [PATCH 0/4] regulator: Fix AXP717 PMIC support
Date: Fri, 29 Mar 2024 23:50:29 +0000
Message-Id: <20240329235033.25309-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are some fixes to the AXP717 PMIC support series. Lee put that in
an immutable branch already, so these here go on top.
Patch 1 contains fixes to the regulator descriptions: the LDOs had the
wrong supply source, and two numbers were wrong. The datasheet describes
the voltage ranges and register values differently from what our macros
expect, in a way that literally begs for off-by-ones, so here you go.
I don't know if that's still feasible, but it would be a good candidate
to squash into the patch that it fixes.

The other three patches add the "boost" regulator, which is meant to
provide the 5V USB VBUS power when operating from the battery. It's the
usual trinity of binding/mfd/regulator patches.
Again this could be squashed into the respective patches from the
original series, if people agree.

Please have a look and test on a device, since I could not do this.

Based on mfd/ib-mfd-regulator-6.10, as detailed below.

Cheers,
Andre

Andre Przywara (4):
  regulator: axp20x: AXP717: fix LDO supply rails and off-by-ones
  dt-bindings: mfd: x-powers,axp152: add boost regulator
  mfd: axp20x: AXP717: Add support for boost regulator
  regulator: axp20x: AXP717: Add boost regulator

 .../bindings/mfd/x-powers,axp152.yaml         |  2 +-
 drivers/mfd/axp20x.c                          |  2 ++
 drivers/regulator/axp20x-regulator.c          | 32 +++++++++++--------
 include/linux/mfd/axp20x.h                    |  3 ++
 4 files changed, 24 insertions(+), 15 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
prerequisite-patch-id: 2b5fb10f68e0994071fc4c7dce73db7047c23220
prerequisite-patch-id: 5d0735de888d155b2c1cdb814e852a5852a17ec7
prerequisite-patch-id: 29c30894b4bf0b9e1e71de065cabbd842505e248
prerequisite-patch-id: 0ab87cbf7362b6dc2d577d2264eb9574be47b5f6
-- 
2.35.8


