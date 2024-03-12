Return-Path: <linux-kernel+bounces-100302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC51E879552
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C42E3B22849
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCC77A714;
	Tue, 12 Mar 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4n5hPNN"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920067A15A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710251329; cv=none; b=t4QqFOdbrRPy27funoiJoqXd1QkNDAk/R4ZloZiabwSOjeDlrDA7aFwlMOK8D9yIqefhRR4USAR7Kcmfi4Gk+a1bFr72qXIgAlBoBuAogiVj7hGqM3afUY5fhmKkEz4XrU1tEbwokO5rbf19WBiq9y/CyJ8RBc4XOoeS+feP/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710251329; c=relaxed/simple;
	bh=mqdloibA4FQfmySkAVlcFWZ2kduQF+L4m1UAOl23IMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTkWKOHgWpUiwI91tzHTDbB2bz/vUi1CReChVKUmO7Ls1rcdBHCevX76iuTtbN3Ik6AZ+ZYFs5UbT6RvIyH1BytURZMjACeqTH8yFQCZgRaoaj0Z6UhnQAkG86kimlu7lu0mQV57wYEV+b65f5tpfMbBazBC8AR+SoIPoGCCIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4n5hPNN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so9252a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710251326; x=1710856126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+kG37cn+Hhk9HFtQJetz/0W7LCqtER5XXHHxqsY9KU=;
        b=l4n5hPNN/efK0XTplNKWJSbb5AoFW/LHqIOPFYDKsZoS5KlkkvW9ZTRXGFCjjBJd+W
         mgDVoNTeAh4+DV3xspz9j5Ogxi380uNqemmCfLWt5WFijJNVN+L9YY+472cu9pAaSUzV
         tq/XU6iGJT4itAfjkrlSRWDEYLvPTY2RAxibALlNufyIL0ZYcU8WkAUvoSYzeLV/+oMb
         GK/D1Ulgu30iRDF78K6l5O2jpL83Z7hTJLvbAnMPRXGbUScyxQddDDk2b99Yp2I1ElWL
         vXYz+HsTxvHTfdOAXaFyfF3fu0TBFl6OCkQB/uIbsLvNeEdn1G7jR09MC7Da+UOa1Hgr
         bjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710251326; x=1710856126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+kG37cn+Hhk9HFtQJetz/0W7LCqtER5XXHHxqsY9KU=;
        b=Y+1+1d5ZqALv8IYOLXxQGVYqr6oEA7kl/UVjWfWKKYwWeCOTC4jYN/TYrUyM2RBAVC
         Xdjwe7nyG09b2lxEBnMfB+u48W+9obkQgp28c6qYCao1fehVaBJBc33woVNu2MnGI6Hc
         wOB/CRRaT8ERQxmlsdc69nVHtDJ96WqB+xlk4SwYZZ3eR7cAXFt6v/r/y7wIBK8CeCK7
         mss2CdsTXhiESPFbDKy2QsI4Nuy0kaUU8iWdF/q0wNcS2wlnhOzKlBifprAM2r+sNA9e
         3RJRIZJJ71NKWksfCPFnSCFMzyg/EKmXBXVgZpncJ3EM4FV9+3vk96Zs8VUaePlijBDz
         Nbew==
X-Forwarded-Encrypted: i=1; AJvYcCWpDga4oShoed3N3RAf30LEeZV6hvSqdJTqbbjtFdCOID+JrLuUlwqzC73OQv5bG2Jc8FT8mTKNjlsobgTB62Sy905cqGEj0dOPQVeH
X-Gm-Message-State: AOJu0YwO8D/yJhCRzrJn01Umrhv0/414FewUGRogKjA9uwbd0gFUvuMo
	IQkjuEpmvzX4Sa/TH0UoE5e5VewnIDa3hzCcm4/rz7+2eMWh6n4KuVNv51cl8F/TM7XTpDTDFd6
	q2pJZMrDzP9OIugxoiO9LLyGjtUjbi+/BULUd
X-Google-Smtp-Source: AGHT+IFcQAFNe2bhFCHb4bclCBXccqBguTbmeCO0n9SDxQ5IunD0vK40Gu7SAv/OLCbD+Mb5itB8534hYWCS08Sgg7g=
X-Received: by 2002:a50:9f2f:0:b0:568:72e2:4e6f with SMTP id
 b44-20020a509f2f000000b0056872e24e6fmr133392edf.6.1710251325617; Tue, 12 Mar
 2024 06:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLwtfAxS7WoMw-1_uxVe3EYajXRuzZfwaQEk0+7m6-B+ug@mail.gmail.com>
 <CANn89i+qLwyPLztPt6Mavjimyv0H_UihVVNfJXWLjcwrqOudTw@mail.gmail.com>
 <20240306103632.GC4420@breakpoint.cc> <CANn89iLe0KGjbSim5Qxxr6o0AjJVs7-h79UvMMXKOgGKQUosiA@mail.gmail.com>
 <20240312132107.GA1529@breakpoint.cc>
In-Reply-To: <20240312132107.GA1529@breakpoint.cc>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Mar 2024 14:48:31 +0100
Message-ID: <CANn89iLkDwnZdBY8CwkrQwCk2o7EAM9J1sv+uxU1tjKb=VB=Ag@mail.gmail.com>
Subject: Re: KASAN: slab-use-after-free Read in ip_finish_output
To: Florian Westphal <fw@strlen.de>
Cc: xingwei lee <xrivendell7@gmail.com>, pabeni@redhat.com, davem@davemloft.net, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, ralf@linux-mips.org, syzkaller-bugs@googlegroups.com, 
	samsun1006219@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 2:21=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Eric Dumazet <edumazet@google.com> wrote:
> > > so skb->sk gets propagated down to __ip_finish_output(), long
> > > after connrack defrag has called skb_orphan().
> > >
> > > No idea yet how to fix it,
> >
> > My plan was to refine "inet: frag: Always orphan skbs inside
> > ip_defrag()" and only do the skb_orphan()
> > for skb added to a frag_list.
> >
> > The head skb would keep a reference to the socket.
>
> I tried to follow this but its beyond my abilities.
>
> Defrag messes with skb->truesize, and I do not know how to
> fix that up safely so later calls to destructor won't underflow sk
> accouting.
>
> Furthermore, depending on delivery order, the skb that gets
> passed to rest of stack might not be the head skb (the one with
> full l4 header and sk reference), its always the last one that arrived.
>
> Existing code skb_morphs() this, see inet_frag_reasm_prepare() and also
> the ->truesize munging (which is fine only because all skbs are
> orphans...).
>
> So in order to not pass already-released sk to inet output somehow
> the skb->sk reference needs to be stolen and moved from one sk
> to another.
>
> No idea how to do this, let alone do regression testing for this.
> see e.g. 48cac18ecf1de82f76259a54402c3adb7839ad01 which added
> unconditional orphaning in ipv6 netfilter defrag.
>
> ATM the only "solution" I see is to completely remove netfilter defrag
> support for outgoing packets.

Thanks for taking a look Florian.

Perhaps not messing with truesize at all would help ?

Something based on this POC :

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index 153960663ce4c2389259e0dc2bb4ba0b011dc698..8fd688df4b24dec7b5a1ea365d5=
b34d81fe6e0e5
100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -94,6 +94,7 @@ struct inet_frag_queue {
        struct rb_root          rb_fragments;
        struct sk_buff          *fragments_tail;
        struct sk_buff          *last_run_head;
+       struct sock             *sk;
        ktime_t                 stamp;
        int                     len;
        int                     meat;
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 7072fc0783ef56e59c886a2f2516e7db7d10c942..aee706226ef8d9e9514fcf7d60e=
4d278ff7178fa
100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -297,6 +297,8 @@ void inet_frag_destroy(struct inet_frag_queue *q)
                        SKB_CONSUMED;
        WARN_ON(del_timer(&q->timer) !=3D 0);

+       if (q->sk)
+               sock_put(q->sk);
        /* Release all fragment data. */
        fqdir =3D q->fqdir;
        f =3D fqdir->f;
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index a4941f53b523725cd777d213500b8f6918287920..198a4c35cd1232278678a20bf0f=
2a49c63f548fc
100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -377,6 +377,10 @@ static int ip_frag_queue(struct ipq *qp, struct
sk_buff *skb)

                skb->_skb_refdst =3D 0UL;
                err =3D ip_frag_reasm(qp, skb, prev_tail, dev);
+               if (qp->q.sk) {
+                       swap(qp->q.sk, skb->sk);
+                       skb->destructor =3D sock_edemux;
+               }
                skb->_skb_refdst =3D orefdst;
                if (err)
                        inet_frag_kill(&qp->q);
@@ -384,6 +388,7 @@ static int ip_frag_queue(struct ipq *qp, struct
sk_buff *skb)
        }

        skb_dst_drop(skb);
+       skb_orphan(skb);
        return -EINPROGRESS;

 insert_error:
@@ -487,7 +492,6 @@ int ip_defrag(struct net *net, struct sk_buff
*skb, u32 user)
        struct ipq *qp;

        __IP_INC_STATS(net, IPSTATS_MIB_REASMREQDS);
-       skb_orphan(skb);

        /* Lookup (or create) queue header */
        qp =3D ip_find(net, ip_hdr(skb), user, vif);
@@ -495,7 +499,12 @@ int ip_defrag(struct net *net, struct sk_buff
*skb, u32 user)
                int ret;

                spin_lock(&qp->q.lock);
+               if (!qp->q.sk) {
+                       struct sock *sk =3D skb->sk;

+                       if (sk && refcount_inc_not_zero(&sk->sk_refcnt))
+                               qp->q.sk =3D sk;
+               }
                ret =3D ip_frag_queue(qp, skb);

                spin_unlock(&qp->q.lock);

