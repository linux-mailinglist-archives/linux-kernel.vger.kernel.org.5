Return-Path: <linux-kernel+bounces-92714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C328724DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1C328199E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5963CD28D;
	Tue,  5 Mar 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKwcPXtO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C408F58
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657567; cv=none; b=POFm6hLVDSnXaUGgkYzA+XqtuS6L8o2Eeqxg9KF1nJR6H0lRlT6n9MwRERX2jy6daFrXZ11zaShXQgstltY5z7UrWCe0ypiLR1EJs2DaT+l5cm5P9c1zBYNp2IiKKXS+pTzAne3wqLJxrrglWtlS3eQwUxj3BrQ7qjKTFbBNCzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657567; c=relaxed/simple;
	bh=STwejP1X5e/WFaw84WfyJRXrXcfv/sRsbhyOF44RY/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1XhGPC9vnfJeHh0KrHJ5J4uPB2tAMoiZTdkOetfp91u+UiV+AZEePzmz5fYt9CfcftEMbJHTai747Slim2/XQWYKhUEo2EIfaO+knhU8NfeWOUtGd5efDhNMCAnJrT4GD8xsVBGZ7jy/yfGRcKNVM9NPZKJnTU/uwfkEfTNPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKwcPXtO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709657564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bP8Cc1m+j7lZNr0m4WpXqV8ri7Lz2AvWMe7Xo/Lhbm0=;
	b=DKwcPXtOWQcDEEI6pxVEggQy1pEy/JFYVgFZcjCFIbu3h+aYJ1byDVujlftXnz/oFRnlGd
	ihG2sTqGx2amvWeTU2gAQM3sNuzOMxnFkqKYv4EgGODNDPDsGnzMAF1NCA75PCthnXsAqM
	BeP+fEytCr+zNVxJXAqmziUk6/N5WVY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-ghsrp182NoGzXKNc_oW1yw-1; Tue, 05 Mar 2024 11:52:43 -0500
X-MC-Unique: ghsrp182NoGzXKNc_oW1yw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-51314c5a05aso4234739e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 08:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709657562; x=1710262362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bP8Cc1m+j7lZNr0m4WpXqV8ri7Lz2AvWMe7Xo/Lhbm0=;
        b=gmE/bpj89ARYGjRQFCHIeJjSR51WnP7ralkOzTtgwMa8rLhXHXYnK3Dqm572eL4UoV
         1jOOVvoxjiloOwUmlg3F1FREfgLjC9Fz6u5PuiqSliYBwrTRz023m6Wxpr0aTauyTXxI
         PE//Jq/74fMuy50QmmEO0FR27PwUH6lRnzDmE34q4Y7ac3PetilMgWm2A4qr0hO0YYPT
         srhQndSn7p8iDctzLqBQ0ZiJKHUhqrgAQPOoQYlx5/5pnGP7NbYccsbd/P/6H/Gj/clp
         gNanJBQ0IM0fVw4X+6zi4FeGROp1FVTB119gj3v/8w4DUNWht273uZrJJXDoAyw8bFw3
         C2IA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Zgiy0JYxPsBwC9TlJCb7Xv9qD9DoUcgzEj020PFfwEMY00gBDRbZG12UYflgMZSC7HpYYYjYSd+CU6X8L4K0Hhbz0+cDxX6Z+jZ9
X-Gm-Message-State: AOJu0YwiwdrT41vMMNM925GZANPfhQ7YsTuvBNoYhP7Pu/0NfQniYfj1
	HgqUC5jCtmCLgyXFYbUwOGW3Krqag2+mFfS6zBTczeDmSzT336FQZz5CZUwnSDf1Y7nlhpzEVa8
	0L5B6EXekM6bKVeFemr4CsikGCcysNTO69kjtuV4LIDGzPVKmbEgMEFoCpwabOA==
X-Received: by 2002:a05:6512:312b:b0:513:5808:72f9 with SMTP id p11-20020a056512312b00b00513580872f9mr984017lfd.56.1709657562035;
        Tue, 05 Mar 2024 08:52:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkvF0km/ldN7XD5s/zPoV3sZCCMPiuDbsJPkUSMImq16qQCqbFD2ESBaFk5r999FxMgVV3bQ==
X-Received: by 2002:a05:6512:312b:b0:513:5808:72f9 with SMTP id p11-20020a056512312b00b00513580872f9mr984003lfd.56.1709657561659;
        Tue, 05 Mar 2024 08:52:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id o39-20020a05600c512700b00412d60cb914sm11594793wms.5.2024.03.05.08.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 08:52:41 -0800 (PST)
Message-ID: <d1d2093c-72a3-4f64-9a8f-9844dc38f0c5@redhat.com>
Date: Tue, 5 Mar 2024 17:52:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] How to test panic handlers, without crashing the kernel
Content-Language: en-US, fr
To: Michael Kelley <mhklinux@outlook.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 John Ogness <john.ogness@linutronix.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lukas Wunner <lukas@wunner.de>,
 Uros Bizjak <ubizjak@gmail.com>, Petr Mladek <pmladek@suse.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Douglas Anderson <dianders@chromium.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>
References: <266579a9-fde6-40ff-b13d-fb2312db406c@redhat.com>
 <87edcpn1l3.fsf@jogness.linutronix.de>
 <15015345-3068-2fb8-aa38-f32acf27e1d0@igalia.com>
 <SN6PR02MB4157AF2E765F7ED3B9487351D4222@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <SN6PR02MB4157AF2E765F7ED3B9487351D4222@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2024 17:23, Michael Kelley wrote:
> From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Monday, March 4, 2024 1:43 PM
>>
>> On 04/03/2024 18:12, John Ogness wrote:
>>> [...]
>>>> The second question is how to simulate a panic context in a
>>>> non-destructive way, so we can test the panic notifiers in CI, without
>>>> crashing the machine.
>>>
>>> I'm wondering if a "fake panic" can be implemented that quiesces all the
>>> other CPUs via NMI (similar to kdb) and then calls the panic
>>> notifiers. And finally releases everything back to normal. That might
>>> produce a fairly realistic panic situation and should be fairly
>>> non-destructive (depending on what the notifiers do and how long they
>>> take).
>>>
>>
>> Hi Jocelyn / John,
>>
>> one concern here is that the panic notifiers are kind of a no man's
>> land, so we can have very simple / safe ones, while others are
>> destructive in nature.
>>
>> An example of a good behaving notifier that is destructive is the
>> Hyper-V one, that destroys an essential host-guest interface (called
>> "vmbus connection"). What happens if we trigger this one just for
>> testing purposes in a debugfs interface? Likely the guest would die...
>>
>> [+CCing Michael Kelley here since he seems interested in panic and is
>> also expert in Hyper-V, just in case my example is bogus.]
> 
> The Hyper-V example is valid. After hv_panic_vmbus_unload()
> is called, the VM won't be able to do any disk, network, or graphics
> frame buffer I/O. There's no recovery short of restarting the VM.

Thanks for the confirmation.
> 
> Michael
> 
> [I have retired from Microsoft.  I'm still occasionally contributing
> to Linux kernel work with email mhklinux@outlook.com.]
> 
>>
>> So, maybe the problem could be split in 2: the non-notifiers portion of
>> the panic path, and the the notifiers; maybe restricting the notifiers
>> you'd run is a way to circumvent the risks, like if you could pass a
>> list of the specific notifiers you aim to test, this could be
>> interesting. Let's see what the others think and thanks for your work in
>> the DRM panic notifier =)

Or maybe have two lists of panic notifiers, the safe and the destructive 
list. So in case of fake panic, we can only call the safe notifiers.

>>
>> Cheers,
>>
>>
>> Guilherme
> 


