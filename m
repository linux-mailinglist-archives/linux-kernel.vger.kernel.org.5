Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E038F77B440
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjHNIfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjHNIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB41610B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692002050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RgXFFW+V5FTk3EF/2a/DSCETIneRMJrqKo+yjAx/Zs8=;
        b=M21fWXNVv6DCxvh744qt9yHARDOG/9l3sf/D2qc8l9MYY49M2z0fOo4IM5Y3SgEK1RYOsH
        hx3c0/EldtXiEt5MCYkvJoTZAY02bHT4ZXEYKGhAeCtk3wsmlyGixe8FxZkm93o/6mIsub
        Mp2NrlRZ9ncvVnVa4VeizsHnKR3e6ew=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-h4UFicKJPoONpgkyuZsfrg-1; Mon, 14 Aug 2023 04:34:08 -0400
X-MC-Unique: h4UFicKJPoONpgkyuZsfrg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99388334de6so246470866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692002047; x=1692606847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgXFFW+V5FTk3EF/2a/DSCETIneRMJrqKo+yjAx/Zs8=;
        b=D+WMUcLBfVOv4985pNEsgjrBJtxnLutjGDmVNsOfK+rHA2ZhGn3HwjSBRht4djz8e/
         K3TziYRu4RIqX6I6kZcI5iIw30XBiRj+djkS4l2j0TxRTDwqz2AZ/gnL/NxkwQX/nYnT
         tBG+bm25bCXAVf4O4p+yLJCfAUDC0M1fNGqD2ksLCqHTL4e03q6GIkczsceZXIf8dwR+
         2BehBSh0GA9Q2loi8g0zoEiCNP72pGyqteLe6HOw2kydYMVbUpxcqqnd7kUaS4koTKMH
         YRXy8tNoEndrnXzP1eRVvmLpQApgcAhbLcKRN73jyy9ut0rO7ySq7R+HSe0fcjHAGvIJ
         ubzw==
X-Gm-Message-State: AOJu0Ywhgk6J/QyiaraWkMTaNPHNpjv41G+WC2f06GR7W3qkaMY+DFq2
        4TJf+U5FWro6HreuK2ifIt1lTzWr9olmK6vXsz/UzkzdiS1D45MT5M/drv9A6yJcYay2Mau6XlA
        gMMlMEx5jqt8EgUuyprJ2HXnS
X-Received: by 2002:a17:907:7608:b0:99c:180a:ea61 with SMTP id jx8-20020a170907760800b0099c180aea61mr6625104ejc.32.1692002047132;
        Mon, 14 Aug 2023 01:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfL8E6nRn9oKZz3TvrEP1iFjy7/Sw0a6a81AvTaKtEKUsy7RECnJhv7Kt6XCM66ig2D9GMbw==
X-Received: by 2002:a17:907:7608:b0:99c:180a:ea61 with SMTP id jx8-20020a170907760800b0099c180aea61mr6625092ejc.32.1692002046875;
        Mon, 14 Aug 2023 01:34:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gf17-20020a170906e21100b00992e14af9c3sm5470076ejb.143.2023.08.14.01.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:34:06 -0700 (PDT)
Message-ID: <cf05f66b-c74e-79b8-f2ec-a41a2c7c5ead@redhat.com>
Date:   Mon, 14 Aug 2023 10:34:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: Add entries for Siemens IPC modules
Content-Language: en-US, nl
To:     Gerd Haeussler <haeussler.gerd@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Xing Tong Wu <xingtong.wu@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
References: <20230814073114.2885-1-haeussler.gerd@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230814073114.2885-1-haeussler.gerd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/14/23 09:31, Gerd Haeussler wrote:
> From: Gerd Haeussler <gerd.haeussler.ext@siemens.com>
> 
> There are different IPC driver modules in the kernel that are actively
> maintained by Siemens but not yet listed in the MAINTAINERS file.
> Add the missing entries.
> 
> Signed-off-by: Gerd Haeussler <gerd.haeussler.ext@siemens.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  MAINTAINERS | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0f966f05fb0d..6ca5564a4f8c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19402,6 +19402,32 @@ F:	drivers/media/mmc/siano/
>  F:	drivers/media/usb/siano/
>  F:	drivers/media/usb/siano/
>  
> +SIEMENS IPC LED DRIVERS
> +M:	Gerd Haeussler <gerd.haeussler.ext@siemens.com>
> +M:	Xing Tong Wu <xingtong.wu@siemens.com>
> +M:	Tobias Schaffner <tobias.schaffner@siemens.com>
> +L:	linux-leds@vger.kernel.org
> +S:	Maintained
> +F:	drivers/leds/simple/
> +
> +SIEMENS IPC PLATFORM DRIVERS
> +M:	Gerd Haeussler <gerd.haeussler.ext@siemens.com>
> +M:	Xing Tong Wu <xingtong.wu@siemens.com>
> +M:	Tobias Schaffner <tobias.schaffner@siemens.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/siemens/
> +F:	include/linux/platform_data/x86/simatic-ipc-base.h
> +F:	include/linux/platform_data/x86/simatic-ipc.h
> +
> +SIEMENS IPC WATCHDOG DRIVERS
> +M:	Gerd Haeussler <gerd.haeussler.ext@siemens.com>
> +M:	Xing Tong Wu <xingtong.wu@siemens.com>
> +M:	Tobias Schaffner <tobias.schaffner@siemens.com>
> +L:	linux-watchdog@vger.kernel.org
> +S:	Maintained
> +F:	drivers/watchdog/simatic-ipc-wdt.c
> +
>  SIFIVE DRIVERS
>  M:	Palmer Dabbelt <palmer@dabbelt.com>
>  M:	Paul Walmsley <paul.walmsley@sifive.com>

