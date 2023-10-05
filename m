Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F927B9E05
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjJEN54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJENzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:55:53 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC74A278
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 02:30:07 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-49d55b90a5aso549661e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696498206; x=1697103006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1y0tR0I7mj7aDDCvbC4XLnLTleYemTWETFhz4bBo18=;
        b=jNdiG4a7w8kkWqROMQr6VGJfgViu9OOR4MfVrrspU/vUvTyeGA8vW5z52nl6sZ8yik
         QrKhHrpWsUYHRnLtj3DMvfoFLjBUZajOxGBd7YidefqOHXZ7es8Uw3QqUnqh9HlPcOpV
         Zm992x8QYz/R/RFz+FX0WcG7ZdM7w46xLQ+E5prodKknYN21z8sUU7/akshahEKQqJiw
         +qqjuIwrcoEgM566YiWhqeS1sdlUBPrLvtTRU9nLxg3MLopng9CC6QceHA9DMC11u98+
         CKmai9zqnUgaZZvvGcRhajXWdUZ7R43BQl29eKA+gbj21rEooRczcF2EHpD37WmJBRRf
         LJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696498206; x=1697103006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1y0tR0I7mj7aDDCvbC4XLnLTleYemTWETFhz4bBo18=;
        b=ae0zS3YJzny4oddme27Nt7028fbiQMI0Nq3W5U3DbHnc7kKFU5krvneu67bTViS6Wm
         lJ9m4dZrFZPRBxjun5mPsbvEGoZXUFx9DqeUmsR0dN3blmqtjOkNSwPPxr2XjZEEBYTo
         UFTItP2bKbaE6jNWcWg6lnJIWy9QAnoAOE/nWkBDfFBSd5u6q3IuPPoTvmv7O+Iji3Ve
         3V1TuUYj/zw4rcvW+ETKuXogYj3PL6nFwwgmgj+oiVeyzyfzfZWrunNQ/Lc45tcacT8g
         ezv0rR7xToRUUCSCF0+flnubjZ21rs1u/tM/b4pPWAMNVFR+GRcL8y0sGpi8mnS41CPh
         mZDA==
X-Gm-Message-State: AOJu0YysbwTJhAAhjbyLO9EOQAB15A410HnzG9EMS1E7m49tlIstqmAZ
        /S6hyEI+mbKBxoPIZ342Hn7CGPY5yVCQs5JWhJzDlQ==
X-Google-Smtp-Source: AGHT+IEWBhDObIF9AQSY7uZ8Y88v8mRS7rKRCmYYz7zW8n5MmdWhFS+ZS1O89a+ihL6jU6tMllCARSI3fGbK811TkzU=
X-Received: by 2002:a1f:62c1:0:b0:496:187e:b33f with SMTP id
 w184-20020a1f62c1000000b00496187eb33fmr1057703vkb.3.1696498206138; Thu, 05
 Oct 2023 02:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231004183906.97845-1-brgl@bgdev.pl> <ZR59dsxK1QBIJoI3@smile.fi.intel.com>
In-Reply-To: <ZR59dsxK1QBIJoI3@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 5 Oct 2023 11:29:55 +0200
Message-ID: <CAMRc=Md3A=cmD-B0gFfdbTEMGH6YjCr3BhN5EhJWJhreuAMDdg@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm2835: add a sentinel at the end of the lookup array
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 11:10=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 04, 2023 at 08:39:06PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > GPIOLIB expects the array of lookup entries to be terminated with an
> > empty member. We need to increase the size of the variable length array
> > in the lookup table by 1.
>
> Right and seems we (used to?) have the same mistake spread over the kerne=
l.

Almost all lookup tables are static and have a sentinel appended. The
temporary lookup hack is only used here and in the int3472 driver
AFAIK so it's not that bad.

> Perhaps a helper at some point?
>

I don't want to make it a habit for people. This is still a hack, just
less bad than what was here before. So I don't think we need a helper
here.

Bart

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
