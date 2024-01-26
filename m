Return-Path: <linux-kernel+bounces-40460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47F583E0C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C0C1F245EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ADD23753;
	Fri, 26 Jan 2024 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v37abj/3"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25222261D;
	Fri, 26 Jan 2024 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291004; cv=fail; b=q652tEYs6qlpplIxW89QYfuuiCpdIy9T6YdqrPczGZvuShfSZNik8OvuaJGF323N1CICVN2ynp4Tu0wjoi3upoEkKi/TGmyGBTni0Qtxa5AryvSSVhxQX5qpZRBzQpoH5VXrt86dIynQk77B98xyTeLPfGcUaaASBDAqMCwzqM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291004; c=relaxed/simple;
	bh=5/XxhSKJ5dyBZqh96AqTlrkzcwfIdMcmwQoh51Qwxuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExE6BLiizYZaGR3RPcVGNmgk3fFOXA4lgH0pjS3Ih1AXv+3+ejeiIn9TZU+QrWZKq1TqAjBLcf0mvYsFgZx1I0YOLRc1Z/+8xfaRSumXRS/4cajx5ZcGEe2pbArkrTG3hrugSQwsf2EFkpNSfcSv8Ff5Hyc4uB+HQ5hVZNUNaAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v37abj/3; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxYstIsXvk27/Qfdy2q1XAGtclS/BKonm81QxI0y9hBxbgezz9Z7XBhgZjwJ2OfWM5TZAY70NaHHCHEMHeLNbV8MEHZZditteBPrYTg+QETVDJ3jearI9rsiANkLi3I863XFz9Y7UkuANH8RDBHeEzKqZC6veqZv3sJM2BBwlFd4DgenMs3GsczPUGXkUHfiXzpZwIn02B5IE/onGc6ILUr7P9UM9ZLMSoqIa1J0y/0zyOE+qY4ko8RlITojCjdj/skyVJYIF5CAexMDl95N2OHy/sggA5iRWAsSLSfyEUZO6I0PQIuwFuv1LuCHlTXHhpLZPtPtHGyA/weHJqfd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJmn4DLpo0vKobqZwL6OFsEod8Q1UUZ0FYjc6MqS7ds=;
 b=cZj9oXVgOKu976e7JcCVK2RCRt7WvAyIYuX/9x6fUN8RpMpNrB7AKUUHVvBbfT77NnWqkf8S+ciBieUkEQhVtYQTodgmwwTLVORNNt9R1JEU/m9rDq5b40Aj7shsXRp0tPeW7a4N/+wDcK+x5gsbP7001DFfBjkY/M5vwYv/JHuxhWloFHdGnBt0jvjnuObf0uJonn2N4ky3JujnR6nXLitO8qlz0irIRPzxqVovGc2Cm5Ozm0+isKt6myaUAhhDPreYsrU4zNy0OVEphhxCqaYyOpw9oJcVkWRUl1ANAf1Fe87dwMDj16wAoVMM2KX/Won9YwyvBSdQFvGyYHk4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJmn4DLpo0vKobqZwL6OFsEod8Q1UUZ0FYjc6MqS7ds=;
 b=v37abj/3UnoRMlndK3gbHTP6SHnGBlnSAk+KUvbxeVG50DcqADHLGhCZu05nHiUOI+bPC967Bqw464qeTRu6Y+7EsD9Yack6Ivp/9mmEmqXMHvPH4KFq3kPlpYSvav8c4r9hGvLb/0G7PyA1Rcnr2+g6fHyR68276UpBQYL0CwI=
Received: from BN8PR15CA0070.namprd15.prod.outlook.com (2603:10b6:408:80::47)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 17:43:20 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::d7) by BN8PR15CA0070.outlook.office365.com
 (2603:10b6:408:80::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Fri, 26 Jan 2024 17:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 17:43:18 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 11:43:16 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 10/10] pds_core: Clean up init/uninit flows to be more readable
Date: Fri, 26 Jan 2024 09:42:55 -0800
Message-ID: <20240126174255.17052-11-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240126174255.17052-1-brett.creeley@amd.com>
References: <20240126174255.17052-1-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9da0d2-6a58-4052-5c00-08dc1e96487c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	brbTWsO0xD0Z7Ds16vOlNVRmEAHuIlPINfbo1qqCmtdQD/NVx0+E41DJk7jrSqfkhB7LcWILUu4UlQwjcTQHYZ9ij7Mh/MKgGaRtwZr26O39dyJF3t7IYVkl1YO/BUOwNoycdqWEZc0YifsKynx8Fo9PdF/g2mGJ7mUcaYff1oXXXciQlAfBSwXocwAkYxwIh7SLQKV2x43VUaECP98ZkwV59bnZ+qZrrg/HNO5F6l0IymICn3bgICPkQbV+6q+hD5fl2OIDxPt2LbPTOeedahgJ0s//oUWnRVsBHP8mvQnAGzX4kZc5qvh1O55Eeou0DUYQnx4skWwjm5VZHh2lh1+MXD77kg5asaBvx/BzdXQipdbX9F2GIRzsN54H1HLek+885QJJB11Xc0T9XaUvbi+tRpx+bXqasLXU5rkBB9Vtp4pOKVOfyv0Wk2xZ5dzD2Y4RF+3tok5cH9W6Umc1/1HPoPAhv3IU7pl/BmxB96QAbzjJx0Tw1Z85Vgs0ZVlPqNoMOu2L0PgNhiFabPFIRcnEUhDREQcb8AoiyrmkEo7dHZfMcqZuOG6TUcUD4xWEfcMyEWEy/NMKsIZD/cuxFe+702zf2m2f+KocwyLO26HKbu1RMowE5buNs2cN3LKflHvgu0kuD0UWkgHxPu6Akbwx61zQ/E9oSpx7rThHiwTAeWXE1S9lTFAUIYNCk5kn/dQ0iD+4RijLG2WkunFSsUXPJ+XRGHwM3u5B0KfFxGl0o+w6z3lHE50yY7tmXDx2Ir+1weIZDk9Mex8I/xdjjg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(47076005)(36756003)(82740400003)(41300700001)(356005)(44832011)(5660300002)(54906003)(1076003)(6666004)(70206006)(316002)(40460700003)(70586007)(110136005)(40480700001)(83380400001)(2906002)(426003)(336012)(8936002)(478600001)(2616005)(8676002)(4326008)(36860700001)(86362001)(26005)(81166007)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:43:18.9336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9da0d2-6a58-4052-5c00-08dc1e96487c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705

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


