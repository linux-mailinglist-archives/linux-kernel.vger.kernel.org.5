Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7D57FF150
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbjK3OJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346023AbjK3OJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:09:07 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058701FF3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:08:59 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-58df5988172so129515eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701353338; x=1701958138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGm3fLcq9TYYkeJn9nu2yfmsGxpSD3YbOVEzHPjzsS4=;
        b=wi2vk/SdwyiQMo4sqe6WPzLtBfZpuxrRPWHoxoJLL3bc6CwJHgWbb5zkt/FcfPEn7D
         7RHKxBgsRMCGJg51FnxFtd2CUE0NiFwz8S1gh+57civxq/uxRg2gSsSstb8hrhVTGSzO
         Ddpm5tvYtEItr+BQ4JPaiNyBR2CelOSZP4Qze60KsEiiozpSJZ6fJ5SuTMR7mpiC/Nba
         LSdzps5t2GKz/TBbiMvAVtcjjkm7bdl6PkWsGiV3TwdQ6N9iwvseu7r5Zjs1542VcTIK
         We80SPXHA4xOD/JL03zvwNqW0G4I/u7FLzmVo1XVId4zXbKo552k6uk259Rclu6M7ff6
         rMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353338; x=1701958138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGm3fLcq9TYYkeJn9nu2yfmsGxpSD3YbOVEzHPjzsS4=;
        b=uBZlQ73JVpH8nE4bzXq3MPpkY1/9hxb6TO8l+h1FH095ygL8cN4TMrGTlrL5b4Qhc9
         lb5IPtSxMo95svK62jzU0C4sPw/zTTdcVaAiD4pFFy+F09n+5iPRoznL5yGmWnpDEyCq
         gZrfmRn3zPlxOUFTgciX4pW2qAlxGI281phQCPfdItjtHBgHRx9S1wMt9GkkQgSOOOGF
         jA2pVxrerWQNZXEjY6sA6bl+iHru+rZZdI1qPPIyi9emOHjFoKiEWHrVx6SkBuM4O/3M
         9LwfjmLKZpOqR0yA1Ov6FJMCYzMvF5or1iNiTTCzU0oqUywqjlWCQ4kBw1vDD7LOJUHh
         9U4g==
X-Gm-Message-State: AOJu0YwgLabLpVVBo/hv8msdXdcCwEmLryAkkCF2tNoCG1/BnDDzPvRb
        RhGPJr9jeX7+VQik2wk0ickL1aKk2V2zeEP4pRjN8w==
X-Google-Smtp-Source: AGHT+IFZJ66hXQZpSa3F0ainHjBlvJpUNMobOd2fvHDH78gdeU9vlpCH8X12pp7pXP2TseZvDBjfp1Goide8q2/TvKE=
X-Received: by 2002:a05:6358:78c:b0:16b:c401:955b with SMTP id
 n12-20020a056358078c00b0016bc401955bmr25149652rwj.2.1701353338323; Thu, 30
 Nov 2023 06:08:58 -0800 (PST)
MIME-Version: 1.0
References: <20231130104023.11885-1-brgl@bgdev.pl> <ZWiQLEz6P3vbZgx0@smile.fi.intel.com>
In-Reply-To: <ZWiQLEz6P3vbZgx0@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 30 Nov 2023 15:08:47 +0100
Message-ID: <CAMRc=McUbCnadoPyRwtmeqckg3LEoC2NKy4xSeje8i3dfSh5ng@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: implement the dbg_show() callback
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 2:37=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 30, 2023 at 11:40:23AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Provide a custom implementation of the dbg_show() callback that prints
> > all requested lines together with their label, direction, value and
> > bias. This improves the code coverage of GPIOLIB.
>
> ...
>
> > +#else
> > +#define gpio_sim_dbg_show NULL
> > +#endif /* CONFIG_DEBUG_FS */
>
> I;m wondering if you can use PTR_IF() instead of this ugly ifdeffery.
>

I wasn't aware of this. Thanks for bringing it to my attention, I'll use it=
.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
