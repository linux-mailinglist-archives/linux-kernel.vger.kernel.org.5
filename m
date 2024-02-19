Return-Path: <linux-kernel+bounces-71035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C44859FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE5B1F222F6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ABD24A18;
	Mon, 19 Feb 2024 09:34:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A01249E0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335274; cv=none; b=UXUaUBG2VThNN9rabXQ4Qg0RPfK8kSKMxxmrIRYhJgKChddNybQovpujBQy0sPlGwcB8rxx/ZTzH8SljMEaliACSVtjJdJ5vnnAF4qyS04/EHQ7wPfXvnDkq0Op7/1F2tPP3LBUPw8gkP4RyIkkaSnL345CyqODPrbqE9SlJuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335274; c=relaxed/simple;
	bh=5Gj/zQQstpYPMZ8eAAuIktQ7FbQhFfd2I8eISMdZ1no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzVobLpSTEMu/dujOZqTMJ9k7Z6Z+5W4izsyGVLQBogl/Nu0A/QUgZGtyUAAbPBq7+Sl1WlkQJ8xpm2B8OzPTLHHcWUCJOJSBrAGdJZZKN+kvLKsIy1zrnbK1zR1KxSV//k8pAXjfldolWTfYbamHo0uO19wbQUwt81ZetQS8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51540FEC;
	Mon, 19 Feb 2024 01:35:05 -0800 (PST)
Received: from [10.162.43.127] (a077893.blr.arm.com [10.162.43.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1574B3F762;
	Mon, 19 Feb 2024 01:34:23 -0800 (PST)
Message-ID: <e88f67fc-cd13-4344-9b3e-64e42a3c6adc@arm.com>
Date: Mon, 19 Feb 2024 15:04:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/hugetlb: Ensure adequate CMA areas available for
 hugetlb_cma[]
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
 linux-kernel@vger.kernel.org
References: <20240215043405.2379295-1-anshuman.khandual@arm.com>
 <20240215172233.06e9515adf7de9c58d1b5d91@linux-foundation.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240215172233.06e9515adf7de9c58d1b5d91@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/16/24 06:52, Andrew Morton wrote:
> On Thu, 15 Feb 2024 10:04:05 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> HugeTLB CMA area array is being created for possible MAX_NUMNODES without
>> ensuring corresponding MAX_CMA_AREAS support in CMA. This fails the build
>> for such scenarios indicating need for CONFIG_CMA_AREAS adjustment.
>>
>> ...
>>
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -7743,6 +7743,13 @@ void __init hugetlb_cma_reserve(int order)
>>  	}
>>  
>>  	reserved = 0;
>> +
>> +	/*
>> +	 * There needs to be enough MAX_CMA_AREAS to accommodate
>> +	 * MAX_NUMNODES heap areas being created here. Otherwise
>> +	 * adjust CONFIG_CMA_AREAS as required.
>> +	 */
>> +	BUILD_BUG_ON(MAX_CMA_AREAS < MAX_NUMNODES);
>>  	for_each_online_node(nid) {
>>  		int res;
> 
> This blew up my x86_64 allmodconfig build.  I didn't check whether this
> is because x86_64 kconfig is broken or because the test is bogus.
> 
> I won't be releasing a kernel which fails x86_64 allmodconfig.

Okay, understood.

> 
> So before adding a new assertion can we please first make a best effort
> to implement the fixes which are required to prevent the new assertion
> from triggering?

Even after applying the previous patch regarding MAX_CMA_AREAS (below),
the build still fails on "x86_64 allmodconfig".

https://lore.kernel.org/all/20240205051929.298559-1-anshuman.khandual@arm.com/

As defined in arch/x86/Kconfig

config NODES_SHIFT
        int "Maximum NUMA Nodes (as a power of 2)" if !MAXSMP
        range 1 10
        default "10" if MAXSMP
        default "6" if X86_64
        default "3"
        depends on NUMA
        help
          Specify the maximum number of NUMA Nodes available on the target
          system.  Increases memory reserved to accommodate various tables.

So with MAXSMP enabled, NODES_SHIFT = 10 and MAX_NUMNODES = 1024 (1 << 10).
Incrementing CONFIG_CMA_AREAS appropriately solves the current problem i.e
CONFIG_CMA_AREAS = 1024 causes the build to pass.

config CMA_AREAS
        int "Maximum count of the CMA areas"
        depends on CMA
        default 20 if NUMA
        default 8
        help
          CMA allows to create CMA areas for particular purpose, mainly,
          used as device private area. This parameter sets the maximum
          number of CMA area in the system.

          If unsure, leave the default value "8" in UMA and "20" in NUMA.

Current default for CMA_AREAS is just 20 with NUMA enabled, hence wondering
should CMA_AREAS be defaulted to 1024 but that does not seem feasible for
smaller systems or find some x86 specific solutions. Please let me know if
there are any suggestions.

