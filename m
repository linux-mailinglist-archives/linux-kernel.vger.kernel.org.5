Return-Path: <linux-kernel+bounces-30479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F42C831F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB74F28CCB2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523182D7A4;
	Thu, 18 Jan 2024 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Ms6PVIMw"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373C2D60D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603077; cv=none; b=UP6Hj8r2zIEKxrpXdQckalq3luncOx2n+ixyCDAPYYYYa2ifPiCIwShIIq1E1M2/3Y60Zk6N7EHh+ugyTMRPijJOo8M+hHzdiFUw6DgLmkkBdD+q1FOJBJSCGckZOjEWc7DZYHS3bjU65ZjCKYhoG6Kfq1jDqlk0pcXayFFmiAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603077; c=relaxed/simple;
	bh=ZhsWxCBVmOS0Tg3/E7fdxwBul+lFxvp6eiP7y0G0MJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyfHBG9Dj3wqa9A06pPnFOfPvGStphchMZUlcRy0FRCh+elCsAOyeDtQRgDlV6jzvxjabIkcd/JmEE3T8wayB25cVx52AVi4hiv1vUIulKQNw9QnjeWlegDctIvmmDFS8r84u4Vumitd/lQdYeFLgNM5Nl4Dl40I38ai/izaieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ms6PVIMw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a271a28aeb4so1361545066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705603074; x=1706207874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bYBrB0Absrq0cOqKL/yLzU6Obd9P2ZIGfMVvbGA9S8=;
        b=Ms6PVIMwof0GmyX9h71WtN7TsGa7oBd0FG8ZUY3VkyGXSj7sDCb3etAtSYDDeDeePp
         gNBqu1SeJAonfMLXR8IGtag0xLXIcx98EYE0JrnE7HPC0INaJIrf3HAZB5Uwdg2Ro4Gg
         ttScGyrd9ehcTH1KcpC2rJZvf47rb4f4GcyTGEVscURHYaapstkg8H5ghHc9Dq78bRNx
         4o7Lhu2V0fjBaE+yhRHdMoE4wWOUldTzQ7NOFW24iv8eo7XDVxJrZkQoFEa9q36Go2tu
         eQEXmxtFLIscIpPgdxCI9pqmtGUPL10Dkd0u1UZV8F5+qBy/33x6u8miBBdMP6w+QNcA
         eoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705603074; x=1706207874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bYBrB0Absrq0cOqKL/yLzU6Obd9P2ZIGfMVvbGA9S8=;
        b=NDCWsu2tlZGPH55QgzOE+rqON/awXa/afDj3/rqp0Q4IUIflJrj//54ZuEe+sd1CSd
         KKXGCC5vv8vLjxFH5Zy1//5QXxupv6ZxRLOXQKPg/rD+FXI6Ap5TU+pXm8wv1VNGzNR1
         0o+I76JnE6cYher2gh08NNEiRpzLFZ5hexgWSKJKCXDM7VwoIUPSQ/VzcG9NgyA5W0FI
         CnoDDgD/uSCxYrwZmCd6Lawqy75YSg0eNBDLNTrYM0Dp2Z1hg/1QgBXJTNAoOigLr+ez
         +WAFveXl05s4liam7EyU/Pj3NczegxtS6C6NfDkFp7BC32cFdVIvVCt3CveXHuofxw5o
         0ISg==
X-Gm-Message-State: AOJu0Ywaadc0+foT+VlsIQJGnCVgSM+07adSa/3fshHh3k4v8hBAo6R/
	B9TpdQRxsmDutQL0rznO147t0GMvPPCuy+rQDJwa7btmbjFd5GB5m9aHmuhsF3K+V4hoeYszi9r
	Pc5A3XbvKDqRfuJozo2H73Jl22v5WS1nHuhVu
X-Google-Smtp-Source: AGHT+IFeUx3hVxaDTHPRbozzkWnnAPGABzgGB8u4CWgMJ1hUMaUFdcZoBq0X8CuWN6gIpHNy8n//Rg5/P84Vg2NyiSQ=
X-Received: by 2002:a17:906:6150:b0:a2f:17d6:68b1 with SMTP id
 p16-20020a170906615000b00a2f17d668b1mr716320ejl.30.1705603073825; Thu, 18 Jan
 2024 10:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com>
 <20240118153425.GI939255@cmpxchg.org> <CAJD7tkY48=2-4_iG6c-FcbzT3EBriem2spOFTTpGMfqmOmsx2Q@mail.gmail.com>
 <20240118180655.GM939255@cmpxchg.org>
In-Reply-To: <20240118180655.GM939255@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Jan 2024 10:37:17 -0800
Message-ID: <CAJD7tkaNA5r7it0NBf+uR5yytJccbV_dLQmPFN0NG5b=+EcOTg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/zswap: optimize the scalability of zswap rb-tree
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Chris Li <chriscli@google.com>, Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 10:07=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Thu, Jan 18, 2024 at 09:30:12AM -0800, Yosry Ahmed wrote:
> > On Thu, Jan 18, 2024 at 7:34=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
org> wrote:
> > >
> > > On Wed, Jan 17, 2024 at 10:37:22AM -0800, Yosry Ahmed wrote:
> > > > On Wed, Jan 17, 2024 at 1:23=E2=80=AFAM Chengming Zhou
> > > > <zhouchengming@bytedance.com> wrote:
> > > > >
> > > > > When testing the zswap performance by using kernel build -j32 in =
a tmpfs
> > > > > directory, I found the scalability of zswap rb-tree is not good, =
which
> > > > > is protected by the only spinlock. That would cause heavy lock co=
ntention
> > > > > if multiple tasks zswap_store/load concurrently.
> > > > >
> > > > > So a simple solution is to split the only one zswap rb-tree into =
multiple
> > > > > rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). Thi=
s idea is
> > > > > from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64M=
B trunks").
> > > > >
> > > > > Although this method can't solve the spinlock contention complete=
ly, it
> > > > > can mitigate much of that contention. Below is the results of ker=
nel build
> > > > > in tmpfs with zswap shrinker enabled:
> > > > >
> > > > >      linux-next  zswap-lock-optimize
> > > > > real 1m9.181s    1m3.820s
> > > > > user 17m44.036s  17m40.100s
> > > > > sys  7m37.297s   4m54.622s
> > > > >
> > > > > So there are clearly improvements. And it's complementary with th=
e ongoing
> > > > > zswap xarray conversion by Chris. Anyway, I think we can also mer=
ge this
> > > > > first, it's complementary IMHO. So I just refresh and resend this=
 for
> > > > > further discussion.
> > > >
> > > > The reason why I think we should wait for the xarray patch(es) is
> > > > there is a chance we may see less improvements from splitting the t=
ree
> > > > if it was an xarray. If we merge this series first, there is no way=
 to
> > > > know.
> > >
> > > I mentioned this before, but I disagree quite strongly with this
> > > general sentiment.
> > >
> > > Chengming's patches are simple, mature, and have convincing
> > > numbers. IMO it's poor form to hold something like that for "let's se=
e
> > > how our other experiment works out". The only exception would be if w=
e
> > > all agree that the earlier change flies in the face of the overall
> > > direction we want to pursue, which I don't think is the case here.
> >
> > My intention was not to delay merging these patches until the xarray
> > patches are merged in. It was only to wait until the xarray patches
> > are *posted*, so that we can redo the testing on top of them and
> > verify that the gains are still there. That should have been around
> > now, but the xarray patches were posted in a form that does not allow
> > this testing (because we still have a lock on the read path), so I am
> > less inclined.
> >
> > My rationale was that if the gains from splitting the tree become
> > minimal after we switch to an xarray, we won't know. It's more
> > difficult to remove optimizations than to add them, because we may
> > cause a regression. I am kind of paranoid about having code sitting
> > around that we don't have full information about how much it's needed.
>
> Yeah I understand that fear.
>
> I expect the splitting to help more than the move to xarray because
> it's the writes that are hot. Luckily in this case it should be fairly
> easy to differential-test after it's been merged by changing that tree
> lookup macro/function locally to always return &trees[type][0], right?

Yeah that's exactly what I had in mind. Once we have a version of the
xarray patch without the locking on the read side we can test with
that. Chengming, does this sound reasonable to you?

