Return-Path: <linux-kernel+bounces-102013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1019C87AD94
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BA71C213A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8DB14EA2A;
	Wed, 13 Mar 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sldq3OI/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C514E2EA;
	Wed, 13 Mar 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348226; cv=none; b=dYffSQ9MqNvZEiE2fY96cPYPfyCEJjp09Qphzk3BsXWuZ+fr62SQM5qo3yjc28n35hkRGvJs7/2oddKxySmBXyzyaO/ChksAITyGyXkt2W0x011wLaBXNZ28UG+1x1eMUS1Nzdfxt6ax02q8l17VOHxm9ulgA/niqaeD3Fl+F58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348226; c=relaxed/simple;
	bh=18U3/jqedjbpaw8g2u8F62gwbxSW7wd9fOj3ASax9Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRhsNs8+rcl0fTUHD+roJ4PJkG0kbW8U87q3pnAgAzl4z5wloB5yOiqOouvLmn8t5chjZ3XYm8w3S0oljs5Z7+Bb+BSACRNxoJAkDtiMmoD+v9eMaU154wCGOSUbOu+2m/alWbcKBR4odJRKVS86xZ9/XayFUOK4J8p1maez7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sldq3OI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79794C43399;
	Wed, 13 Mar 2024 16:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348226;
	bh=18U3/jqedjbpaw8g2u8F62gwbxSW7wd9fOj3ASax9Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sldq3OI/FKSMaFQBlRHDZLOWGk/GtliIdpQnrxcZtfXJ+WDLLgtub8gubx3Hvim5J
	 eXM5gUsPUdeaSpDlKUnxzdrohMK3z7a0TGX9MjdMiCXMpnfdpozcYF7zU58+4fX7wx
	 nZDkdGKGkwBYkmhtw0JdZk7TKHyW6TlV+zCP+RJIZiadSUAzFKWYmsv1PeHlY03QIt
	 thpwCbWwfMGvEYCX7x3fpiEPYUHJ+jMm2OmBgZor6cDHbNXp1WJ1fFPMYnouv8hFnl
	 slCpdKFo8sbdtcHTXkLFan5ji/fJNYRZG5zPqeZkUiGMfEodzGITTC/TEsTIK46Q5g
	 VYu7M3KdhpqPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ansuel Smith <ansuelsmth@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 72/76] regmap: allow to define reg_update_bits for no bus configuration
Date: Wed, 13 Mar 2024 12:42:19 -0400
Message-ID: <20240313164223.615640-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ansuel Smith <ansuelsmth@gmail.com>

[ Upstream commit 02d6fdecb9c38de19065f6bed8d5214556fd061d ]

Some device requires a special handling for reg_update_bits and can't use
the normal regmap read write logic. An example is when locking is
handled by the device and rmw operations requires to do atomic operations.
Allow to declare a dedicated function in regmap_config for
reg_update_bits in no bus configuration.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Link: https://lore.kernel.org/r/20211104150040.1260-1-ansuelsmth@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 3f42b142ea11 ("serial: max310x: fix IO data corruption in batched operations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 1 +
 include/linux/regmap.h       | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 7621b54975b57..ab924127e0aef 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -877,6 +877,7 @@ struct regmap *__regmap_init(struct device *dev,
 	if (!bus) {
 		map->reg_read  = config->reg_read;
 		map->reg_write = config->reg_write;
+		map->reg_update_bits = config->reg_update_bits;
 
 		map->defer_caching = false;
 		goto skip_format_initialization;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e3c9a25a853a8..22652e5fbc380 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -290,6 +290,11 @@ typedef void (*regmap_unlock)(void *);
  *		  read operation on a bus such as SPI, I2C, etc. Most of the
  *		  devices do not need this.
  * @reg_write:	  Same as above for writing.
+ * @reg_update_bits: Optional callback that if filled will be used to perform
+ *		     all the update_bits(rmw) operation. Should only be provided
+ *		     if the function require special handling with lock and reg
+ *		     handling and the operation cannot be represented as a simple
+ *		     update_bits operation on a bus such as SPI, I2C, etc.
  * @fast_io:	  Register IO is fast. Use a spinlock instead of a mutex
  *	     	  to perform locking. This field is ignored if custom lock/unlock
  *	     	  functions are used (see fields lock/unlock of struct regmap_config).
@@ -372,6 +377,8 @@ struct regmap_config {
 
 	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
+	int (*reg_update_bits)(void *context, unsigned int reg,
+			       unsigned int mask, unsigned int val);
 
 	bool fast_io;
 
-- 
2.43.0


