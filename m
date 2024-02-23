Return-Path: <linux-kernel+bounces-78937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97D0861B01
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0638E289A71
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F46142648;
	Fri, 23 Feb 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5FYjqyC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C612AAD7;
	Fri, 23 Feb 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711174; cv=none; b=rDBjKP+W5iQfL91RotT3zu23AGUvKPf9v02+25imnTZCxxXnXnkA2lgNIi8rdBZevddEXxuMP0uU5DPNzVGla+1bfXO4Mju0MJ/vaYZHxF/9qqTOX6k6g/bxuGMQQ3zm0eC8Sm+H+91ZowvxcDO4AH+PFmD8e4HwiME7ZTUV9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711174; c=relaxed/simple;
	bh=gTzPvov1pysXpbl26Na1x4ZDLy1bbNoAUuYg5g+g3FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6+R5bKMfPA0OPP7NwMLDNLpjG1d5tbxu0zSvByXoxpECzO1DzEqE3cNbINrGtqgODA9I/FQLt8OvTXOXqvsEKQiPK8ezDsgeYbjWw5AWWAg+vA7Sy35Xt2/VqQzc7kOu/JPaNQTUawhrXylZF2L++fAVJnqevi+6rOKkzGa/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5FYjqyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0D7C433F1;
	Fri, 23 Feb 2024 17:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708711173;
	bh=gTzPvov1pysXpbl26Na1x4ZDLy1bbNoAUuYg5g+g3FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5FYjqyCTQVqnb/2O35S6LdSKdQ4lCjDyuMfRmmKmXwo32Z8lBPAgLGJulNOiVvLn
	 cKPT5ZXr88aAwmPvkE6ZzgEEB3Hi7cnRFF/azwL3KPcOpvw4VpDZzyo3quRFaYE9oU
	 Jj5SdxpJxfHlbgDqss+f5aP7kkKWGhshHg3/0lnDOTq5vRPuKDmkpGChdFVlAQW7Px
	 QczJPnwsDq9L4MdWG9uhvdEqA1Q8mbWVvZjC5utB1+acfhy8SejCLOIThqZ+FnBRDn
	 fY/cxXpClZCSVjFhre9vstTJMrmA9HgYbOBmpm89YPc0YegmJQt3R4oU4Cjt2UMkwu
	 v1PZkTR2ubOvQ==
Date: Fri, 23 Feb 2024 14:59:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kyle Huey <me@kylehuey.com>
Cc: Ian Rogers <irogers@google.com>, Kyle Huey <khuey@kylehuey.com>,
	Robert O'Callahan <robert@ocallahan.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf test: Test FASYNC with watermark wakeups.
Message-ID: <ZdjdAKIV39A-jpR5@x1>
References: <20240221175210.19936-1-khuey@kylehuey.com>
 <20240221175210.19936-2-khuey@kylehuey.com>
 <CAP-5=fXsv7TJ_SVOZc38fN0gn+7cWBcMWt3FdVLcs5v0_vO=uw@mail.gmail.com>
 <CAP045AoSHWoOP3TN=6Hf2wZj7X9Y41sThBQWCDZ3BEP68qeTBw@mail.gmail.com>
 <ZdemibZepMqWvv6U@x1>
 <CAP045Aqc6woHGYKJG4d=x4gPd0=PmrLeFv25Rkts1a8xFuocOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP045Aqc6woHGYKJG4d=x4gPd0=PmrLeFv25Rkts1a8xFuocOQ@mail.gmail.com>

On Fri, Feb 23, 2024 at 09:35:29AM -0800, Kyle Huey wrote:
> On Thu, Feb 22, 2024 at 11:54 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >         fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
> >         if (fd < 0) {
> >                 if (attr_has_sigtrap()) {
> >                         pr_debug("FAILED sys_perf_event_open(): %s\n",
> >                                  str_error_r(errno, sbuf, sizeof(sbuf)));
> >                 } else {
> >                         pr_debug("perf_event_attr doesn't have sigtrap\n");
> >                         ret = TEST_SKIP;
> >                 }
> >                 goto out_restore_sigaction;
 
> I think perhaps I'm barking up the wrong tree here. This seems like a
> ton of work just to write a regression test. Maybe I should be doing
> this in tools/testing/selftests instead?

Well, if it tests a perf feature, then yeah, that would be better placed
in 'perf test'.

Maybe you can just assume this will run just on modern kernels where
this feature is expected to be present and then add some pr_debug()
stating that maybe this feature is not present in the kernel.

For the vast majority of cases this will be enough, so that is what I
encourage you to do now.

Its possible that distros, like Red Hat, end up backporting first the
perf tools with this test and not the feature it is being tested, if
that happens, then it will eventually come to my attention and I will be
able to do the BTF treatment, as in that case even a test based on the
kernel version would be insufficient.

- Arnaldo

