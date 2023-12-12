Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7DD80EDCE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346570AbjLLNjY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 08:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346530AbjLLNjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:39:22 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338E5AF;
        Tue, 12 Dec 2023 05:39:29 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d9db2f1ddfso767875a34.0;
        Tue, 12 Dec 2023 05:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388368; x=1702993168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQMvVmO3VAcrbLQKmWUJkKzG1H3oPWijGjJxXq7r9mI=;
        b=VuG+1jRloJ8cPjxg1LuEzJSYbK9k/yXXbOc0AeS33b4L91ydv6oJ2ZSmJlaGiTIzw1
         Sj6DFF3I/oc4fx2/ujqKdrtbj+D8YMLDsLcj7XnUoutn+/ZkOdVZFBfNOorCs/XA0NiB
         GlagtpK55zBc+RHzr3DKsMwY3kZuBPw0AZmYETREiyDE2WfjGg+tNrF8rml7uIu68FH7
         m0QWOaofi5UFToK26EDSGugfw3TqHNkrAgT+5qQVi36CPOtaP3K7SfRxVbTPRAZI4gKZ
         60K0gjiBCXrnmT8YYMvc+3xT4R0W68xk+eh6bMusMdimFAz3TDSorRcyHi6p16TOx/+0
         r03g==
X-Gm-Message-State: AOJu0YwzEdeIXlpMANEkkVVlFxqf1OCHlAhZTUcGQ7j9JCXUWbAxyKLT
        QDyvGvD/lvKAHKlM2ZZqCrTWAcshFf44sR/R3Ro=
X-Google-Smtp-Source: AGHT+IFV2pnIGekDy1xzSYBDM1Vz6D5VhfIhXjUh1uF61cWXZYdG6L/VvUyAWZPGYbNMlWEI6JXEGXdYB66FjeczORM=
X-Received: by 2002:a05:6820:220d:b0:58d:5302:5b18 with SMTP id
 cj13-20020a056820220d00b0058d53025b18mr12599520oob.1.1702388368434; Tue, 12
 Dec 2023 05:39:28 -0800 (PST)
MIME-Version: 1.0
References: <170108151076.780347.2482745314490930894.stgit@mhiramat.roam.corp.google.com>
 <170108152012.780347.6355289232990337333.stgit@mhiramat.roam.corp.google.com>
In-Reply-To: <170108152012.780347.6355289232990337333.stgit@mhiramat.roam.corp.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 14:39:17 +0100
Message-ID: <CAJZ5v0j8x_hzKg4RHx-xyd6Mye9=xj7MgACcWa7R1PcagFLzwQ@mail.gmail.com>
Subject: Re: [PATCH v5] PM: sleep: Expose last succeeded resumed timestamp in sysfs
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, suleiman@google.com,
        briannorris@google.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:38 AM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu <mhiramat@kernel.org>
>
> Expose last succeeded resumed timestamp as last_success_resume_time
> attribute of suspend_stats in sysfs.
>
> There are some printk()s for printing the similar resume timing to
> dmesg, but those are recorded with local_clock(), and user can not
> compare it with current time. We also have tracing events but it
> requires CAP_SYS_ADMIN to use it.
>
> This suspend_stats attribute is easy to access and only expose the
> timestamp in CLOCK_MONOTONIC.

Why CLOCK_MONOTONIC?

> So user can find the actual resumed
> time and measure the elapsed time from the time when the kernel
> finished the resume to the user-space action (e.g. display the UI).

Can you please say a bit more about why this is useful?

The time stamp is taken at the point when user space has been already
running for some time, so what's the exact benefit of it?

> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
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
>  kernel/power/suspend.c                |    1 +
>  4 files changed, 28 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
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
> +               The /sys/power/suspend_stats/last_success_resume_time file
> +               contains the timestamp of when the kernel successfully
> +               resumed from suspend/hibernate.
> +               This floating point number is measured in seconds by monotonic
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
> @@ -421,6 +421,17 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
>  }
>  static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
>
> +static ssize_t last_success_resume_time_show(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%llu.%llu\n",
> +               (unsigned long long)suspend_stats.last_success_resume_time.tv_sec,
> +               (unsigned long long)suspend_stats.last_success_resume_time.tv_nsec);
> +}
> +
> +static struct kobj_attribute last_success_resume_time =
> +                       __ATTR_RO(last_success_resume_time);
> +
>  static struct attribute *suspend_attrs[] = {
>         &success.attr,
>         &fail.attr,
> @@ -438,6 +449,7 @@ static struct attribute *suspend_attrs[] = {
>         &last_hw_sleep.attr,
>         &total_hw_sleep.attr,
>         &max_hw_sleep.attr,
> +       &last_success_resume_time.attr,
>         NULL,
>  };
>
> @@ -514,6 +526,9 @@ static int suspend_stats_show(struct seq_file *s, void *unused)
>                         suspend_step_name(
>                                 suspend_stats.failed_steps[index]));
>         }
> +       seq_printf(s,   "last_success_resume_time:\t%-llu.%llu\n",
> +                  (unsigned long long)suspend_stats.last_success_resume_time.tv_sec,
> +                  (unsigned long long)suspend_stats.last_success_resume_time.tv_nsec);
>
>         return 0;
>  }
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index fa3bf161d13f..33334565d5a6 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -622,6 +622,7 @@ int pm_suspend(suspend_state_t state)
>                 dpm_save_failed_errno(error);
>         } else {
>                 suspend_stats.success++;
> +               ktime_get_ts64(&suspend_stats.last_success_resume_time);

And so hibernation is not really covered.

>         }
>         pr_info("suspend exit\n");
>         return error;
>
