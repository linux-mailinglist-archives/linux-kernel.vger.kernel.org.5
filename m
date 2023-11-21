Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675A47F26F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjKUIJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjKUIJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:09:08 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5F8112
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:09:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-548db776f6cso6735a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700554143; x=1701158943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKicp15faTy9dxr+lo3vJn4RmNCBFdNPH9aMUCXaj3A=;
        b=COEgIEDEqYeeTZAhnrdzaWBpwGIcQGx/OrLX5I+ZGW7BBzOGRa1KgP+YLh+UVpJ0TB
         yA2g/2jQ5kl1gjltZwGHDWB5sVCz703V1J0vkWMQD6Xpa+K/FYKlNjt7xE9iPH5pcxG7
         KGH4BREMUO3FEK4fTA2lPXwhgpMHZ1IF6e0WSWr2OtYF3+sVaE/QIBn19zr6YbmZF9ZC
         gU+9JKODmbTOf9VQVRP4TqfQICzUbuX7wxIaqwiOEoQDChRJSkw4zcCImL0oXu7fASdp
         o2+jA+qPjx4seSSvZLMHL/vnJ45hwN/U6WV3ubC87i/wZfhk2TLrFYJEluqsRp9AruLq
         l58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700554143; x=1701158943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKicp15faTy9dxr+lo3vJn4RmNCBFdNPH9aMUCXaj3A=;
        b=KgcGFqyPOVi+0jTOmkMGmzS8NJNSHKcaAy+alYGNI4pH6nWF3TCXj9te8EFpo+3jie
         hyRu2cPel+xM/31RLNeXi/T385EoZ8ql61+P/KktihkuDD4xP3S3n9MDwcyHkvIEPV8c
         rI0o7Ieh0BIngqotb8JmjUkKdU81Twe17d8Rm23qznKWv9LLM+TehRKGS2fwtjsQ7XXM
         fdpD7zJpejybBrWOu6wgGhdK1Rt8sVDhZcHAxbnvVqXKk5vtbyS7m03z6rgY4qUhlY0x
         6zeyXeRGCvgkVSx/+WbljRx0JN+Ff4iklyzpecipfbz/VwKCCOG3JGGrFG6hqsB1YOYw
         Y2Kw==
X-Gm-Message-State: AOJu0YzAO1dvEXlldDCeEk9oDEBzL4lMwe/fjN52EO/XlWDt6vjtYTDA
        /DOL9n9UpKdFXjWeScCDYORfQsFAVcV60QTGoZSqD1SoYLePn7h6i6OVuQ==
X-Google-Smtp-Source: AGHT+IFk7rTNn469v7x2wpKCPVaSegxVKameTngvf3SmEjxXVkO7FQ2gV5Q2EICNAOLjWO6335FnMrlK5knzBXdZPJY=
X-Received: by 2002:a05:6402:12:b0:547:e5b:6e17 with SMTP id
 d18-20020a056402001200b005470e5b6e17mr502485edu.2.1700554142874; Tue, 21 Nov
 2023 00:09:02 -0800 (PST)
MIME-Version: 1.0
References: <20231121020111.1143180-1-dima@arista.com> <20231121020111.1143180-7-dima@arista.com>
In-Reply-To: <20231121020111.1143180-7-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 21 Nov 2023 09:08:49 +0100
Message-ID: <CANn89iLEANNvZ45PaPL8miZeyMUTAcLoVR4WS55gbtfiMPbueQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] net/tcp: ACCESS_ONCE() on snd/rcv SNEs
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
> SNEs need READ_ONCE()/WRITE_ONCE() for access as they can be written and
> read at the same time.
>
> This is actually a shame: I planned to send it in TCP-AO patches, but
> it seems I've chosen a wrong commit to git-commit-fixup some time ago.
> It ended up in a commit that adds a selftest. Human factor.
>
> Fixes: 64382c71a557 ("net/tcp: Add TCP-AO SNE support")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  net/ipv4/tcp_ao.c    | 4 ++--
>  net/ipv4/tcp_input.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index 122ff58168ee..9b7f1970c2e9 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -956,8 +956,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_=
buff *skb,
>                 if (unlikely(th->syn && !th->ack))
>                         goto verify_hash;
>
> -               sne =3D tcp_ao_compute_sne(info->rcv_sne, tcp_sk(sk)->rcv=
_nxt,
> -                                        ntohl(th->seq));
> +               sne =3D tcp_ao_compute_sne(READ_ONCE(info->rcv_sne),
> +                                        tcp_sk(sk)->rcv_nxt, ntohl(th->s=
eq));


I think this is a wrong fix. Something is definitely fishy here.

Update side should only happen for an established socket ?

And the read side should have locked the socket before calling
tcp_inbound_ao_hash(),
otherwise reading other fields (like tcp_sk(sk)->rcv_nxt) would be racy any=
way.


>                 /* Established socket, traffic key are cached */
>                 traffic_key =3D rcv_other_key(key);
>                 err =3D tcp_ao_verify_hash(sk, skb, family, info, aoh, ke=
y,
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index bcb55d98004c..78896c8be0d4 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c

tcp_snd_sne_update() definitely only deals with full sockets
(TCP_AO_ESTABLISHED)

> @@ -3583,7 +3583,7 @@ static void tcp_snd_sne_update(struct tcp_sock *tp,=
 u32 ack)
>         ao =3D rcu_dereference_protected(tp->ao_info,
>                                        lockdep_sock_is_held((struct sock =
*)tp));
>         if (ao && ack < tp->snd_una)
> -               ao->snd_sne++;
> +               WRITE_ONCE(ao->snd_sne, ao->snd_sne + 1);
>  #endif
>  }
>
> @@ -3609,7 +3609,7 @@ static void tcp_rcv_sne_update(struct tcp_sock *tp,=
 u32 seq)
>         ao =3D rcu_dereference_protected(tp->ao_info,
>                                        lockdep_sock_is_held((struct sock =
*)tp));
>         if (ao && seq < tp->rcv_nxt)
> -               ao->rcv_sne++;
> +               WRITE_ONCE(ao->rcv_sne, ao->rcv_sne + 1);
>  #endif
>  }
>
> --
> 2.42.0
>
