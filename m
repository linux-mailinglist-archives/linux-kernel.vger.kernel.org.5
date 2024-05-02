Return-Path: <linux-kernel+bounces-167044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D448BA3CE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AFD2841A8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0498746BA6;
	Thu,  2 May 2024 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x9RqKEks"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BFE41A80;
	Thu,  2 May 2024 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691443; cv=fail; b=eHFI81NZbQWOi6/s0hlKzNGp6hxXMT2IK3qB2hJuAITgOsvpX5w/qR2G858lKUnZwSwMzZdory0nyZTYKhm1thN36fz/awH3fcqtL4/tHNpI49M+MBKgPzS1eIE2yXMhFCHJk2rR+4xcUvLxuRW3kZXM36BwF7pV6+XqCaRhKp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691443; c=relaxed/simple;
	bh=F7V6/iE0BSEsTNEEdjLbTtarHbL0vN7iMH09ivQU1+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhj0dVrhMcL1TL26g4P0bdFb9Rp63k3hezVGBIOn5PtDTXwG2/mYsvxz0EAxGKLwiqaW6/1+EpcA69ooqv4iKYT2jQZOb5/6xWnaKw7xxvfi/FZIll9yXsKDWSdXuKkWJ4C2fUInCjZn9fhsF9ACn9fmN8AjGRZjs9qYH09NNHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x9RqKEks; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG73agcNRxQ6kLUhzOtJ6KHDZLNPWJTfZYwOBA3R5JUE1RwX7xi0w+Zp8UBFjN6ACFaz9zWLT7u/KP45EDMaJuUNqaWgwLyD635EPtscHj524fkoRA6M/+p59nOkAHiE2Vyru4st7ZlWgA4eQGZr9BYPY9gjJXyfQhG11crS3kkwfjYF/jCjhO9YkHKBbKLoUWkoKEkgfKJlI6xMFhbkjWE8x8CQgap1pD2hWt+V6liS3i1QPxXwahSwy0YP1w454wZFHstS+A9ncsY8DWGoS8zEjIR19lcFUfmUgGrNS6BSWlK7VR2vWJcL2YP9DIcgBabA1Zd9NwuEuddQ0KtU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxxJRFFiWMrYhO8xyh3Wp1pfR86bOPMFxxUqEuFHLH8=;
 b=oEzqfNDF47h3iWFlmCD0oPAEiWTyjys0fk+0vfdAGh9+/J1+cfi/r2LhuN0Q78AgvzhyDKKf1kv1Fza98b/3nElDjsWkyQ3iD9KCsvFvRZlwTcSZI1N7G3S1PcYyp4dGMlL7dJkJ9Y1jVYvqFARbAwcl/oPfW6HkBgrxAAOj2yU+oyCs0BdnX5qOZgRO+usKb6u1Ex55lU+coBPDFp5aTZd271O4Mw81hbIgIy+Bd+e8Nfygxm9q6dRtDuDCOXAIh1gbF/w5Mm2jPlFxfjZCtYISxUgJcEukWYXX4rub9saiK6BzXms8RSEjzeumT+dg8qj47p0xHuKVvVAO2ZJy7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxxJRFFiWMrYhO8xyh3Wp1pfR86bOPMFxxUqEuFHLH8=;
 b=x9RqKEksOxskcrvy5Pbus1pEul+4w8E17F/jmiOXRuezXCLHpjG7P6xJ0GxHqBrI9ObR16+ociPAnUlrTd+kNskGRT1zJbzS1sRTEcfKJBnTVFEzZg/VN+Y0y8/QB3vuhZvz6fD/teSKhh8ySBsfaJS4u1K49Wk/3mc+pdPJ6HE=
Received: from BL0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:208:2d::46)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 23:10:39 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::83) by BL0PR03CA0033.outlook.office365.com
 (2603:10b6:208:2d::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 23:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 23:10:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 18:10:38 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 2 May 2024 18:10:37 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Tanmay Shah" <tanmay.shah@amd.com>
Subject: [PATCH 1/2] drivers: remoteproc: xlnx: add attach detach support
Date: Thu, 2 May 2024 16:10:20 -0700
Message-ID: <20240502231021.370047-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502231021.370047-1-tanmay.shah@amd.com>
References: <20240502231021.370047-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b356a5e-72ef-4c6b-3647-08dc6afd14fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zPtt7UcQ+t3vD8AKr7sRu0w40o0nJSbNkluZULkR9ytiSOSUqzb6E+fdq80/?=
 =?us-ascii?Q?6vH+mnCuAl/tPpPJHKYyH6w6w7ZwN2JwbRpfhkvUgGS3se3BV9x/3fV7/mTw?=
 =?us-ascii?Q?Z32E37e69FS2plNWx8gzqDXh/gnK1EkdwX8Yoi3ovBHKjiFMNTVnBWlDwjF/?=
 =?us-ascii?Q?9gngrZlKxiVZYlG7HSfUZeyXg+MWNRvzo0zrTxvna4cZmdUKpPfCV95TT5D6?=
 =?us-ascii?Q?hp/RhyFv5NXdV6qhnqm2JrcuJNgqnwxXJN9wEj/oqsuBg0r5EYLVYUdLxBau?=
 =?us-ascii?Q?1IvjeXlahoNZ/bXDt/RtKBuG3aOvqaPArLaoBxYDq7O+/1EnWevIiZoySrh3?=
 =?us-ascii?Q?fFyjTJ4PQDekMcw2KqZu/9pIdN+UXPzcJxpRJGRIVbt/g2T1dg3W8n1EJugg?=
 =?us-ascii?Q?1Fckpjw0lHzdKWh4bYphHCC6Nzu4/pTSrDEVxvkTFfHyRgCoJjE4A1ewWvbd?=
 =?us-ascii?Q?oC+giuEhBDP86WnxAySaRyFqALbzU8kGbbqQdysfhqHqQ2FMbzR1O0IhYNr7?=
 =?us-ascii?Q?IL9se6e17u7fVltEZi7IoUPmAqSUjABvuMKHIalmePyeXDB3gARgh12PllXf?=
 =?us-ascii?Q?t4GC4IESLOSIym4F4sUDtz0reoWutUGKNB+nbj/ueYpCxncaSN/Zd8IaZyjS?=
 =?us-ascii?Q?JF+c/jDe9sCEi/VMk9LE4MdWxa/7qhK2kE4AeD44ITp+66rBMBU+Z9mlJAjp?=
 =?us-ascii?Q?mHctFHPFsYlsc/W0HBfNAHYgnZ+HWS69z5HVeck49s2QZ6s1+0k+HiRFUR/u?=
 =?us-ascii?Q?CrkuBYCxbe0/KjjGJ3shm60sMeAAuTh8/MCiVIg0xeaWaafyC7M8eg2aEgue?=
 =?us-ascii?Q?2SKa09mYgh4c7toOEl0EPd2WAy/L6Jty8fZjYanoTfD0hOQLvvaw7e6EO2yj?=
 =?us-ascii?Q?Uwdn/R90RaP9cyZiTuR6aTT8QAhlLBuHEjwaOEAJmqbR4oW0L8UoMDgWxPD5?=
 =?us-ascii?Q?KVicGP1DUy+E5oO10v9JwkB0LCA35lDdBoPwSF06BZ2e/x2i8dGG9LpHOZh3?=
 =?us-ascii?Q?iXn+g9MskOMp42VpVoOCopvo+mMSU54LIEbnYpXycjhb67oBLplD/CicSR3l?=
 =?us-ascii?Q?uOUJYsrJiRt/QoBRJpYr7WSZudqa5nB1YDbYN8r+n3HgdSNvH0U+A/jmOICR?=
 =?us-ascii?Q?FgfhUrLkR6pxiMOvSJjKLSorvNa38ZD+LieNgYGuxe7nuf2L+2OnpTr74aNK?=
 =?us-ascii?Q?blE/Ql4Uy3XesR3X7FFKsqCC/VUEbLe2jpLMI5AOsSBfSL0UJ9DSU+U4sEA8?=
 =?us-ascii?Q?gA9cXOGT1EGUENEDhvTEc0JmLdjkdkCOAchH+4UT0tTzzzG6TBoofjG67Nu4?=
 =?us-ascii?Q?Hh5CwP7H9Ckq+PzAlQ15nCBo3BssNNUFYAInzCg52wPnYko6mtJm7Hd1FcB5?=
 =?us-ascii?Q?4MZ95MJouw3pvgiMEj5HW/iZTXan?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 23:10:39.0708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b356a5e-72ef-4c6b-3647-08dc6afd14fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

It is possible that remote processor is already running before
linux boot or remoteproc platform driver probe. Implement required
remoteproc framework ops to provide resource table address and
connect or disconnect with remote processor in such case.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c | 164 +++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 84243d1dff9f..af7aff5e9098 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -25,6 +25,10 @@
 /* RX mailbox client buffer max length */
 #define MBOX_CLIENT_BUF_MAX	(IPI_BUF_LEN_MAX + \
 				 sizeof(struct zynqmp_ipi_message))
+
+#define RSC_TBL_XLNX_MAGIC	((uint32_t)'x' << 24 | (uint32_t)'a' << 16 | \
+				 (uint32_t)'m' << 8 | (uint32_t)'p')
+
 /*
  * settings for RPU cluster mode which
  * reflects possible values of xlnx,cluster-mode dt-property
@@ -73,6 +77,15 @@ struct mbox_info {
 	struct mbox_chan *rx_chan;
 };
 
+/* Xilinx Platform specific data structure */
+struct rsc_tbl_data {
+	const int version;
+	const u32 magic_num;
+	const u32 comp_magic_num;
+	const u32 rsc_tbl_size;
+	const uintptr_t rsc_tbl;
+} __packed;
+
 /*
  * Hardcoded TCM bank values. This will stay in driver to maintain backward
  * compatibility with device-tree that does not have TCM information.
@@ -95,20 +108,24 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
 /**
  * struct zynqmp_r5_core
  *
+ * @rsc_tbl_va: resource table virtual address
  * @dev: device of RPU instance
  * @np: device node of RPU instance
  * @tcm_bank_count: number TCM banks accessible to this RPU
  * @tcm_banks: array of each TCM bank data
  * @rproc: rproc handle
+ * @rsc_tbl_size: resource table size retrieved from remote
  * @pm_domain_id: RPU CPU power domain id
  * @ipi: pointer to mailbox information
  */
 struct zynqmp_r5_core {
+	struct resource_table *rsc_tbl_va;
 	struct device *dev;
 	struct device_node *np;
 	int tcm_bank_count;
 	struct mem_bank_data **tcm_banks;
 	struct rproc *rproc;
+	u32 rsc_tbl_size;
 	u32 pm_domain_id;
 	struct mbox_info *ipi;
 };
@@ -621,10 +638,19 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
 {
 	int ret;
 
-	ret = add_tcm_banks(rproc);
-	if (ret) {
-		dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
-		return ret;
+	/**
+	 * For attach/detach use case, Firmware is already loaded so
+	 * TCM isn't really needed at all. Also, for security TCM can be
+	 * locked in such case and linux may not have access at all.
+	 * So avoid adding TCM banks. TCM power-domains requested during attach
+	 * callback.
+	 */
+	if (rproc->state != RPROC_DETACHED) {
+		ret = add_tcm_banks(rproc);
+		if (ret) {
+			dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
+			return ret;
+		}
 	}
 
 	ret = add_mem_regions_carveout(rproc);
@@ -662,6 +688,123 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
 	return 0;
 }
 
+static struct resource_table *zynqmp_r5_get_loaded_rsc_table(struct rproc *rproc,
+							     size_t *size)
+{
+	struct zynqmp_r5_core *r5_core;
+
+	r5_core = rproc->priv;
+
+	*size = r5_core->rsc_tbl_size;
+
+	return r5_core->rsc_tbl_va;
+}
+
+static int zynqmp_r5_get_rsc_table_va(struct zynqmp_r5_core *r5_core)
+{
+	struct device *dev = r5_core->dev;
+	struct rsc_tbl_data *rsc_data_va;
+	struct resource_table *rsc_addr;
+	struct resource res_mem;
+	struct device_node *np;
+	int ret;
+
+	/**
+	 * It is expected from remote processor firmware to provide resource
+	 * table address via struct rsc_tbl_data data structure.
+	 * Start address of first entry under "memory-region" property list
+	 * contains that data structure which holds resource table address, size
+	 * and some magic number to validate correct resource table entry.
+	 */
+	np = of_parse_phandle(r5_core->np, "memory-region", 0);
+	if (!np) {
+		dev_err(dev, "failed to get memory region dev node\n");
+		return -EINVAL;
+	}
+
+	ret = of_address_to_resource(np, 0, &res_mem);
+	if (ret) {
+		dev_err(dev, "failed to get memory-region resource addr\n");
+		return -EINVAL;
+	}
+
+	rsc_data_va = devm_ioremap_wc(dev, res_mem.start,
+				      sizeof(struct rsc_tbl_data));
+	if (!rsc_data_va) {
+		dev_err(dev, "failed to map resource table data address\n");
+		return -EIO;
+	}
+
+	/**
+	 * If RSC_TBL_XLNX_MAGIC number and its complement isn't found then
+	 * do not consider resource table address valid and don't attach
+	 */
+	if (rsc_data_va->magic_num != RSC_TBL_XLNX_MAGIC ||
+	    rsc_data_va->comp_magic_num != ~RSC_TBL_XLNX_MAGIC) {
+		dev_dbg(dev, "invalid magic number, won't attach\n");
+		return -EINVAL;
+	}
+
+	rsc_addr = ioremap_wc(rsc_data_va->rsc_tbl,
+			      rsc_data_va->rsc_tbl_size);
+	if (!rsc_addr) {
+		dev_err(dev, "failed to get rsc_addr\n");
+		return -EINVAL;
+	}
+
+	/**
+	 * As of now resource table version 1 is expected. Don't fail to attach
+	 * but warn users about it.
+	 */
+	if (rsc_addr->ver != 1)
+		dev_warn(dev, "unexpected resource table version %d\n",
+			 rsc_addr->ver);
+
+	r5_core->rsc_tbl_size = rsc_data_va->rsc_tbl_size;
+	r5_core->rsc_tbl_va = rsc_addr;
+
+	return 0;
+}
+
+static int zynqmp_r5_attach(struct rproc *rproc)
+{
+	struct zynqmp_r5_core *r5_core = rproc->priv;
+	int i, pm_domain_id, ret;
+
+	/*
+	 * Firmware is loaded in TCM. Request TCM power domains to notify
+	 * platform management controller that TCM is in use. This will be
+	 * released during unprepare callback.
+	 */
+	for (i = 0; i < r5_core->tcm_bank_count; i++) {
+		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
+		ret = zynqmp_pm_request_node(pm_domain_id,
+					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
+					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		if (ret < 0)
+			pr_warn("TCM %d can't be requested\n", i);
+	}
+
+	return 0;
+}
+
+static int zynqmp_r5_detach(struct rproc *rproc)
+{
+	struct zynqmp_r5_core *r5_core = rproc->priv;
+
+	/*
+	 * Generate last notification to remote after clearing virtio flag.
+	 * Remote can avoid polling on virtio reset flag if kick is generated
+	 * during detach by host and check virtio reset flag on kick interrupt.
+	 */
+	zynqmp_r5_rproc_kick(rproc, 0);
+
+	iounmap(r5_core->rsc_tbl_va);
+	r5_core->rsc_tbl_va = NULL;
+
+	return 0;
+}
+
 static const struct rproc_ops zynqmp_r5_rproc_ops = {
 	.prepare	= zynqmp_r5_rproc_prepare,
 	.unprepare	= zynqmp_r5_rproc_unprepare,
@@ -673,6 +816,9 @@ static const struct rproc_ops zynqmp_r5_rproc_ops = {
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
 	.kick		= zynqmp_r5_rproc_kick,
+	.get_loaded_rsc_table = zynqmp_r5_get_loaded_rsc_table,
+	.attach		= zynqmp_r5_attach,
+	.detach		= zynqmp_r5_detach,
 };
 
 /**
@@ -723,6 +869,16 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 		goto free_rproc;
 	}
 
+	/*
+	 * Move rproc state to DETACHED to give one time opportunity to attach
+	 * if firmware is already available in the memory. This can happen if
+	 * firmware is loaded via debugger or by any other agent in the system.
+	 * If firmware isn't available in the memory and resource table isn't found,
+	 * then rproc state stay OFFLINE.
+	 */
+	if (!zynqmp_r5_get_rsc_table_va(r5_core))
+		r5_rproc->state = RPROC_DETACHED;
+
 	r5_core->rproc = r5_rproc;
 	return r5_core;
 
-- 
2.25.1


