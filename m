Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DB280BC9A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 19:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjLJSvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 13:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjLJSvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 13:51:02 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3C9DF;
        Sun, 10 Dec 2023 10:51:06 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77f2f492a43so211043285a.2;
        Sun, 10 Dec 2023 10:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702234265; x=1702839065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwBghRFrA47RK6I3MwWBefA7mWpj3AVra/zvkgfIArE=;
        b=lB0nLlbR4P9bLcjE+x5bIlR/N4Cyo/ECosw3XlGjjRTDf43wxF3GTFwI0gUAKZSNxG
         jW4Wjk3UyVF7OOSN80l4Pu0XLcuJN2vMabzLc3zYZ9v9pjoARrj8GpxkCwvVq9VYu/uc
         AKwXjrWvVQT7LuMy++N6wdA3doetnMMTq7tE5Leu37lPv8T9FMjlJdfOFK9v+cHKcsE8
         3O3pMocaE39xfBukG/Fp7ute9L1bWTaj3jxnH5kI62u1gTRT8cHNRFkgHimbfEQiyugb
         Fz6qbpGCbAlBX++ohvMBtP1lK3zjVD4MG0H4E8JPyr+dILyv+pCmn+j44xgsSB2KMUYW
         ImqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702234265; x=1702839065;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GwBghRFrA47RK6I3MwWBefA7mWpj3AVra/zvkgfIArE=;
        b=POgSglDC75X2qAyiXgogPFRIGLfV20OIhBoZULOD73DiUj5nkWLFZ2+l00Ag0dj/fp
         j1gyBR/actFr0KLVEcrdRseREbdy7q8wWmL9nAjDlZdnq+aetAhe95UcJSDEAiFHSd9T
         GSlhAbXCxJoosBu1GrvFZEcEFi1Dr1JhuIF9ctq2ytAH99aLWvYRJSMXWj/Jn3/3BAwb
         p0BybHNi4jXvuw0rWOCAER6TVJbkksnKZrx44wqJytHgBTxGqic23otvosYI310F4OIr
         eT9jco2ILgr2YM1qcoo77Tj8gWL15apFxXKBxDJljJAN13MLbBOPZmxp460jjvg8V6tl
         YpGg==
X-Gm-Message-State: AOJu0YxIDsFqHlLw9n55+iKh1CiDET5BZeYvR6LWCVFIf/tskJ7XZplM
        +lr8p6fnLTgk5+6YIod1qutm7bvIYmSR
X-Google-Smtp-Source: AGHT+IF1W7oF231zjXysnMnigFoKvqoIa1QaTrxU3hRn7x2jiZ5twLvHwDSAPgTl//hYK/m16ItUWQ==
X-Received: by 2002:a05:620a:31a4:b0:77e:fba3:93a1 with SMTP id bi36-20020a05620a31a400b0077efba393a1mr4234595qkb.131.1702234265269;
        Sun, 10 Dec 2023 10:51:05 -0800 (PST)
Received: from [120.7.1.23] (198-84-239-141.cpe.teksavvy.com. [198.84.239.141])
        by smtp.gmail.com with ESMTPSA id m1-20020ae9e701000000b007759a81d88esm2279006qka.50.2023.12.10.10.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 10:51:05 -0800 (PST)
Subject: Re: [PATCH v6 1/2] depmod: Handle installing modules under a
 different directory
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Suchanek <msuchanek@suse.de>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
 <32b332af189bfca8acdb231cee294355aa4af290.1701892062.git.msuchanek@suse.de>
 <CAK7LNATPF7baHLXZVgzz=6zOhLx8maX0r0EU3DBFwAEZ6kCeww@mail.gmail.com>
From:   Woody Suwalski <terraluna977@gmail.com>
Message-ID: <25f50cb2-37aa-a55e-ff1f-959d7f26f91b@gmail.com>
Date:   Sun, 10 Dec 2023 13:51:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18
MIME-Version: 1.0
In-Reply-To: <CAK7LNATPF7baHLXZVgzz=6zOhLx8maX0r0EU3DBFwAEZ6kCeww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada wrote:
> On Thu, Dec 7, 2023 at 4:48 AM Michal Suchanek <msuchanek@suse.de> wrote:
>> Some distributions aim at shipping all files in /usr.
>>
>> The path under which kernel modules are installed is hardcoded to /lib
>> which conflicts with this goal.
>>
>> When kmod provides kmod.pc, use it to determine the correct module
>> installation path.
>>
>> With kmod that does not provide the config /lib/modules is used as
>> before.
>>
>> While pkg-config does not return an error when a variable does not exist
>> the kmod configure script puts some effort into ensuring that
>> module_directory is non-empty. With that empty module_directory from
>> pkg-config can be used to detect absence of the variable.
>>
>> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>> ---
>> v6:
>>   - use ?= instead of := to make it easier to override the value
>
> "KERNEL_MODULE_DIRECTORY=/local/usr/lib/modules make modules_install"
> will override the install destination, but
> depmod will not be not aware of it.
>
> How to avoid the depmod error?
>
>
I think the depmod -b option can be used to ran depmod in an arbitrary 
location:

The following options are useful for people managing distributions:
     -b, --basedir=DIR    Use an image of a module tree.

Woody

>
>
>
>
>
>
>
>
>
>
>
>>   - use shorter expression for determining the module directory assuming
>>     it's non-empty
>> ---
>>   Makefile | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 511b5616aa41..84f32bd563d4 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1081,7 +1081,9 @@ export INSTALL_DTBS_PATH ?= $(INSTALL_PATH)/dtbs/$(KERNELRELEASE)
>>   # makefile but the argument can be passed to make if needed.
>>   #
>>
>> -MODLIB = $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
>> +export KERNEL_MODULE_DIRECTORY ?= $(or $(shell pkg-config --variable=module_directory kmod 2>/dev/null),/lib/modules)
>> +
>> +MODLIB = $(INSTALL_MOD_PATH)$(KERNEL_MODULE_DIRECTORY)/$(KERNELRELEASE)
>>   export MODLIB
>>
>>   PHONY += prepare0
>> --
>> 2.42.0
>>
>>
>
> --
> Best Regards
> Masahiro Yamada

