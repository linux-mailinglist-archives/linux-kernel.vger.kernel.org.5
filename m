Return-Path: <linux-kernel+bounces-50233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D727E847614
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A5A1C23E36
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D7214A4E9;
	Fri,  2 Feb 2024 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8P2pZFm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C2314A4CF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895001; cv=none; b=jfJ9NAGv9UXdwNKzsVGwlXxo82K0+fNJl3T/lDZ7cbu2LRxXO9+8XLddFH2fkclQzVXsfjHXi02sMdlPfxEfm1Xeby7r546TYdAttXaO0FL182I8ixZ2I7sws4aE2R753f/T6Hf3nPquUgXmzPr70X/dW4esL+ZAbeCjqZwodsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895001; c=relaxed/simple;
	bh=kO6aAZ0pKgUTlZffrnrlc+wT24FMTAWDS5t51S8QsRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdhjiPNV/HUDSAprKUqRsfobX4jgFHCP0kZj2qnQkJyqjg3RJQ9abLrDjJM3vRIyUCKMMjAyKrsHw7UcGkgbO6SmHNoDqsGusE1mZaw3yHJW3BOIEdMaQJmz5sDFm4am2T8+D8bvvRMpQLBLTITFFPSpW1Q0b21FWMXuLDte5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8P2pZFm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706894998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQmKdJtNienJwWNmm6v9a0mzgCKgqEXZjhpUCZP6vMg=;
	b=e8P2pZFmfxBDAyrCpbVNmEnS83f0mHlqI/ZGP4cz0G4ouljEf2Sf+diThYtk6jRa4Mb76F
	twv9e43PR9fZ0NMwU56KI9E+Erk73yF8eKOev0CNzhCm4GzyL/trhoEaIUk8hFD4+wyW3f
	SleOme6M22UV+Lc/xE6l+U0P6GjK38M=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-jMk0UdvjPc-kQqr5sch0XA-1; Fri, 02 Feb 2024 12:29:56 -0500
X-MC-Unique: jMk0UdvjPc-kQqr5sch0XA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51136eb0923so873225e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:29:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706894995; x=1707499795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQmKdJtNienJwWNmm6v9a0mzgCKgqEXZjhpUCZP6vMg=;
        b=bI7QYlzQNaQncAOeR+Ef92dvkeSqeAd8GxwnHACjUJfgKpWWYfJR0CA31V+xsvtmpC
         aC7GtoGkEFfVYPaXFS/cAud++G2FAtpz335fVQ0j4D/M38zi0js3WQWZ2dD6cXtfMOul
         thSMxD7PxbuzmFKfWww/2MxNEcDfk0JtBJtMjVl63dI1ElJehTnkeJbFLEcLcw7VIs6L
         aTmhmVCKBjB2PmgqxByeNJGPNKigquuL/EdfqtAxvNb6PcnCZOP4KeVBxTaEsWEE6WCO
         2TVxk4QGoCl0k+w/jNZEqVZxu6HE8u08AFTuTLTtZgBW2Bc3Q1faAOwnrt3i68bNB0mR
         +Paw==
X-Gm-Message-State: AOJu0Yy3mUSmQvWWQSoMyLl/Lw/tgic9jhqad6Jj8TnuhcW7NXzEukWz
	hwR12+wpmAq6+WmpiD0H0q4zJdpgiJpRMLpXwLdD/bfYBYQGbLYO66ACgia/iqciN5gqr8Vu8Fy
	SHpoxsAfgFD+6LrDTK1zBW9y1BLMPd6qfLfVBS3AzLhjk6kATcp7RpofMGW5SJw==
X-Received: by 2002:a05:6512:3a84:b0:511:2aea:5b3f with SMTP id q4-20020a0565123a8400b005112aea5b3fmr4834441lfu.37.1706894995418;
        Fri, 02 Feb 2024 09:29:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYbd2IfyUkPZvdVN76TlGAqKG60jZr6iMuCWE+d3Zul7AoBzIwQueHDOiJOLbiR6SnxqUaIA==
X-Received: by 2002:a05:6512:3a84:b0:511:2aea:5b3f with SMTP id q4-20020a0565123a8400b005112aea5b3fmr4834431lfu.37.1706894995079;
        Fri, 02 Feb 2024 09:29:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXub7HTMncq+N4U2zioX9QPPfkBSBuaDAevR+5VsWrke7LH52Zdkt/yIWs63xEQf5apvORyKV0RzgWPUzqcu+YuB/K9q2tebZr6In6+FTTrXkPR5F37VcHYgym0IjoyRJ8R07Ydt38OW7xScgEUwYxEna3jzbUS+UI1uy34ELiv5VccXlX1v1r1zKhl69kATexxUMA0tTQhbFYKT5IIIqfoH4hNA1n2lA==
Received: from [192.168.1.24] ([212.76.254.34])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c450f00b0040fb01d61a3sm484220wmo.18.2024.02.02.09.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 09:29:54 -0800 (PST)
Message-ID: <06e92b87-4d48-4519-b1db-6d7605bf3962@redhat.com>
Date: Fri, 2 Feb 2024 18:29:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86/amd/hsmp: switch to use
 device_add_groups()
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: naveenkrishna.chatradhi@amd.com, linux-kernel@vger.kernel.org,
 Carlos Bilbao <carlos.bilbao@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <2024020145-junior-outnumber-3e76@gregkh>
 <07010c54-2e44-463b-9a9b-95697fd30ffd@redhat.com>
 <2024020243-blinks-pantomime-c51e@gregkh>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2024020243-blinks-pantomime-c51e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/2/24 16:32, Greg Kroah-Hartman wrote:
> On Fri, Feb 02, 2024 at 08:49:39AM +0100, Hans de Goede wrote:
>> Hi Greg,
>>
>> On 2/2/24 03:44, Greg Kroah-Hartman wrote:
>>> The use of devm_*() functions works properly for when the device
>>> structure itself is dynamic, but the hsmp driver is attempting to have a
>>> local, static, struct device and then calls devm_() functions attaching
>>> memory to the device that will never be freed.
>>
>> As I mentioned in my reply to v1, this is not correct.
>>
>> There is a global data struct, but that holds a struct device
>> pointer, not the device struct.
> 
> Ooops, I misread that:
> 	static struct hsmp_plat_device plat_dev;
> was not the actual device struct anymore.
> 
>> The device itself is created with platform_device_alloc() +
>> platform_device_add() from module-init and it is removed
>> on module-exit by calling platform_device_unregister()
> 
> Ok, much better.
> 
>> So AFAICT this should keep using the devm_ variant to properly
>> cleanup the sysfs attributes.
> 
> This devm_ variant is odd, and should never have been created as the
> sysfs core always cleans up the sysfs attributes when a device is
> removed, there is no need for it (i.e. they do the same thing.)
> 
> That's why I want to get rid of it, it's pointless :)
> 
>> But what this really needs is to be converted to using
>> amd_hsmp_driver.driver.dev_groups rather then manually
>> calling devm_device_add_groups() I have already asked
>> Suma Hegde (AMD) to take a look at this.
> 
> The initial issue I saw with this is that these attributes are being
> created dynamically, so using dev_groups can be a bit harder.  The code
> paths here are twisty and not obvious as it seems to want to support
> devices of multiple types in the same codebase at the same time.
> 
> But yes, using dev_groups is ideal, and if that happens, I'm happy.
> It's just that there are now only 2 in-kernel users of
> devm_device_add_groups() and I have a patch series to get rid of the
> other one, and so this would be the last, hence my attention to this.
> 
> Again, moving from devm_device_add_groups() to device_add_groups() is a
> no-op from a functional standpoint, so this should be fine.

Ok, I was not aware that the core automatically cleans up
all the attributes anyways.

In that case this fine with me and I agree with merging this
so that you can entirely remove the  devm_ variant:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




