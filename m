Return-Path: <linux-kernel+bounces-42595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD82840393
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8CC284E34
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4E7604C9;
	Mon, 29 Jan 2024 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f42a5kof"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C55F879
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526644; cv=none; b=q6URiezwzvsW+lsCuQR4Fe7TWd8uv20L1iumr6WmJwKxhbhWZ3r7zF2P0ZKoCHWh1PvVMIft2PHXAIsuckn+tbF2bwOMjJrrp+q2adVNnBKfn24BxeyI9D+KseQgrZz5DBvf73XfHhDS0NrA45fb+OUv+F/aypANZ4wRNXFpviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526644; c=relaxed/simple;
	bh=iCt3ARyPFGaFcNNh6hPSDnvIq7kLiJZCIOO0G1SZ8xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrTwHHPi6bfGov8xE/iKWkY2JP2iH0LjmCuNNa0lUqHWg4iXlqIsBW6x/z3pw5kS3mGkDGD2prX11GSwdy41TfSkXWprPF4dkxqxYEr64aqv3QqvH6UnFWnTarT3nzRhVjE9UzsNT2TqkV2wj0cxOl+aHMXSSNPAOWmFu79AQOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f42a5kof; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706526641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VViNKQmytjZMa9HQwAlRrm1lQV2U6Y/HrJkRvfH9jxI=;
	b=f42a5kofjjL76NJRQGCmjtK4L9TAU+IAF1vfgLjkMBDsj/Wr0gc+5sgarw2Ukcwy8EjSaV
	kBpTR/2R0Wrp+LQ/2iS0jIlEHULhgSJfCQuNxgS3tqgmOmx6LhFfFlIRsjbbafKxiqk/n7
	pIa/Ehd/RzzUsKrvMjUyeYbY0kumV64=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-QWjqyMXzOLKKg4XhpytMSQ-1; Mon, 29 Jan 2024 06:10:40 -0500
X-MC-Unique: QWjqyMXzOLKKg4XhpytMSQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a30f9374db7so423101966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706526639; x=1707131439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VViNKQmytjZMa9HQwAlRrm1lQV2U6Y/HrJkRvfH9jxI=;
        b=ZI4FTvWguW3If6eG1jSsDXDwVMFnHyZ6M+wbfjBIZT5KWHKfXjF10Yhp9EA6+80fGm
         oxiWa6SVQp42brU2qIEZNrfdfZ1iZe0IzcrPxevqLpCvE+l+x30xOUA8Rh9/2vOrp5H/
         gvEdYkNodTodUNd1omQL6Svfgvpq6E0QSUYNcqdjbL9YF24Qi36cTHy4qNLZuJl9hCgN
         LTDywdQxdWF8tyYo/aeLrLoFBnjVxWyHvNP+0k3nuYmiUsKpdn/f6skv47e2O/On+7A0
         g/cQ2ssxjGQeHIY2CdDS0DpFz7ura4SoX79i/dbz0JoA+pDE9F2q70MrWFovnEVnJSgN
         uQ4Q==
X-Gm-Message-State: AOJu0YwPsW/MkTUz8F0Bk9eoODuzWt2D65lc0kcVeKTPzTGpi2r8boDH
	LXKq9cryfQPfF5E9vNotl27xNm0jQrHO9zxzSZRK27Frm2j+P+hky4QMzBoEzSzTrzC8wGTsy+o
	BffYs2FjETTzCnarfspLx7QuiY8DLUYd9gheRjrN+2WrDCSa6dhW9SR5wMGMYHQ==
X-Received: by 2002:a17:906:3691:b0:a2f:dae6:5987 with SMTP id a17-20020a170906369100b00a2fdae65987mr7350012ejc.33.1706526639095;
        Mon, 29 Jan 2024 03:10:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcHk7VsGGZmyJ31XzDUOwX/PEXGRkxnSxZgRRLBV6kLpC49QOXF5mRcEpT4h1mjOw9NQdpLQ==
X-Received: by 2002:a17:906:3691:b0:a2f:dae6:5987 with SMTP id a17-20020a170906369100b00a2fdae65987mr7349995ejc.33.1706526638797;
        Mon, 29 Jan 2024 03:10:38 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id cu2-20020a170906ba8200b00a35757cbd9esm1944925ejd.4.2024.01.29.03.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 03:10:37 -0800 (PST)
Message-ID: <4c68a68f-5fc6-4906-b958-4e2bd8fcd25a@redhat.com>
Date: Mon, 29 Jan 2024 12:10:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Flood of logitech-hidpp-device messages in v6.7
Content-Language: en-US, nl
To: Jiri Kosina <jikos@kernel.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
 Bastien Nocera <hadess@hadess.net>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
References: <3277085.44csPzL39Z@natalenko.name>
 <824573bb-ae01-41b9-8f97-a760ae8f3f18@redhat.com>
 <nycvar.YFH.7.76.2401172001530.29548@cbobk.fhfr.pm>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <nycvar.YFH.7.76.2401172001530.29548@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jiri,

On 1/17/24 20:01, Jiri Kosina wrote:
> On Tue, 9 Jan 2024, Hans de Goede wrote:
> 
>>> Jan 09 10:05:06 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
>>> Jan 09 10:07:15 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
>>> Jan 09 10:16:51 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
>>> Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
>>> Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
>>> Jan 09 10:36:31 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
>>> Jan 09 10:37:07 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
>>> Jan 09 10:46:21 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
>>> Jan 09 10:48:23 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
>>> Jan 09 11:12:27 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
>>> Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
>>> Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
>>> Jan 09 11:38:32 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
>>> Jan 09 11:43:32 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
>>> Jan 09 11:45:10 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
>>> Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
>>> Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
>>> Jan 09 12:31:48 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
>>> Jan 09 12:33:21 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
>>> ```
>>>
>>> I've got the following hardware:
>>>
>>> * Bus 006 Device 004: ID 046d:c52b Logitech, Inc. Unifying Receiver
>>> * Logitech MX Keys
>>> * Logitech M510v2
>>>
>>> With v6.6 I do not get those messages.
>>>
>>> I think this is related to 680ee411a98e ("HID: logitech-hidpp: Fix connect event race").
>>>
>>> My speculation is that some of the devices enter powersaving state after being idle for some time (5 mins?), and then wake up and reconnect once I touch either keyboard or mouse. I should highlight that everything works just fine, it is the flood of messages that worries me.
>>>
>>> Is it expected?
>>
>> Yes this is expected, looking at your logs I see about 10 messages per
>> hour which IMHO is not that bad.
>>
>> I guess we could change things to track we have logged the connect
>> message once and if yes then log future connect messages (and all
>> disconnect messages) at debug level.
>>
>> Jiri, Benjamin, do you have any opinion on this ?
> 
> Works for me, thanks. Do you plan to submit the patch implementing this?

I was planning too, but I'm a bit swamped atm. I would not mind
someone else implementing this suggestion and I would be happy
to review and test.

Regards,

Hans



