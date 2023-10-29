Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673457DAC9A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjJ2N26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2N24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:28:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2438CC1;
        Sun, 29 Oct 2023 06:28:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1757C433C7;
        Sun, 29 Oct 2023 13:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698586133;
        bh=HHba25T9VztARaJU/UjlQBuEQ+GeLE7wN3ts9+h9slA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J5ifICcU0IZCpXfoCjmcKe+D1febVcVQD2bkY8aShIwKcL6LOpkUB/QSpdU0TNiBK
         5sPUxV8bBaa21b/EFfv4DvR8qqGwhUY4VOiyV8QYfFxhjHmGAgdeTFrQVh1FTBiH5y
         wI855t6EsX4BLa+YNrV7gIhIq/745BO4GPQNc1L5acT/IaMCqLydQ54sAxC8g9qWiA
         vbvM/1XgZJZJ6MkQt1em9HLyBHchRSTUtG6ODZERvvaE0oVEjPBXcZZArPiZZHJJ71
         vtzjdMeNcKvdZ/N0z5OTfw4CFetGPCn2qZJQAC+WaOD772VcYIx+hfpn4b+QomQNCt
         LBy3S3CzbcYwQ==
Date:   Sun, 29 Oct 2023 22:28:49 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        suleiman@google.com, briannorris@google.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] PM: sleep: Expose last succeeded resumed timestamp
 in sysfs
Message-Id: <20231029222849.768feb0bbc3a2e37db2bb2c6@kernel.org>
In-Reply-To: <2e507e97-8ac6-43a2-a290-e0e80af0d044@infradead.org>
References: <169849758243.1357961.4105003693126485611.stgit@mhiramat.roam.corp.google.com>
        <d6f016fe-963b-40ba-9146-de69e4fe0052@infradead.org>
        <20231029115449.8c942b131312c2464eda6970@kernel.org>
        <2e507e97-8ac6-43a2-a290-e0e80af0d044@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 29 Oct 2023 05:16:49 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi.
> 
> On 10/28/23 19:54, Masami Hiramatsu (Google) wrote:
> > On Sat, 28 Oct 2023 09:48:36 -0700
> > Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> >> Hi,
> >>
> >> On 10/28/23 05:53, Masami Hiramatsu (Google) wrote:
> >>> From: Masami Hiramatsu <mhiramat@kernel.org>
> >>>
> >>> Expose last succeeded resumed timestamp as last_success_resume_time
> >>> attribute of suspend_stats in sysfs. This timestamp is recorded in
> >>> CLOCK_MONOTONIC. So user can find the actual resumed time and
> >>> measure the elapsed time from the time when the kernel finished
> >>> the resume to the user-space action (e.g. display the UI).
> >>
> >> Can you go into the use-case a bit more, please?
> >> You have said "what", but not "why".
> >> What do you (or google) plan to do with this?
> 
> and what about this part of my questions? ^^^^^^^^^

Oh, sorry I missed it.
I would like to know the actual (accurate) elapsed time from
the succeeded kernel resume time to displaying UI so that we can
identify the user visible (noticable) resume delay happens in the
kernel or the user resume process.

The kernel side will be recorded on the dmesg if we use PRINTK_TIME,
but the PRINTK_TIME is recorded by local_clock(), we can not know
the actual time in the user space. I also considered to expose
current local_clock() by introducing CLOCK_LOCAL, but that may be
more user-space intrusive change, so I chose this way.

Thank you,

> 
> 
> >>
> >>>
> >>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >>> ---
> >>>  Changes in v3:
> >>>   - Add (unsigned long long) casting for %llu.
> >>>   - Add a line after last_success_resume_time_show().
> >>>  Changes in v2:
> >>>   - Use %llu instead of %lu for printing u64 value.
> >>>   - Remove unneeded indent spaces from the last_success_resume_time
> >>>     line in the debugfs suspend_stat file.
> >>> ---
> >>>  Documentation/ABI/testing/sysfs-power |   10 ++++++++++
> >>>  include/linux/suspend.h               |    2 ++
> >>>  kernel/power/main.c                   |   15 +++++++++++++++
> >>>  kernel/power/suspend.c                |    1 +
> >>>  4 files changed, 28 insertions(+)
> >>>
> >>> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> >>> index a3942b1036e2..63659765dee1 100644
> >>> --- a/Documentation/ABI/testing/sysfs-power
> >>> +++ b/Documentation/ABI/testing/sysfs-power
> >>> @@ -442,6 +442,16 @@ Description:
> >>>  		'total_hw_sleep' and 'last_hw_sleep' may not be accurate.
> >>>  		This number is measured in microseconds.
> >>>  
> >>> +What:		/sys/power/suspend_stats/last_success_resume_time
> >>> +Date:		Oct 2023
> >>> +Contact:	Masami Hiramatsu <mhiramat@kernel.org>
> >>> +Description:
> >>> +		The /sys/power/suspend_stats/last_success_resume_time file
> >>> +		contains the timestamp of when the kernel successfully
> >>> +		resumed from suspend/hibernate.
> >>> +		This floating number is measured in seconds by monotonic
> >>
> >> What does "floating" mean here?  Not floating point...
> > 
> > Oops, it should be "floating point number".
> > 
> > Thank you!
> > 
> >>
> >>
> >>> +		clock.
> >>> +
> >>>  What:		/sys/power/sync_on_suspend
> >>>  Date:		October 2019
> >>>  Contact:	Jonas Meurer <jonas@freesources.org>
> >>
> >> [snip]
> >>
> >> Thanks.
> >> -- 
> >> ~Randy
> > 
> > 
> 
> -- 
> ~Randy


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
