Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A929E7D3630
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjJWMPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjJWMPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:15:23 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50EFF9;
        Mon, 23 Oct 2023 05:15:20 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-637aaaf27f1so3823596d6.0;
        Mon, 23 Oct 2023 05:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698063320; x=1698668120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Day2LqITeqqQW3ubQWwhseOl/p+ZLKwUgz19cu93VSU=;
        b=Sxv7rNCfq2eafYNM31bCc7WnMe54201eXGTTd1Z+VBzTsO4w7utdcONore4Y2TM82T
         E/0b0Jnb2C7e8p5VpV3x+aMdW66DvGem2uvG1cNFD6LKq34cXADeJjyA/Va80Q4bakTI
         rP/XWrd2yt3RUTBwffKBEFcKopIFyrikwGo8ADnTLwnzwqrQkJXnIdZ+101ug26rI5xb
         LtkZDQSDxSmLm4hdiDkYl4t8pel1aU334xEmnSDct5/uSEJUXfcNA0Y7gZ8AyADCq/pN
         X4B/mhVRfqdQnw8SWpyDHuUGmY6t1J7t+tCfa1Q1cGGcv3qC8H+2DAukaThpgza01W2V
         7TZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698063320; x=1698668120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Day2LqITeqqQW3ubQWwhseOl/p+ZLKwUgz19cu93VSU=;
        b=Z3E79Yrqh/hn4kyhPLD3aNp0MSgqVOp96GOVdNVQmIRBW4e2rWKaeUupfCi42TQsIB
         vkQhEweEv/0RHZhiIOMfQpV4nF0Fxz5He1nP2jgz8XgKvzc3xKyOKzVbp5QraUm+Viu2
         HR2U1/9kB9NQAQpofxMDt9F/oTyImtlPtBmzWLBDeRgYqcK4o0hT6cbdVcuxLBj5kF14
         6sbSxgApfy9BA0/Zh0NmfBEyFvUSJvpAX7uYNFG5yygSKAzvG5Q8u8kb5vW9MUt6d5TP
         /DzzveEtuKYZdhjSnsZPHFFXTS5uZ29Ucqgj0C0hhXs2Vv5XVv0bUxVYmin5ziCcC/4t
         gQbQ==
X-Gm-Message-State: AOJu0Yx6ngGMRleyEHjM9GTXo83tpFvH9vF+4z1zYwst/Jv0TKfPHPFn
        bFF8PGyStR7gD8CoA8t3IgJEWXTYGfu/tatyIP0=
X-Google-Smtp-Source: AGHT+IHcaqoNGFxxeWmdXp7AQLKZdrTy5x64ROSxDuQqoBpjzVzCy+vrnbQX5/PjmyZnnWAPtSLtZpLZ1hKDg5oLl5U=
X-Received: by 2002:a05:6214:d0e:b0:668:e12a:1d1c with SMTP id
 14-20020a0562140d0e00b00668e12a1d1cmr9271368qvh.3.1698063319769; Mon, 23 Oct
 2023 05:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231023115255.76934-1-huangjie.albert@bytedance.com>
In-Reply-To: <20231023115255.76934-1-huangjie.albert@bytedance.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Mon, 23 Oct 2023 14:15:08 +0200
Message-ID: <CAJ8uoz0Uv0RrSj+AHXoMbswkzJa-cv9YnTmPHzs1W_ibVAsk9g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] xsk: avoid starving the xsk further down the list
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

On Mon, 23 Oct 2023 at 13:53, Albert Huang
<huangjie.albert@bytedance.com> wrote:
>
> In the previous implementation, when multiple xsk sockets were
> associated with a single xsk_buff_pool, a situation could arise
> where the xsk_tx_list maintained data at the front for one xsk
> socket while starving the xsk sockets at the back of the list.
> This could result in issues such as the inability to transmit packets,
> increased latency, and jitter. To address this problem, we introduced

we introduced -> introduce

> a new variable called tx_budget_cache, which limits each xsk to transmit
> a maximum of MAX_PER_SOCKET_BUDGET tx descriptors. This allocation ensures
> equitable opportunities for subsequent xsk sockets to send tx descriptors.
> The value of MAX_PER_SOCKET_BUDGET is temporarily set to TX_BATCH_SIZE(32).

It is not temporary I hope ;-). Just say "The value of
MAX_PER_SOCKET_BUDGET is set to 32."

>
> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> ---
>  include/net/xdp_sock.h |  5 +++++
>  net/xdp/xsk.c          | 19 +++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 69b472604b86..08cbdf6fca85 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -63,6 +63,11 @@ struct xdp_sock {
>
>         struct xsk_queue *tx ____cacheline_aligned_in_smp;
>         struct list_head tx_list;
> +       /* Record the actual number of times xsk has transmitted a tx
> +        * descriptor, with a maximum limit not exceeding MAX_PER_SOCKET_BUDGET
> +        */
> +       u32 tx_budget_cache;

Since this is not a cache, I would prefer a name like tx_budget_spent.
Reflects more what the purpose is of this variable. Do not forget to
change this in the commit message too.

> +
>         /* Protects generic receive. */
>         spinlock_t rx_lock;
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f5e96e0d6e01..fd0d54b7c046 100644
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
> +       bool xsk_cache_full = false;

Same comment here, it is not a cache. How about just budget_exhausted?
No need for the xsk_ since this is a local variable.

>         struct xdp_sock *xs;
>
>         rcu_read_lock();
> +again:
>         list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> +               if (xs->tx_budget_cache >= MAX_PER_SOCKET_BUDGET) {
> +                       xsk_cache_full = true;
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
>                  * if there is space in it. This avoids having to implement
> @@ -436,6 +446,14 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
>                 return true;
>         }
>
> +       if (xsk_cache_full) {
> +               list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> +                       xs->tx_budget_cache = 0;
> +               }

No need for the {} here since there is only a single line in the loop.
Please remove them.

> +               xsk_cache_full = false;
> +               goto again;
> +       }
> +
>  out:
>         rcu_read_unlock();
>         return false;
> @@ -1230,6 +1248,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
>         xs->zc = xs->umem->zc;
>         xs->sg = !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
>         xs->queue_id = qid;
> +       xs->tx_budget_cache = 0;

This is not needed. The struct is zeroed at allocation.

>         xp_add_xsk(xs->pool, xs);
>
>  out_unlock:
> --
> 2.20.1
>
>
