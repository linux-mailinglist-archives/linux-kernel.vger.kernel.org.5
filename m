Return-Path: <linux-kernel+bounces-46367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73800843E96
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69BE1C218F5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241647BAF5;
	Wed, 31 Jan 2024 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHWjYalG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0929D6D1D2;
	Wed, 31 Jan 2024 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701050; cv=none; b=K5XPhY5RrIEolWrGIExgV1U+O5MKd1X8eBPWLBq6Kfz6eD7cLF/2S/V+Y36WD5EBNKsLy/0AEtpa+DfXQKUE2DfIYOeuS1wpqkP4ZrfWJvXNv767A548zXgJ7bC4ji+HxcCkhrjZIBOCvtgKvBCBx8iMyLrIT3ebokVeMZY2uqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701050; c=relaxed/simple;
	bh=GvAqwQ4KOZBh0mXfOdAbuk8oUfo2FkUF0mPuB57A4+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HAS3gtaaSCo5bfUJNiw/Mb2ZeY6KrUNaYdxL/vP4EEBXxIK/ByeOAdO40dZ0GScMvfW2EJj2OXiaPgkngrSRDn3hHjx+uxj9UbtaTwPUVBn2Odlp84pVuHItdroRmxTo654iFw2uru6XpD/y58AuzCHAUgszLEu+KCABt4zLxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHWjYalG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706701048; x=1738237048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GvAqwQ4KOZBh0mXfOdAbuk8oUfo2FkUF0mPuB57A4+4=;
  b=gHWjYalGxYdoeFDEzjBJyiRO2S3fDrmTNbr9PoYEogwCfTR21QUZe23H
   pQ/Oorsi+Xgaj9TAjZJYwCIN8+CcP51CZlqLoj0vDPLRVf4NZcXq93TL5
   y+XrNusNotfgKq2MKdAd9GVCpNvNS/HpDBeddzlsOYqmg6PY05Cl6g08L
   lnXQPT2fdGUDbqecj/GkU+eIg73TBlLpLWqdTs4Ji2HMRnMzBd+dKgeIq
   87RLWT2gh4QEyHcAKiJeIjwNfl7+RCmFS/I1h1Xg7sXEG/8+MUqg4bi2n
   IXlKffMmwFw8qBDIZU7jh4L/WeKri7nblnsiFZBwiszBbgQcX1z+iYN3h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3441622"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3441622"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:37:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788542472"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="788542472"
Received: from puhongt-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:37:24 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/6] powercap: intel_rapl: Fix a NULL pointer dereference bug
Date: Wed, 31 Jan 2024 19:37:08 +0800
Message-Id: <20240131113713.74779-2-rui.zhang@intel.com>
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

A NULL pointer dereference bug is triggered when probing MMIO RAPL
driver on platforms with CPU ID not listed in intel_rapl_common CPU
model list.

This is because the intel_rapl_common module still probes on such
platforms even if 'defaults_msr' is not set after commit 1488ac990ac8
("powercap: intel_rapl: Allow probing without CPUID match"). Thus the
MMIO RAPL rp->priv->defaults is NULL when registering to RAPL framework.

Fix the problem by adding sanity check to ensure rp->priv->rapl_defaults
is always valid.

Fixes: 1488ac990ac8 ("powercap: intel_rapl: Allow probing without CPUID match")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Cc: <stable@vger.kernel.org>
---
 drivers/powercap/intel_rapl_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 2feed036c1cd..1a739afd47d9 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -759,6 +759,11 @@ static int rapl_config(struct rapl_package *rp)
 	default:
 		return -EINVAL;
 	}
+
+	/* defaults_msr can be NULL on unsupported platforms */
+	if (!rp->priv->defaults || !rp->priv->rpi)
+		return -ENODEV;
+
 	return 0;
 }
 
-- 
2.34.1


