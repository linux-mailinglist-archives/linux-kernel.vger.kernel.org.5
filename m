Return-Path: <linux-kernel+bounces-58558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C0F84E806
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237501F2D67C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC81D25566;
	Thu,  8 Feb 2024 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I17fLeB4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6020312;
	Thu,  8 Feb 2024 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418167; cv=none; b=F+Sh6BKYu4owIl6z84ddJavJrfMrWgDiB71ijSfyJjIktUOP2njNiafbhUDZmL3b6yA7WaX9MptlqVsHMX5cGHRCjLZFQqFx30QL89CaRrgBnoxAzFqyhZ40nzvgvLlOjZt4hWNzWNWQhigbxWmvn9h7Rbf75K9M67BBzZqNCb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418167; c=relaxed/simple;
	bh=x8TByPmOrQ+gMAIIaoMyZZvfiNw4po8E/dT9novu62c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cps6cT+J0K/wvETvWfr04MugUYI9gHN9EdraRFydl8HKg7edAztRbODVjena8Rv1o6k6w9jEHPxShnEmC2e1Df9iAMPXp9vR8PtNui1Ozm1iDr5okN9jmOlqDb9G8qYieWsccWueCxGp1RLqBLQyzCTAC7z+9jFoHRCUaAuFUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I17fLeB4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418166; x=1738954166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x8TByPmOrQ+gMAIIaoMyZZvfiNw4po8E/dT9novu62c=;
  b=I17fLeB4i0dgIctRhUkJ8acOI7nGvMioLkitbYgIJIR+njz8J79cchtW
   IEDMhF2NeQBsyIFCi+5nY43bHStTBuR8PGyZE7won5aqb8ROn4sc+rsGi
   3d2kCEAvbdN8rIPPZC4/O3O6OcYi53ZXXDSWWyu1SeN0d7Z+aSUgMRsFT
   O7cNMaLf9n/Qd0yzJh6on7Y8yBvODDo9IhZD6zKRdb/ToqtHRgLF4ymE1
   siGtMM5ZsA5+aUCfGT+bGu+5hHQXS82f1sKPbEEogbVJG9j+KfWRQv7IZ
   uTEbkgUDtyhJTgCMMdAS8ycTSzp5L67yPwRWI0rmXN9HqoLIGEggCHQcJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1186079"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1186079"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934215511"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934215511"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:49:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 37A626B; Thu,  8 Feb 2024 20:49:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v1 01/15] auxdisplay: img-ascii-lcd: Make container_of() no-op for struct linedisp
Date: Thu,  8 Feb 2024 20:47:59 +0200
Message-ID: <20240208184919.2224986-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
References: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move embedded struct linedisp member to make container_of() no-op.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/img-ascii-lcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index 56efda0740fb..09014ada38bd 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -32,21 +32,21 @@ struct img_ascii_lcd_config {
 
 /**
  * struct img_ascii_lcd_ctx - Private data structure
+ * @linedisp: line display structure
  * @base: the base address of the LCD registers
  * @regmap: the regmap through which LCD registers are accessed
  * @offset: the offset within regmap to the start of the LCD registers
  * @cfg: pointer to the LCD model configuration
- * @linedisp: line display structure
  * @curr: the string currently displayed on the LCD
  */
 struct img_ascii_lcd_ctx {
+	struct linedisp linedisp;
 	union {
 		void __iomem *base;
 		struct regmap *regmap;
 	};
 	u32 offset;
 	const struct img_ascii_lcd_config *cfg;
-	struct linedisp linedisp;
 	char curr[] __aligned(8);
 };
 
-- 
2.43.0.rc1.1.gbec44491f096


