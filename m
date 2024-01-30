Return-Path: <linux-kernel+bounces-44769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E5B842728
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2CE2870C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB8B7CF3B;
	Tue, 30 Jan 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohmsW/G3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3610F4EE;
	Tue, 30 Jan 2024 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626322; cv=none; b=qiWHgk//iB0rGQHd8u5fBvygsba2jO7e96/YCxHAD3STzZd249qGi5gWbxZOnXeNgEQSX+XLY/A8AhfNbVsHiKSUbxCatN7nej2r5+IfmYUbrSpDxvzv38CS9pOPjJQuhNatqY7hja5oh7ufMajbJrgZME5K7DxGB82DnjVkSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626322; c=relaxed/simple;
	bh=9d6ufwDAIf1A0UtOyTYk+Jf/Hs9vxaFZOyONWOgloa4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JMaCuTuS7tTpwNg+H4vbTVU/KZKADgEuedi7Ygl65t5vW9/QCA0p+puUmoeLjcaErHnHM+7u37dgk/W3aqwTGlNkMG+eljWz1pCjqpskcZPrqtIpuauBeSQQpID3cbqc2DMZdeAS73aChR1VwWCp5CrioDl48XpwLLdCzQhv2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohmsW/G3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F70C43390;
	Tue, 30 Jan 2024 14:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706626322;
	bh=9d6ufwDAIf1A0UtOyTYk+Jf/Hs9vxaFZOyONWOgloa4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ohmsW/G3JEHix0NoZqa8v5nmuoIoh507YfeX6swBcMOh4uOg8VP0o4S75Sz9TDrxM
	 wwg/A7Bp3fZq2NhoeYjVpAmgbzRP22iiUg8eb74yk5C+xJNtsCco+dqyIQBR+G8yzs
	 YC0V5n2YZrBGqDvjzVV6fHw1vRDAJtCzk8dAZBxQIzvoT3pVbznwtE8TxLWfCA/DW8
	 BP2MKHECPidFfPjKJzYQvsQ1VfeywPDkyIvVBQ8mzGjIuEoKnIksltk38Jc4L+OCVR
	 zeYYP/0m66lzg+QaGo5ctiPKbY5tfZgOtUQexXfiSA4YLlj5tpWM4emI33dLFmIYnw
	 uQ26W30blw44w==
Date: Tue, 30 Jan 2024 23:51:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 suleiman@google.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7] PM: sleep: Expose last succeeded resumed timestamp
 in sysfs
Message-Id: <20240130235157.636ee1183e073cfba8d7d0b7@kernel.org>
In-Reply-To: <CAJZ5v0jLLTETrMpXE3h=Q9GyhDEcZH5f7v+yvyxhzhW8yQKyTQ@mail.gmail.com>
References: <170359668692.1864392.6909734045167510522.stgit@mhiramat.roam.corp.google.com>
	<170359669607.1864392.5078004271237566637.stgit@mhiramat.roam.corp.google.com>
	<20240117090706.3522d23763fab9dcea21aee1@kernel.org>
	<CAJZ5v0gqWRsSGQZp7tz-0Kw6od+fjd_iof4Rj7fkBy80ySkcEQ@mail.gmail.com>
	<CA+ASDXOwfUrqRDVx_Fi62ERCLRPF+ixD014vE21Sm4mLF_j12A@mail.gmail.com>
	<20240125094320.13a0844614375deb8bb06db6@kernel.org>
	<CAJZ5v0jLLTETrMpXE3h=Q9GyhDEcZH5f7v+yvyxhzhW8yQKyTQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rafael,

Thanks for the comment!

On Thu, 25 Jan 2024 21:19:07 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Thu, Jan 25, 2024 at 1:43 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Mon, 22 Jan 2024 18:08:22 -0800
> > Brian Norris <briannorris@chromium.org> wrote:
> >
> > > On Fri, Jan 19, 2024 at 1:08 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > On Wed, Jan 17, 2024 at 1:07 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > >
> > > > > Gently ping,
> > > > >
> > > > > I would like to know this is enough or I should add more info/update.
> > > >
> > > > I still am not sure what this is going to be useful for.
> > > >
> > > > Do you have a specific example?
> > >
> > > Since there seems to be some communication gap here, I'll give it a try.
> > >
> > > First, I'll paste the key phrase of its use case from the cover letter:
> > >
> > >   "we would like to know how long the resume processes are taken in kernel
> > >   and in user-space"
> > >
> > > This is a "system measurement" question, for use in tests (e.g., in a
> > > test lab for CI or for pre-release testing, where we suspend
> > > Chromebooks, wake them back up, and measure how long the wakeup took)
> > > or for user-reported metrics (e.g., similar statistics from real
> > > users' systems, if they've agreed to automatically report usage
> > > statistics, back to Google). We'd like to know how long it takes for a
> > > system to wake up, so we can detect when there are problems that lead
> > > to a slow system-resume experience. The user experience includes both
> > > time spent in the kernel and time spent after user space has thawed
> > > (and is spending time in potentially complex power and display manager
> > > stacks) before a Chromebook's display lights back up.
> >
> > Thanks Brian for explaining, this is correctly explained how we are
> > using this for measuring resume process duration.
> >
> > > If I understand the whole of Masami's work correctly, I believe we're
> > > taking "timestamps parsed out of dmesg" (or potentially out of ftrace,
> > > trace events, etc.) to measure the kernel side, plus "timestamp
> > > provided here in CLOCK_MONOTONIC" and "timestamp determined in our
> > > power/display managers" to measure user space.
> >
> > Yes, I decided to decouple the kernel and user space because the clock
> > subsystem is adjusted when resuming. So for the kernel, we will use
> > local clock (which is not exposed to user space), and use CLOCK_MONOTONIC
> > for the user space.
> 
> The problem with this split is that you cannot know how much time
> elapses between the "successful kernel resume time" and the time when
> user space gets to resume.

Hm, let me check why.

> 
> As of this patch, the kernel timestamp is taken when the kernel is
> about to thaw user space and some user space tasks may start running
> right away.

Yes. But note that this just indicates the time when the "kernel"
done the resuming process.

> 
> Some other tasks, however, will wait for what happens next in the
> kernel (because it is not done with resuming yet) and some of them
> will wait until explicitly asked to resume by the resume process IIUC.

Yeah, those will be just restarted and may wait for a signal to e.g.
re-draw, re-load etc. I think those are a part of user-space resuming.

> 
> Your results depend on which tasks participate in the "user
> experience", so to speak.  If they are the tasks that wait to be
> kicked by the resume process, the kernel timestamp taken as per the

"kicked by the resume process" means thawing the tasks??

> above is useless for them, because there is quite some stuff that
> happens in the kernel before they will get kicked.

So your point might be, even after the timestamp, some kernel resume
process will affect? Since the system(kernel+user) resuming state is
continuously changing in parallel, it is hard to split the kernel
and user resume process?

> 
> Moreover, some tasks will wait for certain device drivers to get ready
> after the rest of the system resumes and that may still take some more
> time after the kernel has returned to the process driving the system
> suspend-resume.

Oh, I thought driver resume will be done in the kernel before thawing.
Of course some wifi/bt etc. will need to be re-connect again. And
I don't care at this moment.

> 
> I'm not sure if there is a single point which can be used as a "user
> space resume start" time for every task, which is why I'm not
> convinced about this patch.

Ah, OK. Yeah, that is a good point. I also think that is not useful
for every cases, but we need some reference timestamp when we start
resuming. And I think this is a better point to do. Of course if we
observe some delay, we still need more comprehensive tracing not only
application log, but this is the first step and I think the step we
can not avoid (because we don't expose the local clock to user space)

> 
> BTW, there is a utility called sleepgraph that measures the kernel
> part of the system suspend-resume.  It does its best to measure it
> very precisely and uses different techniques for that.  Also, it is
> included in the kernel source tree.  Can you please have a look at it
> and see how much there is in common between it and your tools?  Maybe
> there are some interfaces that can be used in common, or maybe it
> could benefit from some interfaces that you are planning to add.

Thanks for the info!  Yeah we also have some tracing tools (perfetto,
trace-cmd etc.) for analysis. Note that this timestamp will kick those
analysis tools if we find any delay based on the timestamp. I mean this
will be used for "monitoring" the trend but not for precise "analysis".

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

