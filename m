Return-Path: <linux-kernel+bounces-138376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7A689F04B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE8B1C21E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3566B159583;
	Wed, 10 Apr 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8oHfyKF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7B6157E6E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746828; cv=none; b=tuC+eTD8mORuOE+h/pWw0BG9pjSZWevQQyFio2RozmA2HFW4dTJlyLLVuWPWYg9w/mowzaybCPKV0/bOZjWPRsq270VxKVQKLGnA6+8n8702/Nu5qgFgWW2x3NbBLOlZU9FVegwax5LsPYv98OQzqaUS7Txn9bmLxutvvAUOpO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746828; c=relaxed/simple;
	bh=TRbv3m5WRpUW/kPuUQ9Lt5c9hgvwOcwmU6Rb0Cht/0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQWhewmk7ed73u4B+4ihwYoCixnDZJ/vF8rtNUE57RiKGy629c3fXwhFaHuXTRY4kwkap16og2kUHyhgNDn1WQDzVAsGc+ZgzCc4Xx+XT6ZIo90rC6wFrF6+nnGbUm5OUpXbiRmzC8VzPqT6Rwr2mj5iQQt+YvSUga3kzoS1Duo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8oHfyKF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712746825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FAN6eh8bu67NKq/ARd7vlUpySDLdLJHrs4fZKNdTOc=;
	b=C8oHfyKFwSOpfw5iGaofXnVrrjvhOXztA3zU/dDqWZBEDDW5EArU05LcSCumj9aTRTqP+n
	XGcWRtdjcHuiYBBN8d5k/nlRWvU/wjv4jUAKsVFUWTmf1xZ3CAZ/rbCLc8GPE4RKbsIi1P
	aCWBqNc/MB5MEaIrUPGXghtkX7epsI0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-7NvKzKyAOnupm23v-PL2hw-1; Wed, 10 Apr 2024 07:00:24 -0400
X-MC-Unique: 7NvKzKyAOnupm23v-PL2hw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-516d754664dso3751108e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712746823; x=1713351623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FAN6eh8bu67NKq/ARd7vlUpySDLdLJHrs4fZKNdTOc=;
        b=hRAaHTggGcymuNcdq7hgtIeVUE2h+54M0HZyWDR+mP4RtCeoQVKSVY60bz0jkqc2w4
         4lzFJj58Phaq2hG8EBlSkHmapVBWwpHeO0YD8ud5S49VG/G7VAshmeOYLrJGCIGKILNj
         Drj26N/3FctnEIXc1GeX1GjrYFnj6tMKa1eO6SNUHAjL11i9jJhTRCrBgXm2on134/vd
         mAB/kKYr1SGJMTlvcjckzYPVT7q5c3e02YMwDd77pPzTy3LWMpMHkmd/Zo99ntEp+1cP
         UxGD4P1lnfLl32dEwL/4yEWNQtBq+np9bklT+HX0ZvhjcnPiJI2oxihV+yl4wamFlsiQ
         zkPA==
X-Forwarded-Encrypted: i=1; AJvYcCWK5l/QXyPGLfrtoXiWc594sI5W+7Chumpo5o0/4r/TSeqPBu/4tUEArQL1CHxE22oNvN9NbXakss88hU0JZxc0TNIldKhwjQOcvqNB
X-Gm-Message-State: AOJu0Yx+Lq6neO01chJGYte9K1G0FxRwLwxQiU6gNw1pCFIlf4Z2jlSX
	BBjc/cW9dmtwYTrAB683GjqDcWTmXrAlRUxnn19R2mMk9jzqPgo4PR3h3ipe1XqJcLt+G8GLc1B
	sMtr+ENIIlNyZa3U1JGUQHvEWbwHNJR3lBcZ0J9FmO9GYeuH4ls0QvowJvca9Yw==
X-Received: by 2002:ac2:4213:0:b0:515:8c3e:5665 with SMTP id y19-20020ac24213000000b005158c3e5665mr1549501lfh.27.1712746822805;
        Wed, 10 Apr 2024 04:00:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtRBcodkfAPVzHzR6rAgLYuyNguGaz5aoTqXtK2sLX0oISN7HiFpdxmAXTvLXYwNeQOn8Lvg==
X-Received: by 2002:ac2:4213:0:b0:515:8c3e:5665 with SMTP id y19-20020ac24213000000b005158c3e5665mr1549484lfh.27.1712746822304;
        Wed, 10 Apr 2024 04:00:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ak2-20020a170906888200b00a51dccd16d9sm3222697ejc.99.2024.04.10.04.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 04:00:21 -0700 (PDT)
Message-ID: <a510f246-1f3e-4674-9825-e1dee11c3ee9@redhat.com>
Date: Wed, 10 Apr 2024 13:00:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] platform/x86/intel: atomisp2: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240403105511.558395-1-andriy.shevchenko@linux.intel.com>
 <609652ce-0336-4d69-ab79-f84c8a8506e5@redhat.com>
 <ZhV3zUgZjAMUZ0yD@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZhV3zUgZjAMUZ0yD@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/9/24 7:15 PM, Andy Shevchenko wrote:
> On Mon, Apr 08, 2024 at 06:20:03PM +0200, Hans de Goede wrote:
>> On 4/3/24 12:55 PM, Andy Shevchenko wrote:
> 
> ...
> 
>> As mentioned in the description of DEFINE_RUNTIME_DEV_PM_OPS()
>> DEFINE_RUNTIME_DEV_PM_OPS() is NOT a 1:1 replacement for
>> UNIVERSAL_DEV_PM_OPS() specifically it uses pm_runtime_force_suspend() /
>> pm_runtime_force_resume() .
> 
> Right.
> 
>> Specifically pm_runtime_force_suspend() may NOT get set (and in this case
>> will not set) needs_force_resume skipping a resume + suspend cycle
>> after a system suspend, which is a problem if firmware has touched
>> the state of the device during the suspend/resume cycle since the device
>> may now actually be left powered on.
> 
> I see, thanks for explaining me this. So this driver is kinda very special.
> Still the old question, can we get rid altogether of these atomisp "drivers"
> in PDx86?

At some time in the future yes. I've recently done some improvements to
the staging atomisp driver so that it will run in a pm-only mode when
the firmware is missing so that the ISP still gets turned off properly
in this case and the driver now supports both BYT + CHT in a single
build so in a way it is ready to replace the atomisp2 pm driver.

But it is still in staging, so distros are unlikely to enable it
and without a atomisp2-pm driver the battery drains much to quickly
especially when suspended.

So I think we are getting there, but now is not the right moment
to drop this driver.

>> It seems there is no direct replacement for UNIVERSAL_DEV_PM_OPS()
>> without a behavior change.
> 
> Correct.
> 
> ...
> 
> Btw, have you seen a few cleanup patches against AtomISP v2 by me?

Yes I have a bit of a backlog, I have just processed them,
thank you for those patches.

Regards,

Hans







