Return-Path: <linux-kernel+bounces-50675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E61847C61
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344B6287768
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D21385958;
	Fri,  2 Feb 2024 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sr3P0jaG"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F812C7E6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913445; cv=none; b=MTqHqbAPeKtjeFA3/9DxFLls3sdCgGeyp3MkBobq8EkeNr1t4jIB/omqQyw9ZBExBgwcqcsO3Qv8MfCTWd3damLnRcMlzWT/qiF9BB+8zGgXyJsnjyIHuymxgrgAT/d3oSeQyd+HF15naaJj5wra6Gj2R5B4RG8Dg+1Eys9I5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913445; c=relaxed/simple;
	bh=SIx1VqHbNqfumaoA5D1iTckLO+Kue1rw26AGmH8iw4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4hm02DVXtJhu0DZZrQabBnSBFs4LGDkbyeuomwAW/EHsDwMtb3PjLx7PWHtT9EZP2HcNwnVUujGjiKUaVaXtD64k2J2lpUwulQLHTfcPqKNfl8BLF600HjeTVVIAjCYW8KaKASchOr00jdAoCY3Mg715QpVjNIkomuae0TIbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sr3P0jaG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a35e9161b8cso353321666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 14:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706913442; x=1707518242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=433x/1W6CeaGmua3fRLx6mYR/meu70/H/QyCZc2fg1Q=;
        b=Sr3P0jaGcXDxZyvGdujH2EDqlle/0X1Pj7YYd/B6t9HzgdQPeB9wDl3kAlxGf7m+kH
         uNmQlsJ/uS/rsdVCQanifGTqhgHUtreuupS4itFYjnvqOAgqNr1YROc04S+pjYfWctjE
         QQz2uKZsfTizHgWGyHpiYIgx3FyWC4gH4m41Q69M952fchDPw+oXHzGqkvpIlltAF6tu
         D8oIGVKh1He9xyehniUFrX256eqsGSe3Jk7pYLuW1C+VN4jNf/91qMLH3NRBPS4E2ueU
         VnUhLcxxRm5M47C0H42hSbdbRespOypeGmZKpI61vmG8Y33t2QkNKlF3JkINDZxaxLtL
         CzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706913442; x=1707518242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=433x/1W6CeaGmua3fRLx6mYR/meu70/H/QyCZc2fg1Q=;
        b=srpUBHxQq1ksSP0CtFrbiHiCyf2eKz0fBtC4beifMyRoy/y7pCxoW9Tv7mg9bPFMKU
         DOXEFORXb9PjE5so57HHwoYUI9SR2MzmwSA2Tcj2123Km30ORzGSKqRtHF8MhdiRubUz
         r8anzqV80U4bDsnbomOL49s9n9k8BnVTIERcsAEFkZxiHCeTlxlJDCRLWsZJm3vB9uQv
         ONqI4Y1vQKb0Mg0Evo/G4zsiq545YAi1jZaCE0iFRvTkDoCLf8qYa05/Ry72s4q1QofD
         m2lre2sZkzyH279H82BHg+oTW3Nb1exqJ2GbdQ9zsT7bJ+BHWnh1qPQ6U8SnJrB0XvVd
         YG7A==
X-Gm-Message-State: AOJu0Yz3xeXDwkx3Wukj9wJ/9m3KMcIyETJOQrMVFtVYQPQfz6b1VBlz
	1hGr+kRDokpyvDX/d05pHIPxCaK2q33+7nX6+RVWwAd8dv5JOYSH9WuwAC56MRV5zet0GTsEBq/
	LZMggFWW63ZSY4C84Mn0xn76mRrw/U9NO/roS
X-Google-Smtp-Source: AGHT+IELDNXRuRrhDxrQoHA/yFMI8jmugZCJXcQEnOevp62Y+WrQuSWSiuYHD2pjZhxwVXQPNHswjlGIq2qQ6ir7oQI=
X-Received: by 2002:a17:907:7747:b0:a37:5ca:3117 with SMTP id
 kx7-20020a170907774700b00a3705ca3117mr1944120ejc.11.1706913441542; Fri, 02
 Feb 2024 14:37:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-6-56ed496b6e55@bytedance.com> <CAKEwX=MOcmUjtrYOJCwh3unRT7OKdrvtR-FFdSevNf5i7z=Q=A@mail.gmail.com>
In-Reply-To: <CAKEwX=MOcmUjtrYOJCwh3unRT7OKdrvtR-FFdSevNf5i7z=Q=A@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 2 Feb 2024 14:36:43 -0800
Message-ID: <CAJD7tkb9q5FQqwUTH3kJtEcWB57Kua_RJ7zmDdq9KXgVegs=XQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm/zswap: zswap entry doesn't need refcount anymore
To: Nhat Pham <nphamcs@gmail.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 2:33=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Thu, Feb 1, 2024 at 7:50=E2=80=AFAM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> >
> > Since we don't need to leave zswap entry on the zswap tree anymore,
> > we should remove it from tree once we find it from the tree.
> >
> > Then after using it, we can directly free it, no concurrent path
> > can find it from tree. Only the shrinker can see it from lru list,
> > which will also double check under tree lock, so no race problem.
> >
> > So we don't need refcount in zswap entry anymore and don't need to
> > take the spinlock for the second time to invalidate it.
> >
> > The side effect is that zswap_entry_free() maybe not happen in tree
> > spinlock, but it's ok since nothing need to be protected by the lock.
> >
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>
> Oh this is sweet! Fewer things to keep in mind.
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
>
> > ---
> >  mm/zswap.c | 63 +++++++++++-------------------------------------------=
--------
> >  1 file changed, 11 insertions(+), 52 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index cbf379abb6c7..cd67f7f6b302 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -193,12 +193,6 @@ struct zswap_pool {
> >   *
> >   * rbnode - links the entry into red-black tree for the appropriate sw=
ap type
> >   * swpentry - associated swap entry, the offset indexes into the red-b=
lack tree
> > - * refcount - the number of outstanding reference to the entry. This i=
s needed
> > - *            to protect against premature freeing of the entry by cod=
e
> > - *            concurrent calls to load, invalidate, and writeback.  Th=
e lock
> > - *            for the zswap_tree structure that contains the entry mus=
t
> > - *            be held while changing the refcount.  Since the lock mus=
t
> > - *            be held, there is no reason to also make refcount atomic=
.
> >   * length - the length in bytes of the compressed page data.  Needed d=
uring
> >   *          decompression. For a same value filled page length is 0, a=
nd both
> >   *          pool and lru are invalid and must be ignored.
> > @@ -211,7 +205,6 @@ struct zswap_pool {
> >  struct zswap_entry {
> >         struct rb_node rbnode;
> >         swp_entry_t swpentry;
> > -       int refcount;
>
> Hah this should even make zswap a bit more space-efficient. IIRC Yosry
> has some analysis regarding how much less efficient zswap will be
> every time we add a new field to zswap entry - this should go in the
> opposite direction :)

Unfortunately in this specific case I think it won't change the size
of the allocation for struct zswap_entry anyway, but it is a step
nonetheless :)

