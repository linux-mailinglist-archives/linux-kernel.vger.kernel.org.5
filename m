Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5FF792BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbjIERBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354587AbjIEMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:49:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C951D1A8;
        Tue,  5 Sep 2023 05:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz1B5YhB6ttswRph8FbPHZ71ZGGH4b8VopCb9co+GjLl4t2+rF09a6CMzuK1bQhDQpYRrIl4cZ+h66LXH0S2I5qja6ff58ofbvQjoHRdhL9F2SImxO0OIfU+7MOZ2iQcchJPdvH/HQKI/g71ip1+dhrri5B6RlBNPErhsbwkWRdj+KCjrLfCOa1MbT6THy2n5ZJXCcwI9lBqLggphPYGmFACiHHqNRv6WR+r92rPeCkj+HT462JFXpX2qFaOapOJyYFJLBcHaxsWzz153R0PhvnfYwlfprUAKqLMMFVGNgNLMQW07+4/AztTbZodDuQWuOOT6NrhENOHRbIbq/x2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9D1YaNncJa6/g2Zv5Bv4GmBDt/8+bEzO3PeBg99Spcc=;
 b=EQ6pLq9mCxZq+mLS+zSTQUNgO74ze2kg05G3ORXKUN8Qeipda9TP33OmPFTShsWi4EsxVJTnLfVhiifxSVTRxSP5p3/nGSafVf68qwtqgRC06wjDYOPEcZtl4W45xl4He4734Qlz8BbyT+DqK+Syz4fokdhkIPDG4YHfFkzoGTBHN4aBlMoGGnP7ASAx0KhA+geahk9Cmv7QV4qYKOdSHDgevmlGOFVDA0agQ2iTRX0cRefU9zbH25AMJAley7VloNzURCvCOFtaxUYeNAx/8IxkqZ0NccJXjIZToW/P2vUnLKryt0ePudKPa2RRw03UKWcfY6vulfUezHVC80jvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D1YaNncJa6/g2Zv5Bv4GmBDt/8+bEzO3PeBg99Spcc=;
 b=OP1Kw0o+M8CY7J6zPMxgOiYUIqBlauGJ6TnqwX7CHjs2UZ//E7ZKksz6iTs30U9Cv/5lb4zyGH9KS+RxW2+xhfHzoHFpEW/Tqlq1O8ci6dOzj8dJEZVT84pfbQQGPQRljKZqTpb91LQ2dcoIY3MGzwRCNXg6/IE5l4mr7kljT54usgjiavZTkUqgcSQQa/1c3sDdRGtdThF4BOwQWx/p0HCXvkp62002oEMaa6AYtH3UyCRN1iHiNXtctaZ7oC8xhGOEFFWNBAFcz0rKzW4KEdZu58x59oUGtaUqInTWoovYtfQgVwqNzRUdvrmOPDPAtur0EcirBzYekSkRS14KOA==
Received: from CY5PR15CA0091.namprd15.prod.outlook.com (2603:10b6:930:7::10)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 12:49:39 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::86) by CY5PR15CA0091.outlook.office365.com
 (2603:10b6:930:7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 5 Sep 2023 12:49:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 12:49:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 05:49:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 5 Sep 2023 05:49:37 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 5 Sep 2023 05:49:36 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] Updates to Mellanox PMC driver
Date:   Tue, 5 Sep 2023 08:49:31 -0400
Message-ID: <cover.1693917738.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c29283-175f-4c5a-8f4f-08dbae0e9170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hc+2/IJv4y9627+WMjFWMgdkxOnm/uaoCpdDjUwHDpbT7Xs5a7AKKIoXBLLZKyO2c38oKy5JWQhxmogvA8OS88+AM9Yik0GAtZ4k3dkk3+5Ua9eTj84aEkDJeqE+0IJboSk2Z0m6mtYfPIEFRXHR6Ml2Ji9cNRzLm/fcfloRcrGePZLoquO6xdK9X+U9ooGiqKgGqxGYahklAQaBo+0x8FjWqWdRp8ZZdv/LxQlTg5j5GsR9q+2YY3sVnMxXAwPwbFtrtJqTGaNFwsJZLpPFjb1udcWI5c2fqbHwSaTlc6AICFsJ8qFMDgsc77ZjWfDst9tSqlcQnCc4z3VTFJHSed+zV26Sg8+/z3yTQCGXfXNk/e8856jTIGMwvBz46LmalYk/r2NJIYEpgQejUyJ0faISiGBq9t9Qqt7emWf5/Y/f1n2nZ2kimCZPiOyltIY0SlqPncN/hMS/Z9C3f1XeA8To6pwB1mKZtqm7YIhO4vqkAbyNTD7TSgA/X7Fy7bi5/W2kAYVw+ssxLaNKzFVToHEmpXA3WEs9jjjSKy72ie+WLreo0vaF+GP6t5tFTqgZxwPwLj/K+fXea1YuZEJQuMRK4VeDIlgRUCjeZNAAkCiJ4mN4oHyKg5MiJQFizKER0+WhJBRKjy91qf0vB1JSWF11a09+N8N86wrFISGXdG/DPK9rXTgCQsCPvwdHChA7/RLPL4sTS4rI7Ug/Vgnr1SRpKT1jypd2mj1keAXuC3dg2tERRaUK6EBJIya/UNf6
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(7696005)(6666004)(478600001)(83380400001)(2616005)(26005)(336012)(426003)(4744005)(2906002)(6636002)(54906003)(316002)(41300700001)(70206006)(70586007)(110136005)(5660300002)(4326008)(8676002)(8936002)(40460700003)(36756003)(40480700001)(47076005)(36860700001)(86362001)(82740400003)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 12:49:39.4811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c29283-175f-4c5a-8f4f-08dbae0e9170
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This submission consists of 3 patches:
1. Patch 1 replaces sprintf usage with snprintf or sysfs_emit, as applicable.
2. Patch 2 fixes a bug with reading unprogrammed events.
3. Patch 3 adds support for BlueField-3 platform which uses a different
access mechanism.

Patch 3:
v1 -> v2
1. Fixed naming inconsistency with events struct
2. Replaced switch case instance with if else as suggested
3. Used rounddown instead of calculating the value

v2 -> v3
Removed empty lines and added Reviewed-by tag

v3 -> v4
Added macro for crspace event register size
Changed line split as suggested

Shravan Kumar Ramani (3):
  platform/mellanox: mlxbf-pmc: Fix potential buffer overflows
  platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events
  platform/mellanox: mlxbf-pmc: Add support for BlueField-3

 drivers/platform/mellanox/mlxbf-pmc.c | 727 +++++++++++++++++++++++---
 1 file changed, 668 insertions(+), 59 deletions(-)

-- 
2.30.1

