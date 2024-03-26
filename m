Return-Path: <linux-kernel+bounces-119657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B4788CBA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32CD32572D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A9785280;
	Tue, 26 Mar 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8nKDkgq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3DA21344;
	Tue, 26 Mar 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476640; cv=none; b=Rl2bAlYGIOEa4jQvhTJomlmRa2NlxY35Ux5TdbVcVosaQzozjDeY+twgTifqqPJwwIUbbX+fVbRNF9lS18z12Is7roYsOveSxV8BMPhOoVlipLf3SF5WFXchbmcNblbWZmfHfkVOoJWXH6FK+LlKHRrn8WukSc49kCB4cryar/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476640; c=relaxed/simple;
	bh=X27htwA7sCrDGlSqisjWeGimBkuhSBHYDfK89zkUYkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAiJe/QW3z0tHOaRxRaPQ3/NOLh09cfcLJzm+UReRHKJNasAPwFsevTZULJMGfDzK+k/y4OSJLyB0JtdPO6XPvHNSwK/i6MwB3cYA5h84jiTo7r8r3mCMVNqEVmdTIWMsjU3UxZ7QYLpInWoWoL0kjtFKL8nsbR9UFmtucXIOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8nKDkgq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711476639; x=1743012639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X27htwA7sCrDGlSqisjWeGimBkuhSBHYDfK89zkUYkM=;
  b=Q8nKDkgq9eCrrcGVZNJSQqO6LH/kaBMunai/jXQa7pDmHqx46aLhJHcN
   QHx+iTd65fpj9Ix+mgjUY3kUOW2mH+4O4GHE71iLd7wSbM41vXMFgfkFr
   psTrQA4uhRlaX5qc3KpRajvcyWFa9s7bHTUstiD9pb7JMaU+1cuJoTFsZ
   wi0Gne33Ay+ufrmXTQJHyfiIYyt6fK8jS1K7/69MpPhD7qG2L2NiJ6AY5
   zG4G13R91W2p0pthLQnRECZyh4z7IL5VVv4xz0rJ+/NszbX3CLEucRWHc
   wrMP9Zred31KSFm0Lg2AAYQpzWm1azm7tODMzl+wRsOgMI7mPZrelncLi
   A==;
X-CSE-ConnectionGUID: F1Mm8bO5SZKziOdbIB+yJw==
X-CSE-MsgGUID: QN+NZjlxSRuhAoXA/wQwNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10325661"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10325661"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072936"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072936"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 11:10:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DA566524; Tue, 26 Mar 2024 20:10:34 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 02/10] spi: pxa2xx: Keep PXA*_SSP types together
Date: Tue, 26 Mar 2024 20:07:52 +0200
Message-ID: <20240326181027.1418989-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep the PXA*_SSP types together in enum pxa_ssp_type
for better maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pxa2xx_ssp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index cd1973e6ac4b..844a2743ca94 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -217,9 +217,9 @@ enum pxa_ssp_type {
 	PXA27x_SSP,
 	PXA3xx_SSP,
 	PXA168_SSP,
-	MMP2_SSP,
 	PXA910_SSP,
 	CE4100_SSP,
+	MMP2_SSP,
 	MRFLD_SSP,
 	QUARK_X1000_SSP,
 	/* Keep LPSS types sorted with lpss_platforms[] */
-- 
2.43.0.rc1.1.gbec44491f096


