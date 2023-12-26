Return-Path: <linux-kernel+bounces-11514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF00881E78A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACF0282763
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C14EB3F;
	Tue, 26 Dec 2023 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYb9Owdz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5A4EB24;
	Tue, 26 Dec 2023 13:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3685EC433C7;
	Tue, 26 Dec 2023 13:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703596690;
	bh=ky3z8DENNEeInXyPyNEpomo9WDI55hnkx2oLshUqMKw=;
	h=From:To:Cc:Subject:Date:From;
	b=kYb9OwdzfO8EVKuVBURxl3TpdHLxwzsxdj0MJw044IsyI29fAw8tvz/WNzhoEfrEX
	 u6/21pudMjxLMIuvIGPaiE2S1rfipmpB1VzXKhf7WUbf/ob0ph2/fgrIfrTnbGtpe5
	 Lhyqo1H2oLeO63v3igb6FJICTnsfF+sKv++zy/hgHbbDJcxEMZLd8aq4OEZZnJR2dx
	 uCDIqUejS1pO+ZfLQL20/UWXh0oeN8lMBqjbIqptpeW6BEjViLSFc6/XEkI/apppVp
	 w41QJNRqii7LzPNIUh5iKYsqjynQUeqH+MS57tfUzST9+gIwwNBHULDYGauUoYQSbS
	 Kwyvk3ZdQoaVQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: suleiman@google.com,
	briannorris@google.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v7 0/1] PM: sleep: Expose last succeeded resumed timestamp in sysfs
Date: Tue, 26 Dec 2023 22:18:07 +0900
Message-ID:  <170359668692.1864392.6909734045167510522.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 7th version of the patch to expose last succeeded resumed
timestamp in sysfs as /sys/power/suspend_stats/last_success_resume_time.
The previous version is here.

https://lore.kernel.org/all/170245316678.651355.6640896026073025688.stgit@mhiramat.roam.corp.google.com/

This version fixes code comments, sysfs description and patch
description.

On some system like the ChromeOS, the system suspend and resume are
controlled by a power management process. The user-space tasks will be
noticed the suspend and the resume signal from it.
To improve the suspend/resume performance and/or to find regressions,
we would like to know how long the resume processes are taken in kernel
and in user-space.

This patch introduces a last succeeded resumed timestamp (just before
thawing processes) on sysfs which allows us to find when the kernel
resume process successfully done in MONOTONIC clock. Thus user processes
can measure the elapsed time taken by its resume process at any point
in time.

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


 Documentation/ABI/testing/sysfs-power |   11 +++++++++++
 include/linux/suspend.h               |    2 ++
 kernel/power/main.c                   |   15 +++++++++++++++
 kernel/power/suspend.c                |    9 +++++++++
 4 files changed, 37 insertions(+)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

