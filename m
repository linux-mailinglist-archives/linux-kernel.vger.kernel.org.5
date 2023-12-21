Return-Path: <linux-kernel+bounces-8146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AAD81B2A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 066C0B26E67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABEA5102F;
	Thu, 21 Dec 2023 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e95KwguN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5551C26;
	Thu, 21 Dec 2023 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703151208; x=1734687208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FqzmFJD7Hjfw0d9iCOZZDYcOM+cgVL/B/wnjWMOn7QY=;
  b=e95KwguNwJeVqKo/gHrw5AfYu7+2068kw+T9iK2A+wkUq4GLTwb8fSR2
   yVtIISvmdJELyd4juX/Gc7cFeFXELoAe8GGnKsnUd/XiaxT3Vhml2hEJV
   S2wyilF4IVHeT/d7TF8geYMp/Bchtu0EsZjPmd8Zo/WVzXmgbvxcMqRyA
   zWlqyJJP71LxwpMmTJLFDNxbxH2e/bBtXHiE/Qukv674oh8K17FOaiiFy
   pMzmhj++xDbpJsY9k0ULQDE7kIjb8osPJ6sg6XccQwBetghcBFNHQhdB9
   9EuEV0cxJPopUaAX2+MJ4l23bcVG3Qr+PDFFt+/xkNrrrqbbWC4jVJ9XP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="3188551"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="3188551"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 01:33:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="810918202"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="810918202"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga001.jf.intel.com with ESMTP; 21 Dec 2023 01:33:21 -0800
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
	pandith.n@intel.com,
	mallikarjunappa.sangannavar@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [RFC PATCH v2 04/10] igc: remove convert_art_to_tsc()
Date: Thu, 21 Dec 2023 15:02:48 +0530
Message-Id: <20231221093254.9599-5-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231221093254.9599-1-lakshmi.sowjanya.d@intel.com>
References: <20231221093254.9599-1-lakshmi.sowjanya.d@intel.com>
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
index 928f38792203..11108eb075bc 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -911,7 +911,11 @@ static bool igc_is_crosststamp_supported(struct igc_adapter *adapter)
 static struct system_counterval_t igc_device_tstamp_to_system(u64 tstamp)
 {
 #if IS_ENABLED(CONFIG_X86_TSC) && !defined(CONFIG_UML)
-	return convert_art_ns_to_tsc(tstamp);
+	return (struct system_counterval_t) {
+		.cs_id    = CSID_X86_ART,
+		.cycles    = tstamp,
+		.nsecs    = true,
+	};
 #else
 	return (struct system_counterval_t) { };
 #endif
-- 
2.35.3


