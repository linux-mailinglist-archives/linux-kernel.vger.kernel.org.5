Return-Path: <linux-kernel+bounces-79730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F23858625E3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3885A1C20FFA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD1447A5D;
	Sat, 24 Feb 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEVBuFq6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B2446544;
	Sat, 24 Feb 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708790331; cv=none; b=iEoNFwfEeSCv33wkpaGvtmBUSPTrJnXZx4VoSTNWERNa81FpFG9cb7Rb2kiMcNhG+fjVnmkUvARnAO4c//kGkOfCn/j2tsLMYCADCtZn6fYWBmFxer3F2RcrhCRy356b+BQjrpLPPnsYeaeD6bDmdD9GVucQE//iulDco//38Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708790331; c=relaxed/simple;
	bh=ymKqKz0uEEANxmgT8GLsJEyIWmA5nB8NdlwU00hW8TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wms/30kM15DrLBS6RAVeOlpiKR6YYLgMCcayz1zAWH0R56wMc/46vkXOYCXIrCMvBu09bXaDbUOkqUzZxlwapyA8HgQ0bv3XF6gmjih6+xUR8F0zNC/NgcJ6jsOfhBOCFfURT5MAfmFjiNTNarV7LgeUM79UT7buDDXM5y4UU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEVBuFq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987B8C433F1;
	Sat, 24 Feb 2024 15:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708790331;
	bh=ymKqKz0uEEANxmgT8GLsJEyIWmA5nB8NdlwU00hW8TA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEVBuFq6oJDdAP1MaqLFUlcv2816kENsCzujuM1m4gOap4OVMsQSTjdtJsr5GfPC5
	 KSEbXmYYX91ADpokA/uP3LixK5WMdaRA8BmnhM2UUplhgnrH/YisHWuLc7ipNDLx6T
	 GHR1TwDCOOyCc/YlQuDWUt1i+BiMniv3Vjz6BMmTCRY2sxUBTWQGtDk6kAoBWWr7qp
	 duxBPVQlmrYzhejxhImM50cONNy6wYJgvXu/OYUOK764M3dWmGuTuPxd2T6nz3Pbis
	 fLqYAEszJLvgW1KEbKMcIBWXor5W0JarQ8hKozW/YOTBNMPEEAUH1K2i1ItfMiSca1
	 sOYHEDqSTi9qA==
Date: Sat, 24 Feb 2024 12:58:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Robert O'Callahan <robert@ocallahan.org>
Cc: Kyle Huey <me@kylehuey.com>, Ian Rogers <irogers@google.com>,
	Kyle Huey <khuey@kylehuey.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf test: Test FASYNC with watermark wakeups.
Message-ID: <ZdoSN9FA46NfrkzJ@x1>
References: <20240221175210.19936-1-khuey@kylehuey.com>
 <20240221175210.19936-2-khuey@kylehuey.com>
 <CAP-5=fXsv7TJ_SVOZc38fN0gn+7cWBcMWt3FdVLcs5v0_vO=uw@mail.gmail.com>
 <CAP045AoSHWoOP3TN=6Hf2wZj7X9Y41sThBQWCDZ3BEP68qeTBw@mail.gmail.com>
 <ZdemibZepMqWvv6U@x1>
 <CAP045Aqc6woHGYKJG4d=x4gPd0=PmrLeFv25Rkts1a8xFuocOQ@mail.gmail.com>
 <ZdjdAKIV39A-jpR5@x1>
 <CAOp6jLZKZKyYrJrzjZ90ZdxzzuDV0wp+XS3Rzssd-kvZV45JSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOp6jLZKZKyYrJrzjZ90ZdxzzuDV0wp+XS3Rzssd-kvZV45JSQ@mail.gmail.com>

On Sat, Feb 24, 2024 at 10:43:38AM +1300, Robert O'Callahan wrote:
> (I work with Kyle.)
> 
> IMHO this is more of a bug fix than a feature. `man perf_event_open`
> expects this to work already: "watermark: If set, have an overflow
> notification happen when we cross the wakeup_watermark boundary" and
> later "Alternatively, the overflow events can be captured via a signal
> handler, by enabling I/O signaling".
> 
> Bug fixes need regression tests. Such tests should fail on any kernel
> where the bug is present. It seems strange to expect each such test to
> detect whether the bug "should be fixed" in the kernel it's running on
> and skip when that's not the case. I haven't seen any other project
> try to do this. Instead (as in kernel selftests) the tests, the code
> under test, and any metadata about which tests are expected to pass
> are all in the repository together and updated together.
> 
> It makes sense that tests for the code in tools/perf should not fail
> on older kernels, given that the code in tools/perf is expected to
> work on older kernels. But tests for bug fixes in the kernel itself
> should be expected to fail on older kernels and therefore should live
> somewhere else, IMHO.

That is fine, I was mostly trying to help in having the 'perf test'
patch posted to address the review comments from Ian.

And I'm biased because I work on a company that does lots of backports
and then test perf functionality using 'perf test'.

And also because the kernel now has this BTF information that can be
used for introspection.

Being able to run the installed 'perf' tool and check if some fix is in
place and its regression test is passing looked like an improvement
when compared to the selftests method.

If in the end people decide to do this in selftests, that is ok with me.

- Arnaldo

