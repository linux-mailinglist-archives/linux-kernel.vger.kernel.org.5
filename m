Return-Path: <linux-kernel+bounces-107566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D4587FE32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFFC2835F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B4480BE5;
	Tue, 19 Mar 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjNTopYt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F68002F;
	Tue, 19 Mar 2024 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853629; cv=none; b=o+8yHxQbVSKa/B5cp4Wtb6kTzAnPZ0XJlhnZYyzx/r4np1huEdApamUjUnoyCxgJNEV4FVMdsDAjRiJlfsiLFinrJdyCxFK9/O6aUH4usM60Hg6bEcHC0orXiozUO9mI+Ny6iODl/bnEvEtA1wIfND5QpuFKAcD/yRuuQifMF/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853629; c=relaxed/simple;
	bh=6PS4+2Ywv1DMIM5u9+tNfbsYVKa0PISW1H4pAS3IZH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3Nl/uaf05s+jCbhlVFPdgrPlR6gNQ133+51+YYnrGD3GqI4FWLGnR5vg+MG/Pf9t0R4fQKDBexnW8UllGT88VL3FYCMUIn7CJsDHjGWiEndQB1zUx8ZRwU2YuG3wb27daJ3XHI4rOXKxva7AaSLlkFYXAen437ScLjRULY/Pvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjNTopYt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710853627; x=1742389627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6PS4+2Ywv1DMIM5u9+tNfbsYVKa0PISW1H4pAS3IZH0=;
  b=ZjNTopYti3+yohtny3YV9IPJ1275J460RkpReUzISoSRyROzMq+bpO0i
   EyIaiBXm6hGs/bIPRVfYBnCFRDfzkqZqWFtocROXIHatJwFfFYZhUKGZY
   ix7X7jTjaKkoeVWuDyU61x7WsryU/ZQyHFd96Q/NqK8Q144AMQLdy5FP1
   FmkStxnN4FTK7NZvhmXQTxvdA2pXjwrbbq7NfKwe/u0qvr/wPEtdewmtx
   XaJTGvR8yDSd9ipECTBhlPiFL/EljEMCTHHM4axNEZz0ObF2219TIwfle
   t36XLrCUJkahj6eL95KgBbwLCxA+1q60qWLgrPzH7cKDFSfAejO7w+NJh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5843101"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5843101"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 06:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="44883261"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2024 06:06:59 -0700
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
Subject: [PATCH v5 10/11] Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
Date: Tue, 19 Mar 2024 18:35:46 +0530
Message-Id: <20240319130547.4195-11-lakshmi.sowjanya.d@intel.com>
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

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

Add Intel Timed I/O PPS usage instructions.

Co-developed-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/pps.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
index 78dded03e5d8..52a6d5faf885 100644
--- a/Documentation/driver-api/pps.rst
+++ b/Documentation/driver-api/pps.rst
@@ -246,3 +246,25 @@ delay between assert and clear edge as small as possible to reduce system
 latencies. But if it is too small slave won't be able to capture clear edge
 transition. The default of 30us should be good enough in most situations.
 The delay can be selected using 'delay' pps_gen_parport module parameter.
+
+
+Intel Timed I/O PPS signal generator
+------------------------------------
+
+Intel Timed I/O is a high precision device, present on 2019 and newer Intel
+CPUs, that can generate PPS signals.
+
+Timed I/O and system time are both driven by same hardware clock. The signal
+is generated with a precision of ~20 nanoseconds. The generated PPS signal
+is used to synchronize an external device with system clock. For example,
+share your clock with a device that receives PPS signal, generated by
+Timed I/O device. There are dedicated Timed I/O pins to deliver the PPS signal
+to an external device.
+
+Usage of Intel Timed I/O as PPS generator:
+
+Start generating PPS signal::
+        $echo 1 > /sys/devices/platform/INTCxxxx\:00/enable
+
+Stop generating PPS signal::
+        $echo 0 > /sys/devices/platform/INTCxxxx\:00/enable
-- 
2.35.3


