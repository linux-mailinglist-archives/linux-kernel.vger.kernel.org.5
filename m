Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C10075FA07
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjGXOkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjGXOkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B3E191
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690209556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4DnbSlRPxCAiRAkXuGQ4XsCVvGioPwgIXlHHcc4Hw+w=;
        b=a8Ir3+a2Ovcgku1IJ4baAKkvjHBzoJqZCL0CrFwt1c6jD/qPZeWmdJUrqjRlRJTVVaXL4G
        UpWbMDxDGC0iXD8ImXDWT2bUg/LMQC8T7pQAjZ/cszEYU8Wl0I3PZInt6GZTKR6cXm6Fuj
        0pfmGntB3GO3QmeqcxyQU3a+9MzvlOg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-BEAYBtboM3eBxa1fKg_kiw-1; Mon, 24 Jul 2023 10:39:14 -0400
X-MC-Unique: BEAYBtboM3eBxa1fKg_kiw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32E16280D21A;
        Mon, 24 Jul 2023 14:39:14 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD1EE200BA63;
        Mon, 24 Jul 2023 14:39:13 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Vishal Agrawal <vagrawal@redhat.com>,
        Joe Mario <jmario@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH] driver/base/cpu: Retry online operation if -EBUSY
Date:   Mon, 24 Jul 2023 10:38:26 -0400
Message-Id: <20230724143826.3996163-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting the kernel with "maxcpus=1" is a common technique for CPU
partitioning and isolation. It delays the CPU bringup process until
when the bootup scripts are ready to bring CPUs online by writing 1 to
/sys/device/system/cpu/cpu<X>/online. However, it was found that not
all the CPUs were online after bootup. The collection of offline CPUs
are different after every reboot.

Further investigation reveals that some "online" write operations
fail with an -EBUSY error. This error is returned when CPU hotplug is
temporiarly disabled when cpu_hotplug_disable() is called.

During bootup, the main caller of cpu_hotplug_disable() is
pci_call_probe() for PCI device initialization. By measuring the times
spent with cpu_hotplug_disabled set in a typical 2-socket server, most
of them last less than 10ms.  However, there are a few that can last
hundreds of ms. Note that the cpu_hotplug_disabled period of different
devices can overlap leading to longer cpu_hotplug_disabled hold time.

Since the CPU hotplug disable condition is transient and it is not
that easy to modify all the existing bootup scripts to handle this
condition, the kernel can help by retrying the online operation when
an -EBUSY error is returned. This patch retries the online operation
in cpu_subsys_online() when an -EBUSY error is returned for up to 5
times after an exponentially increasing delay that can last a total of
at least 620ms of waiting time by calling msleep().

With this patch in place, booting up the patched kernel with "maxcpus=1"
does not leave any CPU in an offline state in 10 reboot attempts.

Reported-by: Vishal Agrawal <vagrawal@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/base/cpu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c1815b9dae68..4b828f54f9f4 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -19,6 +19,7 @@
 #include <linux/cpufeature.h>
 #include <linux/tick.h>
 #include <linux/pm_qos.h>
+#include <linux/delay.h>
 #include <linux/sched/isolation.h>
 
 #include "base.h"
@@ -50,12 +51,30 @@ static int cpu_subsys_online(struct device *dev)
 	int cpuid = dev->id;
 	int from_nid, to_nid;
 	int ret;
+	int retries = 0;
 
 	from_nid = cpu_to_node(cpuid);
 	if (from_nid == NUMA_NO_NODE)
 		return -ENODEV;
 
+retry:
 	ret = cpu_device_up(dev);
+
+	/*
+	 * If -EBUSY is returned, it is likely that hotplug is temporarily
+	 * disabled when cpu_hotplug_disable() was called. This condition is
+	 * transient. So we retry after waiting for an exponentially
+	 * increasing delay up to a total of at least 620ms as some PCI
+	 * device initialization can take quite a while.
+	 */
+	if (ret == -EBUSY) {
+		retries++;
+		if (retries > 5)
+			return ret;
+		msleep(10 * (1 << retries));
+		goto retry;
+	}
+
 	/*
 	 * When hot adding memory to memoryless node and enabling a cpu
 	 * on the node, node number of the cpu may internally change.
-- 
2.31.1

