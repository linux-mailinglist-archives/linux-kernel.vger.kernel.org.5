Return-Path: <linux-kernel+bounces-95832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE8D8753A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B881F2992C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C058212FB24;
	Thu,  7 Mar 2024 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKgXYZLg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739212F58A;
	Thu,  7 Mar 2024 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826320; cv=none; b=JuCtRX0G+cU325EmcQGLZS88h5xqzuGRlALsDn7rtoIWBiyPG8FGU6viajnDeGJkKXjNYKpAcMlmcP9AK42DPXfx95YlL0hyU82gmlUg+WWCP1p4/mlgARX0ZVgvs6yjR58qPQxz5vVifz3Y+NGgTHJQ+tpmadb9phSNerKqx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826320; c=relaxed/simple;
	bh=XXvje3DsPXFomNyXuJGV+9j2nWWkci2XhBpIRqsHwDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YM/KrZm/xu7yx5YUt1EzNZtlbrc9SgYDcivl09L9t9d3alDP94FLWHQTXFZRlsAZYF0CYX1i8O54wwOH5tg3slVNaE/sANT9roex/FzHQBciWEcHk5sQd5jTJbFC6zODYy5iggITCsznAJWKv63bTsGbktk3S6Cgl3ExMFGYbdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKgXYZLg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709826318; x=1741362318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XXvje3DsPXFomNyXuJGV+9j2nWWkci2XhBpIRqsHwDM=;
  b=jKgXYZLgjZcqVrUm53gGG7U5viXk+8Pw0sdx9gqYv3QTV8JPf9MVXQFs
   iquTWfsVA7vR2dqASq5xej2RRHX9AB5Xne343nrZxXsb014ZWDPPVbCv7
   GDxaWJGtTyofwKye0C2zMx7QWsp44MphGFUgOtHp9AJzvODXfYXvMi3Ev
   tdamR0g3O4KNu2dn+fIq4NokKC300kOt27YyGk8pOyESEBqbZfcaLMoDU
   3ncx+F1HmTeUbNM8sdZC/Hqdyfr5MaM47GscPGo0bRgdenU3F5WKcnBVj
   8R0tSYWcH7J1Sa1FKEZVmfDi5zuOyVsA90LZOteImHxkX4/lK3f7UgCEu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15221963"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15221963"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:45:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046335"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046335"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 07:45:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DAD9C3F1; Thu,  7 Mar 2024 17:45:11 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH v1 2/3] spi: xilinx: Add necessary inclusion and forward declaration
Date: Thu,  7 Mar 2024 17:43:58 +0200
Message-ID: <20240307154510.3795380-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
References: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xilinx_spi.h is mnissing inclusion and forward declaration, add them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/xilinx_spi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
index fd6add419e94..4ba8f53ce570 100644
--- a/include/linux/spi/xilinx_spi.h
+++ b/include/linux/spi/xilinx_spi.h
@@ -2,6 +2,10 @@
 #ifndef __LINUX_SPI_XILINX_SPI_H
 #define __LINUX_SPI_XILINX_SPI_H
 
+#include <linux/types.h>
+
+struct spi_board_info;
+
 /**
  * struct xspi_platform_data - Platform data of the Xilinx SPI driver
  * @num_chipselect:	Number of chip select by the IP.
-- 
2.43.0.rc1.1.gbec44491f096


