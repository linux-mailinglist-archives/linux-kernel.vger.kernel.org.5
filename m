Return-Path: <linux-kernel+bounces-49382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD8F8469C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDF51C22ADF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC5A17BBE;
	Fri,  2 Feb 2024 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nx5wUTdO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9842317BB5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860189; cv=none; b=EBZbdvos6ZI8ZtQWn9rfqoV3gJfXQagfQ0lg4mPZToeKVpOEZ99NHqc4Q21cwM085ePgCbL+8ZZnCKG1qDtSf7riSBv1U+1SXgj6nvos7iMb+bLkeDcabJ77YxOSJjfzeugON6TSSgIBlalAZVvTWKUoyJGDiUIwc+2MBmjUlDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860189; c=relaxed/simple;
	bh=Rosjw/fWeROwK1eHPmgkBfxRsS3OHEYIAC+fl12Rqyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhMThFNFuS0KJuMy/mBSqGMk/q6ek/g8qoa1fKfT5tTRvhd7036JBjTDOwbhK/+l5uBHHTvc++Rap7ANOcE9DNXSZrLgbdXM7PEV9poE7cjURhZ848QIztnUa3fMjm/uvdXziGsO9wEaAkZN2YIT6T4M2kv0fLCnvp14M0X77Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nx5wUTdO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706860186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2y0v+j5Jdi4S0j/7TIDS4/wQS3UjlRfpUREHEJdYNg=;
	b=Nx5wUTdOKkgnZ8AfEXbUCACNoInY6sA+6Jz7sCbhFPxfoUYLtEgFihZsiLDObN+tOqqm0i
	yrRVaFc7NRM6m18Q7RpIQlHVTvMqvI5Euj7U7QJ3unr8Un5DzyBROJbg7mC/ZQPmOmBy3t
	jiX/jJWFLsETRONsIgyzvh9tr2ynxqg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-e5kWamVXP2Cl9x8PgsEwwg-1; Fri, 02 Feb 2024 02:49:43 -0500
X-MC-Unique: e5kWamVXP2Cl9x8PgsEwwg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a31ffe314c5so91163366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 23:49:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706860182; x=1707464982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2y0v+j5Jdi4S0j/7TIDS4/wQS3UjlRfpUREHEJdYNg=;
        b=vdIOEKAKQz6KCVyBid6Zhiiz7GpaLAhNvr61DsZnPzShc+HyCdEVlMgsA76bW0nRd4
         5Q+6J6HMP23l8PHKNq9LbOkanj/x7jiyRFj7HHkKihxUL1+Mw0mT7B9fdfPhPrbVz+Qr
         EWgiPx4oOoFzXMDdhypx4AAGLMLUpaib7qQCORBDCq6tGWI9g+kPqa9UtbOguEtC9k3W
         TnoqnDcBT0z1iEHS4Y2Z/HWbc26JisR9GISot/T2IgTGO2zePy0vzOe99gmudIekuCSW
         aUGPuHnVw+iYHhUgzJ03rtD8c7CCRW+nR4tnWw+gal0m3No7pofRk7gCHFaXiq8GjZbl
         2Hhg==
X-Gm-Message-State: AOJu0YxRj+GVHCFyEMG4b+twvSzr9M89Fgk2RVuf8NEzGrOn+ScUD2XY
	LLz4sngTj+pgynU5nmFqcJA61gZtefJv6MdQ/0jlkRTxnDxdhbgPqxXqWtmvHxUEqAQHuwHJb5I
	k+BMX41vcXJ60CddOC0qilYa4puZ5rS6sh1OdUswgNu/6X8XHjbtuaXCNqj180A==
X-Received: by 2002:a17:906:80cd:b0:a36:c327:e60d with SMTP id a13-20020a17090680cd00b00a36c327e60dmr862108ejx.48.1706860182767;
        Thu, 01 Feb 2024 23:49:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjHnGJIlgrFXDqYi0ZgjzbriJnGOniMRwC25RLoaRxDd4REYDUT00BMXe1znbrb+VqNKNE4Q==
X-Received: by 2002:a17:906:80cd:b0:a36:c327:e60d with SMTP id a13-20020a17090680cd00b00a36c327e60dmr862097ejx.48.1706860182430;
        Thu, 01 Feb 2024 23:49:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVPkyNmTst3UetfCrPr+kbRZff0uSPLuK9Vj/NrzeAxSlLczVI9+bY97Wx6mXcL+7s+Du0GVnLhjRjZ2q+djdSou/hNId6EBT4WRK8+N5X9q6r7NbPLkkHdwPlU3fTL7XINhDFS84DkWdCdWt8g+gX0Gj6qtnoD3jRs9jKHF2Kih8jQ2/oxvhMJ//D7xHc7mqE8E5T4Zse2tiQJcTSVFUwA26cvSaWJXzA1rA==
Received: from [192.168.43.127] ([109.36.129.188])
        by smtp.gmail.com with ESMTPSA id r26-20020a170906365a00b00a2bf9b00508sm602212ejb.141.2024.02.01.23.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 23:49:42 -0800 (PST)
Message-ID: <07010c54-2e44-463b-9a9b-95697fd30ffd@redhat.com>
Date: Fri, 2 Feb 2024 08:49:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86/amd/hsmp: switch to use
 device_add_groups()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 naveenkrishna.chatradhi@amd.com
Cc: linux-kernel@vger.kernel.org, Carlos Bilbao <carlos.bilbao@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <2024020145-junior-outnumber-3e76@gregkh>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2024020145-junior-outnumber-3e76@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

On 2/2/24 03:44, Greg Kroah-Hartman wrote:
> The use of devm_*() functions works properly for when the device
> structure itself is dynamic, but the hsmp driver is attempting to have a
> local, static, struct device and then calls devm_() functions attaching
> memory to the device that will never be freed.

As I mentioned in my reply to v1, this is not correct.

There is a global data struct, but that holds a struct device
pointer, not the device struct.

The device itself is created with platform_device_alloc() +
platform_device_add() from module-init and it is removed
on module-exit by calling platform_device_unregister()

So AFAICT this should keep using the devm_ variant to properly
cleanup the sysfs attributes.

But what this really needs is to be converted to using
amd_hsmp_driver.driver.dev_groups rather then manually
calling devm_device_add_groups() I have already asked
Suma Hegde (AMD) to take a look at this.

Regards,

Hans





> 
> The logic of having a static struct device is almost never a wise
> choice, but for now, just remove the use of devm_device_add_groups() in
> this driver as it obviously is not needed.
> 
> Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> Cc: Carlos Bilbao <carlos.bilbao@amd.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: rebased against platform/for-next
> 
>  drivers/platform/x86/amd/hsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
> index 1927be901108..d84ea66eecc6 100644
> --- a/drivers/platform/x86/amd/hsmp.c
> +++ b/drivers/platform/x86/amd/hsmp.c
> @@ -693,7 +693,7 @@ static int hsmp_create_non_acpi_sysfs_if(struct device *dev)
>  		hsmp_create_attr_list(attr_grp, dev, i);
>  	}
>  
> -	return devm_device_add_groups(dev, hsmp_attr_grps);
> +	return device_add_groups(dev, hsmp_attr_grps);
>  }
>  
>  static int hsmp_create_acpi_sysfs_if(struct device *dev)


