Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C95E80EF72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjLLO57 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 09:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjLLO55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:57:57 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1210C3;
        Tue, 12 Dec 2023 06:58:03 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6da09f8ce35so710475a34.0;
        Tue, 12 Dec 2023 06:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702393083; x=1702997883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uI7/niVPwJXrqn+aODJkyH9Zg/KMSJ6EEIEaKjbnNpY=;
        b=otyzK4LO7asNGssByl2eJz5+J44qgQgCNdAd5TrA2L3M/S0fbh600e12HlDcnlbg96
         9uy94ntnzniIb3QZl05FwmsoVGkUJxEDz/GsxdmnvRIPla7moqOLp4VXuZWbN6CdQoxr
         Az41+V9xyI24qV/emrdw7dzlTt7rgick4LS6pDZCi98tSnKv/15SkOE2xp21ZoUYQj06
         +fXdYKyrtSQugGVQ7p4UJymMIQ+vGdcKwjwbseWqirmfwun+L/0VjebFDaldlj4qJu/d
         7ynEClg90t5NeOMj3LDy88v/CLMw6zDPuFpq+LdQTg1Ikrncgiub6CGwKVZywbmgE5X9
         IZpg==
X-Gm-Message-State: AOJu0YwPzQ2jSKrNnylq083/NetHKuvIYgnJ6I2XoRoxh2+6XwjCKfDc
        0ntlgR6aSDJKhKWPjOD0jp0S/pG7ZCIf+mQERGw=
X-Google-Smtp-Source: AGHT+IFX85hOWBf/RrXFpoD9jaXzKOGxn2HXgJByjv/5kq8gOM68c2U1NhKQYr3oCRj/lN3h7WobxtedVxKE9Of+nJU=
X-Received: by 2002:a4a:da02:0:b0:590:8a57:8012 with SMTP id
 e2-20020a4ada02000000b005908a578012mr10635729oou.0.1702393083230; Tue, 12 Dec
 2023 06:58:03 -0800 (PST)
MIME-Version: 1.0
References: <170108151076.780347.2482745314490930894.stgit@mhiramat.roam.corp.google.com>
 <170108152012.780347.6355289232990337333.stgit@mhiramat.roam.corp.google.com>
 <CAJZ5v0j8x_hzKg4RHx-xyd6Mye9=xj7MgACcWa7R1PcagFLzwQ@mail.gmail.com> <20231212233245.14ae64258bdf07ae1d2f2ff9@kernel.org>
In-Reply-To: <20231212233245.14ae64258bdf07ae1d2f2ff9@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 15:57:52 +0100
Message-ID: <CAJZ5v0gObpUYXBydJG-JA5Ew=gScFMEdp6Xu=viv5FT0xyLQQQ@mail.gmail.com>
Subject: Re: [PATCH v5] PM: sleep: Expose last succeeded resumed timestamp in sysfs
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Tue, Dec 12, 2023 at 3:32 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Rafael,
>
> On Tue, 12 Dec 2023 14:39:17 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Mon, Nov 27, 2023 at 11:38 AM Masami Hiramatsu (Google)
> > <mhiramat@kernel.org> wrote:
> > >
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > >
> > > Expose last succeeded resumed timestamp as last_success_resume_time
> > > attribute of suspend_stats in sysfs.
> > >
> > > There are some printk()s for printing the similar resume timing to
> > > dmesg, but those are recorded with local_clock(), and user can not
> > > compare it with current time. We also have tracing events but it
> > > requires CAP_SYS_ADMIN to use it.
> > >
> > > This suspend_stats attribute is easy to access and only expose the
> > > timestamp in CLOCK_MONOTONIC.
> >
> > Why CLOCK_MONOTONIC?
>
> CLOCK_MONOTONIC is the simplest clock which can be used in both user
> space and kernel space. If we use the CLOCK_LOCAL here, user can not
> know the actual time delta from the succeeded resume.

So what does user space need to do to use this value?

> >
> > > So user can find the actual resumed
> > > time and measure the elapsed time from the time when the kernel
> > > finished the resume to the user-space action (e.g. display the UI).
> >
> > Can you please say a bit more about why this is useful?
>
> This is a reference timestamp from the user space to measure their
> processing time for resuming. The kernel side is OK to just trace
> or printk the each component or subsystem internally. But the user
> space needs to know when the kernel resume has been done for measuring
> its component or processes done.

Why does it need to know that?

> Actually this is obscure because the
> end of resuming in userspace is defined by the user-space application
> or desktop systems. But anyway if there is a reference point, user
> process can calculate the delta at any point from that.
>
> >
> > The time stamp is taken at the point when user space has been already
> > running for some time, so what's the exact benefit of it?
>
> Yes, but that timestamp can be scheduled afterwards so it may not
> be so accurate. This can provide the accurate time of the kernel
> resume.

I'm talking about the timestamp added by this patch, that is
/sys/power/suspend_stats/last_success_resume_time.

By the time ktime_get_ts64() in pm_suspend() is called, user space has
already been thawed and is running, so why is this useful?
