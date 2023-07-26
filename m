Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F277763938
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjGZOeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjGZOeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:34:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10990E7E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690382011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wDJZYchIVkh7r/YkUh+Rl0n+teRoHYZgfwVCEQ3SPM=;
        b=YjbGRxC9si92zevQYcfgaSW5e3xrskg97qCpo6TzO8H6juFCBY7prx1LsjKR+jmNwmY4XC
        B0Ry7ZZSNMiFVTsKz2QIUOnftSM8c7yTPHzAWPQjwHUlLksZcUqxTisLjYDYzlJy6Vy/V9
        IswMuFuUVv5AW4I+70FCHnIS8ibLXtA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-gRtwAuPbNuSXZzAE-zoxYQ-1; Wed, 26 Jul 2023 10:33:30 -0400
X-MC-Unique: gRtwAuPbNuSXZzAE-zoxYQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bb3a2c781so126716666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690382009; x=1690986809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wDJZYchIVkh7r/YkUh+Rl0n+teRoHYZgfwVCEQ3SPM=;
        b=MD9XJ3a/aJLGX4Rr5ACIonM38QWAgty/Im0yjrw3OoyR/+cuVuTYvn4MKXGg2ATVMJ
         Mm94GUJ760ZzSyH4DPBw8jpNlMku2I/bWhDFvcUVu7XSfR7HGMv5M7sPAtW9rFuKmylP
         mpb0lg5elRj1zDD3aihhKC6ep2mOAaHt8U2QeflT8A/59FJCkKjZfm8Houx3wRKUuyD9
         EzDBm/YEBbeO/SW6j0djHjt9aYsqmHalDsg6wyjeEWB10a+GE2N5BVJqGVammxb/dYHv
         3HhKnv7lkKbgnudjKuCIKtYFRuhoGE1dUJODHnTnNrjm749Noo1jUDeOhqe6urOOu+2J
         6Orw==
X-Gm-Message-State: ABy/qLb2IYOQWGTXvUFiemBBt8B/bK8c3bpOwars34uM8eIuhfNh1rzj
        m9mUdj8Y9n07U8pExYu0S2/gphgFW0fjYNXDR7hvful53QaKYFO/KqpZSAUNYzj1h405mKd5x63
        Pafa8lwDznwFunDdAGdtSZ7gG
X-Received: by 2002:a17:907:b1a:b0:96f:d780:5734 with SMTP id h26-20020a1709070b1a00b0096fd7805734mr1771762ejl.65.1690382008869;
        Wed, 26 Jul 2023 07:33:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHQ7Jl1vFcoJO5H3B3T2jHjkZsTJJQ9AZIMD7NmPJVqhhhgbo++OMGJO7db6cml3nWvZ4siLQ==
X-Received: by 2002:a17:907:b1a:b0:96f:d780:5734 with SMTP id h26-20020a1709070b1a00b0096fd7805734mr1771748ejl.65.1690382008528;
        Wed, 26 Jul 2023 07:33:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090608d300b0098d2f703408sm9648295eje.118.2023.07.26.07.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 07:33:28 -0700 (PDT)
Message-ID: <5fdc06b2-22bc-1470-e60c-1e388774ee4b@redhat.com>
Date:   Wed, 26 Jul 2023 16:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: dwc3: pci: skip BYT GPIO lookup table for hardwired
 phy
Content-Language: en-US, nl
To:     Gratian Crisan <gratian.crisan@ni.com>, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, felipe.balbi@linux.intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gratian@gmail.com
References: <20230717170552.466914-1-gratian.crisan@ni.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230717170552.466914-1-gratian.crisan@ni.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/17/23 19:05, Gratian Crisan wrote:
> Hardware based on the Bay Trail / BYT SoCs require an external ULPI phy for
> USB device-mode. The phy chip usually has its 'reset' and 'chip select'
> lines connected to GPIOs described by ACPI fwnodes in the DSDT table.
> 
> Because of hardware with missing ACPI resources for the 'reset' and 'chip
> select' GPIOs commit 5741022cbdf3 ("usb: dwc3: pci: Add GPIO lookup table
> on platforms without ACPI GPIO resources") introduced a fallback
> gpiod_lookup_table with hard-coded mappings for Bay Trail devices.
> 
> However there are existing Bay Trail based devices, like the National
> Instruments cRIO-903x series, where the phy chip has its 'reset' and
> 'chip-select' lines always asserted in hardware via resistor pull-ups. On
> this hardware the phy chip is always enabled and the ACPI dsdt table is
> missing information not only for the 'chip-select' and 'reset' lines but
> also for the BYT GPIO controller itself "INT33FC".
> 
> With the introduction of the gpiod_lookup_table initializing the USB
> device-mode on these hardware now errors out. The error comes from the
> gpiod_get_optional() calls in dwc3_pci_quirks() which will now return an
> -ENOENT error due to the missing ACPI entry for the INT33FC gpio controller
> used in the aforementioned table.
> 
> This hardware used to work before because gpiod_get_optional() will return
> NULL instead of -ENOENT if no GPIO has been assigned to the requested
> function. The dwc3_pci_quirks() code for setting the 'cs' and 'reset' GPIOs
> was then skipped (due to the NULL return). This is the correct behavior in
> cases where the phy chip is hardwired and there are no GPIOs to control.
> 
> Since the gpiod_lookup_table relies on the presence of INT33FC fwnode
> in ACPI tables only add the table if we know the entry for the INT33FC
> gpio controller is present. Additionally check the 'cs' gpio handle is
> not NULL before using it (like we do for the 'reset' line). This
> allows Bay Trail based devices with hardwired dwc3 ULPI phys to
> continue working.
> 
> Fixes: 5741022cbdf3 ("usb: dwc3: pci: Add GPIO lookup table on platforms without ACPI GPIO resources")
> Signed-off-by: Gratian Crisan <gratian.crisan@ni.com>
> ---
>  drivers/usb/dwc3/dwc3-pci.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
> index 44a04c9b2073..780984b07437 100644
> --- a/drivers/usb/dwc3/dwc3-pci.c
> +++ b/drivers/usb/dwc3/dwc3-pci.c
> @@ -233,10 +233,12 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc,
>  
>  			/*
>  			 * A lot of BYT devices lack ACPI resource entries for
> -			 * the GPIOs, add a fallback mapping to the reference
> +			 * the GPIOs. If the ACPI entry for the GPIO controller
> +			 * is present add a fallback mapping to the reference
>  			 * design GPIOs which all boards seem to use.
>  			 */
> -			gpiod_add_lookup_table(&platform_bytcr_gpios);
> +			if (acpi_dev_present("INT33FC", NULL, -1))
> +				gpiod_add_lookup_table(&platform_bytcr_gpios);
>  
>  			/*
>  			 * These GPIOs will turn on the USB2 PHY. Note that we have to

Thanks this change looks good to me.

> @@ -247,8 +249,10 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc,
>  			if (IS_ERR(gpio))
>  				return PTR_ERR(gpio);
>  
> -			gpiod_set_value_cansleep(gpio, 1);
> -			gpiod_put(gpio);
> +			if (gpio) {
> +				gpiod_set_value_cansleep(gpio, 1);
> +				gpiod_put(gpio);
> +			}
>  
>  			gpio = gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
>  			if (IS_ERR(gpio))

But this is not necessary both gpiod_set_value_cansleep() and gpiod_put() handle being called with NULL gracefully (so they handle NULL returned by gpiod_get_optional() without issues) .

Can you please post a version 2 of this patch dropping this unnecessary change?

Regards,

Hans


