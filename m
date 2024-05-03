Return-Path: <linux-kernel+bounces-167752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DC98BAEA2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C10C284305
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192A1154BF4;
	Fri,  3 May 2024 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w/E5rs2E"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F6154455
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745781; cv=fail; b=Vphu3kvMi7SQzWPKq5WOheQOh3R+PLok2t0zExuEsomogyoF1ZIaXokzPUCm/yvC4qDiAM2lfvqOIPuz2WkW/1KGYDbKokotqfhR1pYjembm0yESOXylj/3ifu2WvVDwe2HY6PL13Mh2HfMvyE9AqmSEK9lCjTbEL2VBEfqIJAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745781; c=relaxed/simple;
	bh=twxiNo/NjkhozIOvOfiGDAZN9lkc314GWh4GarOC/Gg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KxYSUTg4TLyp/f/iZPmJUGSvqB93APHQSJ6QkzDSwQQfwHN2eLM2uptGJCwb84Avy7iOUvrxgHQjduG6muUDIRiSdgp6ehvEMMvAdyRSoNZEDC/7oO/dA6gEO27+A1u+imWk+9kw7vjt14eKzgLqAxhXHeuvL01gLWMh5vo2bAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w/E5rs2E; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiBLgSa1DtH2bCT718VADDEn3l6VF3TmKNrPsJuNTvTez9KzsfOvOzV5+Ez76RNmIbU/BV/ugEfa78lF8v/gl1GuU+6HlLfvuNhAxFXpH1I7HuDzAxCg3VeZWMJ6b9CfFVF5O9wNO1OBsu5ofuRUbC9bzT+aNzog8BA1Nx25hsDAEay713LLLDk0Z/DRs0mVMP2prr7yrsu9kTWm0lVR1611JpLd/LuAR2l7yIidUGUwaxsDgx6WgsE9ofoVcwcdqMoF4zs9nPog8hO6UKc7EgfuzEfkZPJQYEJ1ZmzraRTlZM92uQcaUp4/KBb96OKtCEDC6fXC8I5AI0jBevaYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/2y5TsEH3mfE0KwR0skNGoq14R6sDecdFYw83XDc/I=;
 b=OZAZ5O0PUCPzO9OegNDZywiEd502pWF3ae9AHiTEIs0aI7Vnd6xTyyqzlLNnUxJo6MBF/b8H8gqEKY0PJW/yT2dz5XVQu4HnXnM+sP+9VbazL7tJzwJrPvKJ6mmH16pIWjfa7TmarSO0jOdJlaBkCvDBcqC40O7fA8/8vmku0qh3rv6v8rsH0Z8xoPHH5pK5ZX1n5AX8cvVVN8M0poDdb7t0x6xaHmyluXF+O7K+fmaFUJ4bzFSXfQ+ULJZGlza3ZJQUzIUFy9okn8LRqxIOohgI/aSlLK24lg5ZEwZBLpn2zPN9ajijyK9JgAOhbgoOeDYhVE6TnI5lcInuszm0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/2y5TsEH3mfE0KwR0skNGoq14R6sDecdFYw83XDc/I=;
 b=w/E5rs2EHgm1e3D6+mC3O4tTkvmDsaCcKeef23YO8b0bj//oOvUcPw7I7Bhny3Ll4/UXsB/X1e6/fy5u26EQjdgaOIALzwk+9cE+Ni3UgjfO8rLFo+9/4cQQRcIuA5kshD85TfB5MvoLo0Q1V6dPF3Hj8COzkNmd2WYhW+ZBsDE=
Received: from BN0PR04CA0196.namprd04.prod.outlook.com (2603:10b6:408:e9::21)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 14:16:11 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::1) by BN0PR04CA0196.outlook.office365.com
 (2603:10b6:408:e9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Fri, 3 May 2024 14:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Fri, 3 May 2024 14:16:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 09:16:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 09:16:11 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 3 May 2024 09:16:10 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Tanmay Shah <tanmay.shah@amd.com>, Saeed Nowshadi <saeed.nowshadi@amd.com>
Subject: [PATCH] drivers: mailbox: handle SGI for shared IPI
Date: Fri, 3 May 2024 07:15:45 -0700
Message-ID: <20240503141545.495112-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: f19424ec-9b61-4038-10ac-08dc6b7b95a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J6J3c9cVcsPR6f9Es5rTx7BtbPdJH5KZxkM3GR9ojq5uLXnAPVXn6N9x6lW0?=
 =?us-ascii?Q?GI0qHMvj33lWpCy/nbqmtgOQkBTzIEkTZeb9Ty4O6h5BO4w3Cv/iHeJxRzVQ?=
 =?us-ascii?Q?5MiMZBnCEQRzO8HUJRALdK+8bOJJwrbTdRFlnK1Vy3FeHzj20OwitTLuICkE?=
 =?us-ascii?Q?NXDWw3PyClqo/mykC4qO2JlzRgY7kx0b/muhVry4OD/rE7rXzNEkhjUK1/SZ?=
 =?us-ascii?Q?/fgviSJ91IWSzfdLaLZgtfYL8vHJkc+y1FThYbQfsK9EdUdB5ehIKvK2ZwFu?=
 =?us-ascii?Q?xPdT7EKvE/4VB/bBTlmHsxXYM627w28j0HY0hOuZKf6c0jUMJFnVgKur5LO2?=
 =?us-ascii?Q?VE4m6K7WinuEQQf9+ksteyA42gsgkjyNuM8s5XmZuIQN4AIEyncXDuRMJo9w?=
 =?us-ascii?Q?xF8uieVQlN1dlvHDrzdL3m+TXWUDwfzOuUEULqYz3H6L19ALPoHBgOLcp50o?=
 =?us-ascii?Q?0E7uSJWFvzI+0ROyX92l3nDKJ4DImxY3JrlhwrPU3XgVsqxBaYejmXFGN7qe?=
 =?us-ascii?Q?/Rw7m6VG8sV5FAX/2jO9R587Vj+SW87GIWIWexbWoPy8u7GqP+2RdAdIkOhZ?=
 =?us-ascii?Q?7qUWRA4S7LJZkcQ7JJOD0xnNkkb3pM+VSoisXPGlQE0H+5u3BlgOwwmq3Qoh?=
 =?us-ascii?Q?ZY1T45+yUe4Kxi3B6AwkStcwRRPYZVnYraH4ghBPYLP4tOp22OwS+lMdq+v+?=
 =?us-ascii?Q?/wIFWYKvoXZwtb+L0MO3TCyK5FgDFPEai0RayBHBiPfz4sSxF5xUrV7uORKd?=
 =?us-ascii?Q?qrGo/8DEQMD1oJ6/ab57dHvnPad0t8loEl4k8AY2XNDJ3s5Z/aaMtgizQ6MD?=
 =?us-ascii?Q?FdN6nox/LbQh0SxtLr4rO+iehMdMmimpNEF2EuMNeAPVp1m4VDd9yltBvH/Y?=
 =?us-ascii?Q?cL3BDpiTO1A1AI/BKU6m5R/oXy0BqGXVp/Qa4BPydJ3eKIVCDk3uFn9rh9HG?=
 =?us-ascii?Q?XJO7IwLYWQLb94YnwD5W8Wz3xCsT04D3AyV/MVXFoepqP33ldMdAkiETyjVp?=
 =?us-ascii?Q?1JxWla0OvEdA+o0yxjz6pVlScYhTYSqqlRTY/UnSwns/mWTE8cdikI7OLJAv?=
 =?us-ascii?Q?0FBURDADverHuOvs974IUEXnHqdouqflwzkml6FfUciEcdqYqOB3+HQd2NSQ?=
 =?us-ascii?Q?wSHX6mSXjM0z4ulluI5IdEwN9QGRquL1cx9+5K7s9FFTl/gsQjDDGQ6g6PH+?=
 =?us-ascii?Q?GQZGjkSmFf1XOYoGkdey4Aj9lEz2s9EYCSQ67loikosBdLowjJmaNpl9lPgf?=
 =?us-ascii?Q?kRg0ProGV1W/a2i6uDO/m37UzaAmYlGMgJFVA4eJaMMzQNNNEc8P9iF0e4uL?=
 =?us-ascii?Q?gJVxQ00AX7x4v4g1zs6LsVb426QzpD6XVJFszZUzUlEVsZ07EJYGBDNR4QkL?=
 =?us-ascii?Q?ngeFvNLhPTDi9MoIP8Qf5HD03fzz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 14:16:11.4874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f19424ec-9b61-4038-10ac-08dc6b7b95a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002

At least one IPI is used in TF-A for communication with PMC firmware.
If this IPI needs to be used by other agents such as RPU then, IPI
system interrupt can't be generated in mailbox driver. In such case
TF-A generates SGI to mailbox driver for IPI notification.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Signed-off-by: Saeed Nowshadi <saeed.nowshadi@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 159 +++++++++++++++++++++++++--
 1 file changed, 152 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 1cb553cced90..7c90bac3de21 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -6,9 +6,11 @@
  */
 
 #include <linux/arm-smccc.h>
+#include <linux/cpuhotplug.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_controller.h>
@@ -16,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 
 /* IPI agent ID any */
@@ -59,6 +62,8 @@
 #define DST_BIT_POS	9U
 #define SRC_BITMASK	GENMASK(11, 8)
 
+#define MAX_SGI 16
+
 /**
  * struct zynqmp_ipi_mchan - Description of a Xilinx ZynqMP IPI mailbox channel
  * @is_opened: indicate if the IPI channel is opened
@@ -111,6 +116,7 @@ struct zynqmp_ipi_mbox {
  * @irq:                  IPI agent interrupt ID
  * @method:               IPI SMC or HVC is going to be used
  * @local_id:             local IPI agent ID
+ * @virq_sgi:             IRQ number mapped to SGI
  * @num_mboxes:           number of mailboxes of this IPI agent
  * @ipi_mboxes:           IPI mailboxes of this IPI agent
  */
@@ -119,10 +125,13 @@ struct zynqmp_ipi_pdata {
 	int irq;
 	unsigned int method;
 	u32 local_id;
+	int virq_sgi;
 	int num_mboxes;
 	struct zynqmp_ipi_mbox ipi_mboxes[] __counted_by(num_mboxes);
 };
 
+static DEFINE_PER_CPU(struct zynqmp_ipi_pdata *, per_cpu_pdata);
+
 static struct device_driver zynqmp_ipi_mbox_driver = {
 	.owner = THIS_MODULE,
 	.name = "zynqmp-ipi-mbox",
@@ -189,6 +198,14 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
 	return status;
 }
 
+static irqreturn_t zynqmp_sgi_interrupt(int irq, void *data)
+{
+	struct zynqmp_ipi_pdata **pdata_ptr = data;
+	struct zynqmp_ipi_pdata *pdata = *pdata_ptr;
+
+	return zynqmp_ipi_interrupt(irq, pdata);
+}
+
 /**
  * zynqmp_ipi_peek_data - Peek to see if there are any rx messages.
  *
@@ -748,6 +765,112 @@ static int versal_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
 	return 0;
 }
 
+static int xlnx_mbox_cpuhp_start(unsigned int cpu)
+{
+	struct zynqmp_ipi_pdata *pdata;
+
+	pdata = get_cpu_var(per_cpu_pdata);
+	put_cpu_var(per_cpu_pdata);
+	enable_percpu_irq(pdata->virq_sgi, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int xlnx_mbox_cpuhp_down(unsigned int cpu)
+{
+	struct zynqmp_ipi_pdata *pdata;
+
+	pdata = get_cpu_var(per_cpu_pdata);
+	put_cpu_var(per_cpu_pdata);
+	disable_percpu_irq(pdata->virq_sgi);
+
+	return 0;
+}
+
+static void xlnx_disable_percpu_irq(void *data)
+{
+	struct zynqmp_ipi_pdata *pdata;
+
+	pdata = *this_cpu_ptr(&per_cpu_pdata);
+
+	disable_percpu_irq(pdata->virq_sgi);
+}
+
+static int xlnx_mbox_init_sgi(struct platform_device *pdev,
+			      int sgi_num,
+			      struct zynqmp_ipi_pdata *pdata)
+{
+	int ret = 0;
+	int cpu;
+
+	/*
+	 * IRQ related structures are used for the following:
+	 * for each SGI interrupt ensure its mapped by GIC IRQ domain
+	 * and that each corresponding linux IRQ for the HW IRQ has
+	 * a handler for when receiving an interrupt from the remote
+	 * processor.
+	 */
+	struct irq_domain *domain;
+	struct irq_fwspec sgi_fwspec;
+	struct device_node *interrupt_parent = NULL;
+	struct device *dev = &pdev->dev;
+
+	/* Find GIC controller to map SGIs. */
+	interrupt_parent = of_irq_find_parent(dev->of_node);
+	if (!interrupt_parent) {
+		dev_err(&pdev->dev, "Failed to find property for Interrupt parent\n");
+		return -EINVAL;
+	}
+
+	/* Each SGI needs to be associated with GIC's IRQ domain. */
+	domain = irq_find_host(interrupt_parent);
+	of_node_put(interrupt_parent);
+
+	/* Each mapping needs GIC domain when finding IRQ mapping. */
+	sgi_fwspec.fwnode = domain->fwnode;
+
+	/*
+	 * When irq domain looks at mapping each arg is as follows:
+	 * 3 args for: interrupt type (SGI), interrupt # (set later), type
+	 */
+	sgi_fwspec.param_count = 1;
+
+	/* Set SGI's hwirq */
+	sgi_fwspec.param[0] = sgi_num;
+	pdata->virq_sgi = irq_create_fwspec_mapping(&sgi_fwspec);
+
+	for_each_possible_cpu(cpu)
+		per_cpu(per_cpu_pdata, cpu) = pdata;
+
+	ret = request_percpu_irq(pdata->virq_sgi, zynqmp_sgi_interrupt, pdev->name,
+				 &per_cpu_pdata);
+	WARN_ON(ret);
+	if (ret) {
+		irq_dispose_mapping(pdata->virq_sgi);
+		return ret;
+	}
+
+	irq_to_desc(pdata->virq_sgi);
+	irq_set_status_flags(pdata->virq_sgi, IRQ_PER_CPU);
+
+	/* Setup function for the CPU hot-plug cases */
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mailbox/sgi:starting",
+			  xlnx_mbox_cpuhp_start, xlnx_mbox_cpuhp_down);
+
+	return ret;
+}
+
+static void xlnx_mbox_cleanup_sgi(struct zynqmp_ipi_pdata *pdata)
+{
+	cpuhp_remove_state(CPUHP_AP_ONLINE_DYN);
+
+	on_each_cpu(xlnx_disable_percpu_irq, NULL, 1);
+
+	irq_clear_status_flags(pdata->virq_sgi, IRQ_PER_CPU);
+	free_percpu_irq(pdata->virq_sgi, &per_cpu_pdata);
+	irq_dispose_mapping(pdata->virq_sgi);
+}
+
 /**
  * zynqmp_ipi_free_mboxes - Free IPI mailboxes devices
  *
@@ -758,6 +881,9 @@ static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
 	struct zynqmp_ipi_mbox *ipi_mbox;
 	int i;
 
+	if (pdata->irq < MAX_SGI)
+		xlnx_mbox_cleanup_sgi(pdata);
+
 	i = pdata->num_mboxes;
 	for (; i >= 0; i--) {
 		ipi_mbox = &pdata->ipi_mboxes[i];
@@ -773,7 +899,8 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *nc, *np = pdev->dev.of_node;
-	struct zynqmp_ipi_pdata *pdata;
+	struct zynqmp_ipi_pdata __percpu *pdata;
+	struct of_phandle_args out_irq;
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
 	setup_ipi_fn ipi_fn;
@@ -821,14 +948,32 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 		mbox++;
 	}
 
-	/* IPI IRQ */
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
+	ret = of_irq_parse_one(dev_of_node(dev), 0, &out_irq);
+	if (ret < 0) {
+		dev_err(dev, "failed to parse interrupts\n");
 		goto free_mbox_dev;
+	}
+	ret = out_irq.args[1];
+
+	/*
+	 * If Interrupt number is in SGI range, then request SGI else request
+	 * IPI system IRQ.
+	 */
+	if (ret < MAX_SGI) {
+		pdata->irq = ret;
+		ret = xlnx_mbox_init_sgi(pdev, pdata->irq, pdata);
+		if (ret)
+			goto free_mbox_dev;
+	} else {
+		ret = platform_get_irq(pdev, 0);
+		if (ret < 0)
+			goto free_mbox_dev;
+
+		pdata->irq = ret;
+		ret = devm_request_irq(dev, pdata->irq, zynqmp_ipi_interrupt,
+				       IRQF_SHARED, dev_name(dev), pdata);
+	}
 
-	pdata->irq = ret;
-	ret = devm_request_irq(dev, pdata->irq, zynqmp_ipi_interrupt,
-			       IRQF_SHARED, dev_name(dev), pdata);
 	if (ret) {
 		dev_err(dev, "IRQ %d is not requested successfully.\n",
 			pdata->irq);

base-commit: 9221b2819b8a4196eecf5476d66201be60fbcf29
-- 
2.25.1


