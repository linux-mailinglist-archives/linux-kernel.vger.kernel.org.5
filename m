Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D682F7C9DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjJPDKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjJPDKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:10:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744A4D6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:10:36 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso29638421fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697425835; x=1698030635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaakfOTXKlMjsqs7sKQHJ+B6CkPArdgWlfDUoDtnzYE=;
        b=HrGLsE81Dbl5kwP9gZWdQO1uScMX6lpalOar8GLqh3jMa0c5EKquC/ZYo+1CXPcCpl
         bYGIZoL/mMaxwWxi0/fUc1mN2BEnslA1HKm3eK0Te9RNP2o9VvLB1MuVsYD1MohbLabI
         rFMN4EWyVvsfGQm7D6w29HfW8THEyDTNifmJd+8xuHU5BTwLmoghI9DCzVYl6lfUZapK
         ZY4CdBvx+gXezEmy6chY309ef81DoiEW4xnjPVUYYrjMQSkHXmc29jAJyWa+3i2omeLY
         wfo1dfVNUrjaVGU45zC7gcHnZNhKFo/CBqr0iCEMMCDxahGf0FgAxYavf3wsGnxLIuhq
         euVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697425835; x=1698030635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaakfOTXKlMjsqs7sKQHJ+B6CkPArdgWlfDUoDtnzYE=;
        b=h9MtqoYYk9E9rCdQH7Q1J7THDm3LWQQSGiySpcpjNgN9OkXxIJGmKFXpknmQlJkvwJ
         4yXhyQctNZn3fdpB0woZJ0cMe0MzZtohuvUB4UdOiJZTZ7rZFEv0DpOubD6AX0lE79h3
         wrP82QvXgUd0s+dmDxdFloB0keHj13esj0a2SjTvTYFBdvHUeFNkfKVfWjtePjwOf6ng
         kS9gD2r0GN7VFdc8f3yfkTRSyjW0i3dFFV5dD+fvZF+tyIMSkgoMt2gjbKjnBiDkqFpF
         JT4WTWGsSAqnifgPaAlt+Gqs9C1XJS/dvfwXwXWM94Cf1D4Gz9v/QCOBgfEcei4nFWV/
         iRSw==
X-Gm-Message-State: AOJu0Yw9Y9az23OLntaYXi1DNH7yx8/jh0krdLtfCGTfBAu/AVHs1lw+
        tqxdrSYzkpQ+Buc0CasoWkxZe991Gs7aAMVZu7dEiA==
X-Google-Smtp-Source: AGHT+IFw9lI1ekuAxkmE0fWYz6RUZ+iinddYWRM1ugIXNswjPoyGuvg3J8eof9Ngzw5Tns6aYKW6zFrlJlfWVaPsGW8=
X-Received: by 2002:a2e:a7ca:0:b0:2c5:d46:85ec with SMTP id
 x10-20020a2ea7ca000000b002c50d4685ecmr6767391ljp.26.1697425834694; Sun, 15
 Oct 2023 20:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231013063332.38189-1-huangjie.albert@bytedance.com>
In-Reply-To: <20231013063332.38189-1-huangjie.albert@bytedance.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Mon, 16 Oct 2023 11:10:23 +0800
Message-ID: <CABKxMyM=JUiPpmUEBO8hruxPqZCgAHpa7obg+hPEMJbZ5B+Wtw@mail.gmail.com>
Subject: Re: [PATCH net-next] xsk: Avoid starving xsk at the end of the list
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Huang <huangjie.albert@bytedance.com> =E4=BA=8E2023=E5=B9=B410=E6=9C=
=8813=E6=97=A5=E5=91=A8=E4=BA=94 14:33=E5=86=99=E9=81=93=EF=BC=9A
>
> In the previous implementation, when multiple xsk sockets were
> associated with a single xsk_buff_pool, a situation could arise
> where the xsk_tx_list maintained data at the front for one xsk
> socket while starving the xsk sockets at the back of the list.
> This could result in issues such as the inability to transmit packets,
> increased latency, and jitter. To address this problem, we introduced
> a new variable called tx_budget_cache, which limits each xsk to transmit
> a maximum of MAX_XSK_TX_BUDGET tx descriptors. This allocation ensures
> equitable opportunities for subsequent xsk sockets to send tx descriptors=
.
> The value of MAX_XSK_TX_BUDGET is temporarily set to 16.
>
> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> ---
>  include/net/xdp_sock.h |  6 ++++++
>  net/xdp/xsk.c          | 17 +++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 69b472604b86..f617ff54e38c 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -44,6 +44,7 @@ struct xsk_map {
>         struct xdp_sock __rcu *xsk_map[];
>  };
>
> +#define MAX_XSK_TX_BUDGET 16
>  struct xdp_sock {
>         /* struct sock must be the first member of struct xdp_sock */
>         struct sock sk;
> @@ -63,6 +64,11 @@ struct xdp_sock {
>
>         struct xsk_queue *tx ____cacheline_aligned_in_smp;
>         struct list_head tx_list;
> +       /* Record the actual number of times xsk has transmitted a tx
> +        * descriptor, with a maximum limit not exceeding MAX_XSK_TX_BUDG=
ET
> +        */
> +       u32 tx_budget_cache;
> +
>         /* Protects generic receive. */
>         spinlock_t rx_lock;
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f5e96e0d6e01..bf964456e9b1 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -413,16 +413,25 @@ EXPORT_SYMBOL(xsk_tx_release);
>
>  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
>  {
> +       u32 xsk_full_count =3D 0;
>         struct xdp_sock *xs;
>
>         rcu_read_lock();
> +again:
>         list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> +               if (xs->tx_budget_cache >=3D MAX_XSK_TX_BUDGET) {
> +                       xsk_full_count++;
> +                       continue;
> +               }
> +
>                 if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
>                         if (xskq_has_descs(xs->tx))
>                                 xskq_cons_release(xs->tx);
>                         continue;
>                 }
>
> +               xs->tx_budget_cache++;
> +
>                 /* This is the backpressure mechanism for the Tx path.
>                  * Reserve space in the completion queue and only proceed
>                  * if there is space in it. This avoids having to impleme=
nt
> @@ -436,6 +445,13 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, st=
ruct xdp_desc *desc)
>                 return true;
>         }
>
> +       if (unlikely(xsk_full_count > 0)) {
> +               list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) =
{
> +                       xs->tx_budget_cache =3D 0;
> +               }
> +               goto again;
> +       }

xsk_full_count should set to 0, I will resend another patch to fix this.

> +
>  out:
>         rcu_read_unlock();
>         return false;
> @@ -1230,6 +1246,7 @@ static int xsk_bind(struct socket *sock, struct soc=
kaddr *addr, int addr_len)
>         xs->zc =3D xs->umem->zc;
>         xs->sg =3D !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
>         xs->queue_id =3D qid;
> +       xs->tx_budget_cache =3D 0;
>         xp_add_xsk(xs->pool, xs);
>
>  out_unlock:
> --
> 2.20.1
>
