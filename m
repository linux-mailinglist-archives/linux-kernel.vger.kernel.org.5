Return-Path: <linux-kernel+bounces-27056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA5482E9CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47ABB1F2403C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B2110A25;
	Tue, 16 Jan 2024 07:10:34 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47310A12
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TDgB01k7TzNl59;
	Tue, 16 Jan 2024 15:09:44 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E00F1800A9;
	Tue, 16 Jan 2024 15:10:28 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 15:10:27 +0800
Message-ID: <f84f3e60-e71a-4ea4-8c9c-86fd915129a9@huawei.com>
Date: Tue, 16 Jan 2024 15:10:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, "Christoph Lameter
 (Ampere)" <cl@linux.com>
CC: Anshuman Khandual <anshuman.khandual@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <Valentin.Schneider@arm.com>, Vanshidhar Konda
	<vanshikonda@os.amperecomputing.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Robin Murphy <robin.murphy@arm.com>, Dave Kleikamp
	<dave.kleikamp@oracle.com>, Matteo Carlini <Matteo.Carlini@arm.com>,
	<akpm@linux-foundation.org>, <yang@os.amperecomputing.com>
References: <794a1211-630b-3ee5-55a3-c06f10df1490@linux.com>
 <ZaVRlHpAOoNIiRiY@shell.armlinux.org.uk>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZaVRlHpAOoNIiRiY@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/1/15 23:39, Russell King (Oracle) wrote:
> On Thu, Dec 14, 2023 at 04:05:56PM -0800, Christoph Lameter (Ampere) wrote:
>> Index: linux/arch/arm64/Kconfig
>> ===================================================================
>> --- linux.orig/arch/arm64/Kconfig
>> +++ linux/arch/arm64/Kconfig
>> @@ -1407,7 +1407,21 @@ config SCHED_SMT
>>    config NR_CPUS
>>    	int "Maximum number of CPUs (2-4096)"
>>    	range 2 4096
> 
> I think your mailer got to your patch and messed up the white space.
> There are two spaces before each of these lines rather than the usual
> one.
> 
>> -	default "256"
>> +	default 512
>> +
>> +#
>> +# Determines the placement of cpumasks.
>> +#
>> +# With CPUMASK_OFFSTACK the cpumasks are dynamically allocated.
>> +# Useful for machines with lots of core because it avoids increasing
>> +# the size of many of the data structures in the kernel.
>> +#
>> +# If this is off then the cpumasks have a static sizes and are
>> +# embedded within data structures.
>> +#
>> +config CPUMASK_OFFSTACK
>> +	def_bool y
>> +	depends on NR_CPUS > 256
> 
> Should that be ">= 256" ?

Maybe just select CPUMASK_OFFSTACK if NR_CPUS >= 256,


But could we just make CPUMASK_OFFSTACK configurable and let user/distro
to enable it?

diff --git a/lib/Kconfig b/lib/Kconfig
index 5ddda7c2ed9b..4254be5aa843 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -535,7 +535,9 @@ config CHECK_SIGNATURE
         bool

  config CPUMASK_OFFSTACK
-       bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
+       bool "Force CPU masks off stack"
+       depends on SMP
+       default n
         help
           Use dynamic allocation for cpumask_var_t, instead of putting
           them on the stack.  This is a bit more expensive, but avoids


> 
>>
>>    config HOTPLUG_CPU
>>    	bool "Support for hot-pluggable CPUs"
> 
> Same here.
> 

