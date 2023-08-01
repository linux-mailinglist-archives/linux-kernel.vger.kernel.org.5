Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1425176AC97
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjHAJOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjHAJOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943DA30F8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690881024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SxWFjCCAM3ihInbD4ANY0NAVJ+r4OZ28eSTne+Tfr18=;
        b=R5ph2uJZdFtLquFiNZsEFKQn3YhImvb/1huTPGAeim15IbzVacs4DknUAHUjvLlLd6pxYd
        wNgz3WMWr6Y5ga2En576zb9sNchCQj5gkMuoZNXGxHkJ4/fUlSbjbfKQidfeM2044XWY+z
        Kj+ZE0AZpr+qwAGDsMJmcdyCLlOOiEc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-LyX_gRkJO7qVKwKNTisOLw-1; Tue, 01 Aug 2023 05:10:22 -0400
X-MC-Unique: LyX_gRkJO7qVKwKNTisOLw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a355cf318so436297766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 02:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690881022; x=1691485822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxWFjCCAM3ihInbD4ANY0NAVJ+r4OZ28eSTne+Tfr18=;
        b=Fkh+sP4JrdPV4SAJFcbW5ajJQBWwn+grRHPOS/WIoJmuVOOBWlzDytNYc8fJcSSfDO
         Gr6KrdV0A6N4wNYLw4s3ZmjDyLuznm5b+rxYT6fx+wIWCKp/PYiCJmh/9TLDRYW5GvUd
         y8suBDjrWqkQrYW1wLfunLSYu8+GcDnvzuHic5ZAEeQViGRzmDPzLVj3ny3GQ7SQNycF
         V79k1bCu0VtN5gfecfAh/cNFG3DXe93sSwtb+F8VKE/rHQJ/qQA7EvkZb66ivZ88r8O3
         onlnK5DOFNDE8BdIAMQuEpGmEf3WTSgBzITbpvbSoIKLV4oZhz5SbYJOckrVtX3jIBo4
         rZDA==
X-Gm-Message-State: ABy/qLbgCnNnnyrjI03BlAiAYk2Q64/2gva5HEF34N07eoQfhDbRFys2
        utO6yucENhfOupp8VlZxltB7NaBI6ibTKigwSJMWH6fCVSC9ZlgOQmOYtT2gBvUKVUQJwIfLGw7
        fdcGjmS2cYXT1wvv76L08wFZ3
X-Received: by 2002:a17:906:1d9:b0:992:9756:6a22 with SMTP id 25-20020a17090601d900b0099297566a22mr1923878ejj.48.1690881021848;
        Tue, 01 Aug 2023 02:10:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlED1JBaSc5+efiYma1WksHdzfTB4bo//PvWCEO5Zke8EubdRGKbEqTUv71WdddGZ1AYb/dIZA==
X-Received: by 2002:a17:906:1d9:b0:992:9756:6a22 with SMTP id 25-20020a17090601d900b0099297566a22mr1923859ejj.48.1690881021603;
        Tue, 01 Aug 2023 02:10:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s13-20020a1709060c0d00b00988b8ff849csm7269644ejf.108.2023.08.01.02.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 02:10:21 -0700 (PDT)
Message-ID: <18b3a57f-0f8f-6177-4414-0b1f821d9a2d@redhat.com>
Date:   Tue, 1 Aug 2023 11:10:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] platform/x86/siemens: simatic-ipc: fix logic error in
 BX-59A
Content-Language: en-US, nl
To:     xingtong_wu@163.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, xingtong.wu@siemens.com,
        lee@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gerd.haeussler.ext@siemens.com, tobias.schaffner@siemens.com,
        kernel test robot <lkp@intel.com>
References: <20230731071424.4663-2-xingtong_wu@163.com>
 <20230801090423.4747-1-xingtong_wu@163.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230801090423.4747-1-xingtong_wu@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi xingtong,

Thank you for the quick fixes for the issues lkp spotted.

I'll merge these into the pdx86-simatic-ipc branch next time
I do a round of merges (within about a week).

Regards,

Hans





On 8/1/23 11:04, xingtong_wu@163.com wrote:
> From: "xingtong.wu" <xingtong.wu@siemens.com>
> 
> There is a bug in if statement that lead to logical error
> and have influence to other IPC, it get correct now.
> 
> Fixes: b8af77951941 ("platform/x86/siemens: simatic-ipc: add new models BX-56A/BX-59A")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307312322.Aa8upHWK-lkp@intel.com/
> Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
> ---
>  drivers/platform/x86/siemens/simatic-ipc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/siemens/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
> index 02c540cf4070..8ca6e277fa03 100644
> --- a/drivers/platform/x86/siemens/simatic-ipc.c
> +++ b/drivers/platform/x86/siemens/simatic-ipc.c
> @@ -129,7 +129,7 @@ static int register_platform_devices(u32 station_id)
>  		pdevname = KBUILD_MODNAME "_leds";
>  		if (ledmode == SIMATIC_IPC_DEVICE_127E)
>  			pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
> -		if (ledmode == SIMATIC_IPC_DEVICE_227G || SIMATIC_IPC_DEVICE_BX_59A)
> +		if (ledmode == SIMATIC_IPC_DEVICE_227G || ledmode == SIMATIC_IPC_DEVICE_BX_59A)
>  			pdevname = KBUILD_MODNAME "_leds_gpio_f7188x";
>  		if (ledmode == SIMATIC_IPC_DEVICE_BX_21A)
>  			pdevname = KBUILD_MODNAME "_leds_gpio_elkhartlake";

