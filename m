Return-Path: <linux-kernel+bounces-106712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2472B87F250
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F8C1F24F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E8C58ACA;
	Mon, 18 Mar 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs8yPxag"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54658ADF;
	Mon, 18 Mar 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797860; cv=none; b=V+64OyJDJ8K9lB+kUd99TgqqILiDp4JI6QSeUOty1mQiYZSGxDS9zvzuIsnLI9JSCtSJ8X96PmFCvwwDVSBH/kXQk5c+pi9dVRSAcUCIhU7XcBQvfayt9GERRHNnx8stdJ2SYtRdu/DuYHHoUeEWzw3kXie3xWzV8012FtYxxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797860; c=relaxed/simple;
	bh=ddA5fr3D5LmbfEYfDAkP0jwL8eKv8+2KFsAx6wyNvQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu76xsVpm8wuGIYi5rHqIMxJFcHqHJvSaR+UNC5WmJ2YU0+cg1XLDW/EjDlkyl9pQKdjTvxadNavDD2eIaYp8l9oHBFbeUMfD44e+2mbLdqyugTBjHGDjcQ8MVeAkc7/ll8LhaYuHPu+R4ale9B0CoGrOX4dph4GiIFfaugcrs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs8yPxag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B04C433F1;
	Mon, 18 Mar 2024 21:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710797859;
	bh=ddA5fr3D5LmbfEYfDAkP0jwL8eKv8+2KFsAx6wyNvQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cs8yPxagbUznXrCb64F/T27JfTQMj54nlRvrLev9KpPCam/DieIiDfaAV8E1NZ4xb
	 r7MxltpqySX7uui9zxGNjoF51X+MWbi8PysU2iS9gdiNW4o/wC93bGbvhZN5blFRUg
	 sg5LjDjCpbSBphBwqBad1IMb64Ao7kRu+JDLIuoMoAbZ6R91SnZ2yYC+8gGdk4Bbgp
	 K47zmAGnDZNkTMoYcogW3pEAJpJoEGlsYNNuaRqYBqG4b7qUcThYwKrQsD0/9fOwI8
	 YDdhYW60V7hqPBC1sx5p5qLybADkGtLK0RBcLFXb5JEMvqcqa4k7gEiNxVP5tL2uzX
	 WAyqzWLB8OaCQ==
Date: Mon, 18 Mar 2024 18:37:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Changbin Du <changbin.du@huawei.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Paran Lee <p4ranlee@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org, Leo Yan <leo.yan@linux.dev>
Subject: Re: [PATCH v3 0/8] Clean up libperf cpumap's empty function
Message-ID: <Zfi0IJV-OKwyDK0r@x1>
References: <20240202234057.2085863-1-irogers@google.com>
 <CAP-5=fVjAHqAHHLqE=3v2bP6S6k98psiuZds7TUTFCT7RgMFdQ@mail.gmail.com>
 <CAM9d7ciPYMd4zckrcgnPtradZ_bvaNOHji1tkkYQu_TTF5=eYw@mail.gmail.com>
 <CAM9d7cgbxHZoaq4ZLCda-6TW5A+b+-8dSrRApk+AjcTVNC5hNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgbxHZoaq4ZLCda-6TW5A+b+-8dSrRApk+AjcTVNC5hNA@mail.gmail.com>

On Thu, Mar 07, 2024 at 03:47:00PM -0800, Namhyung Kim wrote:
> Hi Ian,
> 
> Sorry for the late reply.
> 
> On Fri, Feb 16, 2024 at 5:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Feb 14, 2024 at 2:03 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Fri, Feb 2, 2024 at 3:41 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > Rename and clean up the use of libperf CPU map functions particularly
> > > > focussing on perf_cpu_map__empty that may return true for maps
> > > > containing CPUs but also with an "any CPU"/dummy value.
> > > >
> > > > perf_cpu_map__nr is also troubling in that iterating an empty CPU map
> > > > will yield the "any CPU"/dummy value. Reduce the appearance of some
> > > > calls to this by using the perf_cpu_map__for_each_cpu macro.
> > > >
> > > > v3: Address handling of "any" is arm-spe/cs-etm patch.
> > > > v2: 6 patches were merged by Arnaldo. New patch added ensure empty
> > > >     maps are allocated as NULL (suggested by James Clark). Hopefully a
> > > >     fix to "perf arm-spe/cs-etm: Directly iterate CPU maps".
> > > >
> > > > Ian Rogers (8):
> > > >   libperf cpumap: Add any, empty and min helpers
> > > >   libperf cpumap: Ensure empty cpumap is NULL from alloc
> > > >   perf arm-spe/cs-etm: Directly iterate CPU maps
> > > >   perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is_empty
> > > >     use
> > > >   perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_empty
> > > >   perf arm64 header: Remove unnecessary CPU map get and put
> > > >   perf stat: Remove duplicate cpus_map_matched function
> > > >   perf cpumap: Use perf_cpu_map__for_each_cpu when possible
> > >
> > > Ping. Thanks,
> > > Ian

> > Adrian and James, are you ok with this now?

> I think James is fine now and the Intel-pt part seems straight-forward
> so I'd like to merge this change.  Please tell me if you have any concerns.

Namhyung,

	I noticed this hasn't been merged and applies cleanly, so I'm
adding it to perf-tools-next, from your comment above can I take it as
an Acked-by or even Reviewed-by?

- Arnaldo

