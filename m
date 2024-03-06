Return-Path: <linux-kernel+bounces-94588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC758741CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E4E1F22226
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70C41CFA0;
	Wed,  6 Mar 2024 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmNYEnFR"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC52A1A29A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759725; cv=none; b=CKZcNjEL6b1vS/ejybJWCnJG8tomuDOYRLawtvYubQb/+6GJPpsC8gzfGWCzhhr0XnOcjGP6VH1eAEvmn6mBLTnn8YKhO8YpjGsXt0RvmlWMkne1iuBHb+PL5HQbkNQy3ih8o3ht/o2TkBYketBlmme+ZyV6c3ntyh93/+ke+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759725; c=relaxed/simple;
	bh=0LPXXDWE9tnVN6mntx034WP764BhOavDDL3fT4m1stU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXU3q2W7ai2wOR+N5YPMcjfl2qlV+T4wq8VVDuSNlRS4DPxp7VigR/KCkSDa186l0CXa6SSK8fbXo4tuCk67ADbMb81Pp1+lOrMRI4crYPiRyxsOG+qlDJLwFUqJ11aoscwTHjX4XC+J4R5LhlGwSa2z5UQD+NNiBqCIY7Mjmug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KmNYEnFR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a293f2280c7so35776666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 13:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709759722; x=1710364522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbfXV/MznD/jj/w7+vcMrhRHgrFHJBSBE2I9brDPuZQ=;
        b=KmNYEnFRtpadVNNaei6XT9B9FWEONaxsORw/oyI7VoseIbMHJnKwChVPo094CvTlEn
         06Sb7k5MVaUMlkIQirgHtgrrGg0Nex9Zn0tdLMtZWVX1HiPfKY0oj0wxeEI2nLCvmmfr
         aTkUd3wWtH2knJh+CvydyfFtktJnjQY10hLINnZrxqkf6LGr77NnAcBsziVRLl0BQkpZ
         AgZ6XVLygWIirTe0I2XFkuc7pecjlrON7+S6xWeN+9o8tZRZoN5hzN6ir76MODTLNUAn
         jBKG0kLmIguZGgUiKkiTh/n2pwsErqmYsgtTxK939m+vGgeCV6EOLtIvjJvXC7z3gMlv
         poLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709759722; x=1710364522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbfXV/MznD/jj/w7+vcMrhRHgrFHJBSBE2I9brDPuZQ=;
        b=bC6egxQ3kL+4moMLCcKSZ9hHLpfzdOT3Fucvdce8kJgGm8l/bfNJ486UVqHeyHSznr
         NGQ2LXZ/J+/2IXOMqfG+rQrnDGQOFcAsHHSaaGHLdfSVd/F/I4G6AG/CtfePyiRyZDSs
         8oowzQjee0ZFJZW56pnUbtNLibfD0pz2mDzNgoeCZv1nScjSHM0KKrojm4QVVfE7e9+R
         juNHwj4Mpa9Wu9BHFrsRPOx/tQYNsZmZ/ubeoItLLwfEsP+1GjMUguGD1f2+qPUXorEN
         7XMD0fopsz0VJJqFkNeKL6+/PB3Ap4u2dvRja8NN8IHdTQogHxySuL/GoUfcrjANYThW
         hmHg==
X-Forwarded-Encrypted: i=1; AJvYcCUixEwz1DCxn2cIs7VnT8w4Xz2c/BqVJrt2bXIQBmt3bY5GHxOY0o8ZBUUMg7Sd1qK8ytENhEmJqHiJUhunHGLDO/rz6SuCLt8cU8Mp
X-Gm-Message-State: AOJu0YzBL2zClKPQ9uwbkAy1MdPnDdF7+uJuw4Zo2RMRJDH/PmfRzZIa
	m7nylQf49lX8dHUEVOoA7LCgHtAtttgbldS0wAJOEK7C749Uon4H0TMJWGQNmh8qNYwKkHNnGNR
	pexMcMcJjdYqblAieokQbatiVXq96JwC8u3Hb
X-Google-Smtp-Source: AGHT+IFZ8miPr7XDHGveLj2M8bruiGjRMKk1+//1krKEu/hfIKbB8Owyx3D7cbLquRoe4ZHSTcJSoQpxL1bldVfuTiQ=
X-Received: by 2002:a17:906:19cf:b0:a43:f588:de2a with SMTP id
 h15-20020a17090619cf00b00a43f588de2amr11783752ejd.66.1709759721884; Wed, 06
 Mar 2024 13:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306190822.390086-1-dtatulea@nvidia.com>
In-Reply-To: <20240306190822.390086-1-dtatulea@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 6 Mar 2024 13:15:07 -0800
Message-ID: <CAHS8izPinALpWgq_3m7C_VCTHwOMiAVgUXkAY=WK4ZO2DCtXKg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] net: esp: fix bad handling of pages from page_pool
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	leonro@nvidia.com, gal@nvidia.com, 
	"Anatoli N . Chechelnickiy" <Anatoli.Chechelnickiy@m.interpipe.biz>, Ian Kumlien <ian.kumlien@gmail.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 11:08=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> When the skb is reorganized during esp_output (!esp->inline), the pages
> coming from the original skb fragments are supposed to be released back
> to the system through put_page. But if the skb fragment pages are
> originating from a page_pool, calling put_page on them will trigger a
> page_pool leak which will eventually result in a crash.
>
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
> The suggested fix is to use a new wrapper that covers page refcounting
> for page_pool pages as well.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reported-by: Anatoli N.Chechelnickiy <Anatoli.Chechelnickiy@m.interpipe.b=
iz>
> Reported-by: Ian Kumlien <ian.kumlien@gmail.com>

Maybe you want to Cc: stable on this & add fixes tag? Or maybe you
skipped that because it's still an RFC patch.

I think it maybe also needs to be  [PATCH net] or [RFC PATCH net]
subject to designate to net and not net-next.

Looks good to me with very minor comment so, FWIW,

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>
> Changes in v2:
> - Added napi_page_unref api based on discussion in v1 [0].
>
> [0]https://lore.kernel.org/netdev/CAHS8izOoO-EovwMwAm9tLYetwikNPxC0FKyVGu=
1TPJWSz4bGoA@mail.gmail.com/T/#t
>
> ---
>  include/linux/skbuff.h | 10 +++++++---
>  net/ipv4/esp4.c        | 16 ++++++++++------
>  net/ipv6/esp6.c        | 16 ++++++++++------
>  3 files changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 696e7680656f..009603db2a43 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3453,10 +3453,8 @@ int skb_cow_data_for_xdp(struct page_pool *pool, s=
truct sk_buff **pskb,
>  bool napi_pp_put_page(struct page *page, bool napi_safe);
>
>  static inline void
> -napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
> +napi_page_unref(struct page *page, bool recycle, bool napi_safe)
>  {
> -       struct page *page =3D skb_frag_page(frag);
> -
>  #ifdef CONFIG_PAGE_POOL
>         if (recycle && napi_pp_put_page(page, napi_safe))

Ah, it looks like we don't need is_pp_page() after all because
napi_pp_put_page() already checks for that internally. Good find, much
better than what I suggested.

>                 return;
> @@ -3464,6 +3462,12 @@ napi_frag_unref(skb_frag_t *frag, bool recycle, bo=
ol napi_safe)
>         put_page(page);
>  }
>
> +static inline void
> +napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
> +{
> +       napi_page_unref(skb_frag_page(frag), recycle, napi_safe);
> +}
> +
>  /**
>   * __skb_frag_unref - release a reference on a paged fragment.
>   * @frag: the paged fragment
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index 4dd9e5040672..3126aeb0588d 100644
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
> @@ -112,9 +112,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void=
 *tmp)
>         /* Unref skb_frag_pages in the src scatterlist if necessary.
>          * Skip the first sg which comes from skb->data.
>          */
> -       if (req->src !=3D req->dst)
> -               for (sg =3D sg_next(req->src); sg; sg =3D sg_next(sg))
> -                       put_page(sg_page(sg));
> +       if (req->src !=3D req->dst) {
> +               for (sg =3D sg_next(req->src); sg; sg =3D sg_next(sg)) {
> +                       struct page *page =3D sg_page(sg);
> +
> +                       napi_page_unref(page, skb->pp_recycle, false);

[minor annoying nit, feel free to ignore]: I would use sg_page(sg)
inline here and below, since page is not reused elsewhere. But I'm
fine either way.

> +               }
> +       }
>  }
>
>  #ifdef CONFIG_INET_ESPINTCP
> @@ -260,7 +264,7 @@ static void esp_output_done(void *data, int err)
>         }
>
>         tmp =3D ESP_SKB_CB(skb)->tmp;
> -       esp_ssg_unref(x, tmp);
> +       esp_ssg_unref(x, tmp, skb);
>         kfree(tmp);
>
>         if (xo && (xo->flags & XFRM_DEV_RESUME)) {
> @@ -639,7 +643,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_b=
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
> index 6e6efe026cdc..7bbe19e74cf0 100644
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
> @@ -129,9 +129,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void=
 *tmp)
>         /* Unref skb_frag_pages in the src scatterlist if necessary.
>          * Skip the first sg which comes from skb->data.
>          */
> -       if (req->src !=3D req->dst)
> -               for (sg =3D sg_next(req->src); sg; sg =3D sg_next(sg))
> -                       put_page(sg_page(sg));
> +       if (req->src !=3D req->dst) {
> +               for (sg =3D sg_next(req->src); sg; sg =3D sg_next(sg)) {
> +                       struct page *page =3D sg_page(sg);
> +
> +                       napi_page_unref(page, skb->pp_recycle, false);
> +               }
> +       }
>  }
>
>  #ifdef CONFIG_INET6_ESPINTCP
> @@ -294,7 +298,7 @@ static void esp_output_done(void *data, int err)
>         }
>
>         tmp =3D ESP_SKB_CB(skb)->tmp;
> -       esp_ssg_unref(x, tmp);
> +       esp_ssg_unref(x, tmp, skb);
>         kfree(tmp);
>
>         esp_output_encap_csum(skb);
> @@ -677,7 +681,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_=
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


--=20
Thanks,
Mina

