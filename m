Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2801177A671
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 15:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjHMNAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 09:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMNAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 09:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767921712
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691931596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xx6IS/2QmZwgaFnutuM14/dSOdQ9YI2iAsu/U1we0B4=;
        b=bRdG7UP+Y1Xh+MRTEsLI/iHKqa7rObEbyzjcnumSaEiWrVsGRf4yAsANRj9Mn4pd9R9NB7
        mri37p6PXhGqbVWdFsoB53ZwtU+IHrypZ26CZCTn2gj6ABj7XQOe5MDxg1jA71Zpzenms5
        +tTYwELIa8J8Ne+8Wr+WOg7Em10ACh0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-7acKtcZNPPaFQCJZfmy10w-1; Sun, 13 Aug 2023 08:59:55 -0400
X-MC-Unique: 7acKtcZNPPaFQCJZfmy10w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fe27502459so3252182e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 05:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691931594; x=1692536394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xx6IS/2QmZwgaFnutuM14/dSOdQ9YI2iAsu/U1we0B4=;
        b=IUZAdRtdtY+JSqVB3KOiM3Pj2BCMSLapqJP5y3ctsmHICN2zPcvPLCOC7XNCk19OJ1
         27Z1g3gudzsDYsXWZ9nUQr6NT82tlR/hxqfbA4t3qkWxZ9S85AWS07WfWmhuV0Rd18Hm
         AEv6Jx8LN6lQl0+GHz0s/Unret9p8Axmhopvxp2koxXb5ZDAEwuzMBpSZxqcq89Qy7cQ
         G8hxEi6HMOzjBtyhzDA+tGikUIXEqJFTpC+YLjNCr3IkFXQx1W0yfoJT/bSC95Zduwin
         uwGTVxmhQuuREfj0cQCTGediOVNsy/zggEoQHpJ9k6Q0AcfJAtHk1JeJlJ0cdRcMqlEl
         d7ow==
X-Gm-Message-State: AOJu0Ywkxnyc67tAuR35NqjOhqK5xgiWBTgQG8zE3uXzTqGLoQW/mLVQ
        CCU82egNvEkRAwhArRW6PtwENRodwEuXtXMebM5cAmDzG7km9m2p6WuGHUEiRmtMWBmzzwKg/gt
        1H9wbTLebrKGjEkh3oiIvC3u5
X-Received: by 2002:a05:6512:703:b0:4f8:49a7:2deb with SMTP id b3-20020a056512070300b004f849a72debmr3342622lfs.8.1691931593760;
        Sun, 13 Aug 2023 05:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYOgMTF9w4RxpDr/YwX5EdgnQ8YlkvmBjUKO1Nsu7whTwP2ooxmuiYVX4g2c/9uHKGSebWBg==
X-Received: by 2002:a05:6512:703:b0:4f8:49a7:2deb with SMTP id b3-20020a056512070300b004f849a72debmr3342608lfs.8.1691931593439;
        Sun, 13 Aug 2023 05:59:53 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i23-20020a1709061cd700b0099293cdbc98sm4595094ejh.145.2023.08.13.05.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 05:59:52 -0700 (PDT)
Message-ID: <68b690bd-f232-0637-a621-9126a189dd0d@redhat.com>
Date:   Sun, 13 Aug 2023 14:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86/siemens: simatic-ipc: fix nonsensical
 condition
Content-Language: en-US, nl
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Mark Gross <markgross@kernel.org>,
        "xingtong.wu" <xingtong.wu@siemens.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Henning Schild <henning.schild@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230811130948.2211800-1-arnd@kernel.org>
 <97764bad-7091-e9ed-6f49-d31861fc622f@linux.intel.com>
 <ef7d94a4-9f65-47fb-906a-4fed4480d020@app.fastmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ef7d94a4-9f65-47fb-906a-4fed4480d020@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/11/23 17:02, Arnd Bergmann wrote:
> On Fri, Aug 11, 2023, at 15:17, Ilpo Järvinen wrote:
>> On Fri, 11 Aug 2023, Arnd Bergmann wrote:
>>
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The condition checking for a constant SIMATIC_IPC_DEVICE_BX_59A value
>>> clearly makes no sense, as clang warns:
>>>
>>> drivers/platform/x86/siemens/simatic-ipc.c:132:42: error: use of logical '||' with constant operand [-Werror,-Wconstant-logical-operand]
>>>                 if (ledmode == SIMATIC_IPC_DEVICE_227G || SIMATIC_IPC_DEVICE_BX_59A)
>>>                                                        ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/platform/x86/siemens/simatic-ipc-batt.c:197:49: error: use of logical '||' with constant operand [-Werror,-Wconstant-logical-operand]
>>>                 if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A || SIMATIC_IPC_DEVICE_BX_59A)
>>>                                                               ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Most likely, this was meant to check ledmode to be one of the two values,
>>> so change it to that.
>>>
>>> Fixes: b8af77951941e ("platform/x86/siemens: simatic-ipc: add new models BX-56A/BX-59A")
>>> Fixes: c56beff203754 ("platform/x86/siemens: simatic-ipc-batt: add support for module BX-59A")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Ok, I see. I missed those as there is hasn't been a new linux-next in
> a few days.
> 
> I suppose this one is also fixed then?
> 
> WARNING: unmet direct dependencies detected for P2SB
>   Depends on [n]: PCI [=n] && X86 [=y]
>   Selected by [m]:
>   - SIEMENS_SIMATIC_IPC_WDT [=m] && WATCHDOG [=y] && SIEMENS_SIMATIC_IPC [=y]
> drivers/platform/x86/p2sb.c:68:9: error: call to undeclared function 'pci_scan_single_device'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

No that one has not been fixed yet. This is the first time I've heard of this one. It seems to not have been caught by the LKP bot.

Regards,

Hans


