Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FB578279F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjHULMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjHULMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E56E1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692616314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kKWxVwDIa0LoG6kc8lkH3kYCQkEyAxI4MOchqwkxyI=;
        b=UF96Zwyd4O34NkqkakXY0En68Epwr5J0dcjZn0lMcswaczBsu8CikDonA96aTHDuViP/ME
        jGQN6dM6M0FBXbkne0CIeV4yTVUtEcmczL7A/lp5c7toTfTYPIbJ3Hca6DCFUnx1N6bebx
        oSGZjO/lx2mGfr0GYjIHxhzBoQ+ShkM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-c8l2IjrxOs-fSAM6KGsa2A-1; Mon, 21 Aug 2023 07:11:52 -0400
X-MC-Unique: c8l2IjrxOs-fSAM6KGsa2A-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2bbbaa6001dso24957011fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692616311; x=1693221111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kKWxVwDIa0LoG6kc8lkH3kYCQkEyAxI4MOchqwkxyI=;
        b=E3RZvsJNfsm8tORyU1m5hy5YpPajaPHYWzKyy2iM820Pxbpa46UPz807JaoWvfYWtr
         pIE04cO5uNdxPDaei+RR3D/s2lNCms1cZ1LUYt/a8V9iNuQAdS/gMHUSm4mzH6qPh8th
         RUSPoPav/PR755j91Xn5RE5dSMJiPNBL9Mdt7ndXkr2UyT9zzB/ZxSkYITuJmh0xGcFZ
         7fWpbtF6FkJiRZ8FH4dcmMReBmXl80GlozY6k42Ebbz1wYWMNElvm0EhPZ0RYBdkFoG7
         GR7bXGXthKRaKYu3nbUx8KLgqqPTLjGaqsjQHSYYcxma8Kvh56JI0vPjwM7VCiW7ky1n
         Kk/g==
X-Gm-Message-State: AOJu0YzU/cByWdNMAKWr9aMnbVZ1zPoXb2Pwn1m1fv+Nzc0pnWkkDvoA
        nxUL3uJ8XodvWP51OUHa69HQgRrHn/BIgzuoor9hUTy1lAlKY8mqXdlbarGc/sYiTCwjfDBIJzq
        UzxpEjUau0xjEKEigWLaSjqlV
X-Received: by 2002:a2e:9a88:0:b0:2bb:bfb0:7b66 with SMTP id p8-20020a2e9a88000000b002bbbfb07b66mr4869235lji.1.1692616311198;
        Mon, 21 Aug 2023 04:11:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIVcK22dC2fwcb0OYio9nfaSYFutOwgY1sZdX45PlJZDV4VuM1nue2vcvI4KJTEJ1CG9nxxQ==
X-Received: by 2002:a2e:9a88:0:b0:2bb:bfb0:7b66 with SMTP id p8-20020a2e9a88000000b002bbbfb07b66mr4869226lji.1.1692616310897;
        Mon, 21 Aug 2023 04:11:50 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id y13-20020a170906470d00b00993928e4d1bsm6395157ejq.24.2023.08.21.04.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 04:11:50 -0700 (PDT)
Message-ID: <6a9b4199-cf2b-9653-5643-89a64a81916c@redhat.com>
Date:   Mon, 21 Aug 2023 13:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] watchdog: simatic: add PCI dependency
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "xingtong.wu" <xingtong_wu@163.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andy@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Haeussler, Gerd" <gerd.haeussler.ext@siemens.com>,
        "Schaffner, Tobias" <tobias.schaffner@siemens.com>,
        "xingtong.wu" <XingTong.Wu@siemens.com>
References: <20230814073924.1066390-1-arnd@kernel.org>
 <a6c2f193-ef7c-54a0-dfbb-13915be259a1@163.com>
 <1834eee9-3fbd-4bea-9e22-960ca993303c@app.fastmail.com>
 <672725bc-6ebf-0a35-96ab-8862be7de193@redhat.com>
 <CAHp75VcR2k=ko4esuO=KNeZRQxeGojTxKeozRGCB+EXrGXgoSQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VcR2k=ko4esuO=KNeZRQxeGojTxKeozRGCB+EXrGXgoSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 8/14/23 17:28, Andy Shevchenko wrote:
> On Mon, Aug 14, 2023 at 11:51 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 8/14/23 10:48, Arnd Bergmann wrote:
> 
> ...
> 
>> Right P2SB would benefit from being changed into a hidden
>> symbol.
> 
> Yes, I dunno why it wasn't that way from day 1. Perhaps due to the
> original contribution done by somebody else...
> 
>> Andy, any comments on making P2SB a hidden symbol ?
> 
> I'm fine with that.

Ok, can you submit a patch for this please ?

Regards,

Hans

