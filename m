Return-Path: <linux-kernel+bounces-119715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D056488CC57
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC24340909
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744D512B169;
	Tue, 26 Mar 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OD+txsyv"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDEE13CA91
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478979; cv=none; b=RNwHcPdnHyzo7CKuaxP6VYYL4LnWGaiAE0a8SMMtzXe6a5XQK5hd/o8pAH8zMUOmELcJh92qumhmlEOel63ZSNiLVP8OyU4g8Rcj9nflczknC9fSsPMZovRADLyOotV7UyE3tOejDRiwD3EbGaao1R03s2g2iJ1PAU7N8OWmDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478979; c=relaxed/simple;
	bh=sz/KySFqkXJ/aVJ6XdfwyB3EarRQ8vsnsAWN1EYmjhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+KtQPzqyPKgXJZDrY1ODKb/umBWgrM66K0F+gnokMEZLDrER0IJqyEoO7PJZjISCAm1cFzijHr6bi9uIO5SpZCxmcQNeRKQX2ui1v0vGycWtwyPnYXnn19CcZG8iY9Ng7PY/1phJdev7F8ybMhMWMCkLhdFT669vLRLObmzrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OD+txsyv; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513e6777af4so10664986e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711478976; x=1712083776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mynrQyLYQKIvyzb5pPjoeLmjvmkiY75j1id5hI0x/A=;
        b=OD+txsyvtkEf7CHmhu2Xheda4K0a/PAiBoFjEBhRtcQkEEQQyNAF4s7Z4DdEr0FzTI
         m6Expxw4ZIHJQZp4EFrajhg133c5gABYjtY5DEYU2VDkvnnhRGYwlUwQ4dfJdJql2ogu
         PaNjuVG9pjoAm5SRQeJHQpMqOLEdDFDE33j5sG6aIL0lIwdR7HcR65X8tLmYQhGi4ftY
         kgg3oaC2DfFYTzMBRfa668KQ6FvtE9Na6oeavA5TNXlySa9KbdlYkCU/iR4Q3vrECCH6
         x/fldArBmKSXIteZBgBgcKtQ2Py7HHi369Q9J70N7UVK1hofm3LisQrYIkA9rHSrGwLl
         trZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478976; x=1712083776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mynrQyLYQKIvyzb5pPjoeLmjvmkiY75j1id5hI0x/A=;
        b=eWGFcjmnd4pFLYiSeR+fCih6mYmCcvc0YSmbY1KFWskY9Nvjxq0ChZwa0fZmd0doSV
         4IVDUG9gLMDldqx1Ov25DS1QE1p/IUySDs4BH/9pRNffHiEmIvCWSX52dfKnNrHLaLko
         SYcv8+h8mP6fqCut0a1+Ku/6rkHXMMY73csdS366Os8/4a0KNqBMZb9lVZkWnAtZt26t
         7eG0bRfStpmpwTRMVxNHhDEnsXHFfe+wE7evuqorbmByqyBC3L29RIUuzT5x04/tsI4E
         V4nQN26OUFA/wCXKgtmtE/9hBQMGA1EU2JrtUFoWo95ZWlo8cvXY+BsN8tDAPE8gyCkx
         ziKg==
X-Forwarded-Encrypted: i=1; AJvYcCWkeMAZKGSNNzutBni4v8hGVCnV4o0aYTQ/lS+O70kz3MyFPFUu0EcLe6mf/6lRsQoCfbsZGkruewcyYKxrCImUUqawnRFv12FTHUXJ
X-Gm-Message-State: AOJu0Yyi4j6CLTPSw2Xh8Nh86jU4uAu9w7zv6iwXQ/iZYwk6QLizFMru
	FbkdSvePvwcO6Jb7tzXSN/fhTwjGKxBzNwcUxNYTSXy11d93qsDLup1GOdXvPp8NrABzJH3m68y
	FVm42kRteu7NiFAvVdhdjPRVyyQpl5ZhJYve29wougcJsr/Vtxw==
X-Google-Smtp-Source: AGHT+IGadDByxC5Y8jsYw2G3ELZW4f5s1LwSvVhbepIXimyXtqmvP0RJWH5b0K5i33DD9xw9b2Q8/zpYp0ntt35t/Qg=
X-Received: by 2002:a19:5e47:0:b0:513:c2e3:226e with SMTP id
 z7-20020a195e47000000b00513c2e3226emr341221lfi.8.1711478975472; Tue, 26 Mar
 2024 11:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-zswap-xarray-v9-1-d2891a65dfc7@kernel.org> <CANeU7Q=8p4whMu+H9GXqQc4Ehjt0_kCtNdg34TiW4bWFw03dbw@mail.gmail.com>
In-Reply-To: <CANeU7Q=8p4whMu+H9GXqQc4Ehjt0_kCtNdg34TiW4bWFw03dbw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 26 Mar 2024 11:48:57 -0700
Message-ID: <CAJD7tkajaRoZOmHV2HhkWk+j9rV6SBDMiZQYvAEw_Y-mH0CPtg@mail.gmail.com>
Subject: Re: [PATCH v9] zswap: replace RB tree with xarray
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 11:42=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Tue, Mar 26, 2024 at 11:35=E2=80=AFAM Chris Li <chrisl@kernel.org> wro=
te:
> >
> > Very deep RB tree requires rebalance at times.  That contributes to the
> > zswap fault latencies.  Xarray does not need to perform tree rebalance.
> > Replacing RB tree to xarray can have some small performance gain.
> >
> > One small difference is that xarray insert might fail with ENOMEM, whil=
e
> > RB tree insert does not allocate additional memory.
> >
> > The zswap_entry size will reduce a bit due to removing the RB node, whi=
ch
> > has two pointers and a color field.  Xarray store the pointer in the
> > xarray tree rather than the zswap_entry.  Every entry has one pointer f=
rom
> > the xarray tree.  Overall, switching to xarray should save some memory,=
 if
> > the swap entries are densely packed.
> >
> > Notice the zswap_rb_search and zswap_rb_insert often followed by
> > zswap_rb_erase.  Use xa_erase and xa_store directly.  That saves one tr=
ee
> > lookup as well.
> >
> > Remove zswap_invalidate_entry due to no need to call zswap_rb_erase any
> > more.  Use zswap_free_entry instead.
> >
> > The "struct zswap_tree" has been replaced by "struct xarray".  The tree
> > spin lock has transferred to the xarray lock.
> >
> > Run the kernel build testing 5 times for each version, averages:
> > (memory.max=3D2GB, zswap shrinker and writeback enabled, one 50GB swapf=
ile,
> > 24 HT core, 32 jobs)
> >
> >            mm-unstable-4aaccadb5c04     xarray v9
> > user       3548.902                     3534.375
> > sys        522.232                      520.976
> > real       202.796                      200.864
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
>
> I remove the previous review tags because I like to get some review of
> the conflict resolution as well.
[..]
> > @@ -1624,20 +1562,14 @@ bool zswap_load(struct folio *folio)
> >         pgoff_t offset =3D swp_offset(swp);
> >         struct page *page =3D &folio->page;
> >         bool swapcache =3D folio_test_swapcache(folio);
> > -       struct zswap_tree *tree =3D swap_zswap_tree(swp);
> > +       struct xarray *tree =3D swap_zswap_tree(swp);
> >         struct zswap_entry *entry;
> >         u8 *dst;
> >
> >         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >
> > -       spin_lock(&tree->lock);
> > -       entry =3D zswap_rb_search(&tree->rbroot, offset);
> > -       if (!entry) {
> > -               spin_unlock(&tree->lock);
> > -               return false;
> > -       }
> >         /*
> > -        * When reading into the swapcache, invalidate our entry. The
> > +        * When reading into the swapcache, erase our entry. The
> >          * swapcache can be the authoritative owner of the page and
> >          * its mappings, and the pressure that results from having two
> >          * in-memory copies outweighs any benefits of caching the
> > @@ -1649,8 +1581,12 @@ bool zswap_load(struct folio *folio)
> >          * the fault fails. We remain the primary owner of the entry.)
> >          */
> >         if (swapcache)
> > -               zswap_rb_erase(&tree->rbroot, entry);
> > -       spin_unlock(&tree->lock);
> > +               entry =3D xa_erase(tree, offset);
> > +       else
> > +               entry =3D xa_load(tree, offset);
>
> This is the place I make the modification for the conflict resolution.
> It depends on the swapcache to execute xa_erase() or xa_load().
> Obviously, the xa_load() will not delete the entry from the tree.

The conflict resolution LGTM. If this is the only change from v8 then:

Acked-by: Yosry Ahmed <yosryahmed@google.com>

