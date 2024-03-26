Return-Path: <linux-kernel+bounces-118634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD02F88BDA3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC0A1C36CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E8D6CDA0;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HB9bN9/q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F714CDE7;
	Tue, 26 Mar 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444841; cv=none; b=qJfh0Bf4M1WQeES5XC5whRIFa987jW5WP0OwUreFTzyZRCQpP6nzYXx8O86w6RsVSYv457/lwwOSRsyr1Z/IlujA/3OqCi8CbJlB3qA6dzDgLKdQzCI8ZRddOFUnT5DdWImeyPOeawLrzoBOxNYy6PkmaCJzIjBC9cUVIFbwWnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444841; c=relaxed/simple;
	bh=kGnW5gfhKYhw1Pks7Kc754F46CzA94AxnSmZUYp3IXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n0p2aSVJbupfWQSiwxbQV3SbFLjrrtRETUp9NVQ4A8JPtT3Yo9PYj2Ar9988/JYP8alyYvZjSUOd/VsN7efRNrJhnPlUgcW138Dr/Klwhwk073U5vPuELH1V29V77xBiBYXg/fynvO01IIcoivyliE7usw0goYiZHrVY1HVnjIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HB9bN9/q; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711444840; x=1742980840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kGnW5gfhKYhw1Pks7Kc754F46CzA94AxnSmZUYp3IXE=;
  b=HB9bN9/qEQoi03/fEqKmBtjXk0kIvpA232bAcCQQaXCfvTBcfXGKEgfq
   cSWKMIQMnUfJ1tYRHffTM5iOn3PFwj5uQVRQA8unyuNGwsK4g9n/8fmpE
   VEx/e+qvFY95eAIQIrW0fOJdvCKYrQsvwXA4UfNRynBc208OWfa1MpO0Q
   DbnwKyZXJALahdXl/hg5H0kXO16v7dgiMY2Rp5bV2fOL5HoFGMDWwwKSr
   YnANCWsYKG+MNev9XPpULWa/evnCne3UHYj9Vtg2naqkQVIbxJ3AFwMAH
   zZ8hM/pO5zOZW2tjzGz0GM5sgiZ1esB+wapy3zB+uBDy0FftCsZvSsSsX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6350339"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6350339"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="16293263"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:36 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 2/7] soundwire: bus: extend base clock checks to 96 MHz
Date: Tue, 26 Mar 2024 09:20:25 +0000
Message-Id: <20240326092030.1062802-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326092030.1062802-1-yung-chuan.liao@linux.intel.com>
References: <20240326092030.1062802-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Starting with MeteorLake, the input frequency to the SoundWire IP can
be 96MHz. The existing code is limited to 24MHz, change accordingly
and move branch after the 32MHz case to avoid issues.

While we're at it, reorder the frequencies by increasing order.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 05b2db00d9cd..191e6cc6f962 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1312,18 +1312,18 @@ static int sdw_slave_set_frequency(struct sdw_slave *slave)
 	if (!(19200000 % mclk_freq)) {
 		mclk_freq = 19200000;
 		base = SDW_SCP_BASE_CLOCK_19200000_HZ;
-	} else if (!(24000000 % mclk_freq)) {
-		mclk_freq = 24000000;
-		base = SDW_SCP_BASE_CLOCK_24000000_HZ;
-	} else if (!(24576000 % mclk_freq)) {
-		mclk_freq = 24576000;
-		base = SDW_SCP_BASE_CLOCK_24576000_HZ;
 	} else if (!(22579200 % mclk_freq)) {
 		mclk_freq = 22579200;
 		base = SDW_SCP_BASE_CLOCK_22579200_HZ;
+	} else if (!(24576000 % mclk_freq)) {
+		mclk_freq = 24576000;
+		base = SDW_SCP_BASE_CLOCK_24576000_HZ;
 	} else if (!(32000000 % mclk_freq)) {
 		mclk_freq = 32000000;
 		base = SDW_SCP_BASE_CLOCK_32000000_HZ;
+	} else if (!(96000000 % mclk_freq)) {
+		mclk_freq = 24000000;
+		base = SDW_SCP_BASE_CLOCK_24000000_HZ;
 	} else {
 		dev_err(&slave->dev,
 			"Unsupported clock base, mclk %d\n",
-- 
2.34.1


