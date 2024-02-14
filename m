Return-Path: <linux-kernel+bounces-64764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB9854296
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0321F24E82
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E5C1119E;
	Wed, 14 Feb 2024 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GR/iwEXy"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D311183;
	Wed, 14 Feb 2024 05:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890404; cv=none; b=VH2ABI5vMcv4UhOAEJSoFDmGYT5FdytnzRfiWy/W7JI7+F9vyMSF+8Eyho5y6e+DVX/Gs83jhLnOEkkbaa48i8jy3Vx9fL4XZgnD98nEoatSilqg4hMdXjZgbCyqzpdjyQnvz2XgBx01hZLtBkHrLKfRG6zKjfD/l2vp6qYYG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890404; c=relaxed/simple;
	bh=S89Yy0TSquu1IiarqlR9c1HsKj9O0OkiKkRYen5KW0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RHNeNcVyohwcwSMo/tASQYvXpPqEo7KSqgWiYKcPZnang+0N++GEcFP49oYCnsAmDHAFQQJr/U9SecjPUAZkcStrOHTgxi+5UIKOnUz2Z/rveYCLTiARFuP9OLXfdubqfA8c81CGcLy5ck2hv2A8b0pe12HOSxq+Sfx52Et8Bao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GR/iwEXy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lSQHVkEuXKOPPFhQR3VnljNy6UO4HmXBWr18LMiSUi8=; b=GR/iwEXyD3tLBMpeUjYZ/keMtD
	1gezL/isRmv679++C+NKYivKmw/E4HaXYqdnPhg67vttt50+knRd/2L/ban+wu1fhB4RAMO5xaUWK
	2O3ubxl+kZqJlV3ZLbfNjWQladoeRCO8nPXNZO9zg8xpNiBx290nlCOCJz2f4inHWZ2BQQE++QSCc
	fg9meOrd4gQ0FFYaoFBoZ/2netUVM6ThtydYF8g/48cGLNDpvpKHcVjaNCp0XyOsNa+488UvgREby
	3wLBw+KRNseHMMYWEVnKzG4yxQUlrFEfYTLy5ATnaxuDkFqTD7+lOtlUO4kyGBrpwx7AyUBurt2pN
	KljKQVaQ==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra8JH-0000000BurM-27Cl;
	Wed, 14 Feb 2024 05:59:55 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] scsi: jazz_esp: only build if SCSI core is builtin
Date: Tue, 13 Feb 2024 21:59:53 -0800
Message-ID: <20240214055953.9612-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

JAZZ_ESP is a bool kconfig symbol that selects SCSI_SPI_ATTRS.
When CONFIG_SCSI=m, this results in SCSI_SPI_ATTRS=m while
JAZZ_ESP=y, which causes many undefined symbol linker errors.

Fix this by only offering to build this driver when CONFIG_SCSI=y.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402112222.Gl0udKyU-lkp@intel.com/
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/scsi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1279,7 +1279,7 @@ source "drivers/scsi/arm/Kconfig"
 
 config JAZZ_ESP
 	bool "MIPS JAZZ FAS216 SCSI support"
-	depends on MACH_JAZZ && SCSI
+	depends on MACH_JAZZ && SCSI=y
 	select SCSI_SPI_ATTRS
 	help
 	  This is the driver for the onboard SCSI host adapter of MIPS Magnum

