Return-Path: <linux-kernel+bounces-81872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 525E1867B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65471F2D093
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D906612C55C;
	Mon, 26 Feb 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fu/m2Xiw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D66212BF26
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963863; cv=none; b=FvVelIkRSuevnjdaiaVULyToAltz1PTSZRchBWD/km41GmYr4manNLVaky2Os5SKIFPW6JFccZbQjXkDDrr/Q9SQ7JcQA2At4I2XioYe3iR0YLz2NPA4Lw4grendcgba1CCc/GXGsIEGw1/Hr7AwR9ziOo6DIUIFGmkkmOdGYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963863; c=relaxed/simple;
	bh=IKJVu6wZV5ujTTsOPLBnVORIKgraqW10GdJ5zwhsGUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJ0ZHr/CUh97P+gOXigDCWWPnHTgqUHlWtRZvp/um7EIPF7eC2oXaw1JEzeJ0AiUWvntih38ypfe8pDg6JVUl5RQvQDg4pLWhl+U5oDtpvgcVHjZ29eXGnGVwNY1PCijKi5lBgNknQNe3h03cmvkUaYOKDxZSYEkB3lm6lj0nPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fu/m2Xiw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708963860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woAOThpj2J4tH7F5PzEED1AordU+F4q2bfJ28Y6keHE=;
	b=fu/m2XiwZ50oM2dLFnbmoT8N0hwVNJ0KoIq4rjIfaBOqacg36QOwldijWch/pqzh5A8wCf
	zXl+dkrh6+phEMVcyvzVfAxAFY/asNXzDo9EJIjC6SOH6L0P40y6js6G8T0h8NZes8hnl5
	3A4LuyPyo4Lmoo8bRL0YwkbKjwRNCb8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-NQmJ5PPiNUWGpyf09UsjqA-1; Mon, 26 Feb 2024 11:10:57 -0500
X-MC-Unique: NQmJ5PPiNUWGpyf09UsjqA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-787d511fa1bso90309285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708963857; x=1709568657;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woAOThpj2J4tH7F5PzEED1AordU+F4q2bfJ28Y6keHE=;
        b=ABOEBq8cjRZ02SFtYVrvJ76iN48XedX9r8Mwp2HFXWaVsdl0HSlUjo2TVp1xhDlFRG
         Bef+7yLhUa2JCYiySbw1tjlmfRsf6Pup/mYIzzm38MRYYbxi0dBGmZYLaS97/4yDx1z8
         fXN76w4qkGm4F5Wu1GP9KPvpoxwrRGJ64wcUEeaq2TY1VNbC0aTUnRAZQiqLQgQrG08F
         N5E3eiqXd54IU8jsyAyq4fCX8nlGDLK0sZHKOJYl49pm37ytXiWL0oa7yH7Mek4ATOqt
         Pebck6Ojo6hunWVD2saDRafPFyyx2Myf59GoHfUPjrS3QYSwTfbNsOoX9jpVl63M/DFv
         1wlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU024v7EoQHygePTneL4xjPeTA6REA9ZfDV+6p3GjAzcX0dsT5ugNK73QYA/Oz3AB77YbGdO2b8XcnfTIh7/HcnPvbzLniIGcqCxZRP
X-Gm-Message-State: AOJu0YyQXIRzdhbODE8SZ9TF2o3HvxmGFfgrgiL8tiptGUFqzGifmKyL
	sp/ZF8UWRwqLhCp8JoCAQ/zruVJJKawSuqxO3cx7vGS269Zhm5+QooChXg63RoJky5F09GGcYnk
	4/n0W2rPgATYQOhkTwf+aA9lMxS4+ixgeqC8un8NXPdcYQyauQPIy9dLgKTDYWQ==
X-Received: by 2002:a05:620a:2416:b0:785:635b:ac2b with SMTP id d22-20020a05620a241600b00785635bac2bmr8908513qkn.32.1708963857395;
        Mon, 26 Feb 2024 08:10:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2MFPYen/n2mShUieoTiLnUA52oBPxHFlEtD/wlll7mKSqVGE4XzC7iMVi6XaBW6A4YbRmcQ==
X-Received: by 2002:a05:620a:2416:b0:785:635b:ac2b with SMTP id d22-20020a05620a241600b00785635bac2bmr8908497qkn.32.1708963857151;
        Mon, 26 Feb 2024 08:10:57 -0800 (PST)
Received: from [10.0.0.33] (modemcable096.103-83-70.mc.videotron.ca. [70.83.103.96])
        by smtp.gmail.com with ESMTPSA id j22-20020a05620a147600b007876a732823sm2604968qkl.25.2024.02.26.08.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:10:56 -0800 (PST)
Message-ID: <1608d86a-24e8-403b-b199-ce23f8411cfd@redhat.com>
Date: Mon, 26 Feb 2024 11:10:55 -0500
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
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <29863354-4efe-d199-a9d4-7daf83f6cde9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-26 11:04, Ilpo Järvinen wrote:
> On Mon, 26 Feb 2024, Luiz Capitulino wrote:
> 
>> On 2024-02-26 08:27, Ilpo Järvinen wrote:
>>> On Thu, 22 Feb 2024 15:57:28 -0500, Luiz Capitulino wrote:
>>>
>>>> The mlxbf-pmc driver fails to load when the firmware reports a new but not
>>>> yet implemented performance block. I can reproduce this today with a
>>>> Bluefield-3 card and UEFI version 4.6.0-18-g7d063bb-BId13035, since this
>>>> reports the new clock_measure performance block.
>>>>
>>>> This[1] patch from Shravan implements the clock_measure support and will
>>>> solve the issue. But this series avoids the situation by ignoring and
>>>> logging unsupported performance blocks.
>>>>
>>>> [...]
>>>
>>>
>>> Thank you for your contribution, it has been applied to my local
>>> review-ilpo branch. Note it will show up in the public
>>> platform-drivers-x86/review-ilpo branch only once I've pushed my
>>> local branch there, which might take a while.
>>
>> Thank you Ilpo and thanks Hans for the review.
>>
>> The only detail is that we probably want this merged for 6.8 since
>> the driver doesn't currently load with the configuration mentioned above.
> 
> Oh, sorry, I missed the mention in the coverletter.
> 
> So you'd want I drop these from review-ilpo branch as there they end
> up into for-next branch, and they should go through Hans instead who
> handles fixes branch for this cycle?

If that's the path to get this series merged for this cycle then yes,
but let's see if Hans agrees (sorry that I didn't know this before
posting).

One additional detail is that this series is on top of linux-next, which
has two additional mlxbf-pmc changes:

* 
https://lore.kernel.org/lkml/39be055af3506ce6f843d11e45d71620f2a96e26.1707808180.git.shravankr@nvidia.com/
* 
https://lore.kernel.org/lkml/d8548c70339a29258a906b2b518e5c48f669795c.1707808180.git.shravankr@nvidia.com/

Maybe those two should be included for 6.8 as well?

- Luiz


