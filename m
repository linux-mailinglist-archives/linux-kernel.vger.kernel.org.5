Return-Path: <linux-kernel+bounces-150044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D048A9994
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607E91F22273
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA72E15F40B;
	Thu, 18 Apr 2024 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0UVVTz4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310D15E814
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442331; cv=none; b=AlllVcT5J0tbxyZDX+vKHeyAw0/MYDMRC5AYfVcjFMP5mv44+NVvkztSsX1hlIB31tof5wp69lR3JLcGrknkhE4qsjDpNfOSPSeIbIplKFiNt28jbg9E47F+Fb9z05TqQiT2okVvwgZgDBPezejU66D3ipuIei019jhGgB0lZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442331; c=relaxed/simple;
	bh=9MAfaRyifghyGBKAvzdc6kFAtwMLsSXsF66leLRJIN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCj51KPpoMyUFmfhzqyZQ8hFBOdPxJvZyJG8YKBobvK+y0+TgHKKn72wwGDL7YpYDVMRGALTl5HyEy+WioKrTWUNF2dQ+1G2VZgZo+4oEsw4/noHWolSQql6jR/rKgWhhIBKeJSSUP4RWF+ijPvh9w+CWD99lgWkyQaL3/C2S/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0UVVTz4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713442327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=or6k/SQ+ZiA88i4NucrFxJ6IuuwjDqoBoopuuP1QuRU=;
	b=H0UVVTz4jQwRZ34y/LelTvbw+IY9wDS/n4/+CN549kGulIjjnN9Yr6pQSRsya9ucxSErFx
	CYf7xsCUdUl3ljErVtdhDfx6mHa6zVLnX0zYzPx8YngpavKHUpHWxw+HeRUHKrSS+iZbTl
	hUe2cvkEa6AXHr1DzN4eYXIornFgfg4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-FLZrv-VyMXqbnmeAKC3amg-1; Thu, 18 Apr 2024 08:12:06 -0400
X-MC-Unique: FLZrv-VyMXqbnmeAKC3amg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a524b774e39so95127666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713442325; x=1714047125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=or6k/SQ+ZiA88i4NucrFxJ6IuuwjDqoBoopuuP1QuRU=;
        b=Jy8UQ98m0z6sTM7E3x03wxcEZXMiMF02/+5LsD1hNNfEXm4FyMbH8fOl7yMeCtPhDM
         0VKW73ctIxtdGbw3X0gWOA9Wxvs+wkTykYXXfoAhp7KlpKVnMz+s/xqhsBXFUP0b8SY5
         6tYHUP2D/JpNS7rmtcTu2mcJB62gSEFbXU+Wuw5rPpd8UtyUTluEFQ7jaXJC8P4t/cQP
         EhpVEBOOs0DmS8U2aBdK71m815VWwISnjHLy+Bnhq1X1Nr2icFmniJoVhFd5VnHRTM3o
         ESipLE6XOJtMijN2TgW/+TUXiXR5CRjo8wMP2nzho9jNOcuqIzsYUTIrvGvDdCPV+T7j
         nD9A==
X-Forwarded-Encrypted: i=1; AJvYcCVkfsiIDh2ThzaBEotBSlPly6qP3xR426lzqFehbhuyaN5+U3qQlUkvvepHjK5cZnFyllSKg7qtyv2JrxHtgm8hGxogYQ/PazNO/cKJ
X-Gm-Message-State: AOJu0YytfqRL5rLAy8tEZrFT34cfP9WxUT9pje5MHtr8+BB4y7SbkxRi
	yHwn+1pUntYnur54ms/z1J8aCTvNz0nYIVCDikjFjGSSqG939oPlGqGFojrNc2dmCHF+jJ5uOP5
	gX7vA0YPrJUL0BheTl9Dz+FQumg6IysPWmft+BH4cmxHGGE9DcQqMJL8AmHitww==
X-Received: by 2002:a17:906:903:b0:a51:ee80:bae9 with SMTP id i3-20020a170906090300b00a51ee80bae9mr1790070ejd.17.1713442325097;
        Thu, 18 Apr 2024 05:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8W5a6sqALulCXn//I/MSe+hj2s2mXgVVfbmIyDaBBFlYJBIgfVpbiGA7+mctjskXQzcGh7g==
X-Received: by 2002:a17:906:903:b0:a51:ee80:bae9 with SMTP id i3-20020a170906090300b00a51ee80bae9mr1790046ejd.17.1713442324735;
        Thu, 18 Apr 2024 05:12:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id nb33-20020a1709071ca100b00a55778c1af7sm403615ejc.11.2024.04.18.05.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 05:12:04 -0700 (PDT)
Message-ID: <103294af-cb15-43d7-9f63-1d6eb458b61a@redhat.com>
Date: Thu, 18 Apr 2024 14:12:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86/amd: Don't allow HSMP to be loaded on
 non-server hardware
To: Mario Limonciello <superm1@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
 Carlos Bilbao <carlos.bilbao@amd.com>,
 "open list:AMD HSMP DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240416182057.8230-1-superm1@gmail.com>
 <ca6e0dc7-f5ea-4c0a-b9fe-0667fadc78a6@redhat.com>
 <1071ea83-7919-469a-ac5b-3209fe9e018c@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1071ea83-7919-469a-ac5b-3209fe9e018c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

HI,

On 4/18/24 1:27 PM, Mario Limonciello wrote:
> 
> 
> On 4/18/24 04:04, Hans de Goede wrote:
>> Hi,
>>
>> On 4/16/24 8:20 PM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> If the HSMP driver is compiled into the kernel or a module manually loaded
>>> on client hardware it can cause problems with the functionality of the PMC
>>> module since it probes a mailbox with a different definition on servers.
>>>
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2414
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3285
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v1->v2:
>>>   * use pm preferred profile instead
>>
>> Thanks, patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Mario, should this go in as a fix for the 6.9 cylce, or is
>> this for-next material ?  (I'm not sure what to do myself)
> The main risk with this patch is if there are servers that previously loaded amd-hsmp no longer working because of a BIOS bug to exporting the incorrect profile.  I think this is quite unlikely but not non-zero.
> 
> To at least give some time for anything like that to be raised I feel this should go to for-next.
> 
> Ideally I do want to see it go to stable kernels after we're all sufficiently happy though.  Random bug reports to me like the ones I added to the commit message get raised mostly by people who compile their own (stable) kernels and enable all the AMD stuff because they have AMD hardware.
> 
> So how about we target for-next, but also add a stable tag for when it gets merged in the 6.10 cycle?

Works for me. I'll merge this during my next round of patch merging and I'll
add a Cc: stable while merging.

Regards,

Hans






>>> ---
>>>   drivers/platform/x86/amd/hsmp.c | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
>>> index 1927be901108..102a49c3e945 100644
>>> --- a/drivers/platform/x86/amd/hsmp.c
>>> +++ b/drivers/platform/x86/amd/hsmp.c
>>> @@ -907,6 +907,17 @@ static int hsmp_plat_dev_register(void)
>>>       return ret;
>>>   }
>>>   +static bool hsmp_supported_profile(void)
>>> +{
>>> +    switch (acpi_gbl_FADT.preferred_profile) {
>>> +    case PM_ENTERPRISE_SERVER:
>>> +    case PM_SOHO_SERVER:
>>> +    case PM_PERFORMANCE_SERVER:
>>> +        return true;
>>> +    }
>>> +    return false;
>>> +}
>>> +
>>>   static int __init hsmp_plt_init(void)
>>>   {
>>>       int ret = -ENODEV;
>>> @@ -917,6 +928,11 @@ static int __init hsmp_plt_init(void)
>>>           return ret;
>>>       }
>>>   +    if (!hsmp_supported_profile()) {
>>> +        pr_err("HSMP is only supported on servers");
>>> +        return ret;
>>> +    }
>>> +
>>>       /*
>>>        * amd_nb_num() returns number of SMN/DF interfaces present in the system
>>>        * if we have N SMN/DF interfaces that ideally means N sockets
>>
> 


