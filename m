Return-Path: <linux-kernel+bounces-133096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FCF899EC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75961C20D29
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D74516DEB9;
	Fri,  5 Apr 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYTVf2I+"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976F16D9BA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325203; cv=none; b=itEBIthWUjcNvJgdJOgaJf7Sj9taIKcIVgKrRv4DSCCVtTgccJ+LOhLAKBgD2WrToehdMcdFnQwUm+RwfgnHttmV+mWoDbXG/foE4KVb4kb4KZZCHoS9zZpnCf7HiwlGBL4u8VQX5Q4NzlvTuK8dU3GhO+XqF/rBJb9S2kOLQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325203; c=relaxed/simple;
	bh=0BksyQPOyLKGmYa0FEtepwJD1JDHx0EJaEKX0tpkO58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILNjJ+VlLB8IBKPqXxdy3PQKMuWqRYxyrztFyZcGjwLgApzUWdHFVCGTcRcr7E3T/jqTLSK3hHNe+nG/R0c6Z/o1l8DNEniFlda13Yu/vwfRYoxhCkL0f97aIrPyS4eHJFJ70sQqYGpIgqK8z6RjL+lIo4x4UZAX1KC4wLQqvuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYTVf2I+; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso2280294276.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712325200; x=1712930000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAHdE5NFk++ufix28SzhuwWBAI0pKipkj98VJiYe3GU=;
        b=aYTVf2I+TyRnSSdH8+I/CVMYO1BJa7hB9/v01eKTU4OrNL9qd16Jg0wQfeflZu4I00
         bJzKgnoYGjlF2wFjjjOIkrUvFIjP/gbka8Ca/nK2NNuY96Fo8i0pVlzBoXDg1TkGWJgh
         e74bm5LQIwxwotdUhDKtFybHE4VYNE/OXkfP4r8mdYC/WVnYYO2zvp0is9rK/LvGlb1u
         rNp+xyY2kEDgPEpFHmoCvWu4DRKLOea8E3f1pcxL98WGt6zjQX+gyOrqvrhhCb7mBZhQ
         NliJCHdvq8o1zOgd+ypWl8ttBwBOiemAKjdJsQE5P4duBu286hd2IUmiV+Z3y72bJNxi
         hYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712325200; x=1712930000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAHdE5NFk++ufix28SzhuwWBAI0pKipkj98VJiYe3GU=;
        b=rDCtWbn/EhPQJkfkaF2Ju7n+9ok0ORLz0NoAwU5MGhczeEN/QgW3IuMyb0rsf4Ep5B
         pm4G/JHkjARXADnkP1LZvt/wmESOdVoSypP2RM/kpVenWrFZkIOpvLHnSgHe0g+ByxW6
         mA6Y8b37Dxke7X4d91aF5l+dvBDZLmj33lwgmHe6igZz3y6or9u9x4iwcB7+cA7TC6oa
         f9IGEd16pg1CqBPmN9YFxS2FStxuRc5IsU3u1S1IfoeF6D6sv44P0OcU9sMkpz6ceNDP
         hA+Jmsuz5fTiTO/Vx52F767lPt3/nUNE48VEGhUbpXmW6qMIanpr4vCCxm+WO9Ik0cpI
         FZfg==
X-Forwarded-Encrypted: i=1; AJvYcCWu91ptRXWOHefmqsye7y50Hi+0FufI3GutOWn8CYTSDXZyXI8+wH9rCDP9JAIgqEnvHdOZoZm1fXX99vdZZ2YsIRIqoF+a3nt/ZakA
X-Gm-Message-State: AOJu0YwhQZad6RcC3i6EC8H0qKK7OQrH+2jjxV62EXaVPeGWfGJMfdWX
	3KzMoOKcCi2aozwrHkAi5DZIu5zEbEWfOW9oabzaPVROTt4HIscB1+epRKA+xhTJbHYmiSMCeHX
	hY7o0Xu9RB4l6pPWCGY4KdVev7GiUSE2P0as1
X-Google-Smtp-Source: AGHT+IH/KRHN+9M5N1gYIB2bCPgMB25x0KPnvuKiHgvgSCGh43Ngn+0mkz51p67LhizDAcBL1UgazcYTNlxqGDPZP2o=
X-Received: by 2002:a25:f454:0:b0:dcd:b624:3e55 with SMTP id
 p20-20020a25f454000000b00dcdb6243e55mr1115241ybe.54.1712325200128; Fri, 05
 Apr 2024 06:53:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404165404.3805498-1-surenb@google.com> <Zg7dmp5VJkm1nLRM@casper.infradead.org>
 <CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
 <CAJuCfpHy5Xo76S7h9rEuA3cQ1pVqurL=wmtQ2cx9-xN1aa_C_A@mail.gmail.com>
 <Zg8qstJNfK07siNn@casper.infradead.org> <jb25mtkveqf63bv74jhynf6ncxmums5s37esveqsv52yurh4z7@5q55ttv34bia>
 <20240404154150.c25ba3a0b98023c8c1eff3a4@linux-foundation.org>
 <jpaw4hdd73ngt7mvtcdryqscivx6m2ic76ikfkcopceb47becp@vox5czt5bec3> <Zg_yHGKpw4HJHdpb@casper.infradead.org>
In-Reply-To: <Zg_yHGKpw4HJHdpb@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 5 Apr 2024 06:53:09 -0700
Message-ID: <CAJuCfpGMSHv7drSu7Veo5CVz3d_Upt8S6Rdx3isi7orct9-uNQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: change inlined allocation helpers to account at
 the call site
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	joro@8bytes.org, will@kernel.org, trond.myklebust@hammerspace.com, 
	anna@kernel.org, arnd@arndb.de, herbert@gondor.apana.org.au, 
	davem@davemloft.net, jikos@kernel.org, benjamin.tissoires@redhat.com, 
	tytso@mit.edu, jack@suse.com, dennis@kernel.org, tj@kernel.org, cl@linux.com, 
	jakub@cloudflare.com, penberg@kernel.org, rientjes@google.com, 
	iamjoonsoo.kim@lge.com, vbabka@suse.cz, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 5:44=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Thu, Apr 04, 2024 at 07:00:51PM -0400, Kent Overstreet wrote:
> > On Thu, Apr 04, 2024 at 03:41:50PM -0700, Andrew Morton wrote:
> > > On Thu, 4 Apr 2024 18:38:39 -0400 Kent Overstreet <kent.overstreet@li=
nux.dev> wrote:
> > >
> > > > On Thu, Apr 04, 2024 at 11:33:22PM +0100, Matthew Wilcox wrote:
> > > > > On Thu, Apr 04, 2024 at 03:17:43PM -0700, Suren Baghdasaryan wrot=
e:
> > > > > > Ironically, checkpatch generates warnings for these type casts:
> > > > > >
> > > > > > WARNING: unnecessary cast may hide bugs, see
> > > > > > http://c-faq.com/malloc/mallocnocast.html
> > > > > > #425: FILE: include/linux/dma-fence-chain.h:90:
> > > > > > + ((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_ch=
ain),
> > > > > > GFP_KERNEL))
> > > > > >
> > > > > > I guess I can safely ignore them in this case (since we cast to=
 the
> > > > > > expected type)?
> > > > >
> > > > > I find ignoring checkpatch to be a solid move 99% of the time.
> > > > >
> > > > > I really don't like the codetags.  This is so much churn, and it =
could
> > > > > all be avoided by just passing in _RET_IP_ or _THIS_IP_ depending=
 on
> > > > > whether we wanted to profile this function or its caller.  vmallo=
c
> > > > > has done it this way since 2008 (OK, using __builtin_return_addre=
ss())
> > > > > and lockdep has used _THIS_IP_ / _RET_IP_ since 2006.
> > > >
> > > > Except you can't. We've been over this; using that approach for tra=
cing
> > > > is one thing, using it for actual accounting isn't workable.
> > >
> > > I missed that.  There have been many emails.  Please remind us of the
> > > reasoning here.
> >
> > I think it's on the other people claiming 'oh this would be so easy if
> > you just do it this other way' to put up some code - or at least more
> > than hot takes.
>
> Well, /proc/vmallocinfo exists, and has existed since 2008, so this is
> slightly more than a "hot take".
>
> > But, since you asked - one of the main goals of this patchset was to be
> > fast enough to run in production, and if you do it by return address
> > then you've added at minimum a hash table lookup to every allocate and
> > free; if you do that, running it in production is completely out of the
> > question.
>
> And yet vmalloc doesn't do that.
>
> > Besides that - the issues with annotating and tracking the correct
> > callsite really don't go away, they just shift around a bit. It's true
> > that the return address approach would be easier initially, but that's
> > not all we're concerned with; we're concerned with making sure
> > allocations get accounted to the _correct_ callsite so that we're givin=
g
> > numbers that you can trust, and by making things less explicit you make
> > that harder.
>
> I'm not convinced that _THIS_IP_ is less precise than a codetag.  They
> do essentially the same thing, except that codetags embed the source
> location in the file while _THIS_IP_ requires a tool like faddr2line
> to decode kernel_clone+0xc0/0x430 into a file + line number.
>
> > This is all stuff that I've explained before; let's please dial back on
> > the whining - or I'll just bookmark this for next time...
>
> Please stop mischaracterising serious thoughtful criticism as whining.
> I don't understand what value codetags bring over using _THIS_IP_ and
> _RET_IP_ and you need to explain that.

The conceptual difference between codetag and _THIS_IP_/_RET_IP_ is
that codetag injects counters at the call site, so you don't need to
spend time finding the appropriate counter to operate on during
allocation.

