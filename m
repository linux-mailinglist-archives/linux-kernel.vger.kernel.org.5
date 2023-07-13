Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16ACF7515F3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 03:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjGMB5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 21:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjGMB5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 21:57:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751841BEC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 18:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iY36NOSlS4tPRAR44dZQrzIgZQ2hlQNXa+IgcxkNcktcFRtTT3i+OZX1d8SE3ByGlubi4bXsXstuy7PJPnVG9GP7L6Khka6dtlNlRFiM+fHa98USRRf/ZKdTQbXeMSarbFdXyCNVMg//Dctc8HmRng+y1hhDPCmKBwusWdUFzlkhgLOJ3cZAnK1wQck9ZQNPlc00eopYq9g/d7nMwU44F4WiXWCgJQELXyh+++l1AadZbfmuL6tu2LdOvqwqGVLiQLuip9IkG4FqPs3RiWeVoJNjlO6Bj2qxxzQsAwB4f/PPJzSvY0aZWnAt1hZtJfDqkuz42ugLrceCkBnwpyj2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vwPEIAMqTQG+dXnEmLO2vtlT4NdclUoQhXqYAhQV8I=;
 b=BB1Pxn+4NZ0Exv89W6bMJgFXbM6KFKL8k0b7g1gtg0TPy7MN0ddZcyu8BvJaiDdJrNXuyhPOZkJ2zMpuopV9OQYnX7y+b9lb34/2VmHKpfP2lzTYnkgvyVItlkF5HQSA38gPRt9kHu8ORe3PFR49VWMLFTmDzAs+49kHrUDpF/WLaPySyT2zzdhIO/CmYcAmxVYPbsSw6xZNG8plkPn7knPJUFRZ3lKowPN9WWuUYx5ZQYvm+1VVWOUZN7eDKHlbx3+AYRQzH9N8jU0vOVnX+fv+2V+4BbcsD5kaqxguQOmmj7psL/WIeTrCNuYH7mCYZyK+vWwhifsCt/v1hLr8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vwPEIAMqTQG+dXnEmLO2vtlT4NdclUoQhXqYAhQV8I=;
 b=a69h8v+5AJ92th6dBEsyUBpk/Lr2uMtj9c0ZXW1GZTRPzGxUtHBpvGT8tOTkgpUc2VgroF9TcExNjDv4HpcytPgSpoAUgedZmDoKbAsugd1QuXCzyX0yjyjwZCk9IycWKlAvu6Mg8tMFNZNHEpqcew4wvaGv1plMWulV4ja5lasxGA+KYenbbRub24wnVqNmSh1lkWRYp08MDtGlj82T8C+IROChRXEAErOH3lh0rbEzN6T7s2sE7OFbveFS5Q3H1kKjnxXBZ6AAgK0yLbd+FRkK4xEZSC8iIV3Ole6PQaMsbcKqRKtZ+vUrARF3ozu7IFPguJin9mHaguxipY3u1w==
Received: from DS7PR05CA0018.namprd05.prod.outlook.com (2603:10b6:5:3b9::23)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 01:57:46 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::b5) by DS7PR05CA0018.outlook.office365.com
 (2603:10b6:5:3b9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.9 via Frontend
 Transport; Thu, 13 Jul 2023 01:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.44 via Frontend Transport; Thu, 13 Jul 2023 01:57:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 12 Jul 2023
 18:57:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 12 Jul
 2023 18:57:33 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 12 Jul 2023 18:57:32 -0700
Date:   Wed, 12 Jul 2023 18:57:30 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <baolu.lu@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/13] iommu/arm-smmu-v3: Use the master-owned s1_cfg
Message-ID: <ZK9aChHZ3E9IcwJ/@Asurada-Nvidia>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-6-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230621063825.268890-6-mshavit@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0d5150-9eb5-4779-e20c-08db83448d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwt+Rz9S4SD8uJDCf1GdCjboR7UGeYvnEfH9ZV+fbylgMHhE6dbROqd2+9YIHwLyQYtWpsvSf7/0wfr5UnIRQu1NSS+APKC3LPnYFozA2s+Qxa58tAK5hJWHv06VJki8B3s5zTntMhiVUNoAaiJSjBRZgbIYFPsMI3JdcynF4hPH3MPbXsN0LGyj3wAfkfw0dy0wrTzYPPt8VlHGgE9wA+NUajbgMXc2ZjMKv0qPricIqQ46tGUrHUHB5ZKVLlM9bNhbfqmQ2laFTAzbaK7DVeVEitUaHZlM3NY6B8QmA2OkPtl7QWNRWh+9p0qlHfHdk4Yr3qxoTmTW674z+plJCbqCgMiCZIkuUaKxQogNa+GjW/JOIT7i7ArZK31fZOqpgahF3AWnQBbzJZ8M0PCkCNy/R0onglgRCi9lk+2Rsod2gYB4LbD4zHO2MWn9j6gsA+b9SNNqo7Y5fMuWXXBgEeVnSmkMJgsLwG43empDeCbkWUfW/RdpMgYbPxrsJSfItl185NUA6pBafwWLLvn7cnoCRRGlfnJdFmJBJBVdrFczpnd/2WkQ9ciHlqGsnuwiQGDHU2tui6eo9ZYxOJEO/K7+mjiaS3qQg6LivG6Z3JT0RBKvUbnIC+2bVJI/zkFQjMu1jKUtlZtdMW/m4yXoO1minHdoQmsJPFcpNqoMz5sqvO0DiaBxMTNHOjCuw3c195IKau80ESWbceGeQi6gWK6wmzAqZfw8QGHjh8XJMEwR3L8yDdwXtgWlXinjYS92
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(8936002)(8676002)(41300700001)(54906003)(55016003)(40480700001)(5660300002)(2906002)(316002)(4744005)(6916009)(4326008)(70586007)(70206006)(40460700003)(426003)(9686003)(33716001)(478600001)(186003)(86362001)(336012)(82310400005)(356005)(7636003)(47076005)(82740400003)(26005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 01:57:45.7133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0d5150-9eb5-4779-e20c-08db83448d89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 02:37:17PM +0800, Michael Shavit wrote:
 
> Insert CDs for STAGE_1 domains into a CD table owned by the
> arm_smmu_master. Remove the CD table that was owned by arm_smmu_domain.

> @@ -718,10 +718,7 @@ struct arm_smmu_domain {
> 
>         enum arm_smmu_domain_stage              stage;
>         union {
> -               struct {
>                 struct arm_smmu_ctx_desc        cd;
> -               struct arm_smmu_s1_cfg          s1_cfg;
> -               };
>                 struct arm_smmu_s2_cfg          s2_cfg;
>         };

So the arm_smmu_domain looks like an object representing either:
1) a CD table + (if !IDENTITY) an S1 IOPT for default substream
2) an S2 IOPT

I wonder if we need something like struct arm_smmu_subdomain to
represent a substream, because now an IOMMU_DOMAIN_SVA domain is
represented by this struct arm_smmu_domain too, which is neither
of the two cases in the list above.

Thanks
Nicolin
