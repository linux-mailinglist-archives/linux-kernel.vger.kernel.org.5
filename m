Return-Path: <linux-kernel+bounces-36831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2509883A777
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BCB29247C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61D71AAD1;
	Wed, 24 Jan 2024 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FeMq+69Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616FB1AACC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706094376; cv=none; b=qjdtHbeVrZndPZH+bj7DAIBr+RPhAlbKTL2zIKPQqeywRdOrQJzMBGvBVE74bQf+Od/DxwF7MZtA84EdFLOMKL5tRdZ2bqeDozllVEzlKUe4DvcaIQvzzD6XJ20JaaCl8LyAR/bHwbT0lNbuVZva2xowPlLe1spFCNE3WrYIFGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706094376; c=relaxed/simple;
	bh=lbRlx22GKCgPiH7cIlxRfV65Lb8BPEI54cwvB3zTRrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spZqlgRH+Wdf67eBu7kkgrrLPl687hl9I1aHvr8hJTpuz89+qenf+UF7cem7xRy1tjBQjtX+8TUzKI0u9AQz39Dz+hOrLVzTJvhsp727lJJDDqJWZHS6jQ883ORWu1r85qLdSASM+trhDXsmrfJX5qvKOqrESLZIABux5fIdv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FeMq+69Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706094373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEJsj9s6UrZVU9HHKu9/sQKaLBA5n9/ZMGfPfZAh1VA=;
	b=FeMq+69Y0RsoXBRJnpuQNbyqvp1Sz/1R/pAtLkqF7eGCT5QQWFcvGLvpOBqn7jgIdnpN8d
	ogdOn18D2QUavYPgBK1CWrOXmKuF0SeJqYVcD0Qp6GnZrg+DSNSwSCW1/xVFIYdNz9KwFS
	XbFlUxfU8zk5cz3vvPxDRY0UDNCxJmY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-WRrYNEJnMP6SMhvBj7-7-g-1; Wed, 24 Jan 2024 06:06:10 -0500
X-MC-Unique: WRrYNEJnMP6SMhvBj7-7-g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2d1e1fa245so236559666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:06:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706094369; x=1706699169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEJsj9s6UrZVU9HHKu9/sQKaLBA5n9/ZMGfPfZAh1VA=;
        b=B55JvG/5z3TQQoisxrqXjjVoRsPwBq+TJjvUtEmIRhIPLlUSJ95hdumtV6EEFKPMTB
         OH428k5E349NQzyd7gYi9VLzvEcSW5VTR2QGnFZOQZ8iOqAiigGl1YDC/JNIq77aEodN
         GoKNDulPAiBIs3CS//uwvEBtxIvyM2koZA20fYHU0Ge/OrsAi+v9BZLZKy8n/rzcbFYu
         Srsp8X2hJGXPpSxBCMRgXZmz3NxaRqe6feZ3tu2npoZgiJ/ZKYsv0NoCOZ1Ba6Fr1nmq
         NX9a4SrfwXOUGvwtiTEJekrXzOSjVlarYPASD4aOKY2wrSeOHiMfIF5FmICfO92SDcRO
         Gmhg==
X-Gm-Message-State: AOJu0Yzc9wuKTc1m0Gw9vW5p/G3ONcvbanDJKRvjciIUND2IUtQn7uiO
	cKEj87DTaUlGBuoy41McEZY2ETQNyq4dgXr5nke8U/t5ovAb1p6p8dGQV/pkyhe1nMz/o9f7j+9
	DBvzLeU3F508neZRFIKyJvWB9bDTv7tpHJDuzwGyTWEev5vcLb7PPLn/Fm50RAQ==
X-Received: by 2002:a17:906:3747:b0:a31:11d0:bf2 with SMTP id e7-20020a170906374700b00a3111d00bf2mr317088ejc.248.1706094369293;
        Wed, 24 Jan 2024 03:06:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4BTv3TZFjjSvIF5n95JYvtKyHGRetIQJx7TTAZ+OdsiVjrozN30qHTHlxx+Lhe5c7P5lbZw==
X-Received: by 2002:a17:906:3747:b0:a31:11d0:bf2 with SMTP id e7-20020a170906374700b00a3111d00bf2mr317084ejc.248.1706094368974;
        Wed, 24 Jan 2024 03:06:08 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id vt11-20020a170907a60b00b00a310c9d0cb9sm673255ejc.121.2024.01.24.03.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 03:06:08 -0800 (PST)
Message-ID: <b057d7fe-aad1-4fc5-909d-6f45ff7969eb@redhat.com>
Date: Wed, 24 Jan 2024 12:06:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: wmi: Use ACPI device name in netlink
 event
To: Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240121200824.2778-1-W_Armin@gmx.de>
 <1862d74a-7b15-48e3-896b-30dda835f28f@redhat.com>
 <61d23b7d-8e47-acf8-f3b7-bea1544ca8fa@linux.intel.com>
 <f07b3156-2bc8-49bf-bc08-e40209b89cf1@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f07b3156-2bc8-49bf-bc08-e40209b89cf1@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 1/22/24 16:03, Armin Wolf wrote:
> Am 22.01.24 um 13:47 schrieb Ilpo Järvinen:
> 
>> On Mon, 22 Jan 2024, Hans de Goede wrote:
>>> On 1/21/24 21:08, Armin Wolf wrote:
>>>> The device name inside the ACPI netlink event is limited to
>>>> 15 characters, so the WMI device name will get truncated.
>>>>
>>>> This can be observed with kacpimon when receiving an event
>>>> from WMI device "9DBB5994-A997-11DA-B012-B622A1EF5492":
>>>>
>>>>     netlink:  9DBB5994-A997- 000000d0 00000000
>>>>
>>>> Fix this by using the shorter device name from the ACPI
>>>> bus device instead. This still allows users to uniquely
>>>> identify the WMI device by using the notify id (0xd0).
>>>>
>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>> ---
>>>> Changes since v1:
>>>> - use acpi_dev_name() helper function
>>> I'm a bit divided on this patch. I agree the new way of doing
>>> things is better, but technically this is a bit of a userspace API
>>> break.
>>>
>>> I guess we could hope that nothing depends on the old netlink API
>>> format / name but I'm not sure we can rely on that ...
>>>
>>> Ilpo, Andy do you have any opinion on this ?
>> Hi Armin,
>>
>> Have you tried to conduct debian code search to find the code using this?
>>
> I did, but i found nothing.
> 
> I am also preparing to properly initialize the device_class field in another patch,
> and this also has the potential of breaking userspace if some users created custom
> acpid configs to listen to those events.
> 
> I think we can revert those changes anytime if someones turns out to be actually depending
> on them.

Based on the above I'm willing to go ahead with these changes, with
the note that we need to be prepared to revert this immediately if we
get any reports if this breaking userspace.

Given the (unlikely) potential breakage I think it would be good
to get this change into linux-next soon for maximum testing.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





