Return-Path: <linux-kernel+bounces-95577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C864C874FB2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F552820C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120A612BF36;
	Thu,  7 Mar 2024 13:12:14 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2912BF0C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817133; cv=none; b=JWAvBkWza/eTct2JviML2YS0CYsa4PuP0H2RwxyOwmO3mMy6mnlrUP6ewfjW7JjN0Ee71iOx7JwHIUB0VclVCKFvghyr7+hLz/MtPOG49GLZXp71wpgiP01WZ97McAzGOg5AhCmjaSs4kKh3euVXElvamuT2tSG1CIoCSh7gosc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817133; c=relaxed/simple;
	bh=4kNmfi5ij31nUuB6kRgFS13SDHOYI7nfHXYm79Gj6gA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cqCzgbe+/C7snxuABH1fp/vtHZr2G80xtrxvd1T4UxTX/Oh86scqeXr5oJrez0GAQTG43hQ+h4Eico41y4dyyjeBe63kjcahLQ0pvS0LFXUAb4N9Ig9iAxDKq80fRDkId/5Oheilrm5o0KHGhtycZKnZgIFcre57zBcPIa1J0Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (78.37.41.175) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 7 Mar
 2024 16:11:59 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] drivers: core: prevent dereferencing of a null pointer in device_move()
Date: Thu, 7 Mar 2024 16:11:41 +0300
Message-ID: <20240307131141.16668-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 03/07/2024 12:55:06
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 184041 [Mar 07 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 9 0.3.9 e923e63e431b6489f12901471775b2d1b59df0ba
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;78.37.41.175:7.4.1,7.7.3;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {cloud_iprep_silent}
X-KSE-AntiSpam-Info: ApMailHostAddress: 78.37.41.175
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/07/2024 12:59:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/7/2024 10:21:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Parameter new_parent can be equal to NULL. In this case if the 
drm_order parameter is equal to DRM_ORDER_DEV_AFTER_PARENT or
DRM_ORDER_PARENT_BEFORE_DEV, a null pointer will be dereferenced.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/base/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 9828da9b933c..9af7ccf56f42 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4593,10 +4593,18 @@ int device_move(struct device *dev, struct device *new_parent,
 	case DPM_ORDER_NONE:
 		break;
 	case DPM_ORDER_DEV_AFTER_PARENT:
+		if (!new_parent) {
+			error = -EINVAL;
+			goto out;
+		}
 		device_pm_move_after(dev, new_parent);
 		devices_kset_move_after(dev, new_parent);
 		break;
 	case DPM_ORDER_PARENT_BEFORE_DEV:
+		if (!new_parent) {
+			error = -EINVAL;
+			goto out;
+		}
 		device_pm_move_before(new_parent, dev);
 		devices_kset_move_before(new_parent, dev);
 		break;
-- 
2.34.1


