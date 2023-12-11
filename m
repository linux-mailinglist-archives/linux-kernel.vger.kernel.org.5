Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0657080BF41
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjLKCi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjLKCiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:38:23 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179F710E;
        Sun, 10 Dec 2023 18:38:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikMgT2FmEUQauvN5Nw+fzTaSw7omAMqF9OKJsuyDDpZ8Ih61s+nAlTTH3KgFfiLgEGog043TpGKdlZrC/kUtVcoDiit8myvBTz5YJD1cmhMru3cmGwpT315bQJkf27sbgCCVgg+PqhtdN+W2EWDgdib9rt1G4L1RPTM3cxE3G3iDC9Td3Qo2qgh/QrLCTtqrH5iC4yzQekvSzqK6VlvQ/8EtQb61L9nR1rLqkN9plEHJz4Iy3o69Muyp3BFMlXtLE2BSc99jq8oLUSEfxFKObtWSF+bX+7Y4FtjMhyxLk5kSeRra4D2xKymdPEhU7bXyG9Nk/ZFbQw7vlKekkrkrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONvhk+ALydoz6fyhdJyLHUpg0zfbwT5fqyFcyfHW8vc=;
 b=a06zGcF6lQcs6WT0s5s7ISTbBtFl2CnY95cNmpTDFbAfmnk0uNBt6FDgw8AtoiCtIc2INKyrms2YxoFbEDopLMfsa/KKNdZUeIAhCT8SOtfEx+riSuRutqTQACQyTbO+ncT/v9cEiIu1ruMBvJSxh2WO65KCJaIm6uQL2RAfs7dkfBR3f4hJZu7TRhLFVZBI1GIrrfn69Ik432mg6LopKa+hl0oalKnikxeWk1SJrt9xoPZHNvnWfwrpAD7I19/yXsu0mC5Gt/37d7jMJykchx/8WACC1YHB4af7QW3yOpcNYwypI26qZlUNduVMSFc1zSsdEI1HFK41HKglKa84MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONvhk+ALydoz6fyhdJyLHUpg0zfbwT5fqyFcyfHW8vc=;
 b=K7PAr+1+DtEHXwt2kdyb69CJyxKGBpjZfMsbzuIODBNWenslGZWB8ttOByt1W8hS1UJePTwcgMUMdD+02hhfyq1NrzYr8mb5fh1NGouBNA8mM2B8i8st1xGNlxQ2JShcP7jh72DnfcObrnXbFq3kR4ozfyKYze8tfQo7oA7bmt4=
Received: from PH7PR17CA0021.namprd17.prod.outlook.com (2603:10b6:510:324::27)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 02:38:26 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::f1) by PH7PR17CA0021.outlook.office365.com
 (2603:10b6:510:324::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 02:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 02:38:26 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 10 Dec 2023 20:38:25 -0600
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <carlos.bilbao@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH 4/4] docs/sp_SP: Move howto.rst into /sp_SP/process/
Date:   Sun, 10 Dec 2023 20:37:30 -0600
Message-ID: <20231211023730.2026204-5-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211023730.2026204-1-avadhut.naik@amd.com>
References: <20231211023730.2026204-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|PH0PR12MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbe8e63-e392-4db0-d105-08dbf9f240c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qo0JYcgvxaK1KBbDo/uV2E52biP/ulPq7C6Pkl4szpV8IwI04CZgkUlxt4YOyE1PBE8jZY4m8LWSRlsPBTGTqfbKZseR7duh02HlRuN57AgRjqxJ+aH4OLxSf31aobGjxMNDIqeunh9H3hINYaW5EmlxxHK0iB2ZrqQwSak8vXc+UBabHQuXgsaiAqqu996zzRoWZK1atr63nBYVS3iabW0J/CNWQqlkuEd/IrkCcuoCG+6K4FcoNIua+x7TQA0OFOsyPBxsYbvNrVVZZhifHR4cAzZRUh9aSb+GTPOsVK6Z2bhwXb20bd3rtgNLfz9aKM4wYnLkSO74YJBtUF3poeiqzeu9u9iZKtUn99HWNpCUHU9innWRUV7iDda5v4S0snJkkmlaIId6kcheEQ3c2YuvYe67UpAvPvzHJFYOBW8dRHephVFmz/TEg83MijxFxTKYR9e5At96spN8gSTrxHbsC3YSuzpta0x4n654LnwzKJQUyLgH5j7TAv4grnLngF3oWDPbk80c5t9o8KyGJBz4ZCe7al3TpQ2SCvUP04PljSo6HfYFs4w7VbYbi6Up134FExZH/cRIR1EMJzJg9tnSJmhSBoPNQF2EFSeWrtu8Hhp+pmmAMyr8uZLZD3GVCrDYfZZz0MMDPoP0uzVRuNA1o2h4Qrc8hbhCPvsPj8RwmAXzB4Ousf1hLx1qPyDO0lqcD0eb59mhCKEvdBOoI8BH+3elZQNsXsuitD/cGHN0Ps6OgV5EbSIVHII1aflebUCaU/1FPuDTO1a2yULUMRprz6etVLO9xCuIavX0ehvJFTS2NfDz71F/+2xyJZi2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230473577357003)(230373577357003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(46966006)(40470700004)(36840700001)(40460700003)(36860700001)(5660300002)(1076003)(47076005)(336012)(26005)(2616005)(16526019)(44832011)(36756003)(426003)(70586007)(70206006)(6916009)(54906003)(40480700001)(2906002)(83380400001)(82740400003)(81166007)(41300700001)(356005)(478600001)(7696005)(86362001)(8676002)(8936002)(4326008)(316002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 02:38:26.6252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbe8e63-e392-4db0-d105-08dbf9f240c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the howto.rst file in Spanish translation to /sp_SP/process/ to
ensure its location is symmetrical to its corresponding version in
English.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/translations/sp_SP/index.rst               | 1 -
 Documentation/translations/sp_SP/{ => process}/howto.rst | 2 +-
 Documentation/translations/sp_SP/process/index.rst       | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/translations/sp_SP/{ => process}/howto.rst (99%)

diff --git a/Documentation/translations/sp_SP/index.rst b/Documentation/translations/sp_SP/index.rst
index 5c2a2131524b..c543b495c042 100644
--- a/Documentation/translations/sp_SP/index.rst
+++ b/Documentation/translations/sp_SP/index.rst
@@ -76,6 +76,5 @@ Traducciones al español
 .. toctree::
    :maxdepth: 1
 
-   howto
    process/index
    wrappers/memory-barriers
diff --git a/Documentation/translations/sp_SP/howto.rst b/Documentation/translations/sp_SP/process/howto.rst
similarity index 99%
rename from Documentation/translations/sp_SP/howto.rst
rename to Documentation/translations/sp_SP/process/howto.rst
index f1629738b49d..dd793c0f8574 100644
--- a/Documentation/translations/sp_SP/howto.rst
+++ b/Documentation/translations/sp_SP/process/howto.rst
@@ -1,4 +1,4 @@
-.. include:: ./disclaimer-sp.rst
+.. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/howto.rst <process_howto>`
 :Translator: Carlos Bilbao <carlos.bilbao@amd.com>
diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index ebafa0e6055d..2239373b3999 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -27,3 +27,4 @@
    handling-regressions
    management-style
    submit-checklist
+   howto
-- 
2.34.1

