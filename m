Return-Path: <linux-kernel+bounces-57655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F2184DBD6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9BF1C24F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E276046;
	Thu,  8 Feb 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+AyC1IJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702AC76026;
	Thu,  8 Feb 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381937; cv=none; b=hhjbRqxB40t4BvmfYSTN/D582LT6/uvh1HD7WeffP0D25EX09pQCL2JEtu1YJisjeBw0fqVKrmi0sdTUIvnFm0HlEkF796H/UA1n012sFuXhI5lqenfaZuBXuN39AhzFOVBBCiMb+tdjAP4Y5YL88fnK+peuEt8eDBoQ7135rTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381937; c=relaxed/simple;
	bh=lMT5ds09tPKnvt5Z0XoIWL0MTp/63mQAtpaTLMS6Bp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvMA2J2qSZEdw0hZErbGteyrLrWJhalxQRYfJk6vLMB/tkvzTBTgddfdaBOeoH/wcJOfc+imY0JRhPeg8auWB2BclF9yYdK7Mp5N3R/fziVbzt2Mn1w16QwIv59GE2rcdFpaPLBvA037rIPF0vM0VZxqjZnIXc8IxjVibrYNB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+AyC1IJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEFEC43399;
	Thu,  8 Feb 2024 08:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707381937;
	bh=lMT5ds09tPKnvt5Z0XoIWL0MTp/63mQAtpaTLMS6Bp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J+AyC1IJGKuoOUKM5zUpx63JFqLmK3QCBMLMNCt2a87u7tEU2INr5mCviZhYP0aY4
	 jE+FZIXhMhOtL29JNAm/HuvP83u7gFMWthjuqXFRePQ2ccCLhWzb0P61wzQQGncLvY
	 Wq+d7cvzmlMBf3QGUprdbxancpf64qlSJ+G+LbUosm8B8m6hhaqb0ZG2qC7L2uwgBa
	 jRFgq2L8l84PNrXWXGck3eqqxs1MuTR8RRwAPmgdmAUOJIZzh8bixKKsR47yefhpKQ
	 FS+pCBiRWxQMQxdOlSMZvgoXMhzs/81weorCR11zGzY79j2ctTvt+MoDfrj5gcDC09
	 +oCg4Lw/QFfYA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 09/10] scsi: aic94xx: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
Date: Thu,  8 Feb 2024 08:44:21 +0000
Message-ID: <20240208084512.3803250-10-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240208084512.3803250-1-lee@kernel.org>
References: <20240208084512.3803250-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since snprintf() has the documented, but still rather strange trait of
returning the length of the data that *would have been* written to the
array if space were available, rather than the arguably more useful
length of data *actually* written, it is usually considered wise to use
something else instead in order to avoid confusion.

In the case of sysfs call-backs, new wrappers exist that do just that.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/aic94xx/aic94xx_init.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 8a3340d8d7ad4..c976e4b77c71e 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -264,8 +264,7 @@ static ssize_t asd_show_dev_rev(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct asd_ha_struct *asd_ha = dev_to_asd_ha(dev);
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			asd_dev_rev[asd_ha->revision_id]);
+	return sysfs_emit(buf, "%s\n", asd_dev_rev[asd_ha->revision_id]);
 }
 static DEVICE_ATTR(aic_revision, S_IRUGO, asd_show_dev_rev, NULL);
 
@@ -273,7 +272,7 @@ static ssize_t asd_show_dev_bios_build(struct device *dev,
 				       struct device_attribute *attr,char *buf)
 {
 	struct asd_ha_struct *asd_ha = dev_to_asd_ha(dev);
-	return snprintf(buf, PAGE_SIZE, "%d\n", asd_ha->hw_prof.bios.bld);
+	return sysfs_emit(buf, "%d\n", asd_ha->hw_prof.bios.bld);
 }
 static DEVICE_ATTR(bios_build, S_IRUGO, asd_show_dev_bios_build, NULL);
 
@@ -281,7 +280,7 @@ static ssize_t asd_show_dev_pcba_sn(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct asd_ha_struct *asd_ha = dev_to_asd_ha(dev);
-	return snprintf(buf, PAGE_SIZE, "%s\n", asd_ha->hw_prof.pcba_sn);
+	return sysfs_emit(buf, "%s\n", asd_ha->hw_prof.pcba_sn);
 }
 static DEVICE_ATTR(pcba_sn, S_IRUGO, asd_show_dev_pcba_sn, NULL);
 
@@ -452,7 +451,7 @@ static ssize_t asd_show_update_bios(struct device *dev,
 	if (asd_ha->bios_status != FLASH_IN_PROGRESS)
 		asd_ha->bios_status = FLASH_OK;
 
-	return snprintf(buf, PAGE_SIZE, "status=%x %s\n",
+	return sysfs_emit(buf, "status=%x %s\n",
 			flash_error_table[i].err_code,
 			flash_error_table[i].reason);
 }
@@ -937,7 +936,7 @@ static int asd_scan_finished(struct Scsi_Host *shost, unsigned long time)
 
 static ssize_t version_show(struct device_driver *driver, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", ASD_DRIVER_VERSION);
+	return sysfs_emit(buf, "%s\n", ASD_DRIVER_VERSION);
 }
 static DRIVER_ATTR_RO(version);
 
-- 
2.43.0.594.gd9cf4e227d-goog


