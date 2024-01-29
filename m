Return-Path: <linux-kernel+bounces-43106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB1840B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4D8282096
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036BF15A4B4;
	Mon, 29 Jan 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heGG28np"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB115A4A6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545922; cv=none; b=EG17R4Gn9YButCwoyru9H5ev5+e3XNEOao7fPsZ1+xUBMQh9vQ3vq6XkJm1zKtKWYlDrgWWCsCa9q7LXfnr57fIf2RwrW04jNue9Efs0CqEuwY3EnvdssxpSNvllcWttpFYNRmApK6QAB7M3JZNN+92zHXfKF7/Id7dyiIzBqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545922; c=relaxed/simple;
	bh=k4/BNjbTTqjP49J8n1Pv3LvMOl+KNbRGTBoLdiaiFNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcF/wPgcn1+Dwe/OBzU2quWor+1tZcXHYpaaaDYYyt4chV9ytYtULho9fi44awzQo9PnRNLXs8p4ScsvYXmjI1DvYnlX6og5ATVJbN85TQHFzysExZ+lDlc5uC3thHkK6lgxgY5atkmXXeWUJB8sKSaBCDssSQNfgzFm+yZ/hh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=heGG28np; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706545919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/L/3+aj4kshl/a2QQJi71HdU9Hie8YBQwAh5a5RCoI=;
	b=heGG28npeEaYyZP1suMeswaL0aka3ldxy21pLYIdYiElDkP+8O1u2oZ18VLc/tXU2ljb5B
	Ms1MrSaDepd947fPRT5tDBcCLkQfc2hHPdKfaT3P18JjZ3F5SuNL5wjJhe8jiQYWZH8jP2
	wZKJRNGCU1cKrEK9XakCJeSSBoHykig=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-6L_ePKKkNNisQsGUd9fiLA-1; Mon, 29 Jan 2024 11:31:57 -0500
X-MC-Unique: 6L_ePKKkNNisQsGUd9fiLA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a2bc65005feso223543166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706545916; x=1707150716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/L/3+aj4kshl/a2QQJi71HdU9Hie8YBQwAh5a5RCoI=;
        b=m8GAgYIimP/Q/yEyg2C7GtUWzwc9naVZnQzG4gAmJ5rvjWqu3+0s6NnazGo9bsXvl0
         xsaAf/HnEGNOVUOIiAjaERCpp218ur2T9Fqo4QobPJ1jvzcwnXe7O0/I+FpeJrtrSWvg
         sXudeO1YYeyoBOiZV/oO2+CI6lMeZQm8K5ljVi1O+6qxg0AHwtLX6WzVS7JKuPAoy0AS
         oswL/8vGhtqbF2SfUfYUY4RQ8WWIjy8/JebSMf3ezEaJYmtJMwX0sDHK1ZcqkNVnaoq5
         Kgu+Mn9R2SGRjRj8q95ExSKd1nQ/k2vdKZkdo/Lh8+Z+TjDG3EEFU+aeNOHc/SJ8Sihj
         UkCg==
X-Gm-Message-State: AOJu0YxB/RyhPRLICdJbwrw6SHrNyjn/yP/OjG1I2pESwX60CMZ8Hfok
	SULNCzg0PPV0xv5WnLPqXFJ1yLPu3UNFcUsDIK66XkfPWHnTur5pPK4H+91S1ws5ETJnnxUOzF1
	bJVkgTp2+ufu7qsxy0zrm5pgTT0TIOg9b3Dj9e5rx7mTNbHGMtTSre3NF1121sA==
X-Received: by 2002:a17:906:a415:b0:a35:becf:4320 with SMTP id l21-20020a170906a41500b00a35becf4320mr1957161ejz.29.1706545916224;
        Mon, 29 Jan 2024 08:31:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG41dzZkEn7luj4mU81wo0+h4odyPle7e5h7j96uGkVWaE6nOrcUuTyWM6BIIjQN653dEmHuw==
X-Received: by 2002:a17:906:a415:b0:a35:becf:4320 with SMTP id l21-20020a170906a41500b00a35becf4320mr1957140ejz.29.1706545915782;
        Mon, 29 Jan 2024 08:31:55 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id tl10-20020a170907c30a00b00a3554bb5d22sm2691654ejc.69.2024.01.29.08.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 08:31:55 -0800 (PST)
Message-ID: <6ba16249-a4d7-400d-a18a-96753367c722@redhat.com>
Date: Mon, 29 Jan 2024 17:31:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Flood of logitech-hidpp-device messages in v6.7
Content-Language: en-US, nl
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, =?UTF-8?Q?Filipe_La=C3=ADns?=
 <lains@riseup.net>, Bastien Nocera <hadess@hadess.net>,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
References: <3277085.44csPzL39Z@natalenko.name>
 <12371430.O9o76ZdvQC@natalenko.name>
 <489d6c71-73eb-4605-8293-5cfea385cf08@redhat.com>
 <4894984.31r3eYUQgx@natalenko.name>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <4894984.31r3eYUQgx@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oleksandr,

On 1/29/24 17:19, Oleksandr Natalenko wrote:
> On pondělí 29. ledna 2024 17:08:56 CET Hans de Goede wrote:
>> Hi,
>>
>> On 1/29/24 16:58, Oleksandr Natalenko wrote:
>>> Hello.
>>>
>>> On úterý 9. ledna 2024 12:58:10 CET Hans de Goede wrote:
>>>> Hi Oleksandr,
>>>>
>>>> On 1/9/24 12:45, Oleksandr Natalenko wrote:
>>>>> Hello Hans et al.
>>>>>
>>>>> Starting from v6.7 release I get the following messages repeating in `dmesg` regularly:
>>>>>
>>>>> ```
>>>>> Jan 09 10:05:06 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
>>>>> Jan 09 10:07:15 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
>>>>> Jan 09 10:16:51 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
>>>>> Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
>>>>> Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
>>>>> Jan 09 10:36:31 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
>>>>> Jan 09 10:37:07 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
>>>>> Jan 09 10:46:21 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
>>>>> Jan 09 10:48:23 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
>>>>> Jan 09 11:12:27 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
>>>>> Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
>>>>> Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
>>>>> Jan 09 11:38:32 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
>>>>> Jan 09 11:43:32 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
>>>>> Jan 09 11:45:10 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
>>>>> Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
>>>>> Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
>>>>> Jan 09 12:31:48 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
>>>>> Jan 09 12:33:21 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
>>>>> ```
>>>>>
>>>>> I've got the following hardware:
>>>>>
>>>>> * Bus 006 Device 004: ID 046d:c52b Logitech, Inc. Unifying Receiver
>>>>> * Logitech MX Keys
>>>>> * Logitech M510v2
>>>>>
>>>>> With v6.6 I do not get those messages.
>>>>>
>>>>> I think this is related to 680ee411a98e ("HID: logitech-hidpp: Fix connect event race").
>>>>>
>>>>> My speculation is that some of the devices enter powersaving state after being idle for some time (5 mins?), and then wake up and reconnect once I touch either keyboard or mouse. I should highlight that everything works just fine, it is the flood of messages that worries me.
>>>>>
>>>>> Is it expected?
>>>>
>>>> Yes this is expected, looking at your logs I see about 10 messages per
>>>> hour which IMHO is not that bad.
>>>>
>>>> I guess we could change things to track we have logged the connect
>>>> message once and if yes then log future connect messages (and all
>>>> disconnect messages) at debug level.
>>>
>>> How granular such a tracking should be? Per-`struct hidpp_device`?
>>
>> Yes per struct hidpp_device we want to log the connect message once
>> per device since it gives info which might be useful for troubleshooting.
>>
>>> Should there be something like `hid_info_once_then_dbg()` macro, or open-code it in each place instead?
>>
>> Since we want something like e.g. a "first_connect" (initialized
>> to true if you use that name) flag per struct hidpp_device this needs
>> to be open coded.
> 
> OK, would something like this make sense (not tested)?

Yes, thank you. I would call once_connected connected_once and
you can drop the disconnected flag and just always log
disconnect messages at the dbg level.

Regards,

Hans



> 
> ```
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 6ef0c88e3e60a..a9899709d6b74 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -203,6 +203,9 @@ struct hidpp_device {
>  	struct hidpp_scroll_counter vertical_wheel_counter;
>  
>  	u8 wireless_feature_index;
> +
> +	bool once_connected;
> +	bool once_disconnected;
>  };
>  
>  /* HID++ 1.0 error codes */
> @@ -988,8 +991,13 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
>  	hidpp->protocol_minor = response.rap.params[1];
>  
>  print_version:
> -	hid_info(hidpp->hid_dev, "HID++ %u.%u device connected.\n",
> -		 hidpp->protocol_major, hidpp->protocol_minor);
> +	if (!hidpp->once_connected) {
> +		hid_info(hidpp->hid_dev, "HID++ %u.%u device connected.\n",
> +			 hidpp->protocol_major, hidpp->protocol_minor);
> +		hidpp->once_connected = true;
> +	} else
> +		hid_dbg(hidpp->hid_dev, "HID++ %u.%u device connected.\n",
> +			 hidpp->protocol_major, hidpp->protocol_minor);
>  	return 0;
>  }
>  
> @@ -4184,7 +4192,11 @@ static void hidpp_connect_event(struct work_struct *work)
>  	/* Get device version to check if it is connected */
>  	ret = hidpp_root_get_protocol_version(hidpp);
>  	if (ret) {
> -		hid_info(hidpp->hid_dev, "Disconnected\n");
> +		if (!hidpp->once_disconnected) {
> +			hid_info(hidpp->hid_dev, "Disconnected\n");
> +			hidpp->once_disconnected = true;
> +		} else
> +			hid_dbg(hidpp->hid_dev, "Disconnected\n");
>  		if (hidpp->battery.ps) {
>  			hidpp->battery.online = false;
>  			hidpp->battery.status = POWER_SUPPLY_STATUS_UNKNOWN;
> ```
> 
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>
> 
> 


