Return-Path: <linux-kernel+bounces-157052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065A48B0C34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389881C24237
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868315E7E2;
	Wed, 24 Apr 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTnv4CCd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719E1E4A9;
	Wed, 24 Apr 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968111; cv=none; b=gsQIHjhVzufm+uGjBDD5K51wzJq0rmvBYkkJIRnb80JlwlvzTFgmzTw+COI8xN65pWAFef0s+xOi3TGcK3J+T421EE8Q0eCosoxQUPkn1ciBwQMmUjrW2myYd8ja6dCnZ4x1AkJl25VOu0BDBFyjh3xP4DticdkHzjvSzjQugrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968111; c=relaxed/simple;
	bh=HNbPj5ZyYt4Q8V+TnVsYN3A1lRAyvMw2Q3ZWnqGiNcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wchkw+Bvr/EyHBYmoRL70vdappVTZddYRqoO95qTl14K0LGzW4HS8Mjkcjxe4ROA9rrR3qpBXTbaEHhyEo5f3pAdDQqwTG5LG0WHNz7bUhjdJxtrm60eDV7aKExLap1h8fEEZfv2GcDAKhjnO5bYvx45FDRmHhU+V1KKnWm9tyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTnv4CCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D386C2BD10;
	Wed, 24 Apr 2024 14:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713968110;
	bh=HNbPj5ZyYt4Q8V+TnVsYN3A1lRAyvMw2Q3ZWnqGiNcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTnv4CCdOO4TGqdhQj4q+Q3Iad43fzw7mOkjyB75VJ/H5iLASLvgHE7s0WztzW3dC
	 vPoiqYH0I+Fg8TQvaUWk8Dwqk+zlCkHUTSqzuq+WBOeHc41EPDIL3g3lySuVhrtvS9
	 7HlHuvQAWedLnEz80attFMbuCqSFdNoCOUDg+mQfpuMEGhiogYxYKIRt0wu2Hz+n/4
	 sWgNDClH4dQBn1VE1AkCg8ngMgZFJT0ttNBheJ66HRpMkzy1jJKnDU4pjax0qSZ1U6
	 fn7QPph6DnY3xV1oRkU9P5JIJ/7LfazvX3oIbssSccpBxNoB3iJYYzYkcJC5+uDXzf
	 3hPllp/Ks6WGg==
Date: Wed, 24 Apr 2024 11:15:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V3] perf scripts python: Add a script to run instances of
 perf script in parallel
Message-ID: <ZikT69GIsijZajoI@x1>
References: <20240423133248.10206-1-adrian.hunter@intel.com>
 <ZihFYbdrnarNFWOd@tassilo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZihFYbdrnarNFWOd@tassilo>

On Tue, Apr 23, 2024 at 04:33:53PM -0700, Andi Kleen wrote:
> On Tue, Apr 23, 2024 at 04:32:48PM +0300, Adrian Hunter wrote:
> > Add a Python script to run a perf script command multiple times in
> > parallel, using perf script options --cpu and --time so that each job
> > processes a different chunk of the data.
> > 
> > Extend perf script tests to test also the new script.
> > 
> > The script supports the use of normal perf script options like
> >  --dlfilter and --script, so that the benefit of running parallel jobs
> > naturally extends to them also. In addition, a command can be provided
> > (refer --pipe-to option) to pipe standard output to a custom command.
> > 
> > Refer to the script's own help text at the end of the patch for more
> > details.
> > 
> > The script is useful for Intel PT traces, that can be efficiently
> > decoded by perf script when split by CPU and/or time ranges. Running
> > jobs in parallel can decrease the overall decoding time.
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied, and added a note on testing it using:

      root@number:~# perf test -vv "perf script tests"
       97: perf script tests:
      <SNIP>
      Starting: perf script --cpu=27 -i /tmp/perf-test-script.T4MJDr0L6J/pp-perf.data
      Finished: perf script --cpu=25 -i /tmp/perf-test-script.T4MJDr0L6J/pp-perf.data
      Finished: perf script --cpu=26 -i /tmp/perf-test-script.T4MJDr0L6J/pp-perf.data
      Finished: perf script --cpu=27 -i /tmp/perf-test-script.T4MJDr0L6J/pp-perf.data
      There are 28 jobs: 27 completed, 1 running 
      Finished: perf script --cpu=24 -i /tmp/perf-test-script.T4MJDr0L6J/pp-perf.data
      There are 28 jobs: 28 completed, 0 running 
      All jobs finished successfully                      
      parallel-perf.py done
      parallel-perf test [Success]
      --- Cleaning up ---
      ---- end(0) ----
       97: perf script tests                                               : Ok
      root@number:~#

- Arnaldo

