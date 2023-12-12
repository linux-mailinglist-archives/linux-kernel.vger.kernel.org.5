Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50A780FA5E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377785AbjLLWTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377775AbjLLWTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:19:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBCDD2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:19:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E254C433C9;
        Tue, 12 Dec 2023 22:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702419549;
        bh=DIQcaPKuaymhD7B2Ud9Fhf3u0xd2DS9jqqZCj0jIqJU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H/kDWIJ/MGPcXG58F38GqOruqiolfunk087bx8xzx9mNA/BNlFg4KI+5ldrxsGVQK
         z3D+Hj2NM1rrahKwTnw1hBpbDwNd7dEbuLbA0wjcImx/XoOtHdI3N14llKgKm/uS+p
         xHfL/CHEPVspOmxqMhIddyD0nrvlDw+tKwNEfGaNTXamRg1YwIwqs9qgwp4qQlBONH
         opWnYumzBfReu/Q2Er9atvwSWPw6eXyIz4cOQ0l9YqNiGWz/vd2UqAvbnGEdSAECu1
         Y3Ie7RSdOKtgj25Knq2wvUR6UfEHh7MKBhm/tudZh+fbkcncPXpUtY48s88pc0NxD2
         C5bu8mzHtpk/w==
Date:   Wed, 13 Dec 2023 07:19:04 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, suleiman@google.com,
        briannorris@google.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5] PM: sleep: Expose last succeeded resumed timestamp
 in sysfs
Message-Id: <20231213071904.c466432fcf085b71d6bd97da@kernel.org>
In-Reply-To: <CAJZ5v0gObpUYXBydJG-JA5Ew=gScFMEdp6Xu=viv5FT0xyLQQQ@mail.gmail.com>
References: <170108151076.780347.2482745314490930894.stgit@mhiramat.roam.corp.google.com>
        <170108152012.780347.6355289232990337333.stgit@mhiramat.roam.corp.google.com>
        <CAJZ5v0j8x_hzKg4RHx-xyd6Mye9=xj7MgACcWa7R1PcagFLzwQ@mail.gmail.com>
        <20231212233245.14ae64258bdf07ae1d2f2ff9@kernel.org>
        <CAJZ5v0gObpUYXBydJG-JA5Ew=gScFMEdp6Xu=viv5FT0xyLQQQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 15:57:52 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Dec 12, 2023 at 3:32 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Rafael,
> >
> > On Tue, 12 Dec 2023 14:39:17 +0100
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > > On Mon, Nov 27, 2023 at 11:38 AM Masami Hiramatsu (Google)
> > > <mhiramat@kernel.org> wrote:
> > > >
> > > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > >
> > > > Expose last succeeded resumed timestamp as last_success_resume_time
> > > > attribute of suspend_stats in sysfs.
> > > >
> > > > There are some printk()s for printing the similar resume timing to
> > > > dmesg, but those are recorded with local_clock(), and user can not
> > > > compare it with current time. We also have tracing events but it
> > > > requires CAP_SYS_ADMIN to use it.
> > > >
> > > > This suspend_stats attribute is easy to access and only expose the
> > > > timestamp in CLOCK_MONOTONIC.
> > >
> > > Why CLOCK_MONOTONIC?
> >
> > CLOCK_MONOTONIC is the simplest clock which can be used in both user
> > space and kernel space. If we use the CLOCK_LOCAL here, user can not
> > know the actual time delta from the succeeded resume.
> 
> So what does user space need to do to use this value?

This will be used to measure the delay of the user-space resuming as a
metric of system health.

> > >
> > > > So user can find the actual resumed
> > > > time and measure the elapsed time from the time when the kernel
> > > > finished the resume to the user-space action (e.g. display the UI).
> > >
> > > Can you please say a bit more about why this is useful?
> >
> > This is a reference timestamp from the user space to measure their
> > processing time for resuming. The kernel side is OK to just trace
> > or printk the each component or subsystem internally. But the user
> > space needs to know when the kernel resume has been done for measuring
> > its component or processes done.
> 
> Why does it need to know that?

For the metrics, the kernel side resume time and user-side resume time are
important to know if any update caused regressions and separate the issue.

> 
> > Actually this is obscure because the
> > end of resuming in userspace is defined by the user-space application
> > or desktop systems. But anyway if there is a reference point, user
> > process can calculate the delta at any point from that.
> >
> > >
> > > The time stamp is taken at the point when user space has been already
> > > running for some time, so what's the exact benefit of it?
> >
> > Yes, but that timestamp can be scheduled afterwards so it may not
> > be so accurate. This can provide the accurate time of the kernel
> > resume.
> 
> I'm talking about the timestamp added by this patch, that is
> /sys/power/suspend_stats/last_success_resume_time.
> 
> By the time ktime_get_ts64() in pm_suspend() is called, user space has
> already been thawed and is running, so why is this useful?

Aaah, good catch! It should be right before thawing process, right?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
