Return-Path: <linux-kernel+bounces-109030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6728813AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E102D283A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8B74AEC2;
	Wed, 20 Mar 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeG2+rZf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAE447F6A;
	Wed, 20 Mar 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946199; cv=none; b=QBnuuq/ee86YtG13nrqrFo+AXv4E8TlkaMbG+rPIHEJN4AmB3rWCSapROkCh5frsnJmPxkbm+Qmdt77JiRdnvKsdUmpn20nn5V3ZqW30fUlBoGaBGuLfsXThNaXieFwWT9kJhknn3D8wXUmijVuePGyI4sdOc3nmuCqQPnSbvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946199; c=relaxed/simple;
	bh=G0BQvQe3h5OzdSrH8qTN0I1MWrHBWh89p4W0eSgt05g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxMp8itL7UWVXMXE5IeVzKsYu+7HqE4hRKSocbI1xPtVhaPPKbilM/DUiUAjN6e7jBryeZC9o1uPWqhwOxSXq3OhRIaYAIPQVM4Sy3VzJzfSJq4egtgMqHkDgx5CZiAnBBKgZgdUv6zYUdBgQ0R/23zhrKvXbdGdugjoR+n6TyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeG2+rZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C67C433F1;
	Wed, 20 Mar 2024 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710946198;
	bh=G0BQvQe3h5OzdSrH8qTN0I1MWrHBWh89p4W0eSgt05g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NeG2+rZfwbCuOUPnN/X/okwbf8NPK2JkmGOnzFn8vCOCmIOfhGTyJeTQzZOXQM5Us
	 57mbOrvVO31RfJwlRD9fF3SaoVFs6Ai+vR/Fc+D/P57rT2EmOm1ajrPBSjkiR4oNQk
	 X4bpDfnyyu0RUd8qTK03y2CuIG3txVlglE31EFISmSbuqbHYYylWIc8NxHnaPKhsXI
	 ZHInvzbFdkQUey36X1TtGNTM5G7w/NHcjiUqgz9ZrNMKqDdWj+Auo3p2Z/Z2o0eLQ/
	 aAHVoOp1CFNUfBWKkST9Mm+RqzGVmtZhypei0mEIZ1ngDZES24koRwzMxCL8TYA6K2
	 U7zA/jh61XqAQ==
Date: Wed, 20 Mar 2024 11:49:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Disha Goel <disgoel@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Song Liu <songliubraving@fb.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1 1/4] perf record: Delete session after stopping
 sideband thread
Message-ID: <Zfr3kxwkpVbuwR8O@x1>
References: <20240301074639.2260708-1-irogers@google.com>
 <CAP-5=fX7JDkyPEXwJGmhYf75EA5KsFQpZ3tC-70hNe8kUnZ=rw@mail.gmail.com>
 <CAP-5=fW_B-HOU0moGXjesjNaz2FR8emSB1LsadXOh5O71CrWWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW_B-HOU0moGXjesjNaz2FR8emSB1LsadXOh5O71CrWWQ@mail.gmail.com>

On Tue, Mar 19, 2024 at 09:42:26PM -0700, Ian Rogers wrote:
> On Thu, Feb 29, 2024 at 11:50 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Feb 29, 2024 at 11:47 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > The session has a header in it which contains a perf env with
> > > bpf_progs. The bpf_progs are accessed by the sideband thread and so
> > > the sideband thread must be stopped before the session is deleted, to
> > > avoid a use after free.  This error was detected by AddressSanitizer
> > > in the following:
> > >
> > > ```
> > > ==2054673==ERROR: AddressSanitizer: heap-use-after-free on address 0x61d000161e00 at pc 0x55769289de54 bp 0x7f9df36d4ab0 sp 0x7f9df36d4aa8
> > > READ of size 8 at 0x61d000161e00 thread T1
> > >     #0 0x55769289de53 in __perf_env__insert_bpf_prog_info util/env.c:42
> > >     #1 0x55769289dbb1 in perf_env__insert_bpf_prog_info util/env.c:29
> > >     #2 0x557692bbae29 in perf_env__add_bpf_info util/bpf-event.c:483
> > >     #3 0x557692bbb01a in bpf_event__sb_cb util/bpf-event.c:512
> > >     #4 0x5576928b75f4 in perf_evlist__poll_thread util/sideband_evlist.c:68
> > >     #5 0x7f9df96a63eb in start_thread nptl/pthread_create.c:444
> > >     #6 0x7f9df9726a4b in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> > >
> > > 0x61d000161e00 is located 384 bytes inside of 2136-byte region [0x61d000161c80,0x61d0001624d8)
> > > freed by thread T0 here:
> > >     #0 0x7f9dfa6d7288 in __interceptor_free libsanitizer/asan/asan_malloc_linux.cpp:52
> > >     #1 0x557692978d50 in perf_session__delete util/session.c:319
> > >     #2 0x557692673959 in __cmd_record tools/perf/builtin-record.c:2884
> > >     #3 0x55769267a9f0 in cmd_record tools/perf/builtin-record.c:4259
> > >     #4 0x55769286710c in run_builtin tools/perf/perf.c:349
> > >     #5 0x557692867678 in handle_internal_command tools/perf/perf.c:402
> > >     #6 0x557692867a40 in run_argv tools/perf/perf.c:446
> > >     #7 0x557692867fae in main tools/perf/perf.c:562
> > >     #8 0x7f9df96456c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
> > > ```
> > >
> > > Fixes: 657ee5531903 ("perf evlist: Introduce side band thread")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Note, after this series I'm seeing parallel perf testing being as
> > reliable as serial but parallel testing is nearly 3 times faster. I
> > think after these changes land we can make parallel execution the
> > default.
> 
> Ping.

Thanks, applied to perf-tools-next,

- Arnaldo

