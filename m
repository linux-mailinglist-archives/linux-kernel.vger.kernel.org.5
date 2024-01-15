Return-Path: <linux-kernel+bounces-26513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E3682E25B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68730283B45
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408BA1B29E;
	Mon, 15 Jan 2024 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VCth2YlI"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870C1B296
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Jan 2024 16:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705355657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0x0GB0Pul9J7I/1BQmRcmuBiTcTNJXeQ9oH4E0KOIY=;
	b=VCth2YlIj2i3L7MGL9YIxztpp/byTJft+gT/yRMawu7buCw1ctT6v2B83hDxFanNg9x8ht
	CP2QAHVN7u19pjg1mk7EUUJq863p99lqikq07isD1q8MF+y9RA7gzo6PsFjTQQ0qMyCZB8
	U1Ua5aisE6yUzBPGO35n3LHVzXazg50=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Leonardo Bras <leobras@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spinlock: Fix failing build for PREEMPT_RT
Message-ID: <yzh3yw3fsdptmlo4d27zakov3wkqzo35wenro3zaafyagfovuz@mp42k5gyfgcg>
References: <20240115201935.2326400-1-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115201935.2326400-1-leobras@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 15, 2024 at 05:19:34PM -0300, Leonardo Bras wrote:
> Since 1d71b30e1f85 ("sched.h: Move (spin|rwlock)_needbreak() to
> spinlock.h") build fails for PREEMPT_RT, since there is no definition
> available of either spin_needbreak() and rwlock_needbreak().
> 
> Since it was moved on the mentioned commit, it was placed inside a
> !PREEMPT_RT part of the code, making it out of reach for an RT kernel.
> 
> Fix this by moving code it a few lines down so it can be reached by an
> RT build, where it can also make use of the *_is_contended() definition
> added by the spinlock_rt.h.
> 
> Fixes: d1d71b30e1f85 ("sched.h: Move (spin|rwlock)_needbreak() to
> spinlock.h")
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

I've picked this up - thanks!

