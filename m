Return-Path: <linux-kernel+bounces-82025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4D5867DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAA21C24065
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140021369A7;
	Mon, 26 Feb 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PS6NPe48"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A107612F5B8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967280; cv=none; b=ldxdz8IXbGtLAoUsHTlyaVgarBZ2yKPaF9eo+kB49laOaz6TludU1dQJigh7zOf6crsEAvg0pb8EELz2VGLGLrLK5PTYYk13hGzdht86+Cf6fJKL8b0Vg+HjDxDQMZFTUTKSgzuTkHPfNjBM0KeAd7OUE0sd2e6bpP0Yegay2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967280; c=relaxed/simple;
	bh=ot5o6Y7N8huTeeBW50wAKAxLA6DbyVtI4eOZUfS5VuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6J1/6QoMlipBkguSS66xxC0rSzf2nDammjQTXvdRL17Lc27no8L0WP3o2mrP2CN79Yp7963u+Qszx+uQO9x4wd9DJaEuZn77YhrvjWPC5ZYGiPcVZlgtuLs8Bz6K4oM5Zc1BM9Wn2Zwe5FVDuSmTX5JQnMeyqGKEEqM4JID2D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PS6NPe48; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708967277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2a3hAc8xbGiBkaQRR/cOD5LbSfgks1mwCtsszd3ZXQ=;
	b=PS6NPe48WADPwE2csUWGJCBqQ/vVW0uOJ8ON+DXUiE+eM9qotlIDKsKZPktGazfh4e9ir4
	nZ6oPmzLO+Y0/iPyafA3gpnWIPVTP5eChz3sUCYFpKvS/nq938XB3/HZGsXW23acPZ+5qw
	f8LZ5j6uA+EnCosptnpuYLVe2eUWnL0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-QP1F8dXLPeyboG6-sn4RdA-1; Mon, 26 Feb 2024 12:07:55 -0500
X-MC-Unique: QP1F8dXLPeyboG6-sn4RdA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-787ac304610so410157385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967275; x=1709572075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2a3hAc8xbGiBkaQRR/cOD5LbSfgks1mwCtsszd3ZXQ=;
        b=Oi/OV2AxjZqMxgtI9Ge915xSYriYiwP+GBpwPiVX1Gqtr5UWsBpTG2fVpmDob4I9qm
         rXTrTIaDbts2gHwqSUj4vhgXSLEzdD+tj5e3XnnrS+9RUisWOCpkolnkON1GiKAUCxOS
         ecLfVpemHGd2arqYlxFNMYL3mYbfkgE9MnVWUZSO3i5z4D7etBAemBKB640TEzjwdVIR
         bmzJmNiQ7aJk//tMAzHkj3IZyV5AYikCoEuZfitULCQ8Xg/NLRDbFC9LDBsqtlcQpxce
         BBfzRJ+PJnaocpW6CuAIJeSewoEYwJtaa1YecqqKlDtH8/mYjA7agJAD2J9o/I0Z6rsY
         ZVhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2p1fEAahaUOAwiibVnEd7lTOOOjFhtgWEH5JVkl7yIP21xZLllB5Eg15J1DvFzoM3yqctB2V3zQbnHZ6gRFqe9oHF77RT3hnKAF5f
X-Gm-Message-State: AOJu0YzbrciEp+wlnAKhEFBaBDWsGa9maM92P0aal8TKnZoPySlzPOVC
	kN8Db8pkWx7ahRmp33QxK72hax9xxNOGz4tExw35k2JGrhzEzhWE/WmhgaJ1QvVHThdDM7YZ0Rz
	OB37Zi3CS5PqgBAHh2EXPxvlLA7EadFlLWUa/kgPBOHnZOxpuSrGWvA/l40l39w==
X-Received: by 2002:a05:620a:14ad:b0:787:91fc:f940 with SMTP id x13-20020a05620a14ad00b0078791fcf940mr9670821qkj.48.1708967275098;
        Mon, 26 Feb 2024 09:07:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwfKR70ni3GqKHB0n9AVnPWbnVBsTRIS2vJYee3RsSzLT5LaxXCqLcGs5KqQWUhaKbbzFDvw==
X-Received: by 2002:a05:620a:14ad:b0:787:91fc:f940 with SMTP id x13-20020a05620a14ad00b0078791fcf940mr9670802qkj.48.1708967274839;
        Mon, 26 Feb 2024 09:07:54 -0800 (PST)
Received: from [10.0.0.33] (modemcable096.103-83-70.mc.videotron.ca. [70.83.103.96])
        by smtp.gmail.com with ESMTPSA id po5-20020a05620a384500b00787b8820f33sm2669048qkn.30.2024.02.26.09.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:07:54 -0800 (PST)
Message-ID: <eaef16d8-d43a-49c8-b1a0-450ab4c1ba9f@redhat.com>
Date: Mon, 26 Feb 2024 12:07:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/mellanox: mlxbf-pmc: Fix module loading
Content-Language: en-US, en-CA
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: shravankr@nvidia.com, davthompson@nvidia.com, ndalvi@redhat.com,
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>
References: <cover.1708635408.git.luizcap@redhat.com>
 <170895404513.2243.14840310263795846559.b4-ty@linux.intel.com>
 <def1a153-3cfb-431d-a7d2-a13bb7d65f4f@redhat.com>
 <29863354-4efe-d199-a9d4-7daf83f6cde9@linux.intel.com>
 <1608d86a-24e8-403b-b199-ce23f8411cfd@redhat.com>
 <8a05120e-fcdf-f7f2-6b60-22e3ee819d37@linux.intel.com>
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <8a05120e-fcdf-f7f2-6b60-22e3ee819d37@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-26 11:59, Ilpo Järvinen wrote:
> On Mon, 26 Feb 2024, Luiz Capitulino wrote:
> 
>> On 2024-02-26 11:04, Ilpo Järvinen wrote:
>>> On Mon, 26 Feb 2024, Luiz Capitulino wrote:
>>>
>>>> On 2024-02-26 08:27, Ilpo Järvinen wrote:
>>>>> On Thu, 22 Feb 2024 15:57:28 -0500, Luiz Capitulino wrote:
>>>>>
>>>>>> The mlxbf-pmc driver fails to load when the firmware reports a new but
>>>>>> not
>>>>>> yet implemented performance block. I can reproduce this today with a
>>>>>> Bluefield-3 card and UEFI version 4.6.0-18-g7d063bb-BId13035, since
>>>>>> this
>>>>>> reports the new clock_measure performance block.
>>>>>>
>>>>>> This[1] patch from Shravan implements the clock_measure support and
>>>>>> will
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
>>
>> One additional detail is that this series is on top of linux-next, which
>> has two additional mlxbf-pmc changes:
>>
>> *
>> https://lore.kernel.org/lkml/39be055af3506ce6f843d11e45d71620f2a96e26.1707808180.git.shravankr@nvidia.com/
>> *
>> https://lore.kernel.org/lkml/d8548c70339a29258a906b2b518e5c48f669795c.1707808180.git.shravankr@nvidia.com/
>>
>> Maybe those two should be included for 6.8 as well?
> 
> Those look a new feature to me so they belong to for-next. So no, they
> will not end up into 6.8 (to fixes branch). If the 2 patches in this
> series do not apply without some for-next targetting dependencies, you
> should rebase on top of fixes branch and send a new version.

Understood.

> About those two patches, please also see my reply. I intentionally only 2
> patches of that series because I wanted to see sysfs documentation first
> so you should resend those two patches to for-next with sysfs
> documentation.

I'm actually not author of the other patches :)

- Luiz



