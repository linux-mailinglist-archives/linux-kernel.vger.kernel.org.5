Return-Path: <linux-kernel+bounces-26665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F5382E4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810C91F2464F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BEC20315;
	Tue, 16 Jan 2024 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGRGbeSO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA8220313;
	Tue, 16 Jan 2024 00:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4CBC43390;
	Tue, 16 Jan 2024 00:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364053;
	bh=KYODEJCLLPPa1wSTMb/nZ9RdT/B9th3CPaj83m5iMEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nGRGbeSO80FQx3MocgZJcwZmpuekhJrlDhdUEA+W/drWn+ddwdp2nQ4zmtFjY5rKq
	 Nt9lwOstBqdb6wgg6SvO+cwBtqANzGqafTUWj2TH+YJBuEx2OqPxjCVLtLGMXRrV/i
	 fL4zZpDNhmOjAQm3cA9/u7wrt4dZkgTXZCCp9YHKqZWzRMSpinqufo++l1pgWQueuk
	 eOsuJcjo9JRJiJxJ1IhgAlc7epDi/9fHXeNTu3KK3rH6sca6HXfDtLAVva73YjaNQh
	 x6fJndiN4e6oywts/UNk5dlHZEuII3o7INJ8mBW5qiAqVz6391VJxwbI9XsGAoQ/nh
	 uHJjSi+VAZ/jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Bo Ye <bo.ye@mediatek.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 14/14] thermal: core: Fix thermal zone suspend-resume synchronization
Date: Mon, 15 Jan 2024 19:13:40 -0500
Message-ID: <20240116001347.213328-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001347.213328-1-sashal@kernel.org>
References: <20240116001347.213328-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 4e814173a8c4f432fd068b1c796f0416328c9d99 ]

There are 3 synchronization issues with thermal zone suspend-resume
during system-wide transitions:

 1. The resume code runs in a PM notifier which is invoked after user
    space has been thawed, so it can run concurrently with user space
    which can trigger a thermal zone device removal.  If that happens,
    the thermal zone resume code may use a stale pointer to the next
    list element and crash, because it does not hold thermal_list_lock
    while walking thermal_tz_list.

 2. The thermal zone resume code calls thermal_zone_device_init()
    outside the zone lock, so user space or an update triggered by
    the platform firmware may see an inconsistent state of a
    thermal zone leading to unexpected behavior.

 3. Clearing the in_suspend global variable in thermal_pm_notify()
    allows __thermal_zone_device_update() to continue for all thermal
    zones and it may as well run before the thermal_tz_list walk (or
    at any point during the list walk for that matter) and attempt to
    operate on a thermal zone that has not been resumed yet.  It may
    also race destructively with thermal_zone_device_init().

To address these issues, add thermal_list_lock locking to
thermal_pm_notify(), especially arount the thermal_tz_list,
make it call thermal_zone_device_init() back-to-back with
__thermal_zone_device_update() under the zone lock and replace
in_suspend with per-zone bool "suspend" indicators set and unset
under the given zone's lock.

Link: https://lore.kernel.org/linux-pm/20231218162348.69101-1-bo.ye@mediatek.com/
Reported-by: Bo Ye <bo.ye@mediatek.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 30 +++++++++++++++++++++++-------
 include/linux/thermal.h        |  2 ++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e6f3166a9208..86ec48c1af93 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -37,8 +37,6 @@ static LIST_HEAD(thermal_governor_list);
 static DEFINE_MUTEX(thermal_list_lock);
 static DEFINE_MUTEX(thermal_governor_lock);
 
-static atomic_t in_suspend;
-
 static struct thermal_governor *def_governor;
 
 /*
@@ -409,7 +407,7 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 {
 	int count;
 
-	if (atomic_read(&in_suspend))
+	if (tz->suspended)
 		return;
 
 	if (WARN_ONCE(!tz->ops->get_temp,
@@ -1528,17 +1526,35 @@ static int thermal_pm_notify(struct notifier_block *nb,
 	case PM_HIBERNATION_PREPARE:
 	case PM_RESTORE_PREPARE:
 	case PM_SUSPEND_PREPARE:
-		atomic_set(&in_suspend, 1);
+		mutex_lock(&thermal_list_lock);
+
+		list_for_each_entry(tz, &thermal_tz_list, node) {
+			mutex_lock(&tz->lock);
+
+			tz->suspended = true;
+
+			mutex_unlock(&tz->lock);
+		}
+
+		mutex_unlock(&thermal_list_lock);
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_RESTORE:
 	case PM_POST_SUSPEND:
-		atomic_set(&in_suspend, 0);
+		mutex_lock(&thermal_list_lock);
+
 		list_for_each_entry(tz, &thermal_tz_list, node) {
+			mutex_lock(&tz->lock);
+
+			tz->suspended = false;
+
 			thermal_zone_device_init(tz);
-			thermal_zone_device_update(tz,
-						   THERMAL_EVENT_UNSPECIFIED);
+			__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+			mutex_unlock(&tz->lock);
 		}
+
+		mutex_unlock(&thermal_list_lock);
 		break;
 	default:
 		break;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a5ae4af955ff..4012f440bfdc 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -150,6 +150,7 @@ struct thermal_cooling_device {
  * @node:	node in thermal_tz_list (in thermal_core.c)
  * @poll_queue:	delayed work for polling
  * @notify_event: Last notification event
+ * @suspended: thermal zone suspend indicator
  */
 struct thermal_zone_device {
 	int id;
@@ -183,6 +184,7 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;
+	bool suspended;
 };
 
 /**
-- 
2.43.0


