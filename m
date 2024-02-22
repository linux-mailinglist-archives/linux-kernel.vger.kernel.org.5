Return-Path: <linux-kernel+bounces-77201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F33F86023E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADCBB24928
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC3973F04;
	Thu, 22 Feb 2024 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPyR72Wl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E073F00
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627851; cv=none; b=iiWRmKYi5g10rW8zWuXM0RaKFalHPHX+/m/iUJSW2VI8iXSetztafqndPuFlmrJf3MdfFguXlkW8dijF1AlMzj9V/ebQMUWoa3igHTGvd26IUknC53k6fhv//yQtp+JawrmLA1jhyWqeMdkRQ9New5VOhV6Zzdrm0pwCDyrq7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627851; c=relaxed/simple;
	bh=iujBheYzPS2kiDl/x9jHkvTLileZkPYaz+fw9bZi8/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxIyex70GGMSWUeS7un7/+kNfjmVAiC2jw4y/v2SaIzDK5Wxj2AG9jlfRomDcVuRZL05wPJfrrLVvPGELHmbk4p+bd8cR09Xe4xREEe6HQY4kcTCGcBBw20hcMpnKyZm/muevWIJSDsbhcXUMwgpeuo4mgyB3JOKcniL/hqG82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPyR72Wl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627849; x=1740163849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iujBheYzPS2kiDl/x9jHkvTLileZkPYaz+fw9bZi8/k=;
  b=TPyR72Wlm1ztz1MMcTYXAFOV64jE8LQbzyTYyqJ+ZgZDPUbLAeSM1sIW
   XUhBewP1pvoh/nGIeT2udEkW03A5lWhrr+KX4Ak+zKGHd/xOFa7IOtfXO
   rI9zOA4msc7n7E28SHT3i5C5oSeAjJxV8QIZgPTTttX7pb1+WdaB8Py7d
   ZmF49raZTuCBA9Fm9oKDYn+xGRKZdk1CAcNmM+/jNLn41w5vQ4W6M9bX8
   X87zh2TILkuvCNGn5amm7hIsbW39VQ6GFA5M+hzU3ETnTskMBJIiWS47b
   RGYjrjXIAppIAUOAvq4PeZc6NOWajYxdbmdU70SBT2PnJ5maf9TwqKmNE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3020535"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3020535"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:50:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="936889164"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="936889164"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:50:45 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 0/2] x86/resctrl: Pass domain to target CPU
Date: Thu, 22 Feb 2024 10:50:37 -0800
Message-ID: <20240222185039.72201-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZdZPht8hY4J9uIOz@agluck-desk3>
References: <ZdZPht8hY4J9uIOz@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a function is called via IPI, it isn't possible for assertions
in source code to check that the right locks are held when those
locks were obtained by the sender of the IPI.

Restructure some code to avoid the need for the check.

Patch 1 has the actual fix

Patch 2 is just some code cleanups

Changes since V2:

1) Rebased on TIP x86/cache

2) Added a missed setting of msr_param.dom in resctrl_arch_update_one()

3) Dropped the code that used separate msr_param structures for CDP

4) Added lockdep_assert_cpus_held() to get_domain_from_cpu()

5) Split into two patches

Tony Luck (2):
  x86/resctrl: Pass domain to target CPU
  x86/resctrl: Simply call convention for MSR update functions

 arch/x86/kernel/cpu/resctrl/internal.h    |  4 +-
 arch/x86/kernel/cpu/resctrl/core.c        | 55 +++++++++--------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 42 +++++------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 ++----
 4 files changed, 37 insertions(+), 78 deletions(-)


base-commit: c0d848fcb09d80a5f48b99f85e448185125ef59f
-- 
2.43.0


