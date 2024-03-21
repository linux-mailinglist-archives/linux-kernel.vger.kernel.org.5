Return-Path: <linux-kernel+bounces-109699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B5D881C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B021C20BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBE850249;
	Thu, 21 Mar 2024 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pyEQneVA"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03244D5B0;
	Thu, 21 Mar 2024 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003213; cv=fail; b=WBDoPMFSwEzXCb8AU8MBnVDFuoJtAlRLIiB+Sr543beLHS+3UrZLkOGY2nABchgv0E7QytxCz3qJcqjEAWIGe6gqW3pmStBBMx8KmWNJskLb3qr9JELQl9GLU1yr45kwb4I5GVmMCO9tE4hDUFsbRpR9TlwSDkW+dU5qYIZMCqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003213; c=relaxed/simple;
	bh=8ssqXe7/jUEMP3eJpTvqTb9uBoifA1wvz/Kim5TJqtg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YVTvN+CC17GlTAOfYm2NaK3HO9ZjAgtmKBzR45BWysHF/lbqRbXRCAcm0xoZqcA4LLkeGbv6qXDAph5I5PVd0hhsii+0kEIePyMYGU36GtvqQOaGJD+rbUdC2PZDlkRTTq3psbo2tzlNUMsX25EUUUFxSxGyef8PwRuf3GVdsMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pyEQneVA; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENITnfIVMeJjDf7/Fm6ZAUIK35XfYJvkuAKB1EBeK8ItjinEx/B/gYlvHuTeNHUenS+9lp1oCYVzLJ4LBq+P3fcCoCutUVNTwLBkPMk64AMlnbxmTXS4uGoe07aMZbjuW0iIMPYHDaidhNfDW+uP7VcFk9C0Ss7q+eym6I4zXUKVsBxyq4t4ervyzYBT5bsbAPzuHlSirZjeW3x5mQSDyxQypn7G81HSMOpD6aPybrg4LWlSC0zN/jA0WXfaz2fFCj1iF6CJ8ZB4FCvqCOfOR8Utgi/BXnyU2+6yNKyt6+jUsE2cAjBwlaDHaj4NI3ejfflfki/EFJMsnQchMw7yoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhFrfR5HruaKH12AfRpYgs7Ch6unS5iggFGuNLcDgQA=;
 b=iR6w2kjiyd39Z/3il0UsEDDALpSK1fG7oVOK7VL20ec0qtcxCFeARsnFl6H625s5y4os3b3pPQ3YHKeSevkrxsOvshefTCrY3TaqlTOnwVHTOwWJA7Wb09Wd0UAPBZ+PkeDxmZrcQHNgttrC+94RKZNeRFFWr6Jn4jbJdXi5HXvsc8MWngZ4oASpJh/wHpjhkiBAkIHiNOdCejST1xXlahL1fYAWXdyGb3CI1FmwF9yUJvLtuGwcSpjq5ISQ37oYdN7abwzjJSxYTjrRZZSdnNAWs0HPVmjkM/SukJl+oD/QqKWPV95jTIU4p3FxrDeG0nM7joGQbFL4HBbcXxc8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhFrfR5HruaKH12AfRpYgs7Ch6unS5iggFGuNLcDgQA=;
 b=pyEQneVAsqimp98eDLLjite0cIIdD8RvHn9aw8nCy3MVf2TqrPHCAfNIZADRxP7Fflpf77LY86uM60Wa+kZ6Lv9txEz7+ja+8qyyffArn19+GgX2D6nHHKQf6Qv+5CrDSeqLN9NPKqN6oST+yR3+PqmIQWebHIlCppiaapW/cnw=
Received: from BYAPR21CA0013.namprd21.prod.outlook.com (2603:10b6:a03:114::23)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 06:40:08 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::ae) by BYAPR21CA0013.outlook.office365.com
 (2603:10b6:a03:114::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.9 via Frontend
 Transport; Thu, 21 Mar 2024 06:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 06:40:07 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 01:40:05 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net] pds_core: Fix pdsc_check_pci_health function to print warning
Date: Wed, 20 Mar 2024 23:39:54 -0700
Message-ID: <20240321063954.18711-1-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3c2490-fe3d-4070-3174-08dc4971bfeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	luWdq5D2mQawkmwKtkoEWon1vncI8MrMIW5Ff9njOPni5q+jH2Oq0B+DsyAhReVzOSEa0kLrHJeBf3v+VgOVe1G8FklEBV6SKZ7lj/d1yIlZOYeN8kVGp+s6ua0s7XBq3F2l04iu9kKCg2bAKM/UOetkfd2AxbZjNYGb0q17aePLyzXVQAcILexJEbNek9+Ophq6+nOocu0oJIofrIgjHukllDzcn8jr41fTthB4xv6jkog5yPgOOrsIQKMm57moi3zOHMCz517vX49qSG40I3MnrBR48ullAr1s6KFuIwQjWW8VxE3ZFF6BMERla7LOUDEmrSPQDQWAQPSRN5rq/2ZbzpIwYdlhu8COv5AgWOFOnsVo8E4Lbx3GDulHwJ+xWBc3Ry9XUMibfcK8BDp9wLG1wWCUbIzFu9N037VBM0GBXpk0xqgvRZOYzQd2/K5GMLUAzop+s0xcVbyfZWOsuQyC8iXYHXYmu2s2VSzIfGyOJCnm0xnOfHpVLK27eE9ev0KucqLBlNSbUe0cOPUEoLjP0mBE05Ojv7LKQyWfYoczYi5aSOmIFD0+W4mOheKJNTKXpGyI+29yrWOHfRfXZgJDtowkUQfKYJMXWkeltuc/+WofSYgLvMofUAqiEG1H51OnQoMipKW/kmlngNoL+6zqepk8ESTCvQJt/FVx4ny1SJF3V016qd4Tp5JST8ZHDnBLIijV58DZWXS+DPEu2vKQ7uySRWezcekCbNsvAHPgSPjii9hXtGBGqVuUljP/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 06:40:07.8355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3c2490-fe3d-4070-3174-08dc4971bfeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323

When the driver notices fw_status == 0xff it tries to perform a PCI
reset on itself via pci_reset_function() in the context of the driver's
health thread. However, pdsc_reset_prepare calls
pdsc_stop_health_thread(), which attempts to stop/flush the health
thread. This results in a deadlock because the stop/flush will never
complete since the driver called pci_reset_function() from the health
thread context. Fix this by changing the pdsc_check_pci_health_function()
to print a dev_warn() once every fw_down/fw_up cycle and requiring the
user to perform a reset on the device via sysfs's reset interface,
reloading the driver, rebinding the device, etc.

Unloading the driver in the fw_down/dead state uncovered another issue,
which can be seen in the following trace:

WARNING: CPU: 51 PID: 6914 at kernel/workqueue.c:1450 __queue_work+0x358/0x440
[...]
RIP: 0010:__queue_work+0x358/0x440
[...]
Call Trace:
 <TASK>
 ? __warn+0x85/0x140
 ? __queue_work+0x358/0x440
 ? report_bug+0xfc/0x1e0
 ? handle_bug+0x3f/0x70
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? __queue_work+0x358/0x440
 queue_work_on+0x28/0x30
 pdsc_devcmd_locked+0x96/0xe0 [pds_core]
 pdsc_devcmd_reset+0x71/0xb0 [pds_core]
 pdsc_teardown+0x51/0xe0 [pds_core]
 pdsc_remove+0x106/0x200 [pds_core]
 pci_device_remove+0x37/0xc0
 device_release_driver_internal+0xae/0x140
 driver_detach+0x48/0x90
 bus_remove_driver+0x6d/0xf0
 pci_unregister_driver+0x2e/0xa0
 pdsc_cleanup_module+0x10/0x780 [pds_core]
 __x64_sys_delete_module+0x142/0x2b0
 ? syscall_trace_enter.isra.18+0x126/0x1a0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7fbd9d03a14b
[...]

Fix this by preventing the devcmd reset if the FW is not running.

Fixes: d9407ff11809 ("pds_core: Prevent health thread from running during reset/remove")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 9 ++++++++-
 drivers/net/ethernet/amd/pds_core/core.h | 1 +
 drivers/net/ethernet/amd/pds_core/dev.c  | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 9662ee72814c..8e5e3797cf0c 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -587,6 +587,9 @@ void pdsc_fw_up(struct pdsc *pdsc)
 						     DEVLINK_HEALTH_REPORTER_STATE_HEALTHY);
 	pdsc_notify(PDS_EVENT_RESET, &reset_event);
 
+	/* Allow for fw_status == 0xff to print another warning */
+	pdsc->bad_pci_warned = false;
+
 	return;
 
 err_out:
@@ -607,7 +610,11 @@ static void pdsc_check_pci_health(struct pdsc *pdsc)
 	if (fw_status != PDS_RC_BAD_PCI)
 		return;
 
-	pci_reset_function(pdsc->pdev);
+	if (!pdsc->bad_pci_warned) {
+		dev_warn(pdsc->dev, "fw not reachable due to failed PCI connection, fw_status = 0x%x\n",
+			 fw_status);
+		pdsc->bad_pci_warned = true;
+	}
 }
 
 void pdsc_health_thread(struct work_struct *work)
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 92d7657dd614..10979118be00 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -165,6 +165,7 @@ struct pdsc {
 	unsigned long state;
 	u8 fw_status;
 	u8 fw_generation;
+	bool bad_pci_warned;
 	unsigned long last_fw_time;
 	u32 last_hb;
 	struct timer_list wdtimer;
diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index e494e1298dc9..495ef4ef8c10 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -229,6 +229,9 @@ int pdsc_devcmd_reset(struct pdsc *pdsc)
 		.reset.opcode = PDS_CORE_CMD_RESET,
 	};
 
+	if (!pdsc_is_fw_running(pdsc))
+		return 0;
+
 	return pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
 }
 
-- 
2.17.1


