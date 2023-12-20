Return-Path: <linux-kernel+bounces-7281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 241FC81A4D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489CA1C259D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981A94AF75;
	Wed, 20 Dec 2023 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSWc2J0f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05AC482D1;
	Wed, 20 Dec 2023 16:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D3EC433C7;
	Wed, 20 Dec 2023 16:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703089191;
	bh=NFnLPjIF3IoK6ZQaApwVUq9VwTB1vbMNJismRladVlU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KSWc2J0fMZSAb9Yh2YgLercKcaoZTqYnKoFJd6/RaBi6YdiiCEKsW4tqHq57TdbFi
	 nxSimYLlVqDzQtYHUYobsAVrSsh8IG+HuCEAvcEM92gro1WD+pA30Byj2NkyTu+rOu
	 Q2o+QSDTnhWNZH51KL+D3Tbj00BikTuiv5m6khxs5g1a05foH09F69fkxYlieXfbu1
	 A9dsmToJ5fsjhbocUeM4x7bBT+OZrWK/boDPmAKyChgrVROk9abe6qvyZC1/e+uEdh
	 F3HAAlSvFGo0ugtih6TbOXlEgef13ZGKVTsge7Q7H6CgnwFSz7ccizcgiatGY/qjw/
	 ERh/hscNYGv5Q==
Date: Thu, 21 Dec 2023 01:19:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Randy
 Dunlap <rdunlap@infradead.org>, suleiman@google.com,
 briannorris@google.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v6] PM: sleep: Expose last succeeded resumed timestamp
 in sysfs
Message-Id: <20231221011947.88fddb3324d6aa1ab63dffb6@kernel.org>
In-Reply-To: <CAJZ5v0j1eD9soyh2JmqfphvwVBApKD_ikFOr3+XYvS4f_0cboA@mail.gmail.com>
References: <170245316678.651355.6640896026073025688.stgit@mhiramat.roam.corp.google.com>
	<170245317569.651355.7858730719579399805.stgit@mhiramat.roam.corp.google.com>
	<CAJZ5v0j1eD9soyh2JmqfphvwVBApKD_ikFOr3+XYvS4f_0cboA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On Tue, 19 Dec 2023 21:32:06 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Dec 13, 2023 at 8:39 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> >
> > Expose last succeeded resumed timestamp as last_success_resume_time
> > attribute of suspend_stats in sysfs so that user can use this time
> > stamp as a reference point of resuming user space.
> >
> > There are some printk()s for printing the similar resume timing to
> > dmesg, but those are recorded with local_clock(), and user can not
> > compare it with current time.
> 
> You'd need to explain why.

OK, I'll add it.

> 
> > We also have tracing events but it requires CAP_SYS_ADMIN to use it.
> >
> > This suspend_stats attribute is easy to access and only expose the
> > timestamp in CLOCK_MONOTONIC. User can find the actual resumed
> > time and measure the elapsed time from the time when the kernel
> > finished the resume
> 
> So now it is the time when the kernel has started thawing tasks.

Yes, so update the description.

> 
> > to the user-space action (e.g. display the UI)
> > and use it as a performance metric of user process resuming time.
> 
> The whole "user process resuming time" idea is highly questionable,
> because it assumes that the user space task has been notified of the
> system suspend somehow and so it knows that it will be resuming
> subsequently.
> 
> I'm wondering what exactly is going on?

I'm improving ChromeOS system resume performance. As you assumed, the
user space tasks have been notified the suspend and the resume from
the power manager daemon. We already have a metrics about kernel resume
time, but no user space resume time. If we have a metrics about user-
space resuming, we can identify which part caused a resume delay if
any delay happens.

For that purpose, the key parts is this timestamp when the kernel
actually finished the resuming, because user application (power
manager and chrome etc.) can get the timestamp when any event happens
in the user space, but it can not know the kernel event timestamp
counted by the same clock easily.

> 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v6:
> >   - Fix to record resume time before thawing user processes.
> >  Changes in v5:
> >   - Just updated for v6.7-rc3.
> >  Changes in v4.1:
> >   - Fix document typo (again).
> >  Changes in v4:
> >   - Update description to add why.
> >   - Fix document typo.
> >  Changes in v3:
> >   - Add (unsigned long long) casting for %llu.
> >   - Add a line after last_success_resume_time_show().
> >  Changes in v2:
> >   - Use %llu instead of %lu for printing u64 value.
> >   - Remove unneeded indent spaces from the last_success_resume_time
> >     line in the debugfs suspend_stat file.
> > ---
> >  Documentation/ABI/testing/sysfs-power |   10 ++++++++++
> >  include/linux/suspend.h               |    2 ++
> >  kernel/power/main.c                   |   15 +++++++++++++++
> >  kernel/power/suspend.c                |    3 +++
> >  4 files changed, 30 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> > index a3942b1036e2..e14975859766 100644
> > --- a/Documentation/ABI/testing/sysfs-power
> > +++ b/Documentation/ABI/testing/sysfs-power
> > @@ -442,6 +442,16 @@ Description:
> >                 'total_hw_sleep' and 'last_hw_sleep' may not be accurate.
> >                 This number is measured in microseconds.
> >
> > +What:          /sys/power/suspend_stats/last_success_resume_time
> > +Date:          Oct 2023
> > +Contact:       Masami Hiramatsu <mhiramat@kernel.org>
> > +Description:
> > +               The /sys/power/suspend_stats/last_success_resume_time file
> > +               contains the timestamp of when the kernel successfully
> > +               resumed from suspend/hibernate.
> 
> It needs to say what exactly the time is.

OK.

> 
> > +               This floating point number is measured in seconds by monotonic
> > +               clock.
> > +
> >  What:          /sys/power/sync_on_suspend
> >  Date:          October 2019
> >  Contact:       Jonas Meurer <jonas@freesources.org>
> > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > index ef503088942d..ddd789044960 100644
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -8,6 +8,7 @@
> >  #include <linux/pm.h>
> >  #include <linux/mm.h>
> >  #include <linux/freezer.h>
> > +#include <linux/timekeeping.h>
> >  #include <asm/errno.h>
> >
> >  #ifdef CONFIG_VT
> > @@ -71,6 +72,7 @@ struct suspend_stats {
> >         u64     last_hw_sleep;
> >         u64     total_hw_sleep;
> >         u64     max_hw_sleep;
> > +       struct timespec64 last_success_resume_time;
> >         enum suspend_stat_step  failed_steps[REC_FAILED_NUM];
> >  };
> >
> > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > index f6425ae3e8b0..2ab23fd3daac 100644
> > --- a/kernel/power/main.c
> > +++ b/kernel/power/main.c
> > @@ -421,6 +421,17 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
> >  }
> >  static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
> >
> > +static ssize_t last_success_resume_time_show(struct kobject *kobj,
> > +               struct kobj_attribute *attr, char *buf)
> > +{
> > +       return sprintf(buf, "%llu.%llu\n",
> > +               (unsigned long long)suspend_stats.last_success_resume_time.tv_sec,
> > +               (unsigned long long)suspend_stats.last_success_resume_time.tv_nsec);
> > +}
> > +
> > +static struct kobj_attribute last_success_resume_time =
> > +                       __ATTR_RO(last_success_resume_time);
> > +
> >  static struct attribute *suspend_attrs[] = {
> >         &success.attr,
> >         &fail.attr,
> > @@ -438,6 +449,7 @@ static struct attribute *suspend_attrs[] = {
> >         &last_hw_sleep.attr,
> >         &total_hw_sleep.attr,
> >         &max_hw_sleep.attr,
> > +       &last_success_resume_time.attr,
> >         NULL,
> >  };
> >
> > @@ -514,6 +526,9 @@ static int suspend_stats_show(struct seq_file *s, void *unused)
> >                         suspend_step_name(
> >                                 suspend_stats.failed_steps[index]));
> >         }
> > +       seq_printf(s,   "last_success_resume_time:\t%-llu.%llu\n",
> > +                  (unsigned long long)suspend_stats.last_success_resume_time.tv_sec,
> > +                  (unsigned long long)suspend_stats.last_success_resume_time.tv_nsec);
> >
> >         return 0;
> >  }
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index fa3bf161d13f..b85889358f53 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -595,6 +595,9 @@ static int enter_state(suspend_state_t state)
> >   Finish:
> >         events_check_enabled = false;
> >         pm_pr_dbg("Finishing wakeup.\n");
> > +       /* Record last succeeded resume time before thawing processes. */
> 
> IMV the comment should explain why this particular time is recorded or
> it is not very useful otherwise.

Agreed.

> 
> > +       if (!error)
> > +               ktime_get_ts64(&suspend_stats.last_success_resume_time);
> 
> A blank line here, please.

OK.

Thank you,

> 
> >         suspend_finish();
> >   Unlock:
> >         mutex_unlock(&system_transition_mutex);
> >
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

