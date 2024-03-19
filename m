Return-Path: <linux-kernel+bounces-107119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E8E87F7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB0C1F20F29
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C335380B;
	Tue, 19 Mar 2024 06:43:07 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9A950A93;
	Tue, 19 Mar 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830586; cv=none; b=D1Vl+5peo8a/rw5t2irwuiCLj7COAv3h94mdhlSNxbXuDXBeSEIPK9ukYc3jcUnOTqerSrhjX7ECUnlm4u0VeX5GaSohkoZvbwWxQm2c78/akbkAk+dCwsPnnVO1TjDeESQcgRSrR7bB11gMqWULUdpYW69AdOHL1KTcS1zbtLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830586; c=relaxed/simple;
	bh=QTmL+ACcCO+15s5DxjpLDmByEmZ95gNcAIeCgsGk3WU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CWyhQHKLOeAJjUA3oVJWwnmgkqRWyqr3zuW9pfh0YDs2eYbtKAYjeB8p1ccI/1SRRNVWXsqSjhAl3V6lL24bzXByxsbV8oZcBvDNrlGmGbWtrX5v1yHLUKSKvC5GlBd2PaUTdu1/V2UPyOEn6k1j3fEIR6Cs0KNNWxaEpFl9588=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 37fa5de156814fcbb47cd840732b653b-20240319
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:6b6abceb-83ab-4b3c-90e0-dffd38351ec6,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.37,REQID:6b6abceb-83ab-4b3c-90e0-dffd38351ec6,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:6f543d0,CLOUDID:93410f00-c26b-4159-a099-3b9d0558e447,B
	ulkID:240319144247I73YYUAM,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 37fa5de156814fcbb47cd840732b653b-20240319
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1923390233; Tue, 19 Mar 2024 14:42:45 +0800
From: Ai Chao <aichao@kylinos.cn>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v1] platform/x86: huawei-wmi: use sysfs_emit() instead of sprintf()
Date: Tue, 19 Mar 2024 14:42:43 +0800
Message-Id: <20240319064243.297320-1-aichao@kylinos.cn>
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
 drivers/platform/x86/huawei-wmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index dde139c69945..09d476dd832e 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -379,7 +379,7 @@ static ssize_t charge_control_start_threshold_show(struct device *dev,
 	if (err)
 		return err;
 
-	return sprintf(buf, "%d\n", start);
+	return sysfs_emit(buf, "%d\n", start);
 }
 
 static ssize_t charge_control_end_threshold_show(struct device *dev,
@@ -392,7 +392,7 @@ static ssize_t charge_control_end_threshold_show(struct device *dev,
 	if (err)
 		return err;
 
-	return sprintf(buf, "%d\n", end);
+	return sysfs_emit(buf, "%d\n", end);
 }
 
 static ssize_t charge_control_thresholds_show(struct device *dev,
@@ -405,7 +405,7 @@ static ssize_t charge_control_thresholds_show(struct device *dev,
 	if (err)
 		return err;
 
-	return sprintf(buf, "%d %d\n", start, end);
+	return sysfs_emit(buf, "%d %d\n", start, end);
 }
 
 static ssize_t charge_control_start_threshold_store(struct device *dev,
@@ -562,7 +562,7 @@ static ssize_t fn_lock_state_show(struct device *dev,
 	if (err)
 		return err;
 
-	return sprintf(buf, "%d\n", on);
+	return sysfs_emit(buf, "%d\n", on);
 }
 
 static ssize_t fn_lock_state_store(struct device *dev,
-- 
2.25.1


