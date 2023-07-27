Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14907765C27
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjG0Tbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjG0Tbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:31:38 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0232D73
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:31:37 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40540a8a3bbso1291cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690486296; x=1691091096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiMrNW8egjJ/rz9pVUsvEDQn31eh5Gj1t0I59KNhMyg=;
        b=HBTIQxL/BwS48caM6acLiUiYzUitIQ/qI+Svnmg1+fDsEi2T6O/2Iw72v3njryct4A
         qTRz7s0d4+6h2wIMkxuq4Pg8Yi6n+JyG0tPEJU1ydcmvj4Y5fcWArU0BhmKFZQBhlj2x
         KCMJj8gJgJccPVS1ftG0oSj2bB01iiJbSsiU11Mksgy/TCzF26o2/z2RYWPCRVfrIAE4
         v6E1V3mRFTGdJ7+urGsco42GFYFRO3DWqoxUkfc8aTEGdyrZWzy82jK8ekeBTJAmkRqm
         Xvgps+ajD6M/9K/7kHg1F5LJnvL0+1kTH8WWNphAJFiUbtIE4368KJDYAe8OyMDaaerf
         3zcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690486296; x=1691091096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiMrNW8egjJ/rz9pVUsvEDQn31eh5Gj1t0I59KNhMyg=;
        b=WOYlTuLL63CJt4qrFX2c6Sffwx3DrL1BhBScsYYbfFsh2zNUk8dnUdpsGGyfrtVKuo
         UiQ28TLcqfRwts/Zt3yi6xWMNIGSCBLnsdUxzO/wUElbiUUP/06sZEDHmR2PEFph8jRP
         l1El6snhCqeH0s+NiqTXpJ/SbJy0JLXuRYcVduVm31V0jiZPL5SlpZrQs5rQonBtp+p2
         gqcMlFMsYuL5UJMrsCrXkqLkMhMJYuzdB8GPNfTG1BhMxBtkSnsqlgv2YXG0p1VSDJdC
         9lJswLfcbbd4x2QY8J5y/QmuAiNS0OG0KE631L1Jlj+Xt/3w4W3UBueIbPzTk4S//KJy
         CfqQ==
X-Gm-Message-State: ABy/qLYb55QQKEp3mtvzalXpbqsO7aE7gfOWNj/ziQSWZu8jFnpPd8H2
        czQ/5Hy0tF9W7jKq85Zdb1TBWWoVG4P7/b6quCEKig==
X-Google-Smtp-Source: APBJJlEgEoveD20WngLpwZFqt+XIR5MqAui5xP7Jad5pqY3GIN2pAcUY+nv2IM84Ol1+aGxHkCs2pG2IhBHgXNgK62M=
X-Received: by 2002:a05:622a:448:b0:3f2:1441:3c11 with SMTP id
 o8-20020a05622a044800b003f214413c11mr62944qtx.2.1690486296479; Thu, 27 Jul
 2023 12:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230727125125.1194376-1-imagedong@tencent.com> <20230727125125.1194376-4-imagedong@tencent.com>
In-Reply-To: <20230727125125.1194376-4-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 27 Jul 2023 21:31:24 +0200
Message-ID: <CANn89iKWTrgEp3QY34mNqVAx09fSxHUh+oHRTd6=aWurGS7qWA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: tcp: check timeout by
 icsk->icsk_timeout in tcp_retransmit_timer()
To:     menglong8.dong@gmail.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>,
        Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 2:52=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> In tcp_retransmit_timer(), a window shrunk connection will be regarded
> as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX'. This is not
> right all the time.
>
> The retransmits will become zero-window probes in tcp_retransmit_timer()
> if the 'snd_wnd=3D=3D0'. Therefore, the icsk->icsk_rto will come up to
> TCP_RTO_MAX sooner or later.
>
> However, the timer is not precise enough, as it base on timer wheel.
> Sorry that I am not good at timer, but I know the concept of time-wheel.
> The longer of the timer, the rougher it will be. So the timeout is not
> triggered after TCP_RTO_MAX, but 122877ms as I tested.
>
> Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is always true
> once the RTO come up to TCP_RTO_MAX.
>
> Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_timeout',
> which is exact the timestamp of the timeout.
>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  net/ipv4/tcp_timer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 470f581eedd4..3a20db15a186 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -511,7 +511,11 @@ void tcp_retransmit_timer(struct sock *sk)
>                                             tp->snd_una, tp->snd_nxt);
>                 }
>  #endif
> -               if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
> +               /* It's a little rough here, we regard any valid packet t=
hat
> +                * update tp->rcv_tstamp as the reply of the retransmitte=
d
> +                * packet.
> +                */
> +               if ((u32)icsk->icsk_timeout - tp->rcv_tstamp > TCP_RTO_MA=
X) {
>                         tcp_write_err(sk);
>                         goto out;
>                 }


Hmm, this looks like a net candidate, since this is unrelated to the
other patches ?

Neal, what do you think ?
