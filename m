Return-Path: <linux-kernel+bounces-156680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F19A8B06C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5B71F2450C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE32158DAE;
	Wed, 24 Apr 2024 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0r8mGqS+"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A4D159218
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952806; cv=fail; b=J6u53+CKmZLcNqV1Ybr0hCJeyiAJxZnEPkgkTv+QdAYTLXgiCX86hsLpGgMQCIDbFjGPVaJuGHgOadDUDvKjhGVPyun64esMy3U8/sTKi3yRAY7q4x6ep+FVQu+3ZXq+cFyv7kJ9x+fzyILIk9ZrEb/oU9CuzfAUq0Y4A0kP2xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952806; c=relaxed/simple;
	bh=5YF9cZjMrVF8r5V2FLVgSOyi5fhrnkbzbCk6ZD/SxkI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kU4DZsV7oYzjtV1w2ETsqNBnXoWjXGZD0v+9KueCAF4cP3L1m1N25dm7daBVJ6upUiRCf5+4yau/Dj2rBSzHCBqKqfosumJJ9sqm9bH4p23YR1aIZmRmjGNmPxtx0XU8e1vvs9iJnidCOgtAfd5onNyVD1mpqKCbKJhEBUyAzss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0r8mGqS+; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STJBMBRTZFsXfcRXJugTESkSNq+7yIlCGoNYV2242l/TmXd+qJVwDJnR7y7mze44VsZ2YG+N2ZLki5jS59bI4casPWlRTEDnerBmI6ETtbR0cqGA9HVhb2PaPB8ooFal7mTgU6iM2zxaddtegPJjQrahI3SW7UazoNMIjHKObc8E8alTV71y0Xu/vA+VoJ5WaPoUrjoz8mfcETsUsXAjvoawFlbtro047ZlUXCX47BF8ovrPATfjwSfsPRT61qjhmtXS+PesT/agooS/f3K1L71tAgIq4HJK+Nt52UYfz+DZfpOmWDW9HEkx46Jtk3oG7L4ktyIwmO0Ck5XleKb+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m34a1BvNKuKhl6vxy1SwgC0Ebirw9tPVPg4fk7J3zI=;
 b=Elu8HsqikvFPxo0FqCe5YtzNaTBd4fHl+b4buOsPLmVwV3QJM693ZiFrpHvEw+j7Oga2lPQAp992uJhSF7nvMZ4d7y4kTyYpuZkPXbEJhiwZCf7M7S352wr5GeFDgbFQ1G9HB/xUMyyHtuVXnqOB5fnT/cktU04pQHzaow5NBkSOZMC2xgLGDOvJwa2AA6dRTkjRSluk8xWRvF1KMnMi1tHnGROZD/sdTc+DedZ5fdZWe7NKhUtca9MSzXcPWlB8RKvPxiK9ZlYcMnzef+VkW36NgF/Vx1EPT3OezKcqo2Ikj0OXQST0myryyR69ym+pvLo1S6cqg2+0BVJOdIqZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m34a1BvNKuKhl6vxy1SwgC0Ebirw9tPVPg4fk7J3zI=;
 b=0r8mGqS+3tRMZlDFSGhOB7/OCTHKydYNlUpNEZyUqn09b3sFuxDa/Vp3uMj7NU53DJLmes3QNoxX6UPX1L56SOl9/m6+TZQgzJkS+zIvH9l1aV+7DK4FR0sG21nKYgjmAipVq0j/Xu1O+1zqT7E8tI5pMnDnIbfgB5jfAp8cna0=
Received: from CH2PR08CA0008.namprd08.prod.outlook.com (2603:10b6:610:5a::18)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 10:00:02 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:5a:cafe::72) by CH2PR08CA0008.outlook.office365.com
 (2603:10b6:610:5a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 10:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Wed, 24 Apr 2024 10:00:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 05:00:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 05:00:01 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 05:00:00 -0500
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: <michal.simek@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH] soc: xilinx: Add cb event for subsystem restart
Date: Wed, 24 Apr 2024 02:59:37 -0700
Message-ID: <20240424095937.2448-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jay.buddhabhatti@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 588433f0-f3cd-4c78-862b-08dc64454f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ihQUh8MUfJKh971h/6h+zNY4/w+3mpgSjBcweE83HvrgmgrREar31Hn94IbP?=
 =?us-ascii?Q?lcRyQRHb7UXluOdnLffwaQzbwebAf2rXTbVJ/5difISw+26Hg7yeihtcFAHV?=
 =?us-ascii?Q?3v5eq4LSu8gcT4K1emLz2B8alwwQzet1gbfd9IB5uYaznu+rSTD2n9FASZcY?=
 =?us-ascii?Q?97yFro4rLkORsspXBRYBdjnPxhxkrBLjIEaJL/xOeIm1Qbf8Sb3HLvtoyaW3?=
 =?us-ascii?Q?ZQL1Md2BpiFodNnsG5QKfEkargGI1jUejz/ud19JD7FQE1x8RydPcFuIdooI?=
 =?us-ascii?Q?9FuMxuOc54fpuslzmcVmhcEsePpYGV1eA0wEdXA7b4ZS4DcD8Dj73Q9cnhyr?=
 =?us-ascii?Q?U+Xa1Aqq9FGpKFzrtdk9auziDnFMbqf4MJhw0EqkGF5SsQy1XJWp8tDV4J8B?=
 =?us-ascii?Q?uDmrAmZvpDYQA4kJT0DEClZcx3nnyIhdLhQiG6IL+Va3VZE/D5IrkfI59u+c?=
 =?us-ascii?Q?GLPGKyvfA1KHt6i955fZAYpVd248hPt6Ex6x+34yq8XLyfox1BWcFG9EiAkv?=
 =?us-ascii?Q?Q3EDjkR3KQALpkslKdj+HRw+oYwKLP7qvzRGpSJZ7e30WJgXR2aiJCS7Xu8W?=
 =?us-ascii?Q?KXSCRTBjFkuZLfwzpd4bthPkS8wLDl/5iM4/m73jogR+rbIRWuF+Kj1/+Ax3?=
 =?us-ascii?Q?xKZbJC8BR6cSUC3nrpZBdj+agIx4JA/a6P2a30QW+Nm1ZpwzNpLfoAaLbhOh?=
 =?us-ascii?Q?msuS1/Kj0ZISrvI8Hxr5D763LwUeanI65J9ElZsBMMd5gI7EQWBpxTbt2nz6?=
 =?us-ascii?Q?glHCoAcX7LezfgQCel2ABTfEQHhkZWiPW2UOCVHdvtB/gW6Fv8NYZkXePVRR?=
 =?us-ascii?Q?r93En1xopIXtx9vay1yM8ZwuO1TX8y4CukQWUY+va/81iBjZvYnypedYb0NQ?=
 =?us-ascii?Q?GrNAP37zDTy9+gpY5GEgVLfArgN6jFOQdMjwu9cb3R3RSb5jQ+jBROG/c9e9?=
 =?us-ascii?Q?iYHsJlIKeHVccQVf9vdLyhx1E4q6SnKHkCGTxxlT3WCbBOsBZSL1q9zHDWZ3?=
 =?us-ascii?Q?8IPtlvju0NhvV1jV/kwhRfmHLFS0trwLHC1WHFmsHccGN+VzNxqtbTiMjsVl?=
 =?us-ascii?Q?EZlaWXobh3Vr4NuxBtgK87CR7Zqe2cmq8rtizGjyDCkJGNSoGmoboMIOjC22?=
 =?us-ascii?Q?rTQohIa+nfzVMkPa6U4CCJ4T1O7kl/bBHXzyd1ewQm+u2iLkpNQ8JDuWye0U?=
 =?us-ascii?Q?EmnRYCwQn5/d5mqwWYju8aH5EjrEHWZ0FViPlTYZxQxHz2tCYI6J5bUtBcOF?=
 =?us-ascii?Q?kX4BE9QYMj0cSLWRtxPy9JI56J/q8fE5e1bhzNyTlA59w4HKHyJhGJRj6Rdc?=
 =?us-ascii?Q?In5aPAyv1tFxg8hmo1X6o0pbfHfkHhWK0Q3fkjF3K8OaZtjtw5unSzGzON7Z?=
 =?us-ascii?Q?zH04qfkVbGIfzLgfAnDUEAtaH/OV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 10:00:02.0451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 588433f0-f3cd-4c78-862b-08dc64454f03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534

Add support to register subsystem restart events from firmware for Versal
and Versal NET platforms. This event is received when firmware requests
for subsystem restart. After receiving this event, the kernel needs to be
restarted.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/soc/xilinx/zynqmp_power.c           | 151 +++++++++++++++++---
 include/linux/firmware/xlnx-event-manager.h |  12 ++
 2 files changed, 143 insertions(+), 20 deletions(-)

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
index 82e8254b0f80..317e51829346 100644
--- a/include/linux/firmware/xlnx-event-manager.h
+++ b/include/linux/firmware/xlnx-event-manager.h
@@ -1,4 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Event Management Driver
+ *
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
 
 #ifndef _FIRMWARE_XLNX_EVENT_MANAGER_H_
 #define _FIRMWARE_XLNX_EVENT_MANAGER_H_
@@ -7,6 +14,11 @@
 
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


