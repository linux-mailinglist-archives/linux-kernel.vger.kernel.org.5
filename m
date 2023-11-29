Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179327FD017
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjK2Hu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjK2Huw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:50:52 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0481735;
        Tue, 28 Nov 2023 23:50:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjVKVNkLpdzRXRDF7+PX3FJ1bJVlqxNC/UfI6fadqO7HGpqq3NB3i5NDqxmcbdEei70aNmp17sBh9f5e5dVxN1tznftUfewBEyZYPPwS5TgQahZaEHqFGTdwVx0GXTJehdhPiyg5JL5doAip5aw3WPvp7yEL2IgSSbvhwmMPAwhyqDlqTU89hBA3XanMFVQA2OawmclidjiI9o6R4dhQKQhLFbBycLnYO4Wecj5pZTEWN5xkyhtk/uU0yapxP4C9mQTvKZpfurNc+UFIdWkryHfT8VlDP6gqWHkP0BrvzCLjnxbWsCpo4MS5ykVwuIjDgQh8EkmwinDvBzjcDvg34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMrFiyxcTOSZ/ViouC6jy/SBXPzqRbSnzbBnesNzb4I=;
 b=Bz6i2UhlNY6NFwZI3C20gY6sCoYq/9hbydFvZ3fGacOv+maGR2/RYhYf9PZ/COjAcabRguMp9tN/dEES7GK9b/BGXDiydEWoOti0WeqJDmdvs8u90T3mc99ZrRhcrwJwK6nzcQhRqddV04MW29h67bhXxpLjJP+6TsjFI4fCl7WmZoRC8q3lKSznlZtiF54NkK7CmzNFESm6tnpTzLr9Zejhsb7YD3fBcSAy+4ZkNe2cxWs3d5wSwTw/VB9yIZHoCL0rRBH2GTWJN1r4pSpWRHw5UThZPE98yzM5f7BJlfRadgMGeYlC8iNo5e8IpQV7KT1gblGH4LrH7yZUpwIM0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMrFiyxcTOSZ/ViouC6jy/SBXPzqRbSnzbBnesNzb4I=;
 b=VaB5cmF7BUdvl63oD/XA8UJIeNB/pngobzRVOW0BD9FOCpP1rwlozeZ4Q6bW6WZH+qPFpJUukEsIQzyAfHKKPwNqZUV6Bsbz0k+z4fJq5v72Yt7oUjTdtUC+OKhzaky7OjAC0OWebWu9ephAICkgVXJfZS1zgU51UNpj9l7eaUY=
Received: from CY5PR15CA0088.namprd15.prod.outlook.com (2603:10b6:930:18::29)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 07:50:56 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::63) by CY5PR15CA0088.outlook.office365.com
 (2603:10b6:930:18::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 07:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 07:50:56 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 01:50:54 -0600
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>,
        Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH 1/4] ACPI/APEI: Add erst_get_size() API
Date:   Wed, 29 Nov 2023 07:50:31 +0000
Message-ID: <20231129075034.2159223-2-muralimk@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 355c11a0-cf22-4737-7f55-08dbf0afeba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GPvlGL/X4FJxTFrJdY+3sZVm34YGf/o7Bg3hCemCJPUmqwUddVhwQIkpEnDw0u3TVuFU1oZ43PO2OrCqlsl6nOFFdGDCnjROCz35X2bTHdPHdrgOORUQcINB1YlIobFSMgTntspWAnqD/l1nrh3WSqpD9FwY7/xzvNagnBLz9VzRd3hshkKEyk2Q+kduGMxvZFtsT4XVZvRwzqlBwkT9Q7meZrDpOQFSRsUmx9e9n817/FXt8hB67pqFBwlIA7BexnfFKZR5VKdhrXBO5Z8FnEvLVxXQY0v+c3LEoZPdQcmrBluqgqjrMTceED1uZin9yOjnmmXpo5LrYOCk5JwZdXSNwPL+NZ4JfoitpxQyDcMIXCoMbZ9Uem+gIM+baxdK/ZusvWXmqcizi27Hv+o85ohCf0+9f8YmnA6SsFMIEC10PhJpHJwJU9EvRDYOaj0xbEVTOgx/eTovt0fM9DWkLTGAMcf2klXFqu4PWpmkSrDYwD0vpJibCVw3VoxKDxRUOYbB5OjbFoZjQHNspAdj+jiwrXyJmFU0/iX1CA4wA8v7LLSOzyhtF3g/I1bNb9dtSQEh9zPR9EUb+l/8hNJqT8QZKB/WWEi9JF3wgB/jfrtia3kzLozPPGvzkr/4H1sTBPTu3K/ES72qkFa2Q/LbsJlTs7V+v18szCx37zNl7bTI5GrNjJYEnXH0HNMRKZKpVokG1ZZBfi00bMm0f3NMdnq2iN6Ms3pGr00B1dtwb+JuDu/+mLbbknEjrr1b33BVlzHM3rQB7eSUBJ0AbzmayA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(81166007)(82740400003)(336012)(426003)(40480700001)(16526019)(70206006)(70586007)(356005)(4326008)(8936002)(26005)(8676002)(1076003)(47076005)(316002)(54906003)(6916009)(478600001)(6666004)(36860700001)(7696005)(2616005)(5660300002)(2906002)(41300700001)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 07:50:56.5267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 355c11a0-cf22-4737-7f55-08dbf0afeba3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Support API for size of a record in the ERST.

Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/acpi/apei/erst.c | 9 +++++++++
 include/acpi/apei.h      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index bf65e3461531..aae1c133095a 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -420,6 +420,15 @@ static int erst_get_erange(struct erst_erange *range)
 	return 0;
 }
 
+u64 erst_get_size(void)
+{
+	if (erst_disable)
+		return 0;
+
+	return erst_erange.size;
+}
+EXPORT_SYMBOL_GPL(erst_get_size);
+
 static ssize_t __erst_get_record_count(void)
 {
 	struct apei_exec_context ctx;
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index dc60f7db5524..3b34f463ea44 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -41,6 +41,7 @@ static inline void acpi_hest_init(void) { }
 
 int erst_write(const struct cper_record_header *record);
 ssize_t erst_get_record_count(void);
+u64 erst_get_size(void);
 int erst_get_record_id_begin(int *pos);
 int erst_get_record_id_next(int *pos, u64 *record_id);
 void erst_get_record_id_end(void);
-- 
2.25.1

