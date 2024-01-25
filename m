Return-Path: <linux-kernel+bounces-38603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC2383C303
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138AD1C21CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45034F5F1;
	Thu, 25 Jan 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaHY65Cr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1F94F88D;
	Thu, 25 Jan 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187821; cv=none; b=XPZGKtkKZ8ARmkSEgwAi5PSSi2eIEs5FKenWrJhrTPp/CeLfqERN80kt9/JRJPJ02+cbOvbSN8tgo5iO4Z4Ha3f9m1Nz316b+OCyknR6PAl8FzAhhYLkpVywwZFrXFe0vUXzqNti5QmpwxoKxIgmL6SKbW6yTMwlWBqLXeQ9pM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187821; c=relaxed/simple;
	bh=tQzaDBMgUReC4SUWQF95D0iTF0E6J/rlAPn3bkuWFrw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CDMHL7777IOBUKkzHzDcmC58Nhf7u8FqAjCMKfmlWKDS4cWHNzbOjL+J1Dn/fYdOWxIeS7CF7Bt+9Bb12eEKhbjmXasHoqxV2C0/rxRSGWPHwulDSOYFb/47rrD80rsVrAMaurcjg+EDL2ZPOfocyKK5yMToKIu5h9XXGhmbFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaHY65Cr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706187820; x=1737723820;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tQzaDBMgUReC4SUWQF95D0iTF0E6J/rlAPn3bkuWFrw=;
  b=YaHY65CrTi18f+blq2fdVLyrL9di/VDOzOl2AmGhypXyTAt6yBvxTuba
   H72LbByl59Oh2qleKVBd+MZ/eoA4Sl9eemfR5Zrgw5dYreW1N8B5xdGUW
   uS6Ce72hbZ0OTU1BwHvCcRSCond3IrQNmEAcJqvA+Rl/vvwS0SjZEsrvS
   c7GTmKjEWAfoccnRJPdE9qmbaDMJy4StvhH44QbC7xXfxXd5//W8g2hqN
   JJp3M6mqSK/N8JYD9h7aJI5ssd1JbG8PzRu+rVx+w52/aeFWViJsDak7f
   ZboZ+4H55dxbXLJ2ado2zutmhHZl4UqGx2eUH0DmasBUxA23vGR1CPMM1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8826371"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8826371"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 05:03:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2242003"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.252.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 05:03:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Jithu Joseph <jithu.joseph@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] platform/x86/intel/ifs: Remove unnecessary ret init
Date: Thu, 25 Jan 2024 15:03:28 +0200
Message-Id: <20240125130328.11253-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ret variable is assigned unconditionally in ifs_load_firmware(), thus
remove the unnecessary initialization of it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index a1ee1a74fc3c..03e49b836a6b 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -383,7 +383,7 @@ int ifs_load_firmware(struct device *dev)
 	unsigned int expected_size;
 	const struct firmware *fw;
 	char scan_path[64];
-	int ret = -EINVAL;
+	int ret;
 
 	snprintf(scan_path, sizeof(scan_path), "intel/ifs_%d/%02x-%02x-%02x-%02x.scan",
 		 test->test_num, boot_cpu_data.x86, boot_cpu_data.x86_model,
-- 
2.39.2


