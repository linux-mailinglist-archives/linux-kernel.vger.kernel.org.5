Return-Path: <linux-kernel+bounces-41371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7225183EFBD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07501C21055
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1952E62D;
	Sat, 27 Jan 2024 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plMVjyja"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C12D610;
	Sat, 27 Jan 2024 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706383838; cv=none; b=LSYObZ2izMnzx3zE5Jn1JIrPJXtXR1j+LUxu9OVrkMJLGWQGscCVe445QXw8UVm8xbiiLbmjMY/ggs0RRIS8jjrMbXQ9lRigOHl8hjlBeCUlH3bjTMB9WPX/7PHcha4gqk0l66Z7a0dShjTyAx7q0WDi05QhQscVeSEXAU2/ibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706383838; c=relaxed/simple;
	bh=80ymeHrsW5HH2OWf8Lr/T2iAX4+IhNBKg4APIwfV+Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8+o3xsFjv9gRK+LLxQcZuWoqilSe9CKFMUVnHU3SzQ9lXsfqZYKbJiHcb8WBrHnm07tJFG3p7KxnelUk4bcLp0e/RoNGMZ4l1k3VtRezoKUU4JPjvUqRBotZKTcTxElTfp+aWJ+4nXKDmatAWmX0Sqk6buVTlp5uVj9zBGNypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plMVjyja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5067C433C7;
	Sat, 27 Jan 2024 19:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706383838;
	bh=80ymeHrsW5HH2OWf8Lr/T2iAX4+IhNBKg4APIwfV+Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=plMVjyja2hI0UNua4E75oIuAWmcdL5d7p8AR+KbPOT1Acgq2tfrlpYiSbgAl/26cm
	 XG5Gl0d/KjKBdrQHKgY/IInpeD6LG56BEFwnH4zW65rabCiGRjSgjJKivcH5YK2B9s
	 Lw6Z7hEcBRRKKynFZmsO4aVSs7JnzG3kVMEzNkAwQrt6siYENiKPMlMzJf464VhErZ
	 ZJgoDxG4BCfgAYFB5zviIyQYJm2p3Hw2UBWH79NsXwm22rqAZXhPRWQScYAcgBCudt
	 47qTGXAN0Je7P264LCiWyZKmLpYGfYbYMpQo7zkIebq7cTOZar5JZ6F23BPrpzzFpX
	 q32IvSuDIVjxw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 4CB2240441; Sat, 27 Jan 2024 16:30:35 -0300 (-03)
Date: Sat, 27 Jan 2024 16:30:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Edward Baker <edward.baker@intel.com>
Subject: Re: [PATCH v1] perf vendor events intel: Alderlake/sapphirerapids
 metric fixes
Message-ID: <ZbVZ2yeWTRKNS-1R@kernel.org>
References: <20240104231903.775717-1-irogers@google.com>
 <8c060937-0351-4c4f-afb3-aa6e5aa1e685@linux.intel.com>
 <CAP-5=fXpkMP0yphYLAUFNwHjBZvapzkop41LGnKDc1QAOoi7qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXpkMP0yphYLAUFNwHjBZvapzkop41LGnKDc1QAOoi7qg@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Fri, Jan 26, 2024 at 05:46:33PM -0800, Ian Rogers escreveu:
> On Fri, Jan 5, 2024 at 11:22 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >
> >
> >
> > On 2024-01-04 6:19 p.m., Ian Rogers wrote:
> > > As events are deduplicated by name, ensure PMU prefixes are always
> > > used in metrics. Previously they may be missed on the first event in a
> > > formula.
> > >
> > > Update metric constraints for architectures with topdown l2 events.
> > >
> > > Conversion script updated in:
> > > https://github.com/intel/perfmon/pull/128
> > >
> > > Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Closes: https://lore.kernel.org/lkml/ZZam-EG-UepcXtWw@kernel.org/
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Thanks Ian.
> >
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> >
> > Thanks,
> > Kan
> 
> Ping.

Applied and it fixes the problem I just reported (perf test 103),
thanks!

- Arnaldo

