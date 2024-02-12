Return-Path: <linux-kernel+bounces-62041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CF7851AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BB71F226F3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A0E3FE58;
	Mon, 12 Feb 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A25fG6PI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946363FB1F;
	Mon, 12 Feb 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757490; cv=none; b=nj5TVjaJJCNU9DO3q+h8Z+jWius5BALxS0vGsdflHafzcnDs7ZM7PAOtJj4SwQX7hNPIr3qiJgvKpIWUkGcNU08AR6Q+LzIoD4va1GCyY/zSeM3eh752xxPJVVHz64Ujr3h/+G9vpVG5zWgZ5vYgalcV9i1+09AWQca1IB742/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757490; c=relaxed/simple;
	bh=x8TByPmOrQ+gMAIIaoMyZZvfiNw4po8E/dT9novu62c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tX5/9Wu/tVFGBTRY/QXm/G+Zy81B/70aadyhvJ7x4xQQNZGENrc/PjkUKz8ogzdGrC7Z9R8BAk6P6YJLyem8NeSC/8+rKYwrqIkxOVPFeg0Ya7lgjDsFXS0K6EbgxGm6e02Q0kXjw4mNcjgPj1cXpSvM4t4UwDxXrzAcV1vdzcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A25fG6PI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757489; x=1739293489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x8TByPmOrQ+gMAIIaoMyZZvfiNw4po8E/dT9novu62c=;
  b=A25fG6PId2B6nwDtMnvawUaaTLhcRTGYoUkAeypqaZbKso93/mihPwBx
   kDKSpdeLCor/aL6ryPOPQQ3P8pYlUj2nZxP7OJQtxT5gCaHNZGfz/exkN
   xCP+dOkd1PaGRv5VS4NeVrGuLXOUjcSBpTQusvpRVQNG/QxMIPW7I2oWM
   JYirSHIeI5SCsyqpivT3H0R5VYqklDms5xsHB9cyofBGY9BaD0SrBlkGH
   f0qIghZHHU7BBNuST1+uNMwKuewdvG5Cegu2JllCpfCIhu9CLOr6lI/vL
   zGNC69M5YstUFYzim5MMPcjSAEFWW0HBHKycFF3Qmy9v4AyYfdSR7M6Q1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19153170"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19153170"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:04:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935116808"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935116808"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 09:04:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 90163A1; Mon, 12 Feb 2024 19:04:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: [PATCH v2 01/15] auxdisplay: img-ascii-lcd: Make container_of() no-op for struct linedisp
Date: Mon, 12 Feb 2024 19:01:34 +0200
Message-ID: <20240212170423.2860895-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
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


