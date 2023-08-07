Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81004772C15
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjHGRI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjHGRI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87DDE68
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691428093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PaUoN6jEp6bScPFRDpbhbjlwtESgFZLJBJ4BEap2ll4=;
        b=BvxsOpcDqeyi7NrmKeu+1679u1bmEquqMT9o9MDysfCV2T/VeHEcrpj6zPpLIVtxMQH2IW
        7oYTYF1YaonYD/BJ5RysHz+IE6GFgD5Ob086rFcM23aPZUYPAk8Yyv9u9QMd94K2n17vIp
        uuPFk2ePeErSz/GdwduMxVqpq6JZt5s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-uk2BBh2YMEyACCFyjw_rWA-1; Mon, 07 Aug 2023 13:08:12 -0400
X-MC-Unique: uk2BBh2YMEyACCFyjw_rWA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99bcfdaaa52so322349066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428091; x=1692032891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaUoN6jEp6bScPFRDpbhbjlwtESgFZLJBJ4BEap2ll4=;
        b=jt2b3y3xm5fQOTRkGon6o1EPuFUlRhK07gMBqCVKMzQG7//2xkcgZksnyF3DK/cUuD
         kbEB7M6Pit0AaSeYY+jXRmh2RAqRmt8sDw8A1BcyGGf4pS0JeB1/MKzBlpgl3AojfkK8
         1AOcNckqiAtpS+r320CyGl6X+mSco8OT25pAIagcrynq9E0+UHi0GC3xfeo8ZCZZaLEQ
         vvqZzSJ7Rv7J6Y9PogBZxJcMx6repsSqQUMoG9Q6js8SRyZ21VNFr2GoaVETicharaxt
         94feWN22gZszQmnVFj5daERtubva8MCTTDJwdLoj/vfTGyg3O5ss+OIX2a4QV0WlcCDh
         lEaA==
X-Gm-Message-State: AOJu0YyJTUeDJsAkL5puH/SKjzpeSCoe9uwvZ44STUhTpTnoqXfpkyWb
        kKz8RytyOJN546NuJ+NoJm+aSppwPD9T8y6OPHuGqwUP0eV4Q39ItC9kYhUjHv0CeLuBOspz2u+
        sRfiqAml6MrAYIlqZ854JAMOa
X-Received: by 2002:a17:907:a068:b0:99c:20f0:dec0 with SMTP id ia8-20020a170907a06800b0099c20f0dec0mr7398272ejc.43.1691428091251;
        Mon, 07 Aug 2023 10:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdRWArae2xjTleGNCnyKN3zPJYqQ7yEgmEAbjdVbwFTs5hltjWWTGAXlxt5oOp8DbgHNlFdw==
X-Received: by 2002:a17:907:a068:b0:99c:20f0:dec0 with SMTP id ia8-20020a170907a06800b0099c20f0dec0mr7398260ejc.43.1691428091012;
        Mon, 07 Aug 2023 10:08:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k2-20020a1709063fc200b00993470682e5sm5474991ejj.32.2023.08.07.10.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 10:08:10 -0700 (PDT)
Message-ID: <79004399-65df-01ed-faa7-5dd6c3cbb75d@redhat.com>
Date:   Mon, 7 Aug 2023 19:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drivers/input/touchscreen/goodix.c: Add support for ACPI
 ID GDX9110
Content-Language: en-US, nl
To:     Felix Engelhardt <felix.engelhardt@eidu.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230807124723.382899-1-felix.engelhardt@eidu.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230807124723.382899-1-felix.engelhardt@eidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/7/23 14:47, Felix Engelhardt wrote:
> The Goodix touchscreen controller with ACPI ID GDX9110 was not recognized
> by the goodix driver. This patch adds this ID to the list of supported IDs,
> allowing the driver to be used with this device. The change will allow
> Linux to be used on ~1 million tablet devices used in Kenyan primary
> schools.
> 
> Signed-off-by: Felix Engelhardt <felix.engelhardt@eidu.com>
> ---
>  drivers/input/touchscreen/goodix.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index 4f53d3c57e69..9cdc01eb00c9 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -1379,6 +1379,7 @@ MODULE_DEVICE_TABLE(i2c, goodix_ts_id);
>  static const struct acpi_device_id goodix_acpi_match[] = {
>  	{ "GDIX1001", 0 },
>  	{ "GDIX1002", 0 },
> +	{ "GDX9110", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);

Hmm, GDX without the 'I' does look like an official ACPI vendor prefix. But if this is used in the wild, then I guess we'll just need to live with it:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



