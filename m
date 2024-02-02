Return-Path: <linux-kernel+bounces-50318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE1D847755
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5717128B7EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C9C1534F2;
	Fri,  2 Feb 2024 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9OZVisQ"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59A152DF9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898169; cv=none; b=KVU+GyzF48R8GOWGHsncTvGIMfEHqvlCZP0SoJ4yDf/5cEqprLsRfA7QSZbukH1no1wkoXkbdoa+yda2iJ+WlTscT07Gcou38l0mx484RxUXK3jKx+xVLCRj6j6DhSdJajU096YOx53n8H3QK6PM5fMT0ZqoWNOsvACfHzd+skI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898169; c=relaxed/simple;
	bh=5ZVyar9au3uXcBd6Rum3RbOscF4rzj84T3kzSFo1sFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUgMNhQY9DuejcbhFj3N6MNs4wM6KhKPLVmPsZiOG+FT7s6vqO1M5wOUFCOP0o9ANdZCOl60addaaHvhirml1qB555m0k+Z/OTt0a9DCiukV/7z13Hf3f8vVnSFZQgq+crTO/Gm4ndi7no4Y9flO6BEILysMd3o6QqvJTVyuDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F9OZVisQ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dc36e501e1so1546525a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706898166; x=1707502966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Vgtnno6wkR+VkAzje/RiytvB0nk1FOGbedoxkxlBHI=;
        b=F9OZVisQvYwJkT+o0qAZ3HXBOa+MH3FfmmRCmb3deMbyH3bwvfgZUv6+TZs72q7ACg
         wJQhHs+WCyLJBQ9pr++aMhtwqB1YPIevYaMG5RLwWRV5aJSroVXjXNw9eqCgMksZDRDT
         f3sygMXu33s46AmUQ3mHConxZo8hg7w5p8FykMMXbfDM8uoIpb0Nl3LTSMixkHjKYp4p
         ZDuv1QnOfYC1LZFkSW5NvIQxmdHFEN1Zk3E7DX6SSnB+fXRXmbA34/DFdtnWfI5OnOsN
         CJPTW1hSi30EVOt68O5yhC/PPp5t7cHjbWGVccsd7XPpfLCYu1ZvLtwl3YkxHdUgwGde
         TwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898166; x=1707502966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Vgtnno6wkR+VkAzje/RiytvB0nk1FOGbedoxkxlBHI=;
        b=B0MecWucRBrZ0Oic+CXpto/TEIxhENe5YbNEWfFkbE74mqn5qCgIkUxebUvIfs2Kgn
         kbyBL6RFc4GgPzY3IrU52V9lIEN4g1dYWigIAYO39CqQBgLQxm+Ipr8oGabauHmjAafs
         7vPuy68ppP5nUhFAVveZ9im3W6J9DA8gx6q+Pm5GZLD8WsC3aCjS/ztP/bBWBqyrZzV6
         Ejj5eG2FIlGoaSSTgVma1zimL48wFKKvfttSrA987SNaFZJFfpASydptnKpviWou7QYX
         uyCvHwKh0SzjSzvQyjHEEmmtwYOmcDzLfAXkDOCPyRl3/G0a6BrHuvWdnuXf9pG/YFvw
         xkFg==
X-Gm-Message-State: AOJu0YyIqfF3p1g9pcbfBch2yzhc/5okyk4H61fhcCiSdQlomBzrWV/g
	7WZhcywEvGnNJP42vqXVem6RqQJy+AoQKiDNIWn5N9Ngsn+zj9ReK9b+FlghSFIUXhB0C8rZqPa
	vQmWcszedeYS4SWCyQafaaPXHYaUSE+1HhznD
X-Google-Smtp-Source: AGHT+IGcU+EKjFdt3AgFAbkSPSfwDQmkDe3lffsGg4gSwfWzSHPSCNHR2D8ZEri2mw0YLTGlB0gcT19xB71Pgzgw4qk=
X-Received: by 2002:a9d:7302:0:b0:6dd:ecaa:3aea with SMTP id
 e2-20020a9d7302000000b006ddecaa3aeamr10041878otk.1.1706898166366; Fri, 02 Feb
 2024 10:22:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201153428.GA307226@cmpxchg.org> <20240202050247.45167-1-yangyifei03@kuaishou.com>
 <vofidz4pzybyxoozjrmuqhycm2aji6inp6lkgd3fakyv5jqsjr@pleoj7ljsxhi>
In-Reply-To: <vofidz4pzybyxoozjrmuqhycm2aji6inp6lkgd3fakyv5jqsjr@pleoj7ljsxhi>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 2 Feb 2024 10:22:34 -0800
Message-ID: <CABdmKX2KsxVExVWzysc_fQagGkYWhqRF00KxNxjpVWovHHip+Q@mail.gmail.com>
Subject: Re: Re: [PATCH] mm: memcg: Use larger chunks for proactive reclaim
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Efly Young <yangyifei03@kuaishou.com>, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	android-mm@google.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, shakeelb@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 2:15=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> On Fri, Feb 02, 2024 at 01:02:47PM +0800, Efly Young <yangyifei03@kuaisho=
u.com> wrote:
> > > Looking at the code, I'm not quite sure if this can be read this
> > > literally. Efly might be able to elaborate, but we do a full loop of
> > > all nodes and cgroups in the tree before checking nr_to_reclaimed, an=
d
> > > rely on priority level for granularity. So request size and complexit=
y
> > > of the cgroup tree play a role. I don't know where the exact factor
> > > two would come from.
> >
> > I'm sorry that this conclusion may be arbitrary. It might just only sui=
t
> > for my case. In my case, I traced it loop twice every time before check=
ing
> > nr_reclaimed, and it reclaimed less than my request size(1G) every time=
.
> > So I think the upper bound is 2 * request. But now it seems that this i=
s
> > related to cgroup tree I constucted and my system status and my request
> > size(a relatively large chunk). So there are many influencing factors,
> > a specific upper bound is not accurate.
>
> Alright, thanks for the background.
>
> > > IMO it's more accurate to phrase it like this:
> > >
> > > Reclaim tries to balance nr_to_reclaim fidelity with fairness across
> > > nodes and cgroups over which the pages are spread. As such, the bigge=
r
> > > the request, the bigger the absolute overreclaim error. Historic
> > > in-kernel users of reclaim have used fixed, small request batches to
> > > approach an appropriate reclaim rate over time. When we reclaim a use=
r
> > > request of arbitrary size, use decaying batches to manage error while
> > > maintaining reasonable throughput.
>
> Hm, decay...
> So shouldn't the formula be
>   nr_pages =3D delta <=3D SWAP_CLUSTER_MAX ? delta : (delta + 3*SWAP_CLUS=
TER_MAX) / 4
> where
>   delta =3D nr_to_reclaim - nr_reclaimed
> ?
> (So that convergence for smaller deltas is same like original- and other
> reclaims while conservative factor is applied for effectivity of higher
> user requests.)

Tapering out at 32 instead of 4 doesn't make much difference in
practice because of how far off the actually reclaimed amount can be
from the request size. We're talking thousands of pages of error for a
request size of a few megs, and hundreds of pages of error for
requests less than 100 pages.

So all of these should be more or less equivalent:
delta <=3D SWAP_CLUSTER_MAX ? delta : (delta + 3*SWAP_CLUSTER_MAX) / 4
max((nr_to_reclaim - nr_reclaimed) / 4, (nr_to_reclaim - nr_reclaimed) % 4)
(nr_to_reclaim - nr_reclaimed) / 4 + 4
(nr_to_reclaim - nr_reclaimed) / 4

I was just trying to avoid putting in a 0 for the request size with the mod=
.

