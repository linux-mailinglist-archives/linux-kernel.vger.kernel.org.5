Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01DB75FE2F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjGXRpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjGXRod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:44:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B83B1BCC;
        Mon, 24 Jul 2023 10:44:10 -0700 (PDT)
Message-ID: <20230724172844.340632180@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kFimYBoIHtAuyZ0nV8lPkTq5OiYik0emivYDmavONE8=;
        b=FHSQZqpS7sWP+5YUx2FGrGYljE0lKjIgQY4afB+sXzC/VZrpgh7rB9EMOg8QFvkw5580Dn
        dtcdgZiuJ4a1aOkepaSI9XxLQYH1wcpcI0ZSM3jRBcn0wozHYoVI9JBTi4J1roSvxDBvVV
        akt7sqoODAodzSJXCXQpOIoYQHq/9AxI4FXOpUMCCX+hxePsARugQQZFiIvbrGIF0GrMdt
        TxNmElYghrqg39J7GZ1d42CbTXP/8PahwJuIbZQGiZJtOyhzk2TI429O/h68QC9eVWa1my
        EiH8jZZo1q7ffXtAAHiesDTIDfmxGhFswgkYgliEZ1fKlag77pN+oZx63MkJSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kFimYBoIHtAuyZ0nV8lPkTq5OiYik0emivYDmavONE8=;
        b=EbATRpE/8xzED6DWIRhPSb2e/h8GCTb7+yiecMEtS1UoIKniBJoOTHjfyt/7SRdxyziWvJ
        J/qZc/oGcq0nFZDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch 11/29] x86/cpu: Provide debug interface
References: <20230724155329.474037902@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 19:44:08 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide debug files which dump the topology related information of
cpuinfo_x86. This is useful to validate the upcoming conversion of the
topology evaluation for correctness or bug compatibility.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/Makefile  |    2 +
 arch/x86/kernel/cpu/debugfs.c |   59 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -54,6 +54,8 @@ obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr
 obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
 obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
 
+obj-$(CONFIG_DEBUG_FS)			+= debugfs.o
+
 quiet_cmd_mkcapflags = MKCAP   $@
       cmd_mkcapflags = $(CONFIG_SHELL) $(srctree)/$(src)/mkcapflags.sh $@ $^
 
--- /dev/null
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/debugfs.h>
+
+#include <asm/apic.h>
+#include <asm/processor.h>
+
+static int cpu_debug_show(struct seq_file *m, void *p)
+{
+	unsigned long cpu = (unsigned long)m->private;
+	struct cpuinfo_x86 *c;
+
+	if (!cpu_online(cpu))
+		return -ENODEV;
+
+	c = per_cpu_ptr(&cpu_info, cpu);
+
+	seq_printf(m, "initial_apicid:      %x\n", c->topo.initial_apicid);
+	seq_printf(m, "apicid:              %x\n", c->topo.apicid);
+	seq_printf(m, "pkg_id:              %u\n", c->topo.pkg_id);
+	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
+	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
+	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
+	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
+	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
+	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
+	seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
+	seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
+	seq_printf(m, "max_die_per_pkg:     %u\n", __max_die_per_package);
+	seq_printf(m, "smp_num_siblings:    %u\n", smp_num_siblings);
+	return 0;
+}
+
+static int cpu_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, cpu_debug_show, inode->i_private);
+}
+
+static const struct file_operations dfs_cpu_ops = {
+	.open		= cpu_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static __init int cpu_init_debugfs(void)
+{
+	struct dentry *dir, *base = debugfs_create_dir("topo", arch_debugfs_dir);
+	unsigned long id;
+	char name [10];
+
+	dir = debugfs_create_dir("cpus", base);
+	for_each_possible_cpu(id) {
+		sprintf(name, "%lu", id);
+		debugfs_create_file(name, 0444, dir, (void *)id, &dfs_cpu_ops);
+	}
+	return 0;
+}
+late_initcall(cpu_init_debugfs);

