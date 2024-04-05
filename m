Return-Path: <linux-kernel+bounces-133489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B09989A475
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F53B284700
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3827D172BC1;
	Fri,  5 Apr 2024 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJ6osTbx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76417279F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343455; cv=none; b=OVXycSgWMscOJr1VLUsbaU//qDHtrUc28ujXJ1lJpBL4Mq5JtEhyOadKf8NrmfVXDQPIbsLdyGDIUOwh5y2CfxhkLc1hDs6v60MJJ1Azp/9rZcoF58XyLPoE/mFbbmTYIp3K9mq2hm49+oUYMEln/XIr8ErZkudbJE2SIHSv8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343455; c=relaxed/simple;
	bh=zZ+xB5nyTR/vHeP+8xGge3oZDV08qibVrKtCdr7AIxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJ/IYN1Dijy/rDg2NqbEZ4crS4e1UdylbGZJZ/9yKoyPe3Dr88HVcgAsYCkFCfc/8vOgCKrlFW3akQworv0PqNE/yHNRj2p6nt1+pscuJRjtX48LQjkh9vP0G9CSeqWb6/saD4KnC9Abk8F5xdEpfAMYF2J6iOFYnEYHnfFBgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJ6osTbx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712343454; x=1743879454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZ+xB5nyTR/vHeP+8xGge3oZDV08qibVrKtCdr7AIxo=;
  b=MJ6osTbxQe33+nLlHEyElwSeT3kuwRmqI5ZB7xJ6gWgtm39ca4pqi6hm
   Z0JCtmiwMMWXHkEypQJ8Rr0pvdnkpyJsFUvunxykEVj4wvGL6Ux6AFf4n
   ayKCT4HvYzhzyfWVPdDEH+AaJ7cKpXn8u1EuH42GGLhGhq1N5vrO8TW+f
   lJBiSLK75yGox5rSjntXDpRs7kz5iM0C6Ry4ovSa6Rfvv2fmMKaJ0Cxl6
   3DmJgrGAJKYEcmGOAiWH5z+oQXv5RvHlrxxYYueNhQjS00AjMaHiO7/ba
   KMQEwU5hX4jcxIIa+nTAyoKK/Rpur6Ghik9MNKYq5CYzDCpzN44InNE6M
   g==;
X-CSE-ConnectionGUID: DMfVZThUS+mPppUSxYJMUg==
X-CSE-MsgGUID: n9l0btjhTfmIVzkqigOoCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7588304"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7588304"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 11:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="937088094"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="937088094"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2024 11:57:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1AC3B812; Fri,  5 Apr 2024 21:57:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] genirq: Fix trivia typo in the comment CPY ==> COPY
Date: Fri,  5 Apr 2024 21:56:46 +0300
Message-ID: <20240405185726.3931703-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240405185726.3931703-1-andriy.shevchenko@linux.intel.com>
References: <20240405185726.3931703-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IRQ_SET_MASK_NOCOPY is defined with 'O' letter. Fix the comment.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 97baa937ab5b..a217e1029c1d 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -115,7 +115,7 @@ enum {
  * Return value for chip->irq_set_affinity()
  *
  * IRQ_SET_MASK_OK	- OK, core updates irq_common_data.affinity
- * IRQ_SET_MASK_NOCPY	- OK, chip did update irq_common_data.affinity
+ * IRQ_SET_MASK_NOCOPY	- OK, chip did update irq_common_data.affinity
  * IRQ_SET_MASK_OK_DONE	- Same as IRQ_SET_MASK_OK for core. Special code to
  *			  support stacked irqchips, which indicates skipping
  *			  all descendant irqchips.
-- 
2.43.0.rc1.1.gbec44491f096


