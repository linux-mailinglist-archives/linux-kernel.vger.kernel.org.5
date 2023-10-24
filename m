Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C067D4C88
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjJXJej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjJXJeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:34:05 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46817268B;
        Tue, 24 Oct 2023 02:33:45 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d32cc3957so10279286d6.0;
        Tue, 24 Oct 2023 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698140024; x=1698744824; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hnpIQUPDm6Zq9acYBDFChtR53+u4G5h2VpvaQkr0GYM=;
        b=frfKjSUqUdTV5sRBaJz3JxpC2w6xamMceVamFKuM8LzSN87o1yuW2ZQf52RmocKYr0
         c0vX0PZW1DtIZpPPicxk4o1LEmcM/fiybITqugE2f6Qxl4OG/KQVo4HEuAyCbMUaK+WP
         hduOhOIE4mI5ftzYym+e9L18WFt6FlEVs7p6k2FfHQgWuJRn9/rLom9dSdXZ639175xb
         PjaLi0I61BHrzUXGtKVP0edfgocgV99ZY7JVWeU5WCWwCEat2sXfWf0D851L0KW9kQdf
         /mo8ea0BY1RYWaEhAXrP/FgLMj1jhdni1BuPVyvJqFIFCQXtqqPDGTNyZk4liiWm/WmV
         +RyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698140024; x=1698744824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnpIQUPDm6Zq9acYBDFChtR53+u4G5h2VpvaQkr0GYM=;
        b=J3HBmVxhDPePwFUYroUvaI++noXalaPwStkW8oYtHD8OlgVreVl7qrGXMhsEOjSfOp
         G5WYBnoEKsAba/sjF2jVabryFAAV3QPeXaRkAm1qkoemExlWtKGHROJU5dmwWYgyHzLo
         58kVsk+YwZxqbaQ5l3c6j8PRM4rKu9ltPH94ZKK6RyxLTHW7h8Wlcu8dK4MVGIVCZtoC
         T55TqUv37v+CR0fIOGNOO7au9sbDN8aj4ASx1D4igAUzI6QjEzG+PeI0ZFhHiLRZZ2so
         8YpOFoqx7x3I5a5oSyKbBxqeG8O9uHiIC88WLf0InqyxQ2W7hhep9+be+ugZdgJ8oOpt
         BK0g==
X-Gm-Message-State: AOJu0YzGKaOkJirNPqliDDWgmWJwOaWLrDpqIaSTn6K7o4RA0CmGNZ+r
        npcDdfPfQEk1Yndm2J1hS3kzizAuNv0yS5Zvuys=
X-Google-Smtp-Source: AGHT+IGfXBx6g6iC3iWUPgREpEWmhHh8YsRyDeFkE6Bg7pnu11hKBIKTbhhdb+2mHNqCmhgjGw+sExZE/sZhJQVMNys=
X-Received: by 2002:a05:6214:2dc8:b0:65d:486:25c6 with SMTP id
 nc8-20020a0562142dc800b0065d048625c6mr12536219qvb.3.1698140024285; Tue, 24
 Oct 2023 02:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231023125732.82261-1-huangjie.albert@bytedance.com>
In-Reply-To: <20231023125732.82261-1-huangjie.albert@bytedance.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Tue, 24 Oct 2023 11:33:33 +0200
Message-ID: <CAJ8uoz2zSPNdSdOFDQ8DB3gW+F7eHQrT9XxmiNbqHvtfWRCr5g@mail.gmail.com>
Subject: Re: [PATCH v4 net-next] xsk: avoid starving the xsk further down the list
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 at 14:57, Albert Huang
<huangjie.albert@bytedance.com> wrote:
>
> In the previous implementation, when multiple xsk sockets were
> associated with a single xsk_buff_pool, a situation could arise
> where the xsk_tx_list maintained data at the front for one xsk
> socket while starving the xsk sockets at the back of the list.
> This could result in issues such as the inability to transmit packets,
> increased latency, and jitter. To address this problem, we introduce
> a new variable called tx_budget_spent, which limits each xsk to transmit
> a maximum of MAX_PER_SOCKET_BUDGET tx descriptors. This allocation ensures
> equitable opportunities for subsequent xsk sockets to send tx descriptors.
> The value of MAX_PER_SOCKET_BUDGET is set to 32.

Thank you Albert for implementing this feature!

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> ---
>  include/net/xdp_sock.h |  7 +++++++
>  net/xdp/xsk.c          | 18 ++++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 69b472604b86..de6819e50d54 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -63,6 +63,13 @@ struct xdp_sock {
>
>         struct xsk_queue *tx ____cacheline_aligned_in_smp;
>         struct list_head tx_list;
> +       /* record the number of tx descriptors sent by this xsk and
> +        * when it exceeds MAX_PER_SOCKET_BUDGET, an opportunity needs
> +        * to be given to other xsks for sending tx descriptors, thereby
> +        * preventing other XSKs from being starved.
> +        */
> +       u32 tx_budget_spent;
> +
>         /* Protects generic receive. */
>         spinlock_t rx_lock;
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f5e96e0d6e01..65c32b85c326 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -33,6 +33,7 @@
>  #include "xsk.h"
>
>  #define TX_BATCH_SIZE 32
> +#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
>
>  static DEFINE_PER_CPU(struct list_head, xskmap_flush_list);
>
> @@ -413,16 +414,25 @@ EXPORT_SYMBOL(xsk_tx_release);
>
>  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
>  {
> +       bool budget_exhausted = false;
>         struct xdp_sock *xs;
>
>         rcu_read_lock();
> +again:
>         list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> +               if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
> +                       budget_exhausted = true;
> +                       continue;
> +               }
> +
>                 if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
>                         if (xskq_has_descs(xs->tx))
>                                 xskq_cons_release(xs->tx);
>                         continue;
>                 }
>
> +               xs->tx_budget_spent++;
> +
>                 /* This is the backpressure mechanism for the Tx path.
>                  * Reserve space in the completion queue and only proceed
>                  * if there is space in it. This avoids having to implement
> @@ -436,6 +446,14 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
>                 return true;
>         }
>
> +       if (budget_exhausted) {
> +               list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list)
> +                       xs->tx_budget_spent = 0;
> +
> +               budget_exhausted = false;
> +               goto again;
> +       }
> +
>  out:
>         rcu_read_unlock();
>         return false;
> --
> 2.20.1
>
>
