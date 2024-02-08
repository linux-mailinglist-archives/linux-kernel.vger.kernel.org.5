Return-Path: <linux-kernel+bounces-58437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32B584E683
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AAC1C246D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239428612E;
	Thu,  8 Feb 2024 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/FNAa2B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAC982D65;
	Thu,  8 Feb 2024 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412655; cv=none; b=XRC65yN9nAFroy3B7A8wMwAxgTJpr4PgahI57hi0svmJueP6oap4c0o8lpK2HJY4BsBsw0FSBGbgtsWXLJ8EiHP3eOW4r3T5sBjDTom5n5EwOTus+1iB80/wiK68yRgkdY+tYPBTvYWgkK1BmL/Qrb4injkFygMxY0wwySZVeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412655; c=relaxed/simple;
	bh=x8TByPmOrQ+gMAIIaoMyZZvfiNw4po8E/dT9novu62c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/mJaE/DKYba/l4pJ3R+inl07JqGYBUxs8MBys61j3a8audeU012dNQa/KTsxlSakI+wdN5z0iyUQfIT+CYzgPj7ZsSPASLuePh+Y/uhxmJFe0jyr9FuaNg3Hl1QDESruQmXc59jIQCxJiiOTz7bf5xF/Oa6qpf2K5HdX640SHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/FNAa2B; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707412653; x=1738948653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x8TByPmOrQ+gMAIIaoMyZZvfiNw4po8E/dT9novu62c=;
  b=P/FNAa2BL1MrZVpUJUREpK1qzcvr/XRxc6hhLUy1oOTC7JoaqAd67lwb
   SFVWcxhZpkCKjcm8lBCdTQfGyhhkrEYDgpj16rTdyjc6rL0dClctSRk8h
   Ndy4RAkuk4kyPqYwv5A4031RghVu+zWl1IkdCDMqaDztgz3kDsje8qM3k
   +42kUXR93ZAmoSGdE5VW7+aOfcKCOpxD0dEXooOK9pg9bCV6g4ETDLvpN
   4yOb4Ns+EL2uY0aP6g3F0+pjmj04L65FN7FfNoXbpTdlYR8nImZuC4E9X
   JYigFLWLTMpnSI0luABeIdy468g2tMpWoCQpBFdwRISXD/33RsY83d8eQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1565661"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1565661"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934195370"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934195370"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 09:17:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 08F1D1043; Thu,  8 Feb 2024 18:59:40 +0200 (EET)
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
Date: Thu,  8 Feb 2024 18:58:44 +0200
Message-ID: <20240208165937.2221193-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
References: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
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


