Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3B77B6CD8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjJCPSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJCPSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:18:06 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C8283;
        Tue,  3 Oct 2023 08:18:03 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3ae5a014d78so2293963b6e.1;
        Tue, 03 Oct 2023 08:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696346283; x=1696951083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K659VYYuoIqH5Bsfh6hrt7QySu3qooBKwhbYnQ9x1+s=;
        b=Eb1v/pmfLlAPGAbgCWNMwzHJ6JtGua+y0Ik54HOwhr/PyVYGnd/c/CNw6GfzLtDE5n
         z8sBCayW3lJ8zarQq8lpV0J/3buDJANTPOAWbClPalwv8uzHQ9wSo6ZZouZhJ0hvLuJU
         Jq0OKNKL5us68Dbnjb20fPEGyS7D5RZ8aFu2hqMs9/WONSJrkWQLDKVlbbprFT+qH21o
         eQ2CjBvAKZklWCT4xW8YaQnLr66+GUF+aoX6YZ4VcWWTX72eqJ0xMp8i2xDKRJUVlFtn
         pYd5Tww4SVIFwaYNotw9j9HfmzBD5kO0xDxMK90Em0jbDhusmqLjxjcMkxq3hcz9V8d2
         1mgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346283; x=1696951083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K659VYYuoIqH5Bsfh6hrt7QySu3qooBKwhbYnQ9x1+s=;
        b=hnT0JeGNw8bGq7GeAgsGTVryKMLgYuxTinYD+P/jytEfNwwDqilVEu01iW6xhoWcaY
         456oGml7PQDVTSh+RZwcu2MxQrnup1U931fob5nlFXBt59Z78YY/EHTpn0ikxZNyacY7
         C7VMzbW2a5amnrMUheh5r62yPq2aiExzM8zcu6ZsFniArWcL2vuTg6xtOOXAHtFX8+Vo
         WPjfTBfxGi8R0++E8pFIq4+rXNRKOEkclsp9c2+kMWc+SjTA/YcnjvLfANnjpqXy5kes
         HZaNkce3256cQkvfdLDGNaZ13DTLQeEN/qO1bL9KgQry3NdqR6rv2S6LX4MRbCToMy+n
         /J7w==
X-Gm-Message-State: AOJu0YyUgllF/XjUyDfXoq6MlohE9Sfch1Zx9d6roI0/URJp0u5KXOwq
        RX7ThdOuyxdAAg8KvqTwmdG8Tn067exaXs901D8=
X-Google-Smtp-Source: AGHT+IGuKl/IqmcqCLQXI4ADPQs9S6RWsjo9UX7+hX7J8vl3qs6kga0FxJybZMuk1UebXxFc080nWez9lx/w62NHjmw=
X-Received: by 2002:a05:6808:1310:b0:3a8:f3e7:d67d with SMTP id
 y16-20020a056808131000b003a8f3e7d67dmr1668765oiv.1.1696346282785; Tue, 03 Oct
 2023 08:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-5-brgl@bgdev.pl>
 <ZRwtEG1DamMLZC/3@sol>
In-Reply-To: <ZRwtEG1DamMLZC/3@sol>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Oct 2023 18:17:27 +0300
Message-ID: <CAHp75VdSDart2b+_d6_9E204JYa2zyFKdh_Pey6Wb4MZ-Z-L0Q@mail.gmail.com>
Subject: Re: [PATCH 04/36] gpio: cdev: use pinctrl_gpio_can_use_line_new()
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 6:02=E2=80=AFPM Kent Gibson <warthog618@gmail.com> w=
rote:
> On Tue, Oct 03, 2023 at 04:50:42PM +0200, Bartosz Golaszewski wrote:

...

> I agree with the change in principle, just not comfortable with the namin=
g.

+1 here. I proposed some names, have you seen my comment(s)?

--=20
With Best Regards,
Andy Shevchenko
