Return-Path: <linux-kernel+bounces-104880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1248A87D4F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1768DB21D43
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46174548F9;
	Fri, 15 Mar 2024 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq0deBeA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8341F19A;
	Fri, 15 Mar 2024 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710534596; cv=none; b=oULsIlxdg48O9ospyLICTOn2edZghUHo0rq/h/EJ1+QDpuCYemCGKx1/7rbBbYyD+4MpyZLvjxyypCtSDP9/0EttP9Et4kuic3Grfxb0EdiinIWIssbqputM5oJPb3MJyzICEqd6AnFBPUvvXGW7vHl0w0smz3AiNHyKHMecSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710534596; c=relaxed/simple;
	bh=HyJ1lV5/KtaAjYSgsjIpgBj1ohgVn3CGns1XQk7p5bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnB7tywPh1jIiekdU09uyyxImKTl5bf5QzePKbctNWv4PnbzQ2zK7YgZGcUUh2MdHPVrPQnLUJ0wvS0MXlWT+HmxWGFkPmmf4yZ3ZMTvMxdOYms+08XDN3hBSZNmCiHiPZqwxqIVSKZj9Q5xsUdsuCdIQ89rtc1QTz0cSAagknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq0deBeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC81C433F1;
	Fri, 15 Mar 2024 20:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710534596;
	bh=HyJ1lV5/KtaAjYSgsjIpgBj1ohgVn3CGns1XQk7p5bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yq0deBeAtd2GuEZq6bTGafM6o0GWNjtBQg/hQSR1AnN3t2LzOi9SJibaWpQi0agtI
	 XRZ+KuzvH4h+1WwDG0cyzrzHZA4fChVaPVPv/9uZdVWLQ+Ex91liNGEcpVuYJFnx7Z
	 65wSKa/eerCi6J1wEwPmIQiuaWmK2B0J3XyrM4JRymVTpewDLEKO2FecEo8h9iazQP
	 kBXBD5vPrsqFP3lSv4xOFEvmmQaAIgwAmas7/HJ5+ZLBeBBshEDbIyAYNpeHng0m1s
	 kxiqpQAqzPjPmkoXUfQ5GHVdmV2eeHqIfoW6PU8BdGMbe4QGY2LdXlrLOLy0IwipBG
	 3c7k/gbdYNARg==
Date: Fri, 15 Mar 2024 17:29:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf vendor events intel: Add umasks to PCU events.
Message-ID: <ZfSvwBQRBhfWGb98@x1>
References: <20240226201517.3540187-1-irogers@google.com>
 <0b2ff06f-099c-424a-97b5-fdf638892e41@linux.intel.com>
 <CAP-5=fVTOgOO=N7uf4CaANWu+WCCLXXMuNBnDdBOP3E6vijG_A@mail.gmail.com>
 <2b950564-fe20-4426-ac91-5b40a2087099@linux.intel.com>
 <CAP-5=fURvd4nx_-QLgRBWSoJbXDUqO=WbsLkqMgjiyucXHVrjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fURvd4nx_-QLgRBWSoJbXDUqO=WbsLkqMgjiyucXHVrjw@mail.gmail.com>

On Wed, Feb 28, 2024 at 08:12:10AM -0800, Ian Rogers wrote:
> On Wed, Feb 28, 2024 at 6:55 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > On 2024-02-27 9:12 p.m., Ian Rogers wrote:
> > > Kan, what's the right way to deal with this?
> >
> > There is no umask in the uncore spec. Please see P120 of the spec.
> > https://www.intel.com/content/www/us/en/develop/download/intel-xeon-processor-e5-2600-v2-product-family-uncore-performance-monitoring-reference.html
> >
> > It should be occ_sel.
> > The occ_sel = (the umask from the event list >> 6) & 0x3.
> >
> > I don't think we want to change either the kernel or the perf tool.
> > There is nothing to help either if we add the occ_sel in the original
> > event list. So it seems the only choice should be handling it in the
> > convertor tool.
> >
> > Is it possible to check the UNC_P_POWER_STATE_OCCUPANCY.CORES_C0 in IVT
> > and use "Filter": "occ_sel=0x1" to replace "UMask": "0x40"?
> >
> > It seems everything in the filter will directly be appended. Is my
> > understanding correct?
> 
> Yep. From the manual:
> C0 = 1
> C3 = 2
> C6= 3
> So I'll need to fix all 3 events during the conversion to perf json.
> The same problem exists for haswell and broadwell, so I'll do the fix
> on those architectures too. I was able to test on a jaketown but the
> kernel source makes me think the same fix is necessary there too. I'll
> send out a new patch with this.

Please clarify if this remains reviewed and should be merged as-is.

- Arnaldo


