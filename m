Return-Path: <linux-kernel+bounces-75506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E6D85E9B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F9B28616E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BFB129A82;
	Wed, 21 Feb 2024 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hikl12X7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC856127B40;
	Wed, 21 Feb 2024 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549928; cv=none; b=cVeciyJqomGc91FPmxxo3/X5mV236LABq2N8ibZGW38z1vnrCQi72QG2oqR3RiDYVoH6DtH3GkFJVj3v0F+cIK0b0Bj7EVPStwMmEwkq6n5xg2mWhziGzoV1wrNPPmb5sBPIbYA2syQD+hfc2/NDeY+VFlPtxhyceoKdD7mEWvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549928; c=relaxed/simple;
	bh=KRiyyGKk5c6LKsxkMPIkDheNqkttEI3XK8ef20ZlAzk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QzCzeAsuej3vB0VfITtiaoTbom86Sl6mS1NwjQbVEv+kra0+qbvS01TfND4TZuzEsU5r4Aw1a/gL7JVaQqjDYZTxywEwd9UY00L1c5kgpuxczhWLSATjdedWQy9Ih36+Jx07sAyvPfIeodCR1V3/onVoTH7NF/tf9zf2zZFBNG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hikl12X7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708549927; x=1740085927;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=KRiyyGKk5c6LKsxkMPIkDheNqkttEI3XK8ef20ZlAzk=;
  b=Hikl12X74uIJcEHQh1cO4CnkqpS49bjoNP3g5y4DfIQLZBBXZZVri6YP
   hhrotc7ePC28xflWxg7Hk7QALgsAIZN6fHkr5uU/UzMpbH0GDAoRcIH75
   hFelE1y0O2l9hIjpct1t5P4xZpZKNYkIavy1yHHbDP3b3VRV+Mlf3etzX
   W0hS77EKUVpbLQzZNteLQGn2ekkzcojVBOwxj77GEbLpRzNtjzG7TRLfW
   eaSKKspTNe6u4tT42btenLhDyWh1foHMChbW/jV/x2xo+nd0r3eibqgIa
   s43tASIxrxNXHkXKk0hn5bQy0VGuU8sgSAncP3fj5I8XenHAD5gkGTrwO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13865880"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="13865880"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:12:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5214083"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:12:05 -0800
Received: from debox1-desk4.lan (unknown [10.209.70.184])
	by linux.intel.com (Postfix) with ESMTP id 8128C580DB4;
	Wed, 21 Feb 2024 13:12:04 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH 3/3] platform/x86/intel/pmc/arl: Put GNA device in D3
Date: Wed, 21 Feb 2024 13:12:03 -0800
Message-Id: <20240221211204.515159-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221211204.515159-1-david.e.box@linux.intel.com>
References: <20240221211204.515159-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To unblock Package C state entry, put the GNA device in D3 by default if no
driver is loaded for it.

Fixes: 83f168a1a437 ("platform/x86/intel/pmc: Add Arrow Lake S support to intel_pmc_core driver")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 683ae828276b..34b4cd23bfe5 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -673,6 +673,7 @@ static struct pmc_info arl_pmc_info_list[] = {
 };
 
 #define ARL_NPU_PCI_DEV			0xad1d
+#define ARL_GNA_PCI_DEV			0xae4c
 /*
  * Set power state of select devices that do not have drivers to D3
  * so that they do not block Package C entry.
@@ -680,6 +681,7 @@ static struct pmc_info arl_pmc_info_list[] = {
 static void arl_d3_fixup(void)
 {
 	pmc_core_set_device_d3(ARL_NPU_PCI_DEV);
+	pmc_core_set_device_d3(ARL_GNA_PCI_DEV);
 }
 
 static int arl_resume(struct pmc_dev *pmcdev)
-- 
2.34.1


