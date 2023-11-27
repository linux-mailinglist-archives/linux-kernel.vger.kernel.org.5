Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D787F9DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjK0Kic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjK0Kia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:38:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3532518B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:38:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF13C433CC;
        Mon, 27 Nov 2023 10:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701081514;
        bh=6S5QzfClwV19elQA6yctifho8YSJOuo6Kodrr9D3l60=;
        h=From:To:Cc:Subject:Date:From;
        b=TyIUHHg4GYm/FuiPshCH2hFp6IIOnD3uEvwla+8K3u2GfAy+cJgM6839lux7r9wIQ
         +hN/RqrdPSbx4jjEVKupD3GO5heyv5c+CBEyQrF0HnzU2/PRbJivglT8xwORjIeu/m
         Chli1Ja2ehX7U3cqHuSzNj9gLzZ9kfLQKyL0DXYJE1KoBDLAiM72SDg0AkEQJHFx33
         W0/qR4BZ5QQjFohQ1QCG+SxqzciGZvTMJ8Sp5jnpsmc7V3rtQzic/IFCK2coEcuY7q
         dWhBEfdry3kQlBBwLA/Gd2yLD656DI7qW/PZ2CudlSe4JC2ePe3INUfYaQzB84elS2
         XTrLWmDoxr6Zg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     suleiman@google.com, briannorris@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v5 0/1] PM: sleep: Expose last succeeded resumed timestamp in sysfs
Date:   Mon, 27 Nov 2023 19:38:30 +0900
Message-ID:  <170108151076.780347.2482745314490930894.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 5th version of the patch to expose last succeeded resumed
timestamp in sysfs as /sys/power/suspend_stats/last_success_resume_time.
This version is just updated for v6.7-rc3.

This allows us to find when the kernel resume process successfully done
in the sysfs in MONOTONIC clock. Thus we can measure the time taken by
the user space resume process at any point in time.

This will help us to detect abnormal value (longer time) process in
the resuming and quickly decide the root cause is in the kernel or
user-space. The kernel side we can use many tools (e.g. printk or
ftrace) but for user-space we need to define the starting point of
the resuming process. Actually, the kernel side needs to use local
clock because the clock subsystem is also suspended. But in that
case, user space can not use that timestamp because the local clock
is not exposed.

So this will be used something like

where_the_user_space_resume_finish() {
	clock_gettime(CLOCK_MONOTONIC, &etime_ts);
	fileread("/sys/.../last_success_resume_time", stime);
	convert_timespec(stime, &stime_ts);
	user_resume_time = timespec_delta(&etime_ts, &stime_ts);
	...
}

Thank you,

---

Masami Hiramatsu (1):
      PM: sleep: Expose last succeeded resumed timestamp in sysfs


 Documentation/ABI/testing/sysfs-power |   10 ++++++++++
 include/linux/suspend.h               |    2 ++
 kernel/power/main.c                   |   15 +++++++++++++++
 kernel/power/suspend.c                |    1 +
 4 files changed, 28 insertions(+)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
