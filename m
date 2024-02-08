Return-Path: <linux-kernel+bounces-58371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2818784E55C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DD228DDEF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CD2811EC;
	Thu,  8 Feb 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfuIhJL4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF1B80058;
	Thu,  8 Feb 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410624; cv=none; b=ckFWybmHM2qiOkJV2VIo+hqYcHNAjMFiJrjhU6zwDPy1svf5vL7c4g1Rwv33DuJdGhRhfdVkfXDqSFNjQR9gj2lH3Hi5JPrD1W0GlxyJscbf3x2OLec7kRb1KIx8wjBWv+Q+BXsCtGYVK6GfTDtdPDbfyvVH7Y4COwvPdTlJWZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410624; c=relaxed/simple;
	bh=WvcWNG+k/HXeupu0f5CO8SLurJ1sa0HyRxAjKBT0hjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOJVz9Eyka6jkXicsnPxmt61LbxFxG3xr1f7QCMotAE5z02Qh78GUqMQ2fPUJAiMY3W/dCGD/MEJzTkiPGTgCYVAKyO35OL5UMp7YKCHTZGtJJmjyrZrQnLF2qLV00C2pM7/N+Gxv83x0XFyowhg0INXJn484IF40+/2tTdxex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfuIhJL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDC8C433C7;
	Thu,  8 Feb 2024 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707410624;
	bh=WvcWNG+k/HXeupu0f5CO8SLurJ1sa0HyRxAjKBT0hjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfuIhJL4tpb8FnVva+RCAJvBpXXhCsV1fb74dUCCA7WgAJnpTw6tB5bbQDAQySdGZ
	 ayMKJ2Pq+ggWUw4Vx4tT/4e3zh7tro0tWUaxk25ckLxCOrvDPo2fiu7cnEzmjyyi3b
	 oWXvDKJWGxDh1xuGGDcbV/PIVzsLspdD0xAV+XvKCQV5C5uaL5pIJ5NSQzipwGDDh6
	 ns2Loz8xHN+DtxUurNBA9mR+b9IeqPmVtDYd70ObLGCrpOxbCv0uszEIu6uBxcyxEz
	 UNvWhXMw8Ezlg9oxbroptZ2ZkIHYInjwzmINgo2GfNqsLyyalTloPkSwMbRhJQtLYA
	 mpv9vnMRpBaag==
Date: Thu, 8 Feb 2024 17:43:40 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 5/7] cpuidle: Introduce CPUIDLE_FLAG_POLLING_HARD
Message-ID: <ZcUEvKzbiTfd12wd@localhost.localdomain>
References: <20231124223226.24249-1-frederic@kernel.org>
 <20231124223226.24249-6-frederic@kernel.org>
 <CAJZ5v0jVtGYM8ETn2V2Ovct4SkpFaU-xZMyZJAOysu42OiuRiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jVtGYM8ETn2V2Ovct4SkpFaU-xZMyZJAOysu42OiuRiw@mail.gmail.com>

Le Tue, Dec 12, 2023 at 02:12:48PM +0100, Rafael J. Wysocki a écrit :
> > diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> > index 66b59868622c..873fdf200dc3 100644
> > --- a/include/linux/cpuidle.h
> > +++ b/include/linux/cpuidle.h
> > @@ -78,13 +78,14 @@ struct cpuidle_state {
> >
> >  /* Idle State Flags */
> >  #define CPUIDLE_FLAG_NONE              (0x00)
> > -#define CPUIDLE_FLAG_POLLING_SOFT              BIT(0) /* polling state */
> > +#define CPUIDLE_FLAG_POLLING_SOFT      BIT(0) /* software need_resched() polling state */
> >  #define CPUIDLE_FLAG_COUPLED           BIT(1) /* state applies to multiple cpus */
> >  #define CPUIDLE_FLAG_TIMER_STOP        BIT(2) /* timer is stopped on this state */
> >  #define CPUIDLE_FLAG_UNUSABLE          BIT(3) /* avoid using this state */
> >  #define CPUIDLE_FLAG_OFF               BIT(4) /* disable this state by default */
> >  #define CPUIDLE_FLAG_TLB_FLUSHED       BIT(5) /* idle-state flushes TLBs */
> >  #define CPUIDLE_FLAG_RCU_IDLE          BIT(6) /* idle-state takes care of RCU */
> > +#define CPUIDLE_FLAG_POLLING_HARD      BIT(7) /* hardware need_resched() polling state */
> 
> Hardware need_resched() monitoring rather?  This doesn't do what
> "polling" usually means AFAICS.

Fair enough!

> >
> >  struct cpuidle_device_kobj;
> >  struct cpuidle_state_kobj;
> > --

