Return-Path: <linux-kernel+bounces-135701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CBC89C9F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B4F284B0E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA29142E6C;
	Mon,  8 Apr 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9j4HMk/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15551428E3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594506; cv=none; b=NUZMaFx8d0ijV8UQzZNb4k3YpXy2KpCZCq3trQzCWwdRct9acrhxbco++1LaXsh8MWv3zLzrBLZTzEPotPgg0WenSyY9Npxl//eAw4XV/ny+5IOHvN7HU4/Hwg40pwIlEbqzYOhNqMKylgpJ5618+F8onEbuNORIHUamqZ+ZI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594506; c=relaxed/simple;
	bh=sWYvE4qmq7hVzJ0dCGaTIE5eJLwFeKcC0+RULiRIeaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RivRQE0FgM5XKTPmjeeE1QjVmQGnKYwCMkShZWitcHpR7Ft6pyUjFReAopAVt7Ooqx1pi5Tk7ASt9XGOyOcRfg+J7rsS6YgWsnBgKnftYMgHOycTqrmIpeyzYJUYV+Z6SHyQz9XBiMjcSVWRMrwi8U+aZVa+z4Dcivmf0IYxv0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9j4HMk/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712594503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYFhy7LtlEFaejmOfEUdc9o2AS0SlykqOVzLzKcDbrs=;
	b=L9j4HMk/4ErZ7woZpg9Hf8EIqqjWD13MDgeea3Yyt01hX1DspTtRcpn1iR4k0cKF8qPI2u
	RvFCo531JMS7CpQdy3AyosmERBbIjZiDOFkliLVeCB3T9CWuG8xpa1aeoLkZXjmzETSwAw
	WcI1mPbZusM4Q6FcHOMY02YpYp3bjoM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-WhyQka5CNzu-eLUzHE7xcA-1; Mon, 08 Apr 2024 12:41:42 -0400
X-MC-Unique: WhyQka5CNzu-eLUzHE7xcA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a51a2113040so189784666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 09:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712594501; x=1713199301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYFhy7LtlEFaejmOfEUdc9o2AS0SlykqOVzLzKcDbrs=;
        b=wZzf9KbBLP+ZrJNU4zwh1lv4psZwsyYo1QccPpP85TPrLbxhI3oEnWdUQULNzvFNeY
         fKumzYBzHa6YXWreDOOAPLNuUzLpZsgOvmCWHC0W9v5fppGArOmIwro1OxMtik2CTjGR
         GYroY9Z6PWvZelIQtMxiNxrT5yU6fpwH5ax27tJfwuqd717/PmPzlHmGRU2axHGh4lRe
         GXH4Yy2Aha3nfBAosSBGd94y7dn3qqM43/nvepc42Q+yjsRhqPYysWGI6flrkOnaIkit
         iCplQUlCCAS/BtfX1fnLUYMZLLrYWDAKh384aITrwcRweuvZLpMmupASRTPS9UT3/DIo
         DkJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUowy612ZVy43keOgoyg7Nd2WL5X/Wf+fLhytlZyexuNU+q7PyK7l1beq9NeanoFKSpqh+M7MeqygyW3sL2nn014auwTx0bLA/Onj2P
X-Gm-Message-State: AOJu0YyADxVmSbhGFJ6Rc+LWW9nnVkB3aOvJ2e+Kc8qupCFAgujfWq/s
	HXxZkZeOviaBAl9A1ORhABME2WiMLCzQPqE4cfWfakIbKRNTcMtGt6Ip24+sOzIRc4s0BWgu8ry
	KBBFazNz8PtkckPfsgAtWCrqxGs5l7+NQChO3avP6XsG26WMrgMoFhoHIdpn2AA==
X-Received: by 2002:a17:907:9810:b0:a46:f69b:49b1 with SMTP id ji16-20020a170907981000b00a46f69b49b1mr8095372ejc.46.1712594501558;
        Mon, 08 Apr 2024 09:41:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFGkr7moajAvwmFAdF7FwE057LZo7dEfP2XQoNu+wIaT/whevnNtaEz20216zr4FK5onjG1Q==
X-Received: by 2002:a17:907:9810:b0:a46:f69b:49b1 with SMTP id ji16-20020a170907981000b00a46f69b49b1mr8095351ejc.46.1712594501251;
        Mon, 08 Apr 2024 09:41:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id j20-20020a170906255400b00a51cd604c4bsm2270224ejb.149.2024.04.08.09.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 09:41:40 -0700 (PDT)
Message-ID: <4e37511c-7570-4ea5-bdf9-6bdd62c63575@redhat.com>
Date: Mon, 8 Apr 2024 18:41:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] ACPI: platform-profile: add
 platform_profile_cycle()
To: Gergo Koteles <soyer@irl.hu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Ike Panhc <ike.pan@canonical.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1712360639.git.soyer@irl.hu>
 <afd975d98708921f67a269aaf031a1dd1be1220d.1712360639.git.soyer@irl.hu>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <afd975d98708921f67a269aaf031a1dd1be1220d.1712360639.git.soyer@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gergo,

On 4/6/24 2:01 AM, Gergo Koteles wrote:
> Some laptops have a key to switch platform profiles.
> 
> Add a platform_profile_cycle() function to cycle between the enabled
> profiles.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Thank you for your patch, 1 small remark below,
otherwise this looks good to me.

Rafael, may I have your Ack for merging this through the pdx86 tree
together with the rest of the series once my remark has been addressed ?


> ---
>  drivers/acpi/platform_profile.c  | 39 ++++++++++++++++++++++++++++++++
>  include/linux/platform_profile.h |  1 +
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index d418462ab791..acc606af812a 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -136,6 +136,45 @@ void platform_profile_notify(void)
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_notify);
>  
> +int platform_profile_cycle(void)
> +{
> +	enum platform_profile_option profile;
> +	enum platform_profile_option next;
> +	int err;
> +
> +	err = mutex_lock_interruptible(&profile_lock);
> +	if (err)
> +		return err;
> +
> +	if (!cur_profile) {
> +		mutex_unlock(&profile_lock);
> +		return -ENODEV;
> +	}
> +
> +	err = cur_profile->profile_get(cur_profile, &profile);
> +	if (err) {
> +		mutex_unlock(&profile_lock);
> +		return err;
> +	}
> +
> +	next = find_next_bit_wrap(cur_profile->choices,
> +				  ARRAY_SIZE(profile_names), profile + 1);
> +
> +	if (WARN_ON(next == ARRAY_SIZE(profile_names))) {

Other code in drivers/acpi/platform_profile.c uses PLATFORM_PROFILE_LAST
instead of ARRAY_SIZE(profile_names) (these are guaranteed to be equal)
please switch to using PLATFORM_PROFILE_LAST for consistency.

Regards,

Hans





> +		mutex_unlock(&profile_lock);
> +		return -EINVAL;
> +	}
> +
> +	err = cur_profile->profile_set(cur_profile, next);
> +	mutex_unlock(&profile_lock);
> +
> +	if (!err)
> +		sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_cycle);
> +
>  int platform_profile_register(struct platform_profile_handler *pprof)
>  {
>  	int err;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index e5cbb6841f3a..f5492ed413f3 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -36,6 +36,7 @@ struct platform_profile_handler {
>  
>  int platform_profile_register(struct platform_profile_handler *pprof);
>  int platform_profile_remove(void);
> +int platform_profile_cycle(void);
>  void platform_profile_notify(void);
>  
>  #endif  /*_PLATFORM_PROFILE_H_*/


