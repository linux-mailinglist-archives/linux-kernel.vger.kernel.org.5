Return-Path: <linux-kernel+bounces-97303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D205F876882
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732091F230B4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2857D54792;
	Fri,  8 Mar 2024 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7UoKGdJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D92D058;
	Fri,  8 Mar 2024 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915372; cv=none; b=STGqCLnWvrB4lWZuYEKL5jqlWhBziSat1beasLw2TRJFSR3cW1mqPMgF5uwK3MstZcwVNsHpl/73/5oxVKuqvbDsJy90pPh+SMI6XQ30UBkqPrCMYefSCZjSE1RDg+ChrPEuxrUhtzf/NZUZ6mQi7t8kjzE9XB1X1ETN0OU09Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915372; c=relaxed/simple;
	bh=5/XZC3z+eM8wwJ1lF4j9tR0kE6krkAhcW+WKtsojmIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uu/gX4kWLEx/lmWDj+B07xCR/TK8LmYAXzZep+kkmUKiKnv0ZrByY67X+mNnz9dxYNWn29n8apTrqdpW8HBuL26X/fhmZATECujfHgSceqAqhxY+HAgKeJirtahN1Odi9jFrU6euCCBe13v0KsOXdBz6aBEZPH6FHhPq70ZGdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7UoKGdJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709915371; x=1741451371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5/XZC3z+eM8wwJ1lF4j9tR0kE6krkAhcW+WKtsojmIg=;
  b=c7UoKGdJ8B8uT9N5UBK1oMlKyuK7qC0ieuRQy3MMD0Qi/95zxCLfctbX
   7Q+0yux2TxBefMlAGKeSx6vMvghY8i/QDbJvFyNpZ3VV/0a5KNLzhFMD+
   +1HUF/aoQJ7o1rlxpYYQzxIHGcbqUAIoeH0Fwyt4RBRzbkdQ1v+33rugF
   MiE3xK1Hs/oLJtO3nKVx7eRMRsib0iQCCYhBIHJDM6fOVr52aabrcX0/k
   GKCvnhUksJ2m0hZiB3I/v1/8WAOD6r2UEb3NPvb8AIsXgpsbpqRohgeg+
   k1ZkRR2i4co8D32hwzFgjwjHOa4cQ9FiePQfavKBejcTiks9qVQG0Oy+y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4806750"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4806750"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 08:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="937047682"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="937047682"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Mar 2024 08:29:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C7F7D369; Fri,  8 Mar 2024 18:29:25 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 3/3] spi: xilinx: Make num_chipselect 8-bit in the struct xspi_platform_data
Date: Fri,  8 Mar 2024 18:27:48 +0200
Message-ID: <20240308162920.46816-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240308162920.46816-1-andriy.shevchenko@linux.intel.com>
References: <20240308162920.46816-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no use for whole 16-bit for the number of chip select pins.
Drop it to 8 bits and reshuffle the data structure layout to avoid
unnecessary paddings.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/xilinx_spi.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
index 4ba8f53ce570..1b8d984668b6 100644
--- a/include/linux/spi/xilinx_spi.h
+++ b/include/linux/spi/xilinx_spi.h
@@ -8,17 +8,17 @@ struct spi_board_info;
 
 /**
  * struct xspi_platform_data - Platform data of the Xilinx SPI driver
- * @num_chipselect:	Number of chip select by the IP.
- * @bits_per_word:	Number of bits per word.
  * @devices:		Devices to add when the driver is probed.
  * @num_devices:	Number of devices in the devices array.
+ * @num_chipselect:	Number of chip select by the IP.
+ * @bits_per_word:	Number of bits per word.
  * @force_irq:		If set, forces QSPI transaction requirements.
  */
 struct xspi_platform_data {
-	u16 num_chipselect;
-	u8 bits_per_word;
 	struct spi_board_info *devices;
 	u8 num_devices;
+	u8 num_chipselect;
+	u8 bits_per_word;
 	bool force_irq;
 };
 
-- 
2.43.0.rc1.1.gbec44491f096


