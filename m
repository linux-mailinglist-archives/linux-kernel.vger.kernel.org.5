Return-Path: <linux-kernel+bounces-106516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD7287EFB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293751C222D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8296B55E7F;
	Mon, 18 Mar 2024 18:28:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6078E55E50
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710786480; cv=none; b=NiY3eoYkDRzAFgdYCd5cQiJcBOhATY4wPKWFgF0c0p3OcB2hndaM10nzQf5S3oLd2a+DOjycQArGh452zrbLXADOdk2+zIAb0GCkWorS3KbdtfDZyGhN3LSul3vCn6aH3faMWiDhFn8cOhBGV4rJPWHhqsnUSJn8luUbfbv3U2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710786480; c=relaxed/simple;
	bh=2StcBdZDAcIccg5ljoMkjIGl8GqyxcQmGScMSH2B3H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNn7ozU1u78cOfEKcfNaZDVi0z4FvTzpDjC32DNd00IRyyJeDkuTshs9CSuh6f1etKvFYVWxf7P7CrTcyYmP52Wgi7eHUzNxepgZnvnDOvIh8mR92hd53RdPuhDGGvNA70UMHjZcqiwg/qbWwkveDBvwPHtmAZHu0/W7G2CHfTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A0FD1FB;
	Mon, 18 Mar 2024 11:28:31 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D47403F67D;
	Mon, 18 Mar 2024 11:27:54 -0700 (PDT)
Message-ID: <2902ac26-ef42-4c2d-81a1-53d66d6e031b@arm.com>
Date: Mon, 18 Mar 2024 18:27:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 32bit resctrl? (was Re: [PATCH v2] fs/resctrl: fix domid loss
 precision issue)
Content-Language: en-GB
To: Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>, babu.moger@amd.com
Cc: Rex Nie <rex.nie@jaguarmicro.com>, "x86@kernel.org" <x86@kernel.org>,
 "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 fenghua.yu@intel.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org
References: <20240312075349.977-1-rex.nie@jaguarmicro.com>
 <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com>
 <162f5113-4eb6-dcea-f034-c81b9dc021b6@amd.com>
 <CALPaoCjorOe8FVOu6_sMrG_8jAgSNNsw8=KDwOrwtftovGiRXQ@mail.gmail.com>
 <93b85205-add3-477f-aa8b-e647447d249b@arm.com>
 <010c9d64-4776-4b78-b21d-8e28a93c409b@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <010c9d64-4776-4b78-b21d-8e28a93c409b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 15/03/2024 22:42, Reinette Chatre wrote:
> On 3/15/2024 11:00 AM, James Morse wrote:
>> On 15/03/2024 16:56, Peter Newman wrote:
>>> On Fri, Mar 15, 2024 at 9:17 AM Moger, Babu <bmoger@amd.com> wrote:
>>>> On 3/14/2024 10:25 AM, Reinette Chatre wrote:
>>>>> On 3/12/2024 12:53 AM, Rex Nie wrote:
>>>>>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>>>>>> index 7a6f46b4edd0..096317610949 100644
>>>>>> --- a/fs/resctrl/internal.h
>>>>>> +++ b/fs/resctrl/internal.h
>>>>>> @@ -94,7 +94,7 @@ union mon_data_bits {
>>>>>>      struct {
>>>>>>              unsigned int rid                : 10;
>>>>>>              enum resctrl_event_id evtid     : 8;
>>>>>> -            unsigned int domid              : 14;
>>>>>> +            u32                             domid;
>>>>>>      } u;
>>>>>>   };
>>>>>>
>>>>> resctrl currently supports 32bit builds. Fixing this issue* in this way
>>>>
>>>> I have never bothered about 32bit builds.   Is Intel still testing 32bit
>>>> builds?
>>>
>>> I can confirm we don't have any 32-bit builds.
>>>
>>>
>>>> The structure pointer "union mon_data_bits priv;" is created in stack
>>>> and passed to create mondata directory. We are reading it later again in
>>>> rdtgroup_mondata_show.
>>>>
>>>> How is this pointer valid again?  Shouldn't we use static pointer or
>>>> allocate memory for the pointer?
>>>
>>> The union is copied by value into the pointer-sized field, hence the
>>> need for pointers to be large enough to hold this value.
>>
>> Couldn't we allocate the memory for a structure to hold the values we want, then use the
>> pointer as a pointer?
> 
> Yes, there are a couple of different ways to solve this that remains friendly
> to 32-bit. My goal with this thread was to gauge the sentiment surrounding
> continuing support for 32-bit resctrl.
> 
>> I suspect whether 32bit builds are important depends on if anyone is using it, which we
>> can't really know. Debian has 32bit builds, and while its unlikely anyone runs that on a
>> server part, whatever an "Intel Celeron J3455" is supports RDT too. I'd be keen not to
>> break it!
> 
> You are right. We can't really know. My question did not yet receive a request to
> keep 32-bit support so this will remain uncertain but I am starting to get a sense that
> folks may not be using these builds. I do not think that the issue that Rex reported 
> warrants such a direction change so I am ok to delay considering moving to 64-bit only
> and try to keep 32-bit in mind in future work. I have not been testing 32-bit builds though.
> 
> (btw ... "Intel Celeron J3455" details can be seen at [1]. It is a great (64-bit)
> platform that I worked with for a while and it supports cache pseudo-locking well.)
> 
>> As for these eye-sore-ids ... I'm in two minds as to whether we should clean them up in
>> the kernel. It would be fairly straightforward to scan the PPTT to find them all and map
>> them to 0,1,2,. But this loses the values provided by the vendor.
>> x86 and arm64:device-tree systems generate them, so its not clear that user-space needs a
>> value provided by the vendor here.


> Another alternative: if I counted right it seems that Arm would need 24bits for these
> IDs? That still leaves 8 bits for the resource ID (current max 4) and event ID (current max 3).
> How many resources and events are on the horizon for Arm?

No where near that many! - but its impossible for me to know. MPAM is a bag of bits, its
up to Arm's partners what they build with it. MPAM does have 8 bit counter id,s but there
are only two defined so far. The other fields depend on what people build.

The problem here is the folk who generate the ACPI tables have seen a 32bit field, and
generated a value based on the topology so they know its always unique - instead of taking
a description of the two or three caches that need an ID.

I'll have a go at compressing them into a smaller range in the kernel. As no other
platform preserves a hardware ID here, I don't think its a major loss to re-create these.
It's certainly going to be less ugly to user-space!


Thanks,

James

