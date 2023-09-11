Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F185179A497
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjIKHdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjIKHdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2A7CE3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694417567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ti9FCfW1EJ3qUQT7yyqBbpgulOtJV84klUH5rxYtG5k=;
        b=WxniAN6eLKqyE25VuIO9t7mczbaD446EqnmITJ3Sf9YqKFpjr2/Vh3UnN2dLBailSvP2jx
        8CPJ8crnz4ExJ/wmdBUZSiWHTi8Uc5q+mno2WOVhYPPUqXnAsVUBws6HjB95leGdouQWZ9
        zUnzkmEu1PwwMQidUgpCoOMIzZi4B/o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-nl1WGxcDNYOrds3R2T2x5w-1; Mon, 11 Sep 2023 03:32:45 -0400
X-MC-Unique: nl1WGxcDNYOrds3R2T2x5w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-98e40d91fdfso284511566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694417564; x=1695022364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti9FCfW1EJ3qUQT7yyqBbpgulOtJV84klUH5rxYtG5k=;
        b=i4JkRFMXrxEF3E83+JYQw3VSX5JBsxJ9C14TjgvFwmG0r2113A3atTfjI6oNBKx526
         Eag4eDBmEjAwM0hHo3xIIwt5CggaSSrENH7nEzfOBBT4ymwShHBx0CkSQUA6g7s87+RD
         7DtyV1Iqv5A+Wmfppv2glDpdjXGaolBRzmXJL4BCHthrd/rlMugOiGdUtsRMSy4M4+cW
         SKFvAQMuK6Rg+Nfi+39XRhTskfpor0I7ztdQUTjKoDjxJ3AwuEuWdMfW4xcsb3Uub3/y
         sGuxTF6y+Vp7NrB+9ZIDgzDQyWuBjZaBSu0xlfuAgnpjvgilNVDtUTIUEG9GauAnZ70G
         2l8g==
X-Gm-Message-State: AOJu0YzKTsi6DsMVQ70HTE4UPvEv7qsG4law/ZeYHyZm6V/Rw+P+jB/d
        lmVKMo8HO4J8mIvnCoC3db89t/YRWm5bi3DhEzNRoCKkCUpYb3Vt2wpF14L7cyNIZVFugpnICDK
        Vb6lfdUstwTfa9wU5k2W/3UkN
X-Received: by 2002:a17:906:9713:b0:9a1:be5b:f4aa with SMTP id k19-20020a170906971300b009a1be5bf4aamr6744838ejx.0.1694417564842;
        Mon, 11 Sep 2023 00:32:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExhalxJVf0F18gM/jp5U3ZKr9e554M+9sO0YAvyRPyjka+NsJmLY4uGpzCLIAn+0gN52Sy4w==
X-Received: by 2002:a17:906:9713:b0:9a1:be5b:f4aa with SMTP id k19-20020a170906971300b009a1be5bf4aamr6744823ejx.0.1694417564487;
        Mon, 11 Sep 2023 00:32:44 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906394100b0099bc038eb2bsm4835138eje.58.2023.09.11.00.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 00:32:43 -0700 (PDT)
Message-ID: <9d2dff10-5a3b-b24a-c3d8-3c843891966d@redhat.com>
Date:   Mon, 11 Sep 2023 09:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB: add ignore remote wakeup quirk for one of Logitech's
 receivers
To:     Hamza Mahfooz <someguy@effective-light.com>,
        linux-usb@vger.kernel.org
Cc:     stable@vger.kernel.org,
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
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230910163751.4210-1-someguy@effective-light.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hamza,

On 9/10/23 18:37, Hamza Mahfooz wrote:
> This device causes the system to wake up from suspend, as soon as it
> enters it (even if the device attached to the receiver is powered off).
> So, ignore remote wakeup events from it.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
>  drivers/usb/core/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 15e9bd180a1d..d2e2a2873f34 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -264,6 +264,10 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	/* Logitech Harmony 700-series */
>  	{ USB_DEVICE(0x046d, 0xc122), .driver_info = USB_QUIRK_DELAY_INIT },
>  
> +	/* Logitech lightspeed receiver (0xc547) */
> +	{ USB_DEVICE(0x046d, 0xc547), .driver_info =
> +			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
> +
>  	/* Philips PSC805 audio device */
>  	{ USB_DEVICE(0x0471, 0x0155), .driver_info = USB_QUIRK_RESET_RESUME },
>  

If this is a lightspeed receiver then it really should be handled by
hid-logitech-dj.c unless this new receiver is using a new protocol ?

I wonder if adding it there also fixes the remote
wakeup issue (I doubt it fixes it but worth a try) ?

Regards,

Hans



