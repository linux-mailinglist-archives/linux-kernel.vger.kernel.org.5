Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440D375DBD6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjGVLUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGVLUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:20:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573AC30E3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK0zBrPVIgxs4piW1AVVS91nRokxDcDTfdJkmZfOVwswcTvHoLraGyg6SBlvkFjllECQ/OU7yDglXj9dFnucszpd2KCSe/uuZxm4OQ3PaFFmorpmBKvPbEYf4i55zSLyQ2kYr+2aULx/FueAFXiTaV5si4/fWk563QMAfArPrC0newh+U7Ilb/f/x/9JJ5EtJItRDsj6aNzNLQPdB/ZVRAFowbOlM5llFP0mxlct182HZ2DB8InvbvV/E5F4NDTntePVS+0y/hJr24mIqgwa3D1y/NKGq5guMMYOArC1Fgr61NlOC9rk3fMfWP3yjIvCpcqmQ7UK1rThCbRIWIpxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuBmIhqf5s50MDqpiNEq7ipa9JYgkOBMMnMLOaInExY=;
 b=ANH+wfKkcZaErbH6v1qevRwjUnc5xuOE9DyMRy+FcFe6RQno1gf4IlftmD4NV5VN4AlDquZyZS4a8aN7ZgMxksF1LAUyOyrSE1AmRZ4J8ONXRlpKsTye24zrn7Fjf15CnCH8VBMFb00ynAECK0Lg5DnDg4Swarp5zzSyVUJthNZxRP4hX+Rpk78i2by9Pitc4UJDr6EjyID/BsqLU+or2Y6rnzd+fmtXSdcR3FX0kKJaLlwbKVZhCGRWzyIOS4ZWPBCjWvMuhUR2BvEtcY2G/fNggApzkxkN/LxfbaVOriaO90ZSID1iASSllBRFY5cbJJe+T8n+V3dlX9TdNfA/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuBmIhqf5s50MDqpiNEq7ipa9JYgkOBMMnMLOaInExY=;
 b=BVQZ8T3LagNNC0prDWT2cFre/cSH/UD7gHeOR1pc9w8GHUIjykrAPtXom4DHhExDnjdhEnxMD8Ecr+uUnH8yG9FvJmubuW53Z/3THdAt09fLGWrnqdEQ5f2JQAYDDWGtWnZzfkYar4e+qlnlF1qZo1JGM90sAbqno1YHlF3zwlA=
Received: from DS7PR03CA0143.namprd03.prod.outlook.com (2603:10b6:5:3b4::28)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 11:20:20 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::9d) by DS7PR03CA0143.outlook.office365.com
 (2603:10b6:5:3b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Sat, 22 Jul 2023 11:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Sat, 22 Jul 2023 11:20:20 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 06:20:16 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v3 02/14] virt: sev-guest: Move mutex to SNP guest device structure
Date:   Sat, 22 Jul 2023 16:48:57 +0530
Message-ID: <20230722111909.15166-3-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722111909.15166-1-nikunj@amd.com>
References: <20230722111909.15166-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT092:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: a218a749-b854-464f-54fc-08db8aa5a273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QL+8uR6eSgE+9+rrX9gB7Am3d1AU3hMQpIwz0o/iazLnDU15z+j91AnbXcQzobdw77634fqg333Q68hkTvJVKkNM1Ak4Hw1m3JAeEqlLXltH11rAWYEyeSMxsAKcV7k0Fm9Z1KrLKC6JEuycpoJahOiMDzDpKOgOeoBi94bR5STul8M03Mc48AoNjH4LBL+O7sKoRCzI6Cz2fEWdJgJzPXlfZYOzV2DQ5Yw+vG7qoduJZXSHQWIHhIT3T9QCkGh8USc+Z/TOluXLkA6uGqFWKA+fWrd3H7imj0BlarzUiJFsBcmjj4PdMjK0jRKOUTjNpyRk40WQRzKWQtmf3d/0J3bc77mutR7SE/Zvw/QOg7MtSxx7srS++hGuaQGmfS1CcRZJlKcuUhJtjvj4DbIjImlfCli6PZbH9u9RBgLRRc5IZ0XDQ0OoWgzhOA2Nss/evn0qiGZx29EiANFwozA5hUfeZHuKcHPcGdoCLe5MsXHWn6hSIPo9PqyzYDmQtz+7otzdd1CJ3WcAed63rJO1m7uvTJz5PB0TO4n6nR/5VHMDmHzsKQDxzpHb3+o52H9xYQ4nbrwysLqU0GYRA3H531iuFHpmCFrLCbhoy4qfedO8vNWs6L5I5/qKah6eWfCoy/IQk/4QiPYFWwuKKhTrChkNy4BiXQVljAFtCSlsCvxIFsdZ+hOxP9FHHTVOpbBV5EDGdyR2vk8FtPyBV0yJeYDgXLubSC3X6KLro10NGtw36svLBlgdqpWcBn6S/nylALBxnWQMAOyhIaVo8rwCqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(83380400001)(40460700003)(36860700001)(2906002)(2616005)(47076005)(426003)(82740400003)(356005)(81166007)(40480700001)(70206006)(70586007)(4326008)(316002)(41300700001)(1076003)(186003)(36756003)(336012)(478600001)(26005)(16526019)(110136005)(7696005)(54906003)(6666004)(5660300002)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 11:20:20.2136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a218a749-b854-464f-54fc-08db8aa5a273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for providing a new API to the sev-guest driver for sending
an SNP guest message, move the SNP command mutex to the snp_guest_dev
structure.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 520e2b6613a7..8ba624088d73 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -35,6 +35,9 @@ struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
+	/* Mutex to serialize the shared buffer access and command handling. */
+	struct mutex cmd_mutex;
+
 	void *certs_data;
 	struct aesgcm_ctx *ctx;
 	/* request and response are in unencrypted memory */
@@ -56,9 +59,6 @@ static u32 vmpck_id;
 module_param(vmpck_id, uint, 0444);
 MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
 
-/* Mutex to serialize the shared buffer access and command handling. */
-static DEFINE_MUTEX(snp_cmd_mutex);
-
 static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
 {
 	if (snp_dev && snp_dev->ctx)
@@ -107,7 +107,7 @@ static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
 {
 	u64 count;
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	/* Read the current message sequence counter from secrets pages */
 	count = *snp_dev->os_area_msg_seqno;
@@ -403,7 +403,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	struct snp_report_req req;
 	int rc, resp_len;
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -443,7 +443,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
 	u8 buf[64 + 16];
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -481,7 +481,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	struct snp_report_resp *resp;
 	int ret, npages = 0, resp_len;
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -566,12 +566,12 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (!input.msg_version)
 		return -EINVAL;
 
-	mutex_lock(&snp_cmd_mutex);
+	mutex_lock(&snp_dev->cmd_mutex);
 
 	/* Check if the VMPCK is not empty */
 	if (is_vmpck_empty(snp_dev)) {
 		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
-		mutex_unlock(&snp_cmd_mutex);
+		mutex_unlock(&snp_dev->cmd_mutex);
 		return -ENOTTY;
 	}
 
@@ -589,7 +589,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 		break;
 	}
 
-	mutex_unlock(&snp_cmd_mutex);
+	mutex_unlock(&snp_dev->cmd_mutex);
 
 	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
@@ -708,6 +708,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 		goto e_unmap;
 	}
 
+	mutex_init(&snp_dev->cmd_mutex);
 	platform_set_drvdata(pdev, snp_dev);
 	snp_dev->dev = dev;
 	snp_dev->layout = layout;
-- 
2.34.1

