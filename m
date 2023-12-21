Return-Path: <linux-kernel+bounces-8145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E55B981B2A1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF6F1F25719
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE394E603;
	Thu, 21 Dec 2023 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PS9s22oN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671F4E1C3;
	Thu, 21 Dec 2023 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703151202; x=1734687202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PmpIlUpx7+DXd9SlbVWYDCreHkh1wtkoXMr9WfcfHRg=;
  b=PS9s22oNcCafNoLKz47o1xVCyQ9j9PUPSKuWE5NJeI+bCi7sGOdDOQrM
   HsKXqAjK9DKs2la99kAFgAjKNSg4PfDMBRga0EWfVPV7Lfj24k9REx84M
   ulm1KLw+o4hZ7ZrCYklv2EgJ2ocB5dEmb3Mo426eMe20VIMXYxdmqgmOI
   I5qRZnaLylsx7bY+TSIlNwabxJovFU+jd3oPOXBSD3UKj3MhvVsvkZTLA
   9SUFnEjAbJm72ivyc2QZN63U5VYBz0FPLfmNdCBWTsdH7CPdxrTvDFnmh
   sf/V/4u4XL4Mj8buWOoec0+lDioNbsxOzlZwIPNSL5dj+5+M/eqBNUUYj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="3188505"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="3188505"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 01:33:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="810918187"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="810918187"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga001.jf.intel.com with ESMTP; 21 Dec 2023 01:33:15 -0800
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
Subject: [RFC PATCH v2 03/10] e10002: remove convert_art_to_tsc()
Date: Thu, 21 Dec 2023 15:02:47 +0530
Message-Id: <20231221093254.9599-4-lakshmi.sowjanya.d@intel.com>
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
 drivers/net/ethernet/intel/e1000e/ptp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index 02d871bc112a..9d8be03a9827 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -124,7 +124,8 @@ static int e1000e_phc_get_syncdevicetime(ktime_t *device,
 	sys_cycles = er32(PLTSTMPH);
 	sys_cycles <<= 32;
 	sys_cycles |= er32(PLTSTMPL);
-	*system = convert_art_to_tsc(sys_cycles);
+	system->cycles = sys_cycles;
+	system->cs_id = CSID_X86_ART;
 
 	return 0;
 }
-- 
2.35.3


