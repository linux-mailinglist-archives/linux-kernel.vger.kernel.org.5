Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6141181121A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379138AbjLMMw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379040AbjLMMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:52:01 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE0F198;
        Wed, 13 Dec 2023 04:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4ff4rMpb4e8+j2FVzHVtwCCPXNpYraqqrJVEXYQ7zus=; b=FTxlsm7nMbZ2auwIoWztzjGrLr
        eJ/+UAL4mRlb+xzpeos7afUrQbA793swTrEBkQs15e6/U2pZQzuZK+w+1AHJpkI3HfUJGZEjFm/Kp
        W9jVCjZgcW9jZXNT7d7yYBD6uXj3FP+JGLZOMl2DiqfJobHMrn+f2Rn1YL+OviAx4TvVtCo8v3NhG
        ha0rLs1UNyB4oOrGfMvPk8nj7AxLUehHcXG4csWrXQ+KZWl07iCkmqKO7r4ZhGqDaej9rOshtXdE9
        mIEiNCaE7QZ92nAimpN8JuMZiod0x/DZEKdfe4Kl4qSvzrc78tI8xR7PubiPehT6ssECE39vdnOjp
        zzmnovvQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33330 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1rDOhV-0008IF-1A;
        Wed, 13 Dec 2023 12:50:57 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1rDOhX-00Dvlg-Ci; Wed, 13 Dec 2023 12:50:59 +0000
In-Reply-To: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
From:   Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>
Subject: [PATCH RFC v3 21/21] cpumask: Add enabled cpumask for present CPUs
 that can be brought online
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rDOhX-00Dvlg-Ci@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Wed, 13 Dec 2023 12:50:59 +0000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

The 'offline' file in sysfs shows all offline CPUs, including those
that aren't present. User-space is expected to remove not-present CPUs
from this list to learn which CPUs could be brought online.

CPUs can be present but not-enabled. These CPUs can't be brought online
until the firmware policy changes, which comes with an ACPI notification
that will register the CPUs.

With only the offline and present files, user-space is unable to
determine which CPUs it can try to bring online. Add a new CPU mask
that shows this based on all the registered CPUs.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
---
Outstanding comment:
 https://lore.kernel.org/r/20230914175443.000038f6@Huawei.com
---
 drivers/base/cpu.c      | 10 ++++++++++
 include/linux/cpumask.h | 25 +++++++++++++++++++++++++
 kernel/cpu.c            |  3 +++
 3 files changed, 38 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 13d052bf13f4..a6e96a0a92b7 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -95,6 +95,7 @@ void unregister_cpu(struct cpu *cpu)
 {
 	int logical_cpu = cpu->dev.id;
 
+	set_cpu_enabled(logical_cpu, false);
 	unregister_cpu_under_node(logical_cpu, cpu_to_node(logical_cpu));
 
 	device_unregister(&cpu->dev);
@@ -273,6 +274,13 @@ static ssize_t print_cpus_offline(struct device *dev,
 }
 static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
 
+static ssize_t print_cpus_enabled(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_enabled_mask));
+}
+static DEVICE_ATTR(enabled, 0444, print_cpus_enabled, NULL);
+
 static ssize_t print_cpus_isolated(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -413,6 +421,7 @@ int register_cpu(struct cpu *cpu, int num)
 	register_cpu_under_node(num, cpu_to_node(num));
 	dev_pm_qos_expose_latency_limit(&cpu->dev,
 					PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
+	set_cpu_enabled(num, true);
 
 	return 0;
 }
@@ -494,6 +503,7 @@ static struct attribute *cpu_root_attrs[] = {
 	&cpu_attrs[2].attr.attr,
 	&dev_attr_kernel_max.attr,
 	&dev_attr_offline.attr,
+	&dev_attr_enabled.attr,
 	&dev_attr_isolated.attr,
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index cfb545841a2c..cc72a0887f04 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -92,6 +92,7 @@ static inline void set_nr_cpu_ids(unsigned int nr)
  *
  *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
  *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
+ *     cpu_enabled_mask  - has bit 'cpu' set iff cpu can be brought online
  *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
  *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
  *
@@ -124,11 +125,13 @@ static inline void set_nr_cpu_ids(unsigned int nr)
 
 extern struct cpumask __cpu_possible_mask;
 extern struct cpumask __cpu_online_mask;
+extern struct cpumask __cpu_enabled_mask;
 extern struct cpumask __cpu_present_mask;
 extern struct cpumask __cpu_active_mask;
 extern struct cpumask __cpu_dying_mask;
 #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
 #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
+#define cpu_enabled_mask   ((const struct cpumask *)&__cpu_enabled_mask)
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
 #define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
@@ -993,6 +996,7 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
 #else
 #define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_possible_mask)
 #define for_each_online_cpu(cpu)   for_each_cpu((cpu), cpu_online_mask)
+#define for_each_enabled_cpu(cpu)   for_each_cpu((cpu), cpu_enabled_mask)
 #define for_each_present_cpu(cpu)  for_each_cpu((cpu), cpu_present_mask)
 #endif
 
@@ -1015,6 +1019,15 @@ set_cpu_possible(unsigned int cpu, bool possible)
 		cpumask_clear_cpu(cpu, &__cpu_possible_mask);
 }
 
+static inline void
+set_cpu_enabled(unsigned int cpu, bool can_be_onlined)
+{
+	if (can_be_onlined)
+		cpumask_set_cpu(cpu, &__cpu_enabled_mask);
+	else
+		cpumask_clear_cpu(cpu, &__cpu_enabled_mask);
+}
+
 static inline void
 set_cpu_present(unsigned int cpu, bool present)
 {
@@ -1096,6 +1109,7 @@ static __always_inline unsigned int num_online_cpus(void)
 	return raw_atomic_read(&__num_online_cpus);
 }
 #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
+#define num_enabled_cpus()	cpumask_weight(cpu_enabled_mask)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
 
@@ -1104,6 +1118,11 @@ static inline bool cpu_online(unsigned int cpu)
 	return cpumask_test_cpu(cpu, cpu_online_mask);
 }
 
+static inline bool cpu_enabled(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_enabled_mask);
+}
+
 static inline bool cpu_possible(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_possible_mask);
@@ -1128,6 +1147,7 @@ static inline bool cpu_dying(unsigned int cpu)
 
 #define num_online_cpus()	1U
 #define num_possible_cpus()	1U
+#define num_enabled_cpus()	1U
 #define num_present_cpus()	1U
 #define num_active_cpus()	1U
 
@@ -1141,6 +1161,11 @@ static inline bool cpu_possible(unsigned int cpu)
 	return cpu == 0;
 }
 
+static inline bool cpu_enabled(unsigned int cpu)
+{
+	return cpu == 0;
+}
+
 static inline bool cpu_present(unsigned int cpu)
 {
 	return cpu == 0;
diff --git a/kernel/cpu.c b/kernel/cpu.c
index a86972a91991..fe0a5189f8ae 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3122,6 +3122,9 @@ EXPORT_SYMBOL(__cpu_possible_mask);
 struct cpumask __cpu_online_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_online_mask);
 
+struct cpumask __cpu_enabled_mask __read_mostly;
+EXPORT_SYMBOL(__cpu_enabled_mask);
+
 struct cpumask __cpu_present_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_present_mask);
 
-- 
2.30.2

