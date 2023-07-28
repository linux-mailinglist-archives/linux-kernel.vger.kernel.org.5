Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2640B7665F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjG1H6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjG1H55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:57:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD073582;
        Fri, 28 Jul 2023 00:57:55 -0700 (PDT)
Date:   Fri, 28 Jul 2023 07:57:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690531074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KOY/ifMv0IFsm2klg1jUCE6shBdji3sg4zG5RdEszdA=;
        b=e/NyTpzcyL99C7i2jm7mtJDT3xb/iWIbNN/yIl6W4as/2aSA6B0t8o+mJeYpF8JHb1tor9
        AtY/fW+KPZs3Z5F+LN+7mnXe8bDLjmR27SO7wHJ2/ZYSfQTGR0Pa3Tup/CLHzayMBtG5yz
        LDGiXTXAxvNTJ8PV2i5Mb4KS86von+cQ/tu2Ueg3qjovgIynyKoK5i+ldJuMbjsih24qs3
        juI8CWk2jnbUtF6yDEqHPi5ZJ7S0RBeWoR1Auf0SPVOhwZfl/08Sva32p2F0ypxqTQ/DOa
        q2PedQ65MJSMfGnYeCp6ayXyY92PYPtvP1ybOYlUs7mLYIYNUezZMuAkqKDB5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690531074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KOY/ifMv0IFsm2klg1jUCE6shBdji3sg4zG5RdEszdA=;
        b=i7tl3fWsTnUe/f4BO/RnnK4V4CnY2cENTWGhA5upS5vBYaCIo65ZrBEcAbDo9k6X3gQavW
        Zxpw2QWfG0+SUPBg==
From:   "tip-bot2 for Michael Ellerman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/SMT: Allow enabling partial SMT states via sysfs
Cc:     kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230705145143.40545-8-ldufour@linux.ibm.com>
References: <20230705145143.40545-8-ldufour@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <169053107324.28540.4463820139250826908.tip-bot2@tip-bot2>
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

Commit-ID:     7f48405c3c3437d578d0f1e4287aa0a3bfa5623f
Gitweb:        https://git.kernel.org/tip/7f48405c3c3437d578d0f1e4287aa0a3bfa5623f
Author:        Michael Ellerman <mpe@ellerman.id.au>
AuthorDate:    Wed, 05 Jul 2023 16:51:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 28 Jul 2023 09:53:37 +02:00

cpu/SMT: Allow enabling partial SMT states via sysfs

Add support to the /sys/devices/system/cpu/smt/control interface for
enabling a specified number of SMT threads per core, including partial
SMT states where not all threads are brought online.

The current interface accepts "on" and "off", to enable either 1 or all
SMT threads per core.

This commit allows writing an integer, between 1 and the number of SMT
threads supported by the machine. Writing 1 is a synonym for "off", 2 or
more enables SMT with the specified number of threads.

When reading the file, if all threads are online "on" is returned, to
avoid changing behaviour for existing users. If some other number of
threads is online then the integer value is returned.

Architectures like x86 only supporting 1 thread or all threads, should not
define CONFIG_SMT_NUM_THREADS_DYNAMIC. Architecture supporting partial SMT
states, like PowerPC, should define it.

[ ldufour: Slightly reword the commit's description ]
[ ldufour: Remove switch() in __store_smt_control() ]
[ ldufour: Rix build issue in control_show() ]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230705145143.40545-8-ldufour@linux.ibm.com
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |  1 +-
 kernel/cpu.c                                       | 60 +++++++++----
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index ecd585c..6dba65f 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -555,6 +555,7 @@ Description:	Control Symmetric Multi Threading (SMT)
 			 ================ =========================================
 			 "on"		  SMT is enabled
 			 "off"		  SMT is disabled
+			 "<N>"		  SMT is enabled with N threads per core.
 			 "forceoff"	  SMT is force disabled. Cannot be changed.
 			 "notsupported"   SMT is not supported by the CPU
 			 "notimplemented" SMT runtime toggling is not
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9a8d068..7e8f1b0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2876,11 +2876,19 @@ static const struct attribute_group cpuhp_cpu_root_attr_group = {
 
 #ifdef CONFIG_HOTPLUG_SMT
 
+static bool cpu_smt_num_threads_valid(unsigned int threads)
+{
+	if (IS_ENABLED(CONFIG_SMT_NUM_THREADS_DYNAMIC))
+		return threads >= 1 && threads <= cpu_smt_max_threads;
+	return threads == 1 || threads == cpu_smt_max_threads;
+}
+
 static ssize_t
 __store_smt_control(struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
-	int ctrlval, ret;
+	int ctrlval, ret, num_threads, orig_threads;
+	bool force_off;
 
 	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
 		return -EPERM;
@@ -2888,30 +2896,39 @@ __store_smt_control(struct device *dev, struct device_attribute *attr,
 	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
 		return -ENODEV;
 
-	if (sysfs_streq(buf, "on"))
+	if (sysfs_streq(buf, "on")) {
 		ctrlval = CPU_SMT_ENABLED;
-	else if (sysfs_streq(buf, "off"))
+		num_threads = cpu_smt_max_threads;
+	} else if (sysfs_streq(buf, "off")) {
 		ctrlval = CPU_SMT_DISABLED;
-	else if (sysfs_streq(buf, "forceoff"))
+		num_threads = 1;
+	} else if (sysfs_streq(buf, "forceoff")) {
 		ctrlval = CPU_SMT_FORCE_DISABLED;
-	else
+		num_threads = 1;
+	} else if (kstrtoint(buf, 10, &num_threads) == 0) {
+		if (num_threads == 1)
+			ctrlval = CPU_SMT_DISABLED;
+		else if (cpu_smt_num_threads_valid(num_threads))
+			ctrlval = CPU_SMT_ENABLED;
+		else
+			return -EINVAL;
+	} else {
 		return -EINVAL;
+	}
 
 	ret = lock_device_hotplug_sysfs();
 	if (ret)
 		return ret;
 
-	if (ctrlval != cpu_smt_control) {
-		switch (ctrlval) {
-		case CPU_SMT_ENABLED:
-			ret = cpuhp_smt_enable();
-			break;
-		case CPU_SMT_DISABLED:
-		case CPU_SMT_FORCE_DISABLED:
-			ret = cpuhp_smt_disable(ctrlval);
-			break;
-		}
-	}
+	orig_threads = cpu_smt_num_threads;
+	cpu_smt_num_threads = num_threads;
+
+	force_off = ctrlval != cpu_smt_control && ctrlval == CPU_SMT_FORCE_DISABLED;
+
+	if (num_threads > orig_threads)
+		ret = cpuhp_smt_enable();
+	else if (num_threads < orig_threads || force_off)
+		ret = cpuhp_smt_disable(ctrlval);
 
 	unlock_device_hotplug();
 	return ret ? ret : count;
@@ -2939,6 +2956,17 @@ static ssize_t control_show(struct device *dev,
 {
 	const char *state = smt_states[cpu_smt_control];
 
+#ifdef CONFIG_HOTPLUG_SMT
+	/*
+	 * If SMT is enabled but not all threads are enabled then show the
+	 * number of threads. If all threads are enabled show "on". Otherwise
+	 * show the state name.
+	 */
+	if (cpu_smt_control == CPU_SMT_ENABLED &&
+	    cpu_smt_num_threads != cpu_smt_max_threads)
+		return sysfs_emit(buf, "%d\n", cpu_smt_num_threads);
+#endif
+
 	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
 }
 
