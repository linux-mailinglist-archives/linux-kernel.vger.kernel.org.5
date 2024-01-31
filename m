Return-Path: <linux-kernel+bounces-46370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEF6843E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B04C1F25846
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3147F479;
	Wed, 31 Jan 2024 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHR3II2i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A47D3F5;
	Wed, 31 Jan 2024 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701054; cv=none; b=oLvF6Hnrsb4RXWJgtgTAY+jjf7DrPquUa/F1W7DkxIpcr2jQ22VAbo3uP/hyl4hGEW56h1QvXbF8jNXuAPxVXeoJ7yyhEMZSJRnWpBUjFG8WEfTali0dkxm/7u2G0Pw+mrSU8iK0yIUsLy7/uhFpavAUSK9RQ5jwnpwFmFPJL9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701054; c=relaxed/simple;
	bh=qqS366ENXAObLZelQMQdQKQUmZl5yUdXm3AHKjxtXp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pKXo3mT1OmHRrtzGw8iuh8L1W0x7azL/TdU++9d6+ZeDtE+BhjkVkXKb3vNSSdL9fx1hFp0Kv27nScrLjL+AepewBV8N7C7LZ6IisB5grxDvv65Zyd0yAtqOeYzV4Npu2mqsHatsqm9jtiyRpa6fyD0iTuvS/VJJ3/rTErv5iNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHR3II2i; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706701052; x=1738237052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qqS366ENXAObLZelQMQdQKQUmZl5yUdXm3AHKjxtXp8=;
  b=NHR3II2ioMEs+bVqqettnbQe1SUBQs1ykmOX3+/25PrHVgi4uX7eKwEB
   Myj5ylSeOXCbM7YmYyvKU9nZowHWniNPjZj9h3KLipgVSjl0LxNnLtdus
   rH3A3RGIIsPv4+84ZwIoMYH/7o54Z9+LQNS+ewjBHPOXIoJZXuW7K+ySs
   uMXW9kcUcWH+AakuNb/YV8lqyF5B+fgWQNCSuD3azTjTLEYerUc/om3tG
   5r41Ryq9ahxN/EDcc3pS8nuJnmavOaN8EPCTtsjwVrfX70Hp23DWiWLYd
   j2dcfDvXW/Ko9U3knbBStfy8i9zbJAQ8rHt62aAC8/SRs/KsYFijyq3Vj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3441644"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3441644"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:37:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788542498"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="788542498"
Received: from puhongt-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:37:30 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 4/6] powercap: intel_rapl_tpmi: Fix System Domain probing
Date: Wed, 31 Jan 2024 19:37:11 +0800
Message-Id: <20240131113713.74779-5-rui.zhang@intel.com>
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

Only domain root packages can enumerate System (Psys) domain.
Whether a package is domain root or not is described in the Bit 0 of the
Domain Info register.

Add support for Domain Info register and fix the System domain probing
accordingly.

Fixes: 9eef7f9da928 ("powercap: intel_rapl: Introduce RAPL TPMI interface driver")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_tpmi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index f1c734ac3c34..f6b7f085977c 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -131,6 +131,12 @@ static void trp_release(struct tpmi_rapl_package *trp)
 	mutex_unlock(&tpmi_rapl_lock);
 }
 
+/*
+ * Bit 0 of TPMI_RAPL_REG_DOMAIN_INFO indicates if the current package is a domain
+ * root or not. Only domain root packages can enumerate System (Psys) Domain.
+ */
+#define TPMI_RAPL_DOMAIN_ROOT	BIT(0)
+
 static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
 {
 	u8 tpmi_domain_version;
@@ -140,6 +146,7 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
 	enum rapl_domain_reg_id reg_id;
 	int tpmi_domain_size, tpmi_domain_flags;
 	u64 tpmi_domain_header = readq(trp->base + offset);
+	u64 tpmi_domain_info;
 
 	/* Domain Parent bits are ignored for now */
 	tpmi_domain_version = tpmi_domain_header & 0xff;
@@ -170,6 +177,13 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
 		domain_type = RAPL_DOMAIN_PACKAGE;
 		break;
 	case TPMI_RAPL_DOMAIN_SYSTEM:
+		if (!(tpmi_domain_flags & BIT(TPMI_RAPL_REG_DOMAIN_INFO))) {
+			pr_warn(FW_BUG "System domain must support Domain Info register\n");
+			return -ENODEV;
+		}
+		tpmi_domain_info = readq(trp->base + offset + TPMI_RAPL_REG_DOMAIN_INFO);
+		if (!(tpmi_domain_info & TPMI_RAPL_DOMAIN_ROOT))
+			return 0;
 		domain_type = RAPL_DOMAIN_PLATFORM;
 		break;
 	case TPMI_RAPL_DOMAIN_MEMORY:
-- 
2.34.1


