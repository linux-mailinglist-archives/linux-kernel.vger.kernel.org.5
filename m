Return-Path: <linux-kernel+bounces-109115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE49F8814D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82CF6284A71
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED1553379;
	Wed, 20 Mar 2024 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO2L/JJv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354453378;
	Wed, 20 Mar 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949469; cv=none; b=DcxOw/klk50qfaTKYTQgsg0luvba7fArk4udMr4YzDy5WeotMNiTu/4uM1OYtvhprxnktSZYuWvdkij4bC8Hq9CVAVExjfxik5Upg3jdFTSsRm/Zx3w5TrCTWBpGJcaBCo0jSdZog/LqyqpLVsKdADmvuDU8YPoWIEVmIE1v+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949469; c=relaxed/simple;
	bh=a0za4WCCKbmt2ceizF1eT8CjZalN0VYRpB7LLv7Opm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBjXnO1BaCiVWMGbhs0MTY6HP5l40/ZEKL1iXr3K7eyirghVDJmvvHVHxI2NP3S8tOrcFHWPL5ezfSGWvG/kQxDAn88vLSSorkl116h6FODMOHSRLaHG+cNDCRXj4yYMrmlCFrS42kzMwG96fuSoZXYHgiRZtXb66fbocgAu6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO2L/JJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE94C43390;
	Wed, 20 Mar 2024 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710949469;
	bh=a0za4WCCKbmt2ceizF1eT8CjZalN0VYRpB7LLv7Opm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tO2L/JJvVcqFMoZ+uhlo2XCL/9B3it6J2Pn3Sdp0CpVsBr6CwpL0y/RarhJSvVW6F
	 piqDwxgFl8MlKsMBAZ72TakOPmBzYn6pFJUoYxXHgW+pjEUDyEjFKrgULXlveBBaQU
	 8/0PeP/FSj5H50ry9ZLDOIdKtL6eRuQQY+0/IeRjhz2qMrt1R60cCcopj+e0Qibhk6
	 miTioizB19R2Z2eN8mxhIEs1CGCT9aHR6CR1lQt5Chbk/y+zRw1DbZCSAXokwUVuyH
	 CqSMALkdGU/7d/fUxZspmwXyIzuBzac25dxR8WqUcsHWEr4iDrGTPSWltB6GjL+3xI
	 pHCsH75UVFddg==
Date: Wed, 20 Mar 2024 12:44:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: Suggest inbuilt commands for unknown command
Message-ID: <ZfsEWoi6eevwLRQC@x1>
References: <20240301201306.2680986-1-irogers@google.com>
 <Zfr4jX_b8FCOG_x_@x1>
 <Zfr5__Ej3-0C8sJj@x1>
 <CAP-5=fXXrJRH=Dto2ajD_TUDE1YmkkJZO5Ey2pq5YB0wbVAzeg@mail.gmail.com>
 <Zfr-sQJPbZzbtk8K@x1>
 <ZfsBopALY3whsst5@x1>
 <ZfsDtr5ejAwGySOR@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfsDtr5ejAwGySOR@x1>

On Wed, Mar 20, 2024 at 12:41:45PM -0300, Arnaldo Carvalho de Melo wrote:
> ⬢[acme@toolbox perf-tools-next]$ perf raccord
> perf: 'raccord' is not a perf-command. See 'perf --help'.

This works with the second patch.

- Arnaldo

> ⬢[acme@toolbox perf-tools-next]$ perf ricord
> perf: 'ricord' is not a perf-command. See 'perf --help'.
> 
> Did you mean this?
> 	record
> ⬢[acme@toolbox perf-tools-next]$ perf ricord
> perf: 'ricord' is not a perf-command. See 'perf --help'.
> 
> Did you mean this?
> 	record
> ⬢[acme@toolbox perf-tools-next]$
> 
> So I'll add that and go on from there.
> 
> - Arnaldo

