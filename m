Return-Path: <linux-kernel+bounces-101702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A41E87AAC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4BA1C21171
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEA0481A5;
	Wed, 13 Mar 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ext14AfK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E588446BF;
	Wed, 13 Mar 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345316; cv=none; b=cqyKS2a7S4E4q56qf6i+WQ7q+Xx2tWH/tasGu0AZMrEpMqoc4wnVajFkfQ3jDPGhw20xb0TUJg3GTHJ1ORNxs7GZjg0JCKqauHBDYLkp8KJt1hQ/9fgtMa4DLr/mda/KjUY2evT+Km1TcGk2nxSOIHMHgcp/bQKRMVMYASt3w+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345316; c=relaxed/simple;
	bh=Nwk/w5uGh1hbn5empdNZ/Fn5j6qCvuoI6jaUjQjaVdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2pjlxWzMg1LReeKpSuEYPH2hx11L49YtoXjo6gCsM3MgFoO8wYCklWfLAPcJ1mCh4wHDUjrNY3OGPsvtt7b2si5xZpi8KwOgZxZD7Z9czK8l+8Qb0g34TcLULi/ZGzsTdZbPz7LfcknopHpOj6C3DKXcrh24vDE5Mn9QUIK1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ext14AfK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710345314; x=1741881314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nwk/w5uGh1hbn5empdNZ/Fn5j6qCvuoI6jaUjQjaVdo=;
  b=Ext14AfK+dEHyIw0h0cZzdAe3KryXf/7djPF0IpGVEDqsrXMPfay2/b6
   bwhripTpX0b+l71fD66KP8rNfTTU+B1W0j+xR+/Rh+lh2LZ46nfrvZIJ/
   BqI8+LQRy1GImFzbU1a29ALrq4AwLRrqLrGlugv82Nfo5CcHlNXOf5sWo
   nXEz/va8itukB3XYY8ecnC1lnR/09owOToFw1x2lWFg8oUN3YQLzb+u/K
   ZIYwC3611lWxSFYN1BTnxuI5zoxC72AmxjybOIQeoctN59e/ze6kTlJ1D
   7SRojxvzElbfFEUErUhp94R3hIdccpiqb1TrVETOaflBKmZSm/LsMYhw1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4987932"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="4987932"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 08:55:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16562454"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 08:55:13 -0700
Date: Wed, 13 Mar 2024 08:55:12 -0700
From: Andi Kleen <ak@linux.intel.com>
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v4 2/6] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Message-ID: <ZfHMYM3iWlsODtjP@tassilo>
References: <20240312234921.812685-1-weilin.wang@intel.com>
 <20240312234921.812685-3-weilin.wang@intel.com>
 <87le6nm20o.fsf@linux.intel.com>
 <CO6PR11MB56356A213DBE53535E9D802BEE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <87edcflzkr.fsf@linux.intel.com>
 <CO6PR11MB56351D1706A9C46D80982AECEE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO6PR11MB56351D1706A9C46D80982AECEE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>

On Wed, Mar 13, 2024 at 03:31:14PM +0000, Wang, Weilin wrote:
> 
> 
> > -----Original Message-----
> > From: Andi Kleen <ak@linux.intel.com>
> > Sent: Tuesday, March 12, 2024 5:56 PM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>; Ian Rogers
> > <irogers@google.com>; Arnaldo Carvalho de Melo <acme@kernel.org>; Peter
> > Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>;
> > Alexander Shishkin <alexander.shishkin@linux.intel.com>; Jiri Olsa
> > <jolsa@kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; Kan Liang
> > <kan.liang@linux.intel.com>; linux-perf-users@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Taylor, Perry <perry.taylor@intel.com>; Alt, Samantha
> > <samantha.alt@intel.com>; Biggers, Caleb <caleb.biggers@intel.com>
> > Subject: Re: [RFC PATCH v4 2/6] perf stat: Fork and launch perf record when
> > perf stat needs to get retire latency value for a metric.
> > 
> > "Wang, Weilin" <weilin.wang@intel.com> writes:
> > 
> > >> -----Original Message-----
> > >> From: Andi Kleen <ak@linux.intel.com>
> > >> Sent: Tuesday, March 12, 2024 5:03 PM
> > >> To: Wang, Weilin <weilin.wang@intel.com>
> > >> Cc: Namhyung Kim <namhyung@kernel.org>; Ian Rogers
> > >> <irogers@google.com>; Arnaldo Carvalho de Melo <acme@kernel.org>;
> > Peter
> > >> Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>;
> > >> Alexander Shishkin <alexander.shishkin@linux.intel.com>; Jiri Olsa
> > >> <jolsa@kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; Kan Liang
> > >> <kan.liang@linux.intel.com>; linux-perf-users@vger.kernel.org; linux-
> > >> kernel@vger.kernel.org; Taylor, Perry <perry.taylor@intel.com>; Alt,
> > Samantha
> > >> <samantha.alt@intel.com>; Biggers, Caleb <caleb.biggers@intel.com>
> > >> Subject: Re: [RFC PATCH v4 2/6] perf stat: Fork and launch perf record
> > when
> > >> perf stat needs to get retire latency value for a metric.
> > >>
> > >> weilin.wang@intel.com writes:
> > >>
> > >> > From: Weilin Wang <weilin.wang@intel.com>
> > >> >
> > >> > When retire_latency value is used in a metric formula, perf stat would fork
> > a
> > >> > perf record process with "-e" and "-W" options. Perf record will collect
> > >> > required retire_latency values in parallel while perf stat is collecting
> > >> > counting values.
> > >>
> > >> How does that work when the workload is specified on the command line?
> > >> The workload would run twice? That is very inefficient and may not
> > >> work if it's a large workload.
> > >>
> > >> The perf tool infrastructure is imho not up to the task of such
> > >> parallel collection.
> > >>
> > >> Also it won't work for very long collections because you will get a
> > >> very large perf.data. Better to use a pipeline.
> > >>
> > >> I think it would be better if you made it a separate operation that can
> > >> generate a file that is then consumed by perf stat. This is also more efficient
> > >> because often the calibration is only needed once. And it's all under
> > >> user control so no nasty surprises.
> > >>
> > >
> > > Workload runs only once with perf stat. Perf record is forked by perf stat and
> > run
> > > in parallel with perf stat. Perf stat will send perf record a signal to terminate
> > after
> > > perf stat stops collecting count value.
> > 
> > I don't understand how the perf record filters on the workload created by
> > the perf stat. At a minimum you would need -p to connect to the pid
> > of the parent, but IIRC -p doesnt follow children, so if it forked
> > it wouldn't work.
> > 
> > I think your approach may only work with -a, but perhaps I'm missing
> > something (-a is often not usable due to restrictions)
> > 
> > Also if perf stat runs in interval mode and you only get the data
> > at the end how would that work?
> > 
> > iirc i wrestled with all these questions for toplev (which has a
> > similar feature) and in the end i concluded doing it automatically
> > has far too many problems.
> > 
> 
> Yes, you are completely right that there are limitation that we can only support -a, -C 
> and not support on -I now. I'm wondering if we could support "-I" in next step by 
> processing sampled data on the go.

-I is very tricky in a separate process. How do you align the two
intervals on a long runs without drift. I don't know of a reliable
way to do it in the general case only using time.

Also just the non support for forking workloads without -a is fatal imho. That's 
likely one of the most common cases.

Separate is a far better model imho:

- It is under full user control and no surprises
- No uncontrolled multiplexing
- Often it is fine to measure once and cache the data

It cannot deal with -I properly either (short of some form of
phase detection), but at least it doesn't give false promises
to that effect.

The way to do it is to have defaults in a json file
and the user can override them with a calibration step.
There is a JSON format that is used by some other tools.

This is my implementation:
https://github.com/andikleen/pmu-tools/blob/master/genretlat.py
https://github.com/andikleen/pmu-tools/blob/89861055b53e57ba0b7c6348745b2fbe6615c068/toplev.py#L1031


-Andi


