Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE2D7D1D96
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjJUOuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjJUOug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:50:36 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A866135
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:50:29 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c9c145bb5bso85705ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697899828; x=1698504628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RTaQFru2BXnNI5/XK38SzM40CR4IpRF3a3oTCzLuEk=;
        b=FUvf0iY7Lm1OZCXXOiea3f+p2TKB6pFEpwhl8JB6xN9bObDQeOO0aLzQRqkMy8Xtth
         LmApkL7NTa0uScyPdoJxCwEYtFEPXj7rKR+ntf87QdDIEtrMvP8ymOAvt4/ispMEhGiK
         37uC0W6F1XYuz7aKdMGuOTmzUinDCeyJdIwFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697899828; x=1698504628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RTaQFru2BXnNI5/XK38SzM40CR4IpRF3a3oTCzLuEk=;
        b=SexQgppCZEcHfi07tqMyZoKmVCwajZBrWxQcpJZnM8SgLQCIJhQ7lkpUDzholofKf+
         gY9+y1bbucyjdXqjuUArD7V00O5igGdFJI7Toe9wqYodARLiKJfKRQJ8A5VXKWAfF1wq
         x83LDqzKsl0BAZKlnvqLIq8jLgamDg6pAffdvH90go0MJ7U78CiRx1jJwmjAUNFhUaB/
         2FoqgRu/aLstp6autAG9wBr1QHzwsCLLkhqxj/3MOAC/QMxBokPoRv1z8xCbccRunmO0
         tNaYZAEsn+qu+YIfUYiz3WNPouMRV1N3Y9Tc1zS0kxtJpjmdkFKHqOT81RwP4fMtLpCZ
         k6nQ==
X-Gm-Message-State: AOJu0Yz4RQyyNzRFCNT4cTPTlTKIY7vl9tffHyCsMuImd3ZpvJ7BybOn
        ZqScjjAJjx9Uem14vaLGKumwF2mIvKOmf8aD9bzmTg==
X-Google-Smtp-Source: AGHT+IEX2WZAFC6EQRssPNVjVrlfo/Qdd0uJDbniOHsAZE0tEm5hboCT3HseYvSt42TNkzMA8u8aBr5Go1qR3mLjbic=
X-Received: by 2002:a17:903:13c7:b0:1bb:2c7b:6d67 with SMTP id
 kd7-20020a17090313c700b001bb2c7b6d67mr388698plb.11.1697899828346; Sat, 21 Oct
 2023 07:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231020210751.3415723-1-dianders@chromium.org> <20231020140655.v5.2.Ica8e16a84695e787d55e54e291fbf8a28e7f2f7b@changeid>
In-Reply-To: <20231020140655.v5.2.Ica8e16a84695e787d55e54e291fbf8a28e7f2f7b@changeid>
From:   Grant Grundler <grundler@chromium.org>
Date:   Sat, 21 Oct 2023 07:50:17 -0700
Message-ID: <CANEJEGtmFWRkaxzqCXZQC4yfwnYtAsMFHEOU8+SMOFdHqLT+3A@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] r8152: Run the unload routine if we have errors
 during probe
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 2:08=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> The rtl8152_probe() function lacks a call to the chip-specific
> unload() routine when it sees an error in probe. Add it in to match
> the cleanup code in rtl8152_disconnect().
>
> Fixes: ac718b69301c ("net/usb: new driver for RTL8152")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

> ---
>
> Changes in v5:
> - ("Run the unload routine if we have errors during probe") new for v5.
>
>  drivers/net/usb/r8152.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 482957beae66..201c688e3e3f 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -9783,6 +9783,8 @@ static int rtl8152_probe(struct usb_interface *intf=
,
>
>  out1:
>         tasklet_kill(&tp->tx_tl);
> +       if (tp->rtl_ops.unload)
> +               tp->rtl_ops.unload(tp);
>         usb_set_intfdata(intf, NULL);
>  out:
>         free_netdev(netdev);
> --
> 2.42.0.758.gaed0368e0e-goog
>
