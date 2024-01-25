Return-Path: <linux-kernel+bounces-38288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF0683BD86
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB4A294DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D40A1C6AD;
	Thu, 25 Jan 2024 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkRaez0G"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9511C29F;
	Thu, 25 Jan 2024 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175484; cv=none; b=Bd2q1wt0N8m8RYM5ZHylQh8RcrNAa5oO59C8CLZe0eJ3y81BqTL93tnnJ5SWxcu9C4Mm7MfC9mE3M3fohhB65oNLFowbtWuMS4Wv4qdUPFhD1ZykOU29TkHA4mcz6KYYl+2+EFXh46kMt54NMgG0+WwNlI1fM0fzAVcsnZojP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175484; c=relaxed/simple;
	bh=s/htPPPH8Thz98T+Ps8fKRrjVJvL7gu+39qd5dyICkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQHKegydcucVa87QT9hgJNRwzs5rI/ikR11LBnVLCEjpFeq1CWRbHYwOS8VUtvPq4h7JLi6SlC7JFrGfxZkBVw1FowgDY4FNqBG0oGwGPt1oLyKOhqCrOwsQ1O66cnCfVR1S7ISO+jw+MfELedGIUu+YSvhmJ0wmQgeMrQVs9XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkRaez0G; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf1524cb17so31926631fa.2;
        Thu, 25 Jan 2024 01:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706175480; x=1706780280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+RkNqMrCMWSlr+Yh44U7hyKXYEqjphS14jY3zThSRg=;
        b=UkRaez0GbCtvo+waidZgIOunT0UAHO+uxkl9mrw5oZAoPBWrcumYYF0YED2cDaeIlb
         Wzizw+QoRoSTxUx1D4/63cTFXaoEyGRRj8WA/1/+U58K2M/4BSQEav8jFl+/+MlLaF1e
         J4skvvWG/9RmQ5UnNorQoTkgukCgjc9y6KIdnLdZeD1MScDIYAkVaOZHvlNbzhAf5g3g
         AS8jcKEguXEW01PWrsaF55mRM8dMyWlkROxKrEmSh+kW4GnxYFeLtn6kGqgozKWUPWoM
         uSxOU+TN3ULjlBGz47IHSL/shemdGLZqQCEzXzX+2v3VjP5qEQjoGlTCAuRRyJ3pknwR
         Crow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706175480; x=1706780280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+RkNqMrCMWSlr+Yh44U7hyKXYEqjphS14jY3zThSRg=;
        b=RGISwO3YTkayxKRyp+EILZiweJuwALggHuntGfFCHiO3ylj1SCYsOSXdFSIF4fuciD
         DqX6YXgbjqW101XTRIfjnD+VQHaJdJNoPkozIl4odWuSirpCxTP5+fV05Eg1wHKHn7RF
         smNza73u+aYGVGRQXsoanl3A9TaJ9E6emNkYqPh9JOVeD86v9ps8nQbmWw7i96AnGcXm
         9JXc6HYnrwISaXqQbklFxWzkQuqj9gTWzxroO6Ggyru7jGLgD+fMzEVUbXEtxcIMN85T
         OrYnap2/ZIur1GvqOSMv1vzeHwvLvN+ecfXQi4UYDzONC/adHjQqGnAk13tockgmWr1F
         TYtA==
X-Gm-Message-State: AOJu0YxZq42Y0gfS1+16sxoLrPlvMRKetlpuPFVJTrhkvgxWv3HBF08U
	dF8Jly+64ELc8g4pkleTgNDQzVRFiZUoBHrcJsEeHQxtaCjziMzGWGrhg6b4+ZqFkt9PWIQlu3r
	4RWDb0DOMsJEd5sojU6IyJZaKf9pPih/5G8M=
X-Google-Smtp-Source: AGHT+IFQb9lHVoPdeNHadDfo2biHwzJySgJs7FG5T5F0tRJc/2lFbJsqxK/r3ISDkgkkVps3PuhohFcNDxKPVBnVh3o=
X-Received: by 2002:a2e:81c3:0:b0:2ce:fbca:606a with SMTP id
 s3-20020a2e81c3000000b002cefbca606amr357473ljg.40.1706175480409; Thu, 25 Jan
 2024 01:38:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com>
 <6b2d5694-f802-43a4-a0fd-1c8e34f8e69a@kernel.org> <CAGWkznHK5UPajY2PG24Jm7+A0c9q+tyQzrPdd=n3tp0dgX+T0w@mail.gmail.com>
 <95082224-a61d-4f4b-bc96-1beea8aa93a9@kernel.org> <CAGWkznGe+37K7_E34G_MZQXNxoLuM3E0mY=BZCGpyiq+TB_PoA@mail.gmail.com>
In-Reply-To: <CAGWkznGe+37K7_E34G_MZQXNxoLuM3E0mY=BZCGpyiq+TB_PoA@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 25 Jan 2024 17:37:49 +0800
Message-ID: <CAGWkznGJejDMZsryPpS-11mb50wMhhQe-=sNoV4_iO5ogVLtLQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/1] block: introduce content activity based ioprio
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Yu Zhao <yuzhao@google.com>, 
	Niklas Cassel <niklas.cassel@wdc.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Hannes Reinecke <hare@suse.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 5:32=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmail=
com> wrote:
>
> On Thu, Jan 25, 2024 at 4:26=E2=80=AFPM Damien Le Moal <dlemoal@kernel.or=
g> wrote:
> >
> > On 1/25/24 16:52, Zhaoyang Huang wrote:
> > > On Thu, Jan 25, 2024 at 3:40=E2=80=AFPM Damien Le Moal <dlemoal@kerne=
l.org> wrote:
> > >>
> > >> On 1/25/24 16:19, zhaoyang.huang wrote:
> > >>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >>>
> > >>> Currently, request's ioprio are set via task's schedule priority(wh=
en no
> > >>> blkcg configured), which has high priority tasks possess the privil=
ege on
> > >>> both of CPU and IO scheduling.
> > >>> This commit works as a hint of original policy by promoting the req=
uest ioprio
> > >>> based on the page/folio's activity. The original idea comes from LR=
U_GEN
> > >>> which provides more precised folio activity than before. This commi=
t try
> > >>> to adjust the request's ioprio when certain part of its folios are =
hot,
> > >>> which indicate that this request carry important contents and need =
be
> > >>> scheduled ealier.
> > >>>
> > >>> This commit is verified on a v6.6 6GB RAM android14 system via 4 te=
st cases
> > >>> by changing the bio_add_page/folio API in ext4 and f2fs.
> > >>
> > >> And as mentioned already by Chrisoph and Jens, why don't you just si=
mply set
> > >> bio->bi_ioprio to the value you want before calling submit_bio() in =
these file
> > >> systems ? Why all the hacking of the priority code for that ? That i=
s not
> > >> justified at all.
> > >>
> > >> Furthermore, the activity things reduces the ioprio hint bits to the=
 bare
> > >> minimum 3 bits necessary for command duration limits. Not great. But=
 if you
> > >> simply set the prio class based on your activity algorithm, you do n=
ot need to
> > >> change all that.
> > > That is because bio->io_prio changes during bio grows with adding
> > > different activity pages in. I have to wrap these into an API which
> > > has both of fs and block be transparent to the process.
> >
> > Pages are not added to BIOs on the fly. The FS does bio_add_page() or s=
imilar
> > (it can be a get user pages for direct IOs) and then calls bio_submit()=
 Between
> > these 2, you can set your IO priority according to how many pages you h=
ave.
> Please correct me if I am wrong. So you suggest iterating the
> request->bios->bvecs(pages) before final submit_bio? Is it too costly
> and introduces too many modifications on each fs.
> >
> > You can even likely do all of this based on the iocb (and use iocb->ki_=
ioprio to
> > set the prio), so before one starts allocating and setting up BIOs to p=
rocess
> > the user IO.
> Actually, the activity information comes from page's history (recorded
> at page cache's slot) instead of user space in step(1) and can be
> associate with bio in step(2) or iterate the bio in step(3)
>
> page fault        \
> (1)
>                               (2)                       (3)
>                           allocate_pages=3D=3D>add_page_to_page_cache(get
> activity information)=3D=3D>xxx_readpage=3D=3D>bio_add_page=3D=3D>submit_=
bio
> vfs read/write  /
The chart goes wrong again:(           change it to vertical mode
Actually, the activity information comes from page's history (recorded
at page cache's slot) instead of user space in step(1) and can be
associate with bio in step(2) or iterate the bio in step(3)
page fault(or vfs)(1)
|
alloc_pages
|
add_page_to_pagecache(get the page's activity information)
|
fs_readpage
|
bio_add_page(2)
|
submit_bio(3)

> >
> > --
> > Damien Le Moal
> > Western Digital Research
> >

