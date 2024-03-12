Return-Path: <linux-kernel+bounces-100281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DDB8794F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AF0282E04
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3290D7A143;
	Tue, 12 Mar 2024 13:18:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCCF78298
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249499; cv=none; b=Igz47ulcb9gTFkrKCjuwOGXOVaGhL+tg8Mc6VIILHPyXScyW35rmiZTFva8pIOMg6gzrn5pgp9JpSPv6jxownOzHMV+C599B9duZUJeHCg41/YqFSB/xTrMB37Yjd2APPc29tLVMLzB1V/gl8rLy0/0yOwVOZ04gmc23gfLIPOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249499; c=relaxed/simple;
	bh=5drlWpMH3WmAowsnVmEKhpqxAho8Tv6BCyVMktLzY68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lu4SnH1fkrHVe3X/Cqhy7JAyxsn9I8E7ar95jB4rvhtpprg9ckq66f1FLSacyeTD3krOu341F51+1IzJfkMSWoO9WqF+7WSEnKfNgePSA0cul2FSKQewqpcTNkgCux7Byg9BG+9bmrMQXANbj26PspxxNCXkpmn9E5HzmT2E+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 808EB1007;
	Tue, 12 Mar 2024 06:18:53 -0700 (PDT)
Received: from [10.57.11.232] (unknown [10.57.11.232])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A13863F762;
	Tue, 12 Mar 2024 06:18:13 -0700 (PDT)
Message-ID: <65f3016c-c060-4d74-ad0f-d1981d1c6eeb@arm.com>
Date: Tue, 12 Mar 2024 14:18:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: simplify __calc_delta()
Content-Language: en-US
To: Dawei Li <daweilics@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240306222838.15087-1-daweilics@gmail.com>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240306222838.15087-1-daweilics@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Dawei,

On 3/6/24 23:28, Dawei Li wrote:
> Based on how __calc_delta() is called now, the input parameter, weight
> is always NICE_0_LOAD. I think we don't need it as an input parameter
> now?

Maybe
   5e963f2bd4654a202a8a05aa3a86cb0300b10e6c ("sched/fair: Commit to EEVDF")
should be referenced to explain that the case where (weight =< lw.weight)
doesn't exist anymore and that NICE_0_LOAD could be incorporated in
__calc_delta() directly.


Also I think indirect forms are preferred in general:
"I think we don't need it as an input parameter now ?" ->
"The 'weight' parameter doesn't seem to be required anymore"
(same note for the whole commit message)

> 
> Also, when weight is always NICE_0_LOAD, the initial fact value is
> always 2^10, and the first fact_hi will always be 0. Thus, we can get
> rid of the first if bock.
> 
> The previous comment "(delta_exec * (weight * lw->inv_weight)) >>
> WMULT_SHIFT" seems to be assuming that lw->weight * lw->inv_weight is
> always (approximately) equal to 2^WMULT_SHIFT. However, when
> CONFIG_64BIT is set, lw->weight * lw->inv_weight is (approximately)
> equal to 2^WMULT_SHIFT * 2^10. What remains true for both CONFIG_32BIT
> and CONFIG_64BIT is: scale_load_down(lw->weight) * lw->inv_weight is
> (approximately) equal to 2^WMULT_SHIFT. (Correct me if I am wrong.)

I think the comment is more about explaining that:
   X * lw.weight
equals:
   X * lw->inv_weight >> WMULT_SHIFT

Also, if CONFIG_64BIT is set, we should have:
   weight / lw.weight == scale_load_down(lw->weight) * 2**10 * lw->inv_weight

So IIUC, either both lines should be update, either none.
(meaning that:
   delta_exec * NICE_0_LOAD / lw->weight
should be changed to
   delta_exec * scale_load_down(NICE_0_LOAD) / lw->weight
)

I assume it's better to let the comment as is.


> 
> Also updated the comment for calc_delta_fair() to make it more
> accurate.
> 
> Signed-off-by: Dawei Li <daweilics@gmail.com>
> ---
>   kernel/sched/fair.c | 29 ++++++++++-------------------
>   1 file changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6a16129f9a5c..c5cdb15f7d62 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -252,32 +252,23 @@ static void __update_inv_weight(struct load_weight *lw)
>   }
>   
>   /*
> - * delta_exec * weight / lw.weight
> + * delta_exec * NICE_0_LOAD / lw->weight
>    *   OR
> - * (delta_exec * (weight * lw->inv_weight)) >> WMULT_SHIFT
> + * (delta_exec * scale_load_down(NICE_0_LOAD) * lw->inv_weight) >> WMULT_SHIFT
>    *
> - * Either weight := NICE_0_LOAD and lw \e sched_prio_to_wmult[], in which case
> - * we're guaranteed shift stays positive because inv_weight is guaranteed to
> - * fit 32 bits, and NICE_0_LOAD gives another 10 bits; therefore shift >= 22.
> - *
> - * Or, weight =< lw.weight (because lw.weight is the runqueue weight), thus
> - * weight/lw.weight <= 1, and therefore our shift will also be positive.
> + * We're guaranteed shift stays positive because inv_weight is guaranteed to
> + * fit 32 bits, and scale_load_down(NICE_0_LOAD) gives another 10 bits;
> + * therefore shift >= 22.
>    */
> -static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight *lw)
> +static u64 __calc_delta(u64 delta_exec, struct load_weight *lw)
>   {
> -	u64 fact = scale_load_down(weight);
> -	u32 fact_hi = (u32)(fact >> 32);
> +	u64 fact = scale_load_down(NICE_0_LOAD);
> +	int fact_hi;
>   	int shift = WMULT_SHIFT;
>   	int fs;

NIT: maybe re-ordering the variables to have a reverse tree

Otherwise, the patch looks good to me,
Regards,
Pierre

