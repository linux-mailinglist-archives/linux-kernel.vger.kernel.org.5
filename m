Return-Path: <linux-kernel+bounces-82022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4576C867DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753711C2A34A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8DC13666D;
	Mon, 26 Feb 2024 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ue2dCFYC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347F5136652
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967166; cv=none; b=bjDIyhAQU1T7+AO41LCF1qsdZSlhcZxkG9XQbU8JYpyQDlTJwHcuCKG1BDgqc4CIpfAkKMYOgshjTgf7C9FaxCzbxGhuQA1kQGz7ExbKdG2s5QOMIcnjqrc3fq1fo3PO9zZ2ABsCvUauIz03YdIC1F21FESSoFcPDb8XQrgwbak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967166; c=relaxed/simple;
	bh=6Vyoo0Bzehw8lcWs30lDQlzHhfwrhCkNK53hcGYdx4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fg8b5rSsTHgzRgMhRxxSXPafYvjI+n4WBP0pxO9+R8JluPhjcDSFSJoWW3tlrSLjXYv8zrbPOrRwbj7wuY1ILYS0JSqAtv1/j54TgoGyooqlmqDAhP6imb/7AtSj33hWEWCJw9+5fq9wW87/DnkQgvls9JYh6F7TQwtBaaQeyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ue2dCFYC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708967163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBgwoqBSOIGBvVMXZVHsZZp0o2jjdWKhIehyduutD1E=;
	b=Ue2dCFYCBxAOtopbM2CdX6eozFyLGOnRGv9GORG0hLnVduxgaOo/BclQMZYLfY8A1Kj7+R
	wXTmweOARNneDWP7HvcyvN2eyWHEiazQxHcebujrgVJRP523qoGwMRRYP0PkfDv3uTRnlI
	cZt+tXqLoZIL9vluq3RC3hgagbbo46Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-qn3-4k7sNX--YaSoH5eh6w-1; Mon, 26 Feb 2024 12:06:00 -0500
X-MC-Unique: qn3-4k7sNX--YaSoH5eh6w-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42de9e960a1so40177411cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967159; x=1709571959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBgwoqBSOIGBvVMXZVHsZZp0o2jjdWKhIehyduutD1E=;
        b=v/k/2SRiJ6TNqZvLkApIxvSkfJrX8OBEWS1vskdVW35erVWrvIsRMrIzOnK/5OlXYG
         l8DlWheb/FrHQnbK1KJlFOVjtCq0AmiBFX+StXlbE1lyRmyaPw9K64mFs2UgFoaXfrTO
         ObifC75Tm90fM9aOeSRpaYpO+3O10ZkiKbwzzpwSuhQ5Xo8tZZ4Dy68CwZjFVjoedkaU
         81nkxmVEzV45HrbO4habNs+7hTSvD3piHiXaTf96N5OoaBXKLA5+ROAjQKhYNOKGlveo
         VMORThb6Gr5xK7Dp3ursGTA8InS5ZDySOPFjoyDjVbD0/x5G/rtstLpjYWf/3DDe0cLQ
         /q+g==
X-Forwarded-Encrypted: i=1; AJvYcCV1MtUL+tln97ZNr7AAI5f+d3MZ1I1pCxfS3aqVM376lAwYXc8ob0zc08JXA3/ugmo5x6yOV9DbJghv/maFQKix5PAk5IJO9NSir1vv
X-Gm-Message-State: AOJu0YwsWzdckmDjL6a2m+x/OyFYVAExKVA8iKhYhYJZDZAQMR7/iq78
	PSgZubh3VpPMTge9qFYqZSXGnmWfuDAJOr0BM0D0XKJ5H/YJgGghijlMaGzsLZsJOWRn5kb9Tf5
	L/GZNZvw0eUnGtdq/hRqe5IdvF3bq+ZoEbmLPis2ItMtilwyPC5wXEVHLQ5zhcg==
X-Received: by 2002:ac8:5c81:0:b0:42e:6334:cc9a with SMTP id r1-20020ac85c81000000b0042e6334cc9amr10584298qta.20.1708967159462;
        Mon, 26 Feb 2024 09:05:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGouxFyrcIqSJ7v+0s8MpATsxAaXlMAoO3A9/eq2kbm9DVSpqPv+iAYJQQEc/dA3L8o1DGUvA==
X-Received: by 2002:ac8:5c81:0:b0:42e:6334:cc9a with SMTP id r1-20020ac85c81000000b0042e6334cc9amr10584252qta.20.1708967158965;
        Mon, 26 Feb 2024 09:05:58 -0800 (PST)
Received: from [10.0.0.33] (modemcable096.103-83-70.mc.videotron.ca. [70.83.103.96])
        by smtp.gmail.com with ESMTPSA id p1-20020ac84601000000b0042e625a110dsm2635894qtn.78.2024.02.26.09.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:05:58 -0800 (PST)
Message-ID: <6c25bbf6-db97-4d55-b7d6-b7b6dbb60a82@redhat.com>
Date: Mon, 26 Feb 2024 12:05:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/mellanox: mlxbf-pmc: Fix module loading
Content-Language: en-US, en-CA
To: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: shravankr@nvidia.com, davthompson@nvidia.com, ndalvi@redhat.com,
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
References: <cover.1708635408.git.luizcap@redhat.com>
 <170895404513.2243.14840310263795846559.b4-ty@linux.intel.com>
 <def1a153-3cfb-431d-a7d2-a13bb7d65f4f@redhat.com>
 <29863354-4efe-d199-a9d4-7daf83f6cde9@linux.intel.com>
 <1608d86a-24e8-403b-b199-ce23f8411cfd@redhat.com>
 <eea32e56-2ea3-4a11-b1b9-8dd46dac7d72@redhat.com>
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <eea32e56-2ea3-4a11-b1b9-8dd46dac7d72@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-26 11:57, Hans de Goede wrote:
> Hi Luiz,
> 
> On 2/26/24 17:10, Luiz Capitulino wrote:
>> On 2024-02-26 11:04, Ilpo Järvinen wrote:
>>> On Mon, 26 Feb 2024, Luiz Capitulino wrote:
>>>
>>>> On 2024-02-26 08:27, Ilpo Järvinen wrote:
>>>>> On Thu, 22 Feb 2024 15:57:28 -0500, Luiz Capitulino wrote:
>>>>>
>>>>>> The mlxbf-pmc driver fails to load when the firmware reports a new but not
>>>>>> yet implemented performance block. I can reproduce this today with a
>>>>>> Bluefield-3 card and UEFI version 4.6.0-18-g7d063bb-BId13035, since this
>>>>>> reports the new clock_measure performance block.
>>>>>>
>>>>>> This[1] patch from Shravan implements the clock_measure support and will
>>>>>> solve the issue. But this series avoids the situation by ignoring and
>>>>>> logging unsupported performance blocks.
>>>>>>
>>>>>> [...]
>>>>>
>>>>>
>>>>> Thank you for your contribution, it has been applied to my local
>>>>> review-ilpo branch. Note it will show up in the public
>>>>> platform-drivers-x86/review-ilpo branch only once I've pushed my
>>>>> local branch there, which might take a while.
>>>>
>>>> Thank you Ilpo and thanks Hans for the review.
>>>>
>>>> The only detail is that we probably want this merged for 6.8 since
>>>> the driver doesn't currently load with the configuration mentioned above.
>>>
>>> Oh, sorry, I missed the mention in the coverletter.
>>>
>>> So you'd want I drop these from review-ilpo branch as there they end
>>> up into for-next branch, and they should go through Hans instead who
>>> handles fixes branch for this cycle?
>>
>> If that's the path to get this series merged for this cycle then yes,
>> but let's see if Hans agrees (sorry that I didn't know this before
>> posting).
> 
> Hmm, new hw enablement typically goes through -next and not to
> the current fixes branch. And AFAICT this is new hw enablement,
> not a regression / bug-fix.
> 
> Is there any special reason why this needs to be in 6.8 ?

Since the new firmware feature is causing the driver not to load,
I'm seeing this more as a bug than new enablement. But it's fine
with me if you decide on not having them on 6.8.

> For RHEL kernels you can cherry-pick patches from -next
> as necessary.

I know :)

>> One additional detail is that this series is on top of linux-next, which
>> has two additional mlxbf-pmc changes:
>>
>> * https://lore.kernel.org/lkml/39be055af3506ce6f843d11e45d71620f2a96e26.1707808180.git.shravankr@nvidia.com/
>> * https://lore.kernel.org/lkml/d8548c70339a29258a906b2b518e5c48f669795c.1707808180.git.shravankr@nvidia.com/
> 
> Hmm, those are not small patches, any other reason
> why this really should go to -next IMHO.

OK.

- Luiz


