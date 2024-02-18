Return-Path: <linux-kernel+bounces-70594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5051985999C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA391C20C23
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA2774295;
	Sun, 18 Feb 2024 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zKNM5G5Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D8BEAD7
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 21:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708292735; cv=none; b=jk4F3B0/Bcimbre1xiljGDIaTsl4nhaAhvpeOTWQvssJkGSjLGLPD0onsAMiZThTCUy0kthXry3A/lGL7TBQwqRFXZfC8ChhPeY10XXomvVtRXospFBDhMZ3HzJkxz6arTndHPn18OOCsMDpBDyRQ3OhKmq1wlgUyxlWE498Bss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708292735; c=relaxed/simple;
	bh=l95OYFV0oWrXm6XhHujtK/Iz/W76B054ieH/C9GE0GU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RIWXmsbyOpeOuHvvQ3dQMFapciOVHrm8RU79scD4kMkeCr/SISjcfWEcWm/zZIiynhSa5Wed1ezCvOXlRyxWI7n9+RxoJQR7ZEay4MiIb8+CwzV67mLuvf43CwU1Wx79pLEiHz9JBGOai3c//+Jsa8V7EMKLkDXuR95O17CPlQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zKNM5G5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B4CC433F1;
	Sun, 18 Feb 2024 21:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708292735;
	bh=l95OYFV0oWrXm6XhHujtK/Iz/W76B054ieH/C9GE0GU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zKNM5G5YwF1ogU++a7VUsSysSaZVgQbYutxxrkHXOIncI5iCLrgZvzFj7qMRvcKJp
	 9m/Qe0vD+3vYOX6eh4GDtMnhrhtWO8UX1pkyLeQp/AC88cwZvB5ekS86ad/hNqMXk0
	 wXUwIWkCK6tACHeD0rtEsnsfTgRdRZsVepri6kUg=
Date: Sun, 18 Feb 2024 13:45:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Barry Song <21cnbao@gmail.com>, hannes@cmpxchg.org, linux-mm@kvack.org,
 nphamcs@gmail.com, zhouchengming@bytedance.com, senozhatsky@chromium.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v2] mm: zswap: increase reject_compress_poor but not
 reject_compress_fail if compression returns ENOSPC
Message-Id: <20240218134534.15a7b1cc7f297a2ecf4b8bc9@linux-foundation.org>
In-Reply-To: <CAJD7tkbHrMzi0z0SzQJj32cDrx4tyH5=_o41GM6JGf9DjahkYg@mail.gmail.com>
References: <20240217053642.79558-1-21cnbao@gmail.com>
	<ZdB0-fnlSyGgH2cQ@google.com>
	<CAGsJ_4xo9Z4zxgDUZAzbCZ83Y1QYXZxRKbTNU_4xDP0+eP0V=w@mail.gmail.com>
	<CAJD7tkbHrMzi0z0SzQJj32cDrx4tyH5=_o41GM6JGf9DjahkYg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Feb 2024 15:14:34 -0800 Yosry Ahmed <yosryahmed@google.com> wrote:

> >
> > >
> > > The patch LGTM, but it won't apply on top of mm-unstable given the
> > > amount of zswap refactoring there. I would rebase on top of mm-unstable
> > > if I were you (and if you did, add mm-unstable in the subject prefix).
> >
> > This patch has a "fixes" tag, so I assume it should be also in 6.8?
> 
> Hmm that's up to Andrew. This fixes debug counters so it's not
> critical. On the other hand, it will conflict with the cleanup series
> in his tree and he'll have to rebase and fix the conflicts (which
> aren't a lot, but could still be annoying). Personally I think this
> can wait till v6.9, but if Andrew doesn't have a problem taking it for
> v6.8 that's fine too.

Yes, there are some pretty extensive repairs needed after this change. 
I'd prefer not to because lazy, and there are risks involved.

So against mm-unstable would be preferred please.

