Return-Path: <linux-kernel+bounces-143980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D6E8A4056
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDF6281D86
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F7919478;
	Sun, 14 Apr 2024 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cwbtfyr1"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BEC1B962
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713069847; cv=none; b=MOj1YVHrxBR0UNbgj0CLrwl65yWHvFoL+2KPk/5Rm65v3gYVL7PHX5a8fGq/sNeuVGSxoILw2TTAO9U8i1jBvPYAMy677L3TqNUOqL1u6FtB+3li29OpmSNzfNR+7X/AynNDclCdERKvSmV/Ag0SAWE610YP1G74CZvRj7/5N/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713069847; c=relaxed/simple;
	bh=tIfkFFUmRxOOPV0VC/F7xum0M9JLZCTctS00A2bwfX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZi4V+ny7FeY2KspRnsu1XGJD4v5s1vd/7f/MEkRj8A08GwenL17pNXt+PJTazf4J3cBBxpYISXr5h2Ji1zaglvBECDzUK4wPTHbm2KqUB+NoPcLGrfBMBAabKPwal6gYoxuEmQmjyu9ZwkUZVzx1d73pydISEl5h96H8m6bsNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cwbtfyr1; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 13 Apr 2024 21:43:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713069843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=otHS0atHsgTcQr9IUlutnpMjbK203rMss46uXgTySWc=;
	b=Cwbtfyr19KBz3dnt2TrYVx25k1AFtXX63eAFtNfEEYBbfqXnyk1wql9ITU/pLXT7ohj/7f
	yuUlGewtbkN/GjeWkgvbCGiK8OPyr3OUlsStxTij1hhFX9c5wxSB31FvCf3/cq/VH++X3b
	5lYwq8WSFXKN3/SaH1fvlbgW7j3ZxKI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	syzbot <syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com>, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [cgroups?] [mm?] WARNING in __mod_memcg_lruvec_state
Message-ID: <ay26fatdqt2k3ub7awzdxsrxrchb7ckwyefilvgotu74ojoxlx@twomhinrtlzi>
References: <0000000000007545d00615188a03@google.com>
 <20240403180752.f95e1b77e033b5e03164c160@linux-foundation.org>
 <CAJD7tkakCEg9zkwCrBr8GyObO7b9KOD6rUgyqniFN+YTCePd0A@mail.gmail.com>
 <CAOUHufZPLEmrh0x43k2ysqvwYwEotGk8Bw=fwyO9aLXXv0aM9Q@mail.gmail.com>
 <CAJD7tkbMR1AdKz3GquHym1MGROgpMcjiubKQ2oOzmpObTHd9Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbMR1AdKz3GquHym1MGROgpMcjiubKQ2oOzmpObTHd9Tw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 04, 2024 at 09:47:34PM -0700, Yosry Ahmed wrote:
[...]
> >
> > Probably an RT build where _irqsave doesn't disable IRQ?
> 
> Yeah, that's possible. I don't have enough familiarity with RT to know
> for sure. Perhaps lruvec->lru_lock needs to be changed to a
> raw_spinlock_t? I am not sure if that's the correct course of action.

The kernel config does not have CONFIG_PREEMPT_RT enabled. However I
have not idea how irqs are getting enabled to raise this warning.

