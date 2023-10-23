Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0537D3FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjJWS7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjJWS7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:59:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7550BA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2L/XR949qg39tiDr/AD6xxn4SQTrnMHOR+gfmcXj06W6UsyMfbWbZninFTFafrhp2ONuteg8ZvPSKw19KA0ggIL+z9pO5p+jSsCCe2O4krycAgXOcV+bR36ASAAnXvGEzrGJs3EVAjWx1WbkVfJnBGwFeZeRWaiOHJWg5xSuLzdThRd8QLFUN2ONbBYWzPy414SjhUpFm+WmwGfhrboCSKA813nlyCXpvcoaqTdKXdF+uQxl3uHWh3li2crzw5ct7IbNjE6sDE9ZGho4o/PRtE4sQmjqNl+7nxa4l9ElxuXBXv0nAOkSI++vAmx8r/TeOCk1/EZbiiO5QSqKSX/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reXxbhnhuvaZDD9pYNeZcwaZjO2TqMYWFHv9R0KoU9U=;
 b=K98y1KE+h4+Lk83Aph+6/0E4big0ZhnEOlUg8jpbkq/MtuB6q0ims0K+QDpclqbcCdFFUAAw670XpVa0nmXvjxciJzRqnYU6m+zLvmq3jAzi9Rnd915Sen6sIc1OZEFUr6LgTzVswr7WQWbV/2Nc8Xdw53MBfxtf3bes9k3k3RotiGrl6WrIGKLctslYTELedtWben9vGrqnlXdkT0gPTYrib/IzNX96N8cC3+iaJOFAJ5q/siuCxNsYWjPhEu/lJt30D8Y2Pu8o9san9gp3AR0uYkYq3DlATVXl1CtEqx408La3ABLUNivERU/xuKsBSvQYXkFZFsFiMXydlVr8hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reXxbhnhuvaZDD9pYNeZcwaZjO2TqMYWFHv9R0KoU9U=;
 b=nnGA3aL67IJLsKfpubKNttCy9nL6yBjV0ChpUXoxw3gMWALqNsZbeEXwPervcTQy8VXyzCKeGKIp8slePNUw7DK24s9A2E6hO/HSky5XCw7mRbQLE4DAIR7t5Kme/sKKcDsagJCT82VFsPGg5c7zx+gkdmi3Z/yAPuuA2igIv8rgEbf3TGGnoDYZeKDLWp1mJ0RjRfCXHl1SIWH21GgZNuC9PWp9B4PvsoWux9BCIsOmOtV92cFQ21Q2wtHsuQSagLpGFpT/M09aeYHy7NsczoY7uvqDN/P/b/V2q68+YXcb4T35KC3GLYajnYZKDRfenGwNHUx6hBqAx4F9ubxIbw==
Received: from CY5PR15CA0130.namprd15.prod.outlook.com (2603:10b6:930:68::21)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 18:59:41 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::25) by CY5PR15CA0130.outlook.office365.com
 (2603:10b6:930:68::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 18:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 18:59:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 23 Oct
 2023 11:59:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 23 Oct 2023 11:59:29 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 23 Oct 2023 11:59:29 -0700
Date:   Mon, 23 Oct 2023 11:59:28 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2] iommufd: Only enforce cache coherency in
 iommufd_hw_pagetable_alloc
Message-ID: <ZTbCkLtvjP4m71w6@Asurada-Nvidia>
References: <20231023035733.27378-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231023035733.27378-1-nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: a626ebf5-a5f9-4215-e50f-08dbd3fa368c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJAFlTJKjkANRDPuCjDrrPxqip8vQGaO1NZI+gBhXjrgKGBRjKJBmG+LluFK8YOir3OW/gX8mQV21amDHhSAhZ4LpgVjVov7DpO69zscpD3IPXAUmYQ74A6IVz3VTvG8eGyNQG+8zEy9EiZpB69sBVae0ar9VuQNfOipcUmzZb4MyvaTP4bMLa+APPKpu9KV+9Sj7L7oTbWhUQ/qvsTQrbG7Ui3ZNWRFBtt1SV6kTUKx0bW8Huxl7gc/PPhxz7Y8cUhk4k6irJMaIWMSFJ1xCO8cQsHP0c5lrs69x9U7NXn+rzh44stWX2hLG84979obW60VaJUNN+S3+M6iVVECgc+UfiCJ5j6LHSus9Xxmi/0BP85omSd5zoudGGiRRtSrB4J8PVhkDtDzW9Pga1KnWeM9+5ZtAV7wBTNDdTZadvagRIo99h2DZlrUCnQ2bCcwzZ7Ri9jOBWs6GyfQ52XS12Toq1LP1guFfSEYdHCTiPKpO77EAzfEyw3uojcWrbno44ars7K/9S0YnoqnaXXqfPcMw6N+l+8myIVMwJrCI8bZ7Gw+C87nEuz3Xe9iq7yfmhjSjJmg1w8U/Y2eQwPL9KA84ItRRDpY1dq482f0WTVaYfRpFjMflVlregAuGrzicE6N2K0uJL8xoTxKlQ0+nxE7hIj7V3VjpL+1h8hW3bqKv6VguIYRY0xRPMQuEwmj9jpCO7NfvMeKhh7M3o5vUSYi+DbPcUw9Cpu2PAHWuula2jdBggIiAwM+P3RCWxZFWOpwfVNKDkM7ccNo/aqJzPI6LO9chrevgn7n7no3bz4=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(426003)(26005)(40480700001)(55016003)(40460700003)(316002)(70206006)(110136005)(70586007)(7636003)(86362001)(356005)(82740400003)(36860700001)(336012)(9686003)(47076005)(966005)(33716001)(8936002)(2906002)(54906003)(478600001)(41300700001)(8676002)(5660300002)(4744005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:59:41.2607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a626ebf5-a5f9-4215-e50f-08dbd3fa368c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 08:57:33PM -0700, Nicolin Chen wrote:

> v2:
>  * Dropped "fixes" tags and merged two patches into one (Jason)
>  * Added comments to the remaining enforce_cache_coherency call (Jason)
>    [Please feel free to rephrase, or let me know what to change.]
>  * Replace "num_devices++" with list_for_each_entry (Baolu)

Sent a v3:
https://lore.kernel.org/linux-iommu/20231023185700.11407-1-nicolinc@nvidia.com/

So, please ignore this version.
