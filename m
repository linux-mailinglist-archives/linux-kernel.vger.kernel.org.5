Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0787DA2A7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjJ0VvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjJ0VvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:51:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D57BB0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:51:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so1482a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698443458; x=1699048258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZFjePgLMvsDi/m2Cvy7/csb6I6R8sktPrrPN2yhQIc=;
        b=L62DnYLROg1LEFU894TOeY/x8bKihLFZAecXxreDhRHsbxrhYdBsxX/BurV0inW0Fp
         UOx9gUsaZQ+2sBdIvMdy3ietIyeEVPayQcHuEWpKDNkoonww3vtn3Y7bPoaxislTZc5j
         9GFpJqilTXmk9UQLYgVS7Ic0HyboEKP2hvVN6FGbkSiyqrnLu/4eQ8LAGobpy5qYzt++
         jqjS6uPr9ArJOGUfcn86VbPzx561nx2jmuD6Na/g4So++TmmhgYEMkK/iLECp/FvzOmP
         g2Ct7B6Rr/eEFj9PRudCI/Y6VdLIb4Q3hBjuUf6kDdV6IjIjU2pNxXEKojCar70Van1N
         IPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698443458; x=1699048258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZFjePgLMvsDi/m2Cvy7/csb6I6R8sktPrrPN2yhQIc=;
        b=VK8gD7LTwJ/FG6RosQe6CKmYUzcx9yNiXYY13IQF2zSLzjaWT9xIhXQO1drhWsmAAE
         KSQdF1JrpgVl0Yq2uRA6qTzOt/47evMRI9uPvoMDXPXXLC/kL3f0X3UvGitNrfgLPL2e
         gM97KrZfvdr31Lq2tdzfb1V4MDvb/iL6TpiybusKitVzxQmyyCjoOnnkQJmSUYpFR4Wv
         Ct2Xy/HxkSmjXmvIRI/QSE5jMUARAQhaqqVWCdWccZ9zk2OSdzpkjmhzNdQlYqdGQuL5
         N8SJSVhGkJ+kgLB4Np56jU0KgF3tODms9XvIM845orqTGNVu4idy1YBF/tZeiAxZBAhU
         6jhg==
X-Gm-Message-State: AOJu0YxELu439rZBg3iWwkSj38SjiJYEapsKA1dOTlIPw9IWfB4XKlX5
        +QJC9IBwCYBl9jMqWkf0Y8DCNaIJiP/CpLLMaRRh2grQptzrgRZoX9o=
X-Google-Smtp-Source: AGHT+IFpkC5O4eKmioGaKAkjC0iU3Y2gulHxH7Zju+sJDBFTxtsSUkD5OnKsAiu0TQaxmCHiTR3GlZ+FQ0a+KKzcM4U=
X-Received: by 2002:a50:9552:0:b0:540:9dbd:4b8 with SMTP id
 v18-20020a509552000000b005409dbd04b8mr37083eda.2.1698443458524; Fri, 27 Oct
 2023 14:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231027213059.3550747-1-ptf@google.com>
In-Reply-To: <20231027213059.3550747-1-ptf@google.com>
From:   Patrick Thompson <ptf@google.com>
Date:   Fri, 27 Oct 2023 17:50:46 -0400
Message-ID: <CAJs+hrEXfk82+WyYSsPvs=qk-_JOsBHdWzgnFuy692eJsP=whQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
To:     netdev@vger.kernel.org
Cc:     Chun-Hao Lin <hau@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        nic_swsd@realtek.com, Jeffery Miller <jefferymiller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiner,

I haven't heard back from realtek about the possibility that this
affects other MAC_VERs. Do you think it's acceptable to merge this
patch for now and if/when we hear back from realtek I can adjust the
function again?

Thank you,
Patrick

On Fri, Oct 27, 2023 at 5:31=E2=80=AFPM Patrick Thompson <ptf@google.com> w=
rote:
>
> MAC_VER_46 ethernet adapters fail to detect eapol packets unless
> allmulti is enabled. Add exception for VER_46 in the same way VER_35
> has an exception.
>
> Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
> Signed-off-by: Patrick Thompson <ptf@google.com>
> ---
>
> Changes in v2:
> - add Fixes tag
> - add net annotation
> - update description
>
>  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index 361b90007148b..a775090650e3a 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2584,7 +2584,8 @@ static void rtl_set_rx_mode(struct net_device *dev)
>                 rx_mode |=3D AcceptAllPhys;
>         } else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
>                    dev->flags & IFF_ALLMULTI ||
> -                  tp->mac_version =3D=3D RTL_GIGA_MAC_VER_35) {
> +                  tp->mac_version =3D=3D RTL_GIGA_MAC_VER_35 ||
> +                  tp->mac_version =3D=3D RTL_GIGA_MAC_VER_46) {
>                 /* accept all multicasts */
>         } else if (netdev_mc_empty(dev)) {
>                 rx_mode &=3D ~AcceptMulticast;
> --
> 2.42.0.820.g83a721a137-goog
>
