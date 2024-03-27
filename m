Return-Path: <linux-kernel+bounces-121948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDFA88EFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA6C1C33478
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B03D152517;
	Wed, 27 Mar 2024 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQGNM0bk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC5314F9E6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569831; cv=none; b=k+yWvKSaKccJumUAfXMmIxxowPoJfhcFbiw8WNcIEE0yA0PUbKN5XwaACU4Nc86NKKEhP41xMTnZvRBPwzasETBUcshrhQP8gYc/QtV2EaQkdZslZyVe76b312N+LWNt0pooBEYw+uvTdqrNb3ig7bn6+H5CZYcLjV2q1InFLBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569831; c=relaxed/simple;
	bh=t12owULa2Uk3B4uxPPmsB4a79oGho0TYNcWr/T2cVIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQwUbvRMpk/xvmOEO9l2+zRlEURl+/NpSvWm7dHQ35SZN23MBkj0i+Ms7O6yEq5k1w/6irK7EOJa9JAFyqnyI5hiPD6aQobajAw7xMW72SizHch3agx3xfbI0Q9D2+rColHPKvVjQkhJSUH92Q525b9TVHtyOJfkgDS/WKX8TzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQGNM0bk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711569825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5gtlylC0qzrEzSYUPIkmlPoES5wXwK/DFLxhK4lKIc=;
	b=RQGNM0bkrdgzQc2v7fFvxEeX55IjbQ063oy1W3wKyP249hYzvDVUj/bGRLeqNkbXokI/GY
	XxH1u6C/jnYLRQ0I/ZTJJ4T/85iwDtWcLK2+P3Rhv+O1uyw+OW5/ZjBJ/vvicX8iecgsLO
	y8TwydpkfeCDgV33jhFm6vs7lj+4LM8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-FcaLx51aPdq3QKZiU3rxLQ-1; Wed, 27 Mar 2024 16:03:41 -0400
X-MC-Unique: FcaLx51aPdq3QKZiU3rxLQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-513e31aef6cso93610e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569820; x=1712174620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5gtlylC0qzrEzSYUPIkmlPoES5wXwK/DFLxhK4lKIc=;
        b=Uw1aFT/YQbQm36z5EPNrH90LrJ96fSa+/nyS/7xnFTA4YM7KdYbtMTsXa3xM8IiLzI
         BKrp8Wehzc7H4vpwT/mbZfBRf4ZxDcv1p6LspRSTXNEcY1xTrxfc3NX91vDeY62jN+Qd
         fDpn6MLfIcJQYK/DhCvLMBDIUtZ0+JUrlGcjAQmwK+Se+JtvAPfu4e5iEY22vb9jirDb
         P9GqbjW3uHWp+gGceG0gsIGrXS163uRArEX2suvlgVxAjHx0DhwrQlXDnK0Gq19lCC8x
         rGyNm2lXV8DuwSyuZ7eUmpUEcM6bleq12p2AoF7R/I65uDY4ArUF64OwpyxmfRbcHlBZ
         SXHg==
X-Forwarded-Encrypted: i=1; AJvYcCXmKzINFSeSyNxPE9zjTYC+J+L+Uy8aufSi9BnEJnejgWFHyjd2ouSv4r8CZIGNMKhRa+KnRNzjWbXDkBfHXVJs5jzNnPZrEJF+WpWn
X-Gm-Message-State: AOJu0Yyy416YIzptUNl9R4azGjEseFXtAM6mPB62w4/aTk14n9lJCz2Q
	7pf6UojRqWz1xwW13P7Cxrn/0+2AXigAdG3rNO3JBvheVx48T/px4YIDky7zvjqtzbZPHA9jp5T
	GNP49tbyy9l830Xd+lnwAGS3kjPF74ozqkzeVYE4dSP/eSm28NDqDhFbIA7PmBQ==
X-Received: by 2002:a05:6512:52b:b0:513:226c:651d with SMTP id o11-20020a056512052b00b00513226c651dmr448050lfc.2.1711569820061;
        Wed, 27 Mar 2024 13:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgOaSquNs/XdTRHz1ZCegoSjmGEMwnfQhgHJRMfn2tZOUBOK1WoIRggVRj1OyU/ET5d7bPfQ==
X-Received: by 2002:a05:6512:52b:b0:513:226c:651d with SMTP id o11-20020a056512052b00b00513226c651dmr448028lfc.2.1711569819620;
        Wed, 27 Mar 2024 13:03:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090609a200b00a3efa4e033asm5796770eje.151.2024.03.27.13.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:03:39 -0700 (PDT)
Message-ID: <4b6aa3ef-82f1-43d4-9544-89f591f49e41@redhat.com>
Date: Wed, 27 Mar 2024 21:03:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] platform/x86: add lenovo wmi camera button driver
Content-Language: en-US, nl
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: =?UTF-8?B?6Im+6LaF?= <aichao@kylinos.cn>,
 "ilpo.jarvinen" <ilpo.jarvinen@linux.intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 platform-driver-x86 <platform-driver-x86@vger.kernel.org>
References: <je8phmmtfz-je9zfg1v9s@nsmail7.0.0--kylin--1>
 <030beaf8-12e1-400a-b064-f17384e32714@redhat.com>
 <ZgQbz5pBTuY64pNF@smile.fi.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZgQbz5pBTuY64pNF@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/27/24 2:14 PM, Andy Shevchenko wrote:
> On Wed, Mar 27, 2024 at 11:54:55AM +0100, Hans de Goede wrote:
>> On 3/26/24 3:54 AM, 艾超 wrote:
> 
> ...
> 
>>>>> +config LENOVO_WMI_CAMERA
>>>>> + tristate "Lenovo WMI Camera Button driver"
>>>>> + depends on ACPI_WMI
>>>>> + depends on INPUT
>>>
>>>> No COMPILE_TEST?
>>>
>>> I compile this driver and used Evtest tool to test it on lenovo A70.
> 
> What I meant here is to add respective COMPILE_TEST to the dependency(ies).

Neither include/linux/input.h nor include/linux/wmi.h offer
stubs when disabled so this will not work.

Besides x86 has a lot of compile test coverage in general,
so I don't see much value in adding || COMPILE_TEST to
dependencies.

Regards,

Hans



