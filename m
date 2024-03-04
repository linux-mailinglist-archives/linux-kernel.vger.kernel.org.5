Return-Path: <linux-kernel+bounces-91039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8FF8708C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C6D2B20B4F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D99F6167C;
	Mon,  4 Mar 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6UOSYG4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4825F26AE7;
	Mon,  4 Mar 2024 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574885; cv=none; b=kjcizTVSvD/hAoE4cM6CZgJHuGvXkMlul7odtfPjLWj9gh4WY1COnM8D1G+ckxBC6kfVSBSjgyWCJH6n9h8LqXZTZepnzKxH8ixumw3WWK4Lfacin6pfskvTTGsIc2hZb9n+LwWNe8+ev7NWroK+pYTkIHYdVH6gOChQ7BFxzxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574885; c=relaxed/simple;
	bh=DAiHZRD/s/Dn2QzXEcQpRd8+jevafLQowuLlVAY2b0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=np1eOemoaKe3frs+7/urtCtDMfGRb6Q5BUfFJpUm5yqgxID6joBJErTUQOyf65EHtq1CL6Wqnl/hTOrkkHFoEPlMIbCm4jjxbOB25WBHeY1bJtZb3cpWSGTHZ9kIIEP73Z6Py5UcI5G4p4QlZFyWhHRWxCgmboga1D56vK5OSiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6UOSYG4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709574884; x=1741110884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DAiHZRD/s/Dn2QzXEcQpRd8+jevafLQowuLlVAY2b0w=;
  b=Y6UOSYG4dbYlspxKfNsJYXgJdJRYS7oXByW7dfca7N0cA419LCpbJt+G
   6Q9iWBGMmPOFPKq+y6Ufzl8iK7NNRMzCaJe92DOU7yIwHapRSTSKoiXm+
   OHZpAVYhZEmn1ZvtuCbYTvLDZs4dMH6uxTgSDzEcE0zh01lfthA9H1DUS
   TaovM27C505hot60naoVo2wau2fBdbmHAhOgbpJGSzmeRwYxffyeFkx8p
   DMQbNZ7u/5kgDCgPD5fFBJLxkS5WQg519YmjG7AIc/HVcKoyao3uRCwQl
   GQ7meXQ5asqdm6FlYLhIViHnjGbd/WyZmQItacWItGNNdZ+DsV/4cXl54
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4210250"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4210250"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 09:54:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040907"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040907"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 09:54:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 51C3A15C; Mon,  4 Mar 2024 19:54:40 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: John Crispin <john@phrozen.org>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH v1 1/1] MIPS: ralink: Remove unused of_gpio.h
Date: Mon,  4 Mar 2024 19:54:39 +0200
Message-ID: <20240304175439.1199865-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/mips/ralink/timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
index fc503679a93d..8b485cbe854e 100644
--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -9,7 +9,6 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/timer.h>
-#include <linux/of_gpio.h>
 #include <linux/clk.h>
 
 #include <asm/mach-ralink/ralink_regs.h>
-- 
2.43.0.rc1.1.gbec44491f096


