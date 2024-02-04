Return-Path: <linux-kernel+bounces-51650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11E4848DE9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6EE1C21D83
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1577225D9;
	Sun,  4 Feb 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqJm7v9M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CBC224D5;
	Sun,  4 Feb 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707051819; cv=none; b=pnX4AQ9B2HdV+c3HN3jLjgZWE1YzF3IZdOSkLLs1Zht6Atn4IaJE6dSHMB20jk7mo4Pkulj+HjP/ca2hP7hYXakwTQpl/TbBTSX03Mit47Rl/hYiEU6ZwCVsEjrJnYwfI9xYf/akuGTU3+pVlFPlTNffYKjdmS9RID39idrh59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707051819; c=relaxed/simple;
	bh=wi21UyEkV/3M6i59lU0acIMbkpPlIykoycCjdPF2J1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=erRPjpXAGYlsRXHsUqRMFIymccV61ga/Ubhzdnb9sJjFH310Rh3dR0UHTUs0Efuiu2RBN8XTXxDfAuM+SmvNJqZ89lmy+BZj6DopI0p9naQy/EmOXz0BOfEQOtdiwjFsDcFLoiV9AZQ5KCR+c1ZuQfqb4+ek4Fp3vsIDco4eevo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqJm7v9M; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707051818; x=1738587818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wi21UyEkV/3M6i59lU0acIMbkpPlIykoycCjdPF2J1I=;
  b=UqJm7v9Mjyo5d/El0XIURyhU0/wlBOhCxqLg/YRwglUQsbJxdMsqf3eJ
   pPvy56aNWBg8HwLD83S1RdDCYUqu5Q+YhNGsnvUDUIZwmGcpsARImyMcV
   kc8GNTb3tJ+SdOgKAdE+eiv2vat2dlae0Upa1Meu9C5hGA2PgaDrEk3+I
   butz87uVGnEYXRF0ctIbxAQ15DetplcoC0jbRLDyeHdD+jt6xOLUmtzZP
   8+NPjonZQrwcDBLYKoKovVx0oM7SvYT2Gz2NRK67MJl7C2LmyqsloHfDO
   j03UkVyyacZGurBP5fHFddKhugoyiCuwvU3JTb1l/62I/UGaNNwacnxpC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="4283238"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="4283238"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 05:03:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="37918237"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orviesa001.jf.intel.com with ESMTP; 04 Feb 2024 05:03:34 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 2/4] iio: hid-sensor-als: Remove hardcoding of values for enums
Date: Sun,  4 Feb 2024 05:03:30 -0800
Message-Id: <20240204130332.2635760-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204130332.2635760-1-srinivas.pandruvada@linux.intel.com>
References: <20240204130332.2635760-1-srinivas.pandruvada@linux.intel.com>
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
v4:
	NO change

v3:
New patch. Added as the next patch removed the hardcoding of enum values
when submitted. To remove unrelated changes, created a patch to just
remove hardcoding of values.

 drivers/iio/light/hid-sensor-als.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index d3b892c0e307..521af52b3f3b 100644
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


