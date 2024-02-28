Return-Path: <linux-kernel+bounces-84781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AD386AB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F62284764
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E123E36123;
	Wed, 28 Feb 2024 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IbDqWDl+"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AB364C0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113133; cv=none; b=R0TfwbzGpr8PQSHUOE55b7y67juMF9ZsYF3ze2SdrQuqymluAaPBQZ4Bxh+T4CqBaMlEqpM/49utFF9SNdI7ljDkxXZltyrUzLwhaBXZ7dGHkmT8s5+4vmiAgjl/XPGaiHIo9zethre7OYb4Vzg0Qq8D93VHqaaiHc7sYw1uu34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113133; c=relaxed/simple;
	bh=aqcJTIVaVFp21PkbL9YzRb4iz4RtSFDWr/4GBKggYtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXK248/SzTPwmeVKcPVHzV23dEzWTA/ENfx7Z/mgw1p6IPxyTqSP4NiIqXZklil8HF3OmLYPy6Yd+JXZ1LHkTLwMJtWREKTraOdB3jdQqiAk6cRxKuww+9wbYiu9f5W/CtSS9sdg/EeVgQjG9Lp9TdfFz5JuyH5FCO05PjK3w3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IbDqWDl+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4129a5f7b54so35055e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709113129; x=1709717929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tq28pWGVy84XWsb1p63TwCaRaQ81JuSb2XPKE4tmWPY=;
        b=IbDqWDl+MF1zmRIUtH5c1x53yHc+6fC9i8SP27oaSA17woIPwQcd9iLGLsZBut91RA
         ySGUfDeTDyj7Pt5Txx7752gExRKeFO4Z2+BENB2FEBi/z0Xrrp+3dDtpWLECH6VaqReJ
         jhfL4QOrHvyXpxbH3aSYZN09/jyXnBYKr+v92ZVTbRQPH3EM5s6WYXMCsuPbVprywkYW
         i/eHZ3GJFwlr0+KvsZ1X9nRa96aNz2ns/1MEtdbum5mjivHLUzGxbIkhXv1niXGFR7VJ
         YnQcO+/qtkB7BCQBrCacJHdMKGtUH2qkeWf/54X4r3+a5CJuNDIkvkJzcKthsbXuRQli
         j5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113129; x=1709717929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tq28pWGVy84XWsb1p63TwCaRaQ81JuSb2XPKE4tmWPY=;
        b=FCamgGibJ/qBvUoSme7V+iqfBzsmQticrAOYS30SYlM2HUUEBkgLvWz1BIlYtU+cxU
         iGTrysc3darAVxHEAyRxDCEegymAZZyFb7SIghKwRL1DmMv4RywNjr1O/KedqJ/kzPgU
         X6ABGeQzpUa5grYxqXikgMhccAuG6DCoHRSe4lVagC1W4jb0Cf9cgUAXUILOBVrZscnc
         WOD1zZ9O9JiLaZUiUC84/pZaUzLuUnlGAK35434hrMxvPxUUetPfm4juVDWpWSxZzcP1
         sG5+QVcA+Fn+I8RccFnM0EjyBOxFjKRT7P+6nUAOZpPxnH9tvGgBbD57xcaTAQrGYyoj
         jOgg==
X-Forwarded-Encrypted: i=1; AJvYcCUIsHpKzSzDnri+17Uzwq5zxscRxOxnHf8YPSrlpN49HoWNhvQai6ddhI+EBoHw9NUWxr5IzvU4gzLqURZzsc/6z2Q5r6tasJ/dcx44
X-Gm-Message-State: AOJu0Yxv62OHdxWTO3531h6VCJh7yfdJGCW1PdYp2kAp9I4zw90cFTnO
	8HAKBfw08GIuzpS7W6FF8026W6wUWWw+bs90rQnYC9QlAFGyooHr+aFlNh0VuO+PgrJXWAoioye
	Lt6g/NrinUrGeVKx5RD4ovPfmKsKPUROQklqe
X-Google-Smtp-Source: AGHT+IEPTOcdwuk9+XFKyavoHLMSmESCQzslFD+zeAM0Yj55ZedW9Tysi8LWYspqOCidhExFA7MbNkEpyLCISXDWoqw=
X-Received: by 2002:a05:600c:1f14:b0:412:b66f:3d0a with SMTP id
 bd20-20020a05600c1f1400b00412b66f3d0amr23933wmb.6.1709113129295; Wed, 28 Feb
 2024 01:38:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
 <20240227062833.7404-1-shijie@os.amperecomputing.com> <CANn89iL2a2534d8QU9Xt6Gjm8M1+wWH03+YPdjSPQCq_Q4ZGxw@mail.gmail.com>
 <018b5652-8006-471d-94d0-d230e4aeef6d@amperemail.onmicrosoft.com>
In-Reply-To: <018b5652-8006-471d-94d0-d230e4aeef6d@amperemail.onmicrosoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 Feb 2024 10:38:37 +0100
Message-ID: <CANn89i+NudPMsKDswRfx3R=opyAKBTw+nxrpkMZTQsgnOGJ_DA@mail.gmail.com>
Subject: Re: [PATCH v2] net: skbuff: set FLAG_SKB_NO_MERGE for skbuff_fclone_cache
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, kuba@kernel.org, 
	patches@amperecomputing.com, davem@davemloft.net, horms@kernel.org, 
	ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, cl@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 8:06=E2=80=AFAM Shijie Huang
<shijie@amperemail.onmicrosoft.com> wrote:
>
>
> =E5=9C=A8 2024/2/27 20:55, Eric Dumazet =E5=86=99=E9=81=93:
> > On Tue, Feb 27, 2024 at 7:29=E2=80=AFAM Huang Shijie
> > <shijie@os.amperecomputing.com> wrote:
> >> Since we do not set FLAG_SKB_NO_MERGE for skbuff_fclone_cache,
> >> the current skbuff_fclone_cache maybe not really allocated, it maybe
> >> used an exist old kmem_cache. In NUMA, the fclone allocated by
> >> alloc_skb_fclone() maybe in remote node.
> > Why is this happening in the first place ? Whab about skb->head ?
>
> I tested the fclone firstly. I did not test others yet.
>
> I did not check the skb->head yet.
>
> But I ever checked the pfrag's page, it is okay.
>
>
> >
> > Jesper patch [1] motivation was not about NUMA., but about
> > fragmentation and bulk allocations/freeing.
> >
> > TCP fclones are not bulk allocated/freed, so I do not understand what
> > your patch is doing.
> > You need to give more details, and experimental results.
>
> 1.) My NUMA machine:
>
>        node 0 (CPU 0 ~ CPU79):
>
>                       CPU 0 ~  CPU 39 are used as memcached's server
>
>                      CPU 40 ~  CPU 79 are used as memcached's client
>
>        node 1 (CPU 80 ~ CPU160):
>
>                       CPU 80 ~  CPU 119 are used as memcached's server
>
>                      CPU 120 ~  CPU 179 are used as memcached's client
>
>     the kernel is linux-next 20240227
>
>
>   2.) My private patches:
>
>        patch 1 is for slub:
>
>        ---
>   mm/slub.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 5d838ebfa35e..d2ab1e36fd6b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5691,6 +5691,7 @@ __kmem_cache_alias(const char *name, unsigned int
> size, unsigned int align,
>
>          s =3D find_mergeable(size, align, flags, name, ctor);
>          if (s) {
> +               printk("[%s] origin:%s, shared :%s\n", __func__, name,
> s->name);
>                  if (sysfs_slab_alias(s, name))
>                          return NULL;
>
> ---------
>
>    This patch is used the check which is the sharing kmem_cache for
> "skbuff_fclone_cache".
>
>    I cannot find the "skbuff_fclone_cache" in /proc/slabinfo.
>
>    From my test, the "pool_workqueue" is the real working kmem_cache.
>
>    The "skbuff_fclone_cache" is just a pointer to "pool_workqueue"
> (pwq_cache).
>
>
>    The following private patch is used to record the fclone allocation:
>
>   ---
>   net/ipv4/tcp.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index c82dc42f57c6..6f31ddcfc017 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -864,6 +864,24 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t
> *ppos,
>   }
>   EXPORT_SYMBOL(tcp_splice_read);
>
> +unsigned long right_num, wrong_num;
> +static void check_fclone(struct sk_buff *skb)
> +{
> +       int n =3D numa_mem_id(); /* current node */
> +       int node2 =3D page_to_nid(virt_to_page((unsigned long) skb));
> +
> +       if (n !=3D node2) {
> +               wrong_num++;
> +               if ((wrong_num % 1000) =3D=3D 999)
> +                       printk(KERN_DEBUG "[%s] current:%d, get from
> :%d, (%ld, %ld, %ld)\n",
> +                               __func__, n, node2, wrong_num,
> right_num, wrong_num * 100 / (wrong_num + right_num));
> +       } else {
> +               right_num++;
> +               if ((right_num % 1000000) =3D=3D 9999)
> +                       printk("[%s] we received :%ld, %ld\n", __func__,
> right_num, wrong_num);
> +       }
> +}
> +
>   struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
>                                       bool force_schedule)
>   {
> @@ -884,6 +902,7 @@ struct sk_buff *tcp_stream_alloc_skb(struct sock
> *sk, gfp_t gfp,
>                          skb_reserve(skb, MAX_TCP_HEADER);
>                          skb->ip_summed =3D CHECKSUM_PARTIAL;
> INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);
> +                       check_fclone(skb);
>                          return skb;
>                  }
>                  __kfree_skb(skb);
> --
>
>    Without this v2 patch, I can get the result after the memcached test:
>
> [ 1027.317645] [check_fclone] current:0, get from :1, (7112999, 9076711, =
43)
> [ 1027.317653] [check_fclone] current:0, get from :1, (7112999, 9076707, =
43)
> [ 1027.804110] [check_fclone] we received :10009999, 7113326
>
> It means nearly 43% fclone is allocated in the remote node.
>
>
>   With this v2 patch,  I can find the "skbuff_fclone_cache" in
> /proc/slabinfo.
>
> The test result shows below:
>
> [  503.357293] [check_fclone] we received :8009999, 0
> [  503.357293] [check_fclone] we received :8009999, 0
> [  503.357305] [check_fclone] we received :8009999, 0
>
> After v2 patch, I cannot see the wrong fclone in remote node.
>
>
> >
> > Using SLAB_NO_MERGE does not help, I am still seeing wrong allocations
> > on a dual socket
> > host with plenty of available memory.
> > (either sk_buff or skb->head being allocated on the other node).
>
> Do you mean you still can see the wrong fclone after using SLAB_NO_MERGE?
>
> If so, I guess there is bug in the slub.
>
>
> > fclones might be allocated from a cpu running on node A, and freed
> > from a cpu running on node B.
> > Maybe SLUB is not properly handling this case ?
>
> Maybe.
>
>
>
> > SLAB_NO_MERGE will avoid merging fclone with kmalloc-512, it does not
> > really help.
> >
> > I think we need help from mm/slub experts, instead of trying to 'fix'
> > networking stacks.
>
> @Christopher
>
> Any idea about this?

I had a simpler bpftrace program to get an histogram of [my_node,
node(sk_buff), node_of(skb->head)]
and can tell that going back to linux-v6.7 and CONFIG_SLAB=3Dy solved
all the issues for me.

99.9999% of SLAB allocations were on the right node.

This looks like a SLUB bug to me.

