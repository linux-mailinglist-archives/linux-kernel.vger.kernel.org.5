Return-Path: <linux-kernel+bounces-37408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 496D783AF67
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251CF1C20947
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823E47E784;
	Wed, 24 Jan 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPeAVYvT"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA27E77D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116495; cv=none; b=Q/ytsJOBKSZLvSfONQMpvSi7c8Af3pVCqNOcKM94c0NMnGMMLBRg2+P5nvzzHvcZU6oAM2tmpVheqoshfdOVDbvTX5j8O2BTEi5ebKI521CqJ6uHflkuFvscDpYtjI0jl3e0+hbUGjkajtj5hwwS3ZRnqjIykd/tJkxJnPBXVGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116495; c=relaxed/simple;
	bh=L+uKNZ2WLPla/ZZDd2j6xgzXzpDBrpy/IS7/1AiSgck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfB9tLRG7ucZ/CVnDaHkXH95C0jrw/2mFRqSke/f8LQpVAgsxsBPP76WXVnQzBGqaSlA3rEPkg/cISf6zmWUZ9k4six2sS7YToZ8D+2JnkBXaSoBeh+Dfhf3DesIq/JYNTb7PMyeLS1G5idQhatdv7kfiq7ehH+mQ2YPof+bgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CPeAVYvT; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc226dca91aso5387356276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706116493; x=1706721293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+uKNZ2WLPla/ZZDd2j6xgzXzpDBrpy/IS7/1AiSgck=;
        b=CPeAVYvTubcUE0/pvNwCEz8yfdrflu1o9zIVOin0UVri8VWAA100tK8PukmKo/zQLE
         ODxhSrpP6ZfYEnnAIEMXWB5W+5dOPzYzNnSCplOYRjc7mT9+vvM/GuPCAR/jEdboF0A8
         TqdjgQxfPsqzCOyhuADmaextTaRgWvFxxWMsjIDI/27svjYhQCYsj1LnnBQw6z6V6TyJ
         lmEhGDwPenhcluRGaO77d5GwlZP2N63+GtOTnbEaK6X8tmEPPNxUqDFGSsIwzt1+r8RJ
         UZLk6W+JaMY7stoehrX6mkAwKAb0ptVm7gztmTjkAIVRIV5tQ12HC9plcx0p/Ip+om6L
         waKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116493; x=1706721293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+uKNZ2WLPla/ZZDd2j6xgzXzpDBrpy/IS7/1AiSgck=;
        b=RFmpn2y8pgZDzqzxuKQyRexUYQeaXi4ztZeTP2OP+3VaWVhfAuw4PG23YPyJi2bs7F
         8f9gTR+GFLVERpedJwvzPpOyfGtn5N3uEm0pWs93lzbZ5NzmHMUkqfTvrXWhrcEWvCEi
         eFdd3kKHt24UB4D1qO12vdzrlgd3dcr4n1cM6kEJtVCfXe3iY2kI1QZEgdAcv1C6L/ld
         I/EAdhiB64TcRpfp2I6YgQtc0xbpRtHiLX/YasI2v/QZlnJCanLQdAOZf6QHv+tWhVhc
         tieSdGSnlwtsgL/NpY0RCfPFfOm4W8gcxJEnBk95kIdIpFGQco4Q4URUZpfuev5adk/v
         049A==
X-Gm-Message-State: AOJu0YwWBEI4rx7zCCznGG23wt7Ik0l0vuo08vzIDbTANeOe0Gx10cqS
	/uScsXz42gINbKY0IGn587y0MkLZg50va1n+KypUM5mLPTxVEs309m36yRXHSu7o5Qxx1ryWKuT
	Ius9NQ3u5mAZCK598ePXBgpdi9QcXpTTrOx5oykaXQUhN+XO+YmCI
X-Google-Smtp-Source: AGHT+IEyp81Xa3DtWhJJgEOzKJKQ9s20e1ls6AY//91B3LGvmFlTYsSm8FpcvIUZCb4scVB2oR6nq9DljRkSRMJJDKE=
X-Received: by 2002:a25:c78f:0:b0:dc2:2f4f:757 with SMTP id
 w137-20020a25c78f000000b00dc22f4f0757mr978740ybe.7.1706116492806; Wed, 24 Jan
 2024 09:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121214413.833776-1-tjmercier@google.com> <Za-H8NNW9bL-I4gj@tiehlicka>
 <CABdmKX2K4MMe9rsKfWi9RxUS5G1RkLVzuUkPnovt5O2hqVmbWA@mail.gmail.com> <Za_m9Pymh0y-lzgX@tiehlicka>
In-Reply-To: <Za_m9Pymh0y-lzgX@tiehlicka>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 24 Jan 2024 09:14:40 -0800
Message-ID: <CABdmKX3kPXAv18+AezoqAeb3ALCbLxcth+ZHv2jZGXsZG5C6hw@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm:vmscan: fix inaccurate reclaim during
 proactive reclaim"
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com, yuzhao@google.com, 
	yangyifei03@kuaishou.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 8:19=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 23-01-24 05:58:05, T.J. Mercier wrote:
> > On Tue, Jan 23, 2024 at 1:33=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Sun 21-01-24 21:44:12, T.J. Mercier wrote:
> > > > This reverts commit 0388536ac29104a478c79b3869541524caec28eb.
> > > >
> > > > Proactive reclaim on the root cgroup is 10x slower after this patch=
 when
> > > > MGLRU is enabled, and completion times for proactive reclaim on muc=
h
> > > > smaller non-root cgroups take ~30% longer (with or without MGLRU).
> > >
> > > What is the reclaim target in these pro-active reclaim requests?
> >
> > Two targets:
> > 1) /sys/fs/cgroup/memory.reclaim
> > 2) /sys/fs/cgroup/uid_0/memory.reclaim (a bunch of Android system servi=
ces)
>
> OK, I was not really clear. I was curious about nr_to_reclaim.
>
> > Note that lru_gen_shrink_node is used for 1, but shrink_node_memcgs is
> > used for 2.
> >
> > The 10x comes from the rate of reclaim (~70k pages/sec vs ~6.6k
> > pages/sec) for 1. After this revert the root reclaim took only about
> > 10 seconds. Before the revert it's still running after about 3 minutes
> > using a core at 100% the whole time, and I'm too impatient to wait
> > longer to record times for comparison.
> >
> > The 30% comes from the average of a few runs for 2:
> > Before revert:
> > $ adb wait-for-device && sleep 120 && adb root && adb shell -t 'time
> > echo "" > /sys/fs/cgroup/uid_0/memory.reclaim'
>
> Ohh, so you want to reclaim all of it (resp. as much as possible).
>
Right, the main use-case here is we decide an application should be
backgrounded and its cgroup frozen. Before freezing, reclaim as much
as possible so that the frozen processes' RAM use is as low as
possible while they're dormant.

> [...]
>
> > > > After the patch the reclaim rate is
> > > > consistently ~6.6k pages/sec due to the reduced nr_pages value caus=
ing
> > > > scan aborts as soon as SWAP_CLUSTER_MAX pages are reclaimed. The
> > > > proactive reclaim doesn't complete after several minutes because
> > > > try_to_free_mem_cgroup_pages is still capable of reclaiming pages i=
n
> > > > tiny SWAP_CLUSTER_MAX page chunks and nr_retries is never decrement=
ed.
> > >
> > > I do not understand this part. How does a smaller reclaim target mana=
ges
> > > to have reclaimed > 0 while larger one doesn't?
> >
> > They both are able to make progress. The main difference is that a
> > single iteration of try_to_free_mem_cgroup_pages with MGLRU ends soon
> > after it reclaims nr_to_reclaim, and before it touches all memcgs. So
> > a single iteration really will reclaim only about SWAP_CLUSTER_MAX-ish
> > pages with MGLRU. WIthout MGLRU the memcg walk is not aborted
> > immediately after nr_to_reclaim is reached, so a single call to
> > try_to_free_mem_cgroup_pages can actually reclaim thousands of pages
> > even when sc->nr_to_reclaim is 32. (I.E. MGLRU overreclaims less.)
> > https://lore.kernel.org/lkml/20221201223923.873696-1-yuzhao@google.com/
>
> OK, I do see how try_to_free_mem_cgroup_pages might over reclaim but I
> do not really follow how increasing the batch actually fixes the issue
> that there is always progress being made and therefore memory_reclaim
> takes ages to terminates?

Oh, because the page reclaim rate with a small batch is just much
lower than with a very large batch. We have to restart reclaim from
fresh each time a batch is completed before we get to a place where
we're actually freeing/swapping pages again. That setup cost is
amortized over many more pages with a large batch size, but appears to
be pretty significant for small batch sizes.

