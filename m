Return-Path: <linux-kernel+bounces-101334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721E287A5B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E091F22354
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AFC39AE1;
	Wed, 13 Mar 2024 10:21:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B3639AC3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325295; cv=none; b=k9xDqP6waCAD5CZmudbnHRstr2BcxTjfJA3uK+q7dmLqKGd+F/0bv3hw6LfV5wqH72j8oyAl5szVCumJkNoOPp9UXrO/EIUusEwa0nfvnrbUfD6RbMJhgkZNJkvg4+jZGPRFkUxSRkL8RMKZcy+pE230p9pv0FqQfAxBYJVCwVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325295; c=relaxed/simple;
	bh=u0wMlhDdHQARQ3rxd3v4bTfOTgyML4VigICP7Q9IYLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdGRcKCBKF/eVUcFZcFG55K+jQRoV1+k94KNivarzUoa15jgnvtnYcFO0Q+lg4IrAVl9VDVscs+JXUgA4RQzASQl3k/QeeF9iUsb/0CJWz1caVPH4KPnG8jHUeremOFMU32fXwt3FnPZ3t1ykOfpLgQAZGHSVaBt6V4CdjTqnto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96CAF1007;
	Wed, 13 Mar 2024 03:22:09 -0700 (PDT)
Received: from [10.34.100.133] (e126645.nice.arm.com [10.34.100.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC1243F73F;
	Wed, 13 Mar 2024 03:21:30 -0700 (PDT)
Message-ID: <baac77f6-2fd4-4683-a3b8-4bd68fee1ecf@arm.com>
Date: Wed, 13 Mar 2024 11:21:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: simplify __calc_delta()
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
 <65f3016c-c060-4d74-ad0f-d1981d1c6eeb@arm.com>
 <CAG5MgCpW3xwSGgF6VBPiSMkwOz793NO4_nLNhJeqyBhs+jN30w@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAG5MgCpW3xwSGgF6VBPiSMkwOz793NO4_nLNhJeqyBhs+jN30w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Dawei,

On 3/13/24 00:25, Dawei Li wrote:
> Hi Pierre,
> Thank you for the review!
> 
> On Tue, Mar 12, 2024 at 6:18 AM Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> Hello Dawei,
>>
>> On 3/6/24 23:28, Dawei Li wrote:
>>> Based on how __calc_delta() is called now, the input parameter, weight
>>> is always NICE_0_LOAD. I think we don't need it as an input parameter
>>> now?
>>
>> Maybe
>>     5e963f2bd4654a202a8a05aa3a86cb0300b10e6c ("sched/fair: Commit to EEVDF")
>> should be referenced to explain that the case where (weight =< lw.weight)
>> doesn't exist anymore and that NICE_0_LOAD could be incorporated in
>> __calc_delta() directly.
>>
>>
>> Also I think indirect forms are preferred in general:
>> "I think we don't need it as an input parameter now ?" ->
>> "The 'weight' parameter doesn't seem to be required anymore"
>> (same note for the whole commit message)
>>
>>>
>>> Also, when weight is always NICE_0_LOAD, the initial fact value is
>>> always 2^10, and the first fact_hi will always be 0. Thus, we can get
>>> rid of the first if bock.
>>>
>>> The previous comment "(delta_exec * (weight * lw->inv_weight)) >>
>>> WMULT_SHIFT" seems to be assuming that lw->weight * lw->inv_weight is
>>> always (approximately) equal to 2^WMULT_SHIFT. However, when
>>> CONFIG_64BIT is set, lw->weight * lw->inv_weight is (approximately)
>>> equal to 2^WMULT_SHIFT * 2^10. What remains true for both CONFIG_32BIT
>>> and CONFIG_64BIT is: scale_load_down(lw->weight) * lw->inv_weight is
>>> (approximately) equal to 2^WMULT_SHIFT. (Correct me if I am wrong.)
>>
>> I think the comment is more about explaining that:
>>     X * lw.weight
>> equals:
>>     X * lw->inv_weight >> WMULT_SHIFT
>>
> I assume you mean
> X / lw->weight
> equals:
> X * lw->inv_weight >> WMULT_SHIFT

Yes right indeed.

> However, this is not always true, and that's why I'd like to revise
> it. It is true for
> CONFIG_32BIT. However, For CONFIG_64BIT, we have lw->weight * lw->inv_weight =
> 2**WMULT_SHIFT * 2**10. Thus,
> X / lw->weight
> equals:
> X * lw->inv_weight >> (WMULT_SHIFT + 10)

Ok yes, you're correct indeed.
The equality is always correct when scale_load_down() is used,

Regards,
Pierre

> 
> 
>> Also, if CONFIG_64BIT is set, we should have:
>>     weight / lw.weight == scale_load_down(lw->weight) * 2**10 * lw->inv_weight
>>
> 
> weight / lw->weight should be equal to scale_load_down(weight) /
> scale_load_down(lw->weight)
> = scale_load_down(weight) * lw->inv_weight / (2**WMULT_SHIFT)
> Right?
> 
>> So IIUC, either both lines should be update, either none.
>> (meaning that:
>>     delta_exec * NICE_0_LOAD / lw->weight
>> should be changed to
>>     delta_exec * scale_load_down(NICE_0_LOAD) / lw->weight
> 
> I think this is not correct? scale_load_down(NICE_0_LOAD) is the true
> weight, as mapped
> directly from the task's nice/priority value, while lw->weight is the
> scaled_up load.
> Their units/scales don't match.
> 

