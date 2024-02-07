Return-Path: <linux-kernel+bounces-56000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E56484C4C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18182864F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1B6208D2;
	Wed,  7 Feb 2024 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4qqeLTI"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E859208D1;
	Wed,  7 Feb 2024 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286191; cv=none; b=MltZkzoEj7h5dR3WB+4SpxiwEAvGOrb1uD3h65PF2T9nNkvMnMiWll1v1kfSzIESS6boMis45jFWyixfhtXBsnwuSviXexTT53zOkyCJBxr8SDlFRnDHvYS3nF7PxOHBpvV2p8QXk9CHfUb/wCyRcy41yIDpRGHw4wUcuU7o5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286191; c=relaxed/simple;
	bh=ts9UT2ntYUOZBJlItohtQOI0E/fFKNFBPAIy0JZJFSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pDEjzhH6oNizCc+cnmzhX2pIJQVcGEUs1JQGkVO7GKN048haLr39g4Z+lX6ZqETSneNbCnUmVP3Qk6/IBtp9pIGYZ7FRCbc2BZax+6UhFNBFti6mgo0zDLXNGDSoHF46Z6XVjsEQASkQjDEycCNDI3d5d5KCthbkbHNzJdohy4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4qqeLTI; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707286189; x=1738822189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ts9UT2ntYUOZBJlItohtQOI0E/fFKNFBPAIy0JZJFSY=;
  b=h4qqeLTIxEZn5wAbu4yZAiWprgIgOucYPm2vmIPwwdUPh5FpTGZX91Hj
   cYE7ixlehBRTdix35CppXfwUWQqqvY3s7pyOnHdK5Tk3s7A1jvvwfNgRN
   RkoShRl4H2mSjs1QUjaY4UiXsgZyAgaEzmHcVC/Xqb/kpZK4mandmnw62
   id/x3tPZ2TGiKAvAIZ/7RKKLlEoI1Cgn+iIcz5AqfuHKw1sj2blEF/FEH
   Zkrg2nNNU17FQjCgZedvrc1BLMfusM2EmXUbVt38d+XaL0qoJNE4a4ll4
   coL8aOFpifguUQENZN8LaCqCj7o+FJgFTRK+Kk0jX1ifP1DoUf/3i8fKc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="436054034"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="436054034"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 22:09:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="5849830"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa004.fm.intel.com with ESMTP; 06 Feb 2024 22:09:42 -0800
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
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v4 07/11] ice/ptp: remove convert_art_to_tsc()
Date: Wed,  7 Feb 2024 11:38:50 +0530
Message-Id: <20240207060854.6524-8-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240207060854.6524-1-lakshmi.sowjanya.d@intel.com>
References: <20240207060854.6524-1-lakshmi.sowjanya.d@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 3b6605c8585e..104b3f7a7cfc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2101,7 +2101,7 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
 			hh_ts_lo = rd32(hw, GLHH_ART_TIME_L);
 			hh_ts_hi = rd32(hw, GLHH_ART_TIME_H);
 			hh_ts = ((u64)hh_ts_hi << 32) | hh_ts_lo;
-			*system = convert_art_ns_to_tsc(hh_ts);
+			system->cycles = hh_ts;
 			/* Read Device source clock time */
 			hh_ts_lo = rd32(hw, GLTSYN_HHTIME_L(tmr_idx));
 			hh_ts_hi = rd32(hw, GLTSYN_HHTIME_H(tmr_idx));
-- 
2.35.3


