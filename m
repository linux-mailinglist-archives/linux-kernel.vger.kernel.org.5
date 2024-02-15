Return-Path: <linux-kernel+bounces-67795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5EC8570D7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B2A1C21151
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44831419A6;
	Thu, 15 Feb 2024 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCB6gHCe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEFA2F30
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037885; cv=none; b=ZGtcn1kjUuBBlgv0LFtpIDppJN2geY4QMrw/t1J/YvuSxg5G81VAUaxKN+FcCN67nDz8FoPGxefEfE5UTxGSeFNFEzDoc221CUxRYx8h8WMcAG0xWhEoNA7rBos6upcBksGgd6EicoszXGD5s8kIHyAdiiB3qIPd25xBwakdIB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037885; c=relaxed/simple;
	bh=hVojgddXNYGq5ilJ1BQ3DJHe6qOJaFaqPGQxuQ/fb6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTGLdvQ3zczmfECVxZPRG2D2Q5+zGV1G1OODrLpayYHCyhmQIV9mvLjzIi1aDuzdZSmd1yXZykwccWrS0BzH0tyNomGsolbBseBLqGdQ/1XJx/sYn+NSosjnSDUoDfkHAQ6cUuVoGY4ZDOpeALY/71m4bhRsrL2XicBwJ/QDVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCB6gHCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28E4C43394
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708037884;
	bh=hVojgddXNYGq5ilJ1BQ3DJHe6qOJaFaqPGQxuQ/fb6A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WCB6gHCexF6ieyybXSNS8Le7eifsGejHlrgxq6ctGXR/clhL7vo0s4ZN4+ULeUu29
	 s9f0ESxiFzEGhgN9+ABrG3jiZdoNsy3D1l0rV/rtEW83WBt1+yxCixX3r/Ky2IuRJu
	 rOdqYPzieC3rgSbYLOqZq94FytF7uNgZ3HeVIX/jWDsKLDkqkrLq0FRAWI3zX1EYQV
	 x++ij6l1Pzhwn11wE8fJF+ozpyFM40M8cwD9CvicV0ES2WCM6mN8/6ROfLCdo9z8P0
	 +YL73OX0VjBquWwB4PB07ndzWHVmhh/N1t9HySBz1kK8gS0IuX1j62A147YLJagWJw
	 Bsopbj9pgxg5g==
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-364e819fe93so5236525ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:58:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgEZy5VtQeJYsgIP1eJMl18lQbBKPXsvj3+9cgyhbF7G7rBuZy7ZSAzYL30Kril3/8t3iQVkX84IzupTK1YVg7KHX5GRbgY1ndrAsB
X-Gm-Message-State: AOJu0Yzts0yekQoaQc/iijxm6Gd9W0EsWONQnTvkxTFrnaBIReKSb91S
	ztv//cJcwSlVOAX4/Px4JPxwewQnu/ZHmfdLniL4ghGzuoOHUhO3VHmYDTz6078YyWrlEqVT5Nw
	LyYP9lx1Bu95J30hRG9nYo7DRK7s25Mo3QCKP
X-Google-Smtp-Source: AGHT+IGfP74GkKlVuV8Htk4dGfX+hfymzix0oMGhP4DC3onmny/GHmV4R62ZEf3W8nfKApL5C4GMSleLz7euSTLulCU=
X-Received: by 2002:a05:6e02:13ca:b0:364:216f:9ce7 with SMTP id
 v10-20020a056e0213ca00b00364216f9ce7mr3017921ilj.15.1708037884021; Thu, 15
 Feb 2024 14:58:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-async-free-v4-1-6abe0d59f85f@kernel.org> <0c5431d984fe518f9f9b2f85639a6fc844115deb.camel@linux.intel.com>
In-Reply-To: <0c5431d984fe518f9f9b2f85639a6fc844115deb.camel@linux.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 15 Feb 2024 14:57:51 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMj7sabiFTBiLf8S8mUjFpPYp2fusd_Fsb=28y7Vcwfbw@mail.gmail.com>
Message-ID: <CAF8kJuMj7sabiFTBiLf8S8mUjFpPYp2fusd_Fsb=28y7Vcwfbw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: swap: async free swap slot cache entries
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Kairui Song <kasong@tencent.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:31=E2=80=AFAM Tim Chen <tim.c.chen@linux.intel.c=
om> wrote:
>
> On Wed, 2024-02-14 at 17:02 -0800, Chris Li wrote:
> > We discovered that 1% swap page fault is 100us+ while 50% of
> > the swap fault is under 20us.
> >
> > Further investigation shows that a large portion of the time
> > spent in the free_swap_slots() function for the long tail case.
> >
> > The percpu cache of swap slots is freed in a batch of 64 entries
> > inside free_swap_slots(). These cache entries are accumulated
> > from previous page faults, which may not be related to the current
> > process.
> >
> > Doing the batch free in the page fault handler causes longer
> > tail latencies and penalizes the current process.
> >
> > When the swap cache slot is full, schedule async free cached
> > swap slots in a work queue, before the next swap fault comes in.
> > If the next swap fault comes in very fast, before the async
> > free gets a chance to run. It will directly free all the swap
> > cache in the swap fault the same way as previously.
> >
> > Testing:
> >
> > Chun-Tse did some benchmark in chromebook, showing that
> > zram_wait_metrics improve about 15% with 80% and 95% confidence.
> >
> > I recently ran some experiments on about 1000 Google production
> > machines. It shows swapin latency drops in the long tail
> > 100us - 500us bucket dramatically.
> >
> > platform      (100-500us)             (0-100us)
> > A             1.12% -> 0.36%          98.47% -> 99.22%
> > B             0.65% -> 0.15%          98.96% -> 99.46%
> > C             0.61% -> 0.23%          98.96% -> 99.38%
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

Thank you so much for your review.

Chris

