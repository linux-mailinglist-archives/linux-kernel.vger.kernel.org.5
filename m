Return-Path: <linux-kernel+bounces-53267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC5484A2E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D82A1C23BD3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE1148CE5;
	Mon,  5 Feb 2024 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRo+KYJ6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269583CF58;
	Mon,  5 Feb 2024 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159572; cv=none; b=P/kJ9EFesFtDObdfAw3cvP9/T26QWwNRn8Xfx3RjdwmGn0uXWTkbgs3ACW0+lxBZtc4Lqa6M6ab1jMn4XU+VlOVMb1bPCtE0gvlaGtAGJNeWUswgeE8fhrnACKPsmCd5jnuQeks7RFks45BWIReXFKlIxC+g+AJgFNfLMPZF69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159572; c=relaxed/simple;
	bh=UEIOHhvL4g19aA5VxyfFMvMc+35jqRicCI0VD6kXsR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QO6v4okRUoAeMjydYZiV/HutBVyJRUlG+uePzDkDaf8vfMU54RAeimmZGAXcd0mXKi3lVpfsLTLPGujvCIfRTyjsOkzadkZIDdbHRvjpBZDs2QlEjRDDtB0V97wDRL6yNcUZRQJgiLeZIe174bQc7QftX3RD9/NzFlDOFoAqLWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRo+KYJ6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707159571; x=1738695571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UEIOHhvL4g19aA5VxyfFMvMc+35jqRicCI0VD6kXsR8=;
  b=IRo+KYJ6BRVCUOaUV03qrnvml5JDcKOgCwvzNIEAV9cmJAmyUPdWN1Hw
   ugQEUFCtAIuubVoR5CgpGG6IU7iO63/BHzMf5t3qOz0YTbJbxQ8u7tCWO
   bb1s5jhmjHkJP3gXLEDXe6kdOP8nxgb8sgWhxZk1QpoJlLEshbD8BHxkJ
   67f6zGnvBzZF9llsD1QkADznm9qLcss2qzKoMUO/3D4Ubt9AmO2wU0ndt
   6532gcgdUH/VNyNqR+Pq484kgaHPLSqMFhVNPQ3jiH5oXPth/6YOhlvSC
   BkAbYRfxkJTER8ejXpSIq6DD3Om9SBF5QREt7bltHmkQh4ww1dulZZe2P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11320390"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11320390"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="31879446"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa001.fm.intel.com with ESMTP; 05 Feb 2024 10:59:28 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5 2/4] iio: hid-sensor-als: Remove hardcoding of values for enums
Date: Mon,  5 Feb 2024 10:59:24 -0800
Message-Id: <20240205185926.3030521-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205185926.3030521-1-srinivas.pandruvada@linux.intel.com>
References: <20240205185926.3030521-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove hardcoding of values for enum CHANNEL_SCAN_INDEX_INTENSITY and
CHANNEL_SCAN_INDEX_ILLUM.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v5:
        No change
v4:
	NO change

v3:
New patch. Added as the next patch removed the hardcoding of enum values
when submitted. To remove unrelated changes, created a patch to just
remove hardcoding of values.

 drivers/iio/light/hid-sensor-als.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index ed5c42aa7cca..144c02fbbbc0 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -14,8 +14,8 @@
 #include "../common/hid-sensors/hid-sensor-trigger.h"
 
 enum {
-	CHANNEL_SCAN_INDEX_INTENSITY = 0,
-	CHANNEL_SCAN_INDEX_ILLUM = 1,
+	CHANNEL_SCAN_INDEX_INTENSITY,
+	CHANNEL_SCAN_INDEX_ILLUM,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
-- 
2.43.0


