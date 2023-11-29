Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74547FDEE6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjK2Rxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2Rxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:53:33 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4372C95
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:53:39 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so451a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701280418; x=1701885218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nolkjQeTKUPpQU0aMQBGDG9EPk/umeej7VkDw1waIR8=;
        b=NyNO2pnGt3/BL7hYXF9eBUkgH9vSo4B+3yM3JGVs3nUTp2jvSViBFJ4kRP/8miKJ14
         KZQa2q+jWYsZVWWSloxgAeprUeJm4WDC8wpEoHRYQtM9sr5pstOpBObLldRuV4CToM2V
         fnbgyO6g1jtIuN0YSEt7XLsJr+fXNiQhK4F8M5HVg8TJsCWzdNMsPpnKlGjOLPkE1wiV
         CJbmOta+QrN4rfZgHHnnQ4bu7aclpLy1kP9ZzFfbvoR6sLdqON6ufrmQ6Ev2ClIEvgK2
         l0Q4qgilABvyPcxtIwwbAO6CrptTOvw5sslreynqesIYm5gC2aMShJ7KXHZxf8SUt8wS
         oz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701280418; x=1701885218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nolkjQeTKUPpQU0aMQBGDG9EPk/umeej7VkDw1waIR8=;
        b=VcLXF+nUezqWl8jVfxL8qT1/1LDy/JXGwHasMrDgMyTu8EEhf/Tqo+oIzICuOMXFg5
         jCb83+ZuKOTTK5v/ADousy0HIL57HSVZt9pbsaNz4VhpgaKLI1jS6YBgKMKX0TtQt8oh
         JDTU1YH6Ydh6LTll5cvS2HC+J3l9z9ul7YmbvqjJBZmH2KkpmKqiMIVT/CZVpTbCz0E3
         QK8k/rybCwrRPbbdT9TJr/Me4SSGDu+31iUv+QPS3TyMVSwnyi6WXPzo7Hq4wDRGWivw
         uhyjDEGGnppGgIyMnUgP2PVC+kQFTSQRSAFuYM8/kUwASAf0ouDzxuzBfDUdxnOZm/X1
         8CFQ==
X-Gm-Message-State: AOJu0YyRJyiBzeQd0jDZnlsrY3/Xe25DpOjmBAG7PxFOOtXmG31WFHcO
        /j1H9Icc7buOS+RGJuColFgJPAIr5gUkpr/BK7Ppew==
X-Google-Smtp-Source: AGHT+IGZcOv7ZQLL12mB+17qgert2qyz+y6OZwNvXyJtI5UtexLrW6LRiiAPvulcoSl1BmeutGldHuWTQhcIW9ifMFY=
X-Received: by 2002:a05:6402:430e:b0:54b:67da:b2f with SMTP id
 m14-20020a056402430e00b0054b67da0b2fmr630112edc.7.1701280417472; Wed, 29 Nov
 2023 09:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20231129165721.337302-1-dima@arista.com> <20231129165721.337302-5-dima@arista.com>
In-Reply-To: <20231129165721.337302-5-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 29 Nov 2023 18:53:26 +0100
Message-ID: <CANn89i+Ln+d6fci8T1MWwACZGS-RE+DfOvQ1kvejGowtiYhofw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] net/tcp: Allow removing current/rnext TCP-AO keys
 on TCP_LISTEN sockets
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 5:57=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> TCP_LISTEN sockets are not connected to any peer, so having
> current_key/rnext_key doesn't make sense.

I do not understand this patch.

This seems that the clearing should happen at disconnect time, from
tcp_disconnect() ?

Why forcing user to set a socket option to clear these fields ?

>
> The userspace may falter over this issue by setting current or rnext
> TCP-AO key before listen() syscall. setsockopt(TCP_AO_DEL_KEY) doesn't
> allow removing a key that is in use (in accordance to RFC 5925), so
> it might be inconvenient to have keys that can be destroyed only with
> listener socket.
>
> Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  net/ipv4/tcp_ao.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index c8be1d526eac..bf41be6d4721 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -1818,8 +1818,16 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigne=
d short int family,
>                 if (!new_rnext)
>                         return -ENOENT;
>         }
> -       if (cmd.del_async && sk->sk_state !=3D TCP_LISTEN)
> -               return -EINVAL;
> +       if (sk->sk_state =3D=3D TCP_LISTEN) {
> +               /* Cleaning up possible "stale" current/rnext keys state,
> +                * that may have preserved from TCP_CLOSE, before sys_lis=
ten()
> +                */
> +               ao_info->current_key =3D NULL;
> +               ao_info->rnext_key =3D NULL;
> +       } else {
> +               if (cmd.del_async)
> +                       return -EINVAL;
> +       }
>
>         if (family =3D=3D AF_INET) {
>                 struct sockaddr_in *sin =3D (struct sockaddr_in *)&cmd.ad=
dr;
> --
> 2.43.0
>
