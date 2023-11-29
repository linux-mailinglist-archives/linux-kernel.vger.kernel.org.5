Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68B97FD01C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjK2HvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjK2Hu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:50:58 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2558D171D;
        Tue, 28 Nov 2023 23:51:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIrFB4lsxHmM4xNFHU3ZeqtgCMlkVESAoUkEH9+vT/hODL0iXX/Kv1IAN1sOmwnBIROl7LokvGo6MkRXlh1qaFnk43ZyrTGXXtH+m16QNuGeiffyPED94gKf3cSNamHgfW1D+i+dbQx6t9ChYwOg76Bm08XQa7Y7R58h+Aqymok4Zdo5nWG2dDbz8pUAwqxwOG3jrT/tiy21XAGgRADji8aDcxQXDH30hVjBDI+UJC1mk09gA5T5OSWq5CvmpMkKHsFDY2Ukf9mIW+bbyVYiRoCuaWVTUxaEq59ARoAdC8Xj0C6B8kovSQVF8OJGVStfsNyc+scJ5c/sbhn5b9BJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRqEVyGtTeeafaCZlkEsEYMaTZwPETuJH5kJZ5dUqIw=;
 b=QbGDFhp28uL+D7DjKzfE8DWlh2Bbiv65swusdDLQBxkHTs03JUESjuKyXgdFe/NZRELlj74SWOhkp37Xk9+hQS46w22GK2ugy5m7OEIn50wYnnyJyZ9PSpp3wwBkh/LaLR3QmfTA5CAMK2HExUL8e5+qILbAE3wBnmlGUP1OURKXTeYw65/tKWxpWUd+DBtigq62J9waLyw/IUg+XW8QR2pRoHb+IfjYtyQN+weJZ8425ifYx16iJn9792HOn9vUBLh+/OR/UuvSS1usajw/Q73o0UMv6fRPrnB2ZYdi5Dss1mAiszXkgWGqu9H20YHIuezcPtI5KQdJCci6qPcG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRqEVyGtTeeafaCZlkEsEYMaTZwPETuJH5kJZ5dUqIw=;
 b=TMnFCUvPo86xsNZgghgLhI7Z+X4hqsQjI7yMr1z2vFjB6PgZaRkR+bDRh37WeddsZ3ZCw/SY2Gi6TMMmklpOzHNhSxssgxYvBVr69zs+TS3rBDR0Bh3BlWS/d4CtpqtJj2ebKF8z1WSKXMxBFl6xosEpH7OAmo+GLEKbwadFOGY=
Received: from CY5P221CA0071.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::37) by
 PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 07:51:02 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::3f) by CY5P221CA0071.outlook.office365.com
 (2603:10b6:930:4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 07:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 07:51:01 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 01:50:59 -0600
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>,
        Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
        Sathya Priya Kumar <sathyapriya.k@amd.com>
Subject: [PATCH 3/4] EDAC/amd64: Add sysfs entry to read FRU poison data
Date:   Wed, 29 Nov 2023 07:50:33 +0000
Message-ID: <20231129075034.2159223-4-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129075034.2159223-1-muralimk@amd.com>
References: <20231129075034.2159223-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|PH7PR12MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 64cdb23c-e279-4e6d-da19-08dbf0afeee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htTeHBhxrqvkgaroQQVbVKKG6Pvjfsm9iMhwfhgjeu9AnaGpUGfTvqWM2gBTMMxsz/g2aoZZnzyDhx6gnCyQfOqBpGKoV5xoV8VjxSlrnBHSZdNCz8ZlmjCkd/18MvWg8nJtjVvyXU9XWHgQAAELIcc0YufpdoxiR4y4W5bEBTd1zUaY+WoAkxHOrCgV6j2EsENlkVV2hwAxADFloYLN+1fsLYqFv58dQKtLJBS9yV8UPnAIZgxS9BDumeShLx0n+32r+zCSwOH1Vlq4m+4SPicXsbTclPdd67TAeLupBIFYQFEix2vE7bms802F/0uGtcFK5PGJbiL0d55dpYIUfRpQBHYam13NBDsJx4FrIp4MFUaieFpNrmUxZiS6mjrimF2n9NMqBq1xmFJb6EwTg/Vw13v5xANh9Nazqdjrff0gxkQz/3W9sIr71OR68V4fKawCY0ScXl81wNNuI5kofd3Nfx4lXqS23qMDarW9wAvfLmgk8KVQ/t/DAqyKoVxGadrCZdYG7PEpKejmvticV8XlBZv+iq5YfxoSDPtzF6cAnNnRUo4EWglaO3f/IwiFiXRUGzglIDiGkgoozFj/25b94KwpXQjtTLw9KhlnL2ELGSjhRBs3ECT86nxAHtgCPsceiuJSmpVesDlNbgBrUcBn7iMkSj4odviycyTeTlQym33RwFiiqypzt8yLpLRrBHFqn867HknMr4im7T8KILPjUlIWX9IrHGQAPwrzKMdtLgIOTgwjVhPyrU8JjrDncjaovub+tmTcilGVgWPceQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(5660300002)(2906002)(40460700003)(6666004)(82740400003)(7696005)(316002)(26005)(1076003)(2616005)(4326008)(8936002)(70206006)(8676002)(70586007)(6916009)(16526019)(54906003)(336012)(36860700001)(47076005)(478600001)(36756003)(426003)(81166007)(356005)(83380400001)(40480700001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 07:51:01.9619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64cdb23c-e279-4e6d-da19-08dbf0afeee0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Create sysfs file for each FRU ID with a list of DRAM MCE address and
MCA IPID value stored in ERST non-volatile storage.

Read the CPER Record information at any time when the system is up
using below command of particular node or FRU index of sysfs entry.
Example: cat /sys/devices/system/edac/mc/<node index>/fmpl

Data in sysfs entries is able to identify the list of poisoned
addresses and FRU index to decide on the replaceble criteria instead
of iterating over the kernel logs.

Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Co-developed-by: Sathya Priya Kumar <sathyapriya.k@amd.com>
Signed-off-by: Sathya Priya Kumar <sathyapriya.k@amd.com>
Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/edac/amd64_edac.c        | 25 +++++++++++
 drivers/ras/fmp/fru_mem_poison.c | 77 +++++++++++++++++++++++++++++++-
 include/linux/fru_mem_poison.h   |  2 +
 3 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9872ede7eca9..3790adfa78b5 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2,6 +2,7 @@
 #include "amd64_edac.h"
 #include <asm/amd_nb.h>
 #include <linux/amd-atl.h>
+#include <linux/fru_mem_poison.h>
 
 static struct edac_pci_ctl_info *pci_ctl;
 
@@ -574,6 +575,28 @@ static ssize_t dram_hole_show(struct device *dev, struct device_attribute *mattr
 						 hole_size);
 }
 
+/* sysfs entry to read FRU(Field Repaceable Unit) memory Poisons */
+static ssize_t fmpl_show(struct device *dev, struct device_attribute *mattr,
+			 char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct amd64_pvt *pvt = mci->pvt_info;
+	ssize_t ret_len = 0, buf_size = PAGE_SIZE;
+	char *buf;
+
+	buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret_len = copy_fmp_data_from_cache(pvt->mc_node_id, buf, buf_size);
+	if (!ret_len)
+		return -EINVAL;
+
+	memcpy(data, buf, ret_len);
+	kfree(buf);
+	return ret_len;
+}
+
 /*
  * update NUM_DBG_ATTRS in case you add new members
  */
@@ -581,6 +604,7 @@ static DEVICE_ATTR(dhar, S_IRUGO, dhar_show, NULL);
 static DEVICE_ATTR(dbam, S_IRUGO, dbam0_show, NULL);
 static DEVICE_ATTR(topmem, S_IRUGO, top_mem_show, NULL);
 static DEVICE_ATTR(topmem2, S_IRUGO, top_mem2_show, NULL);
+static DEVICE_ATTR(fmpl, S_IRUGO, fmpl_show, NULL);
 static DEVICE_ATTR_RO(dram_hole);
 
 static struct attribute *dbg_attrs[] = {
@@ -589,6 +613,7 @@ static struct attribute *dbg_attrs[] = {
 	&dev_attr_topmem.attr,
 	&dev_attr_topmem2.attr,
 	&dev_attr_dram_hole.attr,
+	&dev_attr_fmpl.attr,
 	NULL
 };
 
diff --git a/drivers/ras/fmp/fru_mem_poison.c b/drivers/ras/fmp/fru_mem_poison.c
index c21e736c3ed1..bd85ae527c7f 100644
--- a/drivers/ras/fmp/fru_mem_poison.c
+++ b/drivers/ras/fmp/fru_mem_poison.c
@@ -39,6 +39,11 @@ struct system_fru_poison_info {
 	struct cper_fru_poison_record *fru_record;
 };
 
+#define REC_HDR()	\
+	" FRU_IDX| FRU_ID\t    | P_NUM | TIMESTAMP\t\t | MCA_IPID\t      | MCA_ADDR\t| SPA\t\t |\n"
+#define REC_DATA()	\
+	" %d\t| 0x%llx| %d\t    | %s| 0x%017llx| 0x%013llx | 0x%013llx|\n"
+
 #define CPER_CREATOR_FMP						\
 	GUID_INIT(0xcd5c2993, 0xf4b2, 0x41b2, 0xb5, 0xd4, 0xf9, 0xc3,	\
 		  0xa0, 0x33, 0x08, 0x75)
@@ -122,15 +127,83 @@ static u64 calc_checksum(struct cper_sec_fru_mem_poisons *fmp)
 	return checksum;
 }
 
-struct tm get_timestamp(u64 timestamp)
+ssize_t get_timestamp(u64 timestamp, char *tbuf, ssize_t t_size)
 {
 	struct timespec64 ts;
 	struct tm tm;
+	ssize_t tlen = 0;
 
 	ts.tv_sec = timestamp;
 	time64_to_tm(ts.tv_sec, 0, &tm);
-	return tm;
+	tlen = scnprintf(tbuf, t_size, "%ld-%02d-%02d %02d:%02d:%02d",
+			 tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min,
+			 tm.tm_sec);
+
+	return tlen;
+}
+
+/*
+ * buffer is filled with poison records information and exports to
+ * amd64_edac module to provide the info via sysfs entries
+ * /sys/devices/system/edac/mc/mc<sock_indx>/fmpl
+ */
+ssize_t copy_fmp_data_from_cache(int fru_idx, char *buf, ssize_t buf_size)
+{
+	struct cper_fru_poison_data *temp, *base;
+	int j, p_count;
+	struct mce *m;
+	ssize_t len = 0;
+	ssize_t t_len = 0;
+	ssize_t tb_size = 100;
+	u64 sys_addr;
+	char *t_buf;
+
+	pr_info("FRU_Idx[%d] Record information:\n", fru_idx);
+	pr_info("Record_ID  : 0x%llx\n", sys_fmp_info[fru_idx]->recordid);
+	pr_info("FRU_ID     : 0x%llx\n", sys_fmp_info[fru_idx]->sys_fru_id);
+
+	p_count = sys_fmp_info[fru_idx]->fru_record->fmp.poison_count;
+	pr_info("FRU Memory poison details under FRU_idx[%d]: %d\n", fru_idx, p_count);
+
+	base = (struct cper_fru_poison_data *)&sys_fmp_info[fru_idx]->fru_record->fmp.p_list_off;
+	len = scnprintf(buf, buf_size, REC_HDR());
+	buf += len;
+	buf_size -= len;
+
+	for (j = 1; j <= p_count; j++) {
+		temp = base + j * sizeof(struct cper_fru_poison_data);
+		m = (struct mce *)temp;
+		fill_mce_poison_data(m, temp, fru_idx);
+
+		if (amd_umc_mca_addr_to_sys_addr(m, &sys_addr)) {
+			pr_warn("normalized address failed for mce addr:0x%llx\n", m->addr);
+			sys_addr = 0;
+		}
+		t_buf = kmalloc(tb_size, GFP_KERNEL);
+		if (!t_buf)
+			return -ENOMEM;
+
+		t_len = get_timestamp(temp->timestamp, t_buf, tb_size);
+		if (!t_len)
+			kfree(t_buf);
+
+		pr_info("poison_number[%d] hw_id:0x%llx addr:0x%llx\n", j, temp->hw_id, temp->addr);
+		len = scnprintf(buf, buf_size, REC_DATA(),
+				fru_idx, sys_fmp_info[fru_idx]->sys_fru_id, j, t_buf, temp->hw_id,
+				temp->addr, sys_addr);
+
+		buf_size -= len;
+		if ((buf_size - len) <= 0) {
+			pr_warn("%s FMP cache Buffer full!", __func__);
+			goto out;
+		}
+		buf += len;
+	}
+out:
+	kfree(t_buf);
+	return (PAGE_SIZE - buf_size);
 }
+EXPORT_SYMBOL(copy_fmp_data_from_cache);
 
 /* Fill initial fmp structure variable during empty record creation */
 static int init_fru_poison_fmp_cache(struct system_fru_poison_info *p)
diff --git a/include/linux/fru_mem_poison.h b/include/linux/fru_mem_poison.h
index d3e567c990aa..d2642e1224de 100644
--- a/include/linux/fru_mem_poison.h
+++ b/include/linux/fru_mem_poison.h
@@ -12,4 +12,6 @@
 
 struct system_fru_poison_info **sys_fmp_info;
 
+ssize_t copy_fmp_data_from_cache(int fru_idx, char *buf, ssize_t buf_size);
+
 #endif /* _X86_FMP_H */
-- 
2.25.1

