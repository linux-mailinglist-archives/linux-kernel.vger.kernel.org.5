Return-Path: <linux-kernel+bounces-93061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B8E872A4D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093531F265C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7539212D214;
	Tue,  5 Mar 2024 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="30Twuya/"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762C15FEE3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678238; cv=none; b=ufZWqR0FRNyaJNtkt0vX12w4Qld0t+ZycoZVa+DDMSoQ463iuCdijKiqxRpoMD9u5ERjnFgaU2eGTChII3kN6VNREOVFYfiqQXtgEFjwBa2Cgx+knbwBrpid55o8BW8D6BW6//s9rNKnrzGB06+u3nbqQlupai2Yh2nMlzSwSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678238; c=relaxed/simple;
	bh=W3IhtgptIwJIGVaoRpBisgGELa47nlYnsK3KwD/Ht34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cz5YeGjDHoHpYz9sYg86TiANkZELuTQoBzz0WSyNcy5P7Vd1NFjzH5HhF+ouGHM0SuOsPpcVgGEvGvQqzTfqdkIpLpdQWuWIkLk6yy73N42Zun61+7tSQtT9iTKaSBRH233eqBDxlyeohZ/pV8apdGrezeVHRe1CljydRLCZb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=30Twuya/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56657bcd555so7789850a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 14:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709678234; x=1710283034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kopREHbBAUxVzUnXNQm6/nygDAEnIt8EnnHpLnLXzJA=;
        b=30Twuya/BSHODuDkMDJEZEMbRXYmIHHa/qYjsFkAi9XDF5R3UDSmSWMJEIRO15caX7
         X/dWlhJ0Y/oiDZJgoYyJGgY5e3Zp5nDoicPdRwUbc2XwjFWFu1H541RIEpXdYcNdgYGj
         jmX+BiOBPJ2WKufQPXUYEByMr4K391+BAT43iatSzWfESjgkOkCcgW2epMxAivv0QBfQ
         ELNrmKklOR+mGavcCIFFsQ15vJ8BIR19gSz/9uS0Fpjpu27h8KsxZTb+sYuI2OgCAz8q
         VLRH+MbnZzQn/5n5sJJPavlH4wd7rqiTu6aLCkHToLcorc59tRZOMixZaw5aTnpb+iC4
         Ga3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709678234; x=1710283034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kopREHbBAUxVzUnXNQm6/nygDAEnIt8EnnHpLnLXzJA=;
        b=YF0xeZb5NtFtY73r5tRf09Cr3s9QJ5o4YuZfkl80vMF2nSbz9iGDpxoIbSuQQiuIwr
         J+iBnGpNnBLJiGQba4KR1hbfb+EJ9crA4LK0+B0B3zO6SIIOcn58BL6uwXolgyO+vMS/
         JOf/X55uIf2a618hMxNzjSpU8pYeUVNaKh4GWGSciEsbPw3DPmLIGh0soNmRJDC74dtN
         AhVoxBKLPi3UDMPtEryJKF6ndq75K+hx8CbzGThPvqVswx92cICHe8MVleha8tzd5f0j
         v8liz79NEYyqS2Fr2TPQOOr1ArOgiMJy90PWfuPvSwio1jm2ceKz5HMzYi3Nva0w1GN3
         uOJA==
X-Forwarded-Encrypted: i=1; AJvYcCWsKyjGrYYtSx6O+NgJw+sGHbT2pLLHk+DQy4YnC2tFeJVC3PWXJHTGBREJ4dvwSaqy6aqLaFnktJclguwnKxVUncOBkPQSmov0/d5V
X-Gm-Message-State: AOJu0YwNmerQ33FzDNKqfrCfaQ98CN8F+4EBFdqugM0bHz9GB/nlGRkh
	W+/k/CyCm7jEbyoExF4xHYbkczuKyGgPMtOHnmcE4Ll0LRfm1qFMSjTkqgr1N12UzCSGzndPF81
	pIxq5JITBqMWYFX11Nb7FemFkX+nL7S5qS24m
X-Google-Smtp-Source: AGHT+IGTQdxh2CmAxYK7k5VXoEK42Hgk/ratOcoNOmaK6LyLSJdLrHbaSwb0N2rAMctN/RrhHCuSioRcZyfCDLP2rf8=
X-Received: by 2002:a17:906:ad8d:b0:a44:a5a:30c5 with SMTP id
 la13-20020a170906ad8d00b00a440a5a30c5mr9648703ejb.41.1709678233378; Tue, 05
 Mar 2024 14:37:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-3-almasrymina@google.com> <1b57dac2-4b04-4bec-b2d7-d0edb4fcabbc@davidwei.uk>
In-Reply-To: <1b57dac2-4b04-4bec-b2d7-d0edb4fcabbc@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 5 Mar 2024 14:36:59 -0800
Message-ID: <CAHS8izM5O39mnTQ8mhcQE75amDT4G-3vcgozzjcYsAdd_-he1g@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for
 custom page providers
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, shakeel.butt@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:55=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-03-04 18:01, Mina Almasry wrote:
> > +struct memory_provider_ops {
> > +     int (*init)(struct page_pool *pool);
> > +     void (*destroy)(struct page_pool *pool);
> > +     struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
> > +     bool (*release_page)(struct page_pool *pool, struct page *page);
>
> For ZC Rx we added a scrub() function to memory_provider_ops that is
> called from page_pool_scrub(). Does TCP devmem not custom behaviour
> waiting for all netmem_refs to return before destroying the page pool?
> What happens if e.g. application crashes?

(sorry for the long reply, but he refcounting is pretty complicated to
explain and I feel like we need to agree on how things currently work)

Yeah, the addition of the page_pool_scrub() function is a bit of a
head scratcher for me. Here is how the (complicated) refcounting works
for devmem TCP (assuming the driver is not doing its own recycling
logic which complicates things further):

1. When a netmem_ref is allocated by the page_pool (from dmabuf or
page), the netmem_get_pp_ref_count_ref()=3D=3D1 and belongs to the page
pool as long as the netmem is waiting in the pool for driver
allocation.

2. When a netmem is allocated by the driver, no refcounting is
changed, but the ownership of the netmem_get_pp_ref_count_ref() is
implicitly transferred from the page pool to the driver. i.e. the ref
now belongs to the driver until an skb is formed.

3. When the driver forms an skb using skb_rx_add_frag_netmem(), no
refcounting is changed, but the ownership of the
netmem_get_pp_ref_count_ref() is transferred from the driver to the
TCP stack.

4. When the TCP stack hands the skb to the application, the TCP stack
obtains an additional refcount, so netmem_get_pp_ref_count_ref()=3D=3D2,
and frees the skb using skb_frag_unref(), which drops the
netmem_get_pp_ref_count_ref()=3D=3D1.

5. When the user is done with the skb, the user calls the
DEVMEM_DONTNEED setsockopt which calls napi_pp_put_netmem() which
recycles the netmem back to the page pool. This doesn't modify any
refcounting, but the refcount ownership transfers from the userspace
back to the page pool, and we're back at step 1.

So all in all netmem can belong either to (a) the page pool, or (b)
the driver, or (c) the TCP stack, or (d) the application depending on
where exactly it is in the RX path.

When an application running devmem TCP crashes, the netmem that belong
to the page pool or driver are not touched, because the page pool is
not tied to the application in our case really. However, the TCP stack
notices the devmem socket of the application close, and when it does,
the TCP stack will:

1. Free all the skbs in the sockets receive queue. This is not custom
behavior for devmem TCP, it's just standard for TCP to free all skbs
waiting to be received by the application.
2. The TCP stack will free references that belong to the application.
Since the application crashed, it will not call the DEVMEM_DONTNEED
setsockopt, so we need to free those on behalf of the application.
This is done in this diff:

@@ -2498,6 +2498,15 @@ static void tcp_md5sig_info_free_rcu(struct
rcu_head *head)
 void tcp_v4_destroy_sock(struct sock *sk)
 {
  struct tcp_sock *tp =3D tcp_sk(sk);
+ __maybe_unused unsigned long index;
+ __maybe_unused void *netmem;
+
+#ifdef CONFIG_PAGE_POOL
+ xa_for_each(&sk->sk_user_frags, index, netmem)
+ WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem, false));
+#endif
+
+ xa_destroy(&sk->sk_user_frags);

  trace_tcp_destroy_sock(sk);

To be honest, I think it makes sense for the TCP stack to be
responsible for putting the references that belong to it and the
application. To me, it does not make much sense for the page pool to
be responsible for putting the reference that belongs to the TCP stack
or driver via a page_pool_scrub() function, as those references do not
belong to the page pool really. I'm not sure why there is a diff
between our use cases here because I'm not an io_uring expert. Why do
you need to scrub all the references on page pool destruction? Don't
these belong to non-page pool components like io_uring stack or TCP
stack ol otherwise?

--=20
Thanks,
Mina

