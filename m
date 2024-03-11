Return-Path: <linux-kernel+bounces-98549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD53877BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F28281532
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A492F125CE;
	Mon, 11 Mar 2024 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGy0NHHU"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C6134C9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146646; cv=none; b=T9cMXMVxtXDGm5ppploEizLrS0FHleARGRFIPa0Pdw0LZVS5BmJ2YeVBwuEWQeSZr0FYx+yT+0b/DBQ6Lp9ik2gJpygg0tOBw3E0Ya98FBdOfR5u16Khp02t2ud/2MrXcDoQ/Pz/yHMZ+wizqDwtnPi5ssSlsSaYDLlJgF22IzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146646; c=relaxed/simple;
	bh=4yAabAOW5y86cLzd/eEKqcAB/jCkZr6aV2T8AY250g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRgW/gf7Q/wsDo8KIJfyA8SAHFCg9k/CEsT3riNCuIhmM2DcY2qM+tHjD8x3MFZCwmIPCKslFSOq1ihkBOKVLMOquDiO6TccKvykTxoBLsn8x0g3AqDoyNNvr8s0ABf/khU7Adyx3tqchXfUEXhROmtTabqCrO8nmTQtwwwfNTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pGy0NHHU; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d4141c4438so61599581fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 01:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710146643; x=1710751443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eBCaB1KJSJv4nuU5XUfD5CciJ2EmxrAEpbHEbAM5m0=;
        b=pGy0NHHUVeP57AriTAZK9diNpUQ/NMyuwd6NA72PeAES3sKCHUakG4pmuCor+YIAiZ
         meEs827GLxvF2dHSFPven9FDjYykUiakFDAGbriOt4G5xMIIMghUEAKCCrPeJJZH4jiN
         ciN6IOBaeULL3NwohL0z8LE9mHpOmyr9gJ8rICFJGshu+BkJU++FTZANxcXUI4EDvVhB
         cdLcKizvC0PijBrYiPHSOh0QYIvmZM3bYwNWgRVvLU1HYoUZRqzCTTrm+FD3P1cG5Mjx
         3hijAaX3Fb454lU749+4PSp7HmbwLZHpG12pn+CRB3VPJ6l6xK+raMz2V53BKPEBDxi5
         kYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710146643; x=1710751443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eBCaB1KJSJv4nuU5XUfD5CciJ2EmxrAEpbHEbAM5m0=;
        b=SFJ/zhnJSxIcxxvSHHzzE0Eoro+eXS6weh32pXUwB22RE2mqWI255SIPDqxlhjTBQy
         lm1HUxOH6pXhZczvbt7tWmhe/2cbwv1dlVzn5HbsvdGeXwmpj31dEiHYU6mvA/qrAx0Y
         kHBMAv0QB32Dl0ZdjiOlyLtlyqw4U2h2SJdGvXlMbqIMYw8syM5TSN7embmN0r3qVkVL
         hRv6ZVZt/P6givLVcBgEE44g5VcRH1CXfI8tL/J3WRlndkWw063G787qTQTsk2gzIfIc
         WIZ70mJwUkW1FB5IexPtvcjDc6hV8aY1uqBUXcEL4oqCbvucvip3iSmqoHDplXzQrOy9
         WHhw==
X-Forwarded-Encrypted: i=1; AJvYcCX0rsl9b6mAjiXjmcq6l/WUKgywvbyLsZguGz/7/Mh9N/3ilb4gpIQ/R+2LU8N1Z6LWjlw9/6IbryHj0dAb3HSiqgaRJM4H7em5aDRw
X-Gm-Message-State: AOJu0YzYhDVxsHwIzDTwH4WaXkMK1nu/IqZFgqlwnmoGhcTlAqH47oqY
	C/oFLSU0wZuarp/md/aaaCM+lSY8HdXPvFlawH/om2bXcYae1v8ga4Z+rR0Lh3NwLgcRCRfiJLC
	wkR5DnmnWoK3T5FtQazk8HzgAsQrnaUWItyMH1Q==
X-Google-Smtp-Source: AGHT+IGd74H0Tb8RkEUhAjuh5XS90k+4Px0sLtRsOQcICeykxEYg8zLOFufJFbWW7qQkb5jU/EmxBljEWy75QB9CPN4=
X-Received: by 2002:a2e:850e:0:b0:2d3:982d:aaee with SMTP id
 j14-20020a2e850e000000b002d3982daaeemr3258850lji.16.1710146642679; Mon, 11
 Mar 2024 01:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308152723.831620-1-dtatulea@nvidia.com>
In-Reply-To: <20240308152723.831620-1-dtatulea@nvidia.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Mar 2024 10:43:26 +0200
Message-ID: <CAC_iWjJyDUbK+2+u=Uqeo7r7-Hy5aZQ=12eTEKaBnm8qYnR_8Q@mail.gmail.com>
Subject: Re: [PATCH net v3] net: esp: fix bad handling of pages from page_pool
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: almasrymina@google.com, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <brouer@redhat.com>, Matteo Croce <mcroce@microsoft.com>, leonro@nvidia.com, 
	gal@nvidia.com, stable@vger.kernel.org, 
	"Anatoli N . Chechelnickiy" <Anatoli.Chechelnickiy@m.interpipe.biz>, Ian Kumlien <ian.kumlien@gmail.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On Fri, 8 Mar 2024 at 17:27, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>
> When the skb is reorganized during esp_output (!esp->inline), the pages
> coming from the original skb fragments are supposed to be released back
> to the system through put_page.
>  But if the skb fragment pages are
> originating from a page_pool, calling put_page on them will trigger a
> page_pool leak which will eventually result in a crash.
>

Indeed if you call put_page, you will leak a page. But won't that skb
eventually be freed by skb_free_head()?

Thanks
/Ilias

> This leak can be easily observed when using CONFIG_DEBUG_VM and doing
> ipsec + gre (non offloaded) forwarding:
>
>   BUG: Bad page state in process ksoftirqd/16  pfn:1451b6
>   page:00000000de2b8d32 refcount:0 mapcount:0 mapping:0000000000000000 in=
dex:0x1451b6000 pfn:0x1451b6
>   flags: 0x200000000000000(node=3D0|zone=3D2)
>   page_type: 0xffffffff()
>   raw: 0200000000000000 dead000000000040 ffff88810d23c000 000000000000000=
0
>   raw: 00000001451b6000 0000000000000001 00000000ffffffff 000000000000000=
0
>   page dumped because: page_pool leak
>   Modules linked in: ip_gre gre mlx5_ib mlx5_core xt_conntrack xt_MASQUER=
ADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat xt_addrtype br_netfil=
ter rpcrdma rdma_ucm ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm =
ib_ipoib iw_cm ib_cm ib_uverbs ib_core overlay zram zsmalloc fuse [last unl=
oaded: mlx5_core]
>   CPU: 16 PID: 96 Comm: ksoftirqd/16 Not tainted 6.8.0-rc4+ #22
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-g=
f21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x36/0x50
>    bad_page+0x70/0xf0
>    free_unref_page_prepare+0x27a/0x460
>    free_unref_page+0x38/0x120
>    esp_ssg_unref.isra.0+0x15f/0x200
>    esp_output_tail+0x66d/0x780
>    esp_xmit+0x2c5/0x360
>    validate_xmit_xfrm+0x313/0x370
>    ? validate_xmit_skb+0x1d/0x330
>    validate_xmit_skb_list+0x4c/0x70
>    sch_direct_xmit+0x23e/0x350
>    __dev_queue_xmit+0x337/0xba0
>    ? nf_hook_slow+0x3f/0xd0
>    ip_finish_output2+0x25e/0x580
>    iptunnel_xmit+0x19b/0x240
>    ip_tunnel_xmit+0x5fb/0xb60
>    ipgre_xmit+0x14d/0x280 [ip_gre]
>    dev_hard_start_xmit+0xc3/0x1c0
>    __dev_queue_xmit+0x208/0xba0
>    ? nf_hook_slow+0x3f/0xd0
>    ip_finish_output2+0x1ca/0x580
>    ip_sublist_rcv_finish+0x32/0x40
>    ip_sublist_rcv+0x1b2/0x1f0
>    ? ip_rcv_finish_core.constprop.0+0x460/0x460
>    ip_list_rcv+0x103/0x130
>    __netif_receive_skb_list_core+0x181/0x1e0
>    netif_receive_skb_list_internal+0x1b3/0x2c0
>    napi_gro_receive+0xc8/0x200
>    gro_cell_poll+0x52/0x90
>    __napi_poll+0x25/0x1a0
>    net_rx_action+0x28e/0x300
>    __do_softirq+0xc3/0x276
>    ? sort_range+0x20/0x20
>    run_ksoftirqd+0x1e/0x30
>    smpboot_thread_fn+0xa6/0x130
>    kthread+0xcd/0x100
>    ? kthread_complete_and_exit+0x20/0x20
>    ret_from_fork+0x31/0x50
>    ? kthread_complete_and_exit+0x20/0x20
>    ret_from_fork_asm+0x11/0x20
>    </TASK>
>
> The suggested fix is to introduce a new wrapper (skb_page_unref) that
> covers page refcounting for page_pool pages as well.
>
> Cc: stable@vger.kernel.org
> Fixes: 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling")
> Reported-and-tested-by: Anatoli N.Chechelnickiy <Anatoli.Chechelnickiy@m.=
interpipe.biz>
> Reported-by: Ian Kumlien <ian.kumlien@gmail.com>
> Link: https://lore.kernel.org/netdev/CAA85sZvvHtrpTQRqdaOx6gd55zPAVsqMYk_=
Lwh4Md5knTq7AyA@mail.gmail.com
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Changes in v2:
> - Fixes in tags.
>
> Changes in v3:
> - Rebased to ipsec tree.
> ---
>  include/linux/skbuff.h | 10 ++++++++++
>  net/ipv4/esp4.c        |  8 ++++----
>  net/ipv6/esp6.c        |  8 ++++----
>  3 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 2dde34c29203..d9a1ccfb5708 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3448,6 +3448,16 @@ static inline void skb_frag_ref(struct sk_buff *sk=
b, int f)
>
>  bool napi_pp_put_page(struct page *page, bool napi_safe);
>
> +static inline void
> +skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_s=
afe)
> +{
> +#ifdef CONFIG_PAGE_POOL
> +       if (skb->pp_recycle && napi_pp_put_page(page, napi_safe))
> +               return;
> +#endif
> +       put_page(page);
> +}
> +
>  static inline void
>  napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
>  {
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index 4dd9e5040672..d33d12421814 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -95,7 +95,7 @@ static inline struct scatterlist *esp_req_sg(struct cry=
pto_aead *aead,
>                              __alignof__(struct scatterlist));
>  }
>
> -static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
> +static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buf=
f *skb)
>  {
>         struct crypto_aead *aead =3D x->data;
>         int extralen =3D 0;
> @@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void =
*tmp)
>          */
>         if (req->src !=3D req->dst)
>                 for (sg =3D sg_next(req->src); sg; sg =3D sg_next(sg))
> -                       put_page(sg_page(sg));
> +                       skb_page_unref(skb, sg_page(sg), false);
>  }
>
>  #ifdef CONFIG_INET_ESPINTCP
> @@ -260,7 +260,7 @@ static void esp_output_done(void *data, int err)
>         }
>
>         tmp =3D ESP_SKB_CB(skb)->tmp;
> -       esp_ssg_unref(x, tmp);
> +       esp_ssg_unref(x, tmp, skb);
>         kfree(tmp);
>
>         if (xo && (xo->flags & XFRM_DEV_RESUME)) {
> @@ -639,7 +639,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_b=
uff *skb, struct esp_info *
>         }
>
>         if (sg !=3D dsg)
> -               esp_ssg_unref(x, tmp);
> +               esp_ssg_unref(x, tmp, skb);
>
>         if (!err && x->encap && x->encap->encap_type =3D=3D TCP_ENCAP_ESP=
INTCP)
>                 err =3D esp_output_tail_tcp(x, skb);
> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> index 6e6efe026cdc..7371886d4f9f 100644
> --- a/net/ipv6/esp6.c
> +++ b/net/ipv6/esp6.c
> @@ -112,7 +112,7 @@ static inline struct scatterlist *esp_req_sg(struct c=
rypto_aead *aead,
>                              __alignof__(struct scatterlist));
>  }
>
> -static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
> +static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buf=
f *skb)
>  {
>         struct crypto_aead *aead =3D x->data;
>         int extralen =3D 0;
> @@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void =
*tmp)
>          */
>         if (req->src !=3D req->dst)
>                 for (sg =3D sg_next(req->src); sg; sg =3D sg_next(sg))
> -                       put_page(sg_page(sg));
> +                       skb_page_unref(skb, sg_page(sg), false);
>  }
>
>  #ifdef CONFIG_INET6_ESPINTCP
> @@ -294,7 +294,7 @@ static void esp_output_done(void *data, int err)
>         }
>
>         tmp =3D ESP_SKB_CB(skb)->tmp;
> -       esp_ssg_unref(x, tmp);
> +       esp_ssg_unref(x, tmp, skb);
>         kfree(tmp);
>
>         esp_output_encap_csum(skb);
> @@ -677,7 +677,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_=
buff *skb, struct esp_info
>         }
>
>         if (sg !=3D dsg)
> -               esp_ssg_unref(x, tmp);
> +               esp_ssg_unref(x, tmp, skb);
>
>         if (!err && x->encap && x->encap->encap_type =3D=3D TCP_ENCAP_ESP=
INTCP)
>                 err =3D esp_output_tail_tcp(x, skb);
> --
> 2.42.0
>

