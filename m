Return-Path: <linux-kernel+bounces-132190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02003899127
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFE9289BDE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE6A13C3EA;
	Thu,  4 Apr 2024 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNpgHmou"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9213C3F2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269081; cv=none; b=WZR3ONMF+hWV2vElcjJx2Zo+ily/wE5/yPD6WPRLZpkTSBU7xIlo0E9ihwNY8DJ/RW0BzwhoAmZKlj4EhbyBu9Nj0BoB94nrFkdqVjuPeC81ptKcFCb7D20jRSDb1R+GXlu5asvgZMJzaviOF01hrdc+EAB/7H7ajJtU/N/Xkpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269081; c=relaxed/simple;
	bh=RZPrq+xVDjiyzuvgmiC5bztMCL91wQIMW6JQhQhfvYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcEP+wzhB4yXYyEqPlV1ANgUiiDh38SHo85u7QcMqypdtokubuzrGo3JIsSOpzPICzu7cvf35etIMjSjICbp7l9u5ssg2yaaHYgUIKdKFayrh4q3xtxx0NxWAVYb/UM5DU8NMw4trI96EaasFzvYsJmWsW8eT2AJOqfncUe96Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNpgHmou; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4162b7f197cso6907475e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 15:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712269077; x=1712873877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIW+Z3FuH4Tlrbj9QrjroPzWQnEb4hQ4AxEw1tDZfk4=;
        b=iNpgHmouikM3eS2bzDsViRnQPf4IYT0AntRq/pLUycBts1tEtNDBhLAHPWLbGGQuwD
         QJtB2nqOmcrDZKQqkypAxU9t8BXasLVzM76U6doxh0UD6M0mrI/XgijigKuOcMI2NCIb
         whmis5i9jCy0XZKIvDNYWGW+znPQeHBEMsfX8rggozuXIuCHf0B+o1YIbhjdkYuLbC6k
         nmWR9tyq0QFPwh7UUDhI4p73EwefaEhKQVvrdC/li4M77bvJ/3+wYenQP3FJrzs+WVyB
         h/Tam1ckIRELByLvoQC8mEYZ6O8sMXwbWpK4qyuHRrWaDSukD/B1KlHnI6ojMiGvDvbK
         uIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712269077; x=1712873877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIW+Z3FuH4Tlrbj9QrjroPzWQnEb4hQ4AxEw1tDZfk4=;
        b=u3sxWvR11rPZd0HANO9hGwT/KTWwuaTLUqiaSTaEDfS7XfOdOlUxx7ex0cU/R9qcqx
         8Opp9fBRzvgO7WKJVVU85ylxZx3CnC31FXokXw0eO87Qe5pktMVZoJBv5R9eL530eMZ2
         wsVsJ8waIoNEPfBpyXEgaz32oj/aD+1FZJlS2M63UceHTILJ2dkmWinWafowmQGeaOEE
         j5/lEH9a8UgHjgktqvQpHSCEmt/omRwjHbYz5iW57iA3QQxtxKd2Lrljr6IFfHM88gPQ
         QwYtNZ7JUuLG3X/tCnUQJQNub0mf5geaMg2I7i1sCGY9Edxo0soipOtQRIizbwmov6tG
         DeTA==
X-Forwarded-Encrypted: i=1; AJvYcCVhH7+n4mUWaIxoHRs/djF4eZTpLcoYSrbi0selEtiEpLb/HImfPQ5Bz/vT6Q3gFqFng7D34gua63mcp8saDWYDTUJebuxvYI6V3IF1
X-Gm-Message-State: AOJu0YwmACwXbgCzvwMIXNnyyKGLqvyBqdqRA3WvOoPqbxpMB2T5VtMk
	3ChNyn/N2l2SN2jeuvYZDQNou2TZaRLwDdvrhsHj9Ko/CexQ0y1puzPA9AnNWu06D0uvjoL/lCy
	nIwWdpAvhpxVGLFrVKSJh8QppbyMjEczoKbFX
X-Google-Smtp-Source: AGHT+IEoGycg7Q6yz1U10yVcrqSmmGhsvl59dTKCzdbY+AGkKJwTyJBRF58S2bqCqewHCyhhbzL+kREAY0nZt0Z/KC8=
X-Received: by 2002:a5d:56cd:0:b0:343:a117:7d2 with SMTP id
 m13-20020a5d56cd000000b00343a11707d2mr434133wrw.71.1712269077043; Thu, 04 Apr
 2024 15:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404165404.3805498-1-surenb@google.com> <Zg7dmp5VJkm1nLRM@casper.infradead.org>
 <CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
In-Reply-To: <CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 4 Apr 2024 15:17:43 -0700
Message-ID: <CAJuCfpHy5Xo76S7h9rEuA3cQ1pVqurL=wmtQ2cx9-xN1aa_C_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: change inlined allocation helpers to account at
 the call site
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, joro@8bytes.org, will@kernel.org, 
	trond.myklebust@hammerspace.com, anna@kernel.org, arnd@arndb.de, 
	herbert@gondor.apana.org.au, davem@davemloft.net, jikos@kernel.org, 
	benjamin.tissoires@redhat.com, tytso@mit.edu, jack@suse.com, 
	dennis@kernel.org, tj@kernel.org, cl@linux.com, jakub@cloudflare.com, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	vbabka@suse.cz, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kent.overstreet@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 10:08=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Apr 4, 2024 at 10:04=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Thu, Apr 04, 2024 at 09:54:04AM -0700, Suren Baghdasaryan wrote:
> > > +++ b/include/linux/dma-fence-chain.h
> > > @@ -86,10 +86,7 @@ dma_fence_chain_contained(struct dma_fence *fence)
> > >   *
> > >   * Returns a new struct dma_fence_chain object or NULL on failure.
> > >   */
> > > -static inline struct dma_fence_chain *dma_fence_chain_alloc(void)
> > > -{
> > > -     return kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL);
> > > -};
> > > +#define dma_fence_chain_alloc()      kmalloc(sizeof(struct dma_fence=
_chain), GFP_KERNEL)
> >
> > You've removed some typesafety here.  Before, if I wrote:
> >
> >         struct page *page =3D dma_fence_chain_alloc();
> >
> > the compiler would warn me that I've done something stupid.  Now it
> > can't tell.  Suggest perhaps:
> >
> > #define dma_fence_chain_alloc()                                        =
   \
> >         (struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain=
), \
> >                                                 GFP_KERNEL)
> >
> > but maybe there's a better way of doing that.  There are a few other
> > occurrences of the same problem in this monster patch.
>
> Got your point.

Ironically, checkpatch generates warnings for these type casts:

WARNING: unnecessary cast may hide bugs, see
http://c-faq.com/malloc/mallocnocast.html
#425: FILE: include/linux/dma-fence-chain.h:90:
+ ((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain),
GFP_KERNEL))

I guess I can safely ignore them in this case (since we cast to the
expected type)?

>
> >
> > > +++ b/include/linux/hid_bpf.h
> > > @@ -149,10 +149,7 @@ static inline int hid_bpf_connect_device(struct =
hid_device *hdev) { return 0; }
> > >  static inline void hid_bpf_disconnect_device(struct hid_device *hdev=
) {}
> > >  static inline void hid_bpf_destroy_device(struct hid_device *hid) {}
> > >  static inline void hid_bpf_device_init(struct hid_device *hid) {}
> > > -static inline u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, =
u8 *rdesc, unsigned int *size)
> > > -{
> > > -     return kmemdup(rdesc, *size, GFP_KERNEL);
> > > -}
> > > +#define call_hid_bpf_rdesc_fixup(_hdev, _rdesc, _size) kmemdup(_rdes=
c, *(_size), GFP_KERNEL)
> >
> > here
> >
> > > -static inline handle_t *jbd2_alloc_handle(gfp_t gfp_flags)
> > > -{
> > > -     return kmem_cache_zalloc(jbd2_handle_cache, gfp_flags);
> > > -}
> > > +#define jbd2_alloc_handle(_gfp_flags)        kmem_cache_zalloc(jbd2_=
handle_cache, _gfp_flags)
> >
> > here
> >
> > > +++ b/include/linux/skmsg.h
> > > @@ -410,11 +410,8 @@ void sk_psock_stop_verdict(struct sock *sk, stru=
ct sk_psock *psock);
> > >  int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
> > >                        struct sk_msg *msg);
> > >
> > > -static inline struct sk_psock_link *sk_psock_init_link(void)
> > > -{
> > > -     return kzalloc(sizeof(struct sk_psock_link),
> > > -                    GFP_ATOMIC | __GFP_NOWARN);
> > > -}
> > > +#define sk_psock_init_link() \
> > > +             kzalloc(sizeof(struct sk_psock_link), GFP_ATOMIC | __GF=
P_NOWARN)
> >
> > here
> >
> > ... I kind of gave up at this point.  You'll want to audit for yourself
> > anyway ;-)
>
> Yes, I'll go over it and will make the required changes. Thanks for
> looking into it!
> Suren.

