Return-Path: <linux-kernel+bounces-43322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474D984121F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB02628B877
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31AA13ADA;
	Mon, 29 Jan 2024 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rE252tqz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38A4CB37;
	Mon, 29 Jan 2024 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553288; cv=none; b=cL38ZDI8l8+PEQGdl4Qj9xBAE06a57+F4lumw8DxEILTbq6cEmAOAuYwLBijsUpvtH5rz3vjDURdFbGFMdrVNJbfbxSt0MbJHddi/Jm2O1XeMcfJZqzvn87+xdU0suqOjpyYBYOSFnwVB4vEvyqIwzXymwaXXo5KagB4TUB40dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553288; c=relaxed/simple;
	bh=AwxJS7Jf96UGE+l8L1yMrUBSR56MkBGVMG6Ie3ReMG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayYiwLP3fLF3v2O+wp6F79yKVLDnjL6fTmW0F0o26Nt1OpxRc2E0LUR/RDQjDY4QzgpZ8Ne1A6x3RDwKOKKc+RD5XA7iPzzhGvXjjXlj/LzN9695hSrOxGhFxfC4wOyARHTgb0wwBx+S+Zv4lh4SfyyN8ov4MezCLADOptIjgWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rE252tqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC56C433F1;
	Mon, 29 Jan 2024 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553287;
	bh=AwxJS7Jf96UGE+l8L1yMrUBSR56MkBGVMG6Ie3ReMG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rE252tqzWojL2r/ADYNNEyPCuNByVlRkPNdgKD+YXzwiIV6ceJzniLfwC/2rC4oDw
	 PmU9RxeSwobgiBJVKd8SSBxhfeqNilOvt3/SeBi1/2RjW/b6WdjpqMexPURT6TaRX7
	 3P0z2QpTEgOX47BdLOnNNL433RFyAkmC62ZZ9KIXOt3BAi9xgCVB+WvK8j5rJuWnbY
	 v5np1fGT8JELUkcw17AJDGXgceFf79WC0w405eyHuC8Y10Cc6TU7PkfjqhKDkCqKKN
	 bWoItumrotdG7gx4F/skGs6giO22dQ6bAtes5AIuvNRdLeaM6GC3iz46DXJ2VVXOD/
	 jno3GQ7NMgHoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mahesh Rajashekhara <mahesh.rajashekhara@microchip.com>,
	Scott Teel <scott.teel@microchip.com>,
	Scott Benesh <scott.benesh@microchip.com>,
	Mike McGowen <mike.mcgowen@microchip.com>,
	Kevin Barnett <kevin.barnett@microchip.com>,
	Murthy Bhat <Murthy.Bhat@microchip.com>,
	Don Brace <don.brace@microchip.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 03/12] scsi: smartpqi: Fix logical volume rescan race condition
Date: Mon, 29 Jan 2024 13:34:12 -0500
Message-ID: <20240129183440.463998-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183440.463998-1-sashal@kernel.org>
References: <20240129183440.463998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Mahesh Rajashekhara <mahesh.rajashekhara@microchip.com>

[ Upstream commit fb4cece17b4583f55b34a8538e27a4adc833c9d4 ]

Correct rescan flag race condition.

Multiple conditions are being evaluated before notifying OS to do a rescan.

Driver will skip rescanning the device if any one of the following
conditions are met:

 - Devices that have not yet been added to the OS or devices that have been
   removed.

 - Devices which are already marked for removal or in the phase of removal.

Under very rare conditions, after logical volume size expansion, the OS
still sees the size of the logical volume which was before expansion.

The rescan flag in the driver is used to signal the need for a logical
volume rescan. A race condition can occur in the driver, and it leads to
one thread overwriting the flag inadvertently. As a result, driver is not
notifying the OS SML to rescan the logical volume.

Move device->rescan update into new function pqi_mark_volumes_for_rescan()
and protect with a spin lock.

Move check for device->rescan into new function pqi_volume_rescan_needed()
and protect function call with a spin_lock.

Reviewed-by: Scott Teel <scott.teel@microchip.com>
Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Mike McGowen <mike.mcgowen@microchip.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microchip.com>
Co-developed-by: Murthy Bhat <Murthy.Bhat@microchip.com>
Signed-off-by: Murthy Bhat <Murthy.Bhat@microchip.com>
Signed-off-by: Mahesh Rajashekhara <mahesh.rajashekhara@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
Link: https://lore.kernel.org/r/20231219193653.277553-3-don.brace@microchip.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi.h      |  1 -
 drivers/scsi/smartpqi/smartpqi_init.c | 43 ++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
index 041940183516..cdedc271857a 100644
--- a/drivers/scsi/smartpqi/smartpqi.h
+++ b/drivers/scsi/smartpqi/smartpqi.h
@@ -1347,7 +1347,6 @@ struct pqi_ctrl_info {
 	bool		controller_online;
 	bool		block_requests;
 	bool		scan_blocked;
-	u8		logical_volume_rescan_needed : 1;
 	u8		inbound_spanning_supported : 1;
 	u8		outbound_spanning_supported : 1;
 	u8		pqi_mode_enabled : 1;
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index d56201120087..081bb2c09806 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2093,8 +2093,6 @@ static void pqi_scsi_update_device(struct pqi_ctrl_info *ctrl_info,
 		if (existing_device->devtype == TYPE_DISK) {
 			existing_device->raid_level = new_device->raid_level;
 			existing_device->volume_status = new_device->volume_status;
-			if (ctrl_info->logical_volume_rescan_needed)
-				existing_device->rescan = true;
 			memset(existing_device->next_bypass_group, 0, sizeof(existing_device->next_bypass_group));
 			if (!pqi_raid_maps_equal(existing_device->raid_map, new_device->raid_map)) {
 				kfree(existing_device->raid_map);
@@ -2164,6 +2162,20 @@ static inline void pqi_init_device_tmf_work(struct pqi_scsi_dev *device)
 		INIT_WORK(&tmf_work->work_struct, pqi_tmf_worker);
 }
 
+static inline bool pqi_volume_rescan_needed(struct pqi_scsi_dev *device)
+{
+	if (pqi_device_in_remove(device))
+		return false;
+
+	if (device->sdev == NULL)
+		return false;
+
+	if (!scsi_device_online(device->sdev))
+		return false;
+
+	return device->rescan;
+}
+
 static void pqi_update_device_list(struct pqi_ctrl_info *ctrl_info,
 	struct pqi_scsi_dev *new_device_list[], unsigned int num_new_devices)
 {
@@ -2284,9 +2296,13 @@ static void pqi_update_device_list(struct pqi_ctrl_info *ctrl_info,
 		if (device->sdev && device->queue_depth != device->advertised_queue_depth) {
 			device->advertised_queue_depth = device->queue_depth;
 			scsi_change_queue_depth(device->sdev, device->advertised_queue_depth);
-			if (device->rescan) {
-				scsi_rescan_device(device->sdev);
+			spin_lock_irqsave(&ctrl_info->scsi_device_list_lock, flags);
+			if (pqi_volume_rescan_needed(device)) {
 				device->rescan = false;
+				spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
+				scsi_rescan_device(device->sdev);
+			} else {
+				spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
 			}
 		}
 	}
@@ -2308,8 +2324,6 @@ static void pqi_update_device_list(struct pqi_ctrl_info *ctrl_info,
 		}
 	}
 
-	ctrl_info->logical_volume_rescan_needed = false;
-
 }
 
 static inline bool pqi_is_supported_device(struct pqi_scsi_dev *device)
@@ -3702,6 +3716,21 @@ static bool pqi_ofa_process_event(struct pqi_ctrl_info *ctrl_info,
 	return ack_event;
 }
 
+static void pqi_mark_volumes_for_rescan(struct pqi_ctrl_info *ctrl_info)
+{
+	unsigned long flags;
+	struct pqi_scsi_dev *device;
+
+	spin_lock_irqsave(&ctrl_info->scsi_device_list_lock, flags);
+
+	list_for_each_entry(device, &ctrl_info->scsi_device_list, scsi_device_list_entry) {
+		if (pqi_is_logical_device(device) && device->devtype == TYPE_DISK)
+			device->rescan = true;
+	}
+
+	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
+}
+
 static void pqi_disable_raid_bypass(struct pqi_ctrl_info *ctrl_info)
 {
 	unsigned long flags;
@@ -3742,7 +3771,7 @@ static void pqi_event_worker(struct work_struct *work)
 				ack_event = true;
 				rescan_needed = true;
 				if (event->event_type == PQI_EVENT_TYPE_LOGICAL_DEVICE)
-					ctrl_info->logical_volume_rescan_needed = true;
+					pqi_mark_volumes_for_rescan(ctrl_info);
 				else if (event->event_type == PQI_EVENT_TYPE_AIO_STATE_CHANGE)
 					pqi_disable_raid_bypass(ctrl_info);
 			}
-- 
2.43.0


