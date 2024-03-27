Return-Path: <linux-kernel+bounces-120699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAE588DB97
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A8AB23E01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B24E38FA1;
	Wed, 27 Mar 2024 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhweDbpn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E825630
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536904; cv=none; b=U7aDktarBL+NjtycrXHrvezJLmAwvtzaACGuLSk202lk3rfIIbw4T42UsqmxOE9RO3dVOmfmcBHQGfl2GT4lUZqp7HEXbzJjrJznyYwfYTWHddny6SzoWh6Nf8bYoTE55Lw4KRYHnTnoMMnhW9SJaYh3wpvGTR147EYXxFCqkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536904; c=relaxed/simple;
	bh=KweQtMWh8ngFMvSjQH6JE+OBPcnHJ4rB/+Q5je6TFH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTEyB6tOaVYwox8AXd0QpRmj/yjWUhG1boNnP+cqhVFdCCKHZvbe2iDzMstsvT21HtmxmYWRxoRtZcWOlIjMkYwxvc/FFxpaDKNRvdGzciKuGLYKTaqulW2I/lKXaEx4XwyIb61Qomkr85EyRtykTyytFjKYoF9J0Z1ItN3BYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhweDbpn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711536901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOj1xUDRgKvrKUZwWE47VrEgQM/bvWgtRCCyCpAEu/A=;
	b=ZhweDbpnsfwhs+jQZgSngCeHdeM4q72TLt/2FYnOAQFLxuOG7KxHjeD1Y2IYK0BEWJCSQ+
	t6f+ogsORL9QB+rTunZf868lHpRolb11rHWgdDHobPzJwpFSuiwvVvpnI6xxlm8rCosZHa
	MXlYy7g3ADkPvahrqjh3qlN7VT3jz0Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-NJTUvoOeNJ6o9NggcWuLDw-1; Wed, 27 Mar 2024 06:54:58 -0400
X-MC-Unique: NJTUvoOeNJ6o9NggcWuLDw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a46bae02169so68637566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711536897; x=1712141697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOj1xUDRgKvrKUZwWE47VrEgQM/bvWgtRCCyCpAEu/A=;
        b=wgbcqQgGvRyT6VP9w8YAbkDpxAzCEULhWR3tRIh1AXGlRiPXrApdAGX+Eha1EtrBym
         5Qegh0W6i250rGTQ1aLOXIzBpT2hguGof6xI0MHgTds4nH6gM42mCDFdbVnS+EnXsnlS
         NpTecGSmNnLho9IJsNMaylbMz+cMpFtMD7j+YYVvDt7y7zOkmfSKPe40f3rmOUM++3xm
         xGgxQDkgDaqUCu/7F5QwRVr2Bnk//zoMwG82SQG6bLZGFlm52xt8TykOZGnFRzV5i3J9
         lyIdLxsMFg9dXukumIirLpRsPlORJiDqJNLHT2vW5OJENlI9mgwDYXrG7cNDryjYfbFR
         cx2g==
X-Forwarded-Encrypted: i=1; AJvYcCUa7wjyhZef1A0ReaKBBHov3MkQOQ+jTa9eGhA3A/qSdnxYhtLqrB+2OI4noIHyCG3foAAXggSsQeqh23GPVD8xTuhXstCU0YNLXdVr
X-Gm-Message-State: AOJu0YxagywUkgrvkiTw5ZXRGBcclmmoJ7sdiT/cVPQtFvPtrdBG1Ykc
	8845uPI4fySF/ntX/0NUAqQ9AVU9S41juEjnLx/dWCnxyQHF/6c88kyzM1dOII7F/VhomNzR+bE
	hkMBR4M9p0WFVs6wWBH9LklbJdw9uYP/Pbj2n4ZEeYylVcUFDeLuIDqtrcRJceA==
X-Received: by 2002:a17:906:374a:b0:a47:3cd5:b3f1 with SMTP id e10-20020a170906374a00b00a473cd5b3f1mr3083494ejc.35.1711536897095;
        Wed, 27 Mar 2024 03:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhLJLKLQeaxmFpX4tDgVqdVY05KaUoMv6vx1ZnQa20SN27eR0yLzoiqFoYZY4YoaspWrfDQw==
X-Received: by 2002:a17:906:374a:b0:a47:3cd5:b3f1 with SMTP id e10-20020a170906374a00b00a473cd5b3f1mr3083483ejc.35.1711536896742;
        Wed, 27 Mar 2024 03:54:56 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gx24-20020a1709068a5800b00a46f0d133b9sm5304616ejc.98.2024.03.27.03.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 03:54:56 -0700 (PDT)
Message-ID: <030beaf8-12e1-400a-b064-f17384e32714@redhat.com>
Date: Wed, 27 Mar 2024 11:54:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] platform/x86: add lenovo wmi camera button driver
Content-Language: en-US, nl
To: =?UTF-8?B?6Im+6LaF?= <aichao@kylinos.cn>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "ilpo.jarvinen" <ilpo.jarvinen@linux.intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 platform-driver-x86 <platform-driver-x86@vger.kernel.org>
References: <je8phmmtfz-je9zfg1v9s@nsmail7.0.0--kylin--1>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <je8phmmtfz-je9zfg1v9s@nsmail7.0.0--kylin--1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ai Chao,

On 3/26/24 3:54 AM, 艾超 wrote:
> Hi
> 
>  
> 
> WMI
> 
>> > The Camera button is a GPIO device. This driver receives ACPI notifyi
>> > when the camera button is switched on/off. This driver is used in
>> > Lenovo A70, it is a Computer integrated machine.
> 
>> > +config LENOVO_WMI_CAMERA
>> > + tristate "Lenovo WMI Camera Button driver"
>> > + depends on ACPI_WMI
>> > + depends on INPUT
> 
>> No COMPILE_TEST?
> 
>  
> 
> I compile this driver and used Evtest tool to test it on lenovo A70.
> 
> 
> ...
> 
>> > + /* obj->buffer.pointer[0] is camera mode:
>> > + * 0 camera close
>> > + * 1 camera open
>> > + */
> 
>> /*
>> * The correct multi-line comment style
>> * is depicted here.
>> */
> 
>  
> 
> Thanks, I will modify it.
> ...
> 
>> > + keycode = (camera_mode == SW_CAMERA_ON ?
>> > + KEY_CAMERA_ACCESS_ENABLE : KEY_CAMERA_ACCESS_DISABLE);
> 
>> Useless parentheses.
> 
>  
> 
> I think the parentheses is a good programming style and beneficial for reading.
> 
>  
> 
> ...
> 
>> > + ret = input_register_device(priv->idev);
>> > + if (ret)
>> > + return ret;
> 
>> > + mutex_init(&priv->notify_lock);
> 
>> Your mutex should be initialized before use. Have you tested that?
> 
>  
> 
> Yes, I tested it.
> 
> 
> ...
> 
>> > +static struct wmi_driver lenovo_wmi_driver = {
>> > + .driver = {
>> > + .name = "lenovo-wmi-camera",
>> > + .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> > + },
>> > + .id_table = lenovo_wmi_id_table,
>> > + .no_singleton = true,
>> > + .probe = lenovo_wmi_probe,
>> > + .notify = lenovo_wmi_notify,
>> > + .remove = lenovo_wmi_remove,
>> > +};
>> > +
> 
>> Unneeded blank line.
> 
>  
> 
> Thanks, I will modify it.
> 
> 
>> > +module_wmi_driver(lenovo_wmi_driver);
> 
> ...
> 
>> > +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);
> 
>> Please, move it closer to the respective table.
> 
>  
> 
> Thanks, I will modify it.

I have already merged this. I'll squash in fixes for the few
small code style remarks from Andy, so there is no need
to send a new version.

Regards,

Hans



