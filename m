Return-Path: <linux-kernel+bounces-107063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4968E87F71B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF44A1F222B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB494EB32;
	Tue, 19 Mar 2024 06:07:28 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB2C4594E;
	Tue, 19 Mar 2024 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710828447; cv=none; b=NE0oy0ygP31eNoZa+ux52QhD5DfF3kf+fUUh9qeoHOt4KR7OlRpEY/1xmuHmE854hhUoPUP8qTSgW7cDOWZzMCeg89BAKmO1rRuoqAC4o5gd40sGPMpm+Qmshy2PR+2nyNiVRGxkGNXANbe87WK7HCcGH1c+O00xhE1SKEZ1uO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710828447; c=relaxed/simple;
	bh=97rmmRyR/THWjxWYYtBPperXwuTci/JnGu8FEM9o6/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NWnfvVYHorWJNhlOxEhwHpQmhRqc9/ndlsMjw73uNaO4F+ypIA6LWLFEe+amR+5JZyOhMCJhfY5OYUdTvkvnf1wQmaNxaivX9wZZVfspvK1Eb7q25XbnhO2Xox+ftvXZPb/3QcnUXM1rfDbwEw1D68YNRYs/q5ogC0ivluGFIlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 58ace020264d481a83be61a850fd3cbb-20240319
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:7193bbf2-430b-478f-801c-480c7314e308,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.37,REQID:7193bbf2-430b-478f-801c-480c7314e308,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:55bba981-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240319135640TV1N0V1G,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 58ace020264d481a83be61a850fd3cbb-20240319
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1627458638; Tue, 19 Mar 2024 13:56:38 +0800
From: Ai Chao <aichao@kylinos.cn>
To: corentin.chary@gmail.com,
	luke@ljones.dev,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v1] platform/x86: asus-wmi: use sysfs_emit() instead of sprintf()
Date: Tue, 19 Mar 2024 13:56:36 +0800
Message-Id: <20240319055636.150289-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This changes all *_show attributes in asus-wmi.c to use sysfs_emit()
instead of the older method of writing to the output buffer manually.

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 drivers/platform/x86/asus-wmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3f07bbf809ef..df4c103459da 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2326,7 +2326,7 @@ static ssize_t pwm1_show(struct device *dev,
 
 	/* If we already set a value then just return it */
 	if (asus->agfn_pwm >= 0)
-		return sprintf(buf, "%d\n", asus->agfn_pwm);
+		return sysfs_emit(buf, "%d\n", asus->agfn_pwm);
 
 	/*
 	 * If we haven't set already set a value through the AGFN interface,
@@ -2512,8 +2512,8 @@ static ssize_t asus_hwmon_temp1(struct device *dev,
 	if (err < 0)
 		return err;
 
-	return sprintf(buf, "%ld\n",
-		       deci_kelvin_to_millicelsius(value & 0xFFFF));
+	return sysfs_emit(buf, "%ld\n",
+			  deci_kelvin_to_millicelsius(value & 0xFFFF));
 }
 
 /* GPU fan on modern ROG laptops */
@@ -4061,7 +4061,7 @@ static ssize_t show_sys_wmi(struct asus_wmi *asus, int devid, char *buf)
 	if (value < 0)
 		return value;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 #define ASUS_WMI_CREATE_DEVICE_ATTR(_name, _mode, _cm)			\
-- 
2.25.1


