Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C2477EE7C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 02:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347405AbjHQAue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 20:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347415AbjHQAud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 20:50:33 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71BA8E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 17:50:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR88U5C8CzDsefjOFomNm8G+X7UTP65DYHyp9dJ3mOvsYwN9ljnk2zUYKXNfxE8leG87kkXsb8BK/Njqp+XqTgJbfmNpOoWUPTmTPkEEvDB8qiIqrqy78GuBfjZ8nsJHNW3FXRaLZ8Cil/m8OL6SmN4kQQQc5i1yOGmJbRt7xk2Nr53yizD2nvsd+w0ENoqgacPBYIDetmnzmyS2xib4oFS0bgApa0OtzGHaifBJLLqKWuPJD2y7Txc2/IwhnYmsaUo8gFQHmfprkqVySZZ/WfACbQapmENt9E7fJBs4m6plW9bfM4avdVI3zhsQJFMiPdG/5+YWwPzb0R4ccfLPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdqXDQNm8qOj3fRYIOCHjH5hBAaDDzxAQCL66ZaIPgw=;
 b=RiAsOesPMjzQcNu61gM0OLZVUkvMS8QhOj78w3nRrUcpTP4Dp2PwqYg+iFjPy2PA1n0iRu+s78aANPEacQAPdv0RSNlbqVUQmFzce4PCABrmE/zoUkzTUwc7cVE/9vcqRs4zAq6kug5DJK0MNh7U6qlZi10r8guwGODtFJqx0ieVLUxkXzWjcNmNqAnndACqg2vWFqOZmYoc0TsCcsL5iArcL4y8DdpPCoK0zXDO1M5Z1Tgg7xAeWN8LCsEzTA8E6bCzgPubtal3vfvAqjrAC4AtHCvk/zXFnSKRoeWSvl2jzcaOAgMoj+yVtzsu8c0L9x8nKbP2atDp6Kiom3e6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdqXDQNm8qOj3fRYIOCHjH5hBAaDDzxAQCL66ZaIPgw=;
 b=om3/gtV3wzUs2nz0mb8oX36uagBVMPKdDXdn72n7/Lz/dCZ8FVfAgBvw9TA6DMYl9vKktS+vaNdbEFsQogn0tbQR/eSfmh24/RmufFSxc9KMJ+uigG+dgj4EGpBwfycGRFpe0fO+T9FX0uwIrQ6hpMoPY4jtMJCvooNarpsVguiR3V2bKm30YS1CCl1wSg6s4XcE1/VRFh6vP5sdry6YZL9HqrD5Tf2mijO1vTxA21MGyG5aSmDE1ka9nA2CVb/C8MJM5B2AdgYkq+J3f7aBqJ3C2sZYKopvlPhtByuiyfiMu2pOH9fWVgYMswnm9JiJNpstxYMsQok7639Py0cang==
Received: from BY5PR17CA0034.namprd17.prod.outlook.com (2603:10b6:a03:1b8::47)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 00:50:29 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::9f) by BY5PR17CA0034.outlook.office365.com
 (2603:10b6:a03:1b8::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 00:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 00:50:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 17:50:14 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 16 Aug
 2023 17:50:14 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 17:50:13 -0700
Date:   Wed, 16 Aug 2023 17:50:12 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
        <will@kernel.org>, <jean-philippe@linaro.org>, <jgg@nvidia.com>
Subject: Re: [PATCH v6 06/10] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <ZN1uxPdV27xxK55Q@Asurada-Nvidia>
References: <20230816131925.2521220-1-mshavit@google.com>
 <20230816211849.v6.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816211849.v6.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 132290b4-566c-4d23-89ca-08db9ebbf41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3Af364aqn61qHCobELG47AZ7A1sQSbWZaDFSLpXXiVU2qCA6r+wGmttkSvqrFEvzgT2fvZ//ObGpoVaPkiCSFSBh6qFO+L2fWShWRnbozxFWf53z4xMEeye41/TJkUbRBgz3eJTw68x+7K0dbW4+ejL5sKEZePfUqEzovOrt8YR9lGIi0rQor6PM55YahecWOMEYsAT/YCrBu/LPhygt5ODyKGplE8djJmckBR38o4BpsBZ3/pOZ5kxMmox/d+Ic0BYR5guFrEuYBzjvf235sYVIUZFmk/4rRx6ZgA4j1MEBsY094ojPSgy/tmL7dhos8yE1P7U9BjT4J+I7WdbI7ICapezxKT/GPRIZ2zhbqeGEWYurnFzAZpsMLZTAqGJbZ4NKl0X47crfegKUPWljS4wzGv2oDtTVWiyGh7p4GSeKtStrXWiv1c4lYLMhzNbgbsU3Nd+swsz/a1nibyU4+S5whdyYLsrKGFIzoTsfwoTfdE2VsX8HpRlTOl7SbupMMbmN5m2L/uUyIGXMrD4kSK+BHwsV98SUcfXRLrqTfxAhChHWcyxkB+rZWszcnYhFqavUg5eZ2QbwbdsSUiMFS2UNCQlkqdGG0flc4Zc6EXhlzjNGFBFyvizllnuB0YRJQ6EFFy916Eh+tS8frUoo4OjfEAZhgUy7NayqodWNJlgJQ4JRabxIumjuSHGGzJh9Aobh4m45jWqCNDm6T7WEDXUjutexAienlFiDfRR68+Rx6zqYO9ltFkQNzB2SESq
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(7636003)(316002)(54906003)(356005)(82740400003)(6916009)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(47076005)(4326008)(8936002)(8676002)(33716001)(26005)(2906002)(40460700003)(4744005)(83380400001)(55016003)(40480700001)(426003)(336012)(478600001)(86362001)(9686003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 00:50:29.3234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132290b4-566c-4d23-89ca-08db9ebbf41c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:18:46PM +0800, Michael Shavit wrote:
 
> @@ -2463,16 +2448,43 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>         if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
>                 master->ats_enabled = arm_smmu_ats_supported(master);
> 
> -       arm_smmu_install_ste_for_dev(master);
> 
>         spin_lock_irqsave(&smmu_domain->devices_lock, flags);

Nit: there'd be two empty lines in between; nicer to drop one.
