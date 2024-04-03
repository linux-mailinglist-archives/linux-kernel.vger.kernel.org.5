Return-Path: <linux-kernel+bounces-130227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C6F8975B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BEC1C22602
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660FC152199;
	Wed,  3 Apr 2024 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBUtjFUc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159D1514E3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163361; cv=none; b=fghC1RUb6xJCL9nfOsgofedQlZyklvJt3u5jIjq0Qxt0TTmcR6Fp/t/PE1PI7r9WXBZvL2+8Fmnj5meWAzCVL9PHXNNLs/BnuWYgTUXpbRen/Z20571OM/xzXQyiB2buCOKwWyqWpQByfCIyh+aB/MdlhFgJcKwrT/IXLUeG9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163361; c=relaxed/simple;
	bh=4jJrjHK8mhH2+XRUWtDAF99v5nQv4WwqENIYqGi3klM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhBG3/LSAzDYBOF73tc9c7csTKLxZ26pNmJCR2pQjVGTB/YRaI8LBjw4XOvsuQa3cIyL24233kZGnu0LBmYvU+XE8CDsIyvN5TnyhkOvh7v5jhHdtQnbHw6rO9NohtDPKQ4hfJEXdA1Pmtt8qLp2HpSj8Rhj5S5jKDAAdA7K2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBUtjFUc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712163358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0tT9NwtMxOQ3/QidalKKNOGfTytjEb5HDBw0dV5sAk=;
	b=NBUtjFUcptsNW1756MJiuuTdm94sqb8R+21Z0xAqYdGNQLQ9168wi+cCeK5dNI13S5qskl
	tu6nNb/r3ysAkOTU5deDpjMjxTJXBkKPRO6/CnY5NxHqU2IWsz7/4KkYebDNZJx/DRcAV/
	0x7Mw4nl0gIqzp1HsSL+O5KWBhcsp8g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-qBsj9oqPN0iVaiZMwDPQ3Q-1; Wed, 03 Apr 2024 12:55:48 -0400
X-MC-Unique: qBsj9oqPN0iVaiZMwDPQ3Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4943e972d1so123538366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712163347; x=1712768147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0tT9NwtMxOQ3/QidalKKNOGfTytjEb5HDBw0dV5sAk=;
        b=ULyD+xxSvRZvbq4RalwBBMikkzJPCuCn26DM888+My0OLCCl7copwpdUVcuAI6yAgu
         lsNRRXa64Akpw875XlEdmeUsv9CMIZsksGfs+PjseI+FrXd1QNATYbeC5wTs498w9uA0
         HZoLqCVb9pEUvXWyF+IU80DkiS8nBhzwLCuqKqDFTh8OeYMvlKEKmHR7d9t0bpyAY8Tg
         JMTLb8emj62SoUdxlmMEk4kqzUyXi/wYe5Sie0SHmsAv3K91QjXNmI3eytvB/cUXI8zB
         gi+/L8lFo2+ylN71Uz08vrcE2oActKtYLb7kHAR+/e28DrKaFW7awNopMt6iRmFbutBq
         hw2A==
X-Forwarded-Encrypted: i=1; AJvYcCURfzkcZxjM3sPVrdtoE1gIf5cV1uiLEzoY90umdxymNlakmtTxNEXam9zfFVz7v23ZegnQS5mV0rnT6Y5XAX9OCCi5j89Zg337rdys
X-Gm-Message-State: AOJu0Yx5Iq/wBtOxXghl38ikkV7xyLnC5e0E2ptqk9RCq5l4zsWFDfP4
	GNAW2GzJZ4dDePMGIYCuWF+6lhDZ6waOkuape3kMo50AoRaWJiiNDav2w3d9TmyWmif0btkEoK1
	o6YxxGrxKshwbTASu8rKtUIuw0Xx4bp7jb68WlvOsXOhWskfKBTVNhIJ+lhOs3w==
X-Received: by 2002:a17:906:d8b:b0:a4e:9fc3:de50 with SMTP id m11-20020a1709060d8b00b00a4e9fc3de50mr194749eji.21.1712163347345;
        Wed, 03 Apr 2024 09:55:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtv1RrPtglAG1fV69TYlqzx8x7hOEFywi4AavsMfJnh4NZfMLgZdRMbPTdggQqWq7+0w6JYA==
X-Received: by 2002:a17:906:d8b:b0:a4e:9fc3:de50 with SMTP id m11-20020a1709060d8b00b00a4e9fc3de50mr194730eji.21.1712163347016;
        Wed, 03 Apr 2024 09:55:47 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t5-20020a170906a10500b00a46af5f023bsm7873735ejy.202.2024.04.03.09.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 09:55:46 -0700 (PDT)
Message-ID: <02d348c8-4125-4f72-a431-e6d62b8533cb@redhat.com>
Date: Wed, 3 Apr 2024 18:55:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] HID: logitech-dj: allow mice to use all types of
 reports
To: Yaroslav Furman <yaro330@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Lucas Zampieri <lzampier@redhat.com>, =?UTF-8?Q?Filipe_La=C3=ADns?=
 <lains@riseup.net>,
 "open list:HID LOGITECH DRIVERS" <linux-input@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <6713652f-9a44-422e-b6a7-45501093cb08@redhat.com>
 <20240403165425.114844-1-Yaroslav.Furman@softeq.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240403165425.114844-1-Yaroslav.Furman@softeq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/3/24 6:54 PM, Yaroslav Furman wrote:
> From: Yaraslau Furman <yaro330@gmail.com>
> 
> You can bind whatever action you want to the mouse's reprogrammable
> buttons using Windows application. Allow Linux to receive multimedia keycodes.
> 
> Signed-off-by: Yaraslau Furman <yaro330@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/hid/hid-logitech-dj.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index e6a8b6d8eab7..3c3c497b6b91 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -965,9 +965,7 @@ static void logi_hidpp_dev_conn_notif_equad(struct hid_device *hdev,
>  		}
>  		break;
>  	case REPORT_TYPE_MOUSE:
> -		workitem->reports_supported |= STD_MOUSE | HIDPP;
> -		if (djrcv_dev->type == recvr_type_mouse_only)
> -			workitem->reports_supported |= MULTIMEDIA;
> +		workitem->reports_supported |= STD_MOUSE | HIDPP | MULTIMEDIA;
>  		break;
>  	}
>  }


