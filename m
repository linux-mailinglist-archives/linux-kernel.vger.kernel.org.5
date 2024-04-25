Return-Path: <linux-kernel+bounces-159340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D128B2D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E4B1C21043
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09354155A39;
	Thu, 25 Apr 2024 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9g+U6Vf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37520315
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714085690; cv=none; b=CUrB/SM+tI8yQ6cj4TLsw9xpLAvPU7mNzvorhjCH80eENrTWwmI0fG8IvWv958XsQInt+VzTdSPb1xCuUbpw69B0tnrHEVMw73a0VUET1Kyw00HOLMitE1BfZypxPYW6Svg/lfpTrftg5kRvXqOqxg5zn8IUEjwrzQl0GLvsqQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714085690; c=relaxed/simple;
	bh=OPvPhadmnJkmJD6QVWg5V0EqAqVaZnNCxCAbiIxAbfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmZLqtxmGAtF6xEFrwtSapbSxd6ayQtcxSTpyVnAPn6uXV6Yp1wH5iA8mDj6WrxvgasGTOZ/vgJ6trW0esXr2eQvSNPadbN4kJdRIvUHv7cKWkGRYGsp23XFm2WmkwF8UuORJeU36MQXQq8vjHCKn1EIj1X3U+N/oUZQ81N63p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9g+U6Vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7C4C2BD11
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714085689;
	bh=OPvPhadmnJkmJD6QVWg5V0EqAqVaZnNCxCAbiIxAbfM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E9g+U6VfRi9yDSMuMhrxB1Mp9RXJQ1zLp0BKXAT5nk6Xma8ccQ32PgMLDssWa6hKh
	 7TPxaOLJtVGIigUsVL1JghFdKQ8uaMNYEeoCiRTzK3+Yb96rZI3fitdHiJQUm2nucm
	 Ki8sb72fwIIU0pnCr5mNwwpr8IWz4X3vWH3vT7jMQjjccWc1LW3QGddl5eJwB2XBWa
	 nUmR9AduiPk0tXnUuUCAmtP6cyQR4MiLE0N5rvRNJaf7ZHf6sJ1+ppjeemWfz9UYEQ
	 74M/0gp8GmAA3GyAgu06T/GoP6by2zKaAh95AgiseLQ77OpvSrw/XPGmPJe+e+Kbqm
	 6RbRjTaDVenlg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d2600569so1885051e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:54:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfe9y7JVghC05qX5vuc735qKxH3kRjcklCgbRN2UGktReBYrW7JEVTM9Q+tAvoUogN+Ij9biwBj6JQddTRO63KruwXJxkEyfJyTBfP
X-Gm-Message-State: AOJu0Yy4cc984yVB9FQNb0w7JiF5jvJIzj1n8oxtwZn/luGCiH5B3YkH
	kPn9jyLEwn+ayF/Q0xPoaNcZbosrjy7msuLubBGsHF75kzxarO58yhzc1eCC6fMXTvod93fuyFh
	Jg2MdhsjwLniLXrXZl0Dcq8f/fg==
X-Google-Smtp-Source: AGHT+IEzNchdscKAvQzaEfeLqV2MtTfOX1FBtT+6Diul7Ucds9LiUwJam7OKzowQ4uoYAO1BDl+WjpiKVErZ8caHUNQ=
X-Received: by 2002:a05:6512:208:b0:51b:18f7:6a9e with SMTP id
 a8-20020a056512020800b0051b18f76a9emr463183lfo.45.1714085688498; Thu, 25 Apr
 2024 15:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423051826.791934-1-shakeel.butt@linux.dev>
 <20240423051826.791934-2-shakeel.butt@linux.dev> <20240423135844.GA21141@cmpxchg.org>
 <cupqywok4kl3cxotmpnfrlcsxhkaj7lbo6viehvxlltv3qkt7g@nxxplmgbcfyi> <20240423183041.GA318022@cmpxchg.org>
In-Reply-To: <20240423183041.GA318022@cmpxchg.org>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 25 Apr 2024 15:54:36 -0700
X-Gmail-Original-Message-ID: <CANeU7QksOuw48Frou6Ro6pYCVaG47dAvBPj_5xwMqyfVYx+UFQ@mail.gmail.com>
Message-ID: <CANeU7QksOuw48Frou6Ro6pYCVaG47dAvBPj_5xwMqyfVYx+UFQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: rearrange node_stat_item to put memcg stats at start
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 11:30=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Tue, Apr 23, 2024 at 10:44:07AM -0700, Shakeel Butt wrote:
> > On Tue, Apr 23, 2024 at 09:58:44AM -0400, Johannes Weiner wrote:
> > > On Mon, Apr 22, 2024 at 10:18:23PM -0700, Shakeel Butt wrote:
> > > > At the moment the memcg stats are sized based on the size of enum
> > > > node_stat_item but not all fields in node_stat_item corresponds to =
memcg
> > > > stats. So, rearrage the contents of node_stat_item such that all th=
e
> > > > memcg specific stats are at the top and then the later patches will=
 make
> > > > sure that the memcg code will not waste space for non-memcg stats.
> > > >
> > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > >
> > > This series is a great idea and the savings speak for themselves.
> > >
> > > But rearranging and splitting vmstats along the memcg-nomemcg line
> > > seems like an undue burden on the non-memcg codebase and interface.
> > >
> > > - It messes with user-visible /proc/vmstat ordering, and sets things
> > >   up to do so on an ongoing basis as stats are added to memcg.
> > >
> > > - It also separates related stats (like the workingset ones) in
> > >   /proc/vmstat when memcg only accounts a subset.
> > >
> > > Would it make more sense to have a translation table inside memcg?
> > > Like we have with memcg1_events.
> >
> > Thanks for taking a look. I will look into the translation table
> > approach. The reason I went with this approach was that I am in paralle=
l
> > looking into rearranging fields of important MM structs and also enums
> > to improve cache locality. For example, the field NR_SWAPCACHE is alway=
s
> > accessed together with NR_FILE_PAGES, so it makes sense to have them on
> > same cacheline. So, is the rearrangement of vmstats a big NO or a littl=
e
> > bit here and there is fine unlike what I did with this patch?
>
> I'm curious what other folks think.
>
I slightly prefer not to change user visible ordering for no good reason.
It is not said the order is carved to stone. It depends on the ROI.

> The cache optimization is a stronger argument, IMO, because it
> directly benefits the users of /proc/vmstat. And it would be fairly
> self contained inside the node_stat_item enum - "ordered for cache".

Not sure how much of the cache optimization is measurable here.
I suspect it is going to be hard to measure a meaningful difference
just from the cache line order alone.

> I was more hesitant about imposing a memcg requirement on the generic
> vmstat ordering.

That is a valid reason.

Chris

