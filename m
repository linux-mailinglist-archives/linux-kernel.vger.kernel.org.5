Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA776810BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjLMHjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjLMHjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:39:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BD2B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:39:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B061DC433C8;
        Wed, 13 Dec 2023 07:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702453170;
        bh=MrwMDA0p5hY5rMSLNC9Zaa/t5Tz7gjiSVAxMeg+6Sb8=;
        h=From:To:Cc:Subject:Date:From;
        b=dMRQ5Iqx4PXs6K2Q47pf59XzYjsXfJnNRhN8N5o383oM4fBQacN4vWebnmCE0TDvD
         v5hgcZsvfyuWh2o83IUTB9PbulFPAKPQOYKM9nTpsSRkcXHAqrhXwVgI3YFFhFOshL
         nDeNHjjn5IjIpnbq5/GvrXsBsJu3kWarJ/7oKva1MgKXpGmbRyTT7ZZbnxRYkNmeSN
         4Cgl1RY/CMqkfdcdriRRFWoI/ofJ8EtfuzghImwqrKWJrwbzUVp3EMe9207nod8s2c
         QV2th3u3ck+qetg2hdeyntf/ejq8i1XZ6eNNqPtufmGdyABmZSlEq4fizGb/K529gz
         25ojSxIWFh9Rw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     suleiman@google.com, briannorris@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v6 0/1] PM: sleep: Expose last succeeded resumed timestamp in sysfs
Date:   Wed, 13 Dec 2023 16:39:26 +0900
Message-ID:  <170245316678.651355.6640896026073025688.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
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

Here is the 6th version of the patch to expose last succeeded resumed
timestamp in sysfs as /sys/power/suspend_stats/last_success_resume_time.
The previous version is here.

https://lore.kernel.org/all/170108151076.780347.2482745314490930894.stgit@mhiramat.roam.corp.google.com/

This version fixes the timestamp recording timing to right before thawing
user processes and is rebased on v6.7-rc5. 

This allows us to find when the kernel resume process successfully done
in the sysfs in MONOTONIC clock. Thus user processes can measure the
elapsed time taken by its resume process at any point in time.

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
 kernel/power/suspend.c                |    3 +++
 4 files changed, 30 insertions(+)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
