Return-Path: <linux-kernel+bounces-119997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F3688CFE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43AB1F80E28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E66313D607;
	Tue, 26 Mar 2024 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NttaDzCH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608512C7FF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488071; cv=none; b=eSmhWB09bbzgw8q3JjNxBdRFr9TEIsNJ5yx3LGJZI51hMZtRcRXmlmLoD/HeqDeRB/wHmY79zlKFPinsMAqJad5vylSa4trwmivwZex37oDi5cZPtQPQ8aEpUHmhgb1H6hOuxtbvEYLQVFqTLjy4mviQQCUECTW9wSwMdRXYiL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488071; c=relaxed/simple;
	bh=ktBOuN/l0Oqul05K8wPsro6WSmUcfgpQoRmRKkgldYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTAmsGDg1CGm6i7MgI+BBcYnr0wpbaNvqHHXWwPUvJYwbDQzQe2AujgrZJUnB2py0f5K+4UIi8gQbMZY72xzVf4dzwIJzDaADUyn5fHPgf03espnzMFsFWqmphl0YwfJVo7+LrS1sLfZVkgqSR+aVfcf3DFPWckbZIqGM7sKT2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NttaDzCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA05C43390
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711488070;
	bh=ktBOuN/l0Oqul05K8wPsro6WSmUcfgpQoRmRKkgldYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NttaDzCH0nFE8/OnuI3TFzJPM4f4n0RToHYl7crqDD6iDXABdcYvfaOrbHX8oxOgm
	 7ETBZr7GlUtIPTnxjXf7ldSCdPDFvT+aFQbKOTQst3cnqp28o36NrwF8l6GXzHnk8+
	 sWYIdYdWJYvlJFCTMKWXIFtbb6/RYrzFV13Y4tY2Htog4iqsq9PMuSXI6DM4lgABe2
	 CRm8y2XhLxUekNT1n2F6sg53tsBBY68weqyYJd3Fy8oJ34C74S6i8560gtdhQxprqD
	 GTxfkw/9CQC157sOTMqtdXEgsgVHth0xRzq26SbnOVAUI3gbqfQSVssOb1UX7P0xnz
	 l5jTa8LVFbc3A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5159f9de7fbso4503532e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:21:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnWd75udiJlESd2vXNVJ12dUP3XBmKuVvvJTUZav/hrOhH2eLEM8XvDhMvqrgPtGwV9XrdggOkVKYIB8bKNJ6gl9Xqyj1+tigX2wMa
X-Gm-Message-State: AOJu0YzL01LP0j4TMBhdXE8qRMDGSEKlA01F7hFrwnQM2VH6BZzGmy4i
	eMsfwgTAb9Q0pvaiY6I7ijm0PUbLYCU7PVxjO2qJh00xCrkh9dqRoWTv5wKY7kRUoGM8TMcmT63
	ioK2jdEGtIV/mnDFcALzJa2ikvw==
X-Google-Smtp-Source: AGHT+IG3wPYvGie/m4nkqFnR7BNbZ+T1nPhZdmhz95gFdDCYjSNPOfiAniuep2UkhdyYu4tSSvF/Ll1U2Y302My7IiE=
X-Received: by 2002:a19:5e58:0:b0:513:ccbe:d79f with SMTP id
 z24-20020a195e58000000b00513ccbed79fmr519276lfi.8.1711488069574; Tue, 26 Mar
 2024 14:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-zswap-xarray-v9-1-d2891a65dfc7@kernel.org>
 <CANeU7Q=8p4whMu+H9GXqQc4Ehjt0_kCtNdg34TiW4bWFw03dbw@mail.gmail.com> <CAKEwX=MLFaA-1kYbKT0bMuTsJDqK9ZfoJ+WUyxM4tBu_owyPYA@mail.gmail.com>
In-Reply-To: <CAKEwX=MLFaA-1kYbKT0bMuTsJDqK9ZfoJ+WUyxM4tBu_owyPYA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 26 Mar 2024 14:20:58 -0700
X-Gmail-Original-Message-ID: <CANeU7Qmr-cirRJxm7JyfoFH+d782tHCvuC6wtEBzF4bpd5aeyg@mail.gmail.com>
Message-ID: <CANeU7Qmr-cirRJxm7JyfoFH+d782tHCvuC6wtEBzF4bpd5aeyg@mail.gmail.com>
Subject: Re: [PATCH v9] zswap: replace RB tree with xarray
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry, Johannes and Nhat,

Thank you for your review. I have sent out V10 to revert the comment.

Chris

On Tue, Mar 26, 2024 at 2:04=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Mar 26, 2024 at 11:42=E2=80=AFAM Chris Li <chrisl@kernel.org> wro=
te:
> >
> > > -        * When reading into the swapcache, invalidate our entry. The
> > > +        * When reading into the swapcache, erase our entry. The
> > >          * swapcache can be the authoritative owner of the page and
> > >          * its mappings, and the pressure that results from having tw=
o
> > >          * in-memory copies outweighs any benefits of caching the
> > > @@ -1649,8 +1581,12 @@ bool zswap_load(struct folio *folio)
> > >          * the fault fails. We remain the primary owner of the entry.=
)
> > >          */
> > >         if (swapcache)
> > > -               zswap_rb_erase(&tree->rbroot, entry);
> > > -       spin_unlock(&tree->lock);
> > > +               entry =3D xa_erase(tree, offset);
> > > +       else
> > > +               entry =3D xa_load(tree, offset);
> >
> > This is the place I make the modification for the conflict resolution.
> > It depends on the swapcache to execute xa_erase() or xa_load().
> > Obviously, the xa_load() will not delete the entry from the tree.
> >
>
> The conflict resolution itself LGTM. I'll let you and Johannes decide
> on the comment (but FWIW, the original meaning still holds, so I don't
> see why we need to fix it).
>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
>

