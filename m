Return-Path: <linux-kernel+bounces-55056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0C984B6FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5A31F226E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26DA131750;
	Tue,  6 Feb 2024 13:54:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9641DFFB;
	Tue,  6 Feb 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227645; cv=none; b=n2h3XKMAoncnlM04S4IVb8fxNG0wJxR+qtDynWkQvM93Me3M/JHR6FIgykfRws9bXqIb6C1Mxb60oqnhtVvNMs2+xwbq+uNN8XXO59U9PBP2HnInXHFDmlap/MUsAqz6GK//mTU3S/2MMoN5H/dG/m7obZifzxspFv4PVl7PNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227645; c=relaxed/simple;
	bh=aC1HqlDGZwP1joKTg4zznkz3N2cOWB0Vf6YwVnu/epM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/2PZZBzV10iBGt4+dE8x/QUDjrrpLiBySi0oUEf5EN32mZYisc1xf7dgOY+UcOMGeJYt7Ta5I0kV0LnGfNUEa0t1tZBsGUB2/rzZeD4W7gLLmFa+rjcFr1OYrijtdMRVu/EqUx8okkuqgo9ZblmFiw2I/gfPpA9tweBq8IYmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFEDE1FB;
	Tue,  6 Feb 2024 05:54:44 -0800 (PST)
Received: from [10.57.8.150] (unknown [10.57.8.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B419D3F5A1;
	Tue,  6 Feb 2024 05:53:59 -0800 (PST)
Message-ID: <e18cda72-24a2-4578-affa-f19397a970f9@arm.com>
Date: Tue, 6 Feb 2024 13:54:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/23] Introduce runtime modifiable Energy Model
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
 <c6aa3166-ad82-4576-8d77-19232d477c73@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <c6aa3166-ad82-4576-8d77-19232d477c73@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dietmar,

On 1/29/24 18:16, Dietmar Eggemann wrote:
> On 17/01/2024 10:56, Lukasz Luba wrote:
> 
> [...]
> 
>> Changelog:
>> v7:
>> - dropped em_table_get/put() (Rafael)
>> - renamed memory function to em_table_alloc/free() (Rafael)
>> - use explicit rcu_read_lock/unlock() instead of wrappers and aligned
>>    frameworks & drivers using EM (Rafael)
>> - adjusted documentation to the new functions
>> - fixed doxygen comments (Rafael)
>> - renamed 'refcount' to 'kref' (Rafael)
>> - changed patch headers according to comments (Rafael)
>> - rebased on 'next-20240112' to get Ingo's revert affecting energy_model.h
>> v6 [6]:
>> - renamed 'runtime_table' to 'em_table' (Dietmar, Rafael)
>> - dropped kref increment during allocation (Qais)
>> - renamed em_inc/dec_usage() to em_table_inc/dec() (Qais)
>> - fixed comment description and left old comment block with small
>>    adjustment in em_cpu_energy() patch 15/23 (Dietmar)
>> - added platform name which was used for speed-up testing (Dietmar)
>> - changed patch header description keep it small not repeating the in-code
>>    comment describing 'cost' in em_cpu_energy() patch 15/23 (Dietmar)
>> - added check and warning in em_cpu_energy() about RCU lock held (Qais, Xuewen)
>> - changed nr_perf_states usage in the patch 7/23 (Dietmar)
>> - changed documentation according to comments (Dietmar)
>> - changed in-code comment in patch 11/23 according to comments (Dietmar)
>> - changed example driver function 'ctx' argument in the documentation (Xuewen)
>> - changed the example driver in documentation, dropped module_exit and
>>    added em_free_table() explicit in the update function
>> - fixed comments in various patch headers (Dietmar)
>> - fixed Doxygen comment s/@state/@table patch 4/23 (Dietmar)
>> - added information in the cover letter about:
>> -- optimization in EAS hot code path
>> -- follow-up patch set which adds OPP support and modifies EM for Exynos5
>> - rebased on 'next-20240104' to avoid collision with other code touching
>>    em_cpu_energy()
> 
> LGTM now. I see that my comments from v5 have been addressed. Minor
> points which still exists for me I commented on in the individual patches.
> 
> For the whole series:
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> (with a simple test driver updating the EM for CPU0 on Arm64 Juno-r0)

Thank you for the review and testing!

I'll probably have to re-base the v7 on top of some current PM
branch.

Regards,
Lukasz

