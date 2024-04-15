Return-Path: <linux-kernel+bounces-145713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CF38A59EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265231F214A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539061482E0;
	Mon, 15 Apr 2024 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANoLH6Zh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48FF146A8E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205882; cv=none; b=ATh8fPya3xYAgfqUrllYze02/x2SfXurySu00JAdzmeQ0mMY7niReRfFZyck+oEicylKNGc0zuOTG6KXTd8x4a9AJlPYRFBJy+RJgNeALyOtjSZisMlvmfTxm+PJEhFXy4SsMeLXfFWVrqpUKfw77K8/ojgAWIPche3X+kIZrmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205882; c=relaxed/simple;
	bh=rbjN55/twTwEsELzNM2DrghMIjWahgL+CbSZGgK2kRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/uSYh/fIo4paWNrWZ7zf9eh6lsqF9kKRBDnCKmoTNRqt2fDgzoXhjd2LRmeInDXq3Oi83a+AoDu8IrWQpiCAd5jWUMhEDQFr39Ec9A9Gup+OJBZKlC8tfCyZerrwGWdYkTa4+pP+S4WEdJHjj4V64nEQuapsDVXcDuM6WZOPhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ANoLH6Zh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713205878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4rTYTifbBACIVtjbPwoBhU+3Zfa37muzb1zYig/CPU=;
	b=ANoLH6ZhCwWC5lr9CjQ9GWEAvzUEPzFY/8wtr50KjcvXmJdonWcxa/tL8oqIKoQPE90aRt
	TmqgkBMJy1uB6bgQfGSKmLs8So2ICxcrfQ7QzFaIae+8/7U/BEwW/QUHvBbnLyykFWv3hW
	VESdGk2YRC4/q0AkHC2A4+mTKqa5jng=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-IwMi2j-xO0iNImCkmXLnqA-1; Mon, 15 Apr 2024 14:31:17 -0400
X-MC-Unique: IwMi2j-xO0iNImCkmXLnqA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5199cc13b2so331391566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205876; x=1713810676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4rTYTifbBACIVtjbPwoBhU+3Zfa37muzb1zYig/CPU=;
        b=QHj7NLOa0DtDlvu9zOU9I+7bWNPktEwtveMl53SqCVNsCUHzDHKAQE4ObyA274OVUY
         ISb9J2oRUKfhAcQTH68tVaRKQ9a+6iqZIryXkNkPU9WA/74ANbsDBFi7oQToLcH2/LGe
         IRR6G3gsPuKda+pQbD14/YrCijixod8m5aT5IpBGgC3k/Ld83PIIVQiF8n89tFbZOM33
         rGUZoQnrqz5J4s/oUq93JhUBUEY/cx6GAV3EwkFP091TprAEjabxx8WC74GWT4ne1qpK
         PgWVgM02Q2PL7NCaSRQKECuxLBjbVoY0CAkJd29x+CCuHAS15TSIlEKm7MDDi5/Wgvtz
         Md5w==
X-Forwarded-Encrypted: i=1; AJvYcCUOCRHKqxmtzqdg1vkg8ISOCh3d86ph0Q4a6v9SwFNA56LodmIdkSyc8kFG2tVdozIZdpEUiPKxN4IrDCAKGSY24Mvx7vTc/c2KDdJG
X-Gm-Message-State: AOJu0YxLY02euynpNbBomCfJCIP2Gvx572v1MMZfrEUiON3NNLMAFmYu
	ij3NXifxDIFZGcath3fpaQKiJdu5ULACVUnbxotHzPiGsGF2EbnFqKoiaqABZPSdxntY9fWAM7c
	5QvMq/cqlQAupIGK7zt4P0rIWaxM/Q5PpIjTrMl8Jf8gGJYwTD63Sa0ov3IhUWA==
X-Received: by 2002:a17:906:33d6:b0:a51:d475:aca3 with SMTP id w22-20020a17090633d600b00a51d475aca3mr407782eja.16.1713205875741;
        Mon, 15 Apr 2024 11:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCe0pVnoTmOU35mmZssPwIWRigMO8z3xgUCoe03M0tTPC6sEo/k/+AE2hh+cdWdBxoyUxCKA==
X-Received: by 2002:a17:906:33d6:b0:a51:d475:aca3 with SMTP id w22-20020a17090633d600b00a51d475aca3mr407768eja.16.1713205875380;
        Mon, 15 Apr 2024 11:31:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id dm11-20020a170907948b00b00a51eed4f0d7sm5734728ejc.130.2024.04.15.11.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 11:31:15 -0700 (PDT)
Message-ID: <fe2980e3-3204-4572-9c7c-1e960727e1d4@redhat.com>
Date: Mon, 15 Apr 2024 20:31:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Logitech Anywhere 3SB support
To: Benjamin Tissoires <bentiss@kernel.org>, kde@carewolf.com
Cc: lains@riseup.net, hadess@hadess.net, jikos@kernel.org,
 benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Allan Sandfeld Jensen <allan.jensen@qt.io>
References: <20240413095453.14816-1-kde@carewolf.com>
 <ntsifcsfo5i6xisxbgfjdpe4uenygqxrt3v5sceflgipznw6cb@gnhvkjmglrtg>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ntsifcsfo5i6xisxbgfjdpe4uenygqxrt3v5sceflgipznw6cb@gnhvkjmglrtg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/15/24 5:54 PM, Benjamin Tissoires wrote:
> [Ccing Hans as well for input]
> 
> On Apr 13 2024, kde@carewolf.com wrote:
>> From: Allan Sandfeld Jensen <allan.jensen@qt.io>
>>
> 
> FWIW, this patch neesd a commit description and signed-offs
> 
>> ---
>>  drivers/hid/hid-ids.h            |  1 +
>>  drivers/hid/hid-logitech-dj.c    | 10 +++++++++-
>>  drivers/hid/hid-logitech-hidpp.c |  2 ++
>>  3 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 2235d78784b1..4b79c4578d32 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -849,6 +849,7 @@
>>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1	0xc539
>>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1	0xc53f
>>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_POWERPLAY	0xc53a
>> +#define USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER		0xc548
>>  #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
>>  #define USB_DEVICE_ID_SPACENAVIGATOR	0xc626
>>  #define USB_DEVICE_ID_DINOVO_DESKTOP	0xc704
>> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
>> index c358778e070b..92b41ae5a47c 100644
>> --- a/drivers/hid/hid-logitech-dj.c
>> +++ b/drivers/hid/hid-logitech-dj.c
>> @@ -120,6 +120,7 @@ enum recvr_type {
>>  	recvr_type_27mhz,
>>  	recvr_type_bluetooth,
>>  	recvr_type_dinovo,
>> +	recvr_type_bolt,
> 
> I am *really* hesitant in integrating the bolt receiver into
> logitech-dj.ko:
> - the bolt receiver is not capable of making the distinction between the
>   source of the events (so only one mouse/keyboard can be used at the
>   time)
> - we still have a couple of outstanding and impossible to debug issues
>   with some high resolution mice connected over the unifying receiver,
>   and adding one more receiver makes me nervous
> - I have a strong feeling by reading the code that the keyboard part
>   will fail (there is a comment "For the keyboard, we can reuse the same
>   report by using the second byte which is constant in the USB HID
>   report descriptor." though I can't seem to find this constant report
>   on the bolt receiver)
> - what are the benefits of adding it?
> - will it break fwupd?

FWIW I'm also not in favor of stretching drivers/hid/hid-logitech-dj.c
even further to also support the new bolt stuff.

AFAIK the new bolt stuff is significantly different.

Allan, I see in your other reply that you are mainly after
highres scrolling and since the bolt receiver does not do
per paired device addressing I wonder if you cannot just
get that by treating the bolt receiver as a wired HIDPP
device and just directly listing it as such in
hid-logitech-hidpp.c ?

The whole purpose of hid-logitech-dj.c is to create 1 virtual
hidpp devices per paired device and with bolt that is not
possible, so I think that we should circumvent hid-logitech-dj.c
for bolt and if we want to use any hidpp features do so
by directly listing the receivers in hid-logitech-hidpp.c .

Regards,

Hans





> 
>>  };
>>  
>>  struct dj_report {
>> @@ -1068,6 +1069,7 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
>>  		workitem.reports_supported |= STD_KEYBOARD;
>>  		break;
>>  	case 0x0f:
>> +	case 0x10:
>>  	case 0x11:
>>  		device_type = "eQUAD Lightspeed 1.2";
>>  		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
>> @@ -1430,7 +1432,8 @@ static int logi_dj_ll_parse(struct hid_device *hid)
>>  		dbg_hid("%s: sending a mouse descriptor, reports_supported: %llx\n",
>>  			__func__, djdev->reports_supported);
>>  		if (djdev->dj_receiver_dev->type == recvr_type_gaming_hidpp ||
>> -		    djdev->dj_receiver_dev->type == recvr_type_mouse_only)
>> +		    djdev->dj_receiver_dev->type == recvr_type_mouse_only ||
>> +		    djdev->dj_receiver_dev->type == recvr_type_bolt)
>>  			rdcat(rdesc, &rsize, mse_high_res_descriptor,
>>  			      sizeof(mse_high_res_descriptor));
>>  		else if (djdev->dj_receiver_dev->type == recvr_type_27mhz)
>> @@ -1773,6 +1776,7 @@ static int logi_dj_probe(struct hid_device *hdev,
>>  	case recvr_type_dj:		no_dj_interfaces = 3; break;
>>  	case recvr_type_hidpp:		no_dj_interfaces = 2; break;
>>  	case recvr_type_gaming_hidpp:	no_dj_interfaces = 3; break;
>> +	case recvr_type_bolt:		no_dj_interfaces = 4; break;
> 
> 4? The device I have here only has 3 (unless I misremember how this is
> supposed to be working).
> 
>>  	case recvr_type_mouse_only:	no_dj_interfaces = 2; break;
>>  	case recvr_type_27mhz:		no_dj_interfaces = 2; break;
>>  	case recvr_type_bluetooth:	no_dj_interfaces = 2; break;
>> @@ -1950,6 +1954,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
>>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>  		USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2),
>>  	 .driver_data = recvr_type_dj},
>> +	{ /* Logitech bolt receiver (0xc548) */
>> +	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>> +		USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER),
>> +	 .driver_data = recvr_type_bolt},
>>  
>>  	{ /* Logitech Nano mouse only receiver (0xc52f) */
>>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
>> index 3c00e6ac8e76..509142982daa 100644
>> --- a/drivers/hid/hid-logitech-hidpp.c
>> +++ b/drivers/hid/hid-logitech-hidpp.c
>> @@ -4380,6 +4380,8 @@ static const struct hid_device_id hidpp_devices[] = {
>>  	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
>>  	{ /* MX Master 3S mouse over Bluetooth */
>>  	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb034) },
>> +	{ /* MX Anywhere 3SB mouse over Bluetooth */
>> +	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb038) },
> 
> That I can accept, however know that there is a regression in bluez
> 0.73[0] (but it should be fixed in 0.74)
> 
> Cheers,
> Benjamin
> 
> 
> [0] https://github.com/bluez/bluez/issues/778#issuecomment-2048870358
> 
>>  	{}
>>  };
>>  
>> -- 
>> 2.39.2
>>
> 


