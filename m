Return-Path: <linux-kernel+bounces-119972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2E588CF92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1920291FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1066713D24A;
	Tue, 26 Mar 2024 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlhJBE33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455E812B14F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486999; cv=none; b=T7EIAxWuIinUkaEHHjVIpgCb/+fO39RD+niXamP5P7lxF9DmSfgxRVsAxIqj9Um9byjx+eQqs/to8rjlkvIlP1NcHaYPCiisGJ4J9Y7YmzITZJShZEZtnBQvGyfkqJvc3G0sM6uJq568fyjJGlJ/c6JLxcqwPg2L7op+UWOx9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486999; c=relaxed/simple;
	bh=G+a++kNjQurBcA3LiA4cP05re6SA4msV1Gc1yXADqZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gS+Elds2oVB4iOpNs21wc5jWRk4q1cyXchSaq4FHJMt3uMxwU1OTyhTc5yLOHO3/45Ww9TH++1u23byODUNGYWcG35PnkRysH4KzslpadTU9Ysx4bVXIQZsjOyCta7k7xskGv6W82eJJkehtj2hlUFjkosKCOGWoC1bsrCqr2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlhJBE33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF685C43394
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711486998;
	bh=G+a++kNjQurBcA3LiA4cP05re6SA4msV1Gc1yXADqZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FlhJBE33ACZlGIK3E1Ye2ZgzXbearxME+UsSTgcQpj8e/cojSNa9jRdPeYVaqbQOr
	 31HTtj+W5kbHSPToUNAZjXafpIvSsFeJvUqpm4b4nDOKc9I5PCQchVgwVVDE15mTGW
	 wShGRIqOgOGhNADbba7ZRtfndTT8jU6uUtfKvc5Y+D6NSd32iKizedYZs2ZL0R9FON
	 37uqPGGU9NPcOyrdm0W5uMS6qkZqwanLz51Hq9IxOtKxsCppQZV20+JUw+ABLRj3YV
	 2QaTfqhjd65s42ijAc17nyErRBr+fEAXughG1TbQogEeDZmzv/nvezBSPHG3vmI9nm
	 jn3s91c1K56zw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513e89d0816so7499077e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:03:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVREI0fHc4WsJt4Mt0q6zjPhjGsoOekAigcVELx0pur4ZrfDHEcwOQ4O+GhMIQNWdEuuePsM/g5rAlOMPKAedUivcLr9bd+SiAmFMqH
X-Gm-Message-State: AOJu0YzxoSX++v6kUtnBQiRGslCEWafE7/MrpobzJEnTmcHRCp7p9a0M
	j+acr9JISykm7d0loFsJP6/i/bReyGC85TxfubHiKH71d3G4qYA7gyLzDkvcxY6OYDPWflWlZCg
	iTrVFATkLTZhXTBn9bwNQY5yTcg==
X-Google-Smtp-Source: AGHT+IGpShG06dy2Iv3ekbiR2tBs0kqc7LKX5Tjbx7DWUCpYMKmU8RF5hvpz5WOnAwuQtqFGCCamjbTbJN/VWCpjk50=
X-Received: by 2002:a19:644b:0:b0:512:c8f0:1954 with SMTP id
 b11-20020a19644b000000b00512c8f01954mr7070115lfj.0.1711486997354; Tue, 26 Mar
 2024 14:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-zswap-xarray-v9-1-d2891a65dfc7@kernel.org> <20240326204836.GC229434@cmpxchg.org>
In-Reply-To: <20240326204836.GC229434@cmpxchg.org>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 26 Mar 2024 14:03:05 -0700
X-Gmail-Original-Message-ID: <CANeU7QkSe6f3_81HOY4OeSk=Q+uZiEgks0vdhs7Xryjexusg+Q@mail.gmail.com>
Message-ID: <CANeU7QkSe6f3_81HOY4OeSk=Q+uZiEgks0vdhs7Xryjexusg+Q@mail.gmail.com>
Subject: Re: [PATCH v9] zswap: replace RB tree with xarray
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 1:48=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Mar 26, 2024 at 11:35:43AM -0700, Chris Li wrote:
> >       /*
> > -      * When reading into the swapcache, invalidate our entry. The
> > +      * When reading into the swapcache, erase our entry. The
> >        * swapcache can be the authoritative owner of the page and
> >        * its mappings, and the pressure that results from having two
> >        * in-memory copies outweighs any benefits of caching the
>
> Not sure why you editorialized this? Your patch doesn't change those
> semantics, for which "invalidation" of the backing copy is a much
> better description, given we're also marking the folio dirty again etc.

I was thinking the zswap_invalidate_entry function was deleted now. So
I use the erase to match the xa_erase().
>
> Can you please send a delta fix to undo that?

Sure.

Chris

>
> > @@ -1649,8 +1581,12 @@ bool zswap_load(struct folio *folio)
> >        * the fault fails. We remain the primary owner of the entry.)
> >        */
> >       if (swapcache)
> > -             zswap_rb_erase(&tree->rbroot, entry);
> > -     spin_unlock(&tree->lock);
> > +             entry =3D xa_erase(tree, offset);
> > +     else
> > +             entry =3D xa_load(tree, offset);
> > +
> > +     if (!entry)
> > +             return false;
> >
> >       if (entry->length)
> >               zswap_decompress(entry, page);
>
> Otherwise, looks good to me
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>

