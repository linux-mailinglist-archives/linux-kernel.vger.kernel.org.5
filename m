Return-Path: <linux-kernel+bounces-125747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B75892B98
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5481CB21682
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 14:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13181381AD;
	Sat, 30 Mar 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rl28LvWu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B811C0DEF;
	Sat, 30 Mar 2024 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711810105; cv=none; b=KWU9xytssS3Dk4R4oX9zXo21nAd9kubNc/rvtqRnAT9szDah70tCLi9OxJfUZi5hjfGxneRqAO3I5VJ8e24eO4oGdoUk4yxp6MSoynBQJafcsj0BMrp/pNDzRmVxkmKR+4LDgPMf3PJm+ghB5YrT9oJokAedrAVLis9ENmMxrhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711810105; c=relaxed/simple;
	bh=Wpkl9TtAeYU9lc9iPFm/MeqQLMnA8ufIvAGWRAEVtaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP/EPUNBW8xVNKlwkOhmmE8v25DskoPmwKPT8ju9MfKV5vmY5ccldjOaO0Sml+e3BCqqz2UJjqRQCTN8tU4rM6zQcquYpQ98TZ9GIm4B4tTRfjldJiYRPikSnh+q5ps9brjJTTjNZ0xsoaibDc+CVs2w/4QOJq2w3t5O1I/bOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rl28LvWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA508C433F1;
	Sat, 30 Mar 2024 14:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711810105;
	bh=Wpkl9TtAeYU9lc9iPFm/MeqQLMnA8ufIvAGWRAEVtaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rl28LvWuFUbDMNMTs3jM2vEcteIEkTJvj5Fok1q2nGshSmLpeLtvBgyoXWQFJp3E8
	 Oaa+vGpQ+70PxJXQTSmaEp2eRGA95J5/emnQqBdwpX41fB12NQTXwqt/2yPpx7U1l8
	 umVnvpN3RyRoNMmPKxq9zanAzsQxBU+NX0VElsD02Y2qyK5DtDv077RkRosRspUIL6
	 BY9I7Qh6LK7xg89hWPjMPax6Q774xv45MjElmJrIAnkJSJBuZ/saV/uC/G1okbTa4k
	 K/n+GPG9qT6p9XV/c/kIOsCLK4fydvf/HCVgp68ws0MHMikwPPW1g/9/DWoOaWmKJ/
	 +J5qMNnOUHqhg==
Date: Sat, 30 Mar 2024 11:48:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Yang Jihong <yangjihong@bytedance.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	james.clark@arm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH 1/2] perf sched timehist: Fix
 -g/--call-graph option failure
Message-ID: <ZggmNWYjBtid_hCZ@x1>
References: <20240328055857.383180-1-yangjihong@bytedance.com>
 <CAP-5=fXms1noWT8PXqBu89QogcwVsvAGpxq3Q_bNUYOYL7PpKA@mail.gmail.com>
 <2e44ae50-d4af-4788-9274-aaf345bac066@bytedance.com>
 <CAP-5=fWDY9Aj+qHNOuwJ9yE==G=vmCzECXYEZAifOhGHX7yr6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWDY9Aj+qHNOuwJ9yE==G=vmCzECXYEZAifOhGHX7yr6w@mail.gmail.com>

On Fri, Mar 29, 2024 at 09:08:01AM -0700, Ian Rogers wrote:
> On Thu, Mar 28, 2024 at 8:02 PM Yang Jihong <yangjihong@bytedance.com> wrote:
> >
> > Hello,
> >
> > Sorry, due to the new email settings, the last reply email was in html
> > format, resend it now.
> >
> > On 3/29/24 00:02, Ian Rogers wrote:
> > > On Wed, Mar 27, 2024 at 10:59 PM Yang Jihong <yangjihong@bytedance.com> wrote:
> > >>
> > >> When perf-sched enables the call-graph recording, sample_type of dummy
> > >> event does not have PERF_SAMPLE_CALLCHAIN, timehist_check_attr() checks
> > >> that the evsel does not have a callchain, and set show_callchain to 0.
> > >>
> > >> Currently perf sched timehist only saves callchain when processing
> > >> sched:sched_switch event, timehist_check_attr() only needs to determine
> > >> whether the event has PERF_SAMPLE_CALLCHAIN.
> > >>
> > >> Before:
> > >>    # perf sched record -g true
> > >>    [ perf record: Woken up 0 times to write data ]
> > >>    [ perf record: Captured and wrote 4.153 MB perf.data (7536 samples) ]
> > >>    # perf sched timehist
> > >>    Samples do not have callchains.
> > >>               time    cpu  task name                       wait time  sch delay   run time
> > >>                            [tid/pid]                          (msec)     (msec)     (msec)
> > >>    --------------- ------  ------------------------------  ---------  ---------  ---------
> > >>      147851.826019 [0000]  perf[285035]                        0.000      0.000      0.000
> > >>      147851.826029 [0000]  migration/0[15]                     0.000      0.003      0.009
> > >>      147851.826063 [0001]  perf[285035]                        0.000      0.000      0.000
> > >>      147851.826069 [0001]  migration/1[21]                     0.000      0.003      0.006
> > >>    <SNIP>
> > >>
> > >> After:
> > >>    # perf sched record -g true
> > >>    [ perf record: Woken up 1 times to write data ]
> > >>    [ perf record: Captured and wrote 2.572 MB perf.data (822 samples) ]
> > >>    # perf sched timehist
> > >>               time    cpu  task name                       wait time  sch delay   run time
> > >>                            [tid/pid]                          (msec)     (msec)     (msec)
> > >>    --------------- ------  ------------------------------  ---------  ---------  ---------
> > >>      144193.035164 [0000]  perf[277062]                        0.000      0.000      0.000    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- preempt_schedule_common <- __cond_resched <- __wait_for_common <- wait_for_completion
> > >>      144193.035174 [0000]  migration/0[15]                     0.000      0.003      0.009    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- smpboot_thread_fn <- kthread <- ret_from_fork
> > >>      144193.035207 [0001]  perf[277062]                        0.000      0.000      0.000    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- preempt_schedule_common <- __cond_resched <- __wait_for_common <- wait_for_completion
> > >>      144193.035214 [0001]  migration/1[21]                     0.000      0.003      0.007    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- smpboot_thread_fn <- kthread <- ret_from_fork
> > >> <SNIP>
> > >
> > > This looks good, should there be a Fixes tag for the sake of backports?
> > >
> > The direct cause is commit 9c95e4ef0657 ("perf evlist: Add
> > evlist__findnew_tracking_event() helper"). perf-record uses
> > evlist__add_aux_dummy() to replace evlist__add_dummy() to add a dummy
> > event. The difference is that evlist__add_aux_dummy() sets
> > no_aux_samples to true (this is expected behavior, for dummy event, no
> > need to sample aux data), resulting in evsel__config() not adding the
> > PERF_SAMPLE_CALLCHAIN bit to dummy's sample_type.
> >
> > In summary, the direct cause is the problem introduced by commit
> > 9c95e4ef0657 ("perf evlist: Add evlist__findnew_tracking_event()
> > helper"), but the root cause is the timehist_check_attr() logic problem,
> > The dummy event itself does not need to have PERF_SAMPLE_CALLCHAIN, so
> > there is no need to check it.
> >
> >
> > So, maybe add fixes-tag:
> >
> > Fixes: 9c95e4ef0657 ("perf evlist: Add evlist__findnew_tracking_event()
> > helper")
> >
> > If it is ok, I will send v2 version with this fixes-tag.
> 
> I think the maintainer can add the fixes tag when they add the reviewed-by tag:

I usually do this, but if the submitter does it I'll have just to check
that it is the right tag, helps a bit in processing.

- Arnaldo
 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 
> > Thanks,
> > Yang

