Return-Path: <linux-kernel+bounces-137885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1453D89E8EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDBF1F22F33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8CCC127;
	Wed, 10 Apr 2024 04:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSPGEXG+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64A1396
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723590; cv=none; b=n+Xn4ZcRnmqPUWFDq/FtM5uBr6Lc+QeuT9MANIb055zu0Lo2FBXHgCQy7wxccXasbkBhSTAhNkYHE15RfK11gI00YPErJ+yOwUO++A/Fjh/oUYr4Gk6OgO9CRleHMJ7yq4TKJEiF5kwxgQUUhqu0A+G3608iYMBr5QSGPcxm4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723590; c=relaxed/simple;
	bh=h9tgpqXFJcK+DYD0n9TmnkJ3NShANOlEk6vqoLQFEyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNRs6bacQ8rQReWrXh2JSmT22tIof7wYCo4k5YjSbDjVrqONhgARq+zs3x3Jkh45D2ajny1zzwdLLlRoA2vndH/oEsE3aWhvsRNjj4gxXpGryRQr1LdUiMzHnyrHs0+vSzISbmSeLF1mE8c6A0bPRW3md6h7Xi7as2hWwWyrkMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSPGEXG+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712723587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D96eMegMNvGOobQPUAcgBWo3TgJJp8g0UMvgonFv028=;
	b=aSPGEXG+a3k7A6hWmML4ax+/oGZmYYXxFWC1IWm5c0Io+mZNkcDmWhZ9HXR8bLJgSgxbkh
	Dma7nqK2X3+B+tNURVrXWkys+MgMaNwdPVNq229pcAyllenFO9qKTjoqdb7XW72HOQ1lQZ
	itoCTCO6un3JiKT6pQOrkcPKi0q1F7Q=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-4dY6iIjUNWmhTA-DUqd8Yw-1; Wed, 10 Apr 2024 00:33:04 -0400
X-MC-Unique: 4dY6iIjUNWmhTA-DUqd8Yw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ed2f4e685bso2234659b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 21:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712723584; x=1713328384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D96eMegMNvGOobQPUAcgBWo3TgJJp8g0UMvgonFv028=;
        b=NH1qdfHyz3qvScWeQCMoaXCoJkbnnFmSInI+kI7UNMakpTqqFjbHmfHKKyZklTXpF5
         RSoIYLfGQsInXXkJDQz9Y4BJn2XafQIoW+KvDThAmgs8OPrHiA8gJhL/2iegvCu15mlX
         Ld5oH60KOfvPg9WAIVysi/Vk8Se8CZYPLBIwDjdJ2Euq92O8ibCTOYHwpzzTKXWx3/La
         lcoma2AVyqHjJ0e5nYpsOX2ldxIAjLD5crPEcv1m3PQZPyvrf3FRoHICFxorGnP8VVX6
         5JeHnbjsCvjJnLFvP8uFUCAuaf4LcFYTL7Ws+DlX3GYBc/UCsok9lIEMutsAxgml9KdM
         x+zw==
X-Forwarded-Encrypted: i=1; AJvYcCUQSKY4PIOvnFqa3rRToHRyJI7wyIpOS+YMkA+aCIwvN0S6XPGc20YpeyOfS/QPP5YaDnhVGeJ1KsewGP1dCgQkxSxE9gp+R+SyHyOc
X-Gm-Message-State: AOJu0Yyco/7bRGMFqQfDPRdZ3aeLfGfNRknh17jRrQucyL51K8/bxbeA
	OQyvtoKUcax08iiOSD5hZF9/+IFHqgoQq5dQviHBE8Zxmcj0NkBoEG7IOwW+b+O6mq8C0z1q5Zj
	XUhXytPVcp7Ura8BE+o/v9/RJAxTNvd1GCTqhtpHBUeuCyvF0HxRyk5rhAsHCS9qOQr0XxIuT
X-Received: by 2002:a05:6a00:4fd2:b0:6ed:4b2d:a764 with SMTP id le18-20020a056a004fd200b006ed4b2da764mr7587758pfb.11.1712723583669;
        Tue, 09 Apr 2024 21:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx0Sz3ojTpctz7giTqqx2R5V+bbs742ef5vHqDuJyANeevjTVtDt6gkz7oZGO6GFvy6D5EOg==
X-Received: by 2002:a05:6a00:4fd2:b0:6ed:4b2d:a764 with SMTP id le18-20020a056a004fd200b006ed4b2da764mr7587733pfb.11.1712723583260;
        Tue, 09 Apr 2024 21:33:03 -0700 (PDT)
Received: from [192.168.1.240] (117-20-68-143.751444.bne.nbn.aussiebb.net. [117.20.68.143])
        by smtp.gmail.com with ESMTPSA id it24-20020a056a00459800b006e6be006637sm9251859pfb.135.2024.04.09.21.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 21:33:02 -0700 (PDT)
Message-ID: <5fe3b171-afc0-47de-802c-28470ce40674@redhat.com>
Date: Wed, 10 Apr 2024 14:32:56 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug info
 keycodes
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, hmh@hmh.eng.br,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 njoshi1@lenovo.com, vsankar@lenovo.com
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com> <ZhXpZe1Gm5e4xP6r@google.com>
Content-Language: en-US, en-AU
From: Peter Hutterer <peter.hutterer@redhat.com>
In-Reply-To: <ZhXpZe1Gm5e4xP6r@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/2024 11:20, Dmitry Torokhov wrote:
> On Tue, Apr 09, 2024 at 02:47:05PM -0700, Dmitry Torokhov wrote:
>> On Tue, Apr 09, 2024 at 03:23:52PM +1000, Peter Hutterer wrote:
>>> On 09/04/2024 09:31, Dmitry Torokhov wrote:
>>>> Hi Mark,
>>>>
>>>> On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
>>>>> Add support for new input events on Lenovo laptops that need exporting to
>>>>> user space.
>>>>>
>>>>> Lenovo trackpoints are adding the ability to generate a doubletap event.
>>>>> Add a new keycode to allow this to be used by userspace.
>>>>
>>>> What is the intended meaning of this keycode? How does it differ from
>>>> the driver sending BTN_LEFT press/release twice?
>>>>>
>>>>> Lenovo support is using FN+N with Windows to collect needed details for
>>>>> support cases. Add a keycode so that we'll be able to provide similar
>>>>> support on Linux.
>>>>
>>>> Is there a userspace consumer for this?
>>>
>>> Funnily enough XKB has had a keysym for this for decades but it's not
>>> hooked up anywhere due to the way it's pointer keys accessibility
>>> feature was implemented. Theory is that most of userspace just needs
>>> to patch the various pieces together for the new evdev code + keysym,
>>> it's not really any different to handling a volume key (except this
>>> one needs to be assignable).
>>
>> What is the keysym? If we can make them relatable to each other that
>> would be good. Or maybe we could find a matching usage from HID usage
>> tables...

There's a set of  XK_Pointer_ keysyms defined in X11/keysym.h, including XK_Pointer_DblClick1 and XK_Pointer_DblClickDefault.
Unfortunately they're not hooked up to anything atm, see this draft MR:
   https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/merge_requests/659
Because they're not hooked up anywhere they'll also need to be hooked into the client space, same as the various XF86FooBar symbols we've added over the years.

If we were to add KEY_DOUBLECLICK we can patch xkeyboard-config to bind that to the existing XK_Pointer_DblClickDefault symbol (it would get XF86DoubleClick assigned by the current automated scripts), so in theory that key would work like any other key with that symbol assigned.

> I was looking through the existing codes and I see:
> 
> #define KEY_INFO		0x166	/* AL OEM Features/Tips/Tutorial */
> 
> We also have KEY_VENDOR used in a few drivers/plafrom/x86, including
> thinkkpad_acpi.c and I wonder if it would be suitable for this vendor
> specific debug info collection application (which I honestly doubt will
> materialize).

fwiw, I suggested KEY_DOUBLECLICK because that is the action the user takes. Whether that starts a particular application is mostly a question of configuration, defaulting to something that emulates a double-click seems prudent though. And if someone wants to remap that to the compose key that'd be trivial too then.

Cheers,
   Peter


