Return-Path: <linux-kernel+bounces-107559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAE487FE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC451C20A22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A948120F;
	Tue, 19 Mar 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhpGfCYH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C996A7FBD5;
	Tue, 19 Mar 2024 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853587; cv=none; b=ieXbtmyiYy0YTaw5Zt0yeM1FS99+YOysSTqbDP7PVGheQXiGDxSdj5GkxKfdpjnf5xsisULCwbiZDht8s7ChQFaD4ZcX5QYV5NmmRveP4GFElnBKZy2LOT81Om4aR34u1POB1j4V+nj7wW38aDllbxZDe9RO3OQpJX7nSdBucKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853587; c=relaxed/simple;
	bh=gErqH5iZ2fUCryD2fkCZUAp/vYOS2rcIZgcdaSpVZdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fc6r2pi2VMt/NzyGrw5a1w/pX0dfY57OSIOPPRQAlAJT8n0C5VEnAjanOLOMM9wkXPdYcXn8P+WZ2U8eGWWR5tTUMDT92KsdHbtadU3/pUwbb3QG19CQy3p+t08r7afTvKj3Lo/ZVBsg9LzDVLIsFpBgkK2it0423Y6UKZscWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhpGfCYH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710853586; x=1742389586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gErqH5iZ2fUCryD2fkCZUAp/vYOS2rcIZgcdaSpVZdg=;
  b=AhpGfCYHyQ83+0DHFbogdxs7MzqiByto/R8en0ZQHSn2enkLZP47rX6J
   pBGj1z+HuDLA7FClO0v1thjSATMHmUwk/Ti3X3IyNEl7xFIg108E1rZMZ
   Fun3MVd5Slkcj9XYKPdfVmGTqMX2vKdLlOco4CZrOG5yfZzcEr9pWEDx5
   DSQ5TvJZHYIL+C/Z7TTvBt4AlOB7oIFaKfbt464SDDFQItfmB+xk4BC83
   cqhEXXjua09vI4fiAkJ/56AxJZ427jqGeY89EXh2kGAcpV9DFkGRuuW7+
   qlBN8bWUnGzWch/b9lmal3LFEvFaKO4vmjlv5LswrYr1vYZirdlRYwSun
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5842943"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5842943"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 06:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="44883222"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2024 06:06:17 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com,
	pandith.n@intel.com,
	mallikarjunappa.sangannavar@intel.com,
	subramanian.mohan@intel.com,
	basavaraj.goudar@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v5 04/11] igc: remove convert_art_to_tsc()
Date: Tue, 19 Mar 2024 18:35:40 +0530
Message-Id: <20240319130547.4195-5-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Remove convert_art_to_tsc() function call, Pass system clock cycles and
clocksource ID as input to get_device_system_crosststamp().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 885faaa7b9de..0f568fc4b902 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -901,7 +901,11 @@ static bool igc_is_crosststamp_supported(struct igc_adapter *adapter)
 static struct system_counterval_t igc_device_tstamp_to_system(u64 tstamp)
 {
 #if IS_ENABLED(CONFIG_X86_TSC) && !defined(CONFIG_UML)
-	return convert_art_ns_to_tsc(tstamp);
+	return (struct system_counterval_t) {
+		.cs_id	= CSID_X86_ART,
+		.cycles	= tstamp,
+		.nsecs	= true,
+	};
 #else
 	return (struct system_counterval_t) { };
 #endif
-- 
2.35.3


