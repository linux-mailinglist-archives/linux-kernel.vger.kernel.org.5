Return-Path: <linux-kernel+bounces-153666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E148AD164
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C561C22220
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD90153572;
	Mon, 22 Apr 2024 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dCk4krsQ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690F15350A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801597; cv=none; b=dDe3XW9xL9cVgNK75cFG5PE79CFLPgDCcYLdKh4wt1ZrndmgfzV4D1DoTBloepVoNgjf85cXTRt7yZp147xYULwpMdOzYz+WygPYkpvpWUa55puJbe2HhXPs+u9TLOPsRa6aGdU5VV11hnBGg+Cusg0QxZpY53Cz/tuU92uYO0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801597; c=relaxed/simple;
	bh=Xa9nZaeFyei3wM2vW62rjkL6eqcIAT5dZSTVZWEek3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmZfZsKYdpQcCMMueEM7hYW+T7EV6HA5aowPG01H7AppaH+W9nzJHwsHhKndgsMb8zT/k02mWuebCfQbqpr+I3lcSKXGLp53qhxeayVv1z6XLLmZqW/+l6X69hVux5NM5bBmcAJiPDW5oqRO+fbfsaoKhvkLmipi3vws6XpY9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dCk4krsQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=USasMDIlVBzGhe0JiKyN91KuXZCvg0QpIc1cvHi+wFQ=; b=dCk4krsQYLHdOfSSWtFrDZXNVE
	WjybHd38ZhiGfv+AsyOCLqJKd8hD0rBMsJBz8UL2ENgg5IAqOMnkg1O5CrFY2YRlQJyfk1WHBqTa2
	95QYgOG9fiO314LGyRW6+Mn4eOKi6eQfrl67IVvqEjiNf8N+FcPJGj/Kzv2L4kjvhc8bqqiYglQqe
	+Os6Q9T9/TZI2+Kc5eYqrtGrw20Qd1M2Uy40XImHYMxTYFM7u9LAhgka7TI2CRPEtLyxwBQgbpJJH
	oHztwAAbggiDwod+eQpyg6m1X631myy4/AVrN1v7W3xIxVC9MHqqrw8NcBDbUSuyQppkFXdB7Y+k1
	9+OyujFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryw4w-0000000Di52-1SCJ;
	Mon, 22 Apr 2024 15:59:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 014FF30045D; Mon, 22 Apr 2024 17:59:37 +0200 (CEST)
Date: Mon, 22 Apr 2024 17:59:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	yu.c.chen@intel.com, ke.wang@unisoc.com, di.shen@unisoc.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/eevdf: Prevent vlag from going out of bounds
 when reweight_eevdf
Message-ID: <20240422155937.GP30852@noisy.programming.kicks-ass.net>
References: <20240422082238.5784-1-xuewen.yan@unisoc.com>
 <CAB8ipk-LhSuMsp0DdzjEJN-4XEBT1_ri6BPH_nvxSgFZONMT2Q@mail.gmail.com>
 <20240422094157.GA34453@noisy.programming.kicks-ass.net>
 <CAB8ipk9M1wLXV7MWMBYGMhKbY71QqwkvchiENeWTg7JERe6kZw@mail.gmail.com>
 <20240422111744.GO30852@noisy.programming.kicks-ass.net>
 <CAB8ipk8ZBSnJfw9Ow9My-VXG1TU6DVY7mOL_i0Ejdd7GUZCLWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk8ZBSnJfw9Ow9My-VXG1TU6DVY7mOL_i0Ejdd7GUZCLWA@mail.gmail.com>

On Mon, Apr 22, 2024 at 09:12:12PM +0800, Xuewen Yan wrote:

> By adding a log to observe weight changes in reweight_entity, I found
> that calc_group_shares() often causes new_weight to become very small:

Yes, cgroups do that. But over-all that should not matter no?

Specifically, the whole re-weight thing turns into a series like:

            w_0   w_1         w_n-1   w_0
	S = --- * --- * ... * ----- = ---
	    w_1   w_2          w_n    w_n

Where S is our ultimate scale factor.

So even if w_m (0 < m < n) is 2, it completely disappears. But yes, it
will create a big term, which is why the initial vlag should be limited.

Notably, nice should not exceed 88761*1024 / 2, but I'm not sure I
remember the limits (if there are any on the cgrou pmuck).

But if roughly 27 bits go to weight, then vlag should not exceed 36,
which should be well within the slice limit iirc.

Also, as said before, due to integer division being truncating, the
actual S should be smaller than the expected S due to error
accumulation.

Anyway, the things to verify are:

 - the S series is complete -- missing terms will mess things up right
   quick;

 - the limits on both the weight and vlag part, their sum exceeding
   63bit (plut 1 for sign) will also mess things up.

