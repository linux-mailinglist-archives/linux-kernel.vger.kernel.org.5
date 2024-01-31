Return-Path: <linux-kernel+bounces-46372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B14F843EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CEC71C280AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E0680BE1;
	Wed, 31 Jan 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWoGmA+u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417887F7F4;
	Wed, 31 Jan 2024 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701057; cv=none; b=YDr8efGtvyAzhdUwv41nyZLFb2Xig41tbWXNUsCkBJ1zwxq04P/HHSkoOvX0ALJpUCdFOZ6tKN0r6E8WygmrfWJEW7V0Cj2zYxi0hq/2j9G89m08TR4Vi5hIJnLOc6xndxd7C38ARG0z5fNCDrdMhDYTTSDCI2z6l8ihRn3Okps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701057; c=relaxed/simple;
	bh=3wEv6gpWu5XkRdhubo8bpcen3Ln1BI1Vmy7qOX9Tb8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=blvgaMhaNLdJgYKyK9nZr/PZ/oXcN0TJbday+RGxNU8aiH2QoWHu+1ZfbnSN34kgJjuQQtu6VXs1OH/n7l20Wx+7C8h7JMUOpp4q9K4eMsOs1GF01hF5j7cgJKlxCaaA4HAYpZEG83NJTUcvHxiTKxCsEMEmSfTIgk8t0uzP9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWoGmA+u; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706701056; x=1738237056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3wEv6gpWu5XkRdhubo8bpcen3Ln1BI1Vmy7qOX9Tb8Q=;
  b=PWoGmA+uYHsazKEu4TwaRCI+xJ3HS5Y/eAs/3UF3uayNScJRzp2jTy9f
   Il+IkcpG+ZXSjS1SDM5x0BZDk8SdysfHkhx9kNXL3lO3RAqbQsVth5ET+
   wzrOtZCWBiIK9kX8BnTEjHL59dnGKzQjTddUFREKRKUgOhnSza3KYN9H+
   L9a3rxo2KZEpNc0/WgKRBB+ATdOI8Vhi/vcF3X0sLvuw+HPiTltGfKJXQ
   bQUNCR4rfYSpEDXU3o14jgpDnHct/o/7Fdy4vUa4JcMW9DRy9DNAqJsHJ
   IzTzZf++X55bwzWv5hzEDMLYDYE7O13v/2Z7FMs2JYfoI+VnV4FNwhor/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3441668"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3441668"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:37:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788542511"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="788542511"
Received: from puhongt-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:37:34 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 6/6] powercap: intel_rapl: add support for Arrow Lake
Date: Wed, 31 Jan 2024 19:37:13 +0800
Message-Id: <20240131113713.74779-7-rui.zhang@intel.com>
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

From: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>

Add support for LNL-M platform.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index a3094cb9f296..aa627a6b12a4 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1263,6 +1263,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
 
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&rapl_defaults_byt),
-- 
2.34.1


