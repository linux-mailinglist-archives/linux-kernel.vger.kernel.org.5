Return-Path: <linux-kernel+bounces-145835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31868A5BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC361F24A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BE315E80C;
	Mon, 15 Apr 2024 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dyo3mJLb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1884215E5A6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210438; cv=none; b=cA3832Xx9A/D1Cbuz8s3/mghRUpojDnLBS+IV4o6D0WOtjilMcFUi8gXTRztneTxxDaX5pu9a+1BVlqJxhbodeVkGT4oc72Cp3nUEEmDd8Hem2wiGjGSMwhq8jzW3MHKY+NFg5nwETNRY8hpj6Uvulhm+GL0aWLApdv9TjLwndE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210438; c=relaxed/simple;
	bh=zyecQNa3ROhvJFy5hmNzvTxC0BcQbh3484pUPgoAsDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Og91YObYp59wj8yNJK2KSrKc00twqKWje5MZjYPVbbG7YulmsViqe39NKabAPo5zl1M/94LClwzMhh+YMTl5FcNL62I/Y08IYeLhGtyTpYKWSj6SLnV7kFd9F0EFgoF9DeBznUKr26UVyirGNvmbsyMs3NWqMlDFJm7RhlUecyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dyo3mJLb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713210435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+auaIR8KnfST7jWNI6APpY7sl3sBclpIuI6WlLR8ts=;
	b=Dyo3mJLbYvRzfndsaWa1cqRrZaP3S4f+s+KxAvJNOO1+Zct7u1qPjW2XbCZqcOWgJ9sb8v
	1GAXx0ppWKl71P4VAiz3i99HzHX6Hc0PZ1+BCJizw/1Tke/44IUwqq2K5hTkW3PwZ4nDEW
	1ssfTqW3RmhdhKcydTEBX5jQTX6nkWg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-dxYSHjacNruDLnclWmf8Ag-1; Mon, 15 Apr 2024 15:47:13 -0400
X-MC-Unique: dxYSHjacNruDLnclWmf8Ag-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3479b511725so1295922f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713210432; x=1713815232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+auaIR8KnfST7jWNI6APpY7sl3sBclpIuI6WlLR8ts=;
        b=P1kwifWR6VLQs1LdAg91IzxZLQohy5RZRxBOeD11K/mOIlDgym9OinEX4p3J/9+f71
         KTCRJ+J1VSN6aDrxaGzsy2lLT7OuFw2g9azTrgIS+8G1LxAeg3odfaygpjtmpml4brbk
         TSYewJcxRb4HIC2WzJ9DEJ4KyWfI+Ohj6Eho80RnxDsLI///kxYx8wSMDrMbDbVdnDov
         qqIQiQF4WoHYVmU6YLCQv3x70xNH3f0m2qqXw/HjDuorPlYvZgwz+w/m2QawM1T06i26
         D4juwmzbpmmHF0PxaM1gHTczJpqieeoPNcIBq9YzHdcqM8pFT2q/iZOk0qgkejeIoauT
         bZ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV70WGFE/1HsNZBBwSWPOQM8joo7XJEQNnKKm2a+xC4rJQNVb+zcxSIVy3o5+LslpCaAh/eJ5P0oqmmgDTp7OsIJA7Lc8tQ1kJL8/mT
X-Gm-Message-State: AOJu0YzPBtLAD//+/6SAIc9RLA5J+AC2Gx3Y8TYObIiFn4rpnsgYwwhi
	rwsd7d5i9Wq3KWjaRQAyBuK5ETfmPnN9PkGuuNbfMjx3NebLY+kKEMKj4sxRVzTTJzDyNoM02hS
	ZvCn4BJKj9cWHTy8QeCcyWL00K73h4YuWKD2OrZH7YRqizbmvZQqk1j0n4DXAIw==
X-Received: by 2002:adf:ec47:0:b0:346:addc:18aa with SMTP id w7-20020adfec47000000b00346addc18aamr6227034wrn.25.1713210431953;
        Mon, 15 Apr 2024 12:47:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSiegi5oWZeNbSL8UnLpfTuvyZ4kklxtAsgUvoQ3OWmjNBGLVquT2kX+rNRJrVhftTZ5265Q==
X-Received: by 2002:adf:ec47:0:b0:346:addc:18aa with SMTP id w7-20020adfec47000000b00346addc18aamr6227026wrn.25.1713210431562;
        Mon, 15 Apr 2024 12:47:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709061b1100b00a525492801dsm3168309ejg.119.2024.04.15.12.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 12:47:11 -0700 (PDT)
Message-ID: <15507b66-723d-443c-aaae-c0097d16ef0a@redhat.com>
Date: Mon, 15 Apr 2024 21:47:10 +0200
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
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
 Peter Hutterer <peter.hutterer@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nitin Joshi1 <njoshi1@lenovo.com>, Vishnu Sankar <vsankar@lenovo.com>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com> <ZhXpZe1Gm5e4xP6r@google.com>
 <92ee5cb2-565e-413c-b968-81393a9211c4@app.fastmail.com>
 <ZhcogDESvZmUPEEf@google.com>
 <411e6353-16ef-455b-98fa-2d38bb7bf9bd@redhat.com>
 <Zh2BiqQdM7_n-Ih4@google.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Zh2BiqQdM7_n-Ih4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/15/24 9:35 PM, Dmitry Torokhov wrote:
> On Thu, Apr 11, 2024 at 02:30:35PM +0200, Hans de Goede wrote:
>> Hi Dmitry,
>>
>> On 4/11/24 2:02 AM, Dmitry Torokhov wrote:
>>> On Tue, Apr 09, 2024 at 10:17:05PM -0400, Mark Pearson wrote:
>>>> Hi Dmitry
>>>>
>>>> On Tue, Apr 9, 2024, at 9:20 PM, Dmitry Torokhov wrote:
>>>>> On Tue, Apr 09, 2024 at 02:47:05PM -0700, Dmitry Torokhov wrote:
>>>>>> On Tue, Apr 09, 2024 at 03:23:52PM +1000, Peter Hutterer wrote:
>>>>>>> On 09/04/2024 09:31, Dmitry Torokhov wrote:
>>>>>>>> Hi Mark,
>>>>>>>>
>>>>>>>> On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
>>>>>>>>> Add support for new input events on Lenovo laptops that need exporting to
>>>>>>>>> user space.
>>>>>>>>>
>>>>>>>>> Lenovo trackpoints are adding the ability to generate a doubletap event.
>>>>>>>>> Add a new keycode to allow this to be used by userspace.
>>>>>>>>
>>>>>>>> What is the intended meaning of this keycode? How does it differ from
>>>>>>>> the driver sending BTN_LEFT press/release twice?
>>>>>>>>>
>>>>>>>>> Lenovo support is using FN+N with Windows to collect needed details for
>>>>>>>>> support cases. Add a keycode so that we'll be able to provide similar
>>>>>>>>> support on Linux.
>>>>>>>>
>>>>>>>> Is there a userspace consumer for this?
>>>>>>>
>>>>>>> Funnily enough XKB has had a keysym for this for decades but it's not
>>>>>>> hooked up anywhere due to the way it's pointer keys accessibility
>>>>>>> feature was implemented. Theory is that most of userspace just needs
>>>>>>> to patch the various pieces together for the new evdev code + keysym,
>>>>>>> it's not really any different to handling a volume key (except this
>>>>>>> one needs to be assignable).
>>>>>>
>>>>>> What is the keysym? If we can make them relatable to each other that
>>>>>> would be good. Or maybe we could find a matching usage from HID usage
>>>>>> tables...
>>>>>
>>>>> I was looking through the existing codes and I see:
>>>>>
>>>>> #define KEY_INFO		0x166	/* AL OEM Features/Tips/Tutorial */
>>>>>
>>>>> We also have KEY_VENDOR used in a few drivers/plafrom/x86, including
>>>>> thinkkpad_acpi.c and I wonder if it would be suitable for this vendor
>>>>> specific debug info collection application (which I honestly doubt will
>>>>> materialize).
>>>>>
>>>>
>>>> That's a somewhat disappointing note on your doubts, is that based on
>>>> anything? Just wondering what we've done to deserve that criticism.
>>>
>>> Sorry, this was not meant as a criticism really, but you mentioned
>>> yourself that there isn't anything in the works yet, you just have some
>>> plans.
>>>
>>> For such a project to succeed Lenovo needs to invest into selling
>>> devices with Linux as a primary operating system, and it has to be
>>> consumer segment (or small business, because for corporate they
>>> typically roll their own support channels). The case of retrofitting
>>> Linux onto a that device originally came with Windows OS rarely gets
>>> much if any response from the normal support channels.
>>>
>>> Is this something that is actually happening?
>>
>> Yes, Lenovo is actually offering Fedora as an OS choice when
>> ordering ThinkPads directly from their website in many countries
>> including when ordering as a consumer.
> 
> Ah, very nice, I was not aware of this.
> 
>>
>> And unlike other vendor's Linux preloads which often use a kernel
>> with downstream laptop specific changes these laptops are running
>> unmodified Fedora kernels, which themselves are almost pristine
>> upstream kernels.
>>
>> Lenovo (Mark) has been really good the last couple of years in
>> making sure that their hw just works with mainline kernels without
>> any downstream vendor specific patches.
>>
>>>> That aside, I guess KEY_INFO or KEY_VENDOR could be a good fit (I
>>>> personally don't think KEY_CONFIG matches well), but I would be
>>>> worried about clashing with existing functionality.
>>
>> Using KEY_INFO / KEY_VENDOR works for me too. So maybe we should
>> just go with one of those 2 ?
> 
> It looks like Mark's preference is KEY_VENDOR, so let's go with it?

Ack KEY_VENDOR sounds good to me for the doubletap on the trackpoint event.

What about the new Fn + N keycombo which also generates a WMI
event which we want to translate to a key code to launch a
(to be written) debug-info collecting app for when the customer
calls Lenovo support.

Mark suggested a new KEY_SYS_DEBUG_INFO for that. So do we use:

#define KEY_INFO                0x166   /* AL OEM Features/Tips/Tutorial */

for this, or do we define a new keycode ?

Mark would using KEY_INFO for this work for you.

Dmitry any opinion on this ?

Regards,

Hans



