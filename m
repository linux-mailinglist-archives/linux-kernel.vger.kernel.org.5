Return-Path: <linux-kernel+bounces-151518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA028AB005
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A171C1C22B67
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324BB12DDAB;
	Fri, 19 Apr 2024 14:01:48 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2212A12CDBF;
	Fri, 19 Apr 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535307; cv=none; b=S9hqVd6Jqo6oKg9TEgjIOevQ7J45NtxkyFFg5Nu2KbsQd16se6j7RoyeMUYZ0iamBCWgyTXn+P5ODC/HG9vH8fo1gY4NDlURhAXiiiMHj6GjZAY71r8qcvNfrOSHjz1nhvVWVcxbRflZgJgXbW5BwLAWrTH/m7n6svxe4fknzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535307; c=relaxed/simple;
	bh=rLP5T5mNAZQd4djcmsYzbTopPnuc7PBwVP0b00TuT7k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYxKxhXR+niwPCfBLHbu1RtFqkmlVxhA5Zxp8VDkQWaMeZcQJApF2SwhkM0XeR5zEfkxOs8TRP6sWvs6JZYsm1AE8ZRc2bWWobhtcQeIVMozf+rUOQBLz0BJ+q2PU6Z3EnxjAqT3dRAH6JZ9n6IcPg2My23LZxQ9tg+LmdNEI7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VLbsq4rHjz6K8x1;
	Fri, 19 Apr 2024 22:01:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E2C3E140B2A;
	Fri, 19 Apr 2024 22:01:36 +0800 (CST)
Received: from localhost (10.48.153.65) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 15:01:36 +0100
Date: Fri, 19 Apr 2024 15:01:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
CC: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
	<gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>,
	<tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
	<apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae
 Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, "Dave Jiang" <dave.jiang@intel.com>, Andrew
 Morton <akpm@linux-foundation.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack)
 Chuang" <horenchuang@gmail.com>, <qemu-devel@nongnu.org>, Hao Xiang
	<hao.xiang@bytedance.com>
Subject: Re: [PATCH v11 2/2] memory tier: create CPUless memory tiers after
 obtaining HMAT info
Message-ID: <20240419150134.000032ff@Huawei.com>
In-Reply-To: <20240405000707.2670063-3-horenchuang@bytedance.com>
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
	<20240405000707.2670063-3-horenchuang@bytedance.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri,  5 Apr 2024 00:07:06 +0000
"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:

> The current implementation treats emulated memory devices, such as
> CXL1.1 type3 memory, as normal DRAM when they are emulated as normal memory
> (E820_TYPE_RAM). However, these emulated devices have different
> characteristics than traditional DRAM, making it important to
> distinguish them. Thus, we modify the tiered memory initialization process
> to introduce a delay specifically for CPUless NUMA nodes. This delay
> ensures that the memory tier initialization for these nodes is deferred
> until HMAT information is obtained during the boot process. Finally,
> demotion tables are recalculated at the end.
> 
> * late_initcall(memory_tier_late_init);
> Some device drivers may have initialized memory tiers between
> `memory_tier_init()` and `memory_tier_late_init()`, potentially bringing
> online memory nodes and configuring memory tiers. They should be excluded
> in the late init.
> 
> * Handle cases where there is no HMAT when creating memory tiers
> There is a scenario where a CPUless node does not provide HMAT information.
> If no HMAT is specified, it falls back to using the default DRAM tier.
> 
> * Introduce another new lock `default_dram_perf_lock` for adist calculation
> In the current implementation, iterating through CPUlist nodes requires
> holding the `memory_tier_lock`. However, `mt_calc_adistance()` will end up
> trying to acquire the same lock, leading to a potential deadlock.
> Therefore, we propose introducing a standalone `default_dram_perf_lock` to
> protect `default_dram_perf_*`. This approach not only avoids deadlock
> but also prevents holding a large lock simultaneously.
> 
> * Upgrade `set_node_memory_tier` to support additional cases, including
>   default DRAM, late CPUless, and hot-plugged initializations.
> To cover hot-plugged memory nodes, `mt_calc_adistance()` and
> `mt_find_alloc_memory_type()` are moved into `set_node_memory_tier()` to
> handle cases where memtype is not initialized and where HMAT information is
> available.
> 
> * Introduce `default_memory_types` for those memory types that are not
>   initialized by device drivers.
> Because late initialized memory and default DRAM memory need to be managed,
> a default memory type is created for storing all memory types that are
> not initialized by device drivers and as a fallback.
> 
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

