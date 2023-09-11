Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438F479B6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbjIKVJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242399AbjIKPau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44537F2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694446199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=beFb4jOtgVaCPAjALRMLom3ODylTFoGFqg6zPcwa1kU=;
        b=OxVSjlRJikvRKcoUu+fre0mMhOjb3KrTbGjU8J6ap2VFe3urPH/0ZnQn4eB+0TiicD4Vms
        7Sic+dirwFyM2nMAsuQNY94xTu1UiiUxmMrtBhb2WSFbS5W0IpLwcGVNSLadTpl1WyuXSr
        B7nqDETrHQuGZNwAYAdVv9JIAHLVIug=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-MZf7-olMPTqQCMFxyXXg3A-1; Mon, 11 Sep 2023 11:29:57 -0400
X-MC-Unique: MZf7-olMPTqQCMFxyXXg3A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2bcb47970eeso51160001fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694446196; x=1695050996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beFb4jOtgVaCPAjALRMLom3ODylTFoGFqg6zPcwa1kU=;
        b=b7ZPyP35yJGIiSi6dZYEp4Oe6JICE/D6PmqtPwu8esxpps7E+kYFwEwsbE2Dt5QgJn
         vG8bEM2wBVcWKwhiRQy8B0uoHDag0W7oWgfZJmV7NSuKpPjfMFx0OFlscvzZ2zxIRop5
         KsvE6CCwowwYHP5ZpFs0MzJM/OFiC0isYh3vpq97ktI0t7ovZkKlcAjCpIC+TdifiS0e
         J3ZxBF2kZZw7c3VMf3gznJKO4meAUkrb2KMJr27hCAg6N8pPZ32q5NQHOhVyF+SUwcYv
         Anb15tg1xQ2Pc2tH7E69NymEsQDv5YnX/4guczhtHWaj7Llsapd/22Jv3wMBnXLz/RPN
         I++w==
X-Gm-Message-State: AOJu0YzMd4IZgE4r2PgB/3uGENdfoO7MWbUqwwGVxzsKC8t4aldRUvUx
        c1314JRGf6TqbNZfKSlXK1IKTI3+ME/e9HRjh+dP7q7RAp/lkobvEyBcK+5e2xDpTVyHCIv6HOD
        zIm4LY17PIqM2cUTMs9UEWrWV
X-Received: by 2002:a2e:9a86:0:b0:2b9:d28c:9c2d with SMTP id p6-20020a2e9a86000000b002b9d28c9c2dmr7888768lji.23.1694446196339;
        Mon, 11 Sep 2023 08:29:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCnYmSBBt/79HOY6oG86XzJSUTORWQ+TBN3kldt1k+nkoJjPzYCmkfeSD1Dy0l69/ipFgEMw==
X-Received: by 2002:a2e:9a86:0:b0:2b9:d28c:9c2d with SMTP id p6-20020a2e9a86000000b002b9d28c9c2dmr7888747lji.23.1694446196036;
        Mon, 11 Sep 2023 08:29:56 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m27-20020a1709060d9b00b009a5f7fb51d1sm5497936eji.40.2023.09.11.08.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 08:29:55 -0700 (PDT)
Message-ID: <3c54154f-dd9d-f74c-9852-5135b4bda297@redhat.com>
Date:   Mon, 11 Sep 2023 17:29:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB: add ignore remote wakeup quirk for one of Logitech's
 receivers
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     linux-usb@vger.kernel.org, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?Q?=c5=81ukasz_Bartosik?= <lb@semihalf.com>,
        Nicolas Dumazet <ndumazet@google.com>,
        Jean-Francois Le Fillatre <jflf_kernel@gmx.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Hannu Hartikainen <hannu@hrtk.in>, linux-kernel@vger.kernel.org
References: <20230910163751.4210-1-someguy@effective-light.com>
 <9d2dff10-5a3b-b24a-c3d8-3c843891966d@redhat.com>
 <ZKUT0S.QB90NRXC7O1R1@effective-light.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZKUT0S.QB90NRXC7O1R1@effective-light.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hamza,

On 9/11/23 17:19, Hamza Mahfooz wrote:
> Hey Hans,
> 
> On Mon, Sep 11 2023 at 09:32:42 AM +02:00:00, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi Hamza,
>>
>> On 9/10/23 18:37, Hamza Mahfooz wrote:
>>>  This device causes the system to wake up from suspend, as soon as it
>>>  enters it (even if the device attached to the receiver is powered off).
>>>  So, ignore remote wakeup events from it.
>>>
>>>  Cc: stable@vger.kernel.org
>>>  Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
>>>  ---
>>>   drivers/usb/core/quirks.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>>  diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
>>>  index 15e9bd180a1d..d2e2a2873f34 100644
>>>  --- a/drivers/usb/core/quirks.c
>>>  +++ b/drivers/usb/core/quirks.c
>>>  @@ -264,6 +264,10 @@ static const struct usb_device_id usb_quirk_list[] = {
>>>       /* Logitech Harmony 700-series */
>>>       { USB_DEVICE(0x046d, 0xc122), .driver_info = USB_QUIRK_DELAY_INIT },
>>>
>>>  +    /* Logitech lightspeed receiver (0xc547) */
>>>  +    { USB_DEVICE(0x046d, 0xc547), .driver_info =
>>>  +            USB_QUIRK_IGNORE_REMOTE_WAKEUP },
>>>  +
>>>       /* Philips PSC805 audio device */
>>>       { USB_DEVICE(0x0471, 0x0155), .driver_info = USB_QUIRK_RESET_RESUME },
>>>
>>
>> If this is a lightspeed receiver then it really should be handled by
>> hid-logitech-dj.c unless this new receiver is using a new protocol ?
>>
>> I wonder if adding it there also fixes the remote
>> wakeup issue (I doubt it fixes it but worth a try) ?
> 
> 
> Seems like the following series does indeed fix this issue:
> https://lore.kernel.org/linux-input/20230716182320.85483-1-mavchatz@protonmail.com/T/#u

Great, thank you for letting us know that this is resolved with
that patch series.

Regards,

Hans



