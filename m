Return-Path: <linux-kernel+bounces-39556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768F883D2C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4CC9B22D76
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512A6A95E;
	Fri, 26 Jan 2024 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ztj1tSc+"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EA79DF;
	Fri, 26 Jan 2024 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706238108; cv=fail; b=tTe+QQjtfE8H/yVL8U80nPlHom0AhfNMWZ/5aNExgwH8KQNXZIGpk+liLlWyPb3auSC/ZyLTfHy2W1SnZ+9Qwt2mHpTd147wc+4TuLbgXW10fQnKLXUFs6e+dd8gQlVl6OnHHyns8p+NOBAiJV2hpZG6WrPK+plWikVmpsBEz/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706238108; c=relaxed/simple;
	bh=Ug94k1YQF5LM/qUAvZSroNh9F6WmJsjzS3GwENR5UUM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XTZW+NWLyc3YjZzY+gbnqloHKcfPmNMCX4i9HasJrThJkKFrarMJ6y1pZNJGWOr/H4tKiZASiTdNc80Q7vz4rzFQLwQwvaUg6FiSAz8l0fqZaj8xC44PTwlGv7xdZCW9e9a6YUTZs2z5gCnexR5Ie1rxRBSp17aeZLHULK/Wzz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ztj1tSc+; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0Ke8/EuDd2XywLt6EXLXRbW/K0rhvyPGYl4TjEjCCRxkw3U++kNHUv+BpN7q01+Ecd+3iIHzlgGI6kBMR4TKppwjxDHh49y9KWu7q1T2/x+esZZal8Doo2bLEhC10duf0NANjBMH/mesiNqc5i1YX+nG9ota01T0t/9tJSeufx+JGOeJSifEC1M3mcZ5DQ5C6WIwJoOw3E1R07wqqmfQF9SIykUOhSK6jUhvtfZt9cPI90IkGygi0WqvStQEvJixzr1v1+w+Q5dKftePFa8pwGdOCbDf0kiIAoSR7fPEmrwOwYQMFxLNTyPaQEbmRJ0e5cTTNi4WncxaSxrIkh0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rvNg5v1WZFVs3/ZWnV5jVztNEeVe5+6W1GheKFI0Dw=;
 b=gdVD+0SU+TNtAguD3P/J9woDlyrD95iZQhFQlM9BM4A7AZAurSQe6r2M1p7jJLQSs9Uht0BwgNqoSjgoJsfr6e63DNlZZ3WARn+hoV458L/K+ido9jrlYM+zKkH3uXdi763tWR1Bn6qc8nn4CdKOv0zn9+0e5+RTyWUKS8GAC/gmPrpIPe6vdNjfVmsZS7T67erjVuzXDelA1eeufIlTyiGYIPMmUY+Fhps3LBHxcTTsYzs74Ml3vekTmeOy65T437UZoWFmwzGwgH/xX41Gga60zOBX1MmEcLzc+Az3tX62Gw3gOMg5XDFVCqY/ZgnnoHcRgxyolInxcN9ptpt0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rvNg5v1WZFVs3/ZWnV5jVztNEeVe5+6W1GheKFI0Dw=;
 b=Ztj1tSc+fIdxCkMSN+L5AxGGFYsDxeI8zfZCfTqDIXFnOGccbe+Akuh88pthR/oYFX3Xf7biayG+vJGAoTd7u1szUVjI8ksShxGGTu14tP0nfdig0Y89c6FaiMrvBCWcxrbLvLUpOFdP5ezCQgQJkZwBd39LaEg2a2iiyYZoMOvYzvW153r4xjqsPCCa+fRAl+vQBjbmEdRC+8ugT1Hb+Tx5Kwh1ZPDl5BV9Z+w3ZQ/rJOPuRQTO6JsJx6Tc4YS5cVoTGMIX73OoUhKePmZbCe+OmhlbCeB4rfN622Xlc/2kOHfKBZeRymgcZ6MtTn1ZyXdkAwQN8YjLr9/sHQ/s2Q==
Received: from BN9PR03CA0774.namprd03.prod.outlook.com (2603:10b6:408:13a::29)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 03:01:43 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::6e) by BN9PR03CA0774.outlook.office365.com
 (2603:10b6:408:13a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 03:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 03:01:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 19:01:27 -0800
Received: from e558209-lcelt.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 19:01:25 -0800
From: Haotien Hsu <haotienh@nvidia.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Utkarsh Patel <utkarsh.h.patel@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sing-Han Chen <singhanc@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	Wayne Chang <waynec@nvidia.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, WK Tsai <wtsai@nvidia.com>, Haotien Hsu
	<haotienh@nvidia.com>
Subject: [PATCH v8] ucsi_ccg: Refine the UCSI Interrupt handling
Date: Fri, 26 Jan 2024 11:01:15 +0800
Message-ID: <20240126030115.3791554-1-haotienh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 697b165b-b469-494e-f895-08dc1e1b1ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JEEAiZtFREVjeczvHn26u68f5lYUjSS6Sfiow9agueBAl9FqFqAcLJbN+0rRCY/roMcRvndxDh39Dv372sS6XM1X9/V/JLg6VFGVtCCe505kKtNzZ35SbdqowjDVaT06AthzPCz1cYnDKMzxDqEJpw7GRaOFd7loJ3lkq78lIm3HcDx938lyGVvMTyjtKtpZlkkV0aVT3HX0Y4RcfidYy2kmII+ZxIgIL1jYNHJgK7lRWyjasOvcRaUZPBRE2vE22ms+7fIyXinYy08s4C7Xv+jnLVhfwQKiZdj4UspWbsszcdFxEgVi95qTfJGDn7UjRtPlEq/LiT5IA7f57C2o85QGR0fA23W9Ib7Gi/FNmwfL1NJLlxFeEptPbIZyq2M4HY7U6xlErKBC4R+cB6omIpU+aaqerhMBvHa7FJXOGUFnSVTCmVibvZhUdc/A59c09olEFnp08fDKBltoBxdbdZw8no5SSJEh5ZP+SX94WcmlDLqaticTmoifkGqL+omE1Tws3GD76e6SeZ2+0DKYrneim6FEredGaZSuTL3uvXKw44K3JLrXFTlKBxmFb2hy3jpsX2KRX7CgGKRBPC6Y1WWVUCkN7KlX73eKTsIJwrq8NGWN7xdHfF51WS33I/+pCRUmN9yCFV7yEq/IVCzF4MlhrLFuF4/97k8UtJ7oTBqnRMYO+J746LyiXkxuP/7z82SxsxkwDDKwiPyYqhAteT/79emExO9VfDtw8jztzc6HKWpYxgAFjMBuC6Xrn+YyHEmclXq9cD8JwWNqZvbu6IyuSjaJci6kAShEB3UVzbo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(2906002)(36860700001)(36756003)(4326008)(5660300002)(26005)(6666004)(1076003)(16526019)(426003)(336012)(2616005)(107886003)(47076005)(316002)(70586007)(70206006)(54906003)(478600001)(40460700003)(110136005)(86362001)(8936002)(8676002)(7696005)(83380400001)(41300700001)(82740400003)(40480700001)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 03:01:42.6769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697b165b-b469-494e-f895-08dc1e1b1ff3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547

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
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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
v7->v8
- Add Heikki's Reviewed-by tag
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


