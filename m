Return-Path: <linux-kernel+bounces-50522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEE0847A2F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C182A1C25155
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101658173D;
	Fri,  2 Feb 2024 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UoxdQggr"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3512D753;
	Fri,  2 Feb 2024 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903976; cv=fail; b=jvKROnEejnqXS+PHs1hGUBWK7mEQ75qPVcs/p6f0CkIsw+7sx8ys1IOBZhoLv8TG5q+LjlKnxyoTf0Mfz1q/Vjv0mVkdqmaltmm1j4UXQWKJeTs3BLMwiofcJlmC2BEbT9gNLVCCWNaMCNap9xIrJQ9mAF1O3WPdql5vAA2jAAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903976; c=relaxed/simple;
	bh=5/XxhSKJ5dyBZqh96AqTlrkzcwfIdMcmwQoh51Qwxuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRR1JCxZ2LtWwTEb+wBigAhJYHUuYmQePriTNZFORTlffDceuxJH26zG3ukW1BGWVtsyBOXvprFQrU0xPNymJKahO36PynlTCsCHUvUZCDuoX8usNzq3oUkGRwgomAM6P4Ux4+XnBEwm7Po61TOwIUsIRDwpAk7FQVup8/1YR1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UoxdQggr; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhfKPOe8AP1fUBIxVL4+t0iaxc2HcuK4y7rpPz1EjTeNwESLGTh+Sux3Rk57dOt46ddaH9ay4BZtYLHk6uuzpjPEeHGo5ZIBtPCgfGTEf4NB45yD1aHL0W1Lu375LXxliD5QcIfWdvxaJd0la0rcN1JjthZh+LIzt8GDKAZ5K3X4lPPY0pgTQMTMo2SNUReJrsZIRqCeBXD04XEydQHhdFEdZe+RIr9O5ET3/H9HsTm190e1htG3G650qOVxRf7tu479bX5nP7v4Pg9Z6Wp0XX65KL4aBbXCuUEC70tY22Z8ciaP6t/kDYHS2HW9NAT/aUcJf7VeagfR07fHeHZsHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJmn4DLpo0vKobqZwL6OFsEod8Q1UUZ0FYjc6MqS7ds=;
 b=OBvl3PzFzHlvbb4BeUX/rGIOH70fUk1jgw7OgNSFBa5U15+cygqbNaWjRacpJxz01q4H4OTk/IWDO1s36iktvIO0oN6awAaGOtgRQGGmDbXYl2yq3dfduvrfl5R0tNZQNb/IrODJmO2/Flk6rA0kRqOKWZPrm/kq/a5gG0XFwAPOW/XtodUPLGnB2U0HxOnZPAfFV2UMf2OBnGmkVr5mBhitmpOBzbg96k4g2QFpEHYbhE3CdvbN61aNFwl+iRx3eLNsk+VgrUVzX6CQIMo4R+Hzo1bXDUY0HxCHImQ/S0AfwxOaeZVtFkgyNLbnoAgndyBht0UY2JbYY/9vnGsuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJmn4DLpo0vKobqZwL6OFsEod8Q1UUZ0FYjc6MqS7ds=;
 b=UoxdQggrZ3UeK/aXeLgQdoQbhuAAqWyGgEi/phoPTriRWI54s+nlb4OqkUCyFWyNImZZL6UJNvK8hvXI9fPQH3wvynCA127hUyYerUNSiu2sB+zeM8RpxrnL/3RXIppb9YFcfxjzBeiGBUvQQ4QZCCxo1+9QiaIfooBuAPAVceU=
Received: from SJ0PR03CA0209.namprd03.prod.outlook.com (2603:10b6:a03:2ef::34)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Fri, 2 Feb
 2024 19:59:31 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::57) by SJ0PR03CA0209.outlook.office365.com
 (2603:10b6:a03:2ef::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31 via Frontend
 Transport; Fri, 2 Feb 2024 19:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 2 Feb 2024 19:59:29 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 2 Feb
 2024 13:59:27 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net-next 4/4] pds_core: Clean up init/uninit flows to be more readable
Date: Fri, 2 Feb 2024 11:59:11 -0800
Message-ID: <20240202195911.65338-5-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240202195911.65338-1-brett.creeley@amd.com>
References: <20240202195911.65338-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 83fe8cda-e59b-4b3e-5266-08dc2429779a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f5bH6a1SpNYiJtX77RBFk3CVUSeheD8RnYGYZlgkMtZkhY842JXokj8d2hlu084DYTr+l9gOYFRw2g3P/W9rjHWRVZ/YpTsSEwY41AjGi2XNLHGMZd6S/IwyN8AitH5u7HKQ539y2r4EnJ1upNykR+mv+u3TtwQPJC26un4x+Qz1NLB8c67N/H0p9f6nqwSfuBMQ4kSQzvvlLG7o45FhmrrBIgzI2ClYSwiLWf68ZYSYcbSG9NIrVcbujLsy4VT1RJR1GZYQfv0TWzsm/L3i+B0TskfxSfuVbX2t3REo6ZajhKKGAu4NCYjhhpd18+hkeNLDZ/hbBmyEwKu9Up1a2T5MYwpeYgr4n2tEfiH22D7EO5OIgxoeusHVYnJaETfG6kvB/ES7LgJoPnU2riTYzpXzy93PfggPTzH97bzHUXh5zogSXtKwOeRmixrfwEJIGvknHKjV13lst7/AViUPZzNbUaJV+Pb8qP6udmD/yGzgni9APUQZSpCpSW/DvsMrcYOnhE7w5OahYpUEHu3BK2+PrxQb08qfP+QB4iCQuFa7vXM/Bq6vWB3mlEsgXB9c4EVXgt7dHP5sS5J9C6GdcW4rixpTXU7oNr9Hl9Ky4z7QBKhekKy/llLVi86w+MslV+TxoMa1E1pxb7DaTuis87zXrirHfwvheTaoA4ssmAC1RxC58SZWNmCSWdMkaW41Tw/CYtKEEw7TVC+eRKV54El5KpcgfstYrtMLeQEyxuRPf9wILSDfTVUk1Q1L1l2e7ej0KdgfDT+nDclmE2pRiA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(44832011)(82740400003)(54906003)(70586007)(8676002)(86362001)(2906002)(8936002)(5660300002)(70206006)(110136005)(4326008)(478600001)(36860700001)(36756003)(316002)(81166007)(47076005)(6666004)(356005)(83380400001)(336012)(26005)(41300700001)(40480700001)(40460700003)(1076003)(2616005)(426003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 19:59:29.7379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fe8cda-e59b-4b3e-5266-08dc2429779a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258

The setup and teardown flows are somewhat hard to follow regarding
pdsc_core_init()/pdsc_dev_init() and their corresponding teardown
flows being in pdsc_teardown(). Improve the readability by adding
new pdsc_core_uninit()/pdsc_dev_unint() functions that mirror their
init counterparts. Also, move the notify and admin qcq allocations
into pdsc_core_init(), so they can be freed in pdsc_core_uninit().

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 87 ++++++++++++------------
 drivers/net/ethernet/amd/pds_core/core.h |  1 +
 drivers/net/ethernet/amd/pds_core/dev.c  | 16 +++++
 3 files changed, 61 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 41507ade3570..1234a4a8a4ae 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -300,6 +300,17 @@ int pdsc_qcq_alloc(struct pdsc *pdsc, unsigned int type, unsigned int index,
 	return err;
 }
 
+static void pdsc_core_uninit(struct pdsc *pdsc)
+{
+	pdsc_qcq_free(pdsc, &pdsc->notifyqcq);
+	pdsc_qcq_free(pdsc, &pdsc->adminqcq);
+
+	if (pdsc->kern_dbpage) {
+		iounmap(pdsc->kern_dbpage);
+		pdsc->kern_dbpage = NULL;
+	}
+}
+
 static int pdsc_core_init(struct pdsc *pdsc)
 {
 	union pds_core_dev_comp comp = {};
@@ -310,9 +321,32 @@ static int pdsc_core_init(struct pdsc *pdsc)
 	struct pds_core_dev_init_data_in cidi;
 	u32 dbid_count;
 	u32 dbpage_num;
+	int numdescs;
 	size_t sz;
 	int err;
 
+	/* Scale the descriptor ring length based on number of CPUs and VFs */
+	numdescs = max_t(int, PDSC_ADMINQ_MIN_LENGTH, num_online_cpus());
+	numdescs += 2 * pci_sriov_get_totalvfs(pdsc->pdev);
+	numdescs = roundup_pow_of_two(numdescs);
+	err = pdsc_qcq_alloc(pdsc, PDS_CORE_QTYPE_ADMINQ, 0, "adminq",
+			     PDS_CORE_QCQ_F_CORE | PDS_CORE_QCQ_F_INTR,
+			     numdescs,
+			     sizeof(union pds_core_adminq_cmd),
+			     sizeof(union pds_core_adminq_comp),
+			     0, &pdsc->adminqcq);
+	if (err)
+		return err;
+
+	err = pdsc_qcq_alloc(pdsc, PDS_CORE_QTYPE_NOTIFYQ, 0, "notifyq",
+			     PDS_CORE_QCQ_F_NOTIFYQ,
+			     PDSC_NOTIFYQ_LENGTH,
+			     sizeof(struct pds_core_notifyq_cmd),
+			     sizeof(union pds_core_notifyq_comp),
+			     0, &pdsc->notifyqcq);
+	if (err)
+		goto err_out_uninit;
+
 	cidi.adminq_q_base = cpu_to_le64(pdsc->adminqcq.q_base_pa);
 	cidi.adminq_cq_base = cpu_to_le64(pdsc->adminqcq.cq_base_pa);
 	cidi.notifyq_cq_base = cpu_to_le64(pdsc->notifyqcq.cq.base_pa);
@@ -336,7 +370,7 @@ static int pdsc_core_init(struct pdsc *pdsc)
 	if (err) {
 		dev_err(pdsc->dev, "Device init command failed: %pe\n",
 			ERR_PTR(err));
-		return err;
+		goto err_out_uninit;
 	}
 
 	pdsc->hw_index = le32_to_cpu(cido.core_hw_index);
@@ -346,7 +380,8 @@ static int pdsc_core_init(struct pdsc *pdsc)
 	pdsc->kern_dbpage = pdsc_map_dbpage(pdsc, dbpage_num);
 	if (!pdsc->kern_dbpage) {
 		dev_err(pdsc->dev, "Cannot map dbpage, aborting\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_out_uninit;
 	}
 
 	pdsc->adminqcq.q.hw_type = cido.adminq_hw_type;
@@ -359,6 +394,10 @@ static int pdsc_core_init(struct pdsc *pdsc)
 
 	pdsc->last_eid = 0;
 
+	return 0;
+
+err_out_uninit:
+	pdsc_core_uninit(pdsc);
 	return err;
 }
 
@@ -401,35 +440,12 @@ static int pdsc_viftypes_init(struct pdsc *pdsc)
 
 int pdsc_setup(struct pdsc *pdsc, bool init)
 {
-	int numdescs;
 	int err;
 
 	err = pdsc_dev_init(pdsc);
 	if (err)
 		return err;
 
-	/* Scale the descriptor ring length based on number of CPUs and VFs */
-	numdescs = max_t(int, PDSC_ADMINQ_MIN_LENGTH, num_online_cpus());
-	numdescs += 2 * pci_sriov_get_totalvfs(pdsc->pdev);
-	numdescs = roundup_pow_of_two(numdescs);
-	err = pdsc_qcq_alloc(pdsc, PDS_CORE_QTYPE_ADMINQ, 0, "adminq",
-			     PDS_CORE_QCQ_F_CORE | PDS_CORE_QCQ_F_INTR,
-			     numdescs,
-			     sizeof(union pds_core_adminq_cmd),
-			     sizeof(union pds_core_adminq_comp),
-			     0, &pdsc->adminqcq);
-	if (err)
-		goto err_out_teardown;
-
-	err = pdsc_qcq_alloc(pdsc, PDS_CORE_QTYPE_NOTIFYQ, 0, "notifyq",
-			     PDS_CORE_QCQ_F_NOTIFYQ,
-			     PDSC_NOTIFYQ_LENGTH,
-			     sizeof(struct pds_core_notifyq_cmd),
-			     sizeof(union pds_core_notifyq_comp),
-			     0, &pdsc->notifyqcq);
-	if (err)
-		goto err_out_teardown;
-
 	/* Set up the Core with the AdminQ and NotifyQ info */
 	err = pdsc_core_init(pdsc);
 	if (err)
@@ -455,35 +471,20 @@ int pdsc_setup(struct pdsc *pdsc, bool init)
 
 void pdsc_teardown(struct pdsc *pdsc, bool removing)
 {
-	int i;
-
 	if (!pdsc->pdev->is_virtfn)
 		pdsc_devcmd_reset(pdsc);
 	if (pdsc->adminqcq.work.func)
 		cancel_work_sync(&pdsc->adminqcq.work);
-	pdsc_qcq_free(pdsc, &pdsc->notifyqcq);
-	pdsc_qcq_free(pdsc, &pdsc->adminqcq);
+
+	pdsc_core_uninit(pdsc);
 
 	if (removing) {
 		kfree(pdsc->viftype_status);
 		pdsc->viftype_status = NULL;
 	}
 
-	if (pdsc->intr_info) {
-		for (i = 0; i < pdsc->nintrs; i++)
-			pdsc_intr_free(pdsc, i);
-
-		kfree(pdsc->intr_info);
-		pdsc->intr_info = NULL;
-		pdsc->nintrs = 0;
-	}
-
-	if (pdsc->kern_dbpage) {
-		iounmap(pdsc->kern_dbpage);
-		pdsc->kern_dbpage = NULL;
-	}
+	pdsc_dev_uninit(pdsc);
 
-	pci_free_irq_vectors(pdsc->pdev);
 	set_bit(PDSC_S_FW_DEAD, &pdsc->state);
 }
 
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 110c4b826b22..3468a63f5ae9 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -282,6 +282,7 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 int pdsc_devcmd_init(struct pdsc *pdsc);
 int pdsc_devcmd_reset(struct pdsc *pdsc);
 int pdsc_dev_init(struct pdsc *pdsc);
+void pdsc_dev_uninit(struct pdsc *pdsc);
 
 void pdsc_reset_prepare(struct pci_dev *pdev);
 void pdsc_reset_done(struct pci_dev *pdev);
diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 7dc102a31185..e494e1298dc9 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -316,6 +316,22 @@ static int pdsc_identify(struct pdsc *pdsc)
 	return 0;
 }
 
+void pdsc_dev_uninit(struct pdsc *pdsc)
+{
+	if (pdsc->intr_info) {
+		int i;
+
+		for (i = 0; i < pdsc->nintrs; i++)
+			pdsc_intr_free(pdsc, i);
+
+		kfree(pdsc->intr_info);
+		pdsc->intr_info = NULL;
+		pdsc->nintrs = 0;
+	}
+
+	pci_free_irq_vectors(pdsc->pdev);
+}
+
 int pdsc_dev_init(struct pdsc *pdsc)
 {
 	unsigned int nintrs;
-- 
2.17.1


