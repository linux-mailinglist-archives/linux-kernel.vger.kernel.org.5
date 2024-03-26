Return-Path: <linux-kernel+bounces-119608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 928DE88CB07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60BB1C66383
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A21C823B8;
	Tue, 26 Mar 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="as1CqDb6"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74AA95B;
	Tue, 26 Mar 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474463; cv=none; b=lWpCSe7OSh2RPPTbaG/eTOpRVqNEk9ozQbB4nu9vy3RBoPCKbMCL0sGKm+S8aaU6jjR69pEHG/SwFswPpsahvBs6Yt1mgqW+AmBY/dGHPAj0/AyKMDlVj0BiwcvFFjRXxIov06lsP1hk5j2CU+lvftwCJo2L2lJdrbN9f51pqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474463; c=relaxed/simple;
	bh=UXsCAMGzzqmMpp+L9Y666l1qQYPfIhBVeL6t3mMnmlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nOm2US6NOp8SdmU9zhPajjuFRavLlsOSkP2ChjO4HIFUXGvUZlkOBv4Ianhs7mQ7Prf4i/U4ib+ruF3j/MjMdevvgoNJHzWDC8QhBcgk9Eg8VosfZOgpROZQ3LxZZfSvGinEXcMoQ4OiR9jpwN+fBR5nsvJWofsnnpkdL+cW06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=as1CqDb6; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QHYAJn018910;
	Tue, 26 Mar 2024 12:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711474450;
	bh=3MphZr6wwO8mEMosfjMGG0/PCepj2Gm6s51vuwEuvw4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=as1CqDb68Nhz/Q2s1sCcgJ+mMtQu0uJmhbPxwnhlm6hPWZXWdsqP8iPq8JUXx3NwA
	 qsK69qA5qxzJjXzMppRgF06Pyf2o2ikyXmtHN6FudrzTWQKZTgNQrAbyl4sSk2m9OC
	 MUi8+WOgiESFfTaYY1AjXJeVV+G43JtNHIM877bU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QHYAEs022524
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 12:34:10 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 12:34:10 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 12:34:10 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QHY95E011505;
	Tue, 26 Mar 2024 12:34:09 -0500
Message-ID: <f3fab698-fb1c-4ba0-ab5e-0c616830e22c@ti.com>
Date: Tue, 26 Mar 2024 12:34:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uio: pruss: Deprecate use of this driver
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Robert Nelson <robertcnelson@gmail.com>,
        Jason Kridner
	<jkridner@beagleboard.org>,
        Matthijs van Duin <matthijsvanduin@gmail.com>,
        Drew Fustini <drew@beagleboard.org>, Tony Lindgren <tony@atomide.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240325210045.153827-1-afd@ti.com>
 <2024032631-excursion-opposing-be36@gregkh>
 <CAOCHtYjauA+BAxZJBMTaxxaMGcvipP9=ZPeWe4FiNFs_jpq6dg@mail.gmail.com>
 <c2125144-659e-42f2-af1f-ffef7ec3d157@ti.com>
 <2024032658-chosen-salaried-4702@gregkh>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <2024032658-chosen-salaried-4702@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 3/26/24 12:12 PM, Greg Kroah-Hartman wrote:
> On Tue, Mar 26, 2024 at 12:02:09PM -0500, Andrew Davis wrote:
>> On 3/26/24 11:19 AM, Robert Nelson wrote:
>>> On Tue, Mar 26, 2024 at 12:41 AM Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Mon, Mar 25, 2024 at 04:00:45PM -0500, Andrew Davis wrote:
>>>>> This UIO driver was used to control the PRU processors found on various
>>>>> TI SoCs. It was created before the Remoteproc framework, but now with
>>>>> that we have a standard way to program and manage the PRU processors.
>>>>> The proper PRU Remoteproc driver should be used instead of this driver.
>>>>> Mark this driver deprecated.
>>>>>
>>>>> The userspace tools to use this are no longer available, so also remove
>>>>> those dead links from the Kconfig description.
>>>>>
>>>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>>>> ---
>>>>>    drivers/uio/Kconfig | 10 ++--------
>>>>>    1 file changed, 2 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
>>>>> index 2e16c5338e5b1..358dc2d19b885 100644
>>>>> --- a/drivers/uio/Kconfig
>>>>> +++ b/drivers/uio/Kconfig
>>>>> @@ -126,19 +126,13 @@ config UIO_FSL_ELBC_GPCM_NETX5152
>>>>>           http://www.hilscher.com/netx
>>>>>
>>>>>    config UIO_PRUSS
>>>>> -     tristate "Texas Instruments PRUSS driver"
>>>>> +     tristate "Texas Instruments PRUSS driver (DEPRECATED)"
>>>>
>>>> This isn't going to do much, why not just delete the driver entirely if
>>>> no one uses it?
>>>
>>> CC'ing Matthijs one of our BeagleBoard community members who utilizes
>>> and supports UIO on a number of community projects.
>>>
>>> We know TI and Mainline in general do not like this UIO driver as it's
>>> very open-ended.
>>>
>>> While the remoteproc_pruss driver is now mainline (it has taken a long
>>> time, since 3.14.x i I think TI first started this..)
>>>
>>> There is a large user base of UIO examples that have been running
>>> since 3.8.x and as a community we have made sure ( mostly Matthijs )
>>> that these continue to operate on this driver in
>>> v5.x/v6.x/lts/mainline branches.
>>>
>>
>> These users rely on out-of-tree patches to make this driver usable[0].
>> In its current state upstream, this driver is not used/usable. Since you
>> have to make update patches anyway, why not simply carry the whole driver
>> as an out-of-tree patch?
>>
>> That is why I was thinking of just marking it deprecated for a cycle
>> or two, just to give one last hint that it will be going away soon
>> (or you cancarry the driver out-of-tree for however long you want).
> 
> No one notices "deprecated" stuff, they only notice if the code is
> removed.  So removing it is the only way to pay attention.
> 

Easy enough, will remove completely for v2.

> But why are out-of-tree changes needed?  If they are needed, why are
> they not submitted for us to take so that it is usable by everyone?  Or
> is the out-of-tree patches also not supposed to be used?
> 

The out-of-tree patches should not be used and are only for backwards
compatibility with folks who have not updated to using the proper
remoteproc/rpmsg driver for PRU. Removing this driver would normally
be a userspace break (which we should obviously avoid), but since
the ability to actually use this driver never made it fully upstream
I see no issue.

And we shouldn't try to now upstream the full usable support for this
UIO driver at this point as we have a proper kernel driver for this hardware
upstream now.

(I'd argue most of UIO should not be used as it ends up just being a
hacky way to avoid writing proper kernel drivers for hardware, but that
is a different topic :))

Andrew

> thanks,
> 
> greg k-h

