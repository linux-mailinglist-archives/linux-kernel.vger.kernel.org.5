Return-Path: <linux-kernel+bounces-15145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E8D8227C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77AB1F239AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE7515AF4;
	Wed,  3 Jan 2024 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkuSnhuG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8D17984;
	Wed,  3 Jan 2024 04:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704255202; x=1735791202;
  h=from:to:cc:subject:date:message-id;
  bh=IGi0e3uXdLwqOum7ZLXcJjnmPDlSGG/id/BqMsxXwvI=;
  b=nkuSnhuG4JSt1+lV4aPIrdm+ti+xRDwlrX9PrjM5/7TaQYYf6xGL6ryb
   SArGfkrHpbfup+v2vV5kyhW1zxo24fp1Sjyo0tFawH2shqpfvKG/UiflO
   5L737s91DdoeGsMTKoa1dbZXZMSvS//FzT4gNyv5+HFF20RflIBxIfn5x
   edsUOLFgJBHNwiNWqokQme/7jX2LDllQNhKVguzyDfjMysaEONB31yevd
   VJNpj4Rq3XP07n1EeHdk7T9tP8MhmRRJWKhpOST4Hlrc8AeeZR17MRcSU
   6jjH2v+CYx4A88/ZdgxfYReyvYStDaYKywMp1TcedqRXw9zZnNl4ySeNN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463357395"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="463357395"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 20:13:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1026957000"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="1026957000"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jan 2024 20:13:21 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>,
	Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] thermal: intel: hfi: Fix memory corruption on resume from hibernation
Date: Tue,  2 Jan 2024 20:14:55 -0800
Message-Id: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

This is v2 of this series. You can read the overview and motivation in the
cover letter of v1 [1].

I smoke-retested this version on a Meteor Lake system. It completed 50
cycles of suspend-to-disk and resume. I completed longer testing for v1.

Changes since v1:
 * Added locking to hfi_pm_notify() to serialize RMW operations on the
   MSR_IA32_HW_FEEDBACK_CONFIG register. (Rafael)
 * Relocated a comment regarding the reallocation of HFI memory to
   patch 3/4. (Rafael)
 * Clarified that patch 1/4 does not introduce functional changes.
   (Rafael)
 * Indicated the first stable version on which this patchset should be
   backported.
 * Renamed hfi_do_pm_[enable|disable]() as hfi_do_[enable|disable]() for
   future reuse. (Stan)
 * Registered the HFI suspend notifier towards the end of
   intel_hfi_init(). (Stan)

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/all/20231227062940.10780-1-ricardo.neri-calderon@linux.intel.com/

Ricardo Neri (4):
  thermal: intel: hfi: Refactor enabling code into helper functions
  thermal: intel: hfi: Enable an HFI instance from its first online CPU
  thermal: intel: hfi: Disable an HFI instance when all its CPUs go
    offline
  thermal: intel: hfi: Add a suspend notifier

 drivers/thermal/intel/intel_hfi.c | 153 +++++++++++++++++++++++++-----
 1 file changed, 127 insertions(+), 26 deletions(-)

-- 
2.25.1


