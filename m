Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C607665F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjG1H6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjG1H56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:57:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C313592;
        Fri, 28 Jul 2023 00:57:56 -0700 (PDT)
Date:   Fri, 28 Jul 2023 07:57:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690531075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o65O6jfSAQQ9detRSVb9guKnguVVbBbTifDqM3TmOxY=;
        b=YoIAyuCYItr85zeKCjdVgYyT8ppWFejJ14WcuJeCGdqVpuT+uzYGcRDvqPBu7IaIHlWQPO
        5S8KfvXVMCxHEHkWVdZt4FC7kob5NpzaKmlZcGIGmZrb5lyUAPsHa0svElaW6vFNKkYAw4
        VM0r0YwZwHYSeroqIijTuQ0KPEHeyQ95bBsogTTHZIjBIHVE6o+U2WprOsjUX21dJoVn38
        Nhd2KdsRedUpt7Nzh0rDOAul1v0Kau5YrZKDq6pWUNtKgRV9DXw0CbsBw2YyEPfOef3+kg
        7cR+hRo1PmMh3LkuVmJyx+X5Mj56SoZFNL3onkUhskWyrCzOL8f57BKD9/Qqbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690531075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o65O6jfSAQQ9detRSVb9guKnguVVbBbTifDqM3TmOxY=;
        b=LrTdfq1f6UsJ5C2DmQf75rA9WwZXNmBb0qNtO900Boch8RJ7xUU6JEdtyR9pL0g5nWV/OC
        sjl2+4ohUgHPT1DQ==
From:   "tip-bot2 for Michael Ellerman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/SMT: Move smt/control simple exit cases earlier
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230705145143.40545-4-ldufour@linux.ibm.com>
References: <20230705145143.40545-4-ldufour@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <169053107483.28540.2683617765976319627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     c53361ce7d8771129c517dca529d2f2dc5bf04d1
Gitweb:        https://git.kernel.org/tip/c53361ce7d8771129c517dca529d2f2dc5bf04d1
Author:        Michael Ellerman <mpe@ellerman.id.au>
AuthorDate:    Wed, 05 Jul 2023 16:51:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 28 Jul 2023 09:53:36 +02:00

cpu/SMT: Move smt/control simple exit cases earlier

Move the simple exit cases, i.e. those which don't depend on the value
written, earlier in the function. That makes it clearer that regardless of
the input those states cannot be transitioned out of.

That does have a user-visible effect, in that the error returned will
now always be EPERM/ENODEV for those states, regardless of the value
written. Previously writing an invalid value would return EINVAL even
when in those states.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230705145143.40545-4-ldufour@linux.ibm.com

---
 kernel/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index e02204c..b6fe170 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2841,6 +2841,12 @@ __store_smt_control(struct device *dev, struct device_attribute *attr,
 {
 	int ctrlval, ret;
 
+	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
+		return -EPERM;
+
+	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
+		return -ENODEV;
+
 	if (sysfs_streq(buf, "on"))
 		ctrlval = CPU_SMT_ENABLED;
 	else if (sysfs_streq(buf, "off"))
@@ -2850,12 +2856,6 @@ __store_smt_control(struct device *dev, struct device_attribute *attr,
 	else
 		return -EINVAL;
 
-	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
-		return -EPERM;
-
-	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
-		return -ENODEV;
-
 	ret = lock_device_hotplug_sysfs();
 	if (ret)
 		return ret;
