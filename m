Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EBE7F249F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 04:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjKUDYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 22:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKUDYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 22:24:12 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7334C1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 19:24:08 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ce5b72e743so67265ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 19:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700537048; x=1701141848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDrr9bM3PHykVHLDjRjYj0TBVb7iFAC/0d9okuu8lkw=;
        b=JJyuaxJDla0W/AjZ56GX5FUTJVItRL9szlqSURr9FCJyhNCO5G6Ivb17YZKUla4ZCJ
         sXTpFOn5CXpCHX040+aEoeVqnk/DBP0ySbWPdFmG9a7W0iisV68VhJlvTZi4gocLJO9y
         4x1/QWKY+ChXF0h2Y2D4TA8oMIHOGecy3pIjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700537048; x=1701141848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDrr9bM3PHykVHLDjRjYj0TBVb7iFAC/0d9okuu8lkw=;
        b=MLfWnj0L35/CR29LlnQ6Q6EzjbiTMV7fBnp3IQxMTP7mulJ0Lkn/crGRtsoqss8xlU
         mmcCII28CCL75PaoVOx0zY/i5JKwEoHgCV1mzemSnvteqN+5voAA0oAl7Dc6APwq77vv
         wt3uUN+rkM3nC8H+98ikNKBERTfOIbyVbTzFdpWvBm7rUpv3VBQMXUAr4TD0l13qUeCg
         bzSkWvtotiVDP5aCQpDlZKs5FJeWes3qIqU25LK5vAI9yKr7CjmPQfmUNYx7I+L9pGCd
         IsQyAeDKibocVUv2ChJTBJHUFd0d7Q9FvpzkyNwuzah+/QlTVN2KPoaK0wH9NDs3M+NA
         MdVQ==
X-Gm-Message-State: AOJu0YwL/uf+QT8jN3r9YuroB5xEppb0bKo98mowitCNrkkDwcS3b8G+
        PGhNn/7wszJQ4V1gp6FszokAL8LNOJef4eReR240Ug==
X-Google-Smtp-Source: AGHT+IGmXwcl0iff7b82hBAcY6GbR2Jq2e8T8hci0KzfvAbitbtU8DXqguQRn9YEsaDmHmGrmFuxm09UN61yDpmQZWk=
X-Received: by 2002:a17:902:ceca:b0:1cf:669b:6176 with SMTP id
 d10-20020a170902ceca00b001cf669b6176mr286868plg.16.1700537048028; Mon, 20 Nov
 2023 19:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
In-Reply-To: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
From:   Grant Grundler <grundler@chromium.org>
Date:   Mon, 20 Nov 2023 19:23:56 -0800
Message-ID: <CANEJEGtN0cT2xWLVgi3sN5BBGm8buPFj86cTZyoUAb8tzVy6Yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] r8152: Hold the rtnl_lock for all of reset
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grant Grundler <grundler@chromium.org>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
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

On Fri, Nov 17, 2023 at 1:10=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> As of commit d9962b0d4202 ("r8152: Block future register access if
> register access fails") there is a race condition that can happen
> between the USB device reset thread and napi_enable() (not) getting
> called during rtl8152_open(). Specifically:
> * While rtl8152_open() is running we get a register access error
>   that's _not_ -ENODEV and queue up a USB reset.
> * rtl8152_open() exits before calling napi_enable() due to any reason
>   (including usb_submit_urb() returning an error).
>
> In that case:
> * Since the USB reset is perform in a separate thread asynchronously,
>   it can run at anytime USB device lock is not held - even before
>   rtl8152_open() has exited with an error and caused __dev_open() to
>   clear the __LINK_STATE_START bit.
> * The rtl8152_pre_reset() will notice that the netif_running() returns
>   true (since __LINK_STATE_START wasn't cleared) so it won't exit
>   early.
> * rtl8152_pre_reset() will then hang in napi_disable() because
>   napi_enable() was never called.
>
> We can fix the race by making sure that the r8152 reset routines don't
> run at the same time as we're opening the device. Specifically we need
> the reset routines in their entirety rely on the return value of
> netif_running(). The only way to reliably depend on that is for them
> to hold the rntl_lock() mutex for the duration of reset.
>
> Grabbing the rntl_lock() mutex for the duration of reset seems like a
> long time, but reset is not expected to be common and the rtnl_lock()
> mutex is already held for long durations since the core grabs it
> around the open/close calls.
>
> Fixes: d9962b0d4202 ("r8152: Block future register access if register acc=
ess fails")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

BTW, for ChromeOS systems, the outcome of hang in napi_disable() is a
"hung task" panic after 120 seconds. Fortunately, the stack trace made
it relatively easy (compared to other hung tasks I've looked at) to
unravel.

Doug gets all the credit for figuring out this solution (using rtnl_lock())=
.

cheers,
grant

> ---
>
>  drivers/net/usb/r8152.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 2c5c1e91ded6..d6edf0254599 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -8397,6 +8397,8 @@ static int rtl8152_pre_reset(struct usb_interface *=
intf)
>         struct r8152 *tp =3D usb_get_intfdata(intf);
>         struct net_device *netdev;
>
> +       rtnl_lock();
> +
>         if (!tp || !test_bit(PROBED_WITH_NO_ERRORS, &tp->flags))
>                 return 0;
>
> @@ -8428,20 +8430,17 @@ static int rtl8152_post_reset(struct usb_interfac=
e *intf)
>         struct sockaddr sa;
>
>         if (!tp || !test_bit(PROBED_WITH_NO_ERRORS, &tp->flags))
> -               return 0;
> +               goto exit;
>
>         rtl_set_accessible(tp);
>
>         /* reset the MAC address in case of policy change */
> -       if (determine_ethernet_addr(tp, &sa) >=3D 0) {
> -               rtnl_lock();
> +       if (determine_ethernet_addr(tp, &sa) >=3D 0)
>                 dev_set_mac_address (tp->netdev, &sa, NULL);
> -               rtnl_unlock();
> -       }
>
>         netdev =3D tp->netdev;
>         if (!netif_running(netdev))
> -               return 0;
> +               goto exit;
>
>         set_bit(WORK_ENABLE, &tp->flags);
>         if (netif_carrier_ok(netdev)) {
> @@ -8460,6 +8459,8 @@ static int rtl8152_post_reset(struct usb_interface =
*intf)
>         if (!list_empty(&tp->rx_done))
>                 napi_schedule(&tp->napi);
>
> +exit:
> +       rtnl_unlock();
>         return 0;
>  }
>
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
