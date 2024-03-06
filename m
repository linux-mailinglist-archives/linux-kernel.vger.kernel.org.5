Return-Path: <linux-kernel+bounces-93826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8421787353F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD90DB21319
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAF960DEC;
	Wed,  6 Mar 2024 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSicKGzx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BFA604D5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722887; cv=none; b=qiw82AMvOX+MVV9quNBVGT3dvvLDVdK7y6AkdaCzvy4Asa1HAr1XWbYlK8tdb8EKJu4G7HSJdxPkf9UNWZNJS287b4OTBXQsbSFOn0Z64CFI4M3XT3xLcMsS+25Xnk5qtLr19d4QoK5W3E93NKy8O9QPRGa5KDdJw/hvWkexopY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722887; c=relaxed/simple;
	bh=0BtgKlkxEFfuAK3jbJm263LilfDmbaFMUABjdQurww4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVph5w8wzUnujCdnQhRUyXOkIBib13N8WwPI8F6QlwlN975lAJKa5ssSNz4FJp8rCBhgnjNt5Cp2ImuumdmjKr7DB3ApQurlVODT8RKEJubPiMfcpWgtk/HEjCyoqXNABylKm54ZaQpEVMovhmkcxU3W5lI2uLk5iFUkkXQgOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSicKGzx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709722884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/xdqIyX3WHBcfaU82MWvytSSDhoROzy1XJYnAGe0xU=;
	b=TSicKGzxP+RHa5c/8HDXQHDO2t9N6ENniPVVxnHU6ffz4/imT9cXrHEcR6SZoWeTqoTr8W
	bSvhKxWa8rl7cUF3ukTyo61US20MBnU2+Tmw/60WaYFJSPTTWPclthI8V4Fs0coGCXzacQ
	JCy7Njj/dhG1CKyrMCRM+WGu1phnSGU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Wh4Urci5MJqf-XtVieJTiQ-1; Wed, 06 Mar 2024 06:01:23 -0500
X-MC-Unique: Wh4Urci5MJqf-XtVieJTiQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a449be9db59so286516966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 03:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709722882; x=1710327682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/xdqIyX3WHBcfaU82MWvytSSDhoROzy1XJYnAGe0xU=;
        b=HnkisiUuz2wswLryCE1OfqxeRVBa6eASNMrvjzfrC3s3FOqxCzJF+4Z/tQenqff12s
         fLXfzPWH5TuVy4bGkO/2VcvkdAJ/68AFg/9+cOqHK+u8cv5r3c7t3quJmKfDhH9HCZcv
         nqtLyQ9c6NffjKDlBRqFsrPvmwXRJXoGwNoAM+/M8f+z4MCRaE/Rzwf0NBJwrr9BhSvC
         DTQV5Nsi7c2JZvp1Enw1i2olvjAUS0s0bHVj9jm+9y2SiXAjHUqWRvsI/QpJCJcyBChE
         uq9uniPf+o4/ajopa3sxjWBQEn5nPxRto551QNhTXQkUJK5fcpEuQ8zTB/AR/a2QZ/t/
         //Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXQbPvxzMcZw4e1PBsdhDWmbCoi1m6dHYI2F0TcmREHzsGyQPHUZ5O4w+lUJs6Gt8/C3Bq+c8B2vNWIX3BQTTWm7k5vJpxTj4J6uycc
X-Gm-Message-State: AOJu0Yz9rhIb6fpVqit7kjBs1CD8/Ag/ZHPJ+JdwaDsOz2m2YR13ZGIi
	tcwsjc/RoCoCD/ZI2c94OGTWhJM23rG9mMUdtHuy0LqT/jsvUdCUN/d3j8yRxULglodPDDbS5Br
	q6z7NkQXMDmbVinPL/JvcTkmRTfJWb0/XAoW/JGs3t3rq02v1zXoXSIjubHerHw==
X-Received: by 2002:a17:906:4709:b0:a45:5831:4f00 with SMTP id y9-20020a170906470900b00a4558314f00mr5190405ejq.75.1709722880901;
        Wed, 06 Mar 2024 03:01:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU2MCC7j95NF/rjcuadNvSxFpI8Ztf1NyvWpuIx8AEUaD0oPQp9HbDvXv2YrwJR9Zze55HCA==
X-Received: by 2002:a17:906:4709:b0:a45:5831:4f00 with SMTP id y9-20020a170906470900b00a4558314f00mr5190385ejq.75.1709722880571;
        Wed, 06 Mar 2024 03:01:20 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id wk15-20020a170907054f00b00a4519304f8bsm4011706ejb.14.2024.03.06.03.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 03:01:20 -0800 (PST)
Message-ID: <829d07c8-b602-4463-9f8e-dc8eb73aa077@redhat.com>
Date: Wed, 6 Mar 2024 12:01:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] platform/x86: add lenovo generic wmi driver
Content-Language: en-US, nl
To: =?UTF-8?B?6Im+6LaF?= <aichao@kylinos.cn>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 W_Armin <W_Armin@gmx.de>
Cc: "ilpo.jarvinen" <ilpo.jarvinen@linux.intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 platform-driver-x86 <platform-driver-x86@vger.kernel.org>
References: <2o0aznm5pjb-2o0c9lfkrd4@nsmail7.0.0--kylin--1>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2o0aznm5pjb-2o0c9lfkrd4@nsmail7.0.0--kylin--1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/6/24 09:17, 艾超 wrote:
> Hi
> 
>  
> 
>> I would be interested on which devices this driver was tested and is
>> expected to work with.
> 
>  
> 
> Lenovo A70，it is a Computer integrated machine.
> 
> 
>>> This looks similar to a switch.
>>> Would it be more useful for the user to report a standard switch instead
>>> of a key event which needs to be correlated with the sysfs file?
> 
>> I agree, maybe SW_CAMERA_LENS_COVER might be the right thing to use here,
>> if those camera states (open/closed) are meant to symbolize camera shutter states.
> 
>> In such a case the initial switch state has to be retrieved, or else the input device
>> cannot be registered until the first event is received (similar how the hp-wmi driver
>> handles SW_CAMERA_LENS_COVER events).
> 
>> Ai Chao, can you tell us if those two camera states are meant to act like a switch (camera switched off,
>> camera switched on) or meant to act like a key (camera button pressed, camera button released)?
> 
>  
> 
> The camera button is like a switch.  I can used SW_CAMERA_LENS_COVER to report input event , but the OS
> 
>  can't to show camera OSD. OS need a key value  map to the camera OSD.

Please use SW_CAMERA_LENS_COVER in the next version, that really is the correct
thing to do here, so that you not only report the event of the camera state
changing, but also the actual camera state (on/off) to userspace.

This will also allow you to remove the custom sysfs atribute since you
are now correctly reporting the value to userspace through the evdev event.

As for userspace not responding to SW_CAMERA_LENS_COVER, this is because
SW_CAMERA_LENS_COVER is relatively new and we need to add support to
userspace for this. SW_CAMERA_LENS_COVER is already used on whole a bunch of
Dell laptops for this, so we need to do this anyways.

Please file an issue against GNOME, lets say against gnome-settings-daemon
for this.

Regards,

Hans


