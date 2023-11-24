Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509C47F758B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjKXNuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXNuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:50:10 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E237D41;
        Fri, 24 Nov 2023 05:50:16 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b83fdab870so151335b6e.0;
        Fri, 24 Nov 2023 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700833815; x=1701438615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6I7CJB0Cp8tuYLriqcIjeTAsEGcMeXyDXVh80cPjfPM=;
        b=GpGQcg9bodbd+Wnp/O+gz37+ltHLLWa+Lh72rJFdbNBbJlns6yigoGp6xlKxFbn3gh
         psZM//O5IELvcUr6tLWXyzEK+LrrPYKIspSUDmgSjk3rV6f3ozoI4DE0f835S4UmpryR
         CQBzjBeqy4R+nz1/Nz5RcstYrwf+dRMG2BJf/w3pwUL88v0PkAaqaWZh2j/CWjS8PepN
         MY9VFxim1jfYSfAJNwNwpJXajoig3mMRIfqByT4+Fl1+55olU7dunJZ4nNhevtHBiCo/
         25XJzq0I6ir2hT9ZbWIJmkTjoNGWkZnALGO9Oemx5zHYyJVHuzXMeXMXkIg3rBHbfCLs
         fsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700833815; x=1701438615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6I7CJB0Cp8tuYLriqcIjeTAsEGcMeXyDXVh80cPjfPM=;
        b=Mvrrnqin1fJfGuw6kaf8Do9XyQg4L3RFwW+dQ/lr7dEbYKLD2sQWBNluz6lZOTu9Ew
         VVoSqtdtSgBDPRVVFIvOd/xWQ1f/hUw7HDKfe1bQAtKbp2XoDA107K0Mq1jGLB63T9cO
         8qyZ9bEGzbrQshPnHja0sGrfTPGlAf6QFKyUybw/5IZKtoA/D5k6x2jA24M0SXkNbwfu
         JUJm7rDS93Pv/vzkBkLkv1wntyOObIOl3OWzsIFKwfOikUGntYxZGLa/HJ0Ff6AP+ioc
         g/QL4efl0CBx/Vkk4ZvO5zZ/j+k1z8sJ1TOGJQCfnanVjUzlTZz/TTJxG7FoFtr5/Qrl
         xOJQ==
X-Gm-Message-State: AOJu0YwUoeiDij9aiSnI1N022lLaqdArExaAESin90nIy7dHOY8dsBOu
        wm/x8NQ4QjorMDcwdw2iuVURciJDaVZaxdmsy7c=
X-Google-Smtp-Source: AGHT+IHKzjuBMbN9TdS5p/8W++p2f2puyviMZRwWreH/6vgLDyaY425mPqrCC61xMREv+5rRtr2OlQ5myV2gS9mjevI=
X-Received: by 2002:a9d:6a59:0:b0:6d7:ea8a:f0c1 with SMTP id
 h25-20020a9d6a59000000b006d7ea8af0c1mr3497137otn.3.1700833815295; Fri, 24 Nov
 2023 05:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20231124070005.GA10393@libra05>
In-Reply-To: <20231124070005.GA10393@libra05>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Fri, 24 Nov 2023 14:50:04 +0100
Message-ID: <CAJ8uoz1s_TqemsQSsu4=pH147d9M1y-cy5G1VCLkM9g3pFj93w@mail.gmail.com>
Subject: Re: xdp/xsk.c: missing read memory barrier in xsk_poll()
To:     Yewon Choi <woni9911@gmail.com>
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
        linux-kernel@vger.kernel.org, threeearcat@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 at 08:00, Yewon Choi <woni9911@gmail.com> wrote:
>
> Hello,
>
> We found some possibility of missing read memory barrier in xsk_poll(),
> so we would like to ask to check it.
>
> commit e6762c8b adds two smp_rmb() in xsk_mmap(), which are paired with
> smp_wmb() in XDP_UMEM_REG and xsk_init_queue each. The later one is
> added in order to prevent reordering between reading of q and reading
> of q->ring.
> One example in simplied code is:
>
> xsk_mmap():
>         if (offset == XDP_PGOFF_RX_RING) {
>                 q = READ_ONCE(xs->rx);
>         }
>         ...
>         if (!q)
>                 return -EINVAL;
>
>         /* Matches the smp_wmb() in xsk_init_queue */
>         smp_rmb();
>         ...
>         return remap_vmalloc_range(vma, q->ring, 0);
>
> Also, the similar logic exists in xsk_poll() without smp_rmb().
>
> xsk_poll():
>         ...
>         if (xs->rx && !xskq_prod_is_empty(xs->rx))
>                 mask |= EPOLLIN | EPOLLRDNORM;
>         if (xs->tx && xsk_tx_writeable(xs))
>                 mask |= EPOLLOUT | EPOLLWRNORM;
>
> xskq_prod_is_empty():
>         return READ_ONCE(q->ring->consumer) && ...
>
> To be consistent, I think that smp_rmb() is needed between
> xs->rx and !xsq_prod_is_empty() and the same applies for xs->tx.
>
> Could you check this please?
> If a patch is needed, we will send them.

Yes, you are correct that the current code would need an smp_rmb().
However, an unbound socket should never be allowed to enter the
xsk_poll() code in the first place since it is pointless to poll a
socket that has not been bound. This error was introduced in the
commit below:

commit 1596dae2f17ec5c6e8c8f0e3fec78c5ae55c1e0b
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date:   Wed Feb 15 15:33:09 2023 +0100

    xsk: check IFF_UP earlier in Tx path

When an AF_XDP socket has been bound, it is guaranteed to have been
set up in the correct way and a memory barrier has already been
executed in the xsk_bind call. It would be great if you could submit a
patch, but I suggest that you do something like this instead of
introducing an smp_rmb():

    if (xsk_check_common(xs))
        goto out;
    :
    :

    if (xs->rx && !xskq_prod_is_empty(xs->rx))
        mask |= EPOLLIN | EPOLLRDNORM;
    if (xs->tx && xsk_tx_writeable(xs))
        mask |= EPOLLOUT | EPOLLWRNORM;

out:
    rcu_read_unlock();
    return mask;

Thank you for spotting this!

/Magnus

>
> Best Regards,
> Yewon Choi
>
