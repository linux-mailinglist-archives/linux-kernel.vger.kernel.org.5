Return-Path: <linux-kernel+bounces-156894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B548B0A03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5524D1F23FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E3215ADAD;
	Wed, 24 Apr 2024 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R6eHZM6j"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF9515A49B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962969; cv=fail; b=AqC/U3D+MvRUflb0XNEWiB+Otoi+SbD7siKgf7QB8K6+kGHogkhNHh9HNdAQzHQc4SUWYF5si3C+bETrqiFUmTE0j+YbxQ2uXcJZpS1p7ZCGB63QXLo98jAcC5HbZas5Yx8sRAF187dhcRYW+I/87MRf6kZkp6w2USDrBusagx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962969; c=relaxed/simple;
	bh=mRIlCsVpGcZFC7/KwVG5xiC1hh32FQx36CHt2a3zOnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A87Dk60UZq8djoXcubS11gOnJF9sse/BS2plcc2IboAWLQg8pCTRqykDuRclu/0eczWsCcxFrmp4hDRMAcBx+nQPwdkzzFL6EjJMvHjvqgV4fZ5rW6EDwEyzgyc0FFvj9kFeY3mA4M7jvKwiH2qNRXLRXK+0XXh2NSZjDDdwitA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R6eHZM6j; arc=fail smtp.client-ip=40.107.102.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhVDwznCszYV5Y3CG7mBSqJ7awyEtvqMsdX+t0GHD1kwfVyd2HQlAzV9wbwE8F54nCKsqPqqEjhqZqHbp89BW7YJIL5N7tWME7H9+gZTicomgQrFCSV8LtS/GOqnb4IwQOoLpiDmUlDKmldixrxBNEoHCTzhDpzLPwGLhoBcO9Ac6IdWEKYHIklSB/Iov4+UcN65ev7wQP33L9Y3dZjXsXdKii8nwSNNCxnRKuha258Ni/FDxXO+N3ogr5SIp3NbyZNXB/bs2NeSli7f3c1uc2wtUvLLFvigJwcVYujYx1Eg+Kv4gROpBRmqMhGhA0PlnRMgZyRHis7eBcBMaHgQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Qe0izDaIQhGBsZ0Er0dpOYNE7faXuBTz6A7oF108q4=;
 b=UafJRZMW66vb1OO1apMJ1+c4Fyjt7TF8qo1rQrN63wQBvzja9usbaqfky9ZTNPuq+h/RVXpjEc2Q7N1u8jOpWUWZxMC4IpsyYC2V8rgcWY7zFlbYHbq98Lg/8Ot3N0rH0x8vMUmMW1TdONYTR3qnNgGEFA6PvMHd62S7D5cfiDpcYlTdjLzpOK/YQ5BxHNMhkNEueH+aJh4u/NEQ83vvmAlKCqdjpONoKRL/9JNlEzgf5JKaMZl4UXtKHYqcfT9lQFhQLDTNKVhSQ6/Ypw7D+VGT+AlNs9unEVMas7OMFp9SxT/yPf4vL1GYsI6yXz1BpPGN7xGbFRTg4msArdlj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Qe0izDaIQhGBsZ0Er0dpOYNE7faXuBTz6A7oF108q4=;
 b=R6eHZM6jGK0Uyz2iXqRdgg/HLHDARhgXMMWp6bQynR2AK8l1WJE77UicUYYsgNFmSrbIVVUU0LEeO/FtQ4VWv16alNrIcNiqgSYE3jLow5HF/bRD3JzAxP/37hpnvxIM9sXKJI84r+hphSAPFQRvJHVDta0hJd8po8fBPnOZFT8=
Received: from SA1P222CA0097.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::24)
 by PH8PR12MB7327.namprd12.prod.outlook.com (2603:10b6:510:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 12:49:24 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::4b) by SA1P222CA0097.outlook.office365.com
 (2603:10b6:806:35e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 12:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 12:49:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 07:49:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 07:49:23 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 07:49:22 -0500
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: <michal.simek@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v2] soc: xilinx: Add cb event for subsystem restart
Date: Wed, 24 Apr 2024 05:49:00 -0700
Message-ID: <20240424124900.29287-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240424095937.2448-1-jay.buddhabhatti@amd.com>
References: <20240424095937.2448-1-jay.buddhabhatti@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH8PR12MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f876bc-72a5-46b7-0366-08dc645cf7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400014|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Og3HRHgceJe3Q79GzPNFFVCWdwL/AXt7AyEM6E5vC4WmXHBsgEAIOHisWj7u?=
 =?us-ascii?Q?4f/fi0KOeXFVRSPKd1zY88mTLEBiFNZZnnWhOhAgVptFBRxZjE7OFvFfEy40?=
 =?us-ascii?Q?IIrrl3oKgJAKYrah7FBygw2inVL9VfN7p/e6bXLof8lUiMx8BDlhrkPPg1u6?=
 =?us-ascii?Q?NQukgFvF9QLouIyHb6w3gh0EQNdONq2JQZ04YGZHZgMi1CXpmCWaK+VruOaQ?=
 =?us-ascii?Q?96uIunKrelxfQFUTKO5VfzAtHWtLNwDow7C40w9HMlIuP6CP6svO0VWEnIim?=
 =?us-ascii?Q?lQtv+ilru9lB2rjbJV9/vdV+heg/DIl/HU2XMgSfH6/QIy93xKH+WpavIn/k?=
 =?us-ascii?Q?TtX9K/mfpH9exLCk5kJi/fsVtL6igovB3JeYMeMjHzqdRlMBv0a+dOXXHn4S?=
 =?us-ascii?Q?nIP/kWaexLm8NvF3WQzOW0KeKUaH88O+GZigmVAi2HaJTgoULDYQuLwnjHkL?=
 =?us-ascii?Q?Zn/JBs9R4Kk43QuwXsXfQq7IZhNxzvcDEm47dzYc2rSONgzOvmN/wUpucZCt?=
 =?us-ascii?Q?mfcO0YiKkOTTEWTbvh6ktUhXHoyM0YGYoQB7aCJV87bEUKAzC5GVVirjX1rw?=
 =?us-ascii?Q?7KGTOivyQLQ/4b1Ll0RTVcwq2lB9leDNgkd78hftAHioCK+AhbxWVllRtxR6?=
 =?us-ascii?Q?i2jbvwGWVUApJT6kwykGtGzQwqIXmTxXmFte2yf9werwLwhnC7ZTklGXmr6u?=
 =?us-ascii?Q?Ck9+0NSQk1Qq1raV7P71QFVRJiDArEbt1zA13qZSmVvaAPwAfsOwZpnISTxT?=
 =?us-ascii?Q?nz8/iPQm+K9RpnTU+pHh08XitrdwBUH+jbbTuMuRjbLdpidPMgRC14nywlQT?=
 =?us-ascii?Q?Y6z9VObNYTfQdQZrglXXnaogDfvloLnx8BEwTdF62xWd6oh3OOBDmL/4XPpD?=
 =?us-ascii?Q?CgPdmdNrpFmkHsrGXplHYCItomW0Ty6l20cuMQ2fbsWY8cCVPlp8u5p6fUMn?=
 =?us-ascii?Q?BFo8nchS1K0alxtCZd3KfdWU4g0/Ig4VQUJ7wbn4yEuOZATEYOYvPv4jUA8E?=
 =?us-ascii?Q?uVMDjanNrlCl3u5/Icxnlt7GZDRWW83fqXizGQnYXtDvEfz/wm+QANo/e08j?=
 =?us-ascii?Q?bZSfJLXbE8janOcMiw+bXI/sblgn4SdUtFxtnFzs1qXJfA62d353eqWi+utg?=
 =?us-ascii?Q?zxGhXeA7zozbo9y991PZpbRy9GYTwmED95cGM/vdRJlgqWy4cVnY1ZRJYDAK?=
 =?us-ascii?Q?mVI2M9mV09rMl/zLuj2yflzRH8kQF0ohAEKFXC5j5Wp3vHvuFQnbywCq5hmk?=
 =?us-ascii?Q?QfzVINSfG2prVmZWq3NdTHbvB9roZe0iYmyEFyCjtvtHJzFO2vZCLYpWYeVk?=
 =?us-ascii?Q?fLxiGaTlFxEvupy7IR5flZneWQ1iwWUAK3DZLBwjculcYI4r/a7UwWqQFzIR?=
 =?us-ascii?Q?0HazhVjr1NokT3jIDVQF15K0EKUu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 12:49:23.7564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f876bc-72a5-46b7-0366-08dc645cf7e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7327

Add support to register subsystem restart events from firmware for Versal
and Versal NET platforms. This event is received when firmware requests
for subsystem restart. After receiving this event, the kernel needs to be
restarted.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
V1: https://lore.kernel.org/lkml/20240424095937.2448-1-jay.buddhabhatti@amd.com/
V1->V2: Updated copyright header in xlnx-event-manager.h
---
 drivers/soc/xilinx/zynqmp_power.c           | 151 +++++++++++++++++---
 include/linux/firmware/xlnx-event-manager.h |  10 ++
 2 files changed, 141 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index 8570ab1a6857..c193daf04a0a 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -31,9 +31,27 @@ struct zynqmp_pm_work_struct {
 	u32 args[CB_ARG_CNT];
 };
 
-static struct zynqmp_pm_work_struct *zynqmp_pm_init_suspend_work;
+/**
+ * struct zynqmp_pm_event_info - event related information
+ * @cb_fun:	Function pointer to store the callback function.
+ * @cb_type:	Type of callback from pm_api_cb_id,
+ *			PM_NOTIFY_CB - for Error Events,
+ *			PM_INIT_SUSPEND_CB - for suspend callback.
+ * @node_id:	Node-Id related to event.
+ * @event:	Event Mask for the Error Event.
+ * @wake:	Flag specifying whether the subsystem should be woken upon
+ *		event notification.
+ */
+struct zynqmp_pm_event_info {
+	event_cb_func_t cb_fun;
+	enum pm_api_cb_id cb_type;
+	u32 node_id;
+	u32 event;
+	bool wake;
+};
+
+static struct zynqmp_pm_work_struct *zynqmp_pm_init_suspend_work, *zynqmp_pm_init_restart_work;
 static struct mbox_chan *rx_chan;
-static bool event_registered;
 
 enum pm_suspend_mode {
 	PM_SUSPEND_MODE_FIRST = 0,
@@ -55,6 +73,19 @@ static void zynqmp_pm_get_callback_data(u32 *buf)
 	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, buf, 0);
 }
 
+static void subsystem_restart_event_callback(const u32 *payload, void *data)
+{
+	/* First element is callback API ID, others are callback arguments */
+	if (work_pending(&zynqmp_pm_init_restart_work->callback_work))
+		return;
+
+	/* Copy callback arguments into work's structure */
+	memcpy(zynqmp_pm_init_restart_work->args, &payload[0],
+	       sizeof(zynqmp_pm_init_restart_work->args));
+
+	queue_work(system_unbound_wq, &zynqmp_pm_init_restart_work->callback_work);
+}
+
 static void suspend_event_callback(const u32 *payload, void *data)
 {
 	/* First element is callback API ID, others are callback arguments */
@@ -120,6 +151,37 @@ static void ipi_receive_callback(struct mbox_client *cl, void *data)
 	}
 }
 
+/**
+ * zynqmp_pm_subsystem_restart_work_fn - Initiate Subsystem restart
+ * @work:	Pointer to work_struct
+ *
+ * Bottom-half of PM callback IRQ handler.
+ */
+static void zynqmp_pm_subsystem_restart_work_fn(struct work_struct *work)
+{
+	int ret;
+	struct zynqmp_pm_work_struct *pm_work = container_of(work, struct zynqmp_pm_work_struct,
+							     callback_work);
+
+	/* First element is callback API ID, others are callback arguments */
+	if (pm_work->args[0] == PM_NOTIFY_CB) {
+		if (pm_work->args[2] == EVENT_SUBSYSTEM_RESTART) {
+			ret = zynqmp_pm_system_shutdown(ZYNQMP_PM_SHUTDOWN_TYPE_SETSCOPE_ONLY,
+							ZYNQMP_PM_SHUTDOWN_SUBTYPE_SUBSYSTEM);
+			if (ret) {
+				pr_err("unable to set shutdown scope\n");
+				return;
+			}
+
+			kernel_restart(NULL);
+		} else {
+			pr_err("%s Unsupported Event - %d\n", __func__, pm_work->args[2]);
+		}
+	} else {
+		pr_err("%s() Unsupported Callback %d\n", __func__, pm_work->args[0]);
+	}
+}
+
 /**
  * zynqmp_pm_init_suspend_work_fn - Initialize suspend
  * @work:	Pointer to work_struct
@@ -185,10 +247,46 @@ static ssize_t suspend_mode_store(struct device *dev,
 
 static DEVICE_ATTR_RW(suspend_mode);
 
+static void unregister_event(struct device *dev, void *res)
+{
+	struct zynqmp_pm_event_info *event_info = res;
+
+	xlnx_unregister_event(event_info->cb_type, event_info->node_id,
+			      event_info->event, event_info->cb_fun, NULL);
+}
+
+static int register_event(struct device *dev, const enum pm_api_cb_id cb_type, const u32 node_id,
+			  const u32 event, const bool wake, event_cb_func_t cb_fun)
+{
+	int ret;
+	struct zynqmp_pm_event_info *event_info;
+
+	event_info = devres_alloc(unregister_event, sizeof(struct zynqmp_pm_event_info),
+				  GFP_KERNEL);
+	if (!event_info)
+		return -ENOMEM;
+
+	event_info->cb_type = cb_type;
+	event_info->node_id = node_id;
+	event_info->event = event;
+	event_info->wake = wake;
+	event_info->cb_fun = cb_fun;
+
+	ret = xlnx_register_event(event_info->cb_type, event_info->node_id,
+				  event_info->event, event_info->wake, event_info->cb_fun, NULL);
+	if (ret) {
+		devres_free(event_info);
+		return ret;
+	}
+
+	devres_add(dev, event_info);
+	return 0;
+}
+
 static int zynqmp_pm_probe(struct platform_device *pdev)
 {
 	int ret, irq;
-	u32 pm_api_version;
+	u32 pm_api_version, pm_family_code, pm_sub_family_code, node_id;
 	struct mbox_client *client;
 
 	ret = zynqmp_pm_get_api_version(&pm_api_version);
@@ -206,21 +304,43 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	 * is not available to use) or -ENODEV(Xilinx Event Manager not compiled),
 	 * then use ipi-mailbox or interrupt method.
 	 */
-	ret = xlnx_register_event(PM_INIT_SUSPEND_CB, 0, 0, false,
-				  suspend_event_callback, NULL);
+	ret = register_event(&pdev->dev, PM_INIT_SUSPEND_CB, 0, 0, false,
+			     suspend_event_callback);
 	if (!ret) {
 		zynqmp_pm_init_suspend_work = devm_kzalloc(&pdev->dev,
 							   sizeof(struct zynqmp_pm_work_struct),
 							   GFP_KERNEL);
-		if (!zynqmp_pm_init_suspend_work) {
-			xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0,
-					      suspend_event_callback, NULL);
+		if (!zynqmp_pm_init_suspend_work)
 			return -ENOMEM;
-		}
-		event_registered = true;
 
 		INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
 			  zynqmp_pm_init_suspend_work_fn);
+
+		ret = zynqmp_pm_get_family_info(&pm_family_code, &pm_sub_family_code);
+		if (ret < 0)
+			return ret;
+
+		if (pm_sub_family_code == VERSALNET_SUB_FAMILY_CODE)
+			node_id = PM_DEV_ACPU_0_0;
+		else
+			node_id = PM_DEV_ACPU_0;
+
+		ret = register_event(&pdev->dev, PM_NOTIFY_CB, node_id, EVENT_SUBSYSTEM_RESTART,
+				     false, subsystem_restart_event_callback);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to Register with Xilinx Event manager %d\n",
+				ret);
+			return ret;
+		}
+
+		zynqmp_pm_init_restart_work = devm_kzalloc(&pdev->dev,
+							   sizeof(struct zynqmp_pm_work_struct),
+							   GFP_KERNEL);
+		if (!zynqmp_pm_init_restart_work)
+			return -ENOMEM;
+
+		INIT_WORK(&zynqmp_pm_init_restart_work->callback_work,
+			  zynqmp_pm_subsystem_restart_work_fn);
 	} else if (ret != -EACCES && ret != -ENODEV) {
 		dev_err(&pdev->dev, "Failed to Register with Xilinx Event manager %d\n", ret);
 		return ret;
@@ -267,15 +387,8 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	}
 
 	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
-	if (ret) {
-		if (event_registered) {
-			xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0, suspend_event_callback,
-					      NULL);
-			event_registered = false;
-		}
-		dev_err(&pdev->dev, "unable to create sysfs interface\n");
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
@@ -283,8 +396,6 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 static void zynqmp_pm_remove(struct platform_device *pdev)
 {
 	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
-	if (event_registered)
-		xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0, suspend_event_callback, NULL);
 
 	if (!rx_chan)
 		mbox_free_channel(rx_chan);
diff --git a/include/linux/firmware/xlnx-event-manager.h b/include/linux/firmware/xlnx-event-manager.h
index 82e8254b0f80..645dd34155e6 100644
--- a/include/linux/firmware/xlnx-event-manager.h
+++ b/include/linux/firmware/xlnx-event-manager.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Event Management Driver
+ *
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ */
 
 #ifndef _FIRMWARE_XLNX_EVENT_MANAGER_H_
 #define _FIRMWARE_XLNX_EVENT_MANAGER_H_
@@ -7,6 +12,11 @@
 
 #define CB_MAX_PAYLOAD_SIZE	(4U) /*In payload maximum 32bytes */
 
+#define EVENT_SUBSYSTEM_RESTART		(4U)
+
+#define PM_DEV_ACPU_0_0			(0x1810c0afU)
+#define PM_DEV_ACPU_0			(0x1810c003U)
+
 /************************** Exported Function *****************************/
 
 typedef void (*event_cb_func_t)(const u32 *payload, void *data);
-- 
2.17.1


