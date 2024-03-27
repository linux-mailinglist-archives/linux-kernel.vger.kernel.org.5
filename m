Return-Path: <linux-kernel+bounces-120171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF8988D3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E998B1F24295
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6351BDDB;
	Wed, 27 Mar 2024 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia9kcfKB"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E563DAC0D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711502774; cv=none; b=J29+O8DXy1QvfAhYdFS0TKjwGfj3dx85r1+RH1DX0acrXr7kXdOkP1v88YESddWgpQvfFYLXVlHgV3fQt9ZcpX7EXnrj9h48/HPnQ0jP/ze6vQligW4aYqUbJzCVUfObnGIgu/hdQqwpK2ouxCH5OSZJjuUJWJ0nQwWzzCbsAaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711502774; c=relaxed/simple;
	bh=GqzERt7Hb1xZRdLM5Wl2ICX6XNGzv9UMGiH4kpKGUN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkUizqeSx+7NyOYPWXsq1rnFqOW5allin8u/7W63JNBcXgs9+4zACYoHhwzNhrpMOsdEAUurUCUH/m2QICau9KSI0alDrYQLPx63DzPJuFhiXk44/3c9u9w2e/Wv83tv6g2bDeofL/t/XtRQx7SIqoQe6Ues3mbQUDrYx7nkhnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia9kcfKB; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d41d1bedc9so115764781fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711502771; x=1712107571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYZGEUhGrOB0Ufj0v9g5JNZSmjlSrrhBE0eNJdDGR9E=;
        b=ia9kcfKBZ8l6ONDZLL3qCJ4+aKAu1mOY1DxsoxUt1GIoTjOidaZ9dW7NLaKYL6v5z1
         n6BVk1mR2laxDf2HukNLuA/eB+I6W/2dSDPlSegJJ9QC80TAE5lXhvX4rWBJi4Kv+cF2
         X4euRrn+m8B1NHUq87sByRCaQPsXtrOsVYiPgDb2CXQhJMdnH6ij7jlvmYxIUWW3V5Bu
         eJ0g9sFc1NOjln4QbEheVRVmCMEmS9y7vcSmDnuBlc/TXZ4FjzUFhB1suIc++AyHoS85
         wBCy82panD5kDrkSZiOJX9Oz4Pu180y0Bt8KVdWCXi2DOqR3P/ah7F5bTVAoZGrGhpXn
         JPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711502771; x=1712107571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYZGEUhGrOB0Ufj0v9g5JNZSmjlSrrhBE0eNJdDGR9E=;
        b=nzUuF6XWBAAEJv2EiwpB2nTGwgkzwCx5gptCwn4iSMnclYy5adohhcbvsUUX7Bn0n9
         Eo4TvmdpHQc6tgsB5qGFoiWZuUTrbxvlCj/cHXfo03kKXnusX+5n03MLCYDx3bDpKRSq
         tTH/iDH9ZU/EW10QQpI337yDR+EJqK2NbM9TDpw5AzgWlwUaq/17yjY0kyqpJKF49PBn
         yWR4YQq34HnrWjMgURq7QvtWC5BIux2OQe/JIKBMwZEaxAoBQp7tzYGdb0a9gZwHbWAM
         MeEeMk+tWv5UiDdgrL4amnZWUHeRD3NPu9vgPBGnyh/QSyVZwpxgbLtjPUv23EFNsm5n
         A0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCV8rcMh2QtTZCBaFl8G8T6xx0EChdbHkMkTjOji761NO7Z6EP1z2huYUJ9yb6m/vNJI9/aEVer+5K5sdP7x5VdzRzVt9rRt+NY+VND4
X-Gm-Message-State: AOJu0Yw1aLAVOb5dNNUsm2gMVvy/FdzcVxbgkjc3jBdum3QFXq8grQ9n
	+AkqNEW6P/Ki9oebYQKrhv3uQSOLkPmTAYMqbMjFvUpTZtm6UiAJ5lC4o4G0lh8bwJdY72dl26K
	dCwqX4JfvHS2jLix5GaQr8EXjNBkW44Aj8qo=
X-Google-Smtp-Source: AGHT+IF+O4i8zpoAQA7aYuTcNBW+pg4KvRZb+Abnui5XaAN9wtwyKuIDJxnHBeFHRZlOFJO74wtcAsI79petfkTvJNk=
X-Received: by 2002:a2e:9c92:0:b0:2d6:f793:3434 with SMTP id
 x18-20020a2e9c92000000b002d6f7933434mr513418lji.2.1711502770816; Tue, 26 Mar
 2024 18:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfg0WLrcOmCtdn_M@casper.infradead.org> <CAGWkznGhiuzkqfeewNq-ykKehvFTBjH2v_==xAS2_7iFqsFk5A@mail.gmail.com>
 <Zfj_-LbiIsAVWcPX@casper.infradead.org> <CAGWkznHOWVPpKHOuvvDF2zppkTT0_x4WyJ5S75j+EghhZmEDdg@mail.gmail.com>
 <ZfwpuRjAZV07_lc3@casper.infradead.org> <CAGWkznFtez1fj2L2CtFnA5k-Tn4WtxmDOw=fjOWPg-ZGJX=VWw@mail.gmail.com>
 <Zfz4_GJAHRInB8ul@casper.infradead.org> <CAGWkznEzpcWi4oXVn_WFahnQj3dHcwc_4VW6m1Ss-KJ8mD3F3Q@mail.gmail.com>
 <ZgDt9mwN-Py5Y-xr@casper.infradead.org> <CAGWkznHO27EpVVpFyKnv-SX-JTYCXQxb0MG+EW07gaupocR4RQ@mail.gmail.com>
 <ZgK91II_eSYY6D2F@casper.infradead.org>
In-Reply-To: <ZgK91II_eSYY6D2F@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 27 Mar 2024 09:25:59 +0800
Message-ID: <CAGWkznGLySzLE17+rCe=UoA26vx=iM375o2zkruKM9ssG05QzA@mail.gmail.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 8:21=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Mar 26, 2024 at 05:06:55PM +0800, Zhaoyang Huang wrote:
> > 1. Thread_readahead remove the folio from page cache and drop 2 refcnt
> > by readahead_folio & filemap_remove_folio(get rid of the folios which
> > failed to launch IO during readahead)
> >     refcnt =3D=3D 0, PG_lru =3D=3D true, PG_lock =3D=3D true
> >     read_pages
> > ...
> >         folio =3D readahead_folio
> >         <one refcnt dropped here>
> > ********For the folio which can not launch IO, we should NOT drop
> > refcnt here??? replaced by __readahead_folio???**********
> >         folio_get
> >         filemap_remove_folio(folio)
> >         folio_unlock
> >         <one refcnt dropped here>
> >         folio_put
>
> Ignoring any other thread, you're basically saying that there's a
> refcount imbalance here.  Which means we'd hit an assert (that folio
> refcount went below zero) in the normal case where another thread wasn't
> simultaneously trying to do anything.
Theoretically Yes but it is rare in practice as aops->readahead will
launch all pages to IO under most scenarios.

read_pages
    aops->readahead[1]
..
    while (folio =3D readahead_folio)[2]
        filemap_remove_folio

IMO, according to the comments of readahead_page, the refcnt
represents page cache dropped in [1] makes sense for two reasons, '1.
The folio is going to do IO and is locked until IO done;2. The refcnt
will be added back when found again from the page cache and then serve
for PTE or vfs' while it doesn't make sense in [2] as the refcnt of
page cache will be dropped in filemap_remove_folio

 * Context: The page is locked and has an elevated refcount.  The caller
 * should decreases the refcount once the page has been submitted for I/O
 * and unlock the page once all I/O to that page has completed.
 * Return: A pointer to the next page, or %NULL if we are done.

