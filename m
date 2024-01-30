Return-Path: <linux-kernel+bounces-44951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DEA842956
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433C6292076
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D42312BF1A;
	Tue, 30 Jan 2024 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y90bWpMM"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6E12BEAA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632295; cv=none; b=iZKqyFpeLGuPFnBZU2hI6UIETcIzrfECtD7j4bxnSmxx2X6kbxXnYH2vAM/Q02Oggg9uR+NBE2KN3LxqOB7n2EQCQ0VZm4MiH3HWjHBtAoC4OSJUV/pn6ZE+pjQ1SNbkuLn3aDS97N/1+bBZ3GaYqauq8NX5aLMozfOUYdUUkyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632295; c=relaxed/simple;
	bh=NT2fSX5twVnBGuy7jNRiCkg8HZiJXCO7HcED6If46MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faDa4+QUeWcQ2iBoBNfMHyq8sc15/nSd/zNNFz1R6dOxCZbSwyPnH+022Ousr9uJG3cYIy661/xiz3fztrnupd4OVWK+sdZb5xt4zx4kNBDqjt3ss9uvvz5FimcKZ4oNWmf5jPBYNxuLa8lZ4RKyUBtvhQ/tLkvqxwB+6NXuL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y90bWpMM; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bf7e37dc60so165759939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706632293; x=1707237093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXEo6tViShoTo2n/pOYuxZCls+OeB092lEk8RbUTs/Y=;
        b=Y90bWpMM+6Ox7F0ZjGWoAJh2TXtwhQzXArp3NhrmubA+5B5azAsOURuKNt2wb44dAw
         yoRl7reqrOrsycTrSjquPrppgX7aq0RU/OwuSQ20SCD0e79jHGWpa+3UOpfxbfeCnrUY
         Vj7AUR/dgGUsvi4z0F5jt2/suOxTpqTolkwkyWqmrv6Ra/Qw7Nh6N8ZoaUpiTzju7okP
         WHkqNt5HmmT3u0V7X+2gEyZP571/BxaDG/rna2p3AKjjyXcPbcdfH7uBUA5ZKcO0r31E
         YdeG/TvQf/NazEyuwlMYBmhdjcOKX8KyFK+Q34jWM31vj654AX2yQVvdx85tedO/TWxZ
         QRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632293; x=1707237093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXEo6tViShoTo2n/pOYuxZCls+OeB092lEk8RbUTs/Y=;
        b=HNkgqLLUwIRfl0uKGhBo91HDyNKC4a4KPl+yU2PoiJSzFQldpglaBeqWWwT2V7XmBO
         NtD1BOoljzbJpjwniJAmTBVv0iohZZ0h8+cJAOaqeKlgaPjsAzvieyrf/UI6nrjb0W4E
         BIBIyq8TedczUy5n4g56BXVq6pbnlbji2hnGE+ESN0iNBmBcqtQlVJ3a8GEdRU/H6AOs
         nu0FBWSGL0jn4RKDrvNzH2sv3YMOVrMsEy2szgMZ2kKrZ4q0Q9HJPBk/JU/ml4SdaMav
         LW+HCtnNtH9qah9bJAWoDY7hzhoMvUPKqX45JShU6rGMA/MfVCWIAS5sHWQuT8ZbQYw1
         2dDA==
X-Gm-Message-State: AOJu0YzWHL1kyOYP9UT4Dg7Sg7u2fQGs9czc8VgJ71uAaZNmAQ8OQ5U0
	RV7Fg5B6vVp/F3AuK+6HpBF0+9vwhLyhldDGDg05338C5704MepmLrjK50Kfx27A9lrVkFajrPz
	BbjkROGhBl7jEaWLCmj2f9s5zozs=
X-Google-Smtp-Source: AGHT+IEqcoKNDg6fRo9g1TsD62TKjw9WEVcse47t+lCBCaCilTDcdbErOzup8HTWsyvOdH1T2bK/rEjJSC5A1LmFPRA=
X-Received: by 2002:a05:6602:35a:b0:7bf:8a64:25a6 with SMTP id
 w26-20020a056602035a00b007bf8a6425a6mr9756431iou.1.1706632292955; Tue, 30 Jan
 2024 08:31:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-6-hannes@cmpxchg.org>
 <Zbiqmi0KMo0zTJ-p@google.com>
In-Reply-To: <Zbiqmi0KMo0zTJ-p@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 08:31:22 -0800
Message-ID: <CAKEwX=NjgXOt1f1nb_T=2ZCSZMeCbTW7g5s9VejA_HzKxM-Pmw@mail.gmail.com>
Subject: Re: [PATCH 05/20] mm: zswap: clean up zswap_entry_put()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:51=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Mon, Jan 29, 2024 at 08:36:41PM -0500, Johannes Weiner wrote:
> > Remove stale comment and unnecessary local variable.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/zswap.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 0c6adaf2fdb6..7a7e8da2b4f8 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -546,15 +546,11 @@ static void zswap_entry_get(struct zswap_entry *e=
ntry)
> >       entry->refcount++;
> >  }
> >
> > -/* caller must hold the tree lock
> > -* remove from the tree and free it, if nobody reference the entry
> > -*/
> > +/* caller must hold the tree lock */
>
> We should replace all those "caller must hold the tree lock" comments
> with lockdep_assert_held() or assert_spin_locked() or something.
>
> I can send follow up patches on top if you don't want to resend this
> series.

Agree. There's also this:

/* should be called under RCU */
#ifdef CONFIG_MEMCG
static inline struct mem_cgroup *mem_cgroup_from_entry(struct
zswap_entry *entry)
{
return entry->objcg ? obj_cgroup_memcg(entry->objcg) : NULL;
}

which you pointed out in the per-cgroup zswap LRU review :)


>
> >  static void zswap_entry_put(struct zswap_entry *entry)
> >  {
> > -     int refcount =3D --entry->refcount;
> > -
> > -     WARN_ON_ONCE(refcount < 0);
> > -     if (refcount =3D=3D 0) {
> > +     WARN_ON_ONCE(!entry->refcount);
> > +     if (--entry->refcount =3D=3D 0) {
> >               WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
> >               zswap_entry_free(entry);
> >       }
> > --
> > 2.43.0
> >

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

