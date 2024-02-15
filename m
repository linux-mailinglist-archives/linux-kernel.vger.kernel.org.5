Return-Path: <linux-kernel+bounces-66955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F09B856449
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E6F7B29C57
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70C612FF72;
	Thu, 15 Feb 2024 13:09:34 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0A12F5B6
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002574; cv=none; b=q4QJiSkKIA85WpePAS14sbct6WtzgcL9NRXWviVZX6PEqcH5zYkfnvOR9n1nT7y4gWqPGGBkvJ5wUw/bGaFq+JQnfLjLeODUrMygfiOk9jyVP2P5pumPdQuB2NpOshK+3BDeMA9gQxU4mGvUpKBeYjx6CJ6C+KQWNYcO+DCaiu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002574; c=relaxed/simple;
	bh=LdhE3W0DKxNgydIxqfNhRP53fhR33mH9xifCv+GNwsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=URWp64THBfJGDZeZHAwHkgPsnv7Yl93gICVGOJwz2XbppC7ntZAAY5GEpyo7ZoIrswmFflD6/2zQIUGtTixVs9jcM4diI6rtgMMmFQWo4MkuHje1A5jYq48Gt1TJ6JUD8ccaxbqHEm52NqQZVMq4g1D/yYBlq6N+vLTMcL84PIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ac52:3a54:2a84:d65a])
	by michel.telenet-ops.be with bizsmtp
	id nR9P2B00D0LVNSS06R9PnN; Thu, 15 Feb 2024 14:09:24 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabUK-000gy0-AI;
	Thu, 15 Feb 2024 14:09:23 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabUR-00HZ0d-La;
	Thu, 15 Feb 2024 14:09:23 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: J Keerthy <j-keerthy@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] regulator: lp873x: Use bitfield helpers
Date: Thu, 15 Feb 2024 14:09:18 +0100
Message-Id: <15edeaa9a644c4025234088da3dabb023fce04ac.1708002503.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the FIELD_PREP() helper, instead open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Mark Brown <broonie@kernel.org>
---
Compile-tested only.

v2:
  - Add Acked-by.
---
 drivers/regulator/lp873x-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp873x-regulator.c
index 8dfdd1db20709e18..84a134cfcd9c98d7 100644
--- a/drivers/regulator/lp873x-regulator.c
+++ b/drivers/regulator/lp873x-regulator.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2016 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -93,7 +94,7 @@ static int lp873x_buck_set_ramp_delay(struct regulator_dev *rdev,
 
 	ret = regmap_update_bits(lp873->regmap, regulators[id].ctrl2_reg,
 				 LP873X_BUCK0_CTRL_2_BUCK0_SLEW_RATE,
-				 reg << __ffs(LP873X_BUCK0_CTRL_2_BUCK0_SLEW_RATE));
+				 FIELD_PREP(LP873X_BUCK0_CTRL_2_BUCK0_SLEW_RATE, reg));
 	if (ret) {
 		dev_err(lp873->dev, "SLEW RATE write failed: %d\n", ret);
 		return ret;
-- 
2.34.1


