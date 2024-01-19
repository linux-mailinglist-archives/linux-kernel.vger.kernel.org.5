Return-Path: <linux-kernel+bounces-30704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33855832358
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13951F22F14
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F18817C8;
	Fri, 19 Jan 2024 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nYSFAvUq"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931238E;
	Fri, 19 Jan 2024 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705631694; cv=fail; b=io7zuyFa5OA/1ul3KFYKJl3GOomRRaAI1egR0cF1P3d3M3Cx69BpUewCE5ATOlKimG66uKP50PimHPkGZ+0RqmJWyWkmCCt9liO6ZDi6I+AlaGtTalRkWo6DxuVl7b/uMW9ISZuzUJapC4Py8/CU5Menepj48r0g6c0o/svgQ2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705631694; c=relaxed/simple;
	bh=980mST41PiJWFUwdACUzInQ5N/6P3jOsr3mbyFeBse4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sJ2SYWOPtEryH3Yp02treSyEJDjsv7nTXFfEJ+2vQfvs/XXK1Ue+kSGldQBqyD5v77W5EpmwBvXjMgJkUibAh2Pj8WpM0fD9eZ0z2TGsTHCZUuIjZrPFjzFwpX9K5b4MxyEp+GmdwGwhFHxnqhT1PlDmIB6lgyGDcgeUTJN5nnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nYSFAvUq; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Co5I54cQvuvR4cRMqPurzRZps6dqSrtfbQ042aljcVK8xKpNhS3eF+3XwyW2okcWXQLgUp7daby84A6ArXoDpAZoI0dIVIpQnEC0dQO3Piibd3LyqIZjhMB/VACKFuhuuvsq//KQSqUI8FqlNTPwbv3d4TaGDLTJIgFXasV7tYpKbbBOrdgkJ+2YfaBmr7Z8sV8N/UIgaUQd9aW086YWOd+93PAn2YZEpSicdtZsz/HOEdFAb0zo83AWBg3HxRl4BnKdVKwGyFKs6cGL7X3JK6q7nkatU9h7HOvOWGCSmZNzIogLIseCJLO7zfVSHV/uNMb+7Qr0+PmxWj/32tfVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FI9UjNJwPt002xACVypJXagj6GcOKXOdqEid8qiYeMg=;
 b=TfuPRSkAelNcsik3HESNY6FJVtyhgag08iHX3ncttqs+UICoytJK4kujdPB4svad+YJi1BltxsuvclQuwNDBRX0XdxxdGt7+Atjt4SVsmYQfOkFU0GXYjHs1ouWoWv9rsY1qqygCkMONYPkZw8+n4Y01P1NVfvf/6x84HvxqGLntICh+tXoTnDDfVY54yuxRcZbVHhoT13FuTZUq5xGYF30U2KCovjtpqyrrYUpxyVUIhVipiqfoZGOIgGyl0EHUSZ5OHWSpn/e6b1V+eyttz3/1lPKa0qTquOHkbzRKxYKzA3bLl1hvYKage/584iEPul/5LW283xYCgw3luzm4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FI9UjNJwPt002xACVypJXagj6GcOKXOdqEid8qiYeMg=;
 b=nYSFAvUqTn4CYeCC7VSnh3eKXs8Cnh7+KNS9Kb5PtcFPo2J7hexg81NQHf1ZFSwk4Eh1QdE4KrseaL0CpN/A83lCeT07kiVh4tR93SYn1Q8IvJjHfntsQ08WDck0WVC97xvDzSR3yyjMBPDk923IAlgsTqtfVAg1Wj8iZVCfKgChy7IrR6USxAQFLXwcXboBUFrs67sIsZyONb2Vq4Li62/yEojQesG5Ra6uIgpkgfWycRRVZImdyPAxdEjXSRiHKry1YSvrTIcnS1a/CvtRDOFQkeKLFvhS8A2jqboYXtuCLae3x2ZQ7lJ8S37rAcIYFlo7k86Rrra981cczYINKg==
Received: from MW4PR04CA0063.namprd04.prod.outlook.com (2603:10b6:303:6b::8)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 02:34:44 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::90) by MW4PR04CA0063.outlook.office365.com
 (2603:10b6:303:6b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 02:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.0 via Frontend Transport; Fri, 19 Jan 2024 02:34:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 18 Jan
 2024 18:34:22 -0800
Received: from e558209-lcelt.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 18 Jan 2024 18:34:19 -0800
From: Haotien Hsu <haotienh@nvidia.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Utkarsh Patel <utkarsh.h.patel@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sing-Han Chen <singhanc@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	Wayne Chang <waynec@nvidia.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, WK Tsai <wtsai@nvidia.com>, Haotien Hsu
	<haotienh@nvidia.com>
Subject: [PATCH v7] ucsi_ccg: Refine the UCSI Interrupt handling
Date: Fri, 19 Jan 2024 10:34:09 +0800
Message-ID: <20240119023409.659452-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f38915e-5364-4260-38f5-08dc1897325a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qj/TDeYwI22ChiREM7oGaTO8ZL5jAY7yeL9sOKAsSGRUoLesdWvze4roPH1BbHVJqBlsFxn5Ab2MmtIWCPXOHU551cxkxCDD0pdulA0/eD22NNjlCdtgvhRRg3ybkC5r/hTVW+x2wnEKvdpSby3jU9xjA/FcvTQ87UX6wU6gzw+2EaohpIPyNGd1IRX4X3IWciykkQiURLl49ZeQm/pmhzhULF20iCzLKyb6o4G4T8dB3i8yHIaSCT5rpcWLncnZmh5sCn6yF+kLTdP+pcao8gYISO5tI2/O7yuMSQ79aM6PIIIywFPf9RqLliFhvwtS6OoUDawsNeYfJd0/Tn2e6wknuU1MWlZXJfhzHXiJhteeM124DIyYUsbzNTEdKVOkoKRBF+kj+G1/4BPeaQD98ikspL35c91YaL6jWbxFbMWlv2LebiBglx6Pcmtu0g4+GXit8a6el9Ar6wwbjisgbdiep1OfugO9hYI1Nh9wDWFze8NB3zGY6qGM9Ea0S2UBPQZCj1uH59GAibJXGDUvDnZ0+8Blwp6bs3NMedY9Htylf7ZwYd3R8RJWeHustZ+aa9lOr7CwF2fVeILwcVVWnGPXwXQ4p2DN2yjVTsb5y3UE/uoWt5p/dwpI5OY7kOU7NDnUKkDnEI9J+yGEgW0qckq2UgfLyPlGwujSBBhPRKR1eulu14kGgdjpUx4MihRzHFyQ2eLXfnP7OLcnFtlWR4F0bVT93YVysESbA+IA/SQz5RPCEpMpF61SR0kIIpdwGSQHsvScsatObf6jkVSrv/G1f2TpoJ0VxkzeNz3Lbas=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(8676002)(4326008)(8936002)(54906003)(70586007)(316002)(110136005)(70206006)(40460700003)(40480700001)(478600001)(2616005)(7696005)(6666004)(1076003)(107886003)(83380400001)(336012)(426003)(16526019)(47076005)(26005)(41300700001)(36860700001)(7636003)(82740400003)(356005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 02:34:44.2732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f38915e-5364-4260-38f5-08dc1897325a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260

With the Cypress CCGx Type-C controller the following error is
sometimes observed on boot:
[   16.087147] ucsi_ccg 1-0008: failed to reset PPM!
[   16.087319] ucsi_ccg 1-0008: PPM init failed (-110)

When the above timeout occurs the following happens:
1. The function ucsi_reset_ppm() is called to reset UCSI controller.
   This function performs an async write to start reset and then
   polls for completion.
2. An interrupt occurs when the reset completes. In the interrupt
   handler, the OPM field in the INTR_REG is cleared and this clears
   the CCI data in the PPM. Hence, the reset completion status is
   cleared.
3. The function ucsi_reset_ppm() continues to poll for the reset
   completion, but has missed the reset completion event and
   eventually timeouts.

In this patch, we store CCI when handling the interrupt and make
reading after async write gets the correct value.

To align with the CCGx UCSI interface guide, this patch updates the
driver to copy CCI and MESSAGE_IN before they are reset when UCSI
interrupt acknowledged.

When a new command is sent, the driver will clear the old CCI to avoid
ucsi_ccg_read() getting wrong CCI after ucsi_ccg_async_write() when
the UCSI interrupt is not handled.

Finally, acking the UCSI_READ_INT interrupt before calling complete()
in ISR to ensure that the ucsi_ccg_sync_write() would wait for the
interrupt handling to complete.

Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>

---
V1->V2
- Fix uninitialized symbol 'cci'
v2->v3
- Remove misusing Reported-by tags
v3->v4
- Add comments for op_lock
v4->v5
- Specify the endianness of registers in struct op_region
- Replace ccg_op_region_read() with inline codes
- Replace ccg_op_region_clean() with inline codes
- Replace stack memory with GFP_ATOMIC allocated memory in ccg_op_region_update()
- Add comments for resetting CCI in ucsi_ccg_async_write()
v5->v6
- Fix sparse warning: incorrect type in assignment
v6->v7
- Move changelog to below
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 92 ++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 449c125f6f87..dda7c7c94e08 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -192,6 +192,12 @@ struct ucsi_ccg_altmode {
 	bool checked;
 } __packed;
 
+#define CCGX_MESSAGE_IN_MAX 4
+struct op_region {
+	__le32 cci;
+	__le32 message_in[CCGX_MESSAGE_IN_MAX];
+};
+
 struct ucsi_ccg {
 	struct device *dev;
 	struct ucsi *ucsi;
@@ -222,6 +228,13 @@ struct ucsi_ccg {
 	bool has_multiple_dp;
 	struct ucsi_ccg_altmode orig[UCSI_MAX_ALTMODES];
 	struct ucsi_ccg_altmode updated[UCSI_MAX_ALTMODES];
+
+	/*
+	 * This spinlock protects op_data which includes CCI and MESSAGE_IN that
+	 * will be updated in ISR
+	 */
+	spinlock_t op_lock;
+	struct op_region op_data;
 };
 
 static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
@@ -305,12 +318,42 @@ static int ccg_write(struct ucsi_ccg *uc, u16 rab, const u8 *data, u32 len)
 	return 0;
 }
 
+static int ccg_op_region_update(struct ucsi_ccg *uc, u32 cci)
+{
+	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_MESSAGE_IN);
+	struct op_region *data = &uc->op_data;
+	unsigned char *buf;
+	size_t size = sizeof(data->message_in);
+
+	buf = kzalloc(size, GFP_ATOMIC);
+	if (!buf)
+		return -ENOMEM;
+	if (UCSI_CCI_LENGTH(cci)) {
+		int ret = ccg_read(uc, reg, (void *)buf, size);
+
+		if (ret) {
+			kfree(buf);
+			return ret;
+		}
+	}
+
+	spin_lock(&uc->op_lock);
+	data->cci = cpu_to_le32(cci);
+	if (UCSI_CCI_LENGTH(cci))
+		memcpy(&data->message_in, buf, size);
+	spin_unlock(&uc->op_lock);
+	kfree(buf);
+	return 0;
+}
+
 static int ucsi_ccg_init(struct ucsi_ccg *uc)
 {
 	unsigned int count = 10;
 	u8 data;
 	int status;
 
+	spin_lock_init(&uc->op_lock);
+
 	data = CCGX_RAB_UCSI_CONTROL_STOP;
 	status = ccg_write(uc, CCGX_RAB_UCSI_CONTROL, &data, sizeof(data));
 	if (status < 0)
@@ -520,9 +563,20 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
 	struct ucsi_capability *cap;
 	struct ucsi_altmode *alt;
-	int ret;
+	int ret = 0;
+
+	if (offset == UCSI_CCI) {
+		spin_lock(&uc->op_lock);
+		memcpy(val, &(uc->op_data).cci, val_len);
+		spin_unlock(&uc->op_lock);
+	} else if (offset == UCSI_MESSAGE_IN) {
+		spin_lock(&uc->op_lock);
+		memcpy(val, &(uc->op_data).message_in, val_len);
+		spin_unlock(&uc->op_lock);
+	} else {
+		ret = ccg_read(uc, reg, val, val_len);
+	}
 
-	ret = ccg_read(uc, reg, val, val_len);
 	if (ret)
 		return ret;
 
@@ -559,9 +613,18 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 static int ucsi_ccg_async_write(struct ucsi *ucsi, unsigned int offset,
 				const void *val, size_t val_len)
 {
+	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
 	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
 
-	return ccg_write(ucsi_get_drvdata(ucsi), reg, val, val_len);
+	/*
+	 * UCSI may read CCI instantly after async_write,
+	 * clear CCI to avoid caller getting wrong data before we get CCI from ISR
+	 */
+	spin_lock(&uc->op_lock);
+	uc->op_data.cci = 0;
+	spin_unlock(&uc->op_lock);
+
+	return ccg_write(uc, reg, val, val_len);
 }
 
 static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
@@ -615,13 +678,18 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
 	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_CCI);
 	struct ucsi_ccg *uc = data;
 	u8 intr_reg;
-	u32 cci;
-	int ret;
+	u32 cci = 0;
+	int ret = 0;
 
 	ret = ccg_read(uc, CCGX_RAB_INTR_REG, &intr_reg, sizeof(intr_reg));
 	if (ret)
 		return ret;
 
+	if (!intr_reg)
+		return IRQ_HANDLED;
+	else if (!(intr_reg & UCSI_READ_INT))
+		goto err_clear_irq;
+
 	ret = ccg_read(uc, reg, (void *)&cci, sizeof(cci));
 	if (ret)
 		goto err_clear_irq;
@@ -629,13 +697,21 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(uc->ucsi, UCSI_CCI_CONNECTOR(cci));
 
-	if (test_bit(DEV_CMD_PENDING, &uc->flags) &&
-	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
-		complete(&uc->complete);
+	/*
+	 * As per CCGx UCSI interface guide, copy CCI and MESSAGE_IN
+	 * to the OpRegion before clear the UCSI interrupt
+	 */
+	ret = ccg_op_region_update(uc, cci);
+	if (ret)
+		goto err_clear_irq;
 
 err_clear_irq:
 	ccg_write(uc, CCGX_RAB_INTR_REG, &intr_reg, sizeof(intr_reg));
 
+	if (!ret && test_bit(DEV_CMD_PENDING, &uc->flags) &&
+	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
+		complete(&uc->complete);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.34.1


