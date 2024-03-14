Return-Path: <linux-kernel+bounces-103406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7524787BF00
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A610B1C21141
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6067450EE;
	Thu, 14 Mar 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLzNAp1a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131006FE1E;
	Thu, 14 Mar 2024 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426883; cv=none; b=K1VvbdsaJfCGVVaC6lUKzbqhP3U7wTQGkoBlhFWhJMNoyR4/LupWFBCCPlRMNP7qq+GZDb2xN/634XZRaFU9L7+VD9Li+rAMx7O98luXYrYbguS/sJ+WJFiL781QQgBuI7ig92p/0S1Hw4lvYsQkc9Dq9BbZ0u345QO10FQbO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426883; c=relaxed/simple;
	bh=3QHwzUu9Qz5Nt+YZgo+FDXTbZnPnbZKymsKtzBbdHKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGrNTWwm0E1+x6P7MPd+Edc5h9THXGMe/xfoFgcpKHyJs+rforHiSDRZV/MPjYWblC7DwwiLiku6IPraA1ZFP87YifBQKSJo7XpIP3k6zqX4yXKaHK5UpiX9YEms57TkR6cFjPKEqOXE0L0/M4J/+Sreq5SmEasGT4f6uPWe6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLzNAp1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C6FC433F1;
	Thu, 14 Mar 2024 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710426882;
	bh=3QHwzUu9Qz5Nt+YZgo+FDXTbZnPnbZKymsKtzBbdHKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLzNAp1anNhoQtXC+NyJPrviKJZbmL3QjAKlnrXCW/kJt473/Bz5B09XGBcfkSal5
	 lwnHJM+n6ht4wZgZJ+zHynHbslWkR9fQWqHnnZmLHRptYDXFUEM9cczLF1uD9lFFSj
	 pkN5Isyyic06169uPTAthAZCPfxPnrbHwpGf9tlbn0gJAm8f0Ie3CcbGeCB9tEdX7P
	 kBdzSD0a4uRiG+wZhRDnv59/DZ7dTykUqIwLk/vF6NtPdGGlXYQ/0O3AXER6yZFCe0
	 bTm5hDRfgZeoKYSGFUAUr4L1zrKwFyYA6Y3d21ftsKxzN+oBcbpImELqJqeg06iR8X
	 6omVWiymzfJLw==
Date: Thu, 14 Mar 2024 11:34:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marco Elver <elver@google.com>, Vince Weaver <vincent.weaver@maine.edu>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <ZfMK_yTzxTQCMGZ1@x1>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
 <CANpmjNMYGa46pRQUOfzTa_FRvftOGqg+UDeD_B-tbZgYw-MWww@mail.gmail.com>
 <ZfHE9Ev5T3Lq7o34@x1>
 <ZfHtBB5_-3RByE8p@x1>
 <ZfHw3J5PY6qy4mXn@x1>
 <ZfIIqcmRlrxwUFTn@x1>
 <ZfIJIfqeI9tWnnS5@x1>
 <20240314091033.woaK8h83@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314091033.woaK8h83@linutronix.de>

On Thu, Mar 14, 2024 at 10:10:33AM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-03-13 17:14:25 [-0300], Arnaldo Carvalho de Melo wrote:
> > > tldr; No dmesg activity, no kernel splats, most tests passed, nothing
> > > noticeable when running with/without the patch with Vince's regression
> > > tests. So:
> >  
> > > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Too quick, now I'm testing it on top of torvalds/master, no PREEMPT_RT.
> 
> Just to be clear: You revert your Tested-by because now you test this on
> torvalds/master but not because you reported a regression which I
> missed.

You got it right. No regressions, the code is good, I just need to test
it a bit further, with torvalds/master, without PREEMPT_RT.

- Arnaldo

