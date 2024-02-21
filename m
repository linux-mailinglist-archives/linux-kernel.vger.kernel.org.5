Return-Path: <linux-kernel+bounces-75307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5723B85E640
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 442EDB23BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E2086146;
	Wed, 21 Feb 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jejBQQc+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1226E85940;
	Wed, 21 Feb 2024 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540500; cv=none; b=DliA4COkb/4qxSPjbjPy2U05F7Gy9zLIWZ27oNC5HKYFc3hf6i4wtyzI57ZFzwc/9s4R2nMFR4WmK3GDdZqcJgiAoaR/AJmfdF9P38W9ZneFE7THypvkJ4S3qIcwrZdiZZU9lxz7oEMlv0VmRro3uk6hIf/ncUt2uYRGyhsuX4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540500; c=relaxed/simple;
	bh=tmZdQU9N4IY5BcwLubSQEg1Rug6tt9UVDfRrfuekMhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4BvvYpq4mkh34oOIzCvtHjXlZtVdKcc50juZfDl6paVDeX6NgUHVCSIFqQ1WFw1VuYsC2PXDOBp2QOM4m6L85IeEC80iPdTBOAuS/Bp5dLghq9si4SjQ0jh8p+XYeIox7zwtb9GiZaWkMx0pEWDF6mfxp13oP6li0SZBeHSNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jejBQQc+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708540499; x=1740076499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tmZdQU9N4IY5BcwLubSQEg1Rug6tt9UVDfRrfuekMhA=;
  b=jejBQQc+bdmjIFcC479yeWf2YNHhg3ycWun96tcRPFZHvxe/O8NS2CIW
   GjBKto4qcvqP33GwJH539Z9dKb0CNJqqPCSPTYtTbcV58LVzfKT0Uk089
   g7rhTFfAcy84Lg2rjdvyBMCXUYCKXUeEvvxB8VTOkLAwOX8tSDai84NHz
   pt/qtI2tcTh42m6P2TOyxB1jPtk9O7+cTlxr3xfJCrMAP66KEnRC+6XvH
   z4GV36kHH39ow31JUem0bVAR9sq0B3/akB/KDP4+NYY84NA4z+s485xnf
   5Ss8R8igWb25kMnNGlFNDYgjWdk1ToDuYypqIKFF6EXtdDizjgKToy2Bm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28164731"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="28164731"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:34:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936684742"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936684742"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 10:34:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CCD9C34C; Wed, 21 Feb 2024 20:34:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-tegra@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v1 02/14] serial: core: Add UPIO_UNSET constant for unset port type
Date: Wed, 21 Feb 2024 20:31:18 +0200
Message-ID: <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some APIs we would like to assign the special value to iotype
and compare against it in another places. Introduce UPIO_UNSET
for this purpose.

Note, we can't use 0, because it's a valid value for IO port access.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/serial_core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 2d2ec99eca93..2b0526ae1fac 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -470,6 +470,7 @@ struct uart_port {
 
 	unsigned char		iotype;			/* io access style */
 
+#define UPIO_UNSET		((unsigned char)~0U)	/* UCHAR_MAX */
 #define UPIO_PORT		(SERIAL_IO_PORT)	/* 8b I/O port access */
 #define UPIO_HUB6		(SERIAL_IO_HUB6)	/* Hub6 ISA card */
 #define UPIO_MEM		(SERIAL_IO_MEM)		/* driver-specific */
-- 
2.43.0.rc1.1.gbec44491f096


