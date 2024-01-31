Return-Path: <linux-kernel+bounces-46371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B2B843E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E331C261C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5987F80045;
	Wed, 31 Jan 2024 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqKh7eAg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B57F464;
	Wed, 31 Jan 2024 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701055; cv=none; b=gxAH70iaxXVGjmdgl+yiygK/ZpKarFj9PT3kIP40UvFdfSMoCRYwYzKdtM7RVB35L6FP8rYr0O75HA+JatIB3L4oJFpVuKtpIcKBsYshlatI0zNQamg7LoJiB6aMTdPWI3g6UpZVDRALIvV7I4i0aCkzfkuPcXLsMavooD8oQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701055; c=relaxed/simple;
	bh=+7P8ooaYXamG1JjYcGUuE0lFs56ZdtWnnIGwXoN49QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dkzeb/y/iIcv7uWtvF5AoIYlaFq0PlFAk6ehnKLoJx0FNgFexrdJXBdbQioBOt0XVX8TunIEw8195v6LpFX9SotaeBO2EziE24H/SCbNzdBF5QBuybi9rf4FvdcsSVnq8sF/mtNqPYFeqbFgeN17M9M20XFBqVOXXFTU3ETz3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqKh7eAg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706701054; x=1738237054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+7P8ooaYXamG1JjYcGUuE0lFs56ZdtWnnIGwXoN49QA=;
  b=BqKh7eAgCgZr7AvFXy2F0bLxMXltNFq/VlgKaSNQB8q28FP9AanHvufJ
   EdNDmn0FBrjPKJHxMk+7XySGDLM2x2cgVho6SKrvoDauu2jk5PLCfDb2P
   9pzfYtP6CDf79a1mQR/dNIhitLamdtmRxmnsx/qwZhICg6i5JYWJheU6W
   VFQpXwUcV/bpmgH+V9Nth6jEMD5m4Lao/NqHRWi+yx73+6CmkyNUYNDww
   OeBJDLRxJOKCl4SDRB0If6i5NfxTqNpwVGr5k8ClOZnfSLwSyjnXtu/kc
   5DIFtcwFjE1suPi+GyupzufSWoAVYqpSJBFndsq1WHaAZYX4d8bgTFLfV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3441658"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3441658"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:37:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788542507"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="788542507"
Received: from puhongt-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:37:32 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 5/6] powercap: intel_rapl: Add support for LNL-M paltform
Date: Wed, 31 Jan 2024 19:37:12 +0800
Message-Id: <20240131113713.74779-6-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131113713.74779-1-rui.zhang@intel.com>
References: <20240131113713.74779-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for LNL-M platform.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 9d3e102f1a76..a3094cb9f296 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1262,6 +1262,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
+	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
 
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&rapl_defaults_byt),
-- 
2.34.1


