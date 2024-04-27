Return-Path: <linux-kernel+bounces-161062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C288B4694
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6C71F247C8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB484F8A3;
	Sat, 27 Apr 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyH488HP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D022032A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714227229; cv=none; b=P80GzpR4j0ajbHXqcWPN8+gAZ5kRYE63Fx45oVt89kU6md+qmOAzj02/AOL5cOQdqRXUKUSuyFvonwz+5twlALDWsZeLqcKJAJYb1F0eWPwnSZXzs1bi0JVvt1JWwYd759WQDexxy07XS6ZaIj4pOP7kH46E5FS37Rbkxcj7Tsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714227229; c=relaxed/simple;
	bh=d+3n9UZfA+VHX1B+2z7z9tf7+zE4wxd4K78Oea2WZ/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMx7Vk1LqtTUW5fI4iZL/ES++kWZL8Ar3VwbTmB4ocsyNJ1iBJGgzX8UgJL1S2SjzgCB1GPa876dWAOjd4XyUGHezdzIKIU9+rdhQfjFPmcYx90RxYh2xg/SIrEQhZulDqZzZjfAaapTbc9eZ4rpZaedDjXah2z2Gmyk5VNgpI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HyH488HP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714227227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXMypIwiegUqOtpslqLpUy8xSEb8Llb9TidhERCUP+M=;
	b=HyH488HPNu5QclA6YE3uKkNo6kBQHszfAZJBnWpDGPBglCTu8QRuveeNd1khlEmg2TvqDa
	rFWfzpE9EyXS6Nd3YUa13QLxale+Tkkxi42SFGiaeQWdU+RDSCvTK7TlU+h3v4pGtDuXTJ
	g+nCjXLaoLZFgJpgWft5l94AewkinDA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-g48KcNn0NMe4O9_uliiI5w-1; Sat, 27 Apr 2024 10:13:42 -0400
X-MC-Unique: g48KcNn0NMe4O9_uliiI5w-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-de5823bd7eeso6435401276.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 07:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714227222; x=1714832022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXMypIwiegUqOtpslqLpUy8xSEb8Llb9TidhERCUP+M=;
        b=k85q2PwW4DPoCKLrBk3jWkmIyx+v239unWZlpvU6egFFRvYaGYaL/eHgm2ekYCdmkJ
         A4nHpOrHfWPB4dzoeG6KAwiF2GjQy4M3bkOdneu5euVqMK4F1kMEs4L09flmTcvn+Pce
         dv0ZBDXjaqJlF+Uur52v+7DHEr8iU2uggJ9bqxFNtRL6RlBs8SLBLle54O478jhEjPI3
         v0EbWRG85owC3oG/Q6Zk9KYFsAH7xsZu/MWsd9S2g7D4F6+Jd9tenfoKs1Urekwb/Nbu
         02wywTelpMCKOoKR7nttaS/BOf4GXmsP0/19BZOM3/6oCSyT/o9qGZXMyGPVL2QThnrc
         op+w==
X-Forwarded-Encrypted: i=1; AJvYcCWjejP86m6JnR7FVtKqNSoiJzv3oN7ldqvQ53gz29Bg2UhM9knSnskD9wzB4M/wzKQvru/kCrRwyLfY1ToU5KIY7+bagiqsD2JF9KCg
X-Gm-Message-State: AOJu0YwcZ36aSIVQueUOsDGBRWmcDmG4uwBKPMwt/s7k+/phQ75TRAah
	NNBTEetNKIFRcWisozxawOBiYUetQ6nL8MHeNItaGxrPW3QjOmdiwpU47qFakNHDu6yXvAy2HcH
	0rzbmSE8294KcAnbnGCcatbDE80zpgE1g2Q6MthrSujgaCBNzL8lTmN5GPu4sH7LOneUe8yeyYC
	JAII3+muUA1erhKzeLYgc8AQUVmynI/4GceVzc
X-Received: by 2002:a05:6902:1611:b0:dc6:e1ed:bd1c with SMTP id bw17-20020a056902161100b00dc6e1edbd1cmr2046679ybb.21.1714227221973;
        Sat, 27 Apr 2024 07:13:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOaakH4d+LaeLNo52h6Gxinx2ybJegK2Mwwom9kD+jJ+azyRkUfpoyYFCx3mWohB2H42zgnIbu8s/UEv/e7Yo=
X-Received: by 2002:a05:6902:1611:b0:dc6:e1ed:bd1c with SMTP id
 bw17-20020a056902161100b00dc6e1edbd1cmr2046668ybb.21.1714227221686; Sat, 27
 Apr 2024 07:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405164920.2844-1-mcassell411@gmail.com> <CAHrQN1xuLfc0sfe1kMHmHrBzKQLMD-6PNEakA=EDdabEv4ATnQ@mail.gmail.com>
 <CANiscBDGqwMvbNUXydKMMgXdwSNeXDQOGy=jgdOJCNh7+WaSvg@mail.gmail.com>
In-Reply-To: <CANiscBDGqwMvbNUXydKMMgXdwSNeXDQOGy=jgdOJCNh7+WaSvg@mail.gmail.com>
From: Vratislav Bendel <vbendel@redhat.com>
Date: Sat, 27 Apr 2024 16:13:25 +0200
Message-ID: <CAHrQN1ximY20i9EiOgbmTQcgdEpfsZarjKczE15pyUp0Zc7=2g@mail.gmail.com>
Subject: Re: [PATCH] Documentation/admin-guide/sysctl/vm.rst adding the
 importance of NUMA-node count to documentation
To: Matthew Cassell <mcassell411@gmail.com>
Cc: corbet@lwn.net, akpm@linux-foundation.org, rppt@kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(plain text resend)

IMHO you went too encyclopedia-style this time. :)
My extra point was just to elaborate on what the "additional actions" means=
,
but I would suggest keeping it as concise as possible.
Also the bit values are already explained - no need to repeat that.


On Fri, Apr 12, 2024 at 10:48=E2=80=AFPM Matthew Cassell <mcassell411@gmail=
com> wrote:
>
> Thanks for the feedback. Here is a quick outline I came up with on your
> advice:
>
> [...] (original content)
>
> Keep in mind enabling bits in zone_reclaim_mode makes the most sense
> for topologies consisting of multiple NUMA nodes. In addition to vanilla
> zone_reclaim (clean and unmapped pages), there exist additional bits that
> expand which pages are eligible to be reclaimed and dictate scan_control
> policy during the reclaim process. The page allocator will attempt to rec=
laim
> memory locally in accordance with these bits before attempting to allocat=
e
> on remote nodes.
>
> Allow dirty pages to become candidates for memory reclaim::
>
>         echo 2 > /proc/sys/vm/zone_reclaim_mode
>
> [...] (original content)
>
> Allow mapped pages to become candidates for memory reclaim::
>
>         echo 4 > /proc/sys/vm/zone_reclaim_mode
>
> [...] (original content)
>
> I'm trying to balance between keeping the original content, being descrip=
tive,
> and not going into encyclopedia-mode. My motivation was to stress the imp=
ortance
> of NUMA-node count and describe the additional bits more per your advice.
> I added the echo snippets to better segue the aggressive options. Any tho=
ughts
> on the above?
>
> On Thu, Apr 11, 2024 at 2:54=E2=80=AFAM Vratislav Bendel <vbendel@redhat.=
com> wrote:
> >
> > On Fri, Apr 5, 2024 at 6:49=E2=80=AFPM Matthew Cassell <mcassell411@gma=
il.com> wrote:
> > >
> > > If any bits are set in node_reclaim_mode (tunable via
> > > /proc/sys/vm/zone_reclaim_mode) within get_pages_from_freelist(), the=
n
> > > page allocations start getting early access to reclaim via the
> > > node_reclaim() code path when memory pressure increases. This behavio=
r
> > > provides the most optimization for multiple NUMA node machines. The a=
bove
> > > is mentioned in:
> > >
> > > Commit 9eeff2395e3cfd05c9b2e6 ("[PATCH] Zone reclaim: Reclaim logic")
> > > states "Zone reclaim is of particular importance for NUMA machines. I=
t
> > > can be more beneficial to reclaim a page than taking the performance
> > > penalties that come with allocating a page on a REMOTE zone."
> > >
> > > While the pros/cons of staying on node versus allocating remotely are
> > > mentioned in commit histories and mailing lists. It isn't specificall=
y
> > > mentioned in Documentation/ and isn't possible with a lone node. Imag=
ine a
> > > situation where CONFIG_NUMA=3Dy (the default on most major distributi=
ons)
> > > and only a single NUMA node exists. The latter is an oxymoron
> > > (single-node =3D=3D uniform memory access). Informing the user via vm=
rst that
> > > the most bang for their buck is when multiple nodes exist seems helpf=
ul.
> > >
> >
> > I agree that the documentation could be improved to better express the
> > implications
> > and relevance of setting zone_reclaim_mode bits.
> >
> > Though I would suggest to go a step further and also elaborate on
> > those "additional actions",
> > for example something like:
> > "The page allocator will attempt to reclaim memory within the zone,
> > depending on the bits set,
> > before looking for free pages in other zones, namely on remote memory n=
odes."
> >
> > > Signed-off-by: Matthew Cassell <mcassell411@gmail.com>
> > > ---
> > >  Documentation/admin-guide/sysctl/vm.rst | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/=
admin-guide/sysctl/vm.rst
> > > index c59889de122b..10270548af2a 100644
> > > --- a/Documentation/admin-guide/sysctl/vm.rst
> > > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > > @@ -1031,7 +1031,8 @@ Consider enabling one or more zone_reclaim mode=
 bits if it's known that the
> > >  workload is partitioned such that each partition fits within a NUMA =
node
> > >  and that accessing remote memory would cause a measurable performanc=
e
> > >  reduction.  The page allocator will take additional actions before
> > > -allocating off node pages.
> > > +allocating off node pages. Keep in mind enabling bits in zone_reclai=
m_mode
> > > +makes the most sense for topologies consisting of multiple NUMA node=
s.
> > >
> > >  Allowing zone reclaim to write out pages stops processes that are
> > >  writing large amounts of data from dirtying pages on other nodes. Zo=
ne
> > > --
> > > 2.34.1
> > >
> >
>


