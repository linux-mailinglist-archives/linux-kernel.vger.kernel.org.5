Return-Path: <linux-kernel+bounces-109292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD45881744
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B51281D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640786BFBA;
	Wed, 20 Mar 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ove95qgE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E39664A4;
	Wed, 20 Mar 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710958832; cv=none; b=D5G3ojlMkpYC0Yrd8QdYj2ntz0INDLdgiwBm1H3oVkzfm95Muj1Sjrq/rxUgIjaWSEmELohSVNKvhfSk84r+93Czp6tq9amEK1IBvwW0kY24cQJQ8tyOaN2JdrekSzRQAmcKQmvW6frYfLHORHAb/k2P1SIVCArs4wDs2P68uXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710958832; c=relaxed/simple;
	bh=eVjzfg5iQZiHcL703HNMokoGFzg5pRPfbFf/xbifFaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlIxZfHVmquD8WHqHzD3ZMS7LBWSsICK6r/8udXE24JkQEf73OH6pvqpCEkg63nXaukfJgs8kmH9nasTxh0WZSKRlct1wV/EnMS9dTfLjSw6MdSSHpiG8Q2Q/Nh21ELxFV4XLD1E+oV4/+jDqmUt+XZWETAiKBM+0gbirLoOU6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ove95qgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB4EC433C7;
	Wed, 20 Mar 2024 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710958831;
	bh=eVjzfg5iQZiHcL703HNMokoGFzg5pRPfbFf/xbifFaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ove95qgE/9QvnlrXaca6i0w2LZMZsnDj2Ts4cXVL06kL0jvHcdHRuqOrwqLcNXSTQ
	 WCY4/ZmtiIRLNtMlB3IpRjS085adAGCOuvNin+vcQwZFp/5esf2cd4BqvZYPib/hV2
	 lBMS1ZZJzYc23fTxlSCFip0KuOKArO1vBzsb8XFOXpzlTO7Jno1XV3DtNdH4x2G5no
	 06mPZVVoCZ0W34OuMUR0rnrSbNcT30kYTv7egPR4cCgFwjf5YHzJLPVHV1dviymZUE
	 8LTfx4AVGWz96uz4zebT5Hm9yTADkerC/6aItKZ0mOYpeoIN8MpkWau+Fuc07HrCv/
	 pOkLtktr3mC3Q==
Date: Wed, 20 Mar 2024 15:20:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf tests: Run tests in parallel by default
Message-ID: <Zfso6wDszEoCVeEX@x1>
References: <20240301174711.2646944-1-irogers@google.com>
 <CAP-5=fU7PNEDgOg=cFKkSMgHe7_Xbi5Y9k6yPoAwOpN-Uwdp7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU7PNEDgOg=cFKkSMgHe7_Xbi5Y9k6yPoAwOpN-Uwdp7A@mail.gmail.com>

On Wed, Mar 20, 2024 at 08:58:37AM -0700, Ian Rogers wrote:
> On Fri, Mar 1, 2024 at 9:47 AM Ian Rogers <irogers@google.com> wrote:
> >
> > Switch from running tests sequentially to running in parallel by
> > default. Change the opt-in '-p' or '--parallel' flag to '-S' or
> > '--sequential'.
> >
> > On an 8 core tigerlake an address sanitizer run time changes from:
> > 326.54user 622.73system 6:59.91elapsed 226%CPU
> > to:
> > 973.02user 583.98system 3:01.17elapsed 859%CPU
> >
> > So over twice as fast, saving 4 minutes.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.

Thanks, applied.

- Arnaldo

