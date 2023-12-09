Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0784780B1EF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 04:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjLIDqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 22:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIDqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 22:46:18 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08FB210E6;
        Fri,  8 Dec 2023 19:46:25 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5802320B74C0;
        Fri,  8 Dec 2023 19:46:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5802320B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1702093584;
        bh=CndfACro1vB4lqJpl3P/DHaR4O77a0Wj2l2e2pQn8hE=;
        h=From:To:Cc:Subject:Date:From;
        b=N1XGDzHmrjNwtgrvUfVz9ax9DqVgQnm1uI9kAMBPBmgegGR4k4LxktFm8eWq7h1dH
         wlX3aPIPKtFSYJcAGIfumerdUIFjbsppHq393Be3g3o5hfpSEAnqURpEaE7Hy+VmfP
         CmJqmLSbqhoRxZW0Szc/uBc/Hq1Ho6fC8A9N0NOY=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alexander.stein@ew.tq-group.com, ssengar@linux.microsoft.com,
        decui@microsoft.com
Subject: [PATCH] PCI/sysfs: Fix race in pci sysfs creation
Date:   Fri,  8 Dec 2023 19:46:16 -0800
Message-Id: <1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is a race in calling pci_create_resource_files function
from two different therads, first therad is triggered by pci_sysfs_init
from the late initcall where as the second thread is initiated by
pci_bus_add_devices from the respective PCI drivers probe.

The synchronization between these threads relies on the sysfs_initialized
flag. However, in pci_sysfs_init, sysfs_initialized is set right before
calling pci_create_resource_files which is wrong as it can create race
condition with pci_bus_add_devices threads. Fix this by setting
sysfs_initialized flag at the end of pci_sysfs_init and direecly call the
pci_create_resource_files function from it.

There can be an additional case where driver probe is so delayed that
pci_bus_add_devices is called after the sysfs is created by pci_sysfs_init.
In such cases, attempting to access already existing sysfs resources is
unnecessary. Fix this by adding a check for sysfs attributes and return
if they are already allocated.

In both cases, the consequence will be the removal of sysfs resources that
were appropriately allocated by pci_sysfs_init following the warning below.

[    3.376688] sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:07/VMBUS:01/47505500-0001-0000-3130-444531454238/pci0001:00/0001:00:00.0/resource0'
[    3.385103] CPU: 3 PID: 9 Comm: kworker/u8:0 Not tainted 5.15.0-1046-azure #53~20.04.1-Ubuntu
[    3.389585] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
[    3.394663] Workqueue: events_unbound async_run_entry_fn
[    3.397687] Call Trace:
[    3.399312]  <TASK>
[    3.400780]  dump_stack_lvl+0x38/0x4d
[    3.402998]  dump_stack+0x10/0x16
[    3.406050]  sysfs_warn_dup.cold+0x17/0x2b
[    3.408476]  sysfs_add_file_mode_ns+0x17b/0x190
[    3.411072]  sysfs_create_bin_file+0x64/0x90
[    3.413514]  pci_create_attr+0xc7/0x260
[    3.415827]  pci_create_resource_files+0x6f/0x150
[    3.418455]  pci_create_sysfs_dev_files+0x18/0x30
[    3.421136]  pci_bus_add_device+0x30/0x70
[    3.423512]  pci_bus_add_devices+0x31/0x70
[    3.425958]  hv_pci_probe+0x4ce/0x640
[    3.428106]  vmbus_probe+0x67/0x90
[    3.430121]  really_probe.part.0+0xcb/0x380
[    3.432516]  really_probe+0x40/0x80
[    3.434581]  __driver_probe_device+0xe8/0x140
[    3.437119]  driver_probe_device+0x23/0xb0
[    3.439504]  __driver_attach_async_helper+0x31/0x90
[    3.442296]  async_run_entry_fn+0x33/0x120
[    3.444666]  process_one_work+0x225/0x3d0
[    3.447043]  worker_thread+0x4d/0x3e0
[    3.449233]  ? process_one_work+0x3d0/0x3d0
[    3.451632]  kthread+0x12a/0x150
[    3.453583]  ? set_kthread_struct+0x50/0x50
[    3.456103]  ret_from_fork+0x22/0x30

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
There has been earlier attempts to fix this problem, below are the patches
for reference of these attempts.
1. https://lore.kernel.org/linux-pci/20230316103036.1837869-1-alexander.stein@ew.tq-group.com/T/#u
2. https://lwn.net/ml/linux-kernel/20230316091540.494366-1-alexander.stein@ew.tq-group.com/

Bug details: https://bugzilla.kernel.org/show_bug.cgi?id=215515

 drivers/pci/pci-sysfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f2909ae93f2f..a31f6f2cf309 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1230,6 +1230,10 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 		if (!pci_resource_len(pdev, i))
 			continue;
 
+		/* Check if resource already allocated and proceed no further */
+		if (pdev->res_attr[i] || pdev->res_attr_wc[i])
+			return 0;
+
 		retval = pci_create_attr(pdev, i, 0);
 		/* for prefetchable resources, create a WC mappable file */
 		if (!retval && arch_can_pci_mmap_wc() &&
@@ -1411,9 +1415,8 @@ static int __init pci_sysfs_init(void)
 	struct pci_bus *pbus = NULL;
 	int retval;
 
-	sysfs_initialized = 1;
 	for_each_pci_dev(pdev) {
-		retval = pci_create_sysfs_dev_files(pdev);
+		retval = pci_create_resource_files(pdev);
 		if (retval) {
 			pci_dev_put(pdev);
 			return retval;
@@ -1423,6 +1426,8 @@ static int __init pci_sysfs_init(void)
 	while ((pbus = pci_find_next_bus(pbus)))
 		pci_create_legacy_files(pbus);
 
+	sysfs_initialized = 1;
+
 	return 0;
 }
 late_initcall(pci_sysfs_init);
-- 
2.25.1

