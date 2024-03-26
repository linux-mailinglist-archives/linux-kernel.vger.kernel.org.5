Return-Path: <linux-kernel+bounces-119536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED8F88CA22
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634E3322DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BB213D62A;
	Tue, 26 Mar 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J8H+ZXQc"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A113D500;
	Tue, 26 Mar 2024 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472548; cv=none; b=rA71WdDTsuCQ/ls+jNkkzwLiG6K/2itYPEdrXo2x9pmccpOqyXoOQnbpt8VnV4YoSiO9GGwIjt4mN06QHS/36KylM3TTq8QkJvG3gDKmywnJcyNgDcnwcXjFtWRVk2KBk1iehXgj1fINeQikZfmetYdKE7+8cxDEDB7KOKLW2s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472548; c=relaxed/simple;
	bh=m7flA/kRgCLPkNAwZe1bypb+NQ1MJ5hd9l8I8Af9BSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tM3wFKBQHO9vTyEHShro68xo6ONHWm8J6v29yVkZ4F6Ye6nLYUnsIn7yxKpKd0seodJKnLt1gmoM88bJLFW9d8S1wipGaZSNrxZArz87Tq21H8ox+fi7ZjxENa5cOC1leUNBlt+xHadqw5GEphDtRpEF169go41lwhSRRQHKUY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J8H+ZXQc; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QH2A0Q038545;
	Tue, 26 Mar 2024 12:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711472530;
	bh=rWcNWAPtgmSYG6OvtJyO1ftZISIIWi4ZC//f+OxtTs4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=J8H+ZXQc0v+nUNQgfRgzSy8L75AaeCwthl9PjIa2Lkzs2Fiwed86qTyIHbr2TfZRc
	 BZHHCp9uCJLVxn0qUmIWNail9bmH/lJPndWDAtVAa09VrIdyQ/iZaGRZfTWVM6sPgF
	 igENEz9y/fx0kCu29DbocFLvsV/NXCb1E4uneu74=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QH2AGF019800
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 12:02:10 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 12:02:09 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 12:02:09 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QH29B6023031;
	Tue, 26 Mar 2024 12:02:09 -0500
Message-ID: <c2125144-659e-42f2-af1f-ffef7ec3d157@ti.com>
Date: Tue, 26 Mar 2024 12:02:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uio: pruss: Deprecate use of this driver
To: Robert Nelson <robertcnelson@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Matthijs van Duin <matthijsvanduin@gmail.com>,
        Drew Fustini
	<drew@beagleboard.org>
CC: Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240325210045.153827-1-afd@ti.com>
 <2024032631-excursion-opposing-be36@gregkh>
 <CAOCHtYjauA+BAxZJBMTaxxaMGcvipP9=ZPeWe4FiNFs_jpq6dg@mail.gmail.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <CAOCHtYjauA+BAxZJBMTaxxaMGcvipP9=ZPeWe4FiNFs_jpq6dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 3/26/24 11:19 AM, Robert Nelson wrote:
> On Tue, Mar 26, 2024 at 12:41 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Mon, Mar 25, 2024 at 04:00:45PM -0500, Andrew Davis wrote:
>>> This UIO driver was used to control the PRU processors found on various
>>> TI SoCs. It was created before the Remoteproc framework, but now with
>>> that we have a standard way to program and manage the PRU processors.
>>> The proper PRU Remoteproc driver should be used instead of this driver.
>>> Mark this driver deprecated.
>>>
>>> The userspace tools to use this are no longer available, so also remove
>>> those dead links from the Kconfig description.
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>>   drivers/uio/Kconfig | 10 ++--------
>>>   1 file changed, 2 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
>>> index 2e16c5338e5b1..358dc2d19b885 100644
>>> --- a/drivers/uio/Kconfig
>>> +++ b/drivers/uio/Kconfig
>>> @@ -126,19 +126,13 @@ config UIO_FSL_ELBC_GPCM_NETX5152
>>>          http://www.hilscher.com/netx
>>>
>>>   config UIO_PRUSS
>>> -     tristate "Texas Instruments PRUSS driver"
>>> +     tristate "Texas Instruments PRUSS driver (DEPRECATED)"
>>
>> This isn't going to do much, why not just delete the driver entirely if
>> no one uses it?
> 
> CC'ing Matthijs one of our BeagleBoard community members who utilizes
> and supports UIO on a number of community projects.
> 
> We know TI and Mainline in general do not like this UIO driver as it's
> very open-ended.
> 
> While the remoteproc_pruss driver is now mainline (it has taken a long
> time, since 3.14.x i I think TI first started this..)
> 
> There is a large user base of UIO examples that have been running
> since 3.8.x and as a community we have made sure ( mostly Matthijs )
> that these continue to operate on this driver in
> v5.x/v6.x/lts/mainline branches.
> 

These users rely on out-of-tree patches to make this driver usable[0].
In its current state upstream, this driver is not used/usable. Since you
have to make update patches anyway, why not simply carry the whole driver
as an out-of-tree patch?

That is why I was thinking of just marking it deprecated for a cycle
or two, just to give one last hint that it will be going away soon
(or you cancarry the driver out-of-tree for however long you want).

Andrew

[0] https://github.com/beagleboard/linux/commit/d5a2815173b26095fa469e6f428ff55990f51138

> We can always revert/etc..  But I'm hoping Matthijs will chime-in..
> 
> Regards,
> 

