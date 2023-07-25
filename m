Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB33761BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjGYOjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjGYOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992CDE9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690295936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1h7vN7gw4b4VUnOpoTb+gc+Y2pZRY71isTItrRoM2k=;
        b=URBNT+QCQXIwcyus64B7D91ZZfaC6qbGVMP3EDC93CNCDrfR05pt1J8h4omucbIslrt6zK
        xeqidNspg1KEcYdGKjyP0Y/t7a50mVxHrCNnsIzTTqDXLkaF2uvkjHzI38xzSGpgI4java
        U6loVuJmV0NxsGbGzLoBBv1Bnn5a1HY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-b6JAvIriNzaYTDV91dkn6g-1; Tue, 25 Jul 2023 10:38:55 -0400
X-MC-Unique: b6JAvIriNzaYTDV91dkn6g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-997c891a88dso446348666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690295934; x=1690900734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1h7vN7gw4b4VUnOpoTb+gc+Y2pZRY71isTItrRoM2k=;
        b=CrcFsmjbidTllE0ffCXv1Zaoas9ba+hPTeoRpLHEGLLrdwvS9IW6Z9RVjBhkfzNtuP
         4u0JqTA+VBACv5cncU30NVOi2iu6MPtDTQjdb2mT/IGs4HdkdVgyIHl1KkSbEDnC9LwM
         cjGe4+HyFF9+pbIz/xBig1rAiJhtSzgFgVrx/lqCVihI+jJCi4L/xZ1sGvebqVsewCob
         J6qrPGX7yVEMtlboKtSo8jQa93/PDEoq7Uz+7yxXi4Zm5MExTzcLF3W4/+cML6OE7XWo
         yQDnX2PYm732JH0PQEb20CF9ptcC9dzhNAsnfIXCdZoeiZsSpyp1v3nL7iqCOH3acoiw
         4Oaw==
X-Gm-Message-State: ABy/qLbAtddspdtR18yOGUAqK8yq4cYes6Iuw5yVQYHOudzj0qLSpxJ5
        uGk0QPMJpI8ve3ruH0YiA9WSK9ZBa/ljJOC99arj0lW9fkvTai8YAt4bq/U7OG3DtkP/neKbG+k
        Z0vEZ+i2lmKJo/lvpSRgIi+JTxA51eS+3
X-Received: by 2002:a17:907:7714:b0:99b:5a73:4d04 with SMTP id kw20-20020a170907771400b0099b5a734d04mr11923135ejc.71.1690295934017;
        Tue, 25 Jul 2023 07:38:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEdX0+HBQeLrPYCrsDDggU6cES3WxJKjmeJBpY/9SGagGAk12doMxkMYQs+QUDBrLovlYbPhA==
X-Received: by 2002:a17:907:7714:b0:99b:5a73:4d04 with SMTP id kw20-20020a170907771400b0099b5a734d04mr11923126ejc.71.1690295933732;
        Tue, 25 Jul 2023 07:38:53 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i17-20020a170906445100b00977eec7b7e8sm8353930ejp.68.2023.07.25.07.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 07:38:53 -0700 (PDT)
Message-ID: <cca68246-1e77-7585-ffc4-ff532269b632@redhat.com>
Date:   Tue, 25 Jul 2023 16:38:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] platform/x86: huawei-wmi: Silence ambient light sensor
Content-Language: en-US, nl
To:     Konstantin Shelekhin <k.shelekhin@ftml.net>,
        Mark Gross <markgross@kernel.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230722155922.173856-1-k.shelekhin@ftml.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230722155922.173856-1-k.shelekhin@ftml.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/22/23 17:59, Konstantin Shelekhin wrote:
> Currently huawei-wmi causes a lot of spam in dmesg on my
> Huawei MateBook X Pro 2022:
> 
>   ...
>   [36409.328463] input input9: Unknown key pressed, code: 0x02c1
>   [36411.335104] input input9: Unknown key pressed, code: 0x02c1
>   [36412.338674] input input9: Unknown key pressed, code: 0x02c1
>   [36414.848564] input input9: Unknown key pressed, code: 0x02c1
>   [36416.858706] input input9: Unknown key pressed, code: 0x02c1
>   ...
> 
> Fix that by ignoring events generated by ambient light sensor.
> 
> This issue was reported on GitHub and resolved with the following merge
> request:
> 
>   https://github.com/aymanbagabas/Huawei-WMI/pull/70
> 
> I've contacted the mainter of this repo and he gave me the "go ahead" to
> send this patch to the maling list.
> 
> Signed-off-by: Konstantin Shelekhin <k.shelekhin@ftml.net>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  drivers/platform/x86/huawei-wmi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
> index 70e5c4c0574d..0ef1c46b617b 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -85,6 +85,8 @@ static const struct key_entry huawei_wmi_keymap[] = {
>  	{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
>  	{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
>  	{ KE_IGNORE, 0x295, { KEY_KBDILLUMUP } },
> +	// Ignore Ambient Light Sensoring
> +	{ KE_KEY,    0x2c1, { KEY_RESERVED } },
>  	{ KE_END,	 0 }
>  };
>  

