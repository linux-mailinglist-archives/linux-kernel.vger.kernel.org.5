Return-Path: <linux-kernel+bounces-46369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D75843E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A761C25B30
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66047F463;
	Wed, 31 Jan 2024 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkpR5TKt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF07B3D1;
	Wed, 31 Jan 2024 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701053; cv=none; b=nyot7oZDQHgpp4KkYKH7y33uoh3HsMFwTjTTA98rVrpNqDrQPJqsMLYyyaMlozYs+MVtAnWTxtvkca/4Ji9l0gYyhvXDEswW71s01e3QjhnTNj/USzon3DAZlrfGjHc3bB0ahE3cmnn0HC+a4bHy7ANemiAhtMXnB1urSp6e6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701053; c=relaxed/simple;
	bh=VbGVsMvlR6qLCq5piw4v45/5b+9I9zsshnAjLePRsqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OYV8vcANEIixbthTTIdXXWw4B2VoLhTyUeonq06031wL4XLahv/WZwKuu+/QaGPNbOuT203ckDWNTVtcbMob2vg7Cz5hQO0FQ29HlT7Yu35fhyYXq8r1ng6AlmrmDxxdJvkOro3myqvvnYxiz01y38nmiDAMi3IER8OZ/8oizps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkpR5TKt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706701050; x=1738237050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VbGVsMvlR6qLCq5piw4v45/5b+9I9zsshnAjLePRsqA=;
  b=IkpR5TKtYFISiqvNHGBdb8CfScpggzwA1JrXKV5e83AofD9N/+Enn76m
   Izd7jxwpUNnQBn+sYkRhhvXvMiqDmyWkUUiqOgFIWuc/Mpr6IeIwwjjbk
   vCV5/j8SPl9gf/ocNx1zbuscRBSZEi42wSFbFmngZ5xilnvP3IIgjVq9i
   bmwB3jKEQEbaP2DxBOFqDY8o90CXSLLYLWdOaajUVQi7mCyxqIwOu5AKc
   j2NR0kqooHGW8djN7IvLJITkuXcFSh24pKhG0kbhsyxpIcrFllSnMysTy
   fS4QVsLRFNm/Zes9PklF28qainUlVIhf9O8Q/gKZDgOLAWXUOyVH5MPD5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3441637"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3441637"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:37:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788542488"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="788542488"
Received: from puhongt-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:37:28 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 3/6] powercap: intel_rapl_tpmi: Fix a register bug
Date: Wed, 31 Jan 2024 19:37:10 +0800
Message-Id: <20240131113713.74779-4-rui.zhang@intel.com>
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

Add the missing Domain Info register. This also fixes the bogus
definition of the Interrupt register.

Neither of these two registers was used previously.

Fixes: 9eef7f9da928 ("powercap: intel_rapl: Introduce RAPL TPMI interface driver")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_tpmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index 891c90fefd8b..f1c734ac3c34 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -40,6 +40,7 @@ enum tpmi_rapl_register {
 	TPMI_RAPL_REG_ENERGY_STATUS,
 	TPMI_RAPL_REG_PERF_STATUS,
 	TPMI_RAPL_REG_POWER_INFO,
+	TPMI_RAPL_REG_DOMAIN_INFO,
 	TPMI_RAPL_REG_INTERRUPT,
 	TPMI_RAPL_REG_MAX = 15,
 };
-- 
2.34.1


