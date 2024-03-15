Return-Path: <linux-kernel+bounces-104760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3529187D32C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6AE1F242E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696534CB3D;
	Fri, 15 Mar 2024 18:00:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF63BB28
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710525626; cv=none; b=g3pBkGBnLeemk4XYyM0ij6nPE8JQKM8ormnH4gzSeyZiBC2kEChauDVkBsPZ3lQ6fFqrNUcHEwNOqiSAq53CPE0sHUAeyRC95DlLlbDJbTJD3d23uEH8BvdvjmRr9dmHJueQD02D+Nl5z9aTiTe46MSsnEhAOU2qjsGMcNmak3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710525626; c=relaxed/simple;
	bh=cLd6t3Gr2U1sNEKiEYEZmeJRQTG1Jc2E5Ir5P7jwBcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOOXg7DfUvV/BQl6QUCR88dcnPqbrp/cTg9payUfl1tu2650b26cyxDoQlNaArGKffYFvEtHVLCnJKz/TsZWUf2Ia4RiduX/qVCcfXeuv0F39MpmbxSwm/L3zDWYHAWJzdgkNQd6gDW3Y0hLrU2mcri8zXippr6tBN/pEAX4wyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A2EDC15;
	Fri, 15 Mar 2024 11:00:56 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 383403F762;
	Fri, 15 Mar 2024 11:00:19 -0700 (PDT)
Message-ID: <93b85205-add3-477f-aa8b-e647447d249b@arm.com>
Date: Fri, 15 Mar 2024 18:00:17 +0000
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
To: Peter Newman <peternewman@google.com>, babu.moger@amd.com
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Rex Nie <rex.nie@jaguarmicro.com>, "x86@kernel.org" <x86@kernel.org>,
 "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 fenghua.yu@intel.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org
References: <20240312075349.977-1-rex.nie@jaguarmicro.com>
 <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com>
 <162f5113-4eb6-dcea-f034-c81b9dc021b6@amd.com>
 <CALPaoCjorOe8FVOu6_sMrG_8jAgSNNsw8=KDwOrwtftovGiRXQ@mail.gmail.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCjorOe8FVOu6_sMrG_8jAgSNNsw8=KDwOrwtftovGiRXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi guys,

On 15/03/2024 16:56, Peter Newman wrote:
> On Fri, Mar 15, 2024 at 9:17 AM Moger, Babu <bmoger@amd.com> wrote:
>> On 3/14/2024 10:25 AM, Reinette Chatre wrote:
>>> +x86 maintainers, Tony, Babu, Peter
>>>
>>> Hi Everybody,
>>>
>>> On 3/12/2024 12:53 AM, Rex Nie wrote:
>>>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>>>> index 7a6f46b4edd0..096317610949 100644
>>>> --- a/fs/resctrl/internal.h
>>>> +++ b/fs/resctrl/internal.h
>>>> @@ -94,7 +94,7 @@ union mon_data_bits {
>>>>      struct {
>>>>              unsigned int rid                : 10;
>>>>              enum resctrl_event_id evtid     : 8;
>>>> -            unsigned int domid              : 14;
>>>> +            u32                             domid;
>>>>      } u;
>>>>   };
>>>>
>>> resctrl currently supports 32bit builds. Fixing this issue* in this way
>>
>> I have never bothered about 32bit builds.   Is Intel still testing 32bit
>> builds?
> 
> I can confirm we don't have any 32-bit builds.
> 
> 
>> The structure pointer "union mon_data_bits priv;" is created in stack
>> and passed to create mondata directory. We are reading it later again in
>> rdtgroup_mondata_show.
>>
>> How is this pointer valid again?  Shouldn't we use static pointer or
>> allocate memory for the pointer?
> 
> The union is copied by value into the pointer-sized field, hence the
> need for pointers to be large enough to hold this value.

Couldn't we allocate the memory for a structure to hold the values we want, then use the
pointer as a pointer?

I suspect whether 32bit builds are important depends on if anyone is using it, which we
can't really know. Debian has 32bit builds, and while its unlikely anyone runs that on a
server part, whatever an "Intel Celeron J3455" is supports RDT too. I'd be keen not to
break it!


As for these eye-sore-ids ... I'm in two minds as to whether we should clean them up in
the kernel. It would be fairly straightforward to scan the PPTT to find them all and map
them to 0,1,2,. But this loses the values provided by the vendor.
x86 and arm64:device-tree systems generate them, so its not clear that user-space needs a
value provided by the vendor here.


Thanks,

James

