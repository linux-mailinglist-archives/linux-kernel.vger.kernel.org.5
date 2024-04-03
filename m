Return-Path: <linux-kernel+bounces-129341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DFD8968C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E052856E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B152F873;
	Wed,  3 Apr 2024 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjkhvEZh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907C519470
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133187; cv=none; b=oHqBGGHmMR0UM7U+XOGgrr9akGM00gPKa1g1HOkzwh6HkfBZIqhsIKkM/hFw5aOWdv+i8Nb2GzgTAf8opLFddPUsjGo6lBtRNxIxERujo8DSBUVD8ZzJD51R5LXwGgTgxWIUu0u5SRM3ywPbgHrflEs8qM/JcEtzfxkl9e8NQp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133187; c=relaxed/simple;
	bh=2Z+Ejko7FofGkIpI4wJ7ZPsjyB8mCnSvFfx+1YEfT4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQksMHsHdpOzgSrSxtbTdQtEiQB7zX/aGvl0mTShDR78YrzFkJ4uI5xAOleN/8lrJ+/SeDvHm4zD2yVo7MIEc4bwHvq0DCsqvluSCbrP5NmlL3wJAtm1QPi9+tNDfeSlejyHx9C8XUIEzsiA/F95TqbLdhNtI8oWj4JzRqGY8nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjkhvEZh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712133184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hBwVccZBg0Fl5p97DfphA9YXGRXtnSdOSqA1Wworgs=;
	b=DjkhvEZhGrkB5nVC4eboxXbfrk7ypn5nOcfrV/avO+aoR3dtges1V1zXe5+oJrqet3vPk6
	nbkt4GCl2dJqyxeMZqdPsjU1LY6UD54jWUO1gp90i8v21B8mStM24d/RNdKXsHVare1EJj
	+QSoG1hQtpr1XbQtLWfzuSIc0XB5zOg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-T1LrbgAYNlClX5gUwdV2jQ-1; Wed, 03 Apr 2024 04:33:03 -0400
X-MC-Unique: T1LrbgAYNlClX5gUwdV2jQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a4dfdbdaf06so347714966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712133182; x=1712737982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hBwVccZBg0Fl5p97DfphA9YXGRXtnSdOSqA1Wworgs=;
        b=b6JKMrhn+fh6J3Nv1lD0T+C/9kPvrx4ZBAHv+OY/BVaMira95ndfTe67qiU6+gygLQ
         j9K5dXaYzoRbQh3vHF8/1Tc8+rdvlabyadXSkTwuWV4Sq5heHClVRZXk6teAXc/TmnK3
         JE4+VWs/YNh6ob3uhVzxJmp8rzA4KQZvY7i+8GUBEoOAxH+htxYmJa3oxWIsnEX/WFrr
         1qDAZGW978CQcYySi9tusuk2i2EGCpE50CAAq2u1xksnOpJtCIO7yxUjSxMDLGGdcY8m
         x9ZhW8M1+KYhKTAL/MLWfHb/lZ1JqtY5CZyaGszE3xrmn3tH3SCIfCJ2Qw+oqGt/1P4t
         qsNw==
X-Forwarded-Encrypted: i=1; AJvYcCX9VH9+EtdmoM6kaLFJOgvoA1+UdkiuLvLJ0AwvUndsgplfow7w9WrBNyXgAWA/DkjeaqhqtdWZk8WMTVFAdg0e4TkZfGC1+IxfYj5G
X-Gm-Message-State: AOJu0Yzn3ZvWqRvgUWVmoyBnPxl82J4QdFhqrg/8Y7qJDmvSMWvkgACh
	08IsfPAd6pG8li9QRk4qQgEw06UIOx+u/2O7pyOIZeGU55QBigAt2D9MjccOctMADOnj+nPUWLg
	WQ2Hk2IXsrb16JWFcjjnN0yD9ABPVeBj0CMoMyKYJq4C++6zvdrjBUyfDboSNtXDnVmJnNw==
X-Received: by 2002:a17:906:1157:b0:a4e:6414:5afd with SMTP id i23-20020a170906115700b00a4e64145afdmr5759443eja.52.1712133181940;
        Wed, 03 Apr 2024 01:33:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUYrX1YOrnmR10vdbq+ufbRk4BHlYYJBSP3DuH1BuQ6YlKfpjx3idfoB6rTEHjFrNn1Q5mmA==
X-Received: by 2002:a17:906:1157:b0:a4e:6414:5afd with SMTP id i23-20020a170906115700b00a4e64145afdmr5759429eja.52.1712133181648;
        Wed, 03 Apr 2024 01:33:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id jx24-20020a170906ca5800b00a47152e6d10sm7426027ejb.134.2024.04.03.01.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 01:33:01 -0700 (PDT)
Message-ID: <283b5056-29df-486f-8a4a-5271af8a5b8c@redhat.com>
Date: Wed, 3 Apr 2024 10:33:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: leds: add LED_FUNCTION_FNLOCK
To: Gergo Koteles <soyer@irl.hu>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Ike Panhc <ike.pan@canonical.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1712063200.git.soyer@irl.hu>
 <8ac95e85a53dc0b8cce1e27fc1cab6d19221543b.1712063200.git.soyer@irl.hu>
 <6b47886e-09ac-4cb9-ab53-ca64f5320005@linaro.org>
 <5864594aa47ecfeb23d5d05a3afc02393f84b44e.camel@irl.hu>
 <a19688d3-5402-41c0-b10a-131cefed5b91@linaro.org>
 <2710283677cf12ca6b826565ec39652f560a43d8.camel@irl.hu>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2710283677cf12ca6b826565ec39652f560a43d8.camel@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi George,

On 4/2/24 8:50 PM, Gergo Koteles wrote:
> Hi Krzysztof,
> 
> On Tue, 2024-04-02 at 20:08 +0200, Krzysztof Kozlowski wrote:
>> On 02/04/2024 16:36, Gergo Koteles wrote:
>>> Hi Krzysztof,
>>>
>>> On Tue, 2024-04-02 at 15:55 +0200, Krzysztof Kozlowski wrote:
>>>>
>>>> Do we really need to define all these possible LED functions? Please
>>>> link to DTS user for this.
>>>>
>>>
>>> I think for userspace it's easier to support an LED with a specified
>>> name than to use various sysfs attributes. LED devices are easy to find
>>> because they available are in the /sys/class/leds/ directory.
>>> So I think it's a good thing to define LED names somewhere.
>>
>> You did not add anything for user-space, but DT bindings. We do not keep
>> here anything for user-space.
>>
> 
> The LED_FUNCTION_KBD_BACKLIGHT confused me. Ok, this shouldn't be here,
> I will remove it from v2.

I don't believe that is necessary, see my direct reply to Krzysztof first
email about this. According to Documentation/leds/leds-class.rst
you did exactly the right thing.

Also thank you for your interesting contribution. I have only briefly
looked over your other 2 patches, but I like the concept.

I'll hopefully have time to do a full review coming Monday.

Regards,

Hans



