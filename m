Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C727D786872
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjHXHgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjHXHg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:36:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D379C7;
        Thu, 24 Aug 2023 00:36:26 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bda9207132so51449265ad.0;
        Thu, 24 Aug 2023 00:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692862586; x=1693467386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eIb+HlByq9h5khMqS8bxE7oax55t0scbnyEW7Xgdu4k=;
        b=AuyRMI51Da3PxZvX112N7jP4KDdJgHnZXK3nRLjGaCt/4VjnfLP5j+XCARtf5TFwiZ
         OxD7YSH1PCgSFrYurB1jNBLbz37PJdiZ7agaZ6dcFU6nzCf76Rbrh/RKeUXratWL1TIv
         sXCnHV3feW4WFssAlcTRf3qLQDk4Djc11fN/YxTyKOl4QRmJjDwZJSn6EG6E7kavXxsf
         eZlVAQLpl9CZZD9J9i8q5hvJLUFgdVbvu6UG5Ya7d5f8N7tfZw4wYS29maYbmQ+wRvTK
         48Yywt9zdBr61+iutQNBm+GTl0qpI+8GKTYM/z5JulEkO2qzNQfmJmnK+8Vxxve8Itkh
         fC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692862586; x=1693467386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIb+HlByq9h5khMqS8bxE7oax55t0scbnyEW7Xgdu4k=;
        b=JLooCQz24M8sAHFYzJbUaZV52B57Jo6rHjCG1Ki6INCCq5N8IU/wOT/sGQE89VlSih
         k5K2Akvw/xtp/NuZ5Jt4kDCY7AloZKQ9lrF631EN2mhJ0ELiBbQsBeCYZkDkI2GpJLmr
         OjciBjVr6LGTqBg5T0eA2duyfIhCETsEMvuKQvz+NqN/TDO6UlQfK+hBbv0+FC1C7RxH
         xjCoTk1hCKGys29wkdnWf2V+1OvtD/h//0b29rR2KaUdaglkYvr6LE+lHEOFW0tvqsru
         D3CvUTbC79HiRUiuJf3WL9zvB+Ud3p8gJ2GFcrAknyK2Lsl7eBm1vaoZToZZOahgKxdR
         evOA==
X-Gm-Message-State: AOJu0YyESUtS3yS58aTNSRoCktuirlFGKMD9Kvjc48k3YckfZKI2ofiN
        mrtI9tPy/g7MdMHBws5pnTmTCCqj6sg=
X-Google-Smtp-Source: AGHT+IFcv7cjnpyEzkorL3pZ6uESi7+Ml1pJr9UyH23mfbcrmtPHEh9XXlZtR62k1uXQePsU50dlhQ==
X-Received: by 2002:a17:902:c947:b0:1c0:7bac:13d4 with SMTP id i7-20020a170902c94700b001c07bac13d4mr10772102pla.65.1692862585673;
        Thu, 24 Aug 2023 00:36:25 -0700 (PDT)
Received: from sol (14-203-61-235.static.tpgi.com.au. [14.203.61.235])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902b59000b001bba3650448sm12132572pls.258.2023.08.24.00.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 00:36:25 -0700 (PDT)
Date:   Thu, 24 Aug 2023 15:36:20 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [libgpiod v1.6.x][PATCH] tests: mockup: unbind mockup devices
 before unloading the module
Message-ID: <ZOcIdHVgK1ffzFMb@sol>
References: <20230821153339.26305-1-brgl@bgdev.pl>
 <ZOP/n30hYR/8zN60@sol>
 <CAMRc=Mep_AZPht6cQFQ-Pz8UJC-q1r4F29SJ=+_WgJX1cz5wtw@mail.gmail.com>
 <CAMRc=MdoZJbiNUbdO6VOzS7NJTJtbmD1uoywa7+iWjeoy+RecQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdoZJbiNUbdO6VOzS7NJTJtbmD1uoywa7+iWjeoy+RecQ@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 09:32:06AM +0200, Bartosz Golaszewski wrote:
> On Tue, Aug 22, 2023 at 9:08 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Tue, Aug 22, 2023 at 2:21 AM Kent Gibson <warthog618@gmail.com> wrote:
> > >
> > > On Mon, Aug 21, 2023 at 05:33:39PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > gpio-mockup relies on the GPIO devices being registered in module's __init
> > > > function and them being unregistered in __exit. This works with the GPIO
> > > > subsystem as it only takes a reference to the underlying owner module when
> > > > a GPIO descriptor is requested and not when the GPIO device is
> > > > instantiated.
> > > >
> > > > This behavior may change in the future in the kernel so make the behavior
> > > > of libgpiomockup more correct and have it unbind all mockup devices over
> > > > sysfs before unloading the module.
> > > >
> > >
> > > Never knew that unbinding was even an option.
> > > Maybe update gpio-mockup's documentation?
> > >
> >
> > Yeah, I might once we agree on that reference counting patch.
> >
> > > Just clarifying what the potential impact of the existing libgpiomockup
> > > behaviour and future kernel behaviour is - the kernel may log errors but
> > > otherwise correctly handle userspace unloading behaving badly?
> > > So this patch is pre-emptory noise reduction?
> > >
> >
> > No, it's a bug-fix-in-advance. gpio-mockup will fail to unload (until
> > we unbind all devices anyway) if we couple the module's reference with
> > struct gpio_device. So will every driver that registers devices from
> > its module_init() function and tears them down in module_exit(). But
> > these drivers are wrong to do so in the first place and unloading them
> > sound like a rare thing to do anyway, so I'm willing to give it a try.
> >
> > Bartosz
> 
> So what do you think Kent? Does it make sense to have it in v1.6? I
> would need to make a new bugfix release but I have something else
> queued anyway.
> 

If the plan is to change the kernel such that it will no longer unload
modules with bound devices then the patch totally makes sense.

Cheers,
Kent.
