Return-Path: <linux-kernel+bounces-89986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFB886F8A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8559D28180C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689364416;
	Mon,  4 Mar 2024 02:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIpfIzDI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706F19A;
	Mon,  4 Mar 2024 02:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709520424; cv=none; b=BJ0zTC78eflDLG1b65hvzaYx7uMClZ4jslzmOmCQ1ahVkPSrrep7NhGDHBpklnfEKgDeXlMPnEEsOtzuYnEkg8Z/vE5lCFB44gnlb1sBnmL0/nP7x31Pwjwx1Byx/+fIevRmVT2rxv7uCA6xjTp9USPqoqnzxelkdmIMgoe/ZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709520424; c=relaxed/simple;
	bh=NpJ3kMXPkFPpAOq7sPat1SWaWWApgyHoKsLSe8iwW2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DQENCdUs0Fbkqq2htBkHvTv16vH/hLys5mXAGKWkRZ1FgO7k2sU72/23hYQ7qe0DmQuqcxIo5U52KWNgsih6bn2YWcAbCxolP1lRDWeZTuZOfQwiquBHOOhAmUdt5TbOcCJYALFGiMmw9yPVfIopVY1baDaYG9Ko58x+AIcyQhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIpfIzDI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709520422; x=1741056422;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=NpJ3kMXPkFPpAOq7sPat1SWaWWApgyHoKsLSe8iwW2k=;
  b=cIpfIzDIjO4aT2EM2VBiPpueyfs52PxarZGTZ1qIQuS6uiTvCfkF07ff
   QjnVxySYA4KT3I77gj6wnQVpN1tVAGF2loxiuTmixUyOAsNiWh5exQbfs
   HAxDaqn++Ior+NzWDTqrMaMJMPQFApyXZbdEzYPvjsD2RtqLE8tH5M3Hy
   EiScRi0rh9ltQwAGbQN4GJFRYk4jhbzHOUOZRMPHukwCL64GD0lC7Hl2I
   zZwvgSmrDQ2hcXELuDyaXQHhjCPkuUlQNLkXmsIU8ypNL3vMzTCjgXphc
   zSsVMB26adwAFdLpUZLuE0OkR1qIxB51dS9oPdy76sxb/qKfq33dMBDPG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4115034"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4115034"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 18:47:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="32002826"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 18:46:56 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: "Hao Xiang" <hao.xiang@bytedance.com>,  "Gregory Price"
 <gourry.memverge@gmail.com>,  aneesh.kumar@linux.ibm.com,
  mhocko@suse.com,  tj@kernel.org,  john@jagalactic.com,  "Eishan Mirakhur"
 <emirakhur@micron.com>,  "Vinicius Tavares Petrucci"
 <vtavarespetr@micron.com>,  "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
  "Alistair Popple" <apopple@nvidia.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Len Brown <lenb@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Dave Jiang <dave.jiang@intel.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-acpi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  "Ho-Ren (Jack)
 Chuang" <horenc@vt.edu>,  "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
  linux-cxl@vger.kernel.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v1 0/1] Improved Memory Tier Creation for CPUless NUMA
 Nodes
In-Reply-To: <20240301082248.3456086-1-horenchuang@bytedance.com> (Ho-Ren
	Chuang's message of "Fri, 1 Mar 2024 08:22:44 +0000")
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
Date: Mon, 04 Mar 2024 10:45:02 +0800
Message-ID: <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:

> The memory tiering component in the kernel is functionally useless for
> CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the nodes
> are lumped together in the DRAM tier.
> https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

I think that it's unfair to call it "useless".  Yes, it doesn't work if
the CXL memory device are not enumerate via drivers/dax/kmem.c.  So,
please be specific about in which cases it doesn't work instead of too
general "useless".

> This patchset automatically resolves the issues. It delays the initialization
> of memory tiers for CPUless NUMA nodes until they obtain HMAT information
> at boot time, eliminating the need for user intervention.
> If no HMAT specified, it falls back to using `default_dram_type`.
>
> Example usecase:
> We have CXL memory on the host, and we create VMs with a new system memory
> device backed by host CXL memory. We inject CXL memory performance attributes
> through QEMU, and the guest now sees memory nodes with performance attributes
> in HMAT. With this change, we enable the guest kernel to construct
> the correct memory tiering for the memory nodes.
>
> Ho-Ren (Jack) Chuang (1):
>   memory tier: acpi/hmat: create CPUless memory tiers after obtaining
>     HMAT info
>
>  drivers/acpi/numa/hmat.c     |  3 ++
>  include/linux/memory-tiers.h |  6 +++
>  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
>  3 files changed, 77 insertions(+), 8 deletions(-)

--
Best Regards,
Huang, Ying

