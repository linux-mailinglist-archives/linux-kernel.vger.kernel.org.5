Return-Path: <linux-kernel+bounces-130108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77995897427
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB401F271B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC2414A0B8;
	Wed,  3 Apr 2024 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xt+zSeA6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BBF149E14
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158726; cv=none; b=DJPvVpeXPB9Rd9Cd8NixL7DYpg8ixYTHachL+rF0V38gT/1v22NR5HZ5IhcsGbRdqQzWnPT1vgvEEofK64+kvP2swFxVHqdGwj3BppJcbsuzyYE3SDPGo/a6YU19zG/7/eCWCR+ZFTNfi1Nh+0MWhS04oG4QL1jHW5DaCIj3DZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158726; c=relaxed/simple;
	bh=gvXAN8FqAYyv/zTvnFyrftLXCVC6JR3X40KuZJIRr0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qInObke7tk2sugajHT26PtVPBxqA0VN2IWYUDeiT1rGBHWFb4ldAhbhKUGkUtlhd63woiJeHZ210l15htsCMIgBHmLbJjfiaxGfcOCoEYHObHXhvUPSVUgJHxdJfY8yM78zLkUOO39QHfDfUt+3P4Ouhy5o/0qVrvdvHrIzQCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xt+zSeA6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712158723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ulisZosQVDxfmEDrSXMzfQcC4WL56xkDy6UZQgPC9w=;
	b=Xt+zSeA6JK9ZxYsl3OchfJobtmQsGIaB8CrZXpU8WrofRT6lzUgx3YQ+VNvrpnFybNDrl6
	GS8eFZicItS27VgIix1XBaAKoSDLpDmt7vMoTNaodKO19cD3+C1RgGfuPqK86a2SVmMj54
	g/9Sdg+rFPFXWkcp624KsX9bEdSuQgg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-nl15fDDKMz6L_3DKUJY1OA-1; Wed, 03 Apr 2024 11:38:40 -0400
X-MC-Unique: nl15fDDKMz6L_3DKUJY1OA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-516ae539accso3467742e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 08:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712158719; x=1712763519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ulisZosQVDxfmEDrSXMzfQcC4WL56xkDy6UZQgPC9w=;
        b=lJ/3HPFTap2aMkJ6Wz595jGe2G4Pflc1+O/+5yLh3ndkW8hfQNSqmc9cPlFHKQ1HCv
         IJrRHFP+Bfit/Jmcm+EUCGq2ujuRaTETTjsBJ9OEGREAu7rtNYNxDbMH60SJlfKsmJWe
         Wi7q2UFYzP6C2ax7eDL1P1weffJrqYtRDCmc/6NVs5E7CtFBfnjbIL5JmOCJaDjmtMrQ
         WeR7CxN0wAQuLRy+XRLKyJIDMwkhc9FuiKRIvGdg9yVqqPisOReqvnNYUCb07qYiLVF6
         SDvYhLEFBLiB0vBE3I3dBRwts8nrQ4dhvgR2RkQrD7H4fyXZ6hU96sgsmdBCsaSdX2LB
         zlSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVVfm8NaC/PzS0Z+gZZrOarTklqMVLhmJVw+knzhnmyuQYz1tv858HU2gd6295i+BZcWefCXcCEEIFy6Ig5rH6+w5dNr2E1lEr4kUS
X-Gm-Message-State: AOJu0YwSuELXlKO2BYMioPt/GJgIPbcSc8ZATx3ULWwvxciXETk/lvWg
	bH+lv9zrCUKwGVED4DFn+B9PE5L0RjuNzgmmLoSfGD3HL20Gf7w7ey1E2X0tIEvhTBnDvgEG1hU
	8KiPB3J7cFdH4HWUTnDTeLaZIGgNiAHEwPmNSkqWqXhxWZlq+hLUiyQVgbdoOPQ==
X-Received: by 2002:a19:c509:0:b0:515:af1f:5bad with SMTP id w9-20020a19c509000000b00515af1f5badmr3726476lfe.28.1712158719404;
        Wed, 03 Apr 2024 08:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWDpvKh5HePjjuSqDW7G2f74KFaLPXqg8tpOijWh7Nbj6ROZij9vpsI449A6cEWrPjqHuEJA==
X-Received: by 2002:a19:c509:0:b0:515:af1f:5bad with SMTP id w9-20020a19c509000000b00515af1f5badmr3726444lfe.28.1712158718687;
        Wed, 03 Apr 2024 08:38:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id o1-20020a1709064f8100b00a46baba1a0asm7870261eju.100.2024.04.03.08.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 08:38:38 -0700 (PDT)
Message-ID: <6713652f-9a44-422e-b6a7-45501093cb08@redhat.com>
Date: Wed, 3 Apr 2024 17:38:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] HID: logitech-dj: allow mice to report multimedia
 keycodes
To: Yaroslav Furman <yaro330@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Lucas Zampieri <lzampier@redhat.com>, =?UTF-8?Q?Filipe_La=C3=ADns?=
 <lains@riseup.net>,
 "open list:HID LOGITECH DRIVERS" <linux-input@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <7e34dc43-b70b-4a50-86fd-f021f2de4845@redhat.com>
 <20240403150638.18749-1-Yaroslav.Furman@softeq.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240403150638.18749-1-Yaroslav.Furman@softeq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yaroslav,

On 4/3/24 5:06 PM, Yaroslav Furman wrote:
> From: Yaraslau Furman <yaro330@gmail.com>
> 
> So, I think this should work fine for now, but IMO we should see if it's
> possible to allow the driver to receive all events that a keyboard can send,
> since Windows application can assign pretty much any keycode to any mouse
> button (perhaps not the main ones though), and then we might see the same situation again.
> 
> I tried doing that on my system but the driver stopped working completely.

The actual code change itself looks fine, but the above should have gone
into a cover-letter or something like that.

This is not a proper commit message and this is also lacking
your Signed-off-by (which you did correctly include in your
original version:

https://lore.kernel.org/linux-input/20240128214906.60606-1-yaro330@gmail.com/

Please send a v3 with a proper commit-msg + Signed-off-by.

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


