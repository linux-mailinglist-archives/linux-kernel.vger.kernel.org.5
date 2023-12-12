Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8580F733
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377274AbjLLTw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjLLTw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:52:29 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196019A;
        Tue, 12 Dec 2023 11:52:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0aLrDY3J6MGfRkstAIzF/tkNPjR9FR2WID5f5Jds6SZO3N7X2L0SW8ja7PA12PuarPUXKcSN5JjB0nRVszllwF7zBkHsU9aCtrJ8SdqxALb5pO2N0fXGVRNu4w4KGY+DriaiwGfRCISr1ljKb2jUw/40X2U4mRYK5/jDS2TfSLQBiH2J7F05suRmEn8SNYo7ubFpYbvsbQlNikpx1NApYAt2eYdOryw1Z7ggT1TeSbSxdZAxuLCCe6vLPnkuCKo6gbUx1u+8J94/oipot3subg0kXDjLvZPzD7rXEH4uI5ewUrBXsan5SL+rurJ0pVCKtXNnqmOJIJ85Z/xS0mpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCa5NqkaJeBpWPopOR5Jxf9F+fy0B3qL3L79FO1rkZ0=;
 b=A5LvHcFI+BhUomPa6sJCLXSfOpTJerHVGJPgCo3pilJ3a+Tv3A7pRdDIpUkHGvv8A34ysYAgcwtGRmiQEb3+OI6Fz6y8DT/JTto2Gbga/BdUMUFqPK8kclm/pUTiBOfL2dF8u7jB9/YpG2HWp6c3h6KyDSSx9P/u6ie7gHCw5+9cfkUZUae5nlsElAUCzREKFqYjlop1QN+MnYdtK1dlXbAhQg8XLBWzldzVl4jAf7yN2OPwDaMvR9xmOWjlMPlZ6P2InpmuZCU41fsOBmYFuJbIU5+zy1SbpTVJHBUvFkuHriGrj8+ytHErh5/b0tteRoncnZlolegRwMkF5celWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCa5NqkaJeBpWPopOR5Jxf9F+fy0B3qL3L79FO1rkZ0=;
 b=TvQRiW1rCiLn1PPqVVWVsbZu1WXEwoepmDUr1PY7mb4DH468F6sDozpzplCTGNKP/uZ3KcSoDF7oOQr6sKqAv/V/jQBi68GBJGcT8vxVihIAtsDDeu/+o57A2eguwErIVSbL7tuZDI9JIiM5XLRnfXw4emHJaelwXzDSFOlda98=
Received: from BYAPR11CA0078.namprd11.prod.outlook.com (2603:10b6:a03:f4::19)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 19:52:32 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::40) by BYAPR11CA0078.outlook.office365.com
 (2603:10b6:a03:f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Tue, 12 Dec 2023 19:52:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 19:52:31 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 12 Dec 2023 13:52:28 -0600
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <linux-acpi@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
        <avadnaik@amd.com>
Subject: [PATCH 0/1] Tool for parsing the ACPI PHAT Table
Date:   Tue, 12 Dec 2023 13:52:18 -0600
Message-ID: <20231212195219.2348858-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 078cf8d1-51ae-42ee-0dc7-08dbfb4be0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRBRcTG+0lkvLkHiaSxiCZYQCReEYqa/+vTqAldToXYIsptqsfmIoML84nJb4mqbEnrPzSYCfN3GxnXlks1K7r6AUZ851Y2u705tSAnDdxl/1rx+C38F2yz3uTbeK6EKEg+ylrakAjuYSjWfXZJ++IvA6NifPbGOmwWv0wrgM9DE/ekxFVyN4qs7PJkrbXa9QZ/cLK5q8UP3mYzR2P2QqU3Q36GIdj6+XSyfJPqqWt1qnEqBnKfEPPbswBRCpQL0Ef/6YHajXDH/xCA8XRVojwMUIOtYS715G6Cs1lRspD0GDoAjHmntZWbGgwVZ3ysT9uWZfgCSeGUkVS4u9mjogwbP+8LKeICM/A9Q29D1Uet/GWUZ+4Z08KcxZ6jHnB4ppLhyzvKDSeWh7xX7hOyWPK0co6vEeE86LCZFvcRVTyqX6N3Oob550BdRccVdsfKyFxzCLLnwLNC1JNStabL2OFmcCOLvsSvElIY77YXrbCgTd0ru9F9M0+nqzOgGiwbkct+LEZ66RZDP9FKgmTZ94L8q9DZunZYQRVCardGcAY9LrjF5WZj+FlEPSmPPlsTK73nK431zYFyTVjV8AyVfkny81k9oPrXxGcKSovIIo+sN/Y0hPlDPFmg9XZVw9pDcVEnh34tiFvCIvDpDcpFnzRHvuvG6h0AEK38xe9UESheFr5nxc1JW2ub1eZ2Yj5+FSXw3ecbKOHLViv3fI8dTNRzDk/VVq+S0FIJiybqAnaqkcbT1QMY6WP83D6xSkMk29104Va8vFInvWc4h2n78sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(426003)(26005)(2616005)(16526019)(1076003)(336012)(6666004)(36860700001)(5660300002)(44832011)(4326008)(47076005)(478600001)(2906002)(41300700001)(7696005)(8676002)(8936002)(450100002)(70586007)(54906003)(110136005)(70206006)(316002)(82740400003)(86362001)(81166007)(356005)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:52:31.5877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 078cf8d1-51ae-42ee-0dc7-08dbfb4be0e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Future AMD SOCs will support the ACPI Platform Health Assessment Table
(PHAT) to export an extensible set of platform health related telemetry
through Firmware Version and Firmware Health Data Records.

The table will also export the Reset Reason Health Record which highlights
the cause of the last system reset in case of both expected and unexpected
events. Vendor-specific data capturing the underlying state of the system
during reset will also be exported through the record.

As such, the table, in general, provides important debugging information,
supplementing the existing error reporting mechanisms on the platform viz.
BERT, CPER, etc., especially when debugging unexpected resets.[1]

With that end in view, we developed this tool for parsing the PHAT table
on SOCs that support it. However, we were somewhat confused about existing,
appropriate projects through which this tool can be shared.

Any recommendations on / pointers to projects through which this tool can be
shared with end users? Will personally work with the project maintainers to
have this tool incorporated there.

TIA!

[1] ACPI specification 6.5, section 5.2.31.5

Avadhut Naik (1):
  parse_phat: Add support for ACPI PHAT Table parsing

-- 
2.34.1

