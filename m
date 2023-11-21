Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E127F2706
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjKUIOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKUIN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:13:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5DECB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:13:55 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-548db776f6cso6792a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700554433; x=1701159233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf+BdlEkGDbGf7M1TsZM1PoygNkC+ixC14u9l75PZkw=;
        b=XsiEoi7+g05dayZN6xmalA1z6MxeyC2bjF6D7bzN8LEYkqtLJGTT0AY7aUiLWhFCju
         LpoGP5q0MVEv9X7melgOzatiTFoX94fkYIAUdb6HTPkfoN82kZJcVfLS+Tt7gbp/OJ1U
         eYmZiccnuVa99VdoAOCMNGvsLF5wDNPgxO0Ka+G8aNrkpBYt2Aovgwuuz6CMZT3WXSVd
         qzjGtxbpApQHWreoIbQjZwyYkclX5TUIzYilJ8fd0Kf39UqLc3pxr116tUKQo5DWR+1y
         8f5fDKsD5poiQBYt1fnWIds1WTpBOQ3nUTuEDNjoG6DiVTbhQeRDmBufSKSf5uOzfHLA
         i8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700554433; x=1701159233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf+BdlEkGDbGf7M1TsZM1PoygNkC+ixC14u9l75PZkw=;
        b=Uo9dFb4qxhfLq0ufIWyoYIDd21HBiY3PAnifeapdth7wrqhtPRbz+V+FkFAPJpyagu
         4aIGafvR481p0nH2M9bEajgWHV51xyzb2A4YqnXfRbKaoIAjU3twhlx1x1MAfv0fAwi9
         udiJHWXkzanxVFytunLtUT4FP125fmqH+pzthEKf4y1YGhWwFH0+tajhyL91GihaXrjU
         pzT66rfOzVfNN9uAb5s5xcxTLvrRd9+WI+DigKEUMlaaEnaHbZk1ZPR4zulbD1++A8+k
         5NxXb3VeiPV/xXl2ZmHSdez/MlVk3pMF/lr7xVYsld3UBg5P+V1m1EVcOTbxidMEhoQq
         8XYw==
X-Gm-Message-State: AOJu0YwFRUnZl1Dt34mn58f1gbG0X45Dl8x3BRbx6jVPJcToIMoBsFaa
        Gi02h5nF8ZXqC4k1ha4BFCPW1gwv/eA37oLnDe74BA==
X-Google-Smtp-Source: AGHT+IGFwYxSbTDYvmUGtIwukajn1P1YWpIV0tYvyPHz82Xr6UQWNYv5FGNk7ZL/FeBdbiKiC7fIf9xNc3PSUwRu3tU=
X-Received: by 2002:a05:6402:3886:b0:543:fb17:1a8 with SMTP id
 fd6-20020a056402388600b00543fb1701a8mr575639edb.3.1700554433190; Tue, 21 Nov
 2023 00:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20231121020111.1143180-1-dima@arista.com> <20231121020111.1143180-8-dima@arista.com>
In-Reply-To: <20231121020111.1143180-8-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 21 Nov 2023 09:13:42 +0100
Message-ID: <CANn89iK-=G7p5CMuJDjioa7+ynZRrOOpd7bK3kPzxCXzygfFCQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] net/tcp: Don't store TCP-AO maclen on reqsk
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

On Tue, Nov 21, 2023 at 3:01=E2=80=AFAM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> This extra check doesn't work for a handshake when SYN segment has
> (current_key.maclen !=3D rnext_key.maclen). It could be amended to
> preserve rnext_key.maclen instead of current_key.maclen, but that
> requires a lookup on listen socket.
>
> Originally, this extra maclen check was introduced just because it was
> cheap. Drop it and convert tcp_request_sock::maclen into boolean
> tcp_request_sock::used_tcp_ao.
>
> Fixes: 06b22ef29591 ("net/tcp: Wire TCP-AO to request sockets")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/linux/tcp.h   | 10 ++++------
>  net/ipv4/tcp_ao.c     |  4 ++--
>  net/ipv4/tcp_input.c  |  5 +++--
>  net/ipv4/tcp_output.c |  9 +++------
>  4 files changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 68f3d315d2e1..3af897b00920 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -155,6 +155,9 @@ struct tcp_request_sock {
>         bool                            req_usec_ts;
>  #if IS_ENABLED(CONFIG_MPTCP)
>         bool                            drop_req;
> +#endif
> +#ifdef CONFIG_TCP_AO
> +       bool                            used_tcp_ao;

Why adding another 8bit field here and creating a hole ?

>  #endif
>         u32                             txhash;
>         u32                             rcv_isn;
> @@ -169,7 +172,6 @@ struct tcp_request_sock {
>  #ifdef CONFIG_TCP_AO
>         u8                              ao_keyid;
>         u8                              ao_rcv_next;
> -       u8                              maclen;

Just rename maclen here to  used_tcp_ao ?

>  #endif
>  };
>
