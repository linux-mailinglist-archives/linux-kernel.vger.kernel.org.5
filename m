Return-Path: <linux-kernel+bounces-46594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B34D8441C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BC61F25FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77C983CDA;
	Wed, 31 Jan 2024 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRcOUOHX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0983CC3;
	Wed, 31 Jan 2024 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711040; cv=none; b=nUY25QNYfEPQ0mizJbqrIS7aiXXCAGJwOXEeCCo/0ZE0LHBgIM9AMvTvLuFizHGEtmm4h7raBkmyYyenVPGr/z7jYmwN3Yy7uLmzoslD1cZpgRtxrLmul69D9Lo7bUVRqcZDsZKVMWI83cOqJr4rGdbUkFlnDN6o/SGIjZbsxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711040; c=relaxed/simple;
	bh=ux9RKxYXwHAgHtI+Px/ktM89Oy29Ds3+ltt+/Ms31jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JY3aD2OttR6qWkHsHHKI3Vfu4pyxGtSMc6bv7bvoObmtUcPR382BpKy+JK9sYzHUtwhX1rrV+TY19nHsTKhGY/cIQGKc0r+gSgcPkL0GmDSoLDAdscNoSXTJLbVyNZMm/t+Q3RJ3NY1aQTnA/t8MBPf/iYCm9UCUcwJ3N6YTQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRcOUOHX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706711038; x=1738247038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ux9RKxYXwHAgHtI+Px/ktM89Oy29Ds3+ltt+/Ms31jk=;
  b=IRcOUOHX+nb7A9DEVhNemv8N7p8CrArezGXatJdkhZ7zKcS1YU+v0lZG
   strD7AauE95ISdCLTDxPusQJTsKtLzVc4DVqorK6PIbZIne/B3HQNQWv0
   kJWPAxjkKyAyw8uETDbisVnjHJhOG7oAyDjz1Sro9cUErwrSwnw+U+CQj
   +50uE49o719x5/YqEi+KZRAJ/OAz/nHsG92kpFTLerDFpL4VUmCDgHIuI
   A3I1WxBGzPwwnFSLG+ydf4gYNmKhgGYRBJLJpuhikuBYmYZ+OtUMI37fv
   lfy+J81MOsyi5BEI2vFfVhlee3/NG2uVDbj4FumZMEHswiPjYLRQjqIBO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10995829"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10995829"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:23:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4068741"
Received: from puhongt-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:23:55 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	peterz@infradead.org
Cc: mingo@redhat.com,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 3/5] powercap: intel_rapl_tpmi: Enable PMU support for TPMI RAPL
Date: Wed, 31 Jan 2024 22:23:33 +0800
Message-Id: <20240131142335.84218-4-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131142335.84218-1-rui.zhang@intel.com>
References: <20240131142335.84218-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable RAPL PMU support for TPMI RAPL driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_tpmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index f6b7f085977c..f131a086c535 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -285,6 +285,7 @@ static int intel_rapl_tpmi_probe(struct auxiliary_device *auxdev,
 	trp->priv.read_raw = tpmi_rapl_read_raw;
 	trp->priv.write_raw = tpmi_rapl_write_raw;
 	trp->priv.control_type = tpmi_control_type;
+	trp->priv.enable_pmu = true;
 
 	/* RAPL TPMI I/F is per physical package */
 	trp->rp = rapl_find_package_domain(info->package_id, &trp->priv, false);
-- 
2.34.1


