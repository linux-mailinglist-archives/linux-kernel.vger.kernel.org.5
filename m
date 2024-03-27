Return-Path: <linux-kernel+bounces-121964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F788EFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579061F311AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E65D2D047;
	Wed, 27 Mar 2024 20:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKLZAxmj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568FB14D6E3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711570125; cv=none; b=eMj/9Q9X4WihAoVarQfNlFoXoyrDfmuOG4cC/bgamJMq1m0lsm4A894apT45+ezLRhQSJSlyccWIImA2FF46Y5q5swVQYfE+zj5b1G1ZbI7LNKKDCGnJcDlus/uIApPO2VU8VDl/wyik2pdZeYOXebXAsISWSI9dWmP/ur7R3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711570125; c=relaxed/simple;
	bh=30+SMF3Q4cLn9iLwhMHMGXF2lJwt/e/uG876R4xdZDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiHpTx83SPLGmvJcy5Nxl54P7jQCD0ecvDX68NTvTlffuENwJfJxItbf51y+5M7eepYjT7P6xLOOlqhk09nCIg11yV9hbPt0Bhi+G3wsd6tJ8HFfptoox1V56wPid7RLv94rbuIW8rBRBS2kK+ZqpRDp+GrsQsUe5UrOq4QEaqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKLZAxmj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711570122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+rbOO6Xjs4/MSVYHbBLn8VkYr1ofXwAfF7JXAClqYE=;
	b=QKLZAxmjpaQY97V6LVADqg4B6oSr4ooD0/5ksMbLY2wPzkQfVEg/LslrXDm/Ad3NHb16cI
	HsQbQbvJYAEpuuQNMSmZEKzxscWokWFfa35JliG/sYFu4BmZvNPcaQEGVs0L8WzhaG1P8o
	FgF38EpF4uJNpn4QoEAyuv4GxrPcq2k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-0mMDrPNCOkG28fCL02PhsA-1; Wed, 27 Mar 2024 16:08:40 -0400
X-MC-Unique: 0mMDrPNCOkG28fCL02PhsA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a469d3547c7so21854966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711570119; x=1712174919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+rbOO6Xjs4/MSVYHbBLn8VkYr1ofXwAfF7JXAClqYE=;
        b=NbCWVtb8MXYydEOZcTfKC7HmjeOpF1M57e5KzHa0pOa9xKzSxRWq/MggnHtUZwLZvL
         xbQaAh0vn/qNbEpzz/6ypnnk3jRRDEzsoIxlUM/+UxGrPBX44s4zMyrklAZ8qboik5/w
         D1jYmVIlC0XmMgOXpcwpBDB52z9BiNpI2oQp811QPAjOqxT3Lf2Vj5lLt1gZZ3wHr2F6
         YvGDhuMK32qv2flDqGHbLWLjyyaLW/3nPsziS4/AYcqgP/KYXTSMX7VaRajsTexy7lUW
         65D1uNGpPcUeb7Poc1j12I/69KXI/b8CqVcZrpZVXzpBi/LhZD+Z12HsNyJUERBL+gb3
         YDWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwBLOjVt0aR8WEbn3gt9PV1+DxltvMtiWkNTesiVp8GhyPdByEX/fu6jDNZZLEvWooIce4bNo1+4dkf/ruamN32iymE41Bt/cez023
X-Gm-Message-State: AOJu0Yxsbq9rSN7LzVxxmi57Xe9XigsG+jWA90wY4KeOHpvA6ZaWnBq8
	iglzeIPNn1T0ufEDPoKk4zx8LgAttNA/BTybmu95VuuQblmIrQYqwV5gSAN/sOiXQ18bDNsngVP
	1/Z9mCvBV2LIqat1kio4bpjHymEjA4dY/5lY1P42OpFd+IcS2hxFb6MSGaDI9Zw==
X-Received: by 2002:a17:906:bcda:b0:a46:ebe6:742e with SMTP id lw26-20020a170906bcda00b00a46ebe6742emr306731ejb.23.1711570119672;
        Wed, 27 Mar 2024 13:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRPseT862/dYHMWEZUySiGhxw6iMcjeUjM2enE0KH2m9DZecWpuyWTRPHl2YQ5pmnSH+a0zw==
X-Received: by 2002:a17:906:bcda:b0:a46:ebe6:742e with SMTP id lw26-20020a170906bcda00b00a46ebe6742emr306716ejb.23.1711570119373;
        Wed, 27 Mar 2024 13:08:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id hj13-20020a170906874d00b00a474ef94fddsm4790814ejb.70.2024.03.27.13.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:08:39 -0700 (PDT)
Message-ID: <adc4d0b8-412b-42b0-94fb-96bd6c23bb83@redhat.com>
Date: Wed, 27 Mar 2024 21:08:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] platform: x86-android-tablets: other: Add swnode
 for Xiaomi pad2 indicator LED
Content-Language: en-US, nl
To: Kate Hsuan <hpa@redhat.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
 linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org
References: <20240322033736.9344-1-hpa@redhat.com>
 <20240322033736.9344-2-hpa@redhat.com>
 <bb7536be-9bed-4557-b111-6409ebfe48f4@redhat.com>
 <ZgGm7eDBQtwH37ya@smile.fi.intel.com>
 <CAEth8oEps=T3JGJiCEH_SknjkcGaTXv+ekBQLgVRm+Nc7qfa1g@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAEth8oEps=T3JGJiCEH_SknjkcGaTXv+ekBQLgVRm+Nc7qfa1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/27/24 7:09 AM, Kate Hsuan wrote:
> Hi Hans,
> 
> On Tue, Mar 26, 2024 at 12:32 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
>>
>> On Mon, Mar 25, 2024 at 04:02:54PM +0100, Hans de Goede wrote:
>>> On 3/22/24 4:37 AM, Kate Hsuan wrote:
>>>> There is a KTD2026 LED controller to manage the indicator LED for Xiaomi
>>>> pad2. The ACPI for it is not properly made so the kernel can't get
>>>> a correct description of it.
>>>>
>>>> This work add a description for this RGB LED controller and also set a
>>>> trigger to indicate the chaging event (bq27520-0-charging). When it is
>>>> charging, the indicator LED will be turn on.
>>>>
>>>> Signed-off-by: Kate Hsuan <hpa@redhat.com>
>>>
>>> Thank you for your patch, I've applied this patch to my review-hans
>>> branch:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>>>
>>> I will also merge [PATCH v5 6/6] platform: x86-android-tablets:
>>> others: Set the LED trigger to charging_red_full_green for Xiaomi pad2"
>>>
>>> Once the new power_supply trigger patch this relies on has been
>>> accepted.
>>>
>>> Once I've run some tests on this branch the patches there will be
>>> added to the platform-drivers-x86/for-next branch and eventually
>>> will be included in the pdx86 pull-request to Linus for the next
>>> merge-window.
>>
>> I believe I have commented on the "RESEND" version.

Right, sorry. Since there were just a few trivial comments
I've fixed them up in my review-hans branch now, thank you
for the review.

> Thank you for your reviewing.
> Please review the RESEND patch and I'll fix them according to Andy's comments.

No need to do a new version I've squashed fixed for Andy's remarks +
Andy's commit msg remarks into the version in my review-hans branch.

Note I'm going offline for a long weekend and I won't be
replying to emails until next week Tuesday.

Regards,

Hans



