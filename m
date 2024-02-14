Return-Path: <linux-kernel+bounces-65849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE118552CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC56B2A590
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB3413A276;
	Wed, 14 Feb 2024 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRgkOYUv"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06E12F5A2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937035; cv=none; b=panNDcu7gQCKhpQbsHoHHYUPig5SYlZth2uAySxa/bUG6DKyMU5sBkspkiqKXUSyONJI/RKjTCVq2KnCrk6GlOSEIty2AiVxfma8krUIwM0MM2so9aRYA5Qdodik+PXrhufgn9vTNK4jAa3Kz8reHBaaafw3xXJCm3fIIuZ7kc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937035; c=relaxed/simple;
	bh=zukc9bEvpbmmQV/8hwzHujSES/Vg8/5OkOypsxKLytY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSbFoVjS8vywAtjWU/zYjXT+xrVYBF/Jgx5YV2oC5mEp7A2ZfJsWantVexdOAYWulJbaN3LFlorqpLTqNYijrhF4r10fERTR4uOm4B2PDk5voEc9vgOs92j4TRzm0cFJ6mwVU7Fk8H7Ih6KdOTxKH8fMw8ksEuIZnbpxJIyoZ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRgkOYUv; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7bed9fb159fso580539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707937033; x=1708541833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJnslB2CZfmXgMrNU6HSYcCTfahoTQjHsVs8f3xtvS4=;
        b=mRgkOYUvWsTk1iHyQvetF+rXJ6lLqP+e9Fm+AD/hh3sRTTo6ol5H2MJA4SfM0Hsy4y
         YFHMfzmPEkpMMXLm7cAMMOqWjS1DMjz3KFpwhKCCJw8Tyy2j90pl9aGE9H/Bp0dahY+1
         Fr39k/Xpm/o1A1k9AFWVBKB0cHp3AMlDXCgfLLT5ep4HY9MQXlutp6eAujpAB7CJjjOA
         SbubLSkc3rbMb9iBdJsZx6Qn22H/nAkERhrit0t+Kj4gmOxktJHPdOJCZ4tyTyftTKWy
         OTpy4UWmLqT9idUp/dS9XEWsop4T1MT/h9SY7DiuTPJXpUk73VE5TpiO5R+mds54HmHs
         6YsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707937033; x=1708541833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJnslB2CZfmXgMrNU6HSYcCTfahoTQjHsVs8f3xtvS4=;
        b=X8tRuNIiaI/+gvN1HH+VwI3iK8k+kClqLN6Vbxe7ez/nKCBOV9AmQIUcX/dtZ2M+US
         ttkCTDr7D9/pvfvzp1U5OEe33WDbSdNXYWvnedl76bw9AbwcQwFmGS6imwcSFyzWDsJB
         y/P3ADyNqR5p/qZw9/3QZNpMVKLH3nPMVGzx3Qf4dbxPkoAI8Jcbkf2/InqJGKv0/O4d
         1bS6TjFvWdy5HlBXaSMnNke90haYn2qkQw3bfV3XG1iJ08JiX250eslxaQZF+Qz047fx
         8uWQpaUDXN4bBKmAqaP4YWiG7s1zb3N28Kr44ostOp7NijSuQ0AvaWGfaXaqHAVE/0Ui
         fjDA==
X-Forwarded-Encrypted: i=1; AJvYcCVP4Vb5rWzDkouH2Yu4S0q6TqG5nLRNttcwkUDWfvXuGpewa5exC0fM3U4iqqUOiroHpan7VFikaEyfv4JmrQZp264kfBwuck2TVzal
X-Gm-Message-State: AOJu0YwUMvJ9OGPfH2Us6XsPjRmx5SzgRMYwQmShd3641g9KwYcNYIA7
	+7ySGl8aUn7ZJKXka+V+XwbOYM5I7/snTS5P3zeJmGn2fCQD1cq/FU0XHkuHzw1FxOKakPOV58E
	eCXQd2wkXpKWkqDN+sViqTH/sb8tmnYMeY0Ts6w6RAemlO5PAOA==
X-Google-Smtp-Source: AGHT+IGN23MqhUjWhsi32LcFDx18GhHccM/X1qvWfrLXMU/NaxS8kqfHK1uiej1XjiYz0XqHeqhCrv/NMAZaKWRuWJg=
X-Received: by 2002:a92:d182:0:b0:363:b362:a2bb with SMTP id
 z2-20020a92d182000000b00363b362a2bbmr3721495ilz.32.1707937032775; Wed, 14 Feb
 2024 10:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-async-free-v3-1-b89c3cc48384@kernel.org> <c4ae18fb13ab1c63cdd34da9fe7b1e0f1a91c909.camel@linux.intel.com>
In-Reply-To: <c4ae18fb13ab1c63cdd34da9fe7b1e0f1a91c909.camel@linux.intel.com>
From: Chris Li <chriscli@google.com>
Date: Wed, 14 Feb 2024 10:56:59 -0800
Message-ID: <CAF8kJuMXjp1A1kdS_x-S_dyst8MLHwjuAEt-SfGERKVYZNmRww@mail.gmail.com>
Subject: Re: [PATCH v3] mm: swap: async free swap slot cache entries
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

On Tue, Feb 13, 2024 at 4:08=E2=80=AFPM Tim Chen <tim.c.chen@linux.intel.co=
m> wrote:
>
> On Tue, 2024-02-13 at 15:20 -0800, Chris Li wrote:
> > We discovered that 1% swap page fault is 100us+ while 50% of
> > the swap fault is under 20us.
> >
> > Further investigation show that a large portion of the time
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
> > Add /sys/kernel/mm/swap/swap_slot_async_free to control the
> > async free behavior. When enabled, using work queue to async
> > free the swap slot when the swap slot cache is full.
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
> > ---
> > Changes in v3:
> > - Address feedback from Tim Chen, direct free path will free all swap s=
lots.
> > - Add /sys/kernel/mm/swap/swap_slot_async_fee to enable async free. Def=
ault is off.
> > - Link to v2: https://lore.kernel.org/r/20240131-async-free-v2-1-525f03=
e07184@kernel.org
> >
> > Changes in v2:
> > - Add description of the impact of time changing suggest by Ying.
> > - Remove create_workqueue() and use schedule_work()
> > - Link to v1: https://lore.kernel.org/r/20231221-async-free-v1-1-94b277=
992cb0@kernel.org
> > ---
> >  include/linux/swap_slots.h |  2 ++
> >  mm/swap_slots.c            | 20 ++++++++++++++++++++
> >  mm/swap_state.c            | 23 +++++++++++++++++++++++
> >  3 files changed, 45 insertions(+)
> >
> > diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
> > index 15adfb8c813a..bb9a401d7cae 100644
> > --- a/include/linux/swap_slots.h
> > +++ b/include/linux/swap_slots.h
> > @@ -19,6 +19,7 @@ struct swap_slots_cache {
> >       spinlock_t      free_lock;  /* protects slots_ret, n_ret */
> >       swp_entry_t     *slots_ret;
> >       int             n_ret;
> > +     struct work_struct async_free;
> >  };
> >
> >  void disable_swap_slots_cache_lock(void);
> > @@ -27,5 +28,6 @@ void enable_swap_slots_cache(void);
> >  void free_swap_slot(swp_entry_t entry);
> >
> >  extern bool swap_slot_cache_enabled;
> > +extern uint8_t slot_cache_async_free __read_mostly;
>
> Why wouldn't you enable the async_free always?
> Otherwise the patch looks fine to me.

Thanks for the feedback.

Just in case someone doesn't care about this optimization and wants to
opt out this behavior?
Anyway, I am happy to update the patch without the sysfs control file as we=
ll.

Chris

