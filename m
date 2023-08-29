Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA9878CB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbjH2Rn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbjH2RnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:43:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DE7E9;
        Tue, 29 Aug 2023 10:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4m5SN19wBU8JcKp7a+OoB4hict7L4RiOYQUvGrz3q/3pLy8gw1CDV6k9LyVrWF9hyCVCG7Wz2rvB3tpg6WTkzn5P2KlW2sKVCpmZWHo57zonIOFcQA4ifkjlznCNzN6NVmjbnwue9OQDFBfyfrGgcvjj+Ct75xHUrwVU0JMTUAqvyKopVbBb5jueMTRUfp0ZJ3ekcUTjL8konAy+dtmhwgfjPnlaRomOpGTuCadmpZLyaELSC38EAUp+slqmZGolac5hYwXo3Jn/I0C3dau5vcjTsih+EKuSMiNtyzG6wDfsQlKEbiyd0cThcuFZgt9p4gp7PzgxePwf1BlF7h5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU+MrJaQ4SnZSfyQs/lmJq5DQsCpTFo2mwjV10VvH9Q=;
 b=YOp0ZyDS7S8vxmccHgXm9Nhg2LNi6MoHicuKiRiiybPrQf3iNdJIzhQtdHn6o7GCSzD+BrGPSQd6UlwwVtITzeuet6MRzh0ef5OWfWTeJZm8Gq0ZYQbRiHvnS2QCuQoN/KrgkHW7LyP96uLgMocDQtq0iY/b7BH42LlVewImLnEc4Exc1MiYXdlPuRGjjk+HEcBzif79cpp9auRN8ohKZgnd60cWh9N7Hxs8ief4wji/M2rM+vh3SaOgq3618SzGdQIfywni5zEcp7LfbkWS94G2muYmZxNevJdBHMDo4LmZYZk1fEO22gEY9NiYm8wP4QhTBMMBzcViPInaS9l/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU+MrJaQ4SnZSfyQs/lmJq5DQsCpTFo2mwjV10VvH9Q=;
 b=PBr2Dbyu5nlBiXtN0LKFp12jSQ5rgocjKaRXVjLV2qQdyCozobSWgjGWLkIFmCrFnC8aLdap52O7Lhx4Vs6BG79NBnN0+hPXm4sjMpH3op6xE4TBr/4/Y590FFaXh/sqy4bMLWR4E/58nDta6YHJWqQQd3BUWc6GvcRCZUFGOxu2uIJuKSswsKy2U0YZN84C1n3pUeqo/rK8BNpn0hphElbddTu8DC3kR6RIbW2v+o5stNUbFIAgA9VZG+n+Nts2L0Y4wSmb0LrdxYg3dY9GTPsmCttGHZrChBnQlkPjiyTrVm3/1Y+6qYZCV/C0QLOO5fbLAyLmIuDlzJwDgElP3g==
Received: from MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::7) by
 CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18; Tue, 29 Aug 2023 17:43:17 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::a4) by MW4P221CA0002.outlook.office365.com
 (2603:10b6:303:8b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Tue, 29 Aug 2023 17:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.2 via Frontend Transport; Tue, 29 Aug 2023 17:43:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 29 Aug 2023
 10:43:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 29 Aug 2023 10:43:08 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 29 Aug 2023 10:43:07 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     Liming Sun <limings@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] mlxbf-tmfifo: Add some robust fixes
Date:   Tue, 29 Aug 2023 13:42:58 -0400
Message-ID: <cover.1693266447.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 737df1bf-b590-48d2-9482-08dba8b76d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEX4ReFeGvblWGXDrgNWqRqkFWRMmT/54VLoYyr1/dAqpBKuhNwA0SuP5WF7EWFZ+e/4/J5ABmBKDkK4W5DavuIA6NyG6IWs5mdTiyxvmsiYVZ6QDCwAEKkdtYz4hUfBp2j+1fk1CMvgy0GlkMtpdvGj1gF8t6XlS9uOjmC5wPq0c4ropdS2N+Vo3dQnfSa506D96FpYrSwvv+OU3UtNhluoKs8QnMvKjnWDZlxBP41qVIvdbDj5RXF5x5y2R+s2Of1lL+z7/b8b49klpKm9MrehMBM65/As6YqOxqvw8obyx74kB1yLRqi8dj16981a8uZfSQQ/Qw4kE+miz4BLperfeMcErW+jbqRND4H8zHFVll9m7c9lCAUe8VVl816kTfPhY87lDLm8cS6NVHpC/7I7X998bnmSUiX04f2Uugrx0CEO+XIjtyDbBTejKJ+Zo3Jb9yuTPqiFqtrlaRzQpAzwg0B/5wpBXmSkNwzAF1SpKtJdn2fvVKV75QYYVZtyXOMSEsy8XA9OSW9SzJIJtkm4AC8S2mEhAqliYFKz4oqNod7a5GAkDX6tpOXegX0ZrWvakHpYovN/cw4cM6upZcjfec+yUQEcpf+wFwUIck4ClMwz3FACo3czHaGPiQJVtY0kxnd/W5c0VNWEh22rdjq5RKDzbwDREGUM0G06tmACp3U/Djf7Gsz2FRj6qmqhx6kZRRldir0ra6zC5cQ2UWPYdPOun2QucBxyI3kUPT8QTHK2YeT4hao47z4cZXz5
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(40460700003)(316002)(41300700001)(4326008)(336012)(426003)(2906002)(83380400001)(86362001)(4744005)(47076005)(2616005)(36756003)(26005)(5660300002)(8676002)(40480700001)(36860700001)(8936002)(6666004)(7636003)(356005)(82740400003)(7696005)(54906003)(70206006)(110136005)(70586007)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:43:17.1547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 737df1bf-b590-48d2-9482-08dba8b76d7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series have two robust fixes for the mlxbf-tmfifo driver
syncing up to upstream.

Liming Sun (2):
  mlxbf-tmfifo: Drop the Rx packet if no more descriptors
  mlxbf-tmfifo: Drop jumbo frames

 drivers/platform/mellanox/mlxbf-tmfifo.c | 87 +++++++++++++++++-------
 1 file changed, 63 insertions(+), 24 deletions(-)

-- 
2.30.1

