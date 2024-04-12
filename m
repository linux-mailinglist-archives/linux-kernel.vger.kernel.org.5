Return-Path: <linux-kernel+bounces-143325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1B98A373E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC3C1F2263A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA77640BE1;
	Fri, 12 Apr 2024 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADpxsRzB"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B1405F2;
	Fri, 12 Apr 2024 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954910; cv=none; b=mMeNaXYiJPDa7F/83X0vCRfrwIJlE8E8zZStakuK1KDpDq2N+NH2X16lTMnqPc00wqnicxfTzaQ8s7TZ5bJhBod6ajnUi1W53GDLOtZ2dUBMIPioe+gEyw9JYXntDHgrwgmbLJOE0nv5lBEwUBJnwSTZxv4NIyhaFIqR+kq4PvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954910; c=relaxed/simple;
	bh=pbE3TaIzhf/PuBsPi7z2XyKs+/RUTs1HkbRcW3mWWCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLhRxA6vxEBNNGECaUk27G/VfUxh+fweT5orZcEbRWgrPSyl941xjU5ID9tl813u2+/cplPLtahRK8jtaItPS1nDEN88Naf3Wbu3CFLmxybSXOa12rThaSfHr5QMBfHEo0kVjz0oVrb+R18Uu7bVmOpgYYkOYhIs1BGAzG9XX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADpxsRzB; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69b2f6d31c1so3823766d6.0;
        Fri, 12 Apr 2024 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712954907; x=1713559707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnmmxjRKpqxFVnghAeFega9zNQA9pSSXf3fcA1ZfMnw=;
        b=ADpxsRzB8n+B7MaYarpx2kx1o37tsfnnQe9qv0bZFt569cisd7hzUnGhhmIjpbpC+T
         utw7tp2AgVHJwZdyn64+LLNIMPpCLW78IELO50M76FdBnbzxPZTreNi3ozEP0RGbNQBf
         9PNpBcQ+xTzm8vvgEUR4V8fiMgEebML+o3aHdK33OfFjqiWqroOiCHRPFbj/jdc0r7ff
         ozCv7kJ98ZFYwRCkH9YSMMYzawIiJMBNZLYPolQ8Am1hewW2amQFdY+PilN+baQ7tscI
         8OQezFWGBnA7O8xXCD28KVdfEctGgdeXHHzFOQI8ZruAvNzXHBVKf9b5RClKoVZnx4sP
         kHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712954907; x=1713559707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnmmxjRKpqxFVnghAeFega9zNQA9pSSXf3fcA1ZfMnw=;
        b=bTmK+9oCPi5C3L43jY6n5wfvnkD1lYJae2L2yqIJ47m63BwUVh1jcswgMR7bVvmKaG
         Mu5rINmMfFjV864kN2KLCyzRVlgzWfDtmBY6iBU5ML9oELkfuajv0Gtin4/x7gsXe6yZ
         wOAmAzl+o/ypJGsWcFO2S5pdjZE7FPA0UVNFLT5rbpzLyL3gm13ZY+4oikN3etKqSD7n
         RD80ohV1vbURUccIR4rAXMAzzDN0iNok1rWgkIwbkOtG9XplnhlMOyZFHEwsxvtKOnbQ
         L2zhxqzcBBNKONK83JXegAjRfhaFeCZy7fp5azE8RQBWSq9laiCs2tQl15ioMelD3gKv
         r8WA==
X-Forwarded-Encrypted: i=1; AJvYcCVs+3x3mfdEPdaHU0THTuv3xuJ2IN8X2bQR6tehMnc2W+oGthyxCnRAotuJlHuj2hwRYMx0vGubw3Nh7wKQ+SWqacE8LG9NksEDldV2GaautVw53RdIBR9yFGO68bswCfLc/T4yAuRV
X-Gm-Message-State: AOJu0YwVK9BtXkFcw/2H2SCfRwREUpfpupuWKbhtZjcB6iXeRe9CI0dl
	1PNQSaOm6fLww5vBQ4yvlIErNFCO+F1RIRUC/Ow4TLzrIucgchyRvprCtyKplB4h1V8M3laPraG
	0kkoB6UgEmDZYOMV51e4S1nbVBmleYOE3
X-Google-Smtp-Source: AGHT+IGsxdKNSMvpvFUibqKic+MapNJ5+83IoIIuK53K6T/QEX/NXNp6+YB1TQzZemxd1I6ribVMdXKyKdk4s9Suypg=
X-Received: by 2002:a05:6214:11a2:b0:69b:246b:4bff with SMTP id
 u2-20020a05621411a200b0069b246b4bffmr3823325qvv.33.1712954907535; Fri, 12 Apr
 2024 13:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405164920.2844-1-mcassell411@gmail.com> <CAHrQN1xuLfc0sfe1kMHmHrBzKQLMD-6PNEakA=EDdabEv4ATnQ@mail.gmail.com>
In-Reply-To: <CAHrQN1xuLfc0sfe1kMHmHrBzKQLMD-6PNEakA=EDdabEv4ATnQ@mail.gmail.com>
From: Matthew Cassell <mcassell411@gmail.com>
Date: Fri, 12 Apr 2024 15:48:16 -0500
Message-ID: <CANiscBDGqwMvbNUXydKMMgXdwSNeXDQOGy=jgdOJCNh7+WaSvg@mail.gmail.com>
Subject: Re: [PATCH] Documentation/admin-guide/sysctl/vm.rst adding the
 importance of NUMA-node count to documentation
To: Vratislav Bendel <vbendel@redhat.com>
Cc: corbet@lwn.net, akpm@linux-foundation.org, rppt@kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback. Here is a quick outline I came up with on your
advice:

[...] (original content)

Keep in mind enabling bits in zone_reclaim_mode makes the most sense
for topologies consisting of multiple NUMA nodes. In addition to vanilla
zone_reclaim (clean and unmapped pages), there exist additional bits that
expand which pages are eligible to be reclaimed and dictate scan_control
policy during the reclaim process. The page allocator will attempt to recla=
im
memory locally in accordance with these bits before attempting to allocate
on remote nodes.

Allow dirty pages to become candidates for memory reclaim::

        echo 2 > /proc/sys/vm/zone_reclaim_mode

[...] (original content)

Allow mapped pages to become candidates for memory reclaim::

        echo 4 > /proc/sys/vm/zone_reclaim_mode

[...] (original content)

I'm trying to balance between keeping the original content, being descripti=
ve,
and not going into encyclopedia-mode. My motivation was to stress the impor=
tance
of NUMA-node count and describe the additional bits more per your advice.
I added the echo snippets to better segue the aggressive options. Any thoug=
hts
on the above?

On Thu, Apr 11, 2024 at 2:54=E2=80=AFAM Vratislav Bendel <vbendel@redhat.co=
m> wrote:
>
> On Fri, Apr 5, 2024 at 6:49=E2=80=AFPM Matthew Cassell <mcassell411@gmail=
com> wrote:
> >
> > If any bits are set in node_reclaim_mode (tunable via
> > /proc/sys/vm/zone_reclaim_mode) within get_pages_from_freelist(), then
> > page allocations start getting early access to reclaim via the
> > node_reclaim() code path when memory pressure increases. This behavior
> > provides the most optimization for multiple NUMA node machines. The abo=
ve
> > is mentioned in:
> >
> > Commit 9eeff2395e3cfd05c9b2e6 ("[PATCH] Zone reclaim: Reclaim logic")
> > states "Zone reclaim is of particular importance for NUMA machines. It
> > can be more beneficial to reclaim a page than taking the performance
> > penalties that come with allocating a page on a REMOTE zone."
> >
> > While the pros/cons of staying on node versus allocating remotely are
> > mentioned in commit histories and mailing lists. It isn't specifically
> > mentioned in Documentation/ and isn't possible with a lone node. Imagin=
e a
> > situation where CONFIG_NUMA=3Dy (the default on most major distribution=
s)
> > and only a single NUMA node exists. The latter is an oxymoron
> > (single-node =3D=3D uniform memory access). Informing the user via vm.r=
st that
> > the most bang for their buck is when multiple nodes exist seems helpful=
.
> >
>
> I agree that the documentation could be improved to better express the
> implications
> and relevance of setting zone_reclaim_mode bits.
>
> Though I would suggest to go a step further and also elaborate on
> those "additional actions",
> for example something like:
> "The page allocator will attempt to reclaim memory within the zone,
> depending on the bits set,
> before looking for free pages in other zones, namely on remote memory nod=
es."
>
> > Signed-off-by: Matthew Cassell <mcassell411@gmail.com>
> > ---
> >  Documentation/admin-guide/sysctl/vm.rst | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/ad=
min-guide/sysctl/vm.rst
> > index c59889de122b..10270548af2a 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -1031,7 +1031,8 @@ Consider enabling one or more zone_reclaim mode b=
its if it's known that the
> >  workload is partitioned such that each partition fits within a NUMA no=
de
> >  and that accessing remote memory would cause a measurable performance
> >  reduction.  The page allocator will take additional actions before
> > -allocating off node pages.
> > +allocating off node pages. Keep in mind enabling bits in zone_reclaim_=
mode
> > +makes the most sense for topologies consisting of multiple NUMA nodes.
> >
> >  Allowing zone reclaim to write out pages stops processes that are
> >  writing large amounts of data from dirtying pages on other nodes. Zone
> > --
> > 2.34.1
> >
>

