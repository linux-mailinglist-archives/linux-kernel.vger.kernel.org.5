Return-Path: <linux-kernel+bounces-37829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED8483B629
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F363DB20D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A200ECC;
	Thu, 25 Jan 2024 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJAGw6T9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02F9193;
	Thu, 25 Jan 2024 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706143405; cv=none; b=DpricDiJhvEyySDujxrm4FIwDWOwh4a/GwrdKw23udIdPfaHFzenmm9deQo8zo4x/l1F5g8DM0f76f0QIqlVdH9c95Lr8n7rkBJEJbl2S0MNW4Ixcj5KeMOevrV3Q2u6WtnTGUAlT9Nk9Hwko6AGz8X0tOP8RqHRrKl+JjRbejo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706143405; c=relaxed/simple;
	bh=YJhrz2YlpRjarNzIZIAgKwyto3BYRf6LeDZBXlnVi1Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rZcrxhNRiNo2NJKpEJGXZ78XwwAdzAVPxsJ87Kg4tWmXQrHet6CHfUDtyw+6gssajMk0La9j/8X6zo+/+CtjsHzYoVRkyEVsRIu6LSr4AytEtq7CIuXoYpVArjQLYlsvcQILbOABngXxETVsimdEQ+PY9O174f0560ZqVOMyuk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJAGw6T9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7614C433F1;
	Thu, 25 Jan 2024 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706143405;
	bh=YJhrz2YlpRjarNzIZIAgKwyto3BYRf6LeDZBXlnVi1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZJAGw6T983IlfnB3cj9GYpmNPaSWDuZtHQJNZLxA1qtqCKGbzlYKo+6xKTzQHvTV6
	 X9hTPFD3ix+q9hM3uXFlSL/OX6A7cRTLgU5CosjfaReV4b5X7qtzQmDs2wiptiYu6t
	 5VMw/09ob/JwCcJVgPAhb/r4FJlnJ9vFZFcRTxoq7Dm/HPufTjzSe8yVTAnXKZ4FUX
	 njNCE7lNcchoPnbBpEqe5WanUwJpLYn7HeTj5b7clEyUE25b9wIAodvUQuWieJ/5I0
	 r4z/zgQ8VnaeA5V4EV3mTBIK6uWFtBngWbAyOi3h8aZEoevj15dmgM6HGb8p638oDN
	 QDg5eum/QT4/A==
Date: Thu, 25 Jan 2024 09:43:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
 <len.brown@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 suleiman@google.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7] PM: sleep: Expose last succeeded resumed timestamp
 in sysfs
Message-Id: <20240125094320.13a0844614375deb8bb06db6@kernel.org>
In-Reply-To: <CA+ASDXOwfUrqRDVx_Fi62ERCLRPF+ixD014vE21Sm4mLF_j12A@mail.gmail.com>
References: <170359668692.1864392.6909734045167510522.stgit@mhiramat.roam.corp.google.com>
	<170359669607.1864392.5078004271237566637.stgit@mhiramat.roam.corp.google.com>
	<20240117090706.3522d23763fab9dcea21aee1@kernel.org>
	<CAJZ5v0gqWRsSGQZp7tz-0Kw6od+fjd_iof4Rj7fkBy80ySkcEQ@mail.gmail.com>
	<CA+ASDXOwfUrqRDVx_Fi62ERCLRPF+ixD014vE21Sm4mLF_j12A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 22 Jan 2024 18:08:22 -0800
Brian Norris <briannorris@chromium.org> wrote:

> On Fri, Jan 19, 2024 at 1:08 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Wed, Jan 17, 2024 at 1:07 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > Gently ping,
> > >
> > > I would like to know this is enough or I should add more info/update.
> >
> > I still am not sure what this is going to be useful for.
> >
> > Do you have a specific example?
> 
> Since there seems to be some communication gap here, I'll give it a try.
> 
> First, I'll paste the key phrase of its use case from the cover letter:
> 
>   "we would like to know how long the resume processes are taken in kernel
>   and in user-space"
> 
> This is a "system measurement" question, for use in tests (e.g., in a
> test lab for CI or for pre-release testing, where we suspend
> Chromebooks, wake them back up, and measure how long the wakeup took)
> or for user-reported metrics (e.g., similar statistics from real
> users' systems, if they've agreed to automatically report usage
> statistics, back to Google). We'd like to know how long it takes for a
> system to wake up, so we can detect when there are problems that lead
> to a slow system-resume experience. The user experience includes both
> time spent in the kernel and time spent after user space has thawed
> (and is spending time in potentially complex power and display manager
> stacks) before a Chromebook's display lights back up.

Thanks Brian for explaining, this is correctly explained how we are
using this for measuring resume process duration.

> If I understand the whole of Masami's work correctly, I believe we're
> taking "timestamps parsed out of dmesg" (or potentially out of ftrace,
> trace events, etc.) to measure the kernel side, plus "timestamp
> provided here in CLOCK_MONOTONIC" and "timestamp determined in our
> power/display managers" to measure user space.

Yes, I decided to decouple the kernel and user space because the clock
subsystem is adjusted when resuming. So for the kernel, we will use
local clock (which is not exposed to user space), and use CLOCK_MONOTONIC
for the user space.

> Does that make sense? Or are we still missing something "specific" for
> you? I could give code pointers [1], as it's all open source. But I'm
> not sure browsing our metric-collection code would help understanding
> any more than these explanations.

I hope it helps you understand more about this. If you have further
questions, I will be happy to explain.

> (TBH, this all still seems kinda odd to me, since parsing dmesg isn't
> a great way to get machine-readable information. But this at least
> serves to close some gaps in measurement.)

Yeah, if I can add more in the stat, I would like to add another duration
of the kernel resuming as "last_success_resume_duration". Is that smarter
solution? Or maybe we also can use ftrace for kernel things. But anyway,
to measure the user-space things, in user-space, we need a reference point
of start of resuming.

Thank you,

> 
> Brian
> 
> [1] e.g., https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform2/power_manager/powerd/metrics_collector.cc;l=294;drc=ce8075df179c4f8b2f4e4c4df6978d3df665c4d1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

