Return-Path: <linux-kernel+bounces-56003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A71C784C4D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483D3B27F63
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D32224CA;
	Wed,  7 Feb 2024 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNBTfKVH"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5931A23761;
	Wed,  7 Feb 2024 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286212; cv=none; b=cqVI9p33mp0COpFQg0D5tmqVSNmL+1hA/rqYGcOiCb8VBpFeOK36jbbSVIRV27Jd1gmItu7HNJkB22uzYvgTRxZ8P9C7oiFy3RhNFGE5vFsg/ujvX9y0r+PWJ3HQwCow6VaFKjoN6tXO6bbS39zFPi2pwHupR+jBHtKGegStvZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286212; c=relaxed/simple;
	bh=6PS4+2Ywv1DMIM5u9+tNfbsYVKa0PISW1H4pAS3IZH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9TtldAEt/WPMHRE4ysL8UJeSk7+VHujxAmTxbNvOo8Ox1OXTDXrTL3b3QTghefEE1adhkElP5Q5uOtNHPojhTHjjfdU5JFhN7BAGT5ND+DRYAHnHg4kjpiG60nTPd8LSbrXBHuwsX48QZS/laHTqSAkbYkltXGr+M0wTW/B/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNBTfKVH; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707286210; x=1738822210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6PS4+2Ywv1DMIM5u9+tNfbsYVKa0PISW1H4pAS3IZH0=;
  b=hNBTfKVHiOQvJvGJmtLGzCRM+Z7ooOQVcC8L6+4jyuvlCKrPXAFpyDmD
   7kLT032VSW9S+pZ8mPBBVkH7/Uot52VmmottkKGSHMHSzcH7QWH7gsJuD
   YXskFrgWrf+1OnrPL68iuRRa4aiYbwcbZArqGAEAkvRamGcGRGHWDGkuk
   rIZipmyKLLC2XHpFhrIHBUrw5SeCYHJfff2hnhZcxd5b3i+JLFKt+Eb+u
   X04ve7zoOU5Q6609wTCb0ZI7MF7u6gzvNdsvdTH/IQCZbBWTPPHyXOjsP
   zxeAkd5qekINTytSFBe9cl0g30ZJV1ymK6gBJFziAPiTemH7W8Wm866eP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="436054098"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="436054098"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 22:10:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="5849933"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa004.fm.intel.com with ESMTP; 06 Feb 2024 22:10:03 -0800
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
Subject: [PATCH v4 10/11] Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
Date: Wed,  7 Feb 2024 11:38:53 +0530
Message-Id: <20240207060854.6524-11-lakshmi.sowjanya.d@intel.com>
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


