Return-Path: <linux-kernel+bounces-95831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AB68753A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C149288800
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A412FB21;
	Thu,  7 Mar 2024 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4AxfVfg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAB512F39C;
	Thu,  7 Mar 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826320; cv=none; b=bTuJSDj6KS+BYCuTWq8vts7F096Uf13Q8CLr3aN1rv25cQpuFwLKihIX/GjdkfEvQ8nayDpgSHUIvyMGcCkLXiygkDCG7cu0WFZViEb5XN3W97rAO43rrNwbqvit9FSo4WqafhpR9DBrIGe94ntNbeLhXoESyLZTHxk/cZ4L8fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826320; c=relaxed/simple;
	bh=ZTPKDVQ3ao/mp9y2Lnh/Vze6rnyYpTSQXwLgljoiS1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vAcCoiXjzhqEGU6MQp73Dn8FyRak3tQkrAy16pJio6yncUSH4iJ5tkqEZFSnf55pqY2PsG1XWi2S1Gxn+xS9Z2PTUx8i+PtpBALH2rYqdJPwv9ql835oGVrS6+J+5r30pIAER4q9rYkcsHmvP+o8LUDSfA5Xunyx8Hrep70bTgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4AxfVfg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709826318; x=1741362318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZTPKDVQ3ao/mp9y2Lnh/Vze6rnyYpTSQXwLgljoiS1g=;
  b=g4AxfVfgr/P3cX7T6uBnIO1kbvL+YxLHKE6vwxc8i1uUn2DrVtoIYEIl
   qjSebYaylLl7V7hqhR5Ywz7U2Vudzb06v3K53d9Rtj8o9MJ5tntnkL/Jo
   pwZek357PDwjbJwwyX1K1rnBlX/RbLgZvCwpLCsM+qaYOY5gozwXALhsw
   eJdoFYDIzlVLFkCDdr57HOaF/5C2puE1JJMhlCJj9lb8EKgjmYGZnbA4j
   UeeUtwviFcCZl1anub8TvSpxlr2mIKRMyyOCjFz86K46bOTihVFLWbD+R
   y7DMrwfdpLI3KYedt2MMJXGJRv4+l32nnZJErPkZiV+Sl04LChFCqgUdi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15221957"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15221957"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:45:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046334"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046334"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 07:45:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C635F3C0; Thu,  7 Mar 2024 17:45:11 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH v1 0/3] spi: xilinx: Massage xilinx_spi.h
Date: Thu,  7 Mar 2024 17:43:56 +0200
Message-ID: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
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

Andy Shevchenko (3):
  spi: xilinx: Fix kernel documentation in the xilinx_spi.h
  spi: xilinx: Add necessary inclusion and forward declaration
  spi: xilinx: Make num_chipselect 8-bit in the struct
    xspi_platform_data

 include/linux/spi/xilinx_spi.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


