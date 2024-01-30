Return-Path: <linux-kernel+bounces-45384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A12F842F87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A11928775A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B5078667;
	Tue, 30 Jan 2024 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejlFTTY7"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B77D410;
	Tue, 30 Jan 2024 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653246; cv=none; b=QtCeldqiBxdCRsEK29Id1ZOTDfG7RdBzlfZRGQCElqZRgsCh7VfbKURW+dVfpgu4IQvJmU89nHnCUGObxWUBebnMQIvsmGT9UhMwKSNkOinSCci0NmD3SBTqJGxkcl8qe4UtBXMpXC6QOWlhTkJXVRzrvduj03PbwdX0YcFzY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653246; c=relaxed/simple;
	bh=At0RKTLoBHv44HG3Uy9zivC4vUPHbbq8Oy87lxfsgWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvE7Xph6PYaRX0N+K/FY9Rq1rZRYMW1OJE7jrAy9Mqy0CgnYopP3dxr/lJ8IHVbU2XS7D2DrKLS3G6Ky1fdR/ivVi7+keSgvyESPLOp4Ic0qfQupyF1Z0ONJaB64kES/AZtUrmIE+mMNbMu+aqyK8+UVgCISmk+ISFAAtve+SxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejlFTTY7; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706653245; x=1738189245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=At0RKTLoBHv44HG3Uy9zivC4vUPHbbq8Oy87lxfsgWQ=;
  b=ejlFTTY7YqCsg8cB+Cqd3xY4NnYlnfsLlT6LdrI7U6tvFIlg8HoJ4Vu/
   Ayz3lZeTXD7pCaUL9mDIw8ehB41yytUgFjG5NcKUMi3+hmt7MH4s1ENoj
   bWk8ly4/vtX4dn04n8sqOH9dmqlAmayhqr7UpJ3rvIHuI3Wbuqzx4fok8
   ca0d+Wq31N0AlIfsy1wzkyywB4HWfVCpT8g0bdgmFwPqm6NXQCBXoVN4y
   xwpvN2midCK4a5OJQRHH4+yCf7yX8aGQ3tCARM1vPvgnltLGoAUDQ5Nvs
   5lZJzw0Ho7lvWON3ZY16yecVtv+4IhyF4iKc+pV5QB9EWd5VwGWPybf6U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403041708"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="403041708"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 14:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119412838"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="1119412838"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 14:20:42 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	x86@kernel.org
Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Drew Fustini <dfustini@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v15-RFC 1/8] x86/resctrl: Split the RDT_RESOURCE_L3 resource
Date: Tue, 30 Jan 2024 14:20:27 -0800
Message-ID: <20240130222034.37181-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130222034.37181-1-tony.luck@intel.com>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RDT_RESOURCE_L3 is unique in that it is used for both monitoring
an control functions. This made sense while both uses had the same
scope. But systems with Sub-NUMA clustering enabled do not follow this
pattern.

Create a new resource: RDT_RESOURCE_L3_MON ready to take over the
monitoring functions.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/core.c     | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 52e7e7deee10..c6051bc70e96 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -429,6 +429,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 extern struct dentry *debugfs_resctrl;
 
 enum resctrl_res_level {
+	RDT_RESOURCE_L3_MON,
 	RDT_RESOURCE_L3,
 	RDT_RESOURCE_L2,
 	RDT_RESOURCE_MBA,
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index aa9810a64258..c50f55d7790e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -60,6 +60,16 @@ mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
 #define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
 
 struct rdt_hw_resource rdt_resources_all[] = {
+	[RDT_RESOURCE_L3_MON] =
+	{
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_L3_MON,
+			.name			= "L3",
+			.cache_level		= 3,
+			.domains		= domain_init(RDT_RESOURCE_L3_MON),
+			.fflags			= RFTYPE_RES_CACHE,
+		},
+	},
 	[RDT_RESOURCE_L3] =
 	{
 		.r_resctrl = {
-- 
2.43.0


