Return-Path: <linux-kernel+bounces-129336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64D28968B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643781F2A72A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D19C6FE1D;
	Wed,  3 Apr 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZO5xMyxc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0BC6F076
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133087; cv=none; b=vEmpG12ISPWEXRKFF6rtBBCiwoT18hT8212mxIlEQKmSzCwrmURGVxjCKOd7d8lo0lZOzwRSiAwQd/QgAbY4ABS08iOAHcvLYphzkcaOH0nVLXuGBnqGs76CMlX4kvYFeVyVBwvbZujIDLxs1jcT8ZKqcL9E4UwxBQIbg9mlP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133087; c=relaxed/simple;
	bh=+vVNIkL30xXBEaWxi3EBVw+q/A/bX52+6zrF25jw+3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXGUuUGS5PTqG/WaBHKbvm+OTlDwpWf3pX8VDyV4OYMMg8fJ04gpntJwWabOwPTQSy07ZDM1ITe5M2FimqlQcKrelhmEmKtn6doc2toMzw0nFUkdfjkh1I6JjrC7IYsW3AvUQkCnd6a4JxfyIRzb7bZQenbahwtKu6vG+iQVeMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZO5xMyxc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712133085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLWFcXSG4rlX1A4JD4WkEdD7OkmVurYSG5NUffi+fW4=;
	b=ZO5xMyxck1e802xbMuXhfyzWWTvgghC0oChDLU9I7FdHNYU7df3ISC+hYoyWzWBe/AkdFQ
	5GNJUVKD49hpFEQoX9Bij2dqv7LhGdxrIn5IoVLotosU34Kcx26acdmfirfisNcUXQDy0t
	EFIVrjbB7Iiwr/DodODJi7vwagf+Yqo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-khcJ4ZyDNpSELUIaSVbj5A-1; Wed, 03 Apr 2024 04:31:22 -0400
X-MC-Unique: khcJ4ZyDNpSELUIaSVbj5A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56c079c74d1so2802483a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712133081; x=1712737881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLWFcXSG4rlX1A4JD4WkEdD7OkmVurYSG5NUffi+fW4=;
        b=AR/NMMayMC4gUWMJD9LQ7FcX4vhwWshSqtmH6YoBBkbNiQj8iE8a0yfG2y5BxX6KM9
         lhSqgKohmPu44tfJiFfQaaANvtkNLlnxwbnitwBCFE2dtwcWXMXKPpptZjZHyhICDxC/
         BThAXlj3n+qOo5jg8ZttQJj47z6e6+cnJKpOc8uexPspFLranRRx/7ntIkpYwi7PGj5N
         bPyGA/ytOqRRjJgkIMcn6ZbrlHN+wQLiAtKHqfhUOLCs/Fk0bVOwuLy/m428hWb1dlLs
         qmIu91a6TY0wpw90k6cV9iAstkJRelLB8vJdV13PgtaiAbw518I/8sVbdKTraJ/uwqzO
         YL6g==
X-Forwarded-Encrypted: i=1; AJvYcCUj4S/bs3w16sleuMnyNscX/9mpqi1ry3WEzwd2zBw+hvqklGqwdIbBI/0SlHzXalb7A2b7A2dUX6mwPYnjGkiawbwqAYI7oijxi0ef
X-Gm-Message-State: AOJu0Yx90FXbMIrdL3t6N/h0+Vfm1tUMWX6MeEnEg606q1F0NvnMKimp
	CCiGsimVB1BS/RhgILhNUhzXUT3TSzvAYYp/ovomk68oPyDIMiVwRz5IvpGrWS/h+jTVup3/X20
	AKavHzqvVr4jtALJf5eFimfsQdkMnRl/AvoKBt352MbSwTBm/UA8RI/ncAvhRcw==
X-Received: by 2002:a05:6402:254a:b0:56b:e089:56ed with SMTP id l10-20020a056402254a00b0056be08956edmr14504317edb.39.1712133081180;
        Wed, 03 Apr 2024 01:31:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEVJhrcQkid/ww0Wnkt8Pd/Xp1RBCh4HcViBRk6/ugNOQ7Eel0eDd8Ak45ekBXiFn9o3cr3g==
X-Received: by 2002:a05:6402:254a:b0:56b:e089:56ed with SMTP id l10-20020a056402254a00b0056be08956edmr14504269edb.39.1712133080261;
        Wed, 03 Apr 2024 01:31:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id cn20-20020a0564020cb400b0056dfc8d12fasm820692edb.21.2024.04.03.01.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 01:31:19 -0700 (PDT)
Message-ID: <39acb3b9-a69f-4654-9749-a9af42fea39e@redhat.com>
Date: Wed, 3 Apr 2024 10:31:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: leds: add LED_FUNCTION_FNLOCK
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Gergo Koteles <soyer@irl.hu>, Ike Panhc <ike.pan@canonical.com>,
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
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6b47886e-09ac-4cb9-ab53-ca64f5320005@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 4/2/24 3:55 PM, Krzysztof Kozlowski wrote:
> On 02/04/2024 15:21, Gergo Koteles wrote:
>> Newer laptops have FnLock LED.
>>
>> Add a define for this very common function.
>>
>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
>> ---
>>  include/dt-bindings/leds/common.h | 1 +
> 
> Do we really need to define all these possible LED functions? Please
> link to DTS user for this.

It is useful to have well established names for common
LED functions instead of having each driver come up
with its own name with slightly different spelling
for various fixed function LEDs.

This is even documented in:

Documentation/leds/leds-class.rst :

"""
LED Device Naming
=================

Is currently of the form:

        "devicename:color:function"

..


- function:
        one of LED_FUNCTION_* definitions from the header
        include/dt-bindings/leds/common.h.
"""

Note this even specifies these definitions should go into
include/dt-bindings/leds/common.h .

In this case there is no dts user (yet) only an in kernel
driver which wants to use a LED_FUNCTION_* define to
establish how to identify FN-lock LEDs going forward.

Since a lot of LED_FUNCTION_* defines happen to be used
in dts files these happen to live under include/dt-bindings/
but the dts files are not the only consumer of these defines (1).

IMHO having a hard this must be used in a dts file rule
is not helpful for these kinda files with defines shared
between dts and non dts cases.

If we were to follow this logic then any addition to

include/uapi/linux/input-event-codes.h

must have a dts user before being approved too ? Since
that file is included from include/dt-bindings/input/input.h ?

TL;DR: not only is this patch fine, this is actually
the correct place to add such a define according to
the docs in Documentation/leds/leds-class.rst :

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




1) These defines are also used in:

drivers/hid/hid-playstation.c
drivers/hid/hid-nintendo.c
drivers/platform/x86/ideapad-laptop.c
drivers/leds/leds-cht-wcove.c
drivers/leds/simple/simatic-ipc-leds.c
drivers/leds/simple/simatic-ipc-leds-gpio-core.c




