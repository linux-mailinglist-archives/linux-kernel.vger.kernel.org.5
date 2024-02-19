Return-Path: <linux-kernel+bounces-71194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF1985A1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4769284689
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D45328B6;
	Mon, 19 Feb 2024 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBdJxPIP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5C52E84D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341734; cv=none; b=eRdyQLl1c8MqC1TNLs6eLQTxolCeAG6fUQpZLp0GgWbYUAO7XEUxC2b94om8j1UArCOKnQ7B4K/FBIplV3UOa2/f6XSrEJLbr6VCA9wwNk6yNvIXVlJypwfwFRsKjuRRksVJIXwr0QFRMBXnXbiz6QavRD3Gw7mdyWUrrAQZQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341734; c=relaxed/simple;
	bh=SU6KvDmjdOLfKEuiZcMfCTvca3+Q7A/X/vy1dY8kqnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LcaJe2B+PLJKBufBwb9jOcCuUN7CEf1rgDDeP5UqLSgI2ALRQKi6FyjRt67OoNKvUThCLS9U2xz/t85fTSliCvB0yx4RDb4Zhr+meopjHc6B4JuSjXLR0CUaINOLaaV8OSNe/xcEHW6vyowQ58+fcta77w+dKBAPUqn36JG3CQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBdJxPIP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708341734; x=1739877734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SU6KvDmjdOLfKEuiZcMfCTvca3+Q7A/X/vy1dY8kqnw=;
  b=EBdJxPIPo4sTDzacUdw5qr/UfWMp8L2qPPd9XtT08rek0PjqODxZzYL3
   7/vLaUPkWXkgRbECXrUSn1Szlvr6yfQ1fh+THVGNFPF2oolA/sJTc/jw3
   hvik2zTyU6v5OdHi9yVSGsoOLu53d5j2WIqVmfdKPW6dqKS58LaL+wVa0
   VIZJ7MvCzs1h/soVYw8ZcER1HmzBYYQcGzWAOwUE23mwEKLtGe1gAl0Ff
   0Z3oge1y3dDjSygKdPkaAaiiwe5cFUEdK6JVcoiuJCc4oKoa4C54CMkgM
   RLD4gTqegpMaAJJaZKTWC73lEV9PTkFPSj6ZHVF4stAhYoYRBfPfv9ZW0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13823406"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13823406"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:22:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4826883"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 19 Feb 2024 03:22:11 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] iommu/vt-d: Set SSADE when attaching to a parent with dirty tracking
Date: Mon, 19 Feb 2024 19:16:00 +0800
Message-Id: <20240219111601.96405-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219111601.96405-1-baolu.lu@linux.intel.com>
References: <20240219111601.96405-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

Should set the SSADE (Second Stage Access/Dirty bit Enable) bit of the
pasid entry when attaching a device to a nested domain if its parent
has already enabled dirty tracking.

Fixes: 111bf85c68f6 ("iommu/vt-d: Add helper to setup pasid nested translation")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/r/20240208091414.28133-1-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index a32d7e509842..108158e2b907 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -657,6 +657,8 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 	pasid_set_domain_id(pte, did);
 	pasid_set_address_width(pte, s2_domain->agaw);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+	if (s2_domain->dirty_tracking)
+		pasid_set_ssade(pte);
 	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
 	pasid_set_present(pte);
 	spin_unlock(&iommu->lock);
-- 
2.34.1


