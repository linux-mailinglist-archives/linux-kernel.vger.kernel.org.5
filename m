Return-Path: <linux-kernel+bounces-165006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C54868B865F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E0BB227C9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B634DA10;
	Wed,  1 May 2024 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NzocMZC3"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE59D4D9E9
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549741; cv=none; b=XT70w+wy2Q6OmsvtxCPg9/Wqn8qXZLVcRZi6gsvIuF3q2w/sdzzK1X5UE9VKaXudLfHHvwEc1oKmyaSfqPswQ4Xq3eenEQfvZxO6sC0oFv9YOBqdqks1tGjVicdzj5oXE28hpr/opfumg3lhsUZKAo8UXSqVMjcbC+sVB4TroR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549741; c=relaxed/simple;
	bh=cGwK526R503ldDm/CriBnxuRBeqaMR26khdz4eVoYoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gblzRqUhBvG1ScnQ7m79PC8RRN0xg4v3KwC+9PjVpTnXxcXDQqRGcPrqWT8FEPYwXegtqbhTjNgZ2HjRY+XRZQu4ro5nGY27iUK5q08gfbLB8LJJPU5+Gf+fNi2zEMkp8Kj0xkI3Fx8Qm3b6vpyejOm8rf2jipvsNDYlt5daRoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NzocMZC3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-571be483ccaso7898069a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 00:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714549738; x=1715154538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6caJNuoOcbTF2A8XjASgel2eyoPHbRLJ4yhUwfPsJg=;
        b=NzocMZC3LreJ+QmatL3XEJtLc8PzGFznZ0sz+0GfTNbScnK/PxRu8ef65Wqi8hYvzB
         8My69b2QfPtaP6pxCVV8py2hvmq+VmCKDfw9FPmh5YMcY6adIx9yNR3NRr7bkbqi1sqH
         WPV+jki4lhuqOse9FO0dy4eNEBu1A9TpbhQQQ2sjDBeIDU+z40BZxryqE0P3cb6BSiku
         RljMJj9ql1TwhirXFqoxtGUyhanUUWqoPjh/PEsrokBH0f8xm6iEeY4JqxmQwHy89/aq
         U268mnYY8F0dERU4enxZdbnb6Pt984WwXhKu4eMzpxs0RBqGFTopzOxWndrExrwd7yTR
         Ibdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714549738; x=1715154538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6caJNuoOcbTF2A8XjASgel2eyoPHbRLJ4yhUwfPsJg=;
        b=FQJdx7Nggg0PZcOxtCD3BNiGtvNhda67O4xLK8CLRQPsOhJok5cCyX4JlaErk4ChOa
         IbSO/y+b9Q8C0zvgGrXdJk4SoEWARcVh6bFg0LaBHExezJt1kjOlehcXSg9Tdoa8dhN2
         R4gS4xasAi4O7L2/N4PxB7BHI4T72HHaiY1cDnLn2Hl7/HM78LpbOFYyuaM9qEHEZVrY
         7qFn8duNwhfRkMSGyi2V8eO57kseGvtUOCXsczWvDIf9dvk7UTTZ1HPYymYolacCK2cm
         EA7U7AVPOJ3JK51e13yif7WkDMgvJ3pYrd0OuSuu+ACTtIGWLmCxoccwFoAlU9RysYHn
         9X/A==
X-Forwarded-Encrypted: i=1; AJvYcCWti9GT7kyy50m1+FfycxuMBKl1nenyGW0Do22j7NkWliqHp6iLyrBJCtVxXWYJgdCXcj/ji5/XFnZeAkTog99NhPk4GmCikeiJXuvQ
X-Gm-Message-State: AOJu0YzzaA2dSx7RLmFKni2XUeZBdEQARiFTrw21L8RHXWyWHBIhIntP
	1kTRLqW/6MaiOw22juh+hZf/mBF1zpuzvb8XFqX1n4YuAXA0bLF+/hSffsiTpyVc21z9xlBqMU1
	c8ENzKHFyMagZDoytvS/KEoTOIXUIIa3CkN65
X-Google-Smtp-Source: AGHT+IGhlKIspORV3UsoMFDJbaiFzOQH7V8xn49DkcxHrG8vlrT1eYyx0WJBZ3CEo2IQKHYAlSXX53YHVqq5Mgwl4Sc=
X-Received: by 2002:a17:906:52c1:b0:a55:5ddd:e5f6 with SMTP id
 w1-20020a17090652c100b00a555ddde5f6mr1398294ejn.28.1714549737800; Wed, 01 May
 2024 00:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424165646.1625690-2-dtatulea@nvidia.com> <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
 <CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
 <4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
 <20240426160557.51de91f9@kernel.org> <c307a3086d255d1dfed22284f500aa9fb70f11a3.camel@nvidia.com>
 <7a5a1d74040052afc8cc6cc5c2700fdf2e836b0c.camel@nvidia.com>
In-Reply-To: <7a5a1d74040052afc8cc6cc5c2700fdf2e836b0c.camel@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 1 May 2024 00:48:43 -0700
Message-ID: <CAHS8izOsFqiSiS4Z-E-jfD70aogNp5Bcyt7Rk8xFoR2TcDjz=g@mail.gmail.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	Jianbo Liu <jianbol@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"edumazet@google.com" <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 11:20=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> On Mon, 2024-04-29 at 09:39 +0200, Dragos Tatulea wrote:
> > On Fri, 2024-04-26 at 16:05 -0700, Jakub Kicinski wrote:
> > > On Thu, 25 Apr 2024 08:17:28 +0000 Dragos Tatulea wrote:
> > > > >  The unref path always dropped a regular page
> > > > > ref, thanks to this commit as you point out:
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D2cc3aeb5ecccec0d266813172fcd82b4b5fa5803
> > > > >
> > > > > AFAICT the correct fix is to actually revert commit 2cc3aeb5eccc
> > > > > ("skbuff: Fix a potential race while recycling page_pool packets"=
).
> > > > > The reason is that now that skb_frag_ref() can grab page-pool ref=
s, we
> > > > > don't need to make sure there is only 1 SKB that triggers the rec=
ycle
> > > > > path anymore. All the skb and its clones can obtain page-pool ref=
s,
> > > > > and in the unref path we drop the page-pool refs. page_pool_put_p=
age()
> > > > > detects correctly that the last page-pool ref is put and recycles=
 the
> > > > > page only then.
> > > > >
> > > > I don't think this is a good way forward. For example, skb->pp_recy=
cle is used
> > > > as a hint in skb_gro_receive to avoid coalescing skbs with differen=
t pp_recycle
> > > > flag states. This could interfere with that.
> > >
> > > That's a bit speculative, right? The simple invariant we are trying t=
o
> > > hold is that if skb->pp_recycle && skb_frag_is_pp(skb, i) then the
> > > reference skb is holding on that frag is a pp reference, not page
> > > reference.
> > >
> > Yes, it was a speculative statement. After re-reading it and the code o=
f
> > skb_gro_receive() it makes less sense now.
> >
> > Mina's suggestion to revert commit 2cc3aeb5eccc ("skbuff: Fix a potenti=
al race
> > while recycling page_pool packets") seems less scary now. I just hope w=
e don't
> > bump into too many scenarios similar to the ipsec one...
> >
> > > skb_gro_receive() needs to maintain that invariant, if it doesn't
> > > we need to fix it..
> > >
> >
> Gentle ping. Not sure how to proceed with this:
>
> 1) Revert commit 2cc3aeb5eccc
> ("skbuff: Fix a potential race while recycling page_pool packets"). I tes=
ted
> this btw and it works (for this specific scenario).
>
> 2) Revert Mina's commit a580ea994fd3 ("net: mirror skb frag ref/unref hel=
pers")
> for now.
>

I vote for #1, and IIUC Jakub's feedback, he seems to prefer this as
well. If we continue to run into edge cases after the revert of #1, I
think we may want to do #2 and I can look to reland it with the kunit
tests that Jakub suggested that reproduce these edge cases.

I can upload #1 in the morning if there are no objections. I don't see
any regressions with #1 but I was never able to repo this issue.

--=20
Thanks,
Mina

