Return-Path: <linux-kernel+bounces-21024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 280CB8288B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99821F25A14
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6FC39AF3;
	Tue,  9 Jan 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYp2TOqn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5739FCF;
	Tue,  9 Jan 2024 15:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BAEC433C7;
	Tue,  9 Jan 2024 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704812692;
	bh=i17lvu4SeSGI2dL9kHbOmXIe3juU/lh3iDwzaIHk9O8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kYp2TOqnF18890IZSkp60knjE+uIjBAq60mVNf6GFSoQWT51kPu3SKRYy03Cvp0SO
	 4VICobywgYzuaVmu18bdym4Pl1gtC5Pp5ih5nPToyep9Q9rnT3IVhOHLH6RR1CAkcT
	 6LsHfY+BmNuuje/la2SPqCm8Wy8GXaif4OlvLQ1QpZJ19tyuRM+4JZP2P/6kFiJXht
	 78opHLL6sNV779+e1vlw2DU9bAxlzsYDy35crCMpOVUb/zxvl8C+kllgf1F+m4F3JJ
	 f3NzSUTWIusBYeOJnv5Ua6O0nXd50BxCC5bBiTXv+rhePJ3l4xjCxhkJkLXT4UiGuY
	 EK28cG1kNGu3Q==
Date: Wed, 10 Jan 2024 00:04:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 suleiman@google.com, briannorris@google.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/1] PM: sleep: Expose last succeeded resumed
 timestamp in sysfs
Message-Id: <20240110000447.73e6d3e5ad6e75d63ca1bd4b@kernel.org>
In-Reply-To: <170359668692.1864392.6909734045167510522.stgit@mhiramat.roam.corp.google.com>
References: <170359668692.1864392.6909734045167510522.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Rafael,

Could you review this new version?

Thank you,

On Tue, 26 Dec 2023 22:18:07 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 7th version of the patch to expose last succeeded resumed
> timestamp in sysfs as /sys/power/suspend_stats/last_success_resume_time.
> The previous version is here.
> 
> https://lore.kernel.org/all/170245316678.651355.6640896026073025688.stgit@mhiramat.roam.corp.google.com/
> 
> This version fixes code comments, sysfs description and patch
> description.
> 
> On some system like the ChromeOS, the system suspend and resume are
> controlled by a power management process. The user-space tasks will be
> noticed the suspend and the resume signal from it.
> To improve the suspend/resume performance and/or to find regressions,
> we would like to know how long the resume processes are taken in kernel
> and in user-space.
> 
> This patch introduces a last succeeded resumed timestamp (just before
> thawing processes) on sysfs which allows us to find when the kernel
> resume process successfully done in MONOTONIC clock. Thus user processes
> can measure the elapsed time taken by its resume process at any point
> in time.
> 
> This will help us to detect abnormal value (longer time) process in
> the resuming and quickly decide the root cause is in the kernel or
> user-space. The kernel side we can use many tools (e.g. printk or
> ftrace) but for user-space we need to define the starting point of
> the resuming process. Actually, the kernel side needs to use local
> clock because the clock subsystem is also suspended. But in that
> case, user space can not use that timestamp because the local clock
> is not exposed.
> 
> So this will be used something like
> 
> where_the_user_space_resume_finish() {
> 	clock_gettime(CLOCK_MONOTONIC, &etime_ts);
> 	fileread("/sys/.../last_success_resume_time", stime);
> 	convert_timespec(stime, &stime_ts);
> 	user_resume_time = timespec_delta(&etime_ts, &stime_ts);
> 	...
> }
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (1):
>       PM: sleep: Expose last succeeded resumed timestamp in sysfs
> 
> 
>  Documentation/ABI/testing/sysfs-power |   11 +++++++++++
>  include/linux/suspend.h               |    2 ++
>  kernel/power/main.c                   |   15 +++++++++++++++
>  kernel/power/suspend.c                |    9 +++++++++
>  4 files changed, 37 insertions(+)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

