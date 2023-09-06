Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A39793460
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbjIFETX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbjIFETW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:19:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0C3E76;
        Tue,  5 Sep 2023 21:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693973948; x=1725509948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pc90S/c8932uAvyiduvyGa0QXXHWXOrYk20HoKH2IDo=;
  b=feETVDyHD1D2CnQumpm0VqR/3oqAKPZPnYHOSkfggD0bp7zbkPygqh1E
   +QZdr8y1yJuGSjowjFsWLHA1REnPRKyoI8yihFo6gsgSCnd0VUbx7gJkv
   Oc205fpKyDryCjOrARja65o4xV8lXDYmA0q48V1QmmVshaUoW49timV9T
   HPa06IKu4paIZ3X1sDLq6SSivf+aOFk4+Flzr+4S9EXO5rTRs9gGLEkl5
   BMfa1WRe43RycXVbqxsVevobhCj1q1zNlrfOWjUSwW5cP8dA1m3sphfSq
   GwjDgeLips6xKsBE6UKT9jz4HChQWh1wDpRtPe8o7LCz1glvNSdY5X8bW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="407967868"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="407967868"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 21:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="831483471"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="831483471"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Sep 2023 21:19:05 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chenzhou Feng <chenzhoux.feng@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com
Subject: [PATCH v2 2/2] PM: hibernate: Fix the exclusive get block device in test_resume mode
Date:   Wed,  6 Sep 2023 12:18:52 +0800
Message-Id: <e2279c339fcf919cffa4802b4e32974dc8950513.1693972725.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693972725.git.yu.c.chen@intel.com>
References: <cover.1693972725.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 5904de0d735b ("PM: hibernate: Do not get block device exclusively
in test_resume mode") fixes a hibernation issue under test_resume mode.
That commit is supposed to open the block device in non-exclusive mode
when in test_resume. However the code did the opposite, which is against
its description.

In summary, the swap device is only opened exclusively by swsusp_check()
with its corresponding *close(), and must be in non test_resume mode.
This is to avoid the race condition that different processes scribble the
device at the same time. All the other cases should use non-exclusive mode.

Fix it by really disabling exclusive mode under test_resume.

Fixes: 5904de0d735b ("PM: hibernate: Do not get block device exclusively in test_resume mode")
Reported-by: syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000761f5f0603324129@google.com/
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/hibernate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2b4a946a6ff5..8d35b9f9aaa3 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -786,9 +786,9 @@ int hibernate(void)
 	unlock_device_hotplug();
 	if (snapshot_test) {
 		pm_pr_dbg("Checking hibernation image\n");
-		error = swsusp_check(snapshot_test);
+		error = swsusp_check(false);
 		if (!error)
-			error = load_image_and_restore(snapshot_test);
+			error = load_image_and_restore(false);
 	}
 	thaw_processes();
 
@@ -945,14 +945,14 @@ static int software_resume(void)
 	pm_pr_dbg("Looking for hibernation image.\n");
 
 	mutex_lock(&system_transition_mutex);
-	error = swsusp_check(false);
+	error = swsusp_check(true);
 	if (error)
 		goto Unlock;
 
 	/* The snapshot device should not be opened while we're running */
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
-		swsusp_close(false);
+		swsusp_close(true);
 		goto Unlock;
 	}
 
@@ -973,7 +973,7 @@ static int software_resume(void)
 		goto Close_Finish;
 	}
 
-	error = load_image_and_restore(false);
+	error = load_image_and_restore(true);
 	thaw_processes();
  Finish:
 	pm_notifier_call_chain(PM_POST_RESTORE);
@@ -987,7 +987,7 @@ static int software_resume(void)
 	pm_pr_dbg("Hibernation image not present or could not be loaded.\n");
 	return error;
  Close_Finish:
-	swsusp_close(false);
+	swsusp_close(true);
 	goto Finish;
 }
 
-- 
2.25.1

