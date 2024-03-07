Return-Path: <linux-kernel+bounces-95211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FC5874AB4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AEC61C21026
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3405E83CA6;
	Thu,  7 Mar 2024 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LVs4Tlko"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5088633FB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803307; cv=none; b=tFDnZIJQxgEowCPYDs+fzwxPgatqjf6jSZEarmP6pnpKXq0VZ2w62jPDRVqtytZehlINLOuroKzcqJ6UPKuJ4DL4ZeHfGWIULQXWUAzE86ngUaWmfAJajOQtZwkut/j1L7+1JtoCgicFByrMk7QtRDs3DnWKpuq1qQXdY7JGTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803307; c=relaxed/simple;
	bh=Mo1YANgeHSNxf+W6bYRORnxK7E+hQTSFV57KfvUdwBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qf+TmeCby7LtcsV7VNiPBS9Bis7qjYc5H4mjUrzlwdmquffooUYk2xMsjQQlJpeQhEhdB5OgvCAT0xL6G9NFYYPbY1AQ+/qCWdgz9b8rDGS4zglIV53HG0+qb31+qQYuH/skqrILV9O4HhuPCJDL9MJPOl4/5T/sXJDdcUkjFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LVs4Tlko; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-214def5da12so261977fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 01:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709803304; x=1710408104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X6jZ+dVs7XI8S4fNRPjyKyWA5AZAbLPF6Th9taWNEc8=;
        b=LVs4TlkoujC/vpCYxWuLbb1MxiLJeT2hGTsS22LGY4Y82bxDmePcP8ayifvNv+k2rY
         B3m1FSUacIQJq0wOO770AKPGe0El1myS79hXmsLmIBmAa6hXvI9DClpRDUDalsMfrg+C
         kAJ1a2n9L01bZOZPcAy6bOrKkGRVnLiC3IrxN/naVjLy/Nkh2SF3vjc7tEcLxNTy7hmG
         MiW2xSFNXgFsIc/vNjG1RBBD5unh5G2ROyhvL/H3YufwE/iFYN8hrr83r8sRlOyV2MR3
         CRXQzPytd/09/7ZyfSDTvmjz3JkXaRcszwxP0D7l5nqtBQ2YWcB3hjkpva1xLbqnEKdq
         4+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803304; x=1710408104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6jZ+dVs7XI8S4fNRPjyKyWA5AZAbLPF6Th9taWNEc8=;
        b=pCysPUdbO3Bzc8cOtwIspjIhm0taIh8LRJ6SEC57l8ZO6bW2gk7zZ2RD2T7YGCwNmK
         CVTut/LNKQ/1OY/i2FpFSsAsEl23bPhAls7wqYfXffmCxA5Me2dMpfxL6QqNHxWj8qwg
         mhBdu6jl7dHCciloUyURAeaFE8DN0oTjlavX2VqV3f6qox1LBYpIKs8e7mbWW/siAEyy
         xYc7KvR0jg16ZZyC0V8KZ+CLbiT1zwiN34/A6V89JuZXxydcqFhdocEaLo1SXZvkwIC7
         S0XkY0dvJCXX9SqbuHNc0POATcpOvSi14TgvKvlK3e+6QOBJT1ssWZalL5wUlwLfPqBC
         Hvfg==
X-Gm-Message-State: AOJu0YzNYTMn5+n9AuypMq1mm1weNI7v2Xrtl6DaMy2AiOu7vAqYrKz5
	aWAGyUbe82BD14+hGIOaLPnuGdKZI3cEqEq+kbTis7RQO3QjuRia3KaYaG6Nff0mvqLzF0oaNzL
	Z
X-Google-Smtp-Source: AGHT+IHiqrQZgef41/ev0CdPkKkjI/0sBHEh/20WTBrud6oiZM3o2NSI2JXdtVDL2NYyh+uSd5QyHA==
X-Received: by 2002:a05:6870:114a:b0:21e:df09:fbb6 with SMTP id 10-20020a056870114a00b0021edf09fbb6mr6182351oag.41.1709803304722;
        Thu, 07 Mar 2024 01:21:44 -0800 (PST)
Received: from localhost.localdomain (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id ei4-20020a056a0080c400b006e57e220ceasm12189872pfb.6.2024.03.07.01.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:21:44 -0800 (PST)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: Marc Bonnici <marc.bonnici@arm.com>,
	Olivier Deprez <Olivier.Deprez@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] firmware: arm_ffa: support running as a guest in a vm
Date: Thu,  7 Mar 2024 10:21:32 +0100
Message-Id: <20240307092132.943881-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for running the driver in a guest to a hypervisor. The main
difference is that the notification interrupt is retrieved
with FFA_FEAT_NOTIFICATION_PENDING_INT and that
FFA_NOTIFICATION_BITMAP_CREATE doesn't need to be called.

FFA_FEAT_NOTIFICATION_PENDING_INT gives the interrupt the hypervisor has
chosen to notify its guest of pending notifications.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/firmware/arm_ffa/driver.c | 45 ++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index f2556a8e9401..c183c7d39c0f 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1306,17 +1306,28 @@ static void ffa_sched_recv_irq_work_fn(struct work_struct *work)
 	ffa_notification_info_get();
 }
 
+static int ffa_get_notif_intid(int *intid)
+{
+	int ret;
+
+	ret = ffa_features(FFA_FEAT_SCHEDULE_RECEIVER_INT, 0, intid, NULL);
+	if (!ret)
+		return 0;
+	ret = ffa_features(FFA_FEAT_NOTIFICATION_PENDING_INT, 0, intid, NULL);
+	if (!ret)
+		return 0;
+
+	pr_err("Failed to retrieve one of scheduler Rx or notif pending interrupts\n");
+	return ret;
+}
+
 static int ffa_sched_recv_irq_map(void)
 {
-	int ret, irq, sr_intid;
+	int ret, irq, intid;
 
-	/* The returned sr_intid is assumed to be SGI donated to NS world */
-	ret = ffa_features(FFA_FEAT_SCHEDULE_RECEIVER_INT, 0, &sr_intid, NULL);
-	if (ret < 0) {
-		if (ret != -EOPNOTSUPP)
-			pr_err("Failed to retrieve scheduler Rx interrupt\n");
+	ret = ffa_get_notif_intid(&intid);
+	if (ret)
 		return ret;
-	}
 
 	if (acpi_disabled) {
 		struct of_phandle_args oirq = {};
@@ -1329,12 +1340,12 @@ static int ffa_sched_recv_irq_map(void)
 
 		oirq.np = gic;
 		oirq.args_count = 1;
-		oirq.args[0] = sr_intid;
+		oirq.args[0] = intid;
 		irq = irq_create_of_mapping(&oirq);
 		of_node_put(gic);
 #ifdef CONFIG_ACPI
 	} else {
-		irq = acpi_register_gsi(NULL, sr_intid, ACPI_EDGE_SENSITIVE,
+		irq = acpi_register_gsi(NULL, intid, ACPI_EDGE_SENSITIVE,
 					ACPI_ACTIVE_HIGH);
 #endif
 	}
@@ -1442,17 +1453,15 @@ static void ffa_notifications_setup(void)
 	int ret, irq;
 
 	ret = ffa_features(FFA_NOTIFICATION_BITMAP_CREATE, 0, NULL, NULL);
-	if (ret) {
-		pr_info("Notifications not supported, continuing with it ..\n");
-		return;
-	}
+	if (!ret) {
 
-	ret = ffa_notification_bitmap_create();
-	if (ret) {
-		pr_info("Notification bitmap create error %d\n", ret);
-		return;
+		ret = ffa_notification_bitmap_create();
+		if (ret) {
+			pr_err("notification_bitmap_create error %d\n", ret);
+			return;
+		}
+		drv_info->bitmap_created = true;
 	}
-	drv_info->bitmap_created = true;
 
 	irq = ffa_sched_recv_irq_map();
 	if (irq <= 0) {
-- 
2.34.1


