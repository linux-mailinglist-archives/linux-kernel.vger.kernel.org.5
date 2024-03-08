Return-Path: <linux-kernel+bounces-97302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A02A87687F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA011F22190
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6262E41F;
	Fri,  8 Mar 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="me0Ygm/l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070DD567A;
	Fri,  8 Mar 2024 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915370; cv=none; b=aDlbYrWZlAGQYQGLm0zT92RMpdfUU7ABQwOCLWvUALBl/3sE6RNInsQ6ZdrUFuflT5RorqievJPVpS8fe2EMG+bpTL1ipdXoUYmjMoF9T3MvvrGVpPams7taabdXiUuWNivBiTpsKq4JW08xGL6Emgys2nAj5MffzkK5EijE3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915370; c=relaxed/simple;
	bh=N2Lj7v7SQf44Fw/UBAwAY4LOmM0FmrkxHyZgEKxZtPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M9tcffhJ/piBvRknK5Y4gaaoqVi6kWiqB/eJSJFRc4k/NO9PBOIwPJuespmQDD7dajSgIDgsMDCWXCN/eAmov4JiI7AfECyNMW3e395LbgQI3y8jTkYBjLqn228TTbVS3P7Ach58n/1aZt++HcL05UwoZ4S01G/2hjIkyg/JGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=me0Ygm/l; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709915369; x=1741451369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N2Lj7v7SQf44Fw/UBAwAY4LOmM0FmrkxHyZgEKxZtPA=;
  b=me0Ygm/l4ODJNoztjJw0wtenTSkBH96gFpTlC0YFfef+ZUkvCaeMQbKJ
   zj5jxqLrVBeaww+LoG4XhEddsrXzXr1eyNXZOYF9L9pe0eXSExkpU8Q/a
   I/m59BcWAG4eB/vJTW/aI/Urp6t83gEGBW9t5DPGWPTLwV7zn4FJnueiH
   T12QN6dU0PNf7WG+oQNh3KzfCGYSzaQyDhQdOTfwu23yqZr59JYqZp8Y3
   3n0xhI8b0dttZLcXg7Zrfvb3BDtu96wAHxVYZ5nqfnJMpRWPMuUAV3GIa
   RAq4qMaIasxt3Eyc8N9IMY3odtR3EpI7VcrWxI+S0iYxgioUx77ABq3Ze
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4806754"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4806754"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 08:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="937047683"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="937047683"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Mar 2024 08:29:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9C93C1F1; Fri,  8 Mar 2024 18:29:25 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 0/3] spi: xilinx: Massage xilinx_spi.h
Date: Fri,  8 Mar 2024 18:27:45 +0200
Message-ID: <20240308162920.46816-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel documentation and inclusion block, and dropping the size
of the num_chipselect.

In v2:
- added tags (Michal)
- reshuffled fields better to avoid gaps on 64-bits (Michal)

Andy Shevchenko (3):
  spi: xilinx: Fix kernel documentation in the xilinx_spi.h
  spi: xilinx: Add necessary inclusion and forward declaration
  spi: xilinx: Make num_chipselect 8-bit in the struct
    xspi_platform_data

 include/linux/spi/xilinx_spi.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


