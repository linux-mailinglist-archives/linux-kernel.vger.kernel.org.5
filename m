Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C577DF536
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjKBOid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjKBOib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C04138
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698935858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KpWoxrCsZzrPDM5jl0OZhNo3kWj8IkQT190+RVq6sUs=;
        b=R/l+A7ZI1/JHcmGW/EbDN8lkOp8LLdPPXCMoG2pwK/1OD7svTsSpnTGogcnNgvz5t2yZum
        rlxHtYmqz2dND3fMUS4AFERT/GVKBalYCa+eEMo1D9PyuMv5rqT3XqaR7ye1MJhDlM/Hou
        +TVmfLFEanXVB74uN5puDd9qxSKlJvQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-nmZFxrjFMoOTt-3UU4rcug-1; Thu, 02 Nov 2023 10:37:37 -0400
X-MC-Unique: nmZFxrjFMoOTt-3UU4rcug-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9be601277c2so71616666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935856; x=1699540656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpWoxrCsZzrPDM5jl0OZhNo3kWj8IkQT190+RVq6sUs=;
        b=WlBf3UpDiM1o463pzG/UIWFe4p+n1OCX1HHprx3MmrdE3xmmODRrSQV+gg3MaU6yfs
         /44cKMkAmsWuwf1+AIkj6Lv342wvlHbJE67/hE40haUviWyr9alf4RDC5oJnDi/2/5MH
         5RWU8BJf2u6SKk+uYs+xZHNHZ24p1e4wQUluudZedQjNFFxBfLB8NfbEH61Q583WDQfh
         +r8eG7ayciKgrEQCLtACCNBCCPlKghOfVaMIw/Ca7CbODpG61PsGtIftfKWiLiEBdEOh
         acRHF9Ta+n91XMzyCLN+DQqsIDZAAob+HowlRI+tEeWEVfQazTYenQfz99m2H7kKh1P8
         cUBA==
X-Gm-Message-State: AOJu0Yy9uklRcB4u9BPn/VxSBvuuYlDSTPNweZNpOtAjvjfF9f8d1Esb
        KK6FWaq4q70JjJhbXWwxKUsbnfmMjcVEStBSm4ZYtA/TbVx2qqoKwB7yRPGrYDuKeSSecFU02LA
        gqPru7qBwQRwB0X8IphWcOzTo
X-Received: by 2002:a17:906:794e:b0:9be:1012:91a9 with SMTP id l14-20020a170906794e00b009be101291a9mr4748269ejo.4.1698935856335;
        Thu, 02 Nov 2023 07:37:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYi3UrEGQls9ufTHLMCNWeLR0cTp4f4KwRxha6VAwifajNW1gDKtSRM1hxU9Io/Kzr/+wggw==
X-Received: by 2002:a17:906:794e:b0:9be:1012:91a9 with SMTP id l14-20020a170906794e00b009be101291a9mr4748257ejo.4.1698935856035;
        Thu, 02 Nov 2023 07:37:36 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s20-20020a170906bc5400b009ae3e6c342asm1210005ejv.111.2023.11.02.07.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 07:37:35 -0700 (PDT)
Message-ID: <5ef34d97-e612-a92d-149a-8c966f363342@redhat.com>
Date:   Thu, 2 Nov 2023 15:37:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] Remove redundant return value check
Content-Language: en-US, nl
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Alexandra Diupina <adiupina@astralinux.ru>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20231102141135.369-1-adiupina@astralinux.ru>
 <11e6e0bd-eab1-4aa7-8c5c-29de6cff1b3d@kadam.mountain>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <11e6e0bd-eab1-4aa7-8c5c-29de6cff1b3d@kadam.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 11/2/23 15:35, Dan Carpenter wrote:
> On Thu, Nov 02, 2023 at 05:11:32PM +0300, Alexandra Diupina wrote:
>> media_entity_pads_init() will not return 0 only if the
>> 2nd parameter >= MEDIA_ENTITY_MAX_PADS (512), but 1 is
>> passed, so checking the return value is redundant
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: ad85094b293e ("Revert "media: staging: atomisp: Remove driver"")
>> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
>> ---
>>  drivers/staging/media/atomisp/i2c/atomisp-gc2235.c        | 4 +---
>>  drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c       | 6 +-----
>>  drivers/staging/media/atomisp/i2c/atomisp-ov2722.c        | 2 --
>>  drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c | 2 --
>>  4 files changed, 2 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c b/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
>> index 9fa390fbc5f3..f10931a03285 100644
>> --- a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
>> +++ b/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
>> @@ -840,9 +840,7 @@ static int gc2235_probe(struct i2c_client *client)
>>  	dev->ctrl_handler.lock = &dev->input_lock;
>>  	dev->sd.ctrl_handler = &dev->ctrl_handler;
>>  
>> -	ret = media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
>> -	if (ret)
>> -		gc2235_remove(client);
> 
> Not related to your patch but why doesn't this error path return an
> error?  Can that be right?

This is staging code and there are multiple camera sensor drivers under
drivers/staging/media/atomisp/i2c/

The gc2235 driver is one of the drivers which I have not yes tested
(I do have hw to test it, just no time), let alone worked on cleaning
it up...

Regards,

Hans


