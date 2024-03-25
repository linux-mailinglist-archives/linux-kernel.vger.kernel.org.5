Return-Path: <linux-kernel+bounces-116682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D16B88A284
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFC91C3729C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F5D84D03;
	Mon, 25 Mar 2024 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPtt1NxG"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B54501F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354432; cv=none; b=n4XBcSfoF8VEmPnBAQ2IdH3cokAJVaDxl3eb3JjMPvRKr5Dcl1Gx+8Wms/ob553nDMa1veI68JOHL8ksuKXvAyz24x4oLTuOFG5UFXfFTnRa5H3A4494iamqw5R8uJvbW0yplN2FqAjO+7/Xgr0PJs77s98mVG/ifq8nZtVND7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354432; c=relaxed/simple;
	bh=cx8c+k/KenvncNQO9MPUhik6kvuy5g0Pk5xmkTqsb38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pzWAKBu7B86oMg7blEQTaMuTdu2ac8IF8YqWOdyZJWzCa3JVLi+fCggOhFOTMOL2bXL5oP8xJRFKUPFUN5KfYrgCCJ2bBtySRm5JDuLBsrlgZgOY+hlpV3IPOKJ/YEI+1K3a1EfP2O7xZIzKrmw0n2zGouWukoUu/ULvpvp03hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cPtt1NxG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so5183571a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711354427; x=1711959227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DhXWU9LA3T0RxQdB87MsBwVWbw2Pg7nCtgEYH/YmzjQ=;
        b=cPtt1NxGHniVLRK/jV70lUbkTFPEtRW75TrCgG+0ODmBDL1/ZdrMAcmmxCnMiVx7kW
         Dnr4bMwPhZ0s0sS0+YwIf8isFktVfdE6JAFtYS6aayFaeUa+w/ZmX4AO3mr+AK9Fu9uD
         tvVgHMjqkPnrQ8YPZSglxhZthm6rguhb1JOvZrhqNrRS8UTtEW4UkrSJBGHuePeSVTWs
         VT95jSFc7MwBHwh0lATmiH+UVHZlilf0K/MiZSQtYzRHg3tia+PuNrmqFOcSFwKJ7gDw
         L/uEEZDkQ7lmU3It8mzd61+pyNMrvO16/9OuNpXlEPveVUSKuqDJG0CU+r8ABM7EERyu
         bFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711354427; x=1711959227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhXWU9LA3T0RxQdB87MsBwVWbw2Pg7nCtgEYH/YmzjQ=;
        b=vXUCSjve1E1WSdGLgfy6dJg2B0xxlCRI2tJ2YAOe9FOoDEo1Cy1wixBksgmqWCmSIH
         HoUyqtPSPZPzIOWn6gVQPeaHKUIE+YhHcMedeqC/AwFPjzPkIJ9lnTFb6oLvQdqUyMl3
         MM2fOfxOeLofnSWiY/z561Kka6HYmt3JgC8vTpO6ghm0sABycKAKuPvMqlLFPo8V1bWJ
         TTg50basz9dnQ3iC1v4D2VrFdLtxoLLmqHiNiRt1IqulxrzuIn3gjdoVPhUW83MKbeN0
         VY4Qq/V6hQ//oJjb+27Dj37N3puYRet8fDhMedxQxT9lIsj2Fa0QcoGwiL0urUT4w5bv
         /g1g==
X-Gm-Message-State: AOJu0YyKPXHW07PN0suiOANe+rrzmgUwEsQ0P4igLOdRRIaNVCkDLNuD
	eJhMKuigYq8AuDDrakWqmXXcu9etYpiQjh4pLhlpT/kBhgKiHli7OryeAuzcL9ws6jSBjMpRRY5
	W
X-Google-Smtp-Source: AGHT+IH9IzSEIibSx/cUg3GgoaiZtJ5TnwurXFuYszQrutP1U/mFc422e2ipla6NDZj535YIzmdoYQ==
X-Received: by 2002:a17:906:1ec9:b0:a46:62c0:659f with SMTP id m9-20020a1709061ec900b00a4662c0659fmr3720752ejj.70.1711354427102;
        Mon, 25 Mar 2024 01:13:47 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id dk5-20020a170907940500b00a4750b2e0f0sm1607036ejc.164.2024.03.25.01.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 01:13:46 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Marc Bonnici <marc.bonnici@arm.com>,
	Olivier Deprez <Olivier.Deprez@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bertrand Marquis <Bertrand.Marquis@arm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2] firmware: arm_ffa: support running as a guest in a vm
Date: Mon, 25 Mar 2024 09:13:35 +0100
Message-Id: <20240325081335.2326979-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for running the driver in a guest to a hypervisor. The main
difference is introducing notification pending interrupt and that
FFA_NOTIFICATION_BITMAP_CREATE doesn't need to be called.

The guest may need to use a notification pending interrupt instead of or
in addition to the schedule receiver interrupt.
FFA_FEAT_NOTIFICATION_PENDING_INT gives the interrupt the hypervisor has
chosen to notify its guest of pending notifications.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
Hi,

I've tested this with Xen with as hypervisor (Xen patches to be posted) and
the NPI handler delivers notifications as expected using
FFA_NOTIFICATION_GET. I've also tested without a hypervisor to see that the
SRI handler still works as expected.

Thanks,
Jens

v1->v2:
* Adds a Notification Pending Interrupt handler to retrieve notifications
  using for the interrupted CPU.
* The original Schedule Receiver Interrupt handler is initialized in parallel
  depending on whether FFA_FEAT_SCHEDULE_RECEIVER_INT is available.

 drivers/firmware/arm_ffa/driver.c | 117 +++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 35 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index f2556a8e9401..9732f0066c70 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -101,11 +101,12 @@ struct ffa_drv_info {
 	bool bitmap_created;
 	bool notif_enabled;
 	unsigned int sched_recv_irq;
+	unsigned int notif_pend_irq;
 	unsigned int cpuhp_state;
 	struct ffa_pcpu_irq __percpu *irq_pcpu;
 	struct workqueue_struct *notif_pcpu_wq;
 	struct work_struct notif_pcpu_work;
-	struct work_struct irq_work;
+	struct work_struct sched_recv_irq_work;
 	struct xarray partition_info;
 	DECLARE_HASHTABLE(notifier_hash, ilog2(FFA_MAX_NOTIFICATIONS));
 	struct mutex notify_lock; /* lock to protect notifier hashtable  */
@@ -1291,12 +1292,23 @@ static void ffa_partitions_cleanup(void)
 #define FFA_FEAT_SCHEDULE_RECEIVER_INT		(2)
 #define FFA_FEAT_MANAGED_EXIT_INT		(3)
 
-static irqreturn_t irq_handler(int irq, void *irq_data)
+static irqreturn_t sched_recv_irq_handler(int irq, void *irq_data)
 {
 	struct ffa_pcpu_irq *pcpu = irq_data;
 	struct ffa_drv_info *info = pcpu->info;
 
-	queue_work(info->notif_pcpu_wq, &info->irq_work);
+	queue_work(info->notif_pcpu_wq, &info->sched_recv_irq_work);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t notif_pend_irq_handler(int irq, void *irq_data)
+{
+	struct ffa_pcpu_irq *pcpu = irq_data;
+	struct ffa_drv_info *info = pcpu->info;
+
+	queue_work_on(smp_processor_id(), info->notif_pcpu_wq,
+		      &info->notif_pcpu_work);
 
 	return IRQ_HANDLED;
 }
@@ -1306,15 +1318,16 @@ static void ffa_sched_recv_irq_work_fn(struct work_struct *work)
 	ffa_notification_info_get();
 }
 
-static int ffa_sched_recv_irq_map(void)
+static int ffa_irq_map(u32 id)
 {
-	int ret, irq, sr_intid;
+	int ret, irq, intid;
 
-	/* The returned sr_intid is assumed to be SGI donated to NS world */
-	ret = ffa_features(FFA_FEAT_SCHEDULE_RECEIVER_INT, 0, &sr_intid, NULL);
+	/* The returned intid is assumed to be SGI donated to NS world */
+	ret = ffa_features(id, 0, &intid, NULL);
 	if (ret < 0) {
+		pr_err("Failed to retrieve FF-A id %u interrupt\n", id);
 		if (ret != -EOPNOTSUPP)
-			pr_err("Failed to retrieve scheduler Rx interrupt\n");
+			pr_err("Failed to retrieve FF-A id %u interrupt\n", id);
 		return ret;
 	}
 
@@ -1329,12 +1342,12 @@ static int ffa_sched_recv_irq_map(void)
 
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
@@ -1355,15 +1368,29 @@ static void ffa_sched_recv_irq_unmap(void)
 	}
 }
 
+static void ffa_notif_pend_irq_unmap(void)
+{
+	if (drv_info->notif_pend_irq) {
+		irq_dispose_mapping(drv_info->notif_pend_irq);
+		drv_info->notif_pend_irq = 0;
+	}
+}
+
 static int ffa_cpuhp_pcpu_irq_enable(unsigned int cpu)
 {
-	enable_percpu_irq(drv_info->sched_recv_irq, IRQ_TYPE_NONE);
+	if (drv_info->sched_recv_irq)
+		enable_percpu_irq(drv_info->sched_recv_irq, IRQ_TYPE_NONE);
+	if (drv_info->notif_pend_irq)
+		enable_percpu_irq(drv_info->notif_pend_irq, IRQ_TYPE_NONE);
 	return 0;
 }
 
 static int ffa_cpuhp_pcpu_irq_disable(unsigned int cpu)
 {
-	disable_percpu_irq(drv_info->sched_recv_irq);
+	if (drv_info->sched_recv_irq)
+		disable_percpu_irq(drv_info->sched_recv_irq);
+	if (drv_info->notif_pend_irq)
+		disable_percpu_irq(drv_info->notif_pend_irq);
 	return 0;
 }
 
@@ -1382,13 +1409,16 @@ static void ffa_uninit_pcpu_irq(void)
 	if (drv_info->sched_recv_irq)
 		free_percpu_irq(drv_info->sched_recv_irq, drv_info->irq_pcpu);
 
+	if (drv_info->notif_pend_irq)
+		free_percpu_irq(drv_info->notif_pend_irq, drv_info->irq_pcpu);
+
 	if (drv_info->irq_pcpu) {
 		free_percpu(drv_info->irq_pcpu);
 		drv_info->irq_pcpu = NULL;
 	}
 }
 
-static int ffa_init_pcpu_irq(unsigned int irq)
+static int ffa_init_pcpu_irq(void)
 {
 	struct ffa_pcpu_irq __percpu *irq_pcpu;
 	int ret, cpu;
@@ -1402,13 +1432,29 @@ static int ffa_init_pcpu_irq(unsigned int irq)
 
 	drv_info->irq_pcpu = irq_pcpu;
 
-	ret = request_percpu_irq(irq, irq_handler, "ARM-FFA", irq_pcpu);
-	if (ret) {
-		pr_err("Error registering notification IRQ %d: %d\n", irq, ret);
-		return ret;
+	if (drv_info->sched_recv_irq) {
+		ret = request_percpu_irq(drv_info->sched_recv_irq,
+					 sched_recv_irq_handler,
+					 "ARM-FFA-SR", irq_pcpu);
+		if (ret) {
+			pr_err("Error registering schedule receiver nIRQ %d: %d\n",
+			       drv_info->sched_recv_irq, ret);
+			return ret;
+		}
+	}
+
+	if (drv_info->notif_pend_irq) {
+		ret = request_percpu_irq(drv_info->notif_pend_irq,
+					 notif_pend_irq_handler,
+					 "ARM-FFA-NP", irq_pcpu);
+		if (ret) {
+			pr_err("Error registering notification pendig nIRQ %d: %d\n",
+			       drv_info->notif_pend_irq, ret);
+			return ret;
+		}
 	}
 
-	INIT_WORK(&drv_info->irq_work, ffa_sched_recv_irq_work_fn);
+	INIT_WORK(&drv_info->sched_recv_irq_work, ffa_sched_recv_irq_work_fn);
 	INIT_WORK(&drv_info->notif_pcpu_work, notif_pcpu_irq_work_fn);
 	drv_info->notif_pcpu_wq = create_workqueue("ffa_pcpu_irq_notification");
 	if (!drv_info->notif_pcpu_wq)
@@ -1429,6 +1475,7 @@ static void ffa_notifications_cleanup(void)
 {
 	ffa_uninit_pcpu_irq();
 	ffa_sched_recv_irq_unmap();
+	ffa_notif_pend_irq_unmap();
 
 	if (drv_info->bitmap_created) {
 		ffa_notification_bitmap_destroy();
@@ -1439,30 +1486,30 @@ static void ffa_notifications_cleanup(void)
 
 static void ffa_notifications_setup(void)
 {
-	int ret, irq;
+	int ret;
 
 	ret = ffa_features(FFA_NOTIFICATION_BITMAP_CREATE, 0, NULL, NULL);
-	if (ret) {
-		pr_info("Notifications not supported, continuing with it ..\n");
-		return;
+	if (!ret) {
+		ret = ffa_notification_bitmap_create();
+		if (ret) {
+			pr_info("Notification bitmap create error %d\n", ret);
+			return;
+		}
+		drv_info->bitmap_created = true;
 	}
 
-	ret = ffa_notification_bitmap_create();
-	if (ret) {
-		pr_info("Notification bitmap create error %d\n", ret);
-		return;
-	}
-	drv_info->bitmap_created = true;
+	ret = ffa_irq_map(FFA_FEAT_SCHEDULE_RECEIVER_INT);
+	if (ret > 0)
+		drv_info->sched_recv_irq = ret;
 
-	irq = ffa_sched_recv_irq_map();
-	if (irq <= 0) {
-		ret = irq;
-		goto cleanup;
-	}
+	ret = ffa_irq_map(FFA_FEAT_NOTIFICATION_PENDING_INT);
+	if (ret > 0)
+		drv_info->notif_pend_irq = ret;
 
-	drv_info->sched_recv_irq = irq;
+	if (!drv_info->sched_recv_irq && !drv_info->notif_pend_irq)
+		goto cleanup;
 
-	ret = ffa_init_pcpu_irq(irq);
+	ret = ffa_init_pcpu_irq();
 	if (ret)
 		goto cleanup;
 
-- 
2.34.1


