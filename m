Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138C37F2EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjKUNoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjKUNoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:44:01 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B70D6C;
        Tue, 21 Nov 2023 05:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hwKW27BSIGP2vflIk8amXw2dHCnmehVyW/SsrBiOkzo=; b=bIssjw2/Mjk8O39ibBLN9vbHhT
        AO1nUkBs1ooF6MG5CJ/+2w24+qAMjviTQtWGFKqEDdKTV4mfY27SkS3FkOAOpHnW1PFOAD8uT8Zp2
        RqUVA7bBpUV1aLYNeMjvFHK/Y6exbo/7COEIWDUFiXkHTTXHvIgiaptrim4n/8jXT3TPoQjfRXQ7l
        JpGSMktyj8lalUTFrsiko8bqfDqQV8ukWVcE9pbN0rweblQxnwGyVjdtFNOWLix5HhWRbBwbrSbIS
        uo3sobHGnSt1GYpIyZKFfxg7SW9VyDL7qF27QbJRteFQQBvAu5VPaF/MQQs7p26MhAFKXqu2qBAbI
        Ff2RLkfA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:32876 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1r5R2e-000762-39;
        Tue, 21 Nov 2023 13:43:53 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1r5R2g-00CsyV-Ss; Tue, 21 Nov 2023 13:43:54 +0000
In-Reply-To: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
From:   Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 01/21] arch_topology: Make register_cpu_capacity_sysctl()
 tolerant to late CPUs
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5R2g-00CsyV-Ss@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 21 Nov 2023 13:43:54 +0000
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

register_cpu_capacity_sysctl() adds a property to sysfs that describes
the CPUs capacity. This is done from a subsys_initcall() that assumes
all possible CPUs are registered.

With CPU hotplug, possible CPUs aren't registered until they become
present, (or for arm64 enabled). This leads to messages during boot:
| register_cpu_capacity_sysctl: too early to get CPU1 device!
and once these CPUs are added to the system, the file is missing.

Move this to a cpuhp callback, so that the file is created once
CPUs are brought online. This covers CPUs that are added late by
mechanisms like hotplug.
One observable difference is the file is now missing for offline CPUs.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
If the offline CPUs thing is a problem for the tools that consume
this value, we'd need to move cpu_capacity to be part of cpu.c's
common_cpu_attr_groups. However, attempts to discuss this just end
up in a black hole, so this is a non-starter. Thus, if this needs
to be done, it can be done as a separate patch.
---
 drivers/base/arch_topology.c | 38 ++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index b741b5ba82bd..9ccb7daee78e 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -220,20 +220,34 @@ static DECLARE_WORK(update_topology_flags_work, update_topology_flags_workfn);
 
 static DEVICE_ATTR_RO(cpu_capacity);
 
-static int register_cpu_capacity_sysctl(void)
+static int cpu_capacity_sysctl_add(unsigned int cpu)
 {
-	int i;
-	struct device *cpu;
+	struct device *cpu_dev = get_cpu_device(cpu);
 
-	for_each_possible_cpu(i) {
-		cpu = get_cpu_device(i);
-		if (!cpu) {
-			pr_err("%s: too early to get CPU%d device!\n",
-			       __func__, i);
-			continue;
-		}
-		device_create_file(cpu, &dev_attr_cpu_capacity);
-	}
+	if (!cpu_dev)
+		return -ENOENT;
+
+	device_create_file(cpu_dev, &dev_attr_cpu_capacity);
+
+	return 0;
+}
+
+static int cpu_capacity_sysctl_remove(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+
+	if (!cpu_dev)
+		return -ENOENT;
+
+	device_remove_file(cpu_dev, &dev_attr_cpu_capacity);
+
+	return 0;
+}
+
+static int register_cpu_capacity_sysctl(void)
+{
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "topology/cpu-capacity",
+			  cpu_capacity_sysctl_add, cpu_capacity_sysctl_remove);
 
 	return 0;
 }
-- 
2.30.2

