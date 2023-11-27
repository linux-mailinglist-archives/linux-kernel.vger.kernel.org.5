Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094077FAC9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjK0VfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjK0VfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:35:18 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6999F1B6;
        Mon, 27 Nov 2023 13:35:25 -0800 (PST)
Received: from pmartincic-dev0.corp.microsoft.com (unknown [131.107.159.0])
        by linux.microsoft.com (Postfix) with ESMTPSA id BF60D20B74C0;
        Mon, 27 Nov 2023 13:35:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF60D20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1701120924;
        bh=hzoqjq9Mvw6g9m/hIiSmGN1wXGQ/SBJMNB23AWgjIeg=;
        h=From:To:Subject:Date:From;
        b=l1pMr25ZRg/p8Gjj6k84zE69YJqN6NdbZvA+s9oW1dw9U7T13ZNC1BbZRQ7tC/672
         XcBj6z5iFz4Nr+HUTOqyNR+STZEktXDAZ76McRqJ+ugZ3LiDYd2q5EgUcOXy+ssCMn
         9RS06hXZYPQwlajq+DDI95HaOM3oSpk/JeVl8d0U=
From:   pmartincic@linux.microsoft.com
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC
Date:   Mon, 27 Nov 2023 13:35:24 -0800
Message-Id: <20231127213524.52783-1-pmartincic@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Martincic <pmartincic@microsoft.com>

Hyper-V hosts can omit the _SYNC flag to due a bug on resume from modern
suspend. In such a case, the guest may fail to update its time-of-day to
account for the period when it was suspended, and could proceed with a
significantly wrong time-of-day. In such a case when the guest is
significantly behind, fix it by treating a _SAMPLE the same as if _SYNC
was received so that the guest time-of-day is updated.

This is hidden behind param hv_utils.timesync_implicit.

Signed-off-by: Peter Martincic <pmartincic@microsoft.com>
---
 drivers/hv/hv_util.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 42aec2c5606a..9c97c4065fe7 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -296,6 +296,11 @@ static struct {
 	spinlock_t			lock;
 } host_ts;
 
+static bool timesync_implicit;
+
+module_param(timesync_implicit, bool, 0644);
+MODULE_PARM_DESC(timesync_implicit, "If set treat SAMPLE as SYNC when clock is behind");
+
 static inline u64 reftime_to_ns(u64 reftime)
 {
 	return (reftime - WLTIMEDELTA) * 100;
@@ -344,6 +349,29 @@ static void hv_set_host_time(struct work_struct *work)
 		do_settimeofday64(&ts);
 }
 
+/*
+ * Due to a bug on Hyper-V hosts, the sync flag may not always be sent on resume.
+ * Force a sync if the guest is behind.
+ */
+static inline bool hv_implicit_sync(u64 host_time)
+{
+	struct timespec64 new_ts;
+	struct timespec64 threshold_ts;
+
+	new_ts = ns_to_timespec64(reftime_to_ns(host_time));
+	ktime_get_real_ts64(&threshold_ts);
+
+	threshold_ts.tv_sec += 5;
+
+	/*
+	 * If guest behind the host by 5 or more seconds.
+	 */
+	if (timespec64_compare(&new_ts, &threshold_ts) >= 0)
+		return true;
+
+	return false;
+}
+
 /*
  * Synchronize time with host after reboot, restore, etc.
  *
@@ -384,7 +412,8 @@ static inline void adj_guesttime(u64 hosttime, u64 reftime, u8 adj_flags)
 	spin_unlock_irqrestore(&host_ts.lock, flags);
 
 	/* Schedule work to do do_settimeofday64() */
-	if (adj_flags & ICTIMESYNCFLAG_SYNC)
+	if ((adj_flags & ICTIMESYNCFLAG_SYNC) ||
+	    (timesync_implicit && hv_implicit_sync(host_ts.host_time)))
 		schedule_work(&adj_time_work);
 }
 
-- 
2.34.1

