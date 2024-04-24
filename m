Return-Path: <linux-kernel+bounces-157688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BDA8B149E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53EA6B213B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF52156881;
	Wed, 24 Apr 2024 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ttse6SKn"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4C9143888
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990857; cv=none; b=N0Uyu9Ij+14e37QA5DUrKjboIg0/QoDQGJkGudc3KrDMFidFvLcg7iqw1mLSkGyw+uAF3ClKF94VI7I2PnnPuqfDRsEkvq1OXojvlfQFT5su/pTGq/2Ni0j4NJeJdbTWq0wFupBikMQwropy6Yq5Ef3jRNLCrPfKYeexuhEoBGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990857; c=relaxed/simple;
	bh=N4tR1OCvxXlmqdsmBOe02z1y7xWXGhLUQ3ZnQ2QDSls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+qA+uyoDCAa/xji9fOMv09AAIcwsKcXrRgO2iG0M9jaMEtE5oQ0YguGkwJHzsd3Jydp2GtOyXmRaAP8y2bpxp+bGf78z+QXXEg7AGyN3JPHrOBf1IHSyYmSqNndkVvP4ZGtUlR42yu/6XS370EC1j6whIzS5ij4BsgtXhuI2eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ttse6SKn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b21ed19f6so2028625e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713990854; x=1714595654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3lACvsZ6zPvEprpO/EkNnTnrMAczxl+qNGhSvuhv70=;
        b=Ttse6SKnVtu+sxNMgF0lVhMX8EFKhmhtY952CUKIeahe5ZK+fSyyln/yGuxig8MeZK
         I/bXG7xEME2GqtZMen60ZzfSc2sY7QyMxrazC5HrLcgnCunwrj4Ur2kteMaS+SCuz8DA
         0ifL5eqFiD2XHYGJEq0SDl2FSWRkMSGmlrJJgeGpxjd2xOEaSHrBZfDhq7aqrNIoJcr/
         r1dFN+fPJgnOwHEr9YRvhaH6Dz+udEi6KXa7TZCzN7aVTHbekq+A/N1BXHyLkq70IWQd
         BmPV45uDfXBAOCjNihIOVq6c5jt1A6kTVn/EiIMojlVQeG5TIF2bVCiKTOGs/pwGzD3b
         t88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713990854; x=1714595654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3lACvsZ6zPvEprpO/EkNnTnrMAczxl+qNGhSvuhv70=;
        b=gMwezw7EDNhy6ourcluglPKku+ytMwm0TpVYcekyfFswW00nak7FZ3yxYVZXPsH1mI
         D9Nn2e1BdJPLNQ3VCCIceMkJpjJy9UrIbsoFB/WFCLwBu08jA6gxhBnbDzPTc2+K5wM0
         Xc6YswYYI6kvM6W6x/hzUX+FlBJtY8WWWRgxrFvXEdzoOIyPb9YqI58iV1Ln/RwK7FSF
         yl3GHDIu2eILbsVCWPW/0OZqY1yC8F+HqcoSLWZf8YdYPRBt9Zfa4Udk2RfOv790UQg5
         o0izS+khRjmpHAFaix2xohf2iAbVIgI6dRPGBq0tRua5oVTemyIZTJmljH19OkEenid1
         Rt2g==
X-Forwarded-Encrypted: i=1; AJvYcCXDThTpAL6jhZPmYxcn+ix1GqIsmCD8GwoVMv30YZ+RHDW17v8cGLPI6xV6Y6xE2rq4S/KYxlSdWzyfBY7pOSKF85825QCUf+kNHFcp
X-Gm-Message-State: AOJu0Yy82iLxBrlixQWPI7sb2DgBq8twUNV1lp9pfi/u6VCMl3wD0xKY
	q/Fpvfm8R/MobR/0fg6JfTHCkFl/5e2PkiO3W7sj6D8mMJUof1MffkLCIwuVcrT6Mkf/Gnxywuh
	Pn1gi0DuKSO5Su+a2bPA8QKu9s8MeD6mqElj/
X-Google-Smtp-Source: AGHT+IEpGQsy2wCErtKmtKEcA5NEcY+P1tgXlC5lhSeZkEfEoz+zEFlVXQM5BLNFUYcyPkWe/W0nWNsRNvjlNv9w/5k=
X-Received: by 2002:a5d:4dcd:0:b0:34b:4afc:5d52 with SMTP id
 f13-20020a5d4dcd000000b0034b4afc5d52mr2870877wru.9.1713990854243; Wed, 24 Apr
 2024 13:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424123935.2f65e886@canb.auug.org.au> <20240424130757.531be2842c505a62246d180c@linux-foundation.org>
 <ZilrutXaEB0laSvr@kernel.org>
In-Reply-To: <ZilrutXaEB0laSvr@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Apr 2024 13:33:58 -0700
Message-ID: <CAJuCfpFmZmw-CW17OWjmxzh5BdXsc7a_1HcdEL7kmLTZDpU5kw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the modules tree with the mm tree
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 1:31=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Wed, Apr 24, 2024 at 01:07:57PM -0700, Andrew Morton wrote:
> > On Wed, 24 Apr 2024 12:39:35 +1000 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
> >
> > > Hi all,
> > >
> > > Today's linux-next merge of the modules tree got a conflict in:
> > >
> > >   kernel/module/main.c
> > >
> > > between commits:
> > >
> > >   7f014cdda4cb ("lib: code tagging module support")
> > >   5ab9b0c7ea5c ("lib: prevent module unloading if memory is not freed=
")
> > >
> > > from the mm-unstable branch of the mm tree and commits:
> > >
> > >   0746f9982603 ("module: make module_memory_{alloc,free} more self-co=
ntained")
> > >   18da532eefc8 ("mm/execmem, arch: convert remaining overrides of mod=
ule_alloc to execmem")
> > >
> > > from the modules tree.
> > >
> > > I fixed it up (I think, see below) and can carry the fix as
> > > necessary. This is now fixed as far as linux-next is concerned, but a=
ny
> > > non trivial conflicts should be mentioned to your upstream maintainer
> > > when your tree is submitted for merging.  You may also want to consid=
er
> > > cooperating with the maintainer of the conflicting tree to minimise a=
ny
> > > particularly complex conflicts.
> >
> > That's a shame.  I don't see much that we can do to reduce the damage h=
ere.
>
> I can rebase it on mm-unstable and this can go via the mm tree.

Conflict resolution looks fine to me. I'll run relevant tests on
linux-next within 2 hours.

>
> > Suren&Kent, please review (and preferably) test Stephen's handiwork in
> > linux-next?
> >
>
> --
> Sincerely yours,
> Mike.

