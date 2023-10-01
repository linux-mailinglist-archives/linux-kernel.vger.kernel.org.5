Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161A57B4838
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 16:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbjJAO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 10:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjJAO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 10:56:49 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6048D8;
        Sun,  1 Oct 2023 07:56:47 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57b8cebf57dso7003039eaf.0;
        Sun, 01 Oct 2023 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696172207; x=1696777007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK00HEZ5YDC5fgupWtwn5RbfXLyu48CvHajyLn1vZzk=;
        b=XsAlxsRNnIkHVdeS2CABW2+aUnCiWrFFAg20qlf6S3msToBY10e9uB4tSfMf+wEKI/
         26ZNvF84GS7p71wESpNHeaAt6qHpPtzG3LBvNIs/UO9YwW+n97nBPUvUc3h2xMnDJn6P
         6bteLPQfqiOn6aU8U7w0OjhKLC+n9ZPYYFK9Ux3b5v3Vgn0Pz5iA5OG5gPt7ihMwv/6a
         UgxNbAjcslQREa8KiGaftf6YTkkjWezEv6JpPANKRgGPt4noKDFP0NosDEopwkO5uuSY
         NdOHnpJTm6c/aK+URx+GlQy3bJNVFtdsjsxiyrA5U6/ctLFKnwZUbmxX3AMD+UplgEUZ
         oltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696172207; x=1696777007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK00HEZ5YDC5fgupWtwn5RbfXLyu48CvHajyLn1vZzk=;
        b=IFAgDU0lMsTJDJ9gUjGZFSJpQUez0BYqHm3uU/YAZp2auLKWQQB/jACXBgTwgKpuEE
         ry5XF+ZT9M0B/scnY2PMa6HpImSY5waAkSdcUABhND6i+Fs1aQo3/jjFbslLtLvOlsQh
         zLeAomeaiutVjdoJHRjHF6qtuXJM/M1LXc24KEQ0E3WcMSASj1Qj8Ksho7UOR5RoTcNH
         lvGWuwjayiKnhANds6eBrlxNsikk7CBTOnz7wupMWdySxkiD5WPBK+DdiMmQYrpChFKt
         VlXypathRK1WjIaJdsrgi+5R+56aeP/fNm+i77XxwyAwwny4Owk8mdzDi4qXI2jVlL95
         gkTA==
X-Gm-Message-State: AOJu0Yxw5JS9Jo9oXBC4hOVkipW8+E1BkQ8c9Y0640r7O1sre/+3kogA
        ZlKvYgRPkr5s2hM0+aetd6/T1vsoqLwIod7T9sw=
X-Google-Smtp-Source: AGHT+IEDDRm7IrrSG2/94hMInGF9A8t1RUALVBtsFOsNq1tI/6vbD4mcyX+qXMjE657ts1/1PSWJVa2/soyiRfzFoec=
X-Received: by 2002:a4a:85cd:0:b0:57b:7145:310f with SMTP id
 u13-20020a4a85cd000000b0057b7145310fmr8359787ooh.0.1696172206949; Sun, 01 Oct
 2023 07:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr> <20231001-pxa-gpio-v4-6-0f3b975e6ed5@skole.hr>
In-Reply-To: <20231001-pxa-gpio-v4-6-0f3b975e6ed5@skole.hr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 1 Oct 2023 17:56:11 +0300
Message-ID: <CAHp75VcKztuRsVjZ7GcSEOLcz_eDOrR6gbUVusvPFeTM0Tq0DA@mail.gmail.com>
Subject: Re: [PATCH RFC v4 6/6] input: ads7846: Move wait_for_sync() logic to driver
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
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

On Sun, Oct 1, 2023 at 5:13=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic@=
skole.hr> wrote:
>
> If this code is left in the board file, the sync GPIO would have to be
> separated into another lookup table during conversion to the GPIO
> descriptor API (which is also done in this patch).
>
> The only user of this code (Sharp Spitz) is also converted in this
> patch.

Suggested-by: Linus... ?

...

> +static void ads7846_wait_for_sync(struct ads7846 *ts)

I would name it ..._wait_for_sync_gpio.

...

> +       ts->sync =3D devm_gpiod_get_optional(dev, "sync", GPIOD_IN);
> +       if (IS_ERR(ts->sync)) {

> +               dev_err(dev, "Failed to get sync GPIO: %pe\n", ts->sync);
> +               return PTR_ERR(ts->sync);

return dev_err_probe(...); ?

> +       }

--=20
With Best Regards,
Andy Shevchenko
