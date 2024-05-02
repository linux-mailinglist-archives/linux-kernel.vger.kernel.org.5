Return-Path: <linux-kernel+bounces-166194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8D28B976A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 020F7B211F7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEBA53814;
	Thu,  2 May 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uFQggjpZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118153365;
	Thu,  2 May 2024 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641528; cv=none; b=Fe0G4Yb93A6THyOKFHjUCqlirgkFB5puMmGFmRZ0VWrLsHBpooSAj+gYuWEsVSY6Z6zhruSyZrDZx3ycQkNcam/QTQT9T1JpKFzPekT4augF16rRp/G3qYPpJe/qzC7VXGIqiJEBj4uXaRC+E2weqblZoKJHZgrKww4HkJbhVX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641528; c=relaxed/simple;
	bh=I7p1RdtGOFI//Ur2G0I4lDz0SGt6YQnyFeR6Ar+LrsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+DmB0mjyxiK5Q75t8hdL1SGqQcswyJZpoLHulqC0wCrYBU2yAw65wGHy2o1+zx/5x+FSR5DiJ00HCY0f6XxgJ8vQznISp5cdJ9rs0sXmc6c3TfFNBmcYVywopIbx1nX2KTJBmSO6t5jFrIaZYy6+jJUx0XKRW74n0JPcKXwL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uFQggjpZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YTpMwMX+qpj6Q/bcMYzijVjSwnah9GpAyoqUNT5p8FE=; b=uFQggjpZFaHyRheUPJ/kajtRrJ
	camcEqM/4pLauiKQOWKzIw1iT5fbw+MXhwWL7BezQNa+6f0RMP8EzuUV6yU+jjvBAaVXgIb6/AFUs
	9F/68m45s3ecnvnIooOwxg0lCZlVFXCxxHlvTBwGUTCSEYHyXfEn5s8L1F+MOn33vVtyw4Y9R9cdg
	ybPOuzhOxVG8t+8/c8JyM5lNw2TwVa0G0SUuMbJsk9LfFS3kWh2Cs0ffjoMbfS0QBqhpagjg6MZp0
	5pKlVxu5Xw8HW5TniqLT+UuUUjWqs3JEH7cu1Yfnc0Fp5miS1M+N3a3uVPsxxMIIaJlRpQuiNr1Wk
	AH/wktrQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2SaL-00000001Kdw-2O0D;
	Thu, 02 May 2024 09:18:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3B94A30057A; Thu,  2 May 2024 11:18:37 +0200 (CEST)
Date: Thu, 2 May 2024 11:18:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@outlook.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/ring_buffer: Prefer struct_size over open coded
 arithmetic
Message-ID: <20240502091837.GA30852@noisy.programming.kicks-ass.net>
References: <AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <20240430091504.GC40213@noisy.programming.kicks-ass.net>
 <202405011317.AF41B94B@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405011317.AF41B94B@keescook>

On Wed, May 01, 2024 at 01:21:42PM -0700, Kees Cook wrote:
> On Tue, Apr 30, 2024 at 11:15:04AM +0200, Peter Zijlstra wrote:
> > On Mon, Apr 29, 2024 at 07:40:58PM +0200, Erick Archer wrote:
> > > This is an effort to get rid of all multiplications from allocation
> > > functions in order to prevent integer overflows [1][2].
> > 
> > So personally I detest struct_size() because I can never remember wtf it
> > does, whereas the code it replaces is simple and straight forward :/
> 
> Sure, new APIs can involved a learning curve. If we can all handle
> container_of(), we can deal with struct_size(). :)

containre_of() is actually *much* shorter than typing it all out. Which
is a benefit.

struct_size() not so much. That's just obfuscation for obfuscation's
sake.

