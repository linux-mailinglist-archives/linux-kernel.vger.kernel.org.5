Return-Path: <linux-kernel+bounces-142894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C93B8A31BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534DB284086
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B1B1474D9;
	Fri, 12 Apr 2024 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7V7gCFu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BA145333;
	Fri, 12 Apr 2024 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934107; cv=none; b=S04JxTHls8YtJnCCVnomxL9LK/EYQF2D4o2zF4237fYxSjlEocY7OaBBHORSbYFk411adht+Up0jl8wgHQZxiwf2/c3FYRBGonJCubcNlTN5qikN6kWM2oyuNGqRTMAVheb9zwvcguCLj4CAq2rJSb7B1GOosqp05te6N7cT7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934107; c=relaxed/simple;
	bh=g07M7yc8kYh3zRKK1iY+krBO5+7cUmhQyw/ZFdMq8cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXWZXdAjzBg9paLj4kgyDAsckZIlqpT2E6bCazRP6wwmUhVI0NX7MEm7R3FLv/eypMKDO8O4L4j3eMDEDk4xkorJQNTu7UQfOLaOfMj4E8SSDaHajEvaXFiCuPTctwdgbghp3ALYPNBQ4eC0RXaZXmZQbJjTGJ14qg2DfEcmPgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7V7gCFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4961DC113CC;
	Fri, 12 Apr 2024 15:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712934106;
	bh=g07M7yc8kYh3zRKK1iY+krBO5+7cUmhQyw/ZFdMq8cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7V7gCFurKvzNIYjIChC2uSv6vjjlgWNopsQAtmkyS+1eoGqOvjIpBkHg2u2Rpwxn
	 ZsFbS5IyCEAkoY9B5L/ssNVDc5p2FGgd74BenOWltOFAUgVbXquJPLEv/FT+a1xV1R
	 nYO6UQqHkg/9xRJ2BvxhMn65d/JGfCQiSZD1SVfhWhoBx09k4576drKqB2rSE6VhtM
	 L21jllWoNqllhPpM5ejC/DQySylvPz3ypdi7bPCcJG5U/rZqKmf6Omgn1Fuf7LiW1H
	 xnDWtOoQEtR5A5LkcoGsz8SyNJgFSIju+9U1mY5Za3BkX4I79nXkJxJq5J3EpYvHZo
	 6LdbPAY+kl79w==
Date: Fri, 12 Apr 2024 12:01:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf test: Display number of remaining tests
Message-ID: <ZhlM19baK_P0zREj@x1>
References: <20240405070931.1231245-1-irogers@google.com>
 <20240405070931.1231245-2-irogers@google.com>
 <ZhP7VBvlSPrJKDP6@x1>
 <CAP-5=fVbhf_JgO9APwgOVyktazOAyEL-3vM2d-M4ropMDdYH2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVbhf_JgO9APwgOVyktazOAyEL-3vM2d-M4ropMDdYH2w@mail.gmail.com>

On Thu, Apr 11, 2024 at 10:22:42PM -0700, Ian Rogers wrote:
> On Mon, Apr 8, 2024 at 7:12 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Fri, Apr 05, 2024 at 12:09:31AM -0700, Ian Rogers wrote:
> > > Before polling or sleeping to wait for a test to complete, print out
> > > ": Running (<num> remaining)" where the number of remaining tests is
> > > determined by iterating over the remaining tests and seeing which
> > > return true for check_if_command_finished. After the delay, erase the
> > > line and either update it with the new number of remaining tests, or
> > > print the test's result. This allows a user to know a test is running
> > > and in parallel mode (default) how many of the tests are waiting to
> > > complete. If color mode is disabled then avoid displaying the
> > > "Running" message.
> >
> > Tested and applied, great improvement!
> 
> And I think it is broken. Specifically I think the nohang waitpid can
> cause the later read of the stdout/err pipe to fail. We may need to
> drain the files before checking. I suspect this as I've seen an
> increase test fails where the verbose output shows nothing. The only
> remedy for that in the current code would be to run the tests
> sequentially, so we should probably back this out for now.

Removing it then,

- Arnaldo

