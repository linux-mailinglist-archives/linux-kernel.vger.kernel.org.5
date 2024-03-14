Return-Path: <linux-kernel+bounces-102884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D1587B801
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807051F21CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C3B4A11;
	Thu, 14 Mar 2024 06:37:31 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4D34683;
	Thu, 14 Mar 2024 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710398250; cv=none; b=drjMfVl0bUbfc9jBwcqWmaw7hJdjWV1aY/lyFveCU2I4rSusEdHqY0peBIMWWQUTSUqS2ddTZjHRQ+kPc6DZZXyNwBFVHVSMTjqe4Hi9eTbOGLDN7Gfgjzjhif75/+3UL12yKLqcurLu6QulXrdULKZXMDTCESqKQReKE8ZEcbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710398250; c=relaxed/simple;
	bh=rYAKy0YwJE5ci82WZQpxeGINJPlfTTccgMae34B3AWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aGE7Pocu/F4GKabzyxp5RX7QkG78JSrBKaS+Jn/+nHD6amI84j3QIEe/iPTLqQ0ncUFWV08n4a2kcUHkwU3DHgiHGZy7C6D5OlHjYrLxPksRWl38MeBekf3woyAUResRZYmM2/7sW1M+duGlde7t+/nenCHOY2n1kgiqNRsl7ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 98ce9f10be844c369520d7c1404ded6f-20240314
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e20e57c8-bb4e-4429-a4ac-d750caae4838,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.37,REQID:e20e57c8-bb4e-4429-a4ac-d750caae4838,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:6f543d0,CLOUDID:f1ea7c81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2403141437215XVAHEKJ,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 98ce9f10be844c369520d7c1404ded6f-20240314
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 887291583; Thu, 14 Mar 2024 14:37:19 +0800
From: Ai Chao <aichao@kylinos.cn>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	u.kleine-koenig@pengutronix.de,
	mario.limonciello@amd.com,
	jes965@nyu.edu,
	alexbelm48@gmail.com,
	onenowy@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v1] platform/x86: hp-wmi: use sysfs_emit() instead of sprintf()
Date: Thu, 14 Mar 2024 14:37:03 +0800
Message-Id: <20240314063703.315841-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 drivers/platform/x86/hp/hp-wmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 630519c08617..5fa553023842 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -681,7 +681,7 @@ static ssize_t display_show(struct device *dev, struct device_attribute *attr,
 
 	if (value < 0)
 		return value;
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t hddtemp_show(struct device *dev, struct device_attribute *attr,
@@ -691,7 +691,7 @@ static ssize_t hddtemp_show(struct device *dev, struct device_attribute *attr,
 
 	if (value < 0)
 		return value;
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t als_show(struct device *dev, struct device_attribute *attr,
@@ -701,7 +701,7 @@ static ssize_t als_show(struct device *dev, struct device_attribute *attr,
 
 	if (value < 0)
 		return value;
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t dock_show(struct device *dev, struct device_attribute *attr,
@@ -711,7 +711,7 @@ static ssize_t dock_show(struct device *dev, struct device_attribute *attr,
 
 	if (value < 0)
 		return value;
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t tablet_show(struct device *dev, struct device_attribute *attr,
@@ -721,7 +721,7 @@ static ssize_t tablet_show(struct device *dev, struct device_attribute *attr,
 
 	if (value < 0)
 		return value;
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t postcode_show(struct device *dev, struct device_attribute *attr,
@@ -732,7 +732,7 @@ static ssize_t postcode_show(struct device *dev, struct device_attribute *attr,
 
 	if (value < 0)
 		return value;
-	return sprintf(buf, "0x%x\n", value);
+	return sysfs_emit(buf, "0x%x\n", value);
 }
 
 static ssize_t als_store(struct device *dev, struct device_attribute *attr,
-- 
2.25.1


