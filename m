Return-Path: <linux-kernel+bounces-66956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2059485642D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82CDDB2AE89
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0264012FB3A;
	Thu, 15 Feb 2024 13:10:56 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02012D751
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002655; cv=none; b=DRKYWH1QU/NPgtRUsATS6N/yvbTeoYE28zkHGjOBoH+d4K32Hw9i1I0r3JXXkVo1BuEaOYXid0B/+Bx8s+7ZCOIFKwQtzECacPF7zxBr/V7fGZQ3vWX5z+usVKaZE05LRUWq/oYpmz2jK1Ci+zIK8mXONDL24aOaHkhAK+VPiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002655; c=relaxed/simple;
	bh=yjbAE2nc8iNV6y/AHrAwq9EGZuheR7TP6U4f67OjgLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UN79Chu4Q6n5IENzonFNqA/fGax+6U656zIIrcHRGDR+eMg+yIxqZ2If88VfDUN8EwWoJuujeiKyAjvByaOkomKU1uqAS1dkKSkyqy8mBtEu7OCX7GADxIKax7bA4BPC/QGUHBskHd4WS/W2adRTqe9BHdBVoGUZxnTmoDtgnUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ac52:3a54:2a84:d65a])
	by michel.telenet-ops.be with bizsmtp
	id nRAr2B00J0LVNSS06RAsyc; Thu, 15 Feb 2024 14:10:52 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabVk-000gy6-FC;
	Thu, 15 Feb 2024 14:10:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabVr-00HZQt-Pc;
	Thu, 15 Feb 2024 14:10:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: J Keerthy <j-keerthy@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] regulator: lp87565: Use bitfield helpers
Date: Thu, 15 Feb 2024 14:10:50 +0100
Message-Id: <5e8781d31c983caf6bdabe36c5552077422cb8da.1708002575.git.geert+renesas@glider.be>
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
 drivers/regulator/lp87565-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 61ee5cf3f2411fae..1259b5d20153658b 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -99,7 +100,7 @@ static int lp87565_buck_set_ramp_delay(struct regulator_dev *rdev,
 
 	ret = regmap_update_bits(rdev->regmap, regulators[id].ctrl2_reg,
 				 LP87565_BUCK_CTRL_2_SLEW_RATE,
-				 reg << __ffs(LP87565_BUCK_CTRL_2_SLEW_RATE));
+				 FIELD_PREP(LP87565_BUCK_CTRL_2_SLEW_RATE, reg));
 	if (ret) {
 		dev_err(&rdev->dev, "SLEW RATE write failed: %d\n", ret);
 		return ret;
-- 
2.34.1


