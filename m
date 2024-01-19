Return-Path: <linux-kernel+bounces-30774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920D5832439
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33920284FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E5C4A0F;
	Fri, 19 Jan 2024 05:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/qxAmei"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C7A469E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705642107; cv=none; b=jYv7LLSuOZmfWnIbv+cYvDYOT1I0jU9iTAnmw6A0CBBxPTI6PIeoCCH6aY/pN5LielxSZ8P4cOSeBcL4fw5czULIstWddjyOxYwT31mQlU8q1AMKps3fCcqNqJRJ49E2q+IuPz/kKvc7yMpPyVZ6+vx2WqknDhm5joSugnjc2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705642107; c=relaxed/simple;
	bh=czy8DnaAWLHQlorivc+Ot+gTA06S0rxyezopG91WYbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3piuBVpI7L0gDwr5RM7F0K8fYtYRdp7nFtoGrd3pok9jhqeSD2WiysnSuK4whMeZK1332dQaQGrk0cYV90PVCiW4csoA8O+Uk8h+A1Nl62UAxP/XcrqtnfmC82FzheoTaB6a58WlDBZfxNGpZEmGjYX03s0Aj04OILzzxHO/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/qxAmei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA96EC433B2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705642105;
	bh=czy8DnaAWLHQlorivc+Ot+gTA06S0rxyezopG91WYbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i/qxAmeiqpEB0LGY4stShFOqEOB21Lg4pAWxq74Kq3asfQMUJCvPrGSbGNWeONvRg
	 2ui4YyDE0ZyPzT3t50gVpcPcK83KNu+yI/fafjxiIkUqQcTP1r1pqBQr1q+UhcHfxz
	 qmG08IB2TBk8Ut8hzTAS2cxDGlzKJ/1krR811IE/AFbxCVSHyX+HM4OjV9OQL4FVE+
	 bYVNRsb1Ix/566v4TY1w4H4G9tiHD3Z8o0loSg58dkldM4O/9Vh/RyXGjuupfFXNNv
	 7mmVK4lzPGA2Nrusp7EhRXjuh/I4Xr42Jr5BzcOD1ZOjqquJUEQdCxkNFLjXZQ6KNR
	 maRfhul3QRtPw==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso502187276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 21:28:25 -0800 (PST)
X-Gm-Message-State: AOJu0YzrPm09O2sc/4KZ8m0KYKXncKOc7bzVJ+Gm1G5SBxYedFjSdib+
	te7PHDWUUP1LjqopafYztIm/XqLUPw3bltvGdSeeVQvNc1rfR3/ZYRML4VZVhOx058JV9bSeq3G
	/w8pPLJKdQr7gDo4H6zE6KQ80/lwXWvDh7W5a
X-Google-Smtp-Source: AGHT+IH0pIl7lszmDuj/KH0KhGA0tAt83xxHfis7ot8SIPLQMqZxwTbCMg2bGMQIbNFU7TUnakGrwMXPiUqCqatY1lc=
X-Received: by 2002:a25:9207:0:b0:dbf:114a:9443 with SMTP id
 b7-20020a259207000000b00dbf114a9443mr1873923ybo.67.1705642104867; Thu, 18 Jan
 2024 21:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-1-6daa86c08fae@kernel.org> <CAJD7tkYEx57CPBoaN9GW4M3Mx-+jEsOMWJ02nLKSKD-MLb-WPA@mail.gmail.com>
 <ZaktH7xc72x4Xr3d@casper.infradead.org> <CAJD7tkapY4nx=uAXuyQhJN=rz7QPj6p9OJzpPwZGr_7+7Ywotw@mail.gmail.com>
 <ZaltEwGXHyFFuI0F@casper.infradead.org>
In-Reply-To: <ZaltEwGXHyFFuI0F@casper.infradead.org>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 18 Jan 2024 21:28:13 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPMhbMsjNf7gJF=5s+m0eVXg1juX1e9tVCEffrd5HbGaQ@mail.gmail.com>
Message-ID: <CAF8kJuPMhbMsjNf7gJF=5s+m0eVXg1juX1e9tVCEffrd5HbGaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap.c: add xarray tree to zswap
To: Matthew Wilcox <willy@infradead.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 10:25=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Jan 18, 2024 at 08:59:55AM -0800, Yosry Ahmed wrote:
> > On Thu, Jan 18, 2024 at 5:52=E2=80=AFAM Matthew Wilcox <willy@infradead=
org> wrote:
> > >
> > > On Wed, Jan 17, 2024 at 10:20:29PM -0800, Yosry Ahmed wrote:
> > > > >         /* walk the tree and free everything */
> > > > >         spin_lock(&tree->lock);
> > > > > +
> > > > > +       xas_for_each(&xas, e, ULONG_MAX)
> > > >
> > > > Why not use xa_for_each?
> > >
> > > xas_for_each() is O(n) while xa_for_each() is O(n log n), as mentione=
d
> > > in the fine documentation.  If you don't need to drop the lock while
> > > in the body of the loop, always prefer xas_for_each().
> >
> > Thanks for pointing this out. Out of ignorance, I skipped reading the
> > doc for this one and operated under the general assumption to use xa_*
> > functions were possible.
> >
> > The doc also says we should hold either the RCU read lock or the
> > xa_lock while iterating, we are not doing either here, no?
>
> I have no idea; I haven't studied the patches in detail yet.  I have
> debugging assertions for that, so I was assuming that Chris had been
> developing with debug options turned on.  If not, I guess the bots will
> do it for him.

It is fine now because we have the extra zswap tree spin lock. When we
remove the zswap tree spin lock it does require RCU read lock. You are
right I would get assertion failure.

Chris

