Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D66E8019F0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 03:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjLBCOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 21:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBCOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 21:14:35 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1761B3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 18:14:42 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc79f73e58so39635ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 18:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701483282; x=1702088082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad+Vuli4r0v/oI1SJRzXP2ROeHQLNvp0j2+cttkMcqQ=;
        b=Y8IsA4AVV9jBYFXxWikj5QUdp4C1TSzXDMbcTs4WAy7SOS0R/jpTvqCvpuWSK16jXo
         tUbFPpMv7sSck8Dsy550vZyOCiuPTr6t1c7NTDjc5JnFmxR3Dc0sCKqxdVSjI5Hgk/Rg
         zs1Sc18m9iLqNuxell4BZjlmP2XRgrgNfgjLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701483282; x=1702088082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ad+Vuli4r0v/oI1SJRzXP2ROeHQLNvp0j2+cttkMcqQ=;
        b=EJY43dZh3BvSv+WGi2qZaHqmVq4yKzvM9hCs7mCjCwSvogTs9WLIbd0nxYuztkKj8W
         og4wzU87AMd+HktK2Q6auVPLH6PjJAAs6e+vAPK5gnA7LQj3nIQlQ4rTY+reCKODwg3V
         gPPu9ubb55QYTi43qICgBISaBBCewJ9oc7miUuAowkIieUCSThA/BhUJKzHd7AE1yaEn
         ZKI0K8YEXce1F3CH5QJq9pjeol1czW7T+Z6tkUA4qquILFe6tKquJZu7kU3SbbHsNs3h
         m3Mjc8QQuBZk9w8Oc/qIxPgrZ9v/rWf3tI9bzqBLPHVd+72W3k4vnFz1Oxv48ylxYacg
         wFfg==
X-Gm-Message-State: AOJu0Yz7hFTHzt8L3g7gakP29nR3EmwI6354M2CeKawcgZADOiAx12WC
        t4hrE6moiN+gUQspHpwOCZgSn3Fwe5URAIOPLC9dSg==
X-Google-Smtp-Source: AGHT+IEKqrjLQGf+i8EsRzjviHVepWE5Uj0zYxDLLxLkaXMlqS9mdTsc6E+b/+JqSoxPrT76bM7ZX7LyQ7abgOoFHik=
X-Received: by 2002:a17:903:25d5:b0:1c9:e48c:726d with SMTP id
 jc21-20020a17090325d500b001c9e48c726dmr371666plb.4.1701483281482; Fri, 01 Dec
 2023 18:14:41 -0800 (PST)
MIME-Version: 1.0
References: <20231201183113.343256-1-dianders@chromium.org> <20231201102946.v2.1.I7ea0dd55ee2acdb48b0e6d28c1a704ab2c29206f@changeid>
In-Reply-To: <20231201102946.v2.1.I7ea0dd55ee2acdb48b0e6d28c1a704ab2c29206f@changeid>
From:   Grant Grundler <grundler@chromium.org>
Date:   Fri, 1 Dec 2023 18:14:29 -0800
Message-ID: <CANEJEGu2fe6MEFxd3cofeP1QQU=7kLW7EixxJ3CQmsrzsPjWPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] usb: core: Don't force USB generic_subclass
 drivers to define probe()
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Simon Horman <horms@kernel.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        netdev@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 10:31=E2=80=AFAM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> There's no real reason that subclassed USB drivers _need_ to define
> probe() since they might want to subclass for some other reason. Make
> it optional to define probe() if we're a generic_subclass.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

Thanks for pursuing this Doug!

cheers,
grant

> ---
>
> Changes in v2:
> - ("Don't force USB generic_subclass drivers to define ...") new for v2.
>
>  drivers/usb/core/driver.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index f58a0299fb3b..1dc0c0413043 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -290,7 +290,10 @@ static int usb_probe_device(struct device *dev)
>          * specialised device drivers prior to setting the
>          * use_generic_driver bit.
>          */
> -       error =3D udriver->probe(udev);
> +       if (udriver->probe)
> +               error =3D udriver->probe(udev);
> +       else if (!udriver->generic_subclass)
> +               error =3D -EINVAL;
>         if (error =3D=3D -ENODEV && udriver !=3D &usb_generic_driver &&
>             (udriver->id_table || udriver->match)) {
>                 udev->use_generic_driver =3D 1;
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
