Return-Path: <linux-kernel+bounces-35077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0BC838B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C54B213DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9A55C91C;
	Tue, 23 Jan 2024 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6k4TKJq"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CE75C8F2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005008; cv=none; b=kLy5LpcaQNeZAn3i0sq6zMpwAirLZJ+2nDVtw1RTuEyssn3Yk5PZavHLLnlfZNCDe5t/9lYy21RLcwMx2e2EN7Dz+gAUV3t1kY0uEsEItYPCbqmNFrXwicai+nl5aU4bmLFFGGS/sKUUiDW7snEGqBC1PBnsDI067lpc8+ktxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005008; c=relaxed/simple;
	bh=AvNiMb5S18Sd/bE6Pi2YCH0/QoChPkp9h/HPBHfjKxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aamCUw9nzz9Q5NgsSyDZNnvd4iNVmRtE3KrPROSP0f/JnRVktvORHiBrM5+2i/q34JYLg/BKZ2ycpgRSoo0/yEBWI/8BP5k7zoNKHNurQrtZMExNFnV4N26dv0m9E+ATRNQfRjM1Y9ddS9iZTqSjmEhy/1y08NF3GXSd64/ln7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6k4TKJq; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706005007; x=1737541007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AvNiMb5S18Sd/bE6Pi2YCH0/QoChPkp9h/HPBHfjKxc=;
  b=F6k4TKJq+j5BB9e0TF7CkrPE5ugCyn3Uqckr80GpFauo3Q9D65RTb8AN
   Ge7FKg29/lDSTDbw+83jvWlmUbImEfd3KR2VbaXpepIB/B4Is2HFSvmlD
   YinP2ag2YW0OsPpPaQhZKyv1/YQ+n42h3AO3/MT0akInkLAn1+MYlUak0
   F53J4rBtYt874zcSFPvJlIk0aUiNhOCV2EXZ6IWoqtpHvjX54TCyj6UuQ
   CanTk39FCSF+vYrkuk9J1DSTX8uG7+VtMOODK/XPHcpRarAP00SURJh2/
   j5zw40f83GvWOZkTbl64pEZbLV6Yj34gBXNdL4igbwJO9BJiIQo8MwSy6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="391900218"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="391900218"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 02:16:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1549641"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 02:16:45 -0800
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 5/5] mei: pxp: add dependency on Xe driver
Date: Tue, 23 Jan 2024 12:16:25 +0200
Message-ID: <20240123101625.220365-5-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123101625.220365-1-tomas.winkler@intel.com>
References: <20240123101625.220365-1-tomas.winkler@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

Optionally depend on either i915 or Xe drivers.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/pxp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/pxp/Kconfig b/drivers/misc/mei/pxp/Kconfig
index e9219b61cd92fb76fcabe89d..aa2dece4a927a570c1e325fa 100644
--- a/drivers/misc/mei/pxp/Kconfig
+++ b/drivers/misc/mei/pxp/Kconfig
@@ -4,7 +4,7 @@
 config INTEL_MEI_PXP
 	tristate "Intel PXP services of ME Interface"
 	depends on INTEL_MEI_ME
-	depends on DRM_I915
+	depends on DRM_I915 || DRM_XE
 	help
 	  MEI Support for PXP Services on Intel platforms.
 
-- 
2.43.0


