Return-Path: <linux-kernel+bounces-55999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E384C4C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A68EB27E71
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47EB20325;
	Wed,  7 Feb 2024 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQ0raAcm"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D81CD3D;
	Wed,  7 Feb 2024 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286185; cv=none; b=AJsFwR9b8SsCQPx9SMGG12t26yEESzDbdwtBiI5ADAJ2tH3VYdHl7RkcUqBUmF5bTk0nVWYNPyzzXachpI1pP8wZDDe3LHFtJxva+AiHYGbixhX0XFsRJjEdMoLQY17geM0Y87MoF9U0q6wZEp2cM1V6EuHPqbolSVjK2wqUkAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286185; c=relaxed/simple;
	bh=W10ncAbxufnh5zyGwKufTz7fuO6HXps1+JuIZZy6KjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kalkwg4IDQwX1LsLDm7npSJ+QReTN4DiYb+Gu+kqdO1qww2G4TOoSPt76rSrre2hCvalpAfBgQNAaPT1PhsbnBDSXBUexBcuHxCZsSruJcSuC0glzK1QII/4OblwKhiI9bvAj81sxXFYPVtuNvC8tIQD5hwf8hMPpPXV5K6zDzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQ0raAcm; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707286183; x=1738822183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W10ncAbxufnh5zyGwKufTz7fuO6HXps1+JuIZZy6KjQ=;
  b=KQ0raAcmpgkT+Ren+8Qc69oo7XAgfGW766kIoTip/Gj6OS0FNoBVu5Bt
   elHAAopyCuvXS/wHCxY2e1O91Fvg4PeMe/3kJmS5hBx/ajdQykkoennQj
   w0kVoCQBC37uLKvhUqRtCzWpXLO5Bk1OXQ9hITOE3CZaXsvYkXsINtw7R
   Q1YhLX2mPpiaUq3rvuDp8TkiWKKytOuJdPWS1ESzCbvbE5kz/nQba+Bm/
   k/Buw3FTNKr1D/+XRFAqH4FiHxy22F6bxVJ4sbpp7MhpTyGdXsylSj7dv
   Uhn/aIs3CJTrhstBYwQ1BycFAaCZ4ZBUVat40gsW+zV9qsmwUxUM7JOhk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="436054014"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="436054014"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 22:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="5849799"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa004.fm.intel.com with ESMTP; 06 Feb 2024 22:09:36 -0800
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
Subject: [PATCH v4 06/11] ALSA: hda: remove convert_art_to_tsc()
Date: Wed,  7 Feb 2024 11:38:49 +0530
Message-Id: <20240207060854.6524-7-lakshmi.sowjanya.d@intel.com>
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
 sound/pci/hda/hda_controller.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 3e7bfeee84fd..5206adedb000 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -455,7 +455,8 @@ static int azx_get_sync_time(ktime_t *device,
 	*device = ktime_add_ns(*device, (wallclk_cycles * NSEC_PER_SEC) /
 			       ((HDA_MAX_CYCLE_VALUE + 1) * runtime->rate));
 
-	*system = convert_art_to_tsc(tsc_counter);
+	system->cycles = tsc_counter;
+	system->cs_id = CSID_X86_ART;
 
 	return 0;
 }
-- 
2.35.3


