Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7B77D4A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjJXIgH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 04:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjJXIft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:35:49 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25A0173C;
        Tue, 24 Oct 2023 01:35:19 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a7ad24b3aaso43644607b3.2;
        Tue, 24 Oct 2023 01:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136518; x=1698741318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6WGKCx/tnchPSjDNC0icQpihqJVUVz/LWjSt9rOyiY=;
        b=bF0PdpI/84MtpFYCka+UsLDI3GyjXKp16XZmdl1nCPJrjA9wKFm6YTkR6JVZ6Mo8Fz
         /GueIzj2SwZL6sM2gZLYxVyp8HAfVP7mRMyomMT+QZxZ2U8QWqXMdP3lPN/Gk9b1k5OP
         lL527q6zAiQpEtFISmuo12AaFNyPwvppDnOUaQokqM+u7N1N9KsN6O3TOVsPzXM11qZ0
         JF/LiIrl4nxQMIhJX+HNJZp/WfHHhqXYHMKjT49F1pfJoDCUhHe3ze6dj2PW9kogRusQ
         wRcfb79lCnpx1Il3RsZuyzRfP/YvO+C8++jA5vvWKzZdoAEcocUaMYtsvg2W0yjgMfE1
         SDUA==
X-Gm-Message-State: AOJu0Yz4sM6iL64VUkDwecE0Y9IlF6PYofz8mWSWqEU+/qKyhrr4C7C7
        Ud39Gf89P8dedE4jkavDJDw/rNumc5gXJw==
X-Google-Smtp-Source: AGHT+IFj12rmxpmILK96ZY4ASQ9IUZ+rmjxDY1NGVxlQoatDMCLi+TuKusN2Z6gSC2wxutmZTsOh6A==
X-Received: by 2002:a0d:c483:0:b0:5a7:be29:19ac with SMTP id g125-20020a0dc483000000b005a7be2919acmr12183334ywd.12.1698136518358;
        Tue, 24 Oct 2023 01:35:18 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id o188-20020a8173c5000000b005a7dd6b7eefsm3871199ywc.66.2023.10.24.01.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 01:35:18 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a8ee23f043so43696707b3.3;
        Tue, 24 Oct 2023 01:35:18 -0700 (PDT)
X-Received: by 2002:a81:52d3:0:b0:5a7:a838:3fa with SMTP id
 g202-20020a8152d3000000b005a7a83803famr11277453ywb.3.1698136517845; Tue, 24
 Oct 2023 01:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231023104820.849461819@linuxfoundation.org> <724521b8-9c63-4645-b3e0-30d9635573a7@linaro.org>
 <CAEUSe7-zbuRsgsr2EYq+OeW9iEJyZHmo8u9K3pDCAFRKnCEv0A@mail.gmail.com>
 <CAMuHMdXYB6QAE15RYs7eg9sVofesqNN1+vmPHkosqC_8A-JTSg@mail.gmail.com>
 <9737cd7b-f3c6-7e90-f92c-0ceeed788980@roeck-us.net> <2023102453-backspin-immunize-b110@gregkh>
In-Reply-To: <2023102453-backspin-immunize-b110@gregkh>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Oct 2023 10:35:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVR9KFdu=t=8cowyY_-88Hutd-1OxKh6w+f+Cu+YXgtWQ@mail.gmail.com>
Message-ID: <CAMuHMdVR9KFdu=t=8cowyY_-88Hutd-1OxKh6w+f+Cu+YXgtWQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/137] 5.15.137-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Oct 24, 2023 at 10:31 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Oct 23, 2023 at 12:56:48PM -0700, Guenter Roeck wrote:
> > On 10/23/23 11:50, Geert Uytterhoeven wrote:
> > > CC maz
> > >
> > > On Mon, Oct 23, 2023 at 7:17 PM Daniel Díaz <daniel.diaz@linaro.org> wrote:
> > > > On Mon, 23 Oct 2023 at 09:11, Daniel Díaz <daniel.diaz@linaro.org> wrote:
> > > > > On 23/10/23 4:55 a. m., Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 5.15.137 release.
> > > > > > There are 137 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > >
> > > > > > Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> > > > > > Anything received after that time might be too late.
> > > > > >
> > > > > > The whole patch series can be found in one patch at:
> > > > > >        https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.137-rc1.gz
> > > > > > or in the git tree and branch at:
> > > > > >        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > > > and the diffstat can be found below.
> > > > > >
> > > > > > thanks,
> > > > > >
> > > > > > greg k-h
> > > > >
> > > > > We see lots of errors on Arm 32-bits:
> > > > >
> > > > > -----8<-----
> > > > > /builds/linux/drivers/gpio/gpio-vf610.c:249:11: error: 'IRQCHIP_IMMUTABLE' undeclared here (not in a function); did you mean 'IS_IMMUTABLE'?
> > > > >     .flags = IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND
> > > > >              ^~~~~~~~~~~~~~~~~
> > > > >              IS_IMMUTABLE
> > > > > /builds/linux/drivers/gpio/gpio-vf610.c:251:2: error: 'GPIOCHIP_IRQ_RESOURCE_HELPERS' undeclared here (not in a function)
> > > > >     GPIOCHIP_IRQ_RESOURCE_HELPERS,
> > > > >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > /builds/linux/drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struct initializer
> > > > > /builds/linux/drivers/gpio/gpio-vf610.c:251:2: note: (near initialization for 'vf610_irqchip')
> > > > > /builds/linux/drivers/gpio/gpio-vf610.c: In function 'vf610_gpio_probe':
> > > > > /builds/linux/drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of function 'gpio_irq_chip_set_chip'; did you mean 'gpiochip_get_data'? [-Werror=implicit-function-declaration]
> > > > >     gpio_irq_chip_set_chip(girq, &vf610_irqchip);
> > > > >     ^~~~~~~~~~~~~~~~~~~~~~
> > > > >     gpiochip_get_data
> > > > > cc1: some warnings being treated as errors
> > > > > ----->8-----
> > > >
> > > > Bisection points to "gpio: vf610: make irq_chip immutable" (upstream
> > > > commit e6ef4f8ede09f4af7cde000717b349b50bc62576).
> > >
> > > IRQCHIP_IMMUTABLE was introduced in commit 6c846d026d490b23 ("gpio:
> > > Don't fiddle with irqchips marked as immutable") in v5.19.
> > > Backporting (part of) that is probably not safe.
> > >
> >
> > In this context: What exactly does commit e6ef4f8ede09 fix that makes it
> > a stable release candidate ?
>
> It is needed as a dependency for 430232619791 ("gpio: vf610: mask the
> gpio irq in system suspend and support wakeup") which says it:
>   Fixes: 7f2691a19627 ("gpio: vf610: add gpiolib/IRQ chip driver for Vybrid")
> which was in the 3.19 kernel release.
>
> That's why it was added.  And then none of my x86 builds caught this
> build failure before I pushed out the -rcs.

Ah, the difference between semantic and lexical changes ;-)

The proper backport would be to just add

       .flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND,

Don't bother with the IRQCHIP_IMMUTABLE.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
