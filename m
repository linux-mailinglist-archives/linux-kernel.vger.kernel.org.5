Return-Path: <linux-kernel+bounces-29555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2062D831025
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526B41C21CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED3428699;
	Wed, 17 Jan 2024 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVwTYqsN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17AA2561F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705534908; cv=none; b=q0hAFlEy4HxIQ0iBeZPkokmy7D+wwXTwpcq76+c6z9uPHvO/QoBaqonL8OVpv6NmTKkDGgsCCGkvOg41nh/zChIeQiMaoovWi4NWMHId+xV1lEGLV3rY5gb8bZAzlHhZzaIYeP2uasKZrwxlS+DlrJ4wpfA/P5Ca+XopPevshv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705534908; c=relaxed/simple;
	bh=cY79/Cfp9xIflNIDwfUmZ2vm5pn0cwkYXSHLUwKaasQ=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=rxMbIucivtzmKf/E0kOCkER85Cruay17K2ovY+Q4BqbV7koAwEwqN5H1Z3mD+nwEHR26SjvA+BoWeBYi/dPForbFRFa+XJZGEgqjTYuP9lng8ONH60lhADP34i4g8SjZ8hgDu2Pa0X+Ixuxg7ZRtNMXcB+ESyjiYkx7ahYz4RMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVwTYqsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FAFC433A6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705534908;
	bh=cY79/Cfp9xIflNIDwfUmZ2vm5pn0cwkYXSHLUwKaasQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JVwTYqsNhQmI0YoHxpkxpGD41oMoBmdB5gB6csq63I1W8k3eO4j97Q59XcVo+y3J9
	 p06o/RNx3V4rGt6wYHkHMCFqD+1MtadTpTH7CstvD8mBnOYGppldPi1rDre7hoyooH
	 xOHFM4HZqRT+olNjR75ncyorWJtChHNy0rGjmjmaxi7SAXs0XTWGWo/WPITTk++I00
	 3xcKhb6zFSguSfcNla8ajfSCKMuSzkBd9VB76r2idmf9jpOs1PeLjD0yPopxBBmxa+
	 7jSwy7dIgDNhcZrt1InB7Eoq5PqzFjnOkMaauBmU431Nmw8xwuPRQa74xZTVAyLjtt
	 DQeEXKfajnkzw==
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2901f9a9d00so39658a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:41:48 -0800 (PST)
X-Gm-Message-State: AOJu0YzRiRhUMUieFFGAhr+GZRiQCaSRDehqZK2vmQyO2sPRzKO7pbAw
	RtL+DuC1f+kWN4pI5lAQrwPY4fqPvWkIJP11K+9DKY6qJpsEkx037WwPGYJ2FNPwPfeCzpGfKPr
	mGxdSNcTIP6LBR8RUl5EkoWktLzpAx3N9aK0R
X-Google-Smtp-Source: AGHT+IFs7Y9kVpqYyUhwzuMYD6tF9HAEqcY8re5F/bDLJ7v+vAmuGFeD34dRqhpQ93irvy0QmLM3iQHxGmMhGiTY8fI=
X-Received: by 2002:a17:90a:12ca:b0:28e:89d2:87ba with SMTP id
 b10-20020a17090a12ca00b0028e89d287bamr43131pjg.12.1705534907954; Wed, 17 Jan
 2024 15:41:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com> <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com>
In-Reply-To: <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 17 Jan 2024 15:41:35 -0800
X-Gmail-Original-Message-ID: <CAF8kJuP4o3Ebg-aYKF9=ftbdu97RnkXnYL-8RuVjYAeXd+ng3A@mail.gmail.com>
Message-ID: <CAF8kJuP4o3Ebg-aYKF9=ftbdu97RnkXnYL-8RuVjYAeXd+ng3A@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/zswap: optimize the scalability of zswap rb-tree
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry and Chengming,


On Wed, Jan 17, 2024 at 10:38=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Wed, Jan 17, 2024 at 1:23=E2=80=AFAM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> >
> > When testing the zswap performance by using kernel build -j32 in a tmpf=
s
> > directory, I found the scalability of zswap rb-tree is not good, which
> > is protected by the only spinlock. That would cause heavy lock contenti=
on
> > if multiple tasks zswap_store/load concurrently.
> >
> > So a simple solution is to split the only one zswap rb-tree into multip=
le
> > rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This idea=
 is
> > from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trun=
ks").
> >
> > Although this method can't solve the spinlock contention completely, it
> > can mitigate much of that contention. Below is the results of kernel bu=
ild
> > in tmpfs with zswap shrinker enabled:
> >
> >      linux-next  zswap-lock-optimize
> > real 1m9.181s    1m3.820s
> > user 17m44.036s  17m40.100s
> > sys  7m37.297s   4m54.622s
> >
> > So there are clearly improvements. And it's complementary with the ongo=
ing
> > zswap xarray conversion by Chris. Anyway, I think we can also merge thi=
s
> > first, it's complementary IMHO. So I just refresh and resend this for
> > further discussion.
>

Sorry I have been radio silent busying on a few refreshments of the
xarray on the recent kernel tree. There is an assertion triggered on
xarray and the rb tree does not agree with each other. It takes some
time to debug. I ironed that out, also glad the assert did catch a
bug.

Currently the xarray patch should have everything it takes to use RCU
read lock. However taking out the tree spinlock is more work than
previously. If we are going to remove the tree spinlock, I think we
should revert back to doing a zswap tree lookup and return the zswap
entry with reference increased. The tree mapping can still decouple
from the zswap entry reference count drop to zero.  Anyway, my V1 of
the xarray patch will not include removing the tree spinlock.

> The reason why I think we should wait for the xarray patch(es) is
> there is a chance we may see less improvements from splitting the tree
> if it was an xarray. If we merge this series first, there is no way to
> know.
>
> Chris, do you intend to send the xarray patch(es) anytime soon?

Thanks for the heads up. Let me send it out now.

Chris

