Return-Path: <linux-kernel+bounces-129891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BDF8971B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944ED1C259BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CDD148FE2;
	Wed,  3 Apr 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sj+17mbF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE97148FE0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152462; cv=none; b=a2aGbg9ORmKHE1ef+3wzE+awOA1p3YwMnwGZkK6I5nLV+vtpNgscz2xEJKG9HMhhQtmXixqAbICDn/BjZqrSViFxW9oPJgL8/N2MeZOlpYNg8LrE/YvBFChvcgumyIZ7XPF7qBLE5QjltVCkiBBg8iyDDXw1lzFi9/D+4tpUUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152462; c=relaxed/simple;
	bh=RXLoHtHrC8ukxZ2Y2WmnZ8gQy73qnQHVXwwhcK8X7kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXPBD3IiZdToOm2MTirEaljWyC22Hnz7BSE1/xC7CYtISnfjzFN4RoCod8EcTZm7weZSS/uPyRboBot9SL1npafazwK+UHABtlMbIvt6Yuud1XP5Va4dYMbPtp7epDa0Xsm927heduesi1x0/M3U2fgj9Y/I18JYtGwn6rdDDjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sj+17mbF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712152460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSiIi4jwkenKcpEhgfsqYcfzBPgshw2+qM6tAw1FbuA=;
	b=Sj+17mbFVdM6oTvirH+5pA7qFlkKuuWsgokWLwyu8hgfmLBv2mDCoDUpVgtd20rWnaBewI
	PHLQ3eJ0mIUsyMArS012WyW95oz7tEs1D4R1jEsBzr8ugWFSpNLp/8Zen/sCjHbByAiCKy
	ALwpxCDXBdv31P+SRyB4PLkDXgkpvUw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-JnypC3hfNYSKkGcpF2qP0Q-1; Wed, 03 Apr 2024 09:54:18 -0400
X-MC-Unique: JnypC3hfNYSKkGcpF2qP0Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4dfdbdaf06so368650466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 06:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712152457; x=1712757257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSiIi4jwkenKcpEhgfsqYcfzBPgshw2+qM6tAw1FbuA=;
        b=PMrwjxcR2yQhGFMZsoHPTEoARIUk8Hn6a0Kfv+nElP0zf1CfaP6MSEvid4TkZrQEvG
         67ea698bFxbNysktblARIT7E2EYNGTbSRKTfdBj63sk6Orje4ogX8Zl70PTcdhm7I2CX
         xppZCQcbJJY4cYCM67KbSreyAAHZ9nA2R6rwR4z6X5ABM+x9XUwW01GAuotMEQLVQOWP
         VMnVuK3KhxxnGNbToIHIOYzviruCahF3c0Fjfp6TIVRxLySgQ60Jxy5Gy3f2b+dzPeQf
         YwdT8xJIvqpfA9jQw5fFJZRbeKHcKXxu01RK4W7qf3ql9yzVpkjt/FSVvFa69WwH+xQR
         AYAw==
X-Forwarded-Encrypted: i=1; AJvYcCV7HXdnyO6blBqE74k7FnZpOGj3DXCr1cGF1uW8vfj3nfDWanfptOdWOFNss57iJfki5NypEeD5FWE3U0cAVGHJ85qNe0fVdyechtRn
X-Gm-Message-State: AOJu0Yy1JaqCEaxL1Y71qClVclXjGGmhwOKRyOItrKKU9KW8RJKabsBy
	sbBOUU8LDgj6qy3TuPflGojtj5BB4jFVuw8MIsmioRr7vTx4wJPeC4LFHuw8eN5OrPXoMCUQ4rg
	CBkHbyIP5jCOD6Pfbp92TPGcUQIpkLV771VVOOEWdDu2opq1qeruotrP13AzFOg==
X-Received: by 2002:a17:906:6092:b0:a4e:15f9:f167 with SMTP id t18-20020a170906609200b00a4e15f9f167mr9002779ejj.11.1712152457644;
        Wed, 03 Apr 2024 06:54:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoSOvPZGC5BbyN89YHOc2mvItFoWzIrM+d3N35txLH/zQGfd0P54JGQmzF7146oTQlRm28Qg==
X-Received: by 2002:a17:906:6092:b0:a4e:15f9:f167 with SMTP id t18-20020a170906609200b00a4e15f9f167mr9002768ejj.11.1712152457303;
        Wed, 03 Apr 2024 06:54:17 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id x15-20020a170906710f00b00a46cc48ab13sm7769314ejj.62.2024.04.03.06.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:54:16 -0700 (PDT)
Message-ID: <7e34dc43-b70b-4a50-86fd-f021f2de4845@redhat.com>
Date: Wed, 3 Apr 2024 15:54:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] HID: logitech-dj: allow mice to report multimedia
 keycodes
To: Jiri Kosina <jikos@kernel.org>, Yaraslau Furman <yaro330@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Lucas Zampieri <lzampier@redhat.com>, =?UTF-8?Q?Filipe_La=C3=ADns?=
 <lains@riseup.net>,
 "open list:HID LOGITECH DRIVERS" <linux-input@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240130111700.11666-1-yaro330@gmail.com>
 <20240222101811.18921-1-yaro330@gmail.com>
 <nycvar.YFH.7.76.2404031337250.20263@cbobk.fhfr.pm>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <nycvar.YFH.7.76.2404031337250.20263@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

On 4/3/24 1:38 PM, Jiri Kosina wrote:
> On Thu, 22 Feb 2024, Yaraslau Furman wrote:
> 
>> Multimedia buttons can be bound to the mouse's extra keys in Windows application.
>> Let Linux receive those keycodes.
>>
>> Signed-off-by: Yaraslau Furman <yaro330@gmail.com>
>> ---
>>  drivers/hid/hid-logitech-dj.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
>> index e6a8b6d8eab7..3c3c497b6b91 100644
>> --- a/drivers/hid/hid-logitech-dj.c
>> +++ b/drivers/hid/hid-logitech-dj.c
>> @@ -965,9 +965,7 @@ static void logi_hidpp_dev_conn_notif_equad(struct hid_device *hdev,
>>  		}
>>  		break;
>>  	case REPORT_TYPE_MOUSE:
>> -		workitem->reports_supported |= STD_MOUSE | HIDPP;
>> -		if (djrcv_dev->type == recvr_type_mouse_only)
>> -			workitem->reports_supported |= MULTIMEDIA;
>> +		workitem->reports_supported |= STD_MOUSE | HIDPP | MULTIMEDIA;
>>  		break;
> 
> CCing Hans who introduced this explicit check back in 3ed224e273ac 
> ("HID: logitech-dj: Fix 064d:c52f receiver support").
> Should it be made device-specific?

Jiri, thank you for bringing this to my attention. If mice attached
to other receivers can send multi-media key presses too, then I believe
that dropping the if (djrcv_dev->type == recvr_type_mouse_only) check
is fine.

IOW, the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





