Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4297F275C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjKUIWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKUIWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:22:10 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA44F4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:22:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso6655a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700554925; x=1701159725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCK1g9YM8XFjym+Y1ma/CnG4HTN5lgzW4MRhGnM9Ctg=;
        b=EeiNnOVB61DSfWZT9NiKt2naE2DONQ3VnXhdeyq1oif3E2uLjHqe8NkhtUTkXNLqQR
         aqZksBmH+efpSrmqVfxtSsGpLeKixUl9TQyp+AzQeVnYnQ1F6VgUoEA1ysokhZP9hHT/
         HP7Oo7nFZ/BjpoBWv7STFJPpRup4sxdefBsI40vk+ThVvb6vWQAIiqTkZbtiAEMER7BI
         W4acUuzSCi8bTGLQfVNeSJqkqHZ9HOgYurOLetOjYe/NpW5/XUsAWJ4AEaAoqjpDDizt
         OFHdnIg4nhf7fWm3ID63MP67mjRvtJgMh/v5uXxx2JGnlptz8GwElIVnxL0CWRX4wf5M
         FAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700554925; x=1701159725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCK1g9YM8XFjym+Y1ma/CnG4HTN5lgzW4MRhGnM9Ctg=;
        b=AhBznJV7vCf6gQqvUN59rG9k4oMJD779sI71Ot0FwcALEF9KqwLfCqvpweUPRx3GvJ
         Bk9zn7rPYAWPj7CwsL5lv5l/NdstZGpkRysFMdiWnb+513NnKpNRw+H5is0TojTL3s3e
         TSqNbyNroXIBXcu/tR+FrFveQjHktizllMd+v4lAd07ALO/hOOvCBjdB7IqjxnXJKitq
         lejlSffo+WxoIS2cv6ocu8k0hvfgO+iMnTEsdpnXSIopNyKnxj2xHAY0hE20rGkVpLiN
         e7q9eN1rWZiE1Dp7X00r372IOZZkpYdepub+id3Kt4k2ncfoyxLy2hwXuLXNjecNb5FX
         ELOA==
X-Gm-Message-State: AOJu0YzUmcTDth7UbyLKysU8UjKplNoZM2Vb6LhzCJJcuigxYKNdVZ0h
        xdLhn6sCTv1G7FOuhBBKbbQd+i/xfAYodwjAl3Fzqg==
X-Google-Smtp-Source: AGHT+IEQIy1UWv0nXe/YssFHF48Ncyrazvf+xBS3VY2h5GiT2ncZWuBZH2HEP6iMFMutvlKr9G8jO5eCeWr5mET04R0=
X-Received: by 2002:a05:6402:4414:b0:544:e2b8:ba6a with SMTP id
 y20-20020a056402441400b00544e2b8ba6amr463035eda.3.1700554924840; Tue, 21 Nov
 2023 00:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20231121020111.1143180-1-dima@arista.com> <20231121020111.1143180-4-dima@arista.com>
In-Reply-To: <20231121020111.1143180-4-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 21 Nov 2023 09:21:53 +0100
Message-ID: <CANn89i+2xLv=bR5u0iGcmZhZ8WZjPHyzaqAe3cZAhmc95KSVag@mail.gmail.com>
Subject: Re: [PATCH 3/7] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 3:01=E2=80=AFAM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Listen socket is not an established TCP connection, so
> setsockopt(TCP_AO_REPAIR) doesn't have any impact.
>
> Restrict this uAPI for listen sockets.
>
> Fixes: faadfaba5e01 ("net/tcp: Add TCP_AO_REPAIR")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  net/ipv4/tcp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 53bcc17c91e4..2836515ab3d7 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3594,6 +3594,10 @@ int do_tcp_setsockopt(struct sock *sk, int level, =
int optname,
>                 break;
>
>         case TCP_AO_REPAIR:
> +               if (sk->sk_state =3D=3D TCP_LISTEN) {
> +                       err =3D -ENOSTR;

ENOSTR is not used a single time in linux.

I suggest you use tcp_can_repair_sock() helper (and return -EPERM as
other TCP_REPAIR options)

> +                       break;
> +               }
>                 err =3D tcp_ao_set_repair(sk, optval, optlen);
>                 break;
>  #ifdef CONFIG_TCP_AO
> @@ -4293,6 +4297,8 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>         }
>  #endif
>         case TCP_AO_REPAIR:
> +               if (sk->sk_state =3D=3D TCP_LISTEN)
> +                       return -ENOSTR;
>                 return tcp_ao_get_repair(sk, optval, optlen);
>         case TCP_AO_GET_KEYS:
>         case TCP_AO_INFO: {
> --
> 2.42.0
>
