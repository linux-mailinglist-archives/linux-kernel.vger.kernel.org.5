Return-Path: <linux-kernel+bounces-23121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 585F782A7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EDD6B21C46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6615663;
	Thu, 11 Jan 2024 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TH6tqag8"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896E463B8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e43e55b87so22405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 23:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704956573; x=1705561373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WYAM1bYgAfj3ld0VQHITfABWUOE74KnB1vAcBm8EUIQ=;
        b=TH6tqag86jvhPP8KHtuUd57hSmXP7rD7j0XwkLVEADOrJR0NTcIzD1/FqXXqplwEIb
         zb1/vDBOK57Aas4QdgJDDcqV9nyCo8kKoLsc6mb9o23O7lGS4N+DJ3+IwuFguu9/qmA8
         oOOeqEsHaZRubdEg+UrPgJCX1dFu8VbxsgyzBWpT9qsBG6BHOtcZ/5Dt6gAHcjZdTrhw
         0WrxxWfidD+8Nz1txfOyCnFipjdvPzkDTydsAga3GR+BMID9ZuqiMGXecm9CthXdr0S1
         DWfTdMVhKEt5ZnF+8Jn7MSeFPvoH5/bdtbXtmZKMKGjMuWtvNfAIWUV+ltd5cpWVEzgx
         d1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704956573; x=1705561373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYAM1bYgAfj3ld0VQHITfABWUOE74KnB1vAcBm8EUIQ=;
        b=uBZMTk8ruAnAUqRtjwLd/P4lnga8zwTqDPPROutg7/kdpcx6NxH1io2Ei1jKujPpYx
         9q++wYj2QRcUuRGK1h6p+Vqc4i+bLwKsdjDViGF9rM5GkY98sTEB04+Tu2w0aV6TO2jX
         hnYVw1zFt3AT05Dhtrm14lSvGw20mTtLEzysq8EgdVbvTBIJ054W7diIbOegO3omZITu
         XmkXCpWs+ikuWeOmljLUEZEYjgJKkQzHJBk8eQMYj1M25u/iZyqhD55wlZyB81I2p7jm
         r1ZNqC4LZaGZo4x7AoYV+sjXvrlqOSjpTHhrydeaw/ebGgcEOoh7Ip6kG76NyXdaTmH8
         xjyQ==
X-Gm-Message-State: AOJu0YxkjxTPeEShhgNG6jCpHhLVy16AQIKpNPCMQqJwMByPQqSljrSe
	Sjl6G8BPa7W6fF70GIOOmkgCRtnTGtjqUxCzuNnOrNWltkbi
X-Google-Smtp-Source: AGHT+IE3+1E0YQQ38Q2JMgA11Qp5oCyyq8h5GGB8CHEluK59hLYlT1/fPAcM52zaIiRNAGdGNf6qk6ggQfM0Ypz8taY=
X-Received: by 2002:a05:600c:4750:b0:40e:5274:e2ba with SMTP id
 w16-20020a05600c475000b0040e5274e2bamr42969wmo.4.1704956572152; Wed, 10 Jan
 2024 23:02:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208061407.2125867-1-yuzhao@google.com> <CAMgjq7BTaV5OvHNjGRVJP2VDxj+PXhfd6957CjS4BJ9J4OY8HA@mail.gmail.com>
 <CAOUHufYwZAUaJh6i8Fazc4gVMSqcsz9JbRNpj0cpx2qR+bZBFw@mail.gmail.com>
 <CAMgjq7AtceR-CXnKFfQHM3qi0y4oGyJ4_sw_uh5EkpXCBzkCXg@mail.gmail.com>
 <CAMgjq7CJ3hYHysyRfHzYU4hOYqhUOttxMYGtg0FxzM_wvvyhFA@mail.gmail.com>
 <CAOUHufa=ybd-EPos9DryLHYyhphN0P7qyV5NY3Pui0dfVSk9tQ@mail.gmail.com>
 <ZXpx0K8Vdo3FJixg@google.com> <CAMgjq7CRf4iEKuW2qWKzbhssMbixBo3UoLPqsSk4b+Tvw8at8A@mail.gmail.com>
 <CAOUHufY6x_Erz02Bzoejfs_g2hcmrMFpiOdjiaWZ97oirz71aQ@mail.gmail.com>
 <ZXvcgyjTu92Qqk5X@google.com> <CAMgjq7BsY1tJeOZwSppxUN7Lha-_a7WLfhv1_bxTuU4EuiQyVg@mail.gmail.com>
 <CAOUHufZFkdDjCdQKBV5+W_bp_7x5VwrwkYbJeDdQ19S=m4Mc6A@mail.gmail.com>
 <CAOUHufbRq8WsGzNRn119GqL5AmeSOkZxQv3L2LTaCm=k3bzrRA@mail.gmail.com>
 <CAMgjq7C8uUOz5i8rEHNCs37fdEiAuMZsuV+Ktnz3TMX9Nf8F+g@mail.gmail.com>
 <CAOUHufamzdOL8ByV9V7KQJKnvZBMboVz-EGD=Fus7LZk1inhCw@mail.gmail.com>
 <CAOUHufaWkAvQK_fmXF5WZW4ZKQ0W4UZfjWDG+OZAxgF_J0dOuA@mail.gmail.com>
 <CAMgjq7BR4wyT5itvs58Wjar6EymdazhKvpAjSPHF-SYvrguu2Q@mail.gmail.com>
 <CAOUHufbZTJN6TRv55DVDjMp3frqpJOZP0HsQx3Y7veGCuaih8g@mail.gmail.com>
 <CAMgjq7C+zMYtoE=JVsXZitxKHoCh5MqB76OENs7a+NDgGGQ0Kw@mail.gmail.com>
 <CAOUHufbnLX60n+=OV92kXLZGY5_-f_y0ZtETV+0uTqFo5dvBCg@mail.gmail.com>
 <CAOUHufa12C7Knp78fq4C-ohGz1yrtdriW5xQD=wchinTJD8UVQ@mail.gmail.com> <CAMgjq7BRaRgYLf2+8=+=nWtzkrHFKmudZPRm41PR6W+A+L=AKA@mail.gmail.com>
In-Reply-To: <CAMgjq7BRaRgYLf2+8=+=nWtzkrHFKmudZPRm41PR6W+A+L=AKA@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 11 Jan 2024 00:02:14 -0700
Message-ID: <CAOUHufahuWcKf5f1Sg3emnqX+cODuR=2TQo7T4Gr-QYLujn4RA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/mglru: fix underprotected page cache
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>, 
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d7cb50060ea62231"

--000000000000d7cb50060ea62231
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 12:16=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8826=E6=97=A5=
=E5=91=A8=E4=BA=8C 06:01=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Dec 25, 2023 at 2:52=E2=80=AFPM Yu Zhao <yuzhao@google.com> wro=
te:
> > >
> > > On Mon, Dec 25, 2023 at 5:03=E2=80=AFAM Kairui Song <ryncsn@gmail.com=
> wrote:
> > > >
> > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=B8=80 14:30=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > On Wed, Dec 20, 2023 at 1:24=E2=80=AFAM Kairui Song <ryncsn@gmail=
com> wrote:
> > > > > >
> > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=B8=89 16:17=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >
> > > > > > > On Tue, Dec 19, 2023 at 11:38=E2=80=AFPM Yu Zhao <yuzhao@goog=
le.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Dec 19, 2023 at 11:58=E2=80=AFAM Kairui Song <ryncs=
n@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=
=9C=8819=E6=97=A5=E5=91=A8=E4=BA=8C 11:45=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > >
> > > > > > > > > > On Mon, Dec 18, 2023 at 8:21=E2=80=AFPM Yu Zhao <yuzhao=
@google.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Dec 18, 2023 at 11:05=E2=80=AFAM Kairui Song =
<ryncsn@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B41=
2=E6=9C=8815=E6=97=A5=E5=91=A8=E4=BA=94 12:56=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, Dec 14, 2023 at 04:51:00PM -0700, Yu Zhao=
 wrote:
> > > > > > > > > > > > > > On Thu, Dec 14, 2023 at 11:38=E2=80=AFAM Kairui=
 Song <ryncsn@gmail.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=
=B9=B412=E6=9C=8814=E6=97=A5=E5=91=A8=E5=9B=9B 11:09=E5=86=99=E9=81=93=EF=
=BC=9A
> > > > > > > > > > > > > > > > On Wed, Dec 13, 2023 at 12:59:14AM -0700, Y=
u Zhao wrote:
> > > > > > > > > > > > > > > > > On Tue, Dec 12, 2023 at 8:03=E2=80=AFPM K=
airui Song <ryncsn@gmail.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Kairui Song <ryncsn@gmail.com> =E4=BA=
=8E2023=E5=B9=B412=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C 14:52=E5=86=99=E9=
=81=93=EF=BC=9A
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E=
2023=E5=B9=B412=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C 06:07=E5=86=99=E9=81=
=93=EF=BC=9A
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Fri, Dec 8, 2023 at 1:24=E2=80=
=AFAM Kairui Song <ryncsn@gmail.com> wrote:
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=
=BA=8E2023=E5=B9=B412=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=94 14:14=E5=86=99=
=E9=81=93=EF=BC=9A
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Unmapped folios accessed throug=
h file descriptors can be
> > > > > > > > > > > > > > > > > > > > > > underprotected. Those folios ar=
e added to the oldest generation based
> > > > > > > > > > > > > > > > > > > > > > on:
> > > > > > > > > > > > > > > > > > > > > > 1. The fact that they are less =
costly to reclaim (no need to walk the
> > > > > > > > > > > > > > > > > > > > > >    rmap and flush the TLB) and =
have less impact on performance (don't
> > > > > > > > > > > > > > > > > > > > > >    cause major PFs and can be n=
on-blocking if needed again).
> > > > > > > > > > > > > > > > > > > > > > 2. The observation that they ar=
e likely to be single-use. E.g., for
> > > > > > > > > > > > > > > > > > > > > >    client use cases like Androi=
d, its apps parse configuration files
> > > > > > > > > > > > > > > > > > > > > >    and store the data in heap (=
anon); for server use cases like MySQL,
> > > > > > > > > > > > > > > > > > > > > >    it reads from InnoDB files a=
nd holds the cached data for tables in
> > > > > > > > > > > > > > > > > > > > > >    buffer pools (anon).
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > However, the oldest generation =
can be very short lived, and if so, it
> > > > > > > > > > > > > > > > > > > > > > doesn't provide the PID control=
ler with enough time to respond to a
> > > > > > > > > > > > > > > > > > > > > > surge of refaults. (Note that t=
he PID controller uses weighted
> > > > > > > > > > > > > > > > > > > > > > refaults and those from evicted=
 generations only take a half of the
> > > > > > > > > > > > > > > > > > > > > > whole weight.) In other words, =
for a short lived generation, the
> > > > > > > > > > > > > > > > > > > > > > moving average smooths out the =
spike quickly.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > To fix the problem:
> > > > > > > > > > > > > > > > > > > > > > 1. For folios that are already =
on LRU, if they can be beyond the
> > > > > > > > > > > > > > > > > > > > > >    tracking range of tiers, i.e=
, five accesses through file
> > > > > > > > > > > > > > > > > > > > > >    descriptors, move them to th=
e second oldest generation to give them
> > > > > > > > > > > > > > > > > > > > > >    more time to age. (Note that=
 tiers are used by the PID controller
> > > > > > > > > > > > > > > > > > > > > >    to statistically determine w=
hether folios accessed multiple times
> > > > > > > > > > > > > > > > > > > > > >    through file descriptors are=
 worth protecting.)
> > > > > > > > > > > > > > > > > > > > > > 2. When adding unmapped folios =
to LRU, adjust the placement of them so
> > > > > > > > > > > > > > > > > > > > > >    that they are not too close =
to the tail. The effect of this is
> > > > > > > > > > > > > > > > > > > > > >    similar to the above.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Android, launching 55 apps s=
equentially:
> > > > > > > > > > > > > > > > > > > > > >                            Befo=
re     After      Change
> > > > > > > > > > > > > > > > > > > > > >   workingset_refault_anon  2564=
1024   25598972   0%
> > > > > > > > > > > > > > > > > > > > > >   workingset_refault_file  1150=
16834  106178438  -8%
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Hi Yu,
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Thanks you for your amazing works=
 on MGLRU.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > I believe this is the similar iss=
ue I was trying to resolve previously:
> > > > > > > > > > > > > > > > > > > > > https://lwn.net/Articles/945266/
> > > > > > > > > > > > > > > > > > > > > The idea is to use refault distan=
ce to decide if the page should be
> > > > > > > > > > > > > > > > > > > > > place in oldest generation or som=
e other gen, which per my test,
> > > > > > > > > > > > > > > > > > > > > worked very well, and we have bee=
n using refault distance for MGLRU in
> > > > > > > > > > > > > > > > > > > > > multiple workloads.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > There are a few issues left in my=
 previous RFC series, like anon pages
> > > > > > > > > > > > > > > > > > > > > in MGLRU shouldn't be considered,=
 I wanted to collect feedback or test
> > > > > > > > > > > > > > > > > > > > > cases, but unfortunately it seems=
 didn't get too much attention
> > > > > > > > > > > > > > > > > > > > > upstream.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > I think both this patch and my pr=
evious series are for solving the
> > > > > > > > > > > > > > > > > > > > > file pages underpertected issue, =
and I did a quick test using this
> > > > > > > > > > > > > > > > > > > > > series, for mongodb test, refault=
 distance seems still a better
> > > > > > > > > > > > > > > > > > > > > solution (I'm not saying these tw=
o optimization are mutually exclusive
> > > > > > > > > > > > > > > > > > > > > though, just they do have some co=
nflicts in implementation and solving
> > > > > > > > > > > > > > > > > > > > > similar problem):
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Previous result:
> > > > > > > > > > > > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > > > > > > > > > > > > > > > > > Execution Results after 905 secon=
ds
> > > > > > > > > > > > > > > > > > > > > ---------------------------------=
---------------------------------
> > > > > > > > > > > > > > > > > > > > >                   Executed       =
 Time (=C2=B5s)       Rate
> > > > > > > > > > > > > > > > > > > > >   STOCK_LEVEL     2542           =
 27121571486.2   0.09 txn/s
> > > > > > > > > > > > > > > > > > > > > ---------------------------------=
---------------------------------
> > > > > > > > > > > > > > > > > > > > >   TOTAL           2542           =
 27121571486.2   0.09 txn/s
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > This patch:
> > > > > > > > > > > > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > > > > > > > > > > > > > > > > > Execution Results after 900 secon=
ds
> > > > > > > > > > > > > > > > > > > > > ---------------------------------=
---------------------------------
> > > > > > > > > > > > > > > > > > > > >                   Executed       =
 Time (=C2=B5s)       Rate
> > > > > > > > > > > > > > > > > > > > >   STOCK_LEVEL     1594           =
 27061522574.4   0.06 txn/s
> > > > > > > > > > > > > > > > > > > > > ---------------------------------=
---------------------------------
> > > > > > > > > > > > > > > > > > > > >   TOTAL           1594           =
 27061522574.4   0.06 txn/s
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Unpatched version is always aroun=
d ~500.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Thanks for the test results!
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > I think there are a few points he=
re:
> > > > > > > > > > > > > > > > > > > > > - Refault distance make use of pa=
ge shadow so it can better
> > > > > > > > > > > > > > > > > > > > > distinguish evicted pages of diff=
erent access pattern (re-access
> > > > > > > > > > > > > > > > > > > > > distance).
> > > > > > > > > > > > > > > > > > > > > - Throttled refault distance can =
help hold part of workingset when
> > > > > > > > > > > > > > > > > > > > > memory is too small to hold the w=
hole workingset.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > So maybe part of this patch and t=
he bits of previous series can be
> > > > > > > > > > > > > > > > > > > > > combined to work better on this i=
ssue, how do you think?
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > I'll try to find some time this wee=
k to look at your RFC. It'd be a
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Hi Yu,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I'm working on V4 of the RFC now, which=
 just update some comments, and
> > > > > > > > > > > > > > > > > > skip anon page re-activation in refault=
 path for mglru which was not
> > > > > > > > > > > > > > > > > > very helpful, only some tiny adjustment=
.
> > > > > > > > > > > > > > > > > > And I found it easier to test with fio,=
 using following test script:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > #!/bin/bash
> > > > > > > > > > > > > > > > > > swapoff -a
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > modprobe brd rd_nr=3D1 rd_size=3D167772=
16
> > > > > > > > > > > > > > > > > > mkfs.ext4 /dev/ram0
> > > > > > > > > > > > > > > > > > mount /dev/ram0 /mnt
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > mkdir -p /sys/fs/cgroup/benchmark
> > > > > > > > > > > > > > > > > > cd /sys/fs/cgroup/benchmark
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > echo 4G > memory.max
> > > > > > > > > > > > > > > > > > echo $$ > cgroup.procs
> > > > > > > > > > > > > > > > > > echo 3 > /proc/sys/vm/drop_caches
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > fio -name=3Dmglru --numjobs=3D12 --dire=
ctory=3D/mnt --size=3D1024m \
> > > > > > > > > > > > > > > > > >           --buffered=3D1 --ioengine=3Di=
o_uring --iodepth=3D128 \
> > > > > > > > > > > > > > > > > >           --iodepth_batch_submit=3D32 -=
-iodepth_batch_complete=3D32 \
> > > > > > > > > > > > > > > > > >           --rw=3Drandread --random_dist=
ribution=3Dzipf:0.5 --norandommap \
> > > > > > > > > > > > > > > > > >           --time_based --ramp_time=3D5m=
 --runtime=3D5m --group_reporting
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > zipf:0.5 is used here to simulate a cac=
hed read with slight bias
> > > > > > > > > > > > > > > > > > towards certain pages.
> > > > > > > > > > > > > > > > > > Unpatched 6.7-rc4:
> > > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > > >    READ: bw=3D6548MiB/s (6866MB/s), 654=
8MiB/s-6548MiB/s
> > > > > > > > > > > > > > > > > > (6866MB/s-6866MB/s), io=3D1918GiB (2060=
GB), run=3D300001-300001msec
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Patched with RFC v4:
> > > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > > >    READ: bw=3D7270MiB/s (7623MB/s), 727=
0MiB/s-7270MiB/s
> > > > > > > > > > > > > > > > > > (7623MB/s-7623MB/s), io=3D2130GiB (2287=
GB), run=3D300001-300001msec
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Patched with this series:
> > > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > > >    READ: bw=3D7098MiB/s (7442MB/s), 709=
8MiB/s-7098MiB/s
> > > > > > > > > > > > > > > > > > (7442MB/s-7442MB/s), io=3D2079GiB (2233=
GB), run=3D300002-300002msec
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > MGLRU off:
> > > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > > >    READ: bw=3D6525MiB/s (6842MB/s), 652=
5MiB/s-6525MiB/s
> > > > > > > > > > > > > > > > > > (6842MB/s-6842MB/s), io=3D1912GiB (2052=
GB), run=3D300002-300002msec
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > - If I change zipf:0.5 to random:
> > > > > > > > > > > > > > > > > > Unpatched 6.7-rc4:
> > > > > > > > > > > > > > > > > > Patched with this series:
> > > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > > >    READ: bw=3D5975MiB/s (6265MB/s), 597=
5MiB/s-5975MiB/s
> > > > > > > > > > > > > > > > > > (6265MB/s-6265MB/s), io=3D1750GiB (1879=
GB), run=3D300002-300002msec
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Patched with RFC v4:
> > > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > > >    READ: bw=3D5987MiB/s (6278MB/s), 598=
7MiB/s-5987MiB/s
> > > > > > > > > > > > > > > > > > (6278MB/s-6278MB/s), io=3D1754GiB (1883=
GB), run=3D300001-300001msec
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Patched with this series:
> > > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > > >    READ: bw=3D5839MiB/s (6123MB/s), 583=
9MiB/s-5839MiB/s
> > > > > > > > > > > > > > > > > > (6123MB/s-6123MB/s), io=3D1711GiB (1837=
GB), run=3D300001-300001msec
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > MGLRU off:
> > > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > > >    READ: bw=3D5689MiB/s (5965MB/s), 568=
9MiB/s-5689MiB/s
> > > > > > > > > > > > > > > > > > (5965MB/s-5965MB/s), io=3D1667GiB (1790=
GB), run=3D300003-300003msec
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > fio uses ramdisk so LRU accuracy will h=
ave smaller impact. The Mongodb
> > > > > > > > > > > > > > > > > > test I provided before uses a SATA SSD =
so it will have a much higher
> > > > > > > > > > > > > > > > > > impact. I'll provides a script to setup=
 the test case and run it, it's
> > > > > > > > > > > > > > > > > > more complex to setup than fio since in=
volving setting up multiple
> > > > > > > > > > > > > > > > > > replicas and auth and hundreds of GB of=
 test fixtures, I'm currently
> > > > > > > > > > > > > > > > > > occupied by some other tasks but will t=
ry best to send them out as
> > > > > > > > > > > > > > > > > > soon as possible.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Thanks! Apparently your RFC did show bett=
er IOPS with both access
> > > > > > > > > > > > > > > > > patterns, which was a surprise to me beca=
use it had higher refaults
> > > > > > > > > > > > > > > > > and usually higher refautls result in wor=
se performance.
> > > > > > > > > > > > >
> > > > > > > > > > > > > And thanks for providing the refaults I requested=
 for -- your data
> > > > > > > > > > > > > below confirms what I mentioned above:
> > > > > > > > > > > > >
> > > > > > > > > > > > > For fio:
> > > > > > > > > > > > >                            Your RFC   This series=
   Change
> > > > > > > > > > > > >   workingset_refault_file  628192729  596790506  =
   -5%
> > > > > > > > > > > > >   IOPS                     1862k      1830k      =
   -2%
> > > > > > > > > > > > >
> > > > > > > > > > > > > For MongoDB:
> > > > > > > > > > > > >                            Your RFC   This series=
   Change
> > > > > > > > > > > > >   workingset_refault_anon  10512      35277      =
   +30%
> > > > > > > > > > > > >   workingset_refault_file  22751782   20335355   =
   -11%
> > > > > > > > > > > > >   total                    22762294   20370632   =
   -11%
> > > > > > > > > > > > >   TPS                      0.09       0.06       =
   -33%
> > > > > > > > > > > > >
> > > > > > > > > > > > > For MongoDB, this series should be a big win (but=
 apparently it's not),
> > > > > > > > > > > > > especially when using zram, since an anon refault=
 should be a lot
> > > > > > > > > > > > > cheaper than a file refault.
> > > > > > > > > > > > >
> > > > > > > > > > > > > So, I'm baffled...
> > > > > > > > > > > > >
> > > > > > > > > > > > > One important detail I forgot to mention: based o=
n your data from
> > > > > > > > > > > > > lru_gen_full, I think there is another difference=
 between our Kconfigs:
> > > > > > > > > > > > >
> > > > > > > > > > > > >                   Your Kconfig  My Kconfig  Max p=
ossible
> > > > > > > > > > > > >   LRU_REFS_WIDTH  1             2           2
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Yu,
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks for the info, my fault, I forgot to update m=
y config as I was
> > > > > > > > > > > > testing some other features.
> > > > > > > > > > > > Buf after I changed LRU_REFS_WIDTH to 2 by disablin=
g IDLE_PAGE, thing
> > > > > > > > > > > > got much worse for MongoDB test:
> > > > > > > > > > > >
> > > > > > > > > > > > With LRU_REFS_WIDTH =3D=3D 2:
> > > > > > > > > > > >
> > > > > > > > > > > > This patch:
> > > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > > Execution Results after 919 seconds
> > > > > > > > > > > > ---------------------------------------------------=
---------------
> > > > > > > > > > > >                   Executed        Time (=C2=B5s)   =
    Rate
> > > > > > > > > > > >   STOCK_LEVEL     488             27598136201.9   0=
02 txn/s
> > > > > > > > > > > > ---------------------------------------------------=
---------------
> > > > > > > > > > > >   TOTAL           488             27598136201.9   0=
02 txn/s
> > > > > > > > > > > >
> > > > > > > > > > > > memcg    86 /system.slice/docker-1c3a90be9f0a072f57=
19332419550cd0e1455f2cd5863bc2780ca4d3f913ece5.scope
> > > > > > > > > > > >  node     0
> > > > > > > > > > > >           1     948187          0x          0x
> > > > > > > > > > > >                      0          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                      1          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                      2          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                      3          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                                 0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >           2     948187          0     6051788=C2=B7
> > > > > > > > > > > >                      0          0r          0e     =
     0p      11916r
> > > > > > > > > > > >      66442e          0p
> > > > > > > > > > > >                      1          0r          0e     =
     0p        903r
> > > > > > > > > > > >      16888e          0p
> > > > > > > > > > > >                      2          0r          0e     =
     0p        459r
> > > > > > > > > > > >       9764e          0p
> > > > > > > > > > > >                      3          0r          0e     =
     0p          0r
> > > > > > > > > > > >          0e       2874p
> > > > > > > > > > > >                                 0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >           3     948187    1353160        6351=C2=B7
> > > > > > > > > > > >                      0          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                      1          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                      2          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                      3          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                                 0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >           4      73045      23573          12=C2=B7
> > > > > > > > > > > >                      0          0R          0T     =
     0     3498607R
> > > > > > > > > > > >    4868605T          0=C2=B7
> > > > > > > > > > > >                      1          0R          0T     =
     0     3012246R
> > > > > > > > > > > >    3270261T          0=C2=B7
> > > > > > > > > > > >                      2          0R          0T     =
     0     2498608R
> > > > > > > > > > > >    2839104T          0=C2=B7
> > > > > > > > > > > >                      3          0R          0T     =
     0           0R
> > > > > > > > > > > >    1983947T          0=C2=B7
> > > > > > > > > > > >                           1486579L          0O    1=
380614Y       2945N
> > > > > > > > > > > >       2945F       2734A
> > > > > > > > > > > >
> > > > > > > > > > > > workingset_refault_anon 0
> > > > > > > > > > > > workingset_refault_file 18130598
> > > > > > > > > > > >
> > > > > > > > > > > >               total        used        free      sh=
ared  buff/cache   available
> > > > > > > > > > > > Mem:          31978        6705         312        =
  20       24960       24786
> > > > > > > > > > > > Swap:         31977           4       31973
> > > > > > > > > > > >
> > > > > > > > > > > > RFC:
> > > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > > Execution Results after 908 seconds
> > > > > > > > > > > > ---------------------------------------------------=
---------------
> > > > > > > > > > > >                   Executed        Time (=C2=B5s)   =
    Rate
> > > > > > > > > > > >   STOCK_LEVEL     2252            27159962888.2   0=
08 txn/s
> > > > > > > > > > > > ---------------------------------------------------=
---------------
> > > > > > > > > > > >   TOTAL           2252            27159962888.2   0=
08 txn/s
> > > > > > > > > > > >
> > > > > > > > > > > > workingset_refault_anon 22585
> > > > > > > > > > > > workingset_refault_file 22715256
> > > > > > > > > > > >
> > > > > > > > > > > > memcg    66 /system.slice/docker-0989446ff78106e32d=
3f400a0cf371c9a703281bded86d6d6bb1af706ebb25da.scope
> > > > > > > > > > > >  node     0
> > > > > > > > > > > >          22     563007       2274     1198225=C2=B7
> > > > > > > > > > > >                      0          0r          1e     =
     0p          0r
> > > > > > > > > > > >     697076e          0p
> > > > > > > > > > > >                      1          0r          0e     =
     0p          0r
> > > > > > > > > > > >          0e     325661p
> > > > > > > > > > > >                      2          0r          0e     =
     0p          0r
> > > > > > > > > > > >          0e     888728p
> > > > > > > > > > > >                      3          0r          0e     =
     0p          0r
> > > > > > > > > > > >          0e    3602238p
> > > > > > > > > > > >                                 0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >          23     532222       7525     4948747=C2=B7
> > > > > > > > > > > >                      0          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                      1          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                      2          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                      3          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                                 0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >          24     500367    1214667        3292=C2=B7
> > > > > > > > > > > >                      0          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                      1          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                      2          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                      3          0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >                                 0           0      =
     0           0
> > > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > > >          25     469692      40797         466=C2=B7
> > > > > > > > > > > >                      0          0R        271T     =
     0           0R
> > > > > > > > > > > >    1162165T          0=C2=B7
> > > > > > > > > > > >                      1          0R          0T     =
     0      774028R
> > > > > > > > > > > >    1205332T          0=C2=B7
> > > > > > > > > > > >                      2          0R          0T     =
     0           0R
> > > > > > > > > > > >     932484T          0=C2=B7
> > > > > > > > > > > >                      3          0R          1T     =
     0           0R
> > > > > > > > > > > >    4252158T          0=C2=B7
> > > > > > > > > > > >                          25178380L     156515O   23=
953602Y      59234N
> > > > > > > > > > > >      49391F      48664A
> > > > > > > > > > > >
> > > > > > > > > > > >               total        used        free      sh=
ared  buff/cache   available
> > > > > > > > > > > > Mem:          31978        6968         338        =
   5       24671       24555
> > > > > > > > > > > > Swap:         31977        1533       30444
> > > > > > > > > > > >
> > > > > > > > > > > > Using same mongodb config (a 3 replica cluster usin=
g the same config):
> > > > > > > > > > > > {
> > > > > > > > > > > >     "net": {
> > > > > > > > > > > >         "bindIpAll": true,
> > > > > > > > > > > >         "ipv6": false,
> > > > > > > > > > > >         "maxIncomingConnections": 10000,
> > > > > > > > > > > >     },
> > > > > > > > > > > >     "setParameter": {
> > > > > > > > > > > >         "disabledSecureAllocatorDomains": "*"
> > > > > > > > > > > >     },
> > > > > > > > > > > >     "replication": {
> > > > > > > > > > > >         "oplogSizeMB": 10480,
> > > > > > > > > > > >         "replSetName": "issa-tpcc_0"
> > > > > > > > > > > >     },
> > > > > > > > > > > >     "security": {
> > > > > > > > > > > >         "keyFile": "/data/db/keyfile"
> > > > > > > > > > > >     },
> > > > > > > > > > > >     "storage": {
> > > > > > > > > > > >         "dbPath": "/data/db/",
> > > > > > > > > > > >         "syncPeriodSecs": 60,
> > > > > > > > > > > >         "directoryPerDB": true,
> > > > > > > > > > > >         "wiredTiger": {
> > > > > > > > > > > >             "engineConfig": {
> > > > > > > > > > > >                 "cacheSizeGB": 5
> > > > > > > > > > > >             }
> > > > > > > > > > > >         }
> > > > > > > > > > > >     },
> > > > > > > > > > > >     "systemLog": {
> > > > > > > > > > > >         "destination": "file",
> > > > > > > > > > > >         "logAppend": true,
> > > > > > > > > > > >         "logRotate": "rename",
> > > > > > > > > > > >         "path": "/data/db/mongod.log",
> > > > > > > > > > > >         "verbosity": 0
> > > > > > > > > > > >     }
> > > > > > > > > > > > }
> > > > > > > > > > > >
> > > > > > > > > > > > The test environment have 32g memory and 16 core.
> > > > > > > > > > > >
> > > > > > > > > > > > Per my analyze, the access pattern for the mongodb =
test is that page
> > > > > > > > > > > > will be re-access long after it's evicted so PID co=
ntroller won't
> > > > > > > > > > > > protect higher tier. That RFC will make use of the =
long existing
> > > > > > > > > > > > shadow to do feedback to PID/Gen so the result will=
 be much better.
> > > > > > > > > > > > Still need more adjusting though, will try to do a =
rebase on top of
> > > > > > > > > > > > mm-unstable which includes your patch.
> > > > > > > > > > > >
> > > > > > > > > > > > I've no idea why the workingset_refault_* is higher=
 in the better
> > > > > > > > > > > > case, this a clearly an IO bound workload, Memory a=
nd IO is busy while
> > > > > > > > > > > > CPU is not full...
> > > > > > > > > > > >
> > > > > > > > > > > > I've uploaded my local reproducer here:
> > > > > > > > > > > > https://github.com/ryncsn/emm-test-project/tree/mas=
ter/mongo-cluster
> > > > > > > > > > > > https://github.com/ryncsn/py-tpcc
> > > > > > > > > > >
> > > > > > > > > > > Thanks for the repos -- I'm trying them right now. Wh=
ich MongoDB
> > > > > > > > > > > version did you use? setup.sh didn't seem to install =
it.
> > > > > > > > > > >
> > > > > > > > > > > Also do you have a QEMU image? It'd be a lot easier f=
or me to
> > > > > > > > > > > duplicate the exact environment by looking into it.
> > > > > > > > > >
> > > > > > > > > > I ended up using docker.io/mongodb/mongodb-community-se=
rver:latest,
> > > > > > > > > > and it's not working:
> > > > > > > > > >
> > > > > > > > > > # docker exec -it mongo-r1 mongosh --eval \
> > > > > > > > > > '"rs.initiate({
> > > > > > > > > >     _id: "issa-tpcc_0",
> > > > > > > > > >     members: [
> > > > > > > > > >       {_id: 0, host: "mongo-r1"},
> > > > > > > > > >       {_id: 1, host: "mongo-r2"},
> > > > > > > > > >       {_id: 2, host: "mongo-r3"}
> > > > > > > > > >     ]
> > > > > > > > > > })"'
> > > > > > > > > > Emulate Docker CLI using podman. Create /etc/containers=
/nodocker to quiet msg.
> > > > > > > > > > Error: can only create exec sessions on running contain=
ers: container
> > > > > > > > > > state improper
> > > > > > > > >
> > > > > > > > > Hi Yu,
> > > > > > > > >
> > > > > > > > > I've updated the test repo:
> > > > > > > > > https://github.com/ryncsn/emm-test-project/tree/master/mo=
ngo-cluster
> > > > > > > > >
> > > > > > > > > I've tested it on top of latest Fedora Cloud Image 39 and=
 it worked
> > > > > > > > > well for me, the README now contains detailed and not har=
d to follow
> > > > > > > > > steps to reproduce this test.
> > > > > > > >
> > > > > > > > Thanks. I was following the instructions down to the letter=
 and it
> > > > > > > > fell apart again at line 46 (./tpcc.py).
> > > > > > >
> > > > > > > I think you just broke it by
> > > > > > > https://github.com/ryncsn/py-tpcc/commit/7b9b380d636cb84faa5b=
11b5562e531f924eeb7e
> > > > > > >
> > > > > > > (But it's also possible you actually wanted me to use this la=
test
> > > > > > > commit but forgot to account for it in your instructions.)
> > > > > > >
> > > > > > > > Were you able to successfully run the benchmark on a fresh =
VM by
> > > > > > > > following the instructions? If not, I'd appreciate it if yo=
u could do
> > > > > > > > so and document all the missing steps.
> > > > > >
> > > > > > Ah, you are right, I attempted to convert it to Python3 but fou=
nd it
> > > > > > only brought more trouble, so I gave up and the instruction is =
still
> > > > > > using Python2. However I accidentally pushed the WIP python3 co=
nvert
> > > > > > commit... I've reset the repo to
> > > > > > https://github.com/ryncsn/py-tpcc/commit/86e862c5cf3b2d1f51e029=
7742fa837c7a99ebf8,
> > > > > > this is working well. Sorry for the inconvenient.
> > > > >
> > > > > Thanks -- I was able to reproduce results similar to yours.
> > > > >
> > > >
> > > > Hi Yu,
> > > >
> > > > Thanks for the testing, and merry xmas.
> > > >
> > > > > It turned out the mystery (fewer refaults but worse performance) =
was caused by
> > > > >     13.89%    13.89%  kswapd0  [kernel.vmlinux]  [k]
> > > > > __list_del_entry_valid_or_report
> > > >
> > > > I'm not sure about this, if the task is CPU bounded, this could
> > > > explain. But it's not, the performance gap is larger when tested on
> > > > slow IO device.
> > > >
> > > > The iostat output during my test run:
> > > > avg-cpu:  %user   %nice %system %iowait  %steal   %idle
> > > >            7.40    0.00    2.42   83.37    0.00    6.80
> > > > Device            r/s     w/s     rkB/s     wkB/s   rrqm/s   wrqm/s
> > > > %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
> > > > vda             35.00    0.80    167.60     17.20     6.90     3.50
> > > > 16.47  81.40    0.47    1.62   0.02     4.79    21.50   0.63   2.27
> > > > vdb           5999.30    4.80 104433.60     84.00     0.00     8.30
> > > > 0.00  63.36    6.54    1.31  39.25    17.41    17.50   0.17 100.00
> > > > zram0            0.00    0.00      0.00      0.00     0.00     0.00
> > > > 0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00
> > >
> > > I ran the benchmark on the slowest bare metal I have that roughly
> > > matches your CPU/DRAM configurations (ThinkPad P1 G4
> > > https://support.lenovo.com/us/en/solutions/pd031426).
> > >
> > > But it seems you used a VM (vda/vdb) -- I never run performance
> > > benchmarks in VMs because the host and hypervisor can complicate
> > > things, for example, in this case, is it possible the host page cache
> > > cached your disk image containing the database files?
> > >
> > > > You can see CPU is waiting for IO, %user is always around 10%.
> > > > The hotspot you posted only take up 13.89% of the runtime, which
> > > > shouldn't cause so much performance drop.
> > > >
> > > > >
> > > > > Apparently Fedora has CONFIG_DEBUG_LIST=3Dy by default, and after=
 I
> > > > > turned it off (the only change I made), this series showed better=
 TPS
> > > > > (I used"--duration=3D10800" for more reliable results):
> > > > >                          v6.7-rc6   RFC [1]    change
> > > > > total txns               25024      24672      +1%
> > > > > workingset_refault_anon  573668     680248     -16%
> > > > > workingset_refault_file  260631976  265808452  -2%
> > > >
> > > > I have disabled CONFIG_DEBUG_LIST when doing performance comparison=
 test.
> >
> > Also I'd suggest we both use the same distro you shared with me and
> > the default .config except CONFIG_DEBUG_LIST=3Dn, and v6.7-rc6 for now.
> >
> > (I'm attaching the default .config based on /boot/config-6.5.6-300.fc39=
x86_64.)
> >
>
> Hi Yu
>
> I've been adapting and testing the refault distance series based on
> latest 6.7. Also I found a serious bug in my previous V3, so I updated
> it here with some importance changes (using a seperate refault
> distance model, instead of glueing to active/inactive model):
> https://github.com/ryncsn/linux/commits/kasong/devel/refault-distance-202=
4-1/
>
> So far I can conclude that previous result is not caused by host
> cache, I setup a baremetal test environment, strictly using your
> config, I gathered some data (I also updated the refault distance
> patch series, updated version in link above, and also the baremetal
> hava a fast NVME so the performance gap wasn't so large but still
> stably observable):
>
> With latest 6.7 (Your config):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Execution Results after 905 seconds
> ------------------------------------------------------------------
>                   Executed        Time (=C2=B5s)       Rate
>   STOCK_LEVEL     4025            27162035181.5   0.15 txn/s
> ------------------------------------------------------------------
>   TOTAL           4025            27162035181.5   0.15 txn/s
>
> vmstat:
> workingset_nodes 82996
> workingset_refault_anon 269371
> workingset_refault_file 37671044
> workingset_activate_anon 121061
> workingset_activate_file 8927227
> workingset_restore_anon 121061
> workingset_restore_file 2578269
> workingset_nodereclaim 62394
>
> lru_gen_full:
> memcg    67 /machine.slice/libpod-38b33777db34724cf8edfbef1ac2e4fd0621f14=
151e241bbf1430d397d3dee51.scope/container
>  node     0
>          34      60565      21248     1254331
>                      0          0r          0e          0p     121186r
>     169948e          0p
>                      1          0r          0e          0p     156224r
>     222553e          0p
>                      2          0r          0e          0p          0r
>          0e    4227858p
>                      3          0r          0e          0p          0r
>          0e          0p
>                                 0           0           0           0
>          0           0
>          35      41132     714504     4300280
>                      0          0           0           0           0
>          0           0
>                      1          0           0           0           0
>          0           0
>                      2          0           0           0           0
>          0           0
>                      3          0           0           0           0
>          0           0
>                                 0           0           0           0
>          0           0
>          36      20586     473476        2105
>                      0          0           0           0           0
>          0           0
>                      1          0           0           0           0
>          0           0
>                      2          0           0           0           0
>          0           0
>                      3          0           0           0           0
>          0           0
>                                 0           0           0           0
>          0           0
>          37       2035        817         876
>                      0       6647R       9116T          0      166836R
>     871850T          0
>                      1          0R          0T          0      110807R
>     296447T          0
>                      2          0R        268T          0           0R
>    4655276T          0
>                      3          0R          0T          0           0R
>          0T          0
>                          12510062L     639646O   11048666Y      45512N
>      24520F      23613A
> iostat:
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>           76.29    0.00   12.09    3.50    1.44    6.69
>
> Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s
> kB_read    kB_wrtn    kB_dscd
> dm-0             16.12       684.50        36.93         0.00
> 649996      35070          0
> dm-1              0.05         1.10         0.00         0.00
> 1044          0          0
> nvme0n1      16.47       700.22        39.09         0.00     664922
>    37118          0
> nvme1n1        4905.93    205287.92      1030.70         0.00
> 194939353     978740          0
> zram0          4440.17      5356.90     12404.81         0.00
> 5086856   11779480          0
>
> free -m:
>                total        used        free      shared  buff/cache   av=
ailable
> Mem:           31830        9475         403           0       21951     =
  21918
> Swap:          31829        6500       25329
>
> With latest refault distance series (Your config):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Execution Results after 902 seconds
> ------------------------------------------------------------------
>                   Executed        Time (=C2=B5s)       Rate
>   STOCK_LEVEL     4260            27065448172.8   0.16 txn/s
> ------------------------------------------------------------------
>   TOTAL           4260            27065448172.8   0.16 txn/s
>
> workingset_nodes 113824
> workingset_refault_anon 293426
> workingset_refault_file 42700484
> workingset_activate_anon 0
> workingset_activate_file 13410174
> workingset_restore_anon 289106
> workingset_restore_file 5592042
> workingset_nodereclaim 33249
>
> memcg    67 /machine.slice/libpod-8eff6b7b65e34fe0497ff5c0c88c750f6896c43=
a06bb26e8cd6470de596be76e.scope/container
>  node     0
>          15     261222     266350       65081
>                      0          0r          0e          0p     185212r
>    2314329e          0p
>                      1          0r          0e          0p      40887r
>     710312e          0p
>                      2          0r          0e          0p          0r
>          0e    5026031p
>                      3          0r          0e          0p          0r
>          0e          0p
>                                 0           0           0           0
>          0           0
>          16     199341     267661     5034442
>                      0          0           0           0           0
>          0           0
>                      1          0           0           0           0
>          0           0
>                      2          0           0           0           0
>          0           0
>                      3          0           0           0           0
>          0           0
>                                 0           0           0           0
>          0           0
>          17     120655     547852         592
>                      0          0           0           0           0
>          0           0
>                      1          0           0           0           0
>          0           0
>                      2          0           0           0           0
>          0           0
>                      3          0           0           0           0
>          0           0
>                                 0           0           0           0
>          0           0
>          18      55172     127769        3855
>                      0       1910R       2975T          0     1894614R
>    4375361T          0
>                      1          0R          0T          0     2099208R
>    2861460T          0
>                      2          0R         27T          0      446000R
>    5569781T          0
>                      3          0R          0T          0           0R
>          0T          0
>                           2817512L      35421O    2579377Y      10452N
>       5517F       5414A
>
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>           76.34    0.00   11.25    4.22    1.29    6.90
>
> Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s
> kB_read    kB_wrtn    kB_dscd
> dm-0             12.85       563.18        30.75         0.00
> 532390      29070          0
> dm-1              0.05         1.10         0.00         0.00
> 1044          0          0
> nvme0n1          13.22       578.97        32.92         0.00
> 547315      31119          0
> nvme1n1        5384.11    229164.12      1038.95         0.00
> 216635713     982152          0
> zram0          3590.88      4730.84      9633.71         0.00
> 4472204    9107032          0
>
>                total        used        free      shared  buff/cache   av=
ailable
> Mem:           31830       10854         520           0       20455     =
  20541
> Swap:          31829        4508       27321
>
> You see actually refault distance is now protecting more anon page,
> total IO on ZRAM is lower, It's mostly CPU bound, and NVME is fast
> enough, and result in a better performance.
>
> Things get more interesting if I disable page idle flag (so refs bits
> is extended, in your config, refs bit is only one bit, so it maybe
> overprotect file pages):
>
> Latest 6.7 (You config with page idle flag disabled):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Execution Results after 904 seconds
> ------------------------------------------------------------------
>                   Executed        Time (=C2=B5s)       Rate
>   STOCK_LEVEL     4016            27122163703.9   0.15 txn/s
> ------------------------------------------------------------------
>   TOTAL           4016            27122163703.9   0.15 txn/s
>
> workingset_nodes 99637
> workingset_refault_anon 309548
> workingset_refault_file 45896663
> workingset_activate_anon 129401
> workingset_activate_file 18461236
> workingset_restore_anon 129400
> workingset_restore_file 4963707
> workingset_nodereclaim 43970
>
> memcg    67 /machine.slice/libpod-7546463bd2b257a9b799817ca11bee1389d7dee=
c20032529098520a89a207d7e.scope/container
>  node     0
>          27     103004     328070      269733
>                      0          0r          0e          0p     509949r
>    1957117e          0p
>                      1          0r          0e          0p     141642r
>     319695e          0p
>                      2          0r          0e          0p     777835r
>     793518e          0p
>                      3          0r          0e          0p          0r
>          0e    4333835p
>                                 0           0           0           0
>          0           0
>          28      82361      24748     5192182
>                      0          0           0           0           0
>          0           0
>                      1          0           0           0           0
>          0           0
>                      2          0           0           0           0
>          0           0
>                      3          0           0           0           0
>          0           0
>                                 0           0           0           0
>          0           0
>          29      57025     786386        5681
>                      0          0           0           0           0
>          0           0
>                      1          0           0           0           0
>          0           0
>                      2          0           0           0           0
>          0           0
>                      3          0           0           0           0
>          0           0
>                                 0           0           0           0
>          0           0
>          30      18619      76289        1273
>                      0       4295R       8888T          0      222326R
>    1044601T          0
>                      1          0R          0T          0      117646R
>     301735T          0
>                      2          0R          0T          0      433431R
>     825516T          0
>                      3          0R          1T          0           0R
>    4076839T          0
>                          13369819L     603360O   11981074Y      47388N
>      26235F      25276A
>
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>           74.90    0.00   11.96    4.92    1.62    6.60
>
> Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s
> kB_read    kB_wrtn    kB_dscd
> dm-0             14.93       645.44        36.54         0.00
> 610150      34540          0
> dm-1              0.05         1.10         0.00         0.00
> 1044          0          0
> nvme0n1          15.30       661.23        38.71         0.00
> 625076      36589          0
> nvme1n1        6352.42    240726.35      1036.47         0.00
> 227565845     979808          0
> zram0          4189.65      4883.27     11876.36         0.00
> 4616304   11227080          0
>
>                total        used        free      shared  buff/cache   av=
ailable
> Mem:           31830        9529         509           0       21791     =
  21867
> Swap:          31829        6441       25388
>
> Refault distance seriese (Your config with page idle flag disabled):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Execution Results after 901 seconds
> ------------------------------------------------------------------
>                   Executed        Time (=C2=B5s)       Rate
>   STOCK_LEVEL     4268            27060267967.7   0.16 txn/s
> ------------------------------------------------------------------
>   TOTAL           4268            27060267967.7   0.16 txn/s
>
> workingset_nodes 115394
> workingset_refault_anon 144774
> workingset_refault_file 41055081
> workingset_activate_anon 8
> workingset_activate_file 13194460
> workingset_restore_anon 144629
> workingset_restore_file 187419
> workingset_nodereclaim 19598
>
> memcg    66 /machine.slice/libpod-4866051af817731602b37017b0e71feb2a8f2cb=
aa949f577e0444af01b4f3b0c.scope/container
>  node     0
>          12     213402      18054     1287510
>                      0          0r          0e          0p          0r
>      15755e          0p
>                      1          0r          0e          0p          0r
>       4771e          0p
>                      2          0r          0e          0p        908r
>       6810e          0p
>                      3          0r          0e          0p          0r
>          0e    3533888p
>                                 0           0           0           0
>          0           0
>          13     141209      10690     3571958
>                      0          0           0           0           0
>          0           0
>                      1          0           0           0           0
>          0           0
>                      2          0           0           0           0
>          0           0
>                      3          0           0           0           0
>          0           0
>                                 0           0           0           0
>          0           0
>          14      69327    1165064       34657
>                      0          0           0           0           0
>          0           0
>                      1          0           0           0           0
>          0           0
>                      2          0           0           0           0
>          0           0
>                      3          0           0           0           0
>          0           0
>                                 0           0           0           0
>          0           0
>          15       6404      21574        3363
>                      0        953R       1773T          0     1263395R
>    3816639T          0
>                      1          0R          0T          0     1164069R
>    1936973T          0
>                      2          0R          0T          0      350041R
>     409121T          0
>                      3          0R          3T          0       12305R
>    4767303T          0
>                           3622197L      36916O    3338446Y      10409N
>       7120F       6945A
>
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>           75.79    0.00   10.68    3.91    1.18    8.44
>
> Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s
> kB_read    kB_wrtn    kB_dscd
> dm-0             12.66       547.71        38.73         0.00
> 526782      37248          0
> dm-1              0.05         1.09         0.00         0.00
> 1044          0          0
> nvme0n1         13.02       563.23        40.86         0.00
> 541708      39297          0
> nvme1n1       4916.00    217529.48      1018.04         0.00
> 209217677     979136          0
> zram0          1744.90      1970.86      5009.75         0.00
> 1895556    4818328          0
>
>                total        used        free      shared  buff/cache   av=
ailable
> Mem:           31830       11713         485           0       19630     =
  19684
> Swap:          31829        2847       28982
>
> And still refault distance series is better, and refault is also lower
> for both anon/file pages.
>
> ------
> I did some more test using MySQL and other workflow, no performance
> drop observed so far.
> And with a loop MongoDB test (keep running 900s test in loop) using my
> previous VM env
> (the SATA SSD vdb is using cache bypass so not a host cache issue here)
> I found one thing interesting (refs bit is set to 2 in config):
>
> Loop test using 6.7:
>   STOCK_LEVEL     874             27246011368.3   0.03 txn/s
>   STOCK_LEVEL     1533            27023181579.6   0.06 txn/s
>   STOCK_LEVEL     1122            28044867987.6   0.04 txn/s
>   STOCK_LEVEL     1032            27378070931.9   0.04 txn/s
>   STOCK_LEVEL     1021            27612530579.1   0.04 txn/s
>   STOCK_LEVEL     750             28076187896.3   0.03 txn/s
>   STOCK_LEVEL     780             27519993034.8   0.03 txn/s
> Refault stat here:
> workingset_refault_anon 126369
> workingset_refault_file 170389428
>   STOCK_LEVEL     750             27464016123.5   0.03 txn/s
>   STOCK_LEVEL     780             27529550313.0   0.03 txn/s
>   STOCK_LEVEL     750             28296286486.1   0.03 txn/s
>   STOCK_LEVEL     690             27504193850.3   0.03 txn/s
>   STOCK_LEVEL     716             28089360754.5   0.03 txn/s
>   STOCK_LEVEL     607             27852180474.3   0.02 txn/s
>   STOCK_LEVEL     689             27703367075.4   0.02 txn/s
>   STOCK_LEVEL     630             28184685482.7   0.02 txn/s
>   STOCK_LEVEL     450             28667721196.2   0.02 txn/s
>   STOCK_LEVEL     450             28047985314.4   0.02 txn/s
>   STOCK_LEVEL     450             28125609857.3   0.02 txn/s
>   STOCK_LEVEL     420             27393478488.0   0.02 txn/s
>   STOCK_LEVEL     420             27435537312.3   0.02 txn/s
>   STOCK_LEVEL     420             29060748699.2   0.01 txn/s
>   STOCK_LEVEL     420             28155584095.2   0.01 txn/s
>   STOCK_LEVEL     420             27888635407.0   0.02 txn/s
>   STOCK_LEVEL     420             27307856858.5   0.02 txn/s
>   STOCK_LEVEL     420             28842280889.0   0.01 txn/s
>   STOCK_LEVEL     390             27640696814.1   0.01 txn/s
>   STOCK_LEVEL     420             28471605716.7   0.01 txn/s
>   STOCK_LEVEL     420             27648174237.5   0.02 txn/s
>   STOCK_LEVEL     420             27848217938.7   0.02 txn/s
>   STOCK_LEVEL     420             27344698602.2   0.02 txn/s
>   STOCK_LEVEL     420             27046819537.2   0.02 txn/s
>   STOCK_LEVEL     420             27855626843.2   0.02 txn/s
>   STOCK_LEVEL     420             27971873627.9   0.02 txn/s
>   STOCK_LEVEL     420             28007014046.4   0.01 txn/s
>   STOCK_LEVEL     420             28445164626.1   0.01 txn/s
>   STOCK_LEVEL     420             27902621006.5   0.02 txn/s
>   STOCK_LEVEL     420             28282574433.3   0.01 txn/s
>   STOCK_LEVEL     390             27161599608.7   0.01 txn/s
>
> Using refault distance seriese:
>   STOCK_LEVEL     2605            27120667462.8   0.10 txn/s
>   STOCK_LEVEL     3000            27106854857.2   0.11 txn/s
>   STOCK_LEVEL     2925            27066601064.4   0.11 txn/s
>   STOCK_LEVEL     2757            27035248005.2   0.10 txn/s
>   STOCK_LEVEL     1325            28053716046.8   0.05 txn/s
>   STOCK_LEVEL     717             27455091366.3   0.03 txn/s
>   STOCK_LEVEL     967             27404085208.2   0.04 txn/s
> Refault stat here:
> workingset_refault_anon 109337
> workingset_refault_file 191249716
>   STOCK_LEVEL     716             27448213557.2   0.03 txn/s
>   STOCK_LEVEL     807             28607974517.8   0.03 txn/s
>   STOCK_LEVEL     760             28081442513.2   0.03 txn/s
>   STOCK_LEVEL     745             28594555797.6   0.03 txn/s
>   STOCK_LEVEL     450             27999536348.3   0.02 txn/s
>   STOCK_LEVEL     598             27095531895.4   0.02 txn/s
>   STOCK_LEVEL     711             27623112841.1   0.03 txn/s
>   STOCK_LEVEL     540             28358770820.6   0.02 txn/s
>   STOCK_LEVEL     480             27734277554.5   0.02 txn/s
>   STOCK_LEVEL     450             27313906125.3   0.02 txn/s
>   STOCK_LEVEL     480             27487299100.4   0.02 txn/s
>   STOCK_LEVEL     480             27804589683.5   0.02 txn/s
>   STOCK_LEVEL     480             28242205820.8   0.02 txn/s
>   STOCK_LEVEL     480             27540680102.3   0.02 txn/s
>   STOCK_LEVEL     450             27428645816.8   0.02 txn/s
>   STOCK_LEVEL     480             27946866129.2   0.02 txn/s
>   STOCK_LEVEL     480             27266068262.3   0.02 txn/s
>   STOCK_LEVEL     450             27267487051.5   0.02 txn/s
>   STOCK_LEVEL     480             27896369224.8   0.02 txn/s
>   STOCK_LEVEL     480             28784662706.1   0.02 txn/s
>   STOCK_LEVEL     450             27179853217.8   0.02 txn/s
>   STOCK_LEVEL     480             28170594101.7   0.02 txn/s
>   STOCK_LEVEL     450             28084651341.0   0.02 txn/s
>   STOCK_LEVEL     480             27901608868.6   0.02 txn/s
>   STOCK_LEVEL     480             27323790886.6   0.02 txn/s
>   STOCK_LEVEL     480             28891008895.4   0.02 txn/s
>   STOCK_LEVEL     480             27964563148.0   0.02 txn/s
>   STOCK_LEVEL     450             27942421198.4   0.02 txn/s
>   STOCK_LEVEL     480             28833968825.8   0.02 txn/s
>   STOCK_LEVEL     480             28090975437.9   0.02 txn/s
>   STOCK_LEVEL     480             27915246877.4   0.02 txn/s
>
> It seems the performance will drain as the test keep running (might be
> caused by MongoDB anon usage rising or DB internal caching/logging),
> that explains why for a long term test the performance gap seem to be
> smaller. The VM have a poor IO performance so the test run speed is
> much slower too, take a long time to warm up.
>
> But I think it's clear that refault distance series will boost the
> performance during warm up, and for long time workload it's also
> looking better, especially for low IO performance machines.
>
> I still can't explain about why workingset_refault is higher for the
> better case in the VM environment... I can resetup/reboot/randomize
> the test the the performance is same here. My guess is maybe related
> to readahead or some kernel space IO path issue? The actual IO usage
> is lower when refault distance series is applied.
>
> I notices a slight performance regression (1 - 3%) for pure in-mem FIO
> though, the "bulk series" I sent previous can help improve it.
>
> There is a bug in my previous V3 that will cause PID controller to
> lost control in long term (due to a bugged bit operation, my bad),
> which I've fixed in link above, I can send out new series if you think
> it's acceptable.

Could you try the attached patch on the mainline v6.7 and see how it
compares with the results above? Thanks.

--000000000000d7cb50060ea62231
Content-Type: application/octet-stream; name="mglru-6.7.patch"
Content-Disposition: attachment; filename="mglru-6.7.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lr8v0nh10>
X-Attachment-Id: f_lr8v0nh10

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW1faW5saW5lLmggYi9pbmNsdWRlL2xpbnV4L21t
X2lubGluZS5oCmluZGV4IGY0ZmU1OTNjMTQwMC4uZDlhOGE0YWZmYWFmIDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L21tX2lubGluZS5oCisrKyBiL2luY2x1ZGUvbGludXgvbW1faW5saW5lLmgK
QEAgLTEzMywxOCArMTMzLDE3IEBAIHN0YXRpYyBpbmxpbmUgaW50IGxydV9oaXN0X2Zyb21fc2Vx
KHVuc2lnbmVkIGxvbmcgc2VxKQogCXJldHVybiBzZXEgJSBOUl9ISVNUX0dFTlM7CiB9CiAKLXN0
YXRpYyBpbmxpbmUgaW50IGxydV90aWVyX2Zyb21fcmVmcyhpbnQgcmVmcykKK3N0YXRpYyBpbmxp
bmUgaW50IGxydV90aWVyX2Zyb21fcmVmcyhpbnQgcmVmcywgYm9vbCB3b3JraW5nc2V0KQogewot
CVZNX1dBUk5fT05fT05DRShyZWZzID4gQklUKExSVV9SRUZTX1dJRFRIKSk7CisJVk1fV0FSTl9P
Tl9PTkNFKHJlZnMgPj0gQklUKExSVV9SRUZTX1dJRFRIKSk7CiAKIAkvKiBzZWUgdGhlIGNvbW1l
bnQgaW4gZm9saW9fbHJ1X3JlZnMoKSAqLwotCXJldHVybiBvcmRlcl9iYXNlXzIocmVmcyArIDEp
OworCXJldHVybiB3b3JraW5nc2V0ID8gTUFYX05SX1RJRVJTIC0gMSA6IG9yZGVyX2Jhc2VfMihy
ZWZzICsgMSk7CiB9CiAKIHN0YXRpYyBpbmxpbmUgaW50IGZvbGlvX2xydV9yZWZzKHN0cnVjdCBm
b2xpbyAqZm9saW8pCiB7CiAJdW5zaWduZWQgbG9uZyBmbGFncyA9IFJFQURfT05DRShmb2xpby0+
ZmxhZ3MpOwotCWJvb2wgd29ya2luZ3NldCA9IGZsYWdzICYgQklUKFBHX3dvcmtpbmdzZXQpOwog
CiAJLyoKIAkgKiBSZXR1cm4gdGhlIG51bWJlciBvZiBhY2Nlc3NlcyBiZXlvbmQgUEdfcmVmZXJl
bmNlZCwgaS5lLiwgTi0xIGlmIHRoZQpAQCAtMTUyLDcgKzE1MSwxOCBAQCBzdGF0aWMgaW5saW5l
IGludCBmb2xpb19scnVfcmVmcyhzdHJ1Y3QgZm9saW8gKmZvbGlvKQogCSAqIHRpZXIuIGxydV90
aWVyX2Zyb21fcmVmcygpIHdpbGwgYWNjb3VudCBmb3IgdGhpcyBvZmYtYnktb25lLiBBbHNvIHNl
ZQogCSAqIHRoZSBjb21tZW50IG9uIE1BWF9OUl9USUVSUy4KIAkgKi8KLQlyZXR1cm4gKChmbGFn
cyAmIExSVV9SRUZTX01BU0spID4+IExSVV9SRUZTX1BHT0ZGKSArIHdvcmtpbmdzZXQ7CisJcmV0
dXJuIGZsYWdzICYgQklUKFBHX3JlZmVyZW5jZWQpID8gKGZsYWdzICYgTFJVX1JFRlNfTUFTSykg
Pj4gTFJVX1JFRlNfUEdPRkYgOiAwOworfQorCitzdGF0aWMgaW5saW5lIGJvb2wgbHJ1X2dlbl9h
Y3RpdmF0ZShzdHJ1Y3QgZm9saW8gKmZvbGlvKQoreworCWlmICghZm9saW9fdGVzdF9yZWZlcmVu
Y2VkKGZvbGlvKSAmJiAhZm9saW9fdGVzdF93b3JraW5nc2V0KGZvbGlvKSkgeworCQlmb2xpb19z
ZXRfcmVmZXJlbmNlZChmb2xpbyk7CisJCXJldHVybiBmYWxzZTsKKwl9CisKKwlzZXRfbWFza19i
aXRzKCZmb2xpby0+ZmxhZ3MsIExSVV9SRUZTX0ZMQUdTLCBCSVQoUEdfd29ya2luZ3NldCkpOwor
CXJldHVybiB0cnVlOwogfQogCiBzdGF0aWMgaW5saW5lIGludCBmb2xpb19scnVfZ2VuKHN0cnVj
dCBmb2xpbyAqZm9saW8pCkBAIC0yNDQsMTUgKzI1NCwxNSBAQCBzdGF0aWMgaW5saW5lIGJvb2wg
bHJ1X2dlbl9hZGRfZm9saW8oc3RydWN0IGxydXZlYyAqbHJ1dmVjLCBzdHJ1Y3QgZm9saW8gKmZv
bGlvLAogCSAqICAgIG9sZGVzdCBnZW5lcmF0aW9uIG90aGVyd2lzZS4gU2VlIGxydV9nZW5faXNf
YWN0aXZlKCkuCiAJICovCiAJaWYgKGZvbGlvX3Rlc3RfYWN0aXZlKGZvbGlvKSkKLQkJc2VxID0g
bHJ1Z2VuLT5tYXhfc2VxOworCQlzZXEgPSBscnVnZW4tPm1heF9zZXEgLSAhZm9saW9fdGVzdF93
b3JraW5nc2V0KGZvbGlvKTsKIAllbHNlIGlmICgodHlwZSA9PSBMUlVfR0VOX0FOT04gJiYgIWZv
bGlvX3Rlc3Rfc3dhcGNhY2hlKGZvbGlvKSkgfHwKIAkJIChmb2xpb190ZXN0X3JlY2xhaW0oZm9s
aW8pICYmCiAJCSAgKGZvbGlvX3Rlc3RfZGlydHkoZm9saW8pIHx8IGZvbGlvX3Rlc3Rfd3JpdGVi
YWNrKGZvbGlvKSkpKQogCQlzZXEgPSBscnVnZW4tPm1heF9zZXEgLSAxOwotCWVsc2UgaWYgKHJl
Y2xhaW1pbmcgfHwgbHJ1Z2VuLT5taW5fc2VxW3R5cGVdICsgTUlOX05SX0dFTlMgPj0gbHJ1Z2Vu
LT5tYXhfc2VxKQorCWVsc2UgaWYgKHJlY2xhaW1pbmcpCiAJCXNlcSA9IGxydWdlbi0+bWluX3Nl
cVt0eXBlXTsKIAllbHNlCi0JCXNlcSA9IGxydWdlbi0+bWluX3NlcVt0eXBlXSArIDE7CisJCXNl
cSA9IGxydWdlbi0+bWluX3NlcVt0eXBlXSArIGZvbGlvX3Rlc3Rfd29ya2luZ3NldChmb2xpbyk7
CiAKIAlnZW4gPSBscnVfZ2VuX2Zyb21fc2VxKHNlcSk7CiAJZmxhZ3MgPSAoZ2VuICsgMVVMKSA8
PCBMUlVfR0VOX1BHT0ZGOwpAQCAtMzAzLDYgKzMxMywxMSBAQCBzdGF0aWMgaW5saW5lIGJvb2wg
bHJ1X2dlbl9pbl9mYXVsdCh2b2lkKQogCXJldHVybiBmYWxzZTsKIH0KIAorc3RhdGljIGlubGlu
ZSBib29sIGxydV9nZW5fYWN0aXZhdGUoc3RydWN0IGZvbGlvICpmb2xpbykKK3sKKwlyZXR1cm4g
ZmFsc2U7Cit9CisKIHN0YXRpYyBpbmxpbmUgYm9vbCBscnVfZ2VuX2FkZF9mb2xpbyhzdHJ1Y3Qg
bHJ1dmVjICpscnV2ZWMsIHN0cnVjdCBmb2xpbyAqZm9saW8sIGJvb2wgcmVjbGFpbWluZykKIHsK
IAlyZXR1cm4gZmFsc2U7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tem9uZS5oIGIvaW5j
bHVkZS9saW51eC9tbXpvbmUuaAppbmRleCA5ZGIzNmUxOTc3MTIuLjVjMjliNzY5M2Y2NCAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC9tbXpvbmUuaAorKysgYi9pbmNsdWRlL2xpbnV4L21tem9u
ZS5oCkBAIC0zNzUsNiArMzc1LDcgQEAgc3RydWN0IHBhZ2Vfdm1hX21hcHBlZF93YWxrOwogCiAj
ZGVmaW5lIExSVV9HRU5fTUFTSwkJKChCSVQoTFJVX0dFTl9XSURUSCkgLSAxKSA8PCBMUlVfR0VO
X1BHT0ZGKQogI2RlZmluZSBMUlVfUkVGU19NQVNLCQkoKEJJVChMUlVfUkVGU19XSURUSCkgLSAx
KSA8PCBMUlVfUkVGU19QR09GRikKKyNkZWZpbmUgTFJVX1JFRlNfRkxBR1MJCShMUlVfUkVGU19N
QVNLIHwgQklUKFBHX3JlZmVyZW5jZWQpKQogCiAjaWZkZWYgQ09ORklHX0xSVV9HRU4KIApkaWZm
IC0tZ2l0IGEvbW0vc3dhcC5jIGIvbW0vc3dhcC5jCmluZGV4IGNkOGYwMTUwYmEzYS4uMGE2Zjdi
OWNjOTg3IDEwMDY0NAotLS0gYS9tbS9zd2FwLmMKKysrIGIvbW0vc3dhcC5jCkBAIC00MjQsMTkg
KzQyNCwxNCBAQCBzdGF0aWMgdm9pZCBmb2xpb19pbmNfcmVmcyhzdHJ1Y3QgZm9saW8gKmZvbGlv
KQogCQlyZXR1cm47CiAJfQogCi0JaWYgKCFmb2xpb190ZXN0X3dvcmtpbmdzZXQoZm9saW8pKSB7
Ci0JCWZvbGlvX3NldF93b3JraW5nc2V0KGZvbGlvKTsKLQkJcmV0dXJuOwotCX0KLQogCS8qIHNl
ZSB0aGUgY29tbWVudCBvbiBNQVhfTlJfVElFUlMgKi8KIAlkbyB7Ci0JCW5ld19mbGFncyA9IG9s
ZF9mbGFncyAmIExSVV9SRUZTX01BU0s7Ci0JCWlmIChuZXdfZmxhZ3MgPT0gTFJVX1JFRlNfTUFT
SykKLQkJCWJyZWFrOworCQlpZiAoKG9sZF9mbGFncyAmIExSVV9SRUZTX01BU0spID09IExSVV9S
RUZTX01BU0spIHsKKwkJCWZvbGlvX3NldF93b3JraW5nc2V0KGZvbGlvKTsKKwkJCXJldHVybjsK
KwkJfQogCi0JCW5ld19mbGFncyArPSBCSVQoTFJVX1JFRlNfUEdPRkYpOwotCQluZXdfZmxhZ3Mg
fD0gb2xkX2ZsYWdzICYgfkxSVV9SRUZTX01BU0s7CisJCW5ld19mbGFncyA9IG9sZF9mbGFncyAr
IEJJVChMUlVfUkVGU19QR09GRik7CiAJfSB3aGlsZSAoIXRyeV9jbXB4Y2hnKCZmb2xpby0+Zmxh
Z3MsICZvbGRfZmxhZ3MsIG5ld19mbGFncykpOwogfQogI2Vsc2UKZGlmZiAtLWdpdCBhL21tL3Zt
c2Nhbi5jIGIvbW0vdm1zY2FuLmMKaW5kZXggYmJhMjA3ZjQxYjE0Li44NTA5NzlhNDUyMjkgMTAw
NjQ0Ci0tLSBhL21tL3Ztc2Nhbi5jCisrKyBiL21tL3Ztc2Nhbi5jCkBAIC04MjgsNyArODI4LDYg
QEAgc3RhdGljIGVudW0gZm9saW9fcmVmZXJlbmNlcyBmb2xpb19jaGVja19yZWZlcmVuY2VzKHN0
cnVjdCBmb2xpbyAqZm9saW8sCiAKIAlyZWZlcmVuY2VkX3B0ZXMgPSBmb2xpb19yZWZlcmVuY2Vk
KGZvbGlvLCAxLCBzYy0+dGFyZ2V0X21lbV9jZ3JvdXAsCiAJCQkJCSAgICZ2bV9mbGFncyk7Ci0J
cmVmZXJlbmNlZF9mb2xpbyA9IGZvbGlvX3Rlc3RfY2xlYXJfcmVmZXJlbmNlZChmb2xpbyk7CiAK
IAkvKgogCSAqIFRoZSBzdXBwb3NlZGx5IHJlY2xhaW1hYmxlIGZvbGlvIHdhcyBmb3VuZCB0byBi
ZSBpbiBhIFZNX0xPQ0tFRCB2bWEuCkBAIC04NDEsNiArODQwLDE2IEBAIHN0YXRpYyBlbnVtIGZv
bGlvX3JlZmVyZW5jZXMgZm9saW9fY2hlY2tfcmVmZXJlbmNlcyhzdHJ1Y3QgZm9saW8gKmZvbGlv
LAogCWlmIChyZWZlcmVuY2VkX3B0ZXMgPT0gLTEpCiAJCXJldHVybiBGT0xJT1JFRl9LRUVQOwog
CisJaWYgKGxydV9nZW5fZW5hYmxlZCgpKSB7CisJCWlmICghcmVmZXJlbmNlZF9wdGVzKQorCQkJ
cmV0dXJuIEZPTElPUkVGX1JFQ0xBSU07CisKKwkJbHJ1X2dlbl9hY3RpdmF0ZShmb2xpbyk7CisJ
CXJldHVybiBGT0xJT1JFRl9BQ1RJVkFURTsKKwl9CisKKwlyZWZlcmVuY2VkX2ZvbGlvID0gZm9s
aW9fdGVzdF9jbGVhcl9yZWZlcmVuY2VkKGZvbGlvKTsKKwogCWlmIChyZWZlcmVuY2VkX3B0ZXMp
IHsKIAkJLyoKIAkJICogQWxsIG1hcHBlZCBmb2xpb3Mgc3RhcnQgb3V0IHdpdGggcGFnZSB0YWJs
ZQpAQCAtMTA0NiwxMSArMTA1NSw2IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgc2hyaW5rX2ZvbGlv
X2xpc3Qoc3RydWN0IGxpc3RfaGVhZCAqZm9saW9fbGlzdCwKIAkJaWYgKCFzYy0+bWF5X3VubWFw
ICYmIGZvbGlvX21hcHBlZChmb2xpbykpCiAJCQlnb3RvIGtlZXBfbG9ja2VkOwogCi0JCS8qIGZv
bGlvX3VwZGF0ZV9nZW4oKSB0cmllZCB0byBwcm9tb3RlIHRoaXMgcGFnZT8gKi8KLQkJaWYgKGxy
dV9nZW5fZW5hYmxlZCgpICYmICFpZ25vcmVfcmVmZXJlbmNlcyAmJgotCQkgICAgZm9saW9fbWFw
cGVkKGZvbGlvKSAmJiBmb2xpb190ZXN0X3JlZmVyZW5jZWQoZm9saW8pKQotCQkJZ290byBrZWVw
X2xvY2tlZDsKLQogCQkvKgogCQkgKiBUaGUgbnVtYmVyIG9mIGRpcnR5IHBhZ2VzIGRldGVybWlu
ZXMgaWYgYSBub2RlIGlzIG1hcmtlZAogCQkgKiByZWNsYWltX2Nvbmdlc3RlZC4ga3N3YXBkIHdp
bGwgc3RhbGwgYW5kIHN0YXJ0IHdyaXRpbmcKQEAgLTI1NTcsOCArMjU2MSw2IEBAIHN0YXRpYyBi
b29sIHNob3VsZF9jbGVhcl9wbWRfeW91bmcodm9pZCkKICAqICAgICAgICAgICAgICAgICAgICAg
ICAgICBzaG9ydGhhbmQgaGVscGVycwogICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KIAotI2RlZmlu
ZSBMUlVfUkVGU19GTEFHUwkoQklUKFBHX3JlZmVyZW5jZWQpIHwgQklUKFBHX3dvcmtpbmdzZXQp
KQotCiAjZGVmaW5lIERFRklORV9NQVhfU0VRKGxydXZlYykJCQkJCQlcCiAJdW5zaWduZWQgbG9u
ZyBtYXhfc2VxID0gUkVBRF9PTkNFKChscnV2ZWMpLT5scnVnZW4ubWF4X3NlcSkKIApAQCAtMzA3
NiwxNiArMzA3OCwxOCBAQCBzdGF0aWMgaW50IGZvbGlvX3VwZGF0ZV9nZW4oc3RydWN0IGZvbGlv
ICpmb2xpbywgaW50IGdlbikKIAlWTV9XQVJOX09OX09OQ0UoZ2VuID49IE1BWF9OUl9HRU5TKTsK
IAlWTV9XQVJOX09OX09OQ0UoIXJjdV9yZWFkX2xvY2tfaGVsZCgpKTsKIAorCWlmICghZm9saW9f
dGVzdF9yZWZlcmVuY2VkKGZvbGlvKSAmJiAhZm9saW9fdGVzdF93b3JraW5nc2V0KGZvbGlvKSkg
eworCQlmb2xpb19zZXRfcmVmZXJlbmNlZChmb2xpbyk7CisJCXJldHVybiAtMTsKKwl9CisKIAlk
byB7CiAJCS8qIGxydV9nZW5fZGVsX2ZvbGlvKCkgaGFzIGlzb2xhdGVkIHRoaXMgcGFnZT8gKi8K
LQkJaWYgKCEob2xkX2ZsYWdzICYgTFJVX0dFTl9NQVNLKSkgewotCQkJLyogZm9yIHNocmlua19m
b2xpb19saXN0KCkgKi8KLQkJCW5ld19mbGFncyA9IG9sZF9mbGFncyB8IEJJVChQR19yZWZlcmVu
Y2VkKTsKLQkJCWNvbnRpbnVlOwotCQl9CisJCWlmICghKG9sZF9mbGFncyAmIExSVV9HRU5fTUFT
SykpCisJCQlyZXR1cm4gLTE7CiAKLQkJbmV3X2ZsYWdzID0gb2xkX2ZsYWdzICYgfihMUlVfR0VO
X01BU0sgfCBMUlVfUkVGU19NQVNLIHwgTFJVX1JFRlNfRkxBR1MpOwotCQluZXdfZmxhZ3MgfD0g
KGdlbiArIDFVTCkgPDwgTFJVX0dFTl9QR09GRjsKKwkJbmV3X2ZsYWdzID0gb2xkX2ZsYWdzICYg
fihMUlVfR0VOX01BU0sgfCBMUlVfUkVGU19GTEFHUyk7CisJCW5ld19mbGFncyB8PSAoKGdlbiAr
IDFVTCkgPDwgTFJVX0dFTl9QR09GRikgfCBCSVQoUEdfd29ya2luZ3NldCk7CiAJfSB3aGlsZSAo
IXRyeV9jbXB4Y2hnKCZmb2xpby0+ZmxhZ3MsICZvbGRfZmxhZ3MsIG5ld19mbGFncykpOwogCiAJ
cmV0dXJuICgob2xkX2ZsYWdzICYgTFJVX0dFTl9NQVNLKSA+PiBMUlVfR0VOX1BHT0ZGKSAtIDE7
CkBAIC0zMTA5LDcgKzMxMTMsNyBAQCBzdGF0aWMgaW50IGZvbGlvX2luY19nZW4oc3RydWN0IGxy
dXZlYyAqbHJ1dmVjLCBzdHJ1Y3QgZm9saW8gKmZvbGlvLCBib29sIHJlY2xhaQogCiAJCW5ld19n
ZW4gPSAob2xkX2dlbiArIDEpICUgTUFYX05SX0dFTlM7CiAKLQkJbmV3X2ZsYWdzID0gb2xkX2Zs
YWdzICYgfihMUlVfR0VOX01BU0sgfCBMUlVfUkVGU19NQVNLIHwgTFJVX1JFRlNfRkxBR1MpOwor
CQluZXdfZmxhZ3MgPSBvbGRfZmxhZ3MgJiB+KExSVV9HRU5fTUFTSyB8IExSVV9SRUZTX0ZMQUdT
KTsKIAkJbmV3X2ZsYWdzIHw9IChuZXdfZ2VuICsgMVVMKSA8PCBMUlVfR0VOX1BHT0ZGOwogCQkv
KiBmb3IgZm9saW9fZW5kX3dyaXRlYmFjaygpICovCiAJCWlmIChyZWNsYWltaW5nKQpAQCAtMzI4
NCw2ICszMjg4LDkgQEAgc3RhdGljIHN0cnVjdCBmb2xpbyAqZ2V0X3Bmbl9mb2xpbyh1bnNpZ25l
ZCBsb25nIHBmbiwgc3RydWN0IG1lbV9jZ3JvdXAgKm1lbWNnLAogCWlmIChmb2xpb19tZW1jZ19y
Y3UoZm9saW8pICE9IG1lbWNnKQogCQlyZXR1cm4gTlVMTDsKIAorCWlmICghZm9saW9fdGVzdF9s
cnUoZm9saW8pKQorCQlyZXR1cm4gTlVMTDsKKwogCS8qIGZpbGUgVk1BcyBjYW4gY29udGFpbiBh
bm9uIHBhZ2VzIGZyb20gQ09XICovCiAJaWYgKCFmb2xpb19pc19maWxlX2xydShmb2xpbykgJiYg
IWNhbl9zd2FwKQogCQlyZXR1cm4gTlVMTDsKQEAgLTQwMzIsMTEgKzQwMzksMTEgQEAgdm9pZCBs
cnVfZ2VuX2xvb2tfYXJvdW5kKHN0cnVjdCBwYWdlX3ZtYV9tYXBwZWRfd2FsayAqcHZtdykKIAkJ
CWNvbnRpbnVlOwogCQl9CiAKLQkJb2xkX2dlbiA9IGZvbGlvX2xydV9nZW4oZm9saW8pOwotCQlp
ZiAob2xkX2dlbiA8IDApCi0JCQlmb2xpb19zZXRfcmVmZXJlbmNlZChmb2xpbyk7Ci0JCWVsc2Ug
aWYgKG9sZF9nZW4gIT0gbmV3X2dlbikKLQkJCWZvbGlvX2FjdGl2YXRlKGZvbGlvKTsKKwkJaWYg
KGxydV9nZW5fYWN0aXZhdGUoZm9saW8pKSB7CisJCQlvbGRfZ2VuID0gZm9saW9fbHJ1X2dlbihm
b2xpbyk7CisJCQlpZiAob2xkX2dlbiA+PSAwICYmIG9sZF9nZW4gIT0gbmV3X2dlbikKKwkJCQlm
b2xpb19hY3RpdmF0ZShmb2xpbyk7CisJCX0KIAl9CiAKIAlhcmNoX2xlYXZlX2xhenlfbW11X21v
ZGUoKTsKQEAgLTQyMDYsNyArNDIxMyw4IEBAIHN0YXRpYyBib29sIHNvcnRfZm9saW8oc3RydWN0
IGxydXZlYyAqbHJ1dmVjLCBzdHJ1Y3QgZm9saW8gKmZvbGlvLCBzdHJ1Y3Qgc2Nhbl9jCiAJaW50
IHpvbmUgPSBmb2xpb196b25lbnVtKGZvbGlvKTsKIAlpbnQgZGVsdGEgPSBmb2xpb19ucl9wYWdl
cyhmb2xpbyk7CiAJaW50IHJlZnMgPSBmb2xpb19scnVfcmVmcyhmb2xpbyk7Ci0JaW50IHRpZXIg
PSBscnVfdGllcl9mcm9tX3JlZnMocmVmcyk7CisJYm9vbCB3b3JraW5nc2V0ID0gZm9saW9fdGVz
dF93b3JraW5nc2V0KGZvbGlvKTsKKwlpbnQgdGllciA9IGxydV90aWVyX2Zyb21fcmVmcyhyZWZz
LCB3b3JraW5nc2V0KTsKIAlzdHJ1Y3QgbHJ1X2dlbl9mb2xpbyAqbHJ1Z2VuID0gJmxydXZlYy0+
bHJ1Z2VuOwogCiAJVk1fV0FSTl9PTl9PTkNFX0ZPTElPKGdlbiA+PSBNQVhfTlJfR0VOUywgZm9s
aW8pOwpAQCAtNDIzNyw3ICs0MjQ1LDcgQEAgc3RhdGljIGJvb2wgc29ydF9mb2xpbyhzdHJ1Y3Qg
bHJ1dmVjICpscnV2ZWMsIHN0cnVjdCBmb2xpbyAqZm9saW8sIHN0cnVjdCBzY2FuX2MKIAl9CiAK
IAkvKiBwcm90ZWN0ZWQgKi8KLQlpZiAodGllciA+IHRpZXJfaWR4IHx8IHJlZnMgPT0gQklUKExS
VV9SRUZTX1dJRFRIKSkgeworCWlmICh0aWVyID4gdGllcl9pZHggfHwgcmVmcyArIHdvcmtpbmdz
ZXQgPT0gQklUKExSVV9SRUZTX1dJRFRIKSkgewogCQlpbnQgaGlzdCA9IGxydV9oaXN0X2Zyb21f
c2VxKGxydWdlbi0+bWluX3NlcVt0eXBlXSk7CiAKIAkJZ2VuID0gZm9saW9faW5jX2dlbihscnV2
ZWMsIGZvbGlvLCBmYWxzZSk7CkBAIC00Mjg4LDExICs0Mjk2LDEwIEBAIHN0YXRpYyBib29sIGlz
b2xhdGVfZm9saW8oc3RydWN0IGxydXZlYyAqbHJ1dmVjLCBzdHJ1Y3QgZm9saW8gKmZvbGlvLCBz
dHJ1Y3Qgc2NhCiAKIAkvKiBzZWUgdGhlIGNvbW1lbnQgb24gTUFYX05SX1RJRVJTICovCiAJaWYg
KCFmb2xpb190ZXN0X3JlZmVyZW5jZWQoZm9saW8pKQotCQlzZXRfbWFza19iaXRzKCZmb2xpby0+
ZmxhZ3MsIExSVV9SRUZTX01BU0sgfCBMUlVfUkVGU19GTEFHUywgMCk7CisJCXNldF9tYXNrX2Jp
dHMoJmZvbGlvLT5mbGFncywgTFJVX1JFRlNfTUFTSywgMCk7CiAKIAkvKiBmb3Igc2hyaW5rX2Zv
bGlvX2xpc3QoKSAqLwogCWZvbGlvX2NsZWFyX3JlY2xhaW0oZm9saW8pOwotCWZvbGlvX2NsZWFy
X3JlZmVyZW5jZWQoZm9saW8pOwogCiAJc3VjY2VzcyA9IGxydV9nZW5fZGVsX2ZvbGlvKGxydXZl
YywgZm9saW8sIHRydWUpOwogCVZNX1dBUk5fT05fT05DRV9GT0xJTyghc3VjY2VzcywgZm9saW8p
OwpAQCAtNDUxNCwyMCArNDUyMSwxNSBAQCBzdGF0aWMgaW50IGV2aWN0X2ZvbGlvcyhzdHJ1Y3Qg
bHJ1dmVjICpscnV2ZWMsIHN0cnVjdCBzY2FuX2NvbnRyb2wgKnNjLCBpbnQgc3dhcAogCQkJY29u
dGludWU7CiAJCX0KIAotCQlpZiAoZm9saW9fdGVzdF9yZWNsYWltKGZvbGlvKSAmJgotCQkgICAg
KGZvbGlvX3Rlc3RfZGlydHkoZm9saW8pIHx8IGZvbGlvX3Rlc3Rfd3JpdGViYWNrKGZvbGlvKSkp
IHsKLQkJCS8qIHJlc3RvcmUgTFJVX1JFRlNfRkxBR1MgY2xlYXJlZCBieSBpc29sYXRlX2ZvbGlv
KCkgKi8KLQkJCWlmIChmb2xpb190ZXN0X3dvcmtpbmdzZXQoZm9saW8pKQotCQkJCWZvbGlvX3Nl
dF9yZWZlcmVuY2VkKGZvbGlvKTsKKwkJaWYgKGZvbGlvX3Rlc3RfYWN0aXZlKGZvbGlvKSB8fAor
CQkgICAgKHR5cGUgPT0gTFJVX0dFTl9BTk9OICYmICFmb2xpb190ZXN0X3N3YXBjYWNoZShmb2xp
bykpIHx8CisJCSAgICAoZm9saW9fdGVzdF9yZWNsYWltKGZvbGlvKSAmJgorCQkgICAgIChmb2xp
b190ZXN0X2RpcnR5KGZvbGlvKSB8fCBmb2xpb190ZXN0X3dyaXRlYmFjayhmb2xpbykpKSkKIAkJ
CWNvbnRpbnVlOwotCQl9CiAKLQkJaWYgKHNraXBfcmV0cnkgfHwgZm9saW9fdGVzdF9hY3RpdmUo
Zm9saW8pIHx8IGZvbGlvX3Rlc3RfcmVmZXJlbmNlZChmb2xpbykgfHwKLQkJICAgIGZvbGlvX21h
cHBlZChmb2xpbykgfHwgZm9saW9fdGVzdF9sb2NrZWQoZm9saW8pIHx8Ci0JCSAgICBmb2xpb190
ZXN0X2RpcnR5KGZvbGlvKSB8fCBmb2xpb190ZXN0X3dyaXRlYmFjayhmb2xpbykpIHsKKwkJaWYg
KHNraXBfcmV0cnkpIHsKIAkJCS8qIGRvbid0IGFkZCByZWplY3RlZCBmb2xpb3MgdG8gdGhlIG9s
ZGVzdCBnZW5lcmF0aW9uICovCi0JCQlzZXRfbWFza19iaXRzKCZmb2xpby0+ZmxhZ3MsIExSVV9S
RUZTX01BU0sgfCBMUlVfUkVGU19GTEFHUywKLQkJCQkgICAgICBCSVQoUEdfYWN0aXZlKSk7CisJ
CQlmb2xpb19zZXRfYWN0aXZlKGZvbGlvKTsKIAkJCWNvbnRpbnVlOwogCQl9CiAKQEAgLTQ1NzAs
OSArNDU3Miw3IEBAIHN0YXRpYyBib29sIHNob3VsZF9ydW5fYWdpbmcoc3RydWN0IGxydXZlYyAq
bHJ1dmVjLCB1bnNpZ25lZCBsb25nIG1heF9zZXEsCiAJCQkgICAgIHN0cnVjdCBzY2FuX2NvbnRy
b2wgKnNjLCBib29sIGNhbl9zd2FwLCB1bnNpZ25lZCBsb25nICpucl90b19zY2FuKQogewogCWlu
dCBnZW4sIHR5cGUsIHpvbmU7Ci0JdW5zaWduZWQgbG9uZyBvbGQgPSAwOwotCXVuc2lnbmVkIGxv
bmcgeW91bmcgPSAwOwotCXVuc2lnbmVkIGxvbmcgdG90YWwgPSAwOworCXVuc2lnbmVkIGxvbmcg
c2l6ZSA9IDA7CiAJc3RydWN0IGxydV9nZW5fZm9saW8gKmxydWdlbiA9ICZscnV2ZWMtPmxydWdl
bjsKIAlzdHJ1Y3QgbWVtX2Nncm91cCAqbWVtY2cgPSBscnV2ZWNfbWVtY2cobHJ1dmVjKTsKIAlE
RUZJTkVfTUlOX1NFUShscnV2ZWMpOwpAQCAtNDU4Nyw1MCArNDU4NywyMSBAQCBzdGF0aWMgYm9v
bCBzaG91bGRfcnVuX2FnaW5nKHN0cnVjdCBscnV2ZWMgKmxydXZlYywgdW5zaWduZWQgbG9uZyBt
YXhfc2VxLAogCQl1bnNpZ25lZCBsb25nIHNlcTsKIAogCQlmb3IgKHNlcSA9IG1pbl9zZXFbdHlw
ZV07IHNlcSA8PSBtYXhfc2VxOyBzZXErKykgewotCQkJdW5zaWduZWQgbG9uZyBzaXplID0gMDsK
LQogCQkJZ2VuID0gbHJ1X2dlbl9mcm9tX3NlcShzZXEpOwogCiAJCQlmb3IgKHpvbmUgPSAwOyB6
b25lIDwgTUFYX05SX1pPTkVTOyB6b25lKyspCiAJCQkJc2l6ZSArPSBtYXgoUkVBRF9PTkNFKGxy
dWdlbi0+bnJfcGFnZXNbZ2VuXVt0eXBlXVt6b25lXSksIDBMKTsKLQotCQkJdG90YWwgKz0gc2l6
ZTsKLQkJCWlmIChzZXEgPT0gbWF4X3NlcSkKLQkJCQl5b3VuZyArPSBzaXplOwotCQkJZWxzZSBp
ZiAoc2VxICsgTUlOX05SX0dFTlMgPT0gbWF4X3NlcSkKLQkJCQlvbGQgKz0gc2l6ZTsKIAkJfQog
CX0KIAogCS8qIHRyeSB0byBzY3JhcGUgYWxsIGl0cyBtZW1vcnkgaWYgdGhpcyBtZW1jZyB3YXMg
ZGVsZXRlZCAqLwogCWlmICghbWVtX2Nncm91cF9vbmxpbmUobWVtY2cpKSB7Ci0JCSpucl90b19z
Y2FuID0gdG90YWw7CisJCSpucl90b19zY2FuID0gc2l6ZTsKIAkJcmV0dXJuIGZhbHNlOwogCX0K
IAotCSpucl90b19zY2FuID0gdG90YWwgPj4gc2MtPnByaW9yaXR5OwotCi0JLyoKLQkgKiBUaGUg
YWdpbmcgdHJpZXMgdG8gYmUgbGF6eSB0byByZWR1Y2UgdGhlIG92ZXJoZWFkLCB3aGlsZSB0aGUg
ZXZpY3Rpb24KLQkgKiBzdGFsbHMgd2hlbiB0aGUgbnVtYmVyIG9mIGdlbmVyYXRpb25zIHJlYWNo
ZXMgTUlOX05SX0dFTlMuIEhlbmNlLCB0aGUKLQkgKiBpZGVhbCBudW1iZXIgb2YgZ2VuZXJhdGlv
bnMgaXMgTUlOX05SX0dFTlMrMS4KLQkgKi8KLQlpZiAobWluX3NlcVshY2FuX3N3YXBdICsgTUlO
X05SX0dFTlMgPCBtYXhfc2VxKQotCQlyZXR1cm4gZmFsc2U7Ci0KLQkvKgotCSAqIEl0J3MgYWxz
byBpZGVhbCB0byBzcHJlYWQgcGFnZXMgb3V0IGV2ZW5seSwgaS5lLiwgMS8oTUlOX05SX0dFTlMr
MSkKLQkgKiBvZiB0aGUgdG90YWwgbnVtYmVyIG9mIHBhZ2VzIGZvciBlYWNoIGdlbmVyYXRpb24u
IEEgcmVhc29uYWJsZSByYW5nZQotCSAqIGZvciB0aGlzIGF2ZXJhZ2UgcG9ydGlvbiBpcyBbMS9N
SU5fTlJfR0VOUywgMS8oTUlOX05SX0dFTlMrMildLiBUaGUKLQkgKiBhZ2luZyBjYXJlcyBhYm91
dCB0aGUgdXBwZXIgYm91bmQgb2YgaG90IHBhZ2VzLCB3aGlsZSB0aGUgZXZpY3Rpb24KLQkgKiBj
YXJlcyBhYm91dCB0aGUgbG93ZXIgYm91bmQgb2YgY29sZCBwYWdlcy4KLQkgKi8KLQlpZiAoeW91
bmcgKiBNSU5fTlJfR0VOUyA+IHRvdGFsKQotCQlyZXR1cm4gdHJ1ZTsKLQlpZiAob2xkICogKE1J
Tl9OUl9HRU5TICsgMikgPCB0b3RhbCkKLQkJcmV0dXJuIHRydWU7Ci0KLQlyZXR1cm4gZmFsc2U7
CisJKm5yX3RvX3NjYW4gPSBzaXplID4+IHNjLT5wcmlvcml0eTsKKwlyZXR1cm4gbWluX3NlcVsh
Y2FuX3N3YXBdICsgTUlOX05SX0dFTlMgPT0gbWF4X3NlcTsKIH0KIAogLyoKZGlmZiAtLWdpdCBh
L21tL3dvcmtpbmdzZXQuYyBiL21tL3dvcmtpbmdzZXQuYwppbmRleCAzM2JhYWQyMDMyNzcuLjc1
NzE3M2I0YTA2ZSAxMDA2NDQKLS0tIGEvbW0vd29ya2luZ3NldC5jCisrKyBiL21tL3dvcmtpbmdz
ZXQuYwpAQCAtMjM4LDcgKzIzOCw4IEBAIHN0YXRpYyB2b2lkICpscnVfZ2VuX2V2aWN0aW9uKHN0
cnVjdCBmb2xpbyAqZm9saW8pCiAJaW50IHR5cGUgPSBmb2xpb19pc19maWxlX2xydShmb2xpbyk7
CiAJaW50IGRlbHRhID0gZm9saW9fbnJfcGFnZXMoZm9saW8pOwogCWludCByZWZzID0gZm9saW9f
bHJ1X3JlZnMoZm9saW8pOwotCWludCB0aWVyID0gbHJ1X3RpZXJfZnJvbV9yZWZzKHJlZnMpOwor
CWJvb2wgd29ya2luZ3NldCA9IGZvbGlvX3Rlc3Rfd29ya2luZ3NldChmb2xpbyk7CisJaW50IHRp
ZXIgPSBscnVfdGllcl9mcm9tX3JlZnMocmVmcywgd29ya2luZ3NldCk7CiAJc3RydWN0IG1lbV9j
Z3JvdXAgKm1lbWNnID0gZm9saW9fbWVtY2coZm9saW8pOwogCXN0cnVjdCBwZ2xpc3RfZGF0YSAq
cGdkYXQgPSBmb2xpb19wZ2RhdChmb2xpbyk7CiAKQEAgLTI0NywyMyArMjQ4LDIzIEBAIHN0YXRp
YyB2b2lkICpscnVfZ2VuX2V2aWN0aW9uKHN0cnVjdCBmb2xpbyAqZm9saW8pCiAJbHJ1dmVjID0g
bWVtX2Nncm91cF9scnV2ZWMobWVtY2csIHBnZGF0KTsKIAlscnVnZW4gPSAmbHJ1dmVjLT5scnVn
ZW47CiAJbWluX3NlcSA9IFJFQURfT05DRShscnVnZW4tPm1pbl9zZXFbdHlwZV0pOwotCXRva2Vu
ID0gKG1pbl9zZXEgPDwgTFJVX1JFRlNfV0lEVEgpIHwgbWF4KHJlZnMgLSAxLCAwKTsKKwl0b2tl
biA9IChtaW5fc2VxIDw8IExSVV9SRUZTX1dJRFRIKSB8IHJlZnM7CiAKIAloaXN0ID0gbHJ1X2hp
c3RfZnJvbV9zZXEobWluX3NlcSk7CiAJYXRvbWljX2xvbmdfYWRkKGRlbHRhLCAmbHJ1Z2VuLT5l
dmljdGVkW2hpc3RdW3R5cGVdW3RpZXJdKTsKIAotCXJldHVybiBwYWNrX3NoYWRvdyhtZW1fY2dy
b3VwX2lkKG1lbWNnKSwgcGdkYXQsIHRva2VuLCByZWZzKTsKKwlyZXR1cm4gcGFja19zaGFkb3co
bWVtX2Nncm91cF9pZChtZW1jZyksIHBnZGF0LCB0b2tlbiwgd29ya2luZ3NldCk7CiB9CiAKIC8q
CiAgKiBUZXN0cyBpZiB0aGUgc2hhZG93IGVudHJ5IGlzIGZvciBhIGZvbGlvIHRoYXQgd2FzIHJl
Y2VudGx5IGV2aWN0ZWQuCiAgKiBGaWxscyBpbiBAbHJ1dmVjLCBAdG9rZW4sIEB3b3JraW5nc2V0
IHdpdGggdGhlIHZhbHVlcyB1bnBhY2tlZCBmcm9tIHNoYWRvdy4KICAqLwotc3RhdGljIGJvb2wg
bHJ1X2dlbl90ZXN0X3JlY2VudCh2b2lkICpzaGFkb3csIGJvb2wgZmlsZSwgc3RydWN0IGxydXZl
YyAqKmxydXZlYywKK3N0YXRpYyBib29sIGxydV9nZW5fdGVzdF9yZWNlbnQodm9pZCAqc2hhZG93
LCBzdHJ1Y3QgbHJ1dmVjICoqbHJ1dmVjLAogCQkJCXVuc2lnbmVkIGxvbmcgKnRva2VuLCBib29s
ICp3b3JraW5nc2V0KQogewogCWludCBtZW1jZ19pZDsKLQl1bnNpZ25lZCBsb25nIG1pbl9zZXE7
CisJdW5zaWduZWQgbG9uZyBtYXhfc2VxOwogCXN0cnVjdCBtZW1fY2dyb3VwICptZW1jZzsKIAlz
dHJ1Y3QgcGdsaXN0X2RhdGEgKnBnZGF0OwogCkBAIC0yNzIsOCArMjczLDkgQEAgc3RhdGljIGJv
b2wgbHJ1X2dlbl90ZXN0X3JlY2VudCh2b2lkICpzaGFkb3csIGJvb2wgZmlsZSwgc3RydWN0IGxy
dXZlYyAqKmxydXZlYywKIAltZW1jZyA9IG1lbV9jZ3JvdXBfZnJvbV9pZChtZW1jZ19pZCk7CiAJ
KmxydXZlYyA9IG1lbV9jZ3JvdXBfbHJ1dmVjKG1lbWNnLCBwZ2RhdCk7CiAKLQltaW5fc2VxID0g
UkVBRF9PTkNFKCgqbHJ1dmVjKS0+bHJ1Z2VuLm1pbl9zZXFbZmlsZV0pOwotCXJldHVybiAoKnRv
a2VuID4+IExSVV9SRUZTX1dJRFRIKSA9PSAobWluX3NlcSAmIChFVklDVElPTl9NQVNLID4+IExS
VV9SRUZTX1dJRFRIKSk7CisJbWF4X3NlcSA9IFJFQURfT05DRSgoKmxydXZlYyktPmxydWdlbi5t
YXhfc2VxKTsKKwlyZXR1cm4gYWJzX2RpZmYobWF4X3NlcSAmIChFVklDVElPTl9NQVNLID4+IExS
VV9SRUZTX1dJRFRIKSwKKwkJCSp0b2tlbiA+PiBMUlVfUkVGU19XSURUSCkgPCBNQVhfTlJfR0VO
UzsKIH0KIAogc3RhdGljIHZvaWQgbHJ1X2dlbl9yZWZhdWx0KHN0cnVjdCBmb2xpbyAqZm9saW8s
IHZvaWQgKnNoYWRvdykKQEAgLTI4OSw3ICsyOTEsNyBAQCBzdGF0aWMgdm9pZCBscnVfZ2VuX3Jl
ZmF1bHQoc3RydWN0IGZvbGlvICpmb2xpbywgdm9pZCAqc2hhZG93KQogCiAJcmN1X3JlYWRfbG9j
aygpOwogCi0JcmVjZW50ID0gbHJ1X2dlbl90ZXN0X3JlY2VudChzaGFkb3csIHR5cGUsICZscnV2
ZWMsICZ0b2tlbiwgJndvcmtpbmdzZXQpOworCXJlY2VudCA9IGxydV9nZW5fdGVzdF9yZWNlbnQo
c2hhZG93LCAmbHJ1dmVjLCAmdG9rZW4sICZ3b3JraW5nc2V0KTsKIAlpZiAobHJ1dmVjICE9IGZv
bGlvX2xydXZlYyhmb2xpbykpCiAJCWdvdG8gdW5sb2NrOwogCkBAIC0zMDIsOCArMzA0LDggQEAg
c3RhdGljIHZvaWQgbHJ1X2dlbl9yZWZhdWx0KHN0cnVjdCBmb2xpbyAqZm9saW8sIHZvaWQgKnNo
YWRvdykKIAogCWhpc3QgPSBscnVfaGlzdF9mcm9tX3NlcShSRUFEX09OQ0UobHJ1Z2VuLT5taW5f
c2VxW3R5cGVdKSk7CiAJLyogc2VlIHRoZSBjb21tZW50IGluIGZvbGlvX2xydV9yZWZzKCkgKi8K
LQlyZWZzID0gKHRva2VuICYgKEJJVChMUlVfUkVGU19XSURUSCkgLSAxKSkgKyB3b3JraW5nc2V0
OwotCXRpZXIgPSBscnVfdGllcl9mcm9tX3JlZnMocmVmcyk7CisJcmVmcyA9IHRva2VuICYgKEJJ
VChMUlVfUkVGU19XSURUSCkgLSAxKTsKKwl0aWVyID0gbHJ1X3RpZXJfZnJvbV9yZWZzKHJlZnMs
IHdvcmtpbmdzZXQpOwogCiAJYXRvbWljX2xvbmdfYWRkKGRlbHRhLCAmbHJ1Z2VuLT5yZWZhdWx0
ZWRbaGlzdF1bdHlwZV1bdGllcl0pOwogCW1vZF9scnV2ZWNfc3RhdGUobHJ1dmVjLCBXT1JLSU5H
U0VUX0FDVElWQVRFX0JBU0UgKyB0eXBlLCBkZWx0YSk7CkBAIC0zMTUsMTAgKzMxNywxMSBAQCBz
dGF0aWMgdm9pZCBscnVfZ2VuX3JlZmF1bHQoc3RydWN0IGZvbGlvICpmb2xpbywgdm9pZCAqc2hh
ZG93KQogCSAqIDIuIEZvciBwYWdlcyBhY2Nlc3NlZCBtdWx0aXBsZSB0aW1lcyB0aHJvdWdoIGZp
bGUgZGVzY3JpcHRvcnMsCiAJICogICAgdGhleSB3b3VsZCBoYXZlIGJlZW4gcHJvdGVjdGVkIGJ5
IHNvcnRfZm9saW8oKS4KIAkgKi8KLQlpZiAobHJ1X2dlbl9pbl9mYXVsdCgpIHx8IHJlZnMgPj0g
QklUKExSVV9SRUZTX1dJRFRIKSAtIDEpIHsKLQkJc2V0X21hc2tfYml0cygmZm9saW8tPmZsYWdz
LCAwLCBMUlVfUkVGU19NQVNLIHwgQklUKFBHX3dvcmtpbmdzZXQpKTsKKwlpZiAobHJ1X2dlbl9p
bl9mYXVsdCgpIHx8IHJlZnMgPT0gQklUKExSVV9SRUZTX1dJRFRIKSAtIDEpIHsKKwkJZm9saW9f
c2V0X3dvcmtpbmdzZXQoZm9saW8pOwogCQltb2RfbHJ1dmVjX3N0YXRlKGxydXZlYywgV09SS0lO
R1NFVF9SRVNUT1JFX0JBU0UgKyB0eXBlLCBkZWx0YSk7Ci0JfQorCX0gZWxzZSBpZiAocmVmcykK
KwkJc2V0X21hc2tfYml0cygmZm9saW8tPmZsYWdzLCBMUlVfUkVGU19NQVNLLCByZWZzIDw8IExS
VV9SRUZTX1BHT0ZGKTsKIHVubG9jazoKIAlyY3VfcmVhZF91bmxvY2soKTsKIH0KQEAgLTMzMCw3
ICszMzMsNyBAQCBzdGF0aWMgdm9pZCAqbHJ1X2dlbl9ldmljdGlvbihzdHJ1Y3QgZm9saW8gKmZv
bGlvKQogCXJldHVybiBOVUxMOwogfQogCi1zdGF0aWMgYm9vbCBscnVfZ2VuX3Rlc3RfcmVjZW50
KHZvaWQgKnNoYWRvdywgYm9vbCBmaWxlLCBzdHJ1Y3QgbHJ1dmVjICoqbHJ1dmVjLAorc3RhdGlj
IGJvb2wgbHJ1X2dlbl90ZXN0X3JlY2VudCh2b2lkICpzaGFkb3csIHN0cnVjdCBscnV2ZWMgKips
cnV2ZWMsCiAJCQkJdW5zaWduZWQgbG9uZyAqdG9rZW4sIGJvb2wgKndvcmtpbmdzZXQpCiB7CiAJ
cmV0dXJuIGZhbHNlOwpAQCAtNDI2LDcgKzQyOSw3IEBAIGJvb2wgd29ya2luZ3NldF90ZXN0X3Jl
Y2VudCh2b2lkICpzaGFkb3csIGJvb2wgZmlsZSwgYm9vbCAqd29ya2luZ3NldCkKIAl1bnNpZ25l
ZCBsb25nIGV2aWN0aW9uOwogCiAJaWYgKGxydV9nZW5fZW5hYmxlZCgpKQotCQlyZXR1cm4gbHJ1
X2dlbl90ZXN0X3JlY2VudChzaGFkb3csIGZpbGUsICZldmljdGlvbl9scnV2ZWMsICZldmljdGlv
biwgd29ya2luZ3NldCk7CisJCXJldHVybiBscnVfZ2VuX3Rlc3RfcmVjZW50KHNoYWRvdywgJmV2
aWN0aW9uX2xydXZlYywgJmV2aWN0aW9uLCB3b3JraW5nc2V0KTsKIAogCXVucGFja19zaGFkb3co
c2hhZG93LCAmbWVtY2dpZCwgJnBnZGF0LCAmZXZpY3Rpb24sIHdvcmtpbmdzZXQpOwogCWV2aWN0
aW9uIDw8PSBidWNrZXRfb3JkZXI7Cg==
--000000000000d7cb50060ea62231--

