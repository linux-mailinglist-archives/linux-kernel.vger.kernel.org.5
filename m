Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4312277477C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjHHTPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjHHTOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:14:44 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F42614595;
        Tue,  8 Aug 2023 09:37:38 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d593a63e249so1291681276.3;
        Tue, 08 Aug 2023 09:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691512628; x=1692117428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1NFY3VdQSb9Zqy0SLKHAuSu4mepElX+9AY6ISptc7A=;
        b=lnjNTk76EJhxe170Ber/m2Ta5V/1jtLHDBLmMD0JYx7yevLbvSYvVGGDAu0GW3D/6U
         Sa8ChHydFDVZmbX0tTfE9p8ENZ0pybIQ48smkQNCSh7bk2nIx4uCPinzCsm+EER//nVF
         3/6BT1ghjjupgQKsNaYGxT2x/g90u0xnAGn5dJQmT+HuBHoZ4HTl/Bi//ktD1jPQdX98
         CKzDpoWYu5sPRplLUxF/viKmvBqSqpLiAUI+JOb3LmRJPJ8OZq8s8ZgB7vOOR2bl073w
         6wUd9eQ3qc7uszytp3WCqmSeonZGwguAEm+6VVP1qSBHUK471ZEJ5QEQOLdrgNvpMSjI
         kNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512628; x=1692117428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1NFY3VdQSb9Zqy0SLKHAuSu4mepElX+9AY6ISptc7A=;
        b=I56n8FPRclMCGrjoxKPhcIJJVVcoSDA5SRK7Y7g7RByHzaAYt3B/xCJpTUYUHKrvt3
         RD9sbtZcUsF6JqOgpU3FP/F4unbamIm6K/8iDsdkcZvEiMlCJL9VDIJmxnWgzeOwIyQb
         vgKTAp5YD2YMkzwn8WjUvu16TUsny7DirspRHanPqSPCMbLOfRsPLc0ELIhWveqtnzdF
         w01xc0Cfs9DumxWNzsksdAKuM/6h6QCCgtTrVK7MfOTJ/Ry6vTvuIAwI/3NG59VIgSlw
         ucWR/RHCBM/LlRmNajTDtK96snVUPiYKt4vOJnZs7prSZlJQ0t4iaI1jpUvXMDOCglOX
         5tIA==
X-Gm-Message-State: AOJu0YwRe+iF2SDYo+t0pI08hJyVv5NcDZ2k3rxcrCghUXTMt3qIAQL1
        6XB/MiF+g+D+aKfD2zBKa8iFOVxXak/jJa++BtEfLX3f
X-Google-Smtp-Source: AGHT+IHTpkThIqFuGfK/2amDNPTDmnfieKGEWv6tFlNYZqVK0lo9FRR56ROQMjc00EwVtS4enzsrcJtq/ZwK297L3Rw=
X-Received: by 2002:a17:90a:1f41:b0:268:e5db:6e19 with SMTP id
 y1-20020a17090a1f4100b00268e5db6e19mr9233015pjy.20.1691502363028; Tue, 08 Aug
 2023 06:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
 <20230804180529.2483231-6-aleksander.lobakin@intel.com> <692d71dc8068b3d27aba39d7141c811755965786.camel@gmail.com>
 <601c0203-ee5f-03a3-e9dd-fdb241f3bcdc@intel.com>
In-Reply-To: <601c0203-ee5f-03a3-e9dd-fdb241f3bcdc@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 8 Aug 2023 06:45:26 -0700
Message-ID: <CAKgT0Uc0pLzaOfqFbvd9jFErAbTbsUMNNw5e_XY5NfCnO0=g0g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/6] page_pool: add a lockdep check for
 recycling in hardirq
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 6:16=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander H Duyck <alexander.duyck@gmail.com>
> Date: Mon, 07 Aug 2023 07:48:54 -0700
>
> > On Fri, 2023-08-04 at 20:05 +0200, Alexander Lobakin wrote:
> >> From: Jakub Kicinski <kuba@kernel.org>
> >>
> >> Page pool use in hardirq is prohibited, add debug checks
> >> to catch misuses. IIRC we previously discussed using
> >> DEBUG_NET_WARN_ON_ONCE() for this, but there were concerns
> >> that people will have DEBUG_NET enabled in perf testing.
> >> I don't think anyone enables lockdep in perf testing,
> >> so use lockdep to avoid pushback and arguing :)
> >>
> >> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >> ---
> >>  include/linux/lockdep.h | 7 +++++++
> >>  net/core/page_pool.c    | 2 ++
> >>  2 files changed, 9 insertions(+)
> >>
> >> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> >> index 310f85903c91..dc2844b071c2 100644
> >> --- a/include/linux/lockdep.h
> >> +++ b/include/linux/lockdep.h
> >> @@ -625,6 +625,12 @@ do {                                             =
                       \
> >>      WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirq_context)=
); \
> >>  } while (0)
> >>
> >> +#define lockdep_assert_no_hardirq()                                 \
> >> +do {                                                                 =
       \
> >> +    WARN_ON_ONCE(__lockdep_enabled && (this_cpu_read(hardirq_context)=
 || \
> >> +                                       !this_cpu_read(hardirqs_enable=
d))); \
> >> +} while (0)
> >> +
> >>  #define lockdep_assert_preemption_enabled()                         \
> >>  do {                                                                 =
       \
> >>      WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)   &&              \
> >> @@ -659,6 +665,7 @@ do {                                              =
                       \
> >>  # define lockdep_assert_irqs_enabled() do { } while (0)
> >>  # define lockdep_assert_irqs_disabled() do { } while (0)
> >>  # define lockdep_assert_in_irq() do { } while (0)
> >> +# define lockdep_assert_no_hardirq() do { } while (0)
> >>
> >>  # define lockdep_assert_preemption_enabled() do { } while (0)
> >>  # define lockdep_assert_preemption_disabled() do { } while (0)
> >> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> >> index 03ad74d25959..77cb75e63aca 100644
> >> --- a/net/core/page_pool.c
> >> +++ b/net/core/page_pool.c
> >> @@ -587,6 +587,8 @@ static __always_inline struct page *
> >>  __page_pool_put_page(struct page_pool *pool, struct page *page,
> >>                   unsigned int dma_sync_size, bool allow_direct)
> >>  {
> >> +    lockdep_assert_no_hardirq();
> >> +
> >>      /* This allocator is optimized for the XDP mode that uses
> >>       * one-frame-per-page, but have fallbacks that act like the
> >>       * regular page allocator APIs.
> >
> > So two points.
> >
> > First could we look at moving this inside the if statement just before
> > we return the page, as there isn't a risk until we get into that path
> > of needing a lock.
> >
> > Secondly rather than returning an error is there any reason why we
> > couldn't just look at not returning page and instead just drop into the
> > release path which wouldn't take the locks in the first place? Either
>
> That is exception path to quickly catch broken drivers and fix them, why
> bother? It's not something we have to live with.

My concern is that the current "fix" consists of stalling a Tx ring.
We need to have a way to allow forward progress when somebody mixes
xdp_frame and skb traffic as I suspect we will end up with a number of
devices doing this since they cannot handle recycling the pages in
hardirq context.

The only reason why the skbs don't have the problem is that they are
queued and then cleaned up in the net_tx_action. That is why I wonder
if we shouldn't look at adding some sort of support for doing
something like that with xdp_frame as well. Something like a
dev_kfree_pp_page_any to go along with the dev_kfree_skb_any.
