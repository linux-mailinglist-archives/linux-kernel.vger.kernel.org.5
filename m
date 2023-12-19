Return-Path: <linux-kernel+bounces-5919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D50819184
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C981F275F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA712FE08;
	Tue, 19 Dec 2023 20:32:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C11F3B189;
	Tue, 19 Dec 2023 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5909156aea9so824263eaf.0;
        Tue, 19 Dec 2023 12:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703017937; x=1703622737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rz5E3fjvqMyLiddSP1uy19E5YF0I/DE0BxWP+hMc2sY=;
        b=Srs7JWmRR6w4JVHEzSM/ON8hMG5CuVWPuaU6f5WMUVyWBeexb0R+ctE3e+vZmrB7J+
         ugI1xkeuzi65qA4JEJHfYm4RmQLQ91mDU8kzetDEz5E3nXV6orWIfxRwX9QLWdR6Qkv5
         Hd/PHhvHhoFDRspJOU1EuAmpVKqG+UrdN4r4mGYaaNl7suANUfHwnPGkUjLV4p7iCabO
         Y2o5pGTOMDUtd4cwpj9GHSJtxW7hoIr2FkuREJjX0IkmVDjmKZU1VwmXRcjkjp3SJAy1
         kQr5L8GxDrAbhxMXRZk0zK5s60sG+zXqGiHZPLVEx1uxjTvfBYVwSDTEHttP6Z2ddQTr
         tz8A==
X-Gm-Message-State: AOJu0YzquOFZQxk8ePQLm8PvNOSKRyJhH/U88CWLCkvwaAOk3c56DLeS
	DlugQIs/VGEs22glnHrPm/kX3ALJq/LKjCYb98Q=
X-Google-Smtp-Source: AGHT+IFrvP3cd4l9qiGv8wHmvWjEFk33NEFWy3dIkDhtiPiXQFYL1qUAv1fkOpeyH7+Sf1CUIrnD+1hfXn0GhEHxN/c=
X-Received: by 2002:a05:6820:2484:b0:591:4861:6b02 with SMTP id
 cq4-20020a056820248400b0059148616b02mr21185640oob.1.1703017937385; Tue, 19
 Dec 2023 12:32:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170245316678.651355.6640896026073025688.stgit@mhiramat.roam.corp.google.com>
 <170245317569.651355.7858730719579399805.stgit@mhiramat.roam.corp.google.com>
In-Reply-To: <170245317569.651355.7858730719579399805.stgit@mhiramat.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Dec 2023 21:32:06 +0100
Message-ID: <CAJZ5v0j1eD9soyh2JmqfphvwVBApKD_ikFOr3+XYvS4f_0cboA@mail.gmail.com>
Subject: Re: [PATCH v6] PM: sleep: Expose last succeeded resumed timestamp in sysfs
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Randy Dunlap <rdunlap@infradead.org>, suleiman@google.com, briannorris@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 8:39=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu <mhiramat@kernel.org>
>
> Expose last succeeded resumed timestamp as last_success_resume_time
> attribute of suspend_stats in sysfs so that user can use this time
> stamp as a reference point of resuming user space.
>
> There are some printk()s for printing the similar resume timing to
> dmesg, but those are recorded with local_clock(), and user can not
> compare it with current time.

You'd need to explain why.

> We also have tracing events but it requires CAP_SYS_ADMIN to use it.
>
> This suspend_stats attribute is easy to access and only expose the
> timestamp in CLOCK_MONOTONIC. User can find the actual resumed
> time and measure the elapsed time from the time when the kernel
> finished the resume

So now it is the time when the kernel has started thawing tasks.

> to the user-space action (e.g. display the UI)
> and use it as a performance metric of user process resuming time.

The whole "user process resuming time" idea is highly questionable,
because it assumes that the user space task has been notified of the
system suspend somehow and so it knows that it will be resuming
subsequently.

I'm wondering what exactly is going on?

> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v6:
>   - Fix to record resume time before thawing user processes.
>  Changes in v5:
>   - Just updated for v6.7-rc3.
>  Changes in v4.1:
>   - Fix document typo (again).
>  Changes in v4:
>   - Update description to add why.
>   - Fix document typo.
>  Changes in v3:
>   - Add (unsigned long long) casting for %llu.
>   - Add a line after last_success_resume_time_show().
>  Changes in v2:
>   - Use %llu instead of %lu for printing u64 value.
>   - Remove unneeded indent spaces from the last_success_resume_time
>     line in the debugfs suspend_stat file.
> ---
>  Documentation/ABI/testing/sysfs-power |   10 ++++++++++
>  include/linux/suspend.h               |    2 ++
>  kernel/power/main.c                   |   15 +++++++++++++++
>  kernel/power/suspend.c                |    3 +++
>  4 files changed, 30 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/te=
sting/sysfs-power
> index a3942b1036e2..e14975859766 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -442,6 +442,16 @@ Description:
>                 'total_hw_sleep' and 'last_hw_sleep' may not be accurate.
>                 This number is measured in microseconds.
>
> +What:          /sys/power/suspend_stats/last_success_resume_time
> +Date:          Oct 2023
> +Contact:       Masami Hiramatsu <mhiramat@kernel.org>
> +Description:
> +               The /sys/power/suspend_stats/last_success_resume_time fil=
e
> +               contains the timestamp of when the kernel successfully
> +               resumed from suspend/hibernate.

It needs to say what exactly the time is.

> +               This floating point number is measured in seconds by mono=
tonic
> +               clock.
> +
>  What:          /sys/power/sync_on_suspend
>  Date:          October 2019
>  Contact:       Jonas Meurer <jonas@freesources.org>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index ef503088942d..ddd789044960 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -8,6 +8,7 @@
>  #include <linux/pm.h>
>  #include <linux/mm.h>
>  #include <linux/freezer.h>
> +#include <linux/timekeeping.h>
>  #include <asm/errno.h>
>
>  #ifdef CONFIG_VT
> @@ -71,6 +72,7 @@ struct suspend_stats {
>         u64     last_hw_sleep;
>         u64     total_hw_sleep;
>         u64     max_hw_sleep;
> +       struct timespec64 last_success_resume_time;
>         enum suspend_stat_step  failed_steps[REC_FAILED_NUM];
>  };
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index f6425ae3e8b0..2ab23fd3daac 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -421,6 +421,17 @@ static ssize_t last_failed_step_show(struct kobject =
*kobj,
>  }
>  static struct kobj_attribute last_failed_step =3D __ATTR_RO(last_failed_=
step);
>
> +static ssize_t last_success_resume_time_show(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%llu.%llu\n",
> +               (unsigned long long)suspend_stats.last_success_resume_tim=
e.tv_sec,
> +               (unsigned long long)suspend_stats.last_success_resume_tim=
e.tv_nsec);
> +}
> +
> +static struct kobj_attribute last_success_resume_time =3D
> +                       __ATTR_RO(last_success_resume_time);
> +
>  static struct attribute *suspend_attrs[] =3D {
>         &success.attr,
>         &fail.attr,
> @@ -438,6 +449,7 @@ static struct attribute *suspend_attrs[] =3D {
>         &last_hw_sleep.attr,
>         &total_hw_sleep.attr,
>         &max_hw_sleep.attr,
> +       &last_success_resume_time.attr,
>         NULL,
>  };
>
> @@ -514,6 +526,9 @@ static int suspend_stats_show(struct seq_file *s, voi=
d *unused)
>                         suspend_step_name(
>                                 suspend_stats.failed_steps[index]));
>         }
> +       seq_printf(s,   "last_success_resume_time:\t%-llu.%llu\n",
> +                  (unsigned long long)suspend_stats.last_success_resume_=
time.tv_sec,
> +                  (unsigned long long)suspend_stats.last_success_resume_=
time.tv_nsec);
>
>         return 0;
>  }
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index fa3bf161d13f..b85889358f53 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -595,6 +595,9 @@ static int enter_state(suspend_state_t state)
>   Finish:
>         events_check_enabled =3D false;
>         pm_pr_dbg("Finishing wakeup.\n");
> +       /* Record last succeeded resume time before thawing processes. */

IMV the comment should explain why this particular time is recorded or
it is not very useful otherwise.

> +       if (!error)
> +               ktime_get_ts64(&suspend_stats.last_success_resume_time);

A blank line here, please.

>         suspend_finish();
>   Unlock:
>         mutex_unlock(&system_transition_mutex);
>
>

