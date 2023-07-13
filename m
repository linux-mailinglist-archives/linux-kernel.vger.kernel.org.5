Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6021E751772
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjGME2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjGME1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:27:52 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54A03A8B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDI3KCidvZUWtdPhyy1+FTF7cX1MbaKydJ9tWjArggYvCU8S9u3BXMbKznoPF5W4SlLNEdRseiu9osTcC1+WiI6bl/TPv7AjOOX/oiorxygflEoounb6aeKKGhEuiSBNtcuY2H4VfXogm41BXbiPjGBgdnxrnPsuW6XtkNJ3NpDsbcIAmv7+bgKoMIaw+VhZ4FCGPwrkXVYrcjFHhIjH9lotN9DmSi9XbqXB3XRZGDtfjwIdijPM/4SB1WL7ZkQCL4YmDir88HeusEgpRRquiZe+a4xYsP7rmsxbfkpeTUC3GcD0GuZTyS5q4K3d61lVW8CdFNmDtARPuZzaXjgBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+cjXOZ8aZLgIXqgeNhx895vlnsvANa5cYt3B9hw4no=;
 b=IFnK1r3TkvapnOSH95IaAjz7/pJIIxkp1yHsdrWODG6IK26DZZQySQFcig6w8NXUlrgBbvf3PUmm3fJj9/ZllS/X0zxPJ5jOWf8ED2qVSoyahTO2+LKgqgHYQrr8DFrZj2GtOww0Sv9CsVvKwpUp8xVTf7BZRpP/YvvmZpbC71wEnS+ZGDfma4GaLTKnoZOT/S+Z7C8fKnldFQW0vpVgAO+hhC7PFn905A7wM2ow5xNPJhkjiOihnigus0n/dJsTpgXxXRLoi97LkDeZc+uXpPvkAJTla71wrQw3E1JpsHn+QAIKUVxRjXYGKUj2kOVIM/tEPKNylUjog7p5K29Njg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+cjXOZ8aZLgIXqgeNhx895vlnsvANa5cYt3B9hw4no=;
 b=B6HO3qtLeA9SrIWMIW2OrQmdN095agSw8H8/39kEqWkgFKoZOzvvyMOfXAe09MiFamBXmhsEO0JJA2IkJzQe5hgG2iLjgZ96Ujs5WTL0w1HjDPsfydZ+TuhInRdBmwIVSdASG32aN7ROCjcHEEuHNblOlsEzARQBlP7/q6snAnPsJvf3ESYnJKF+b91g1qJTE4aLlPGODHihThAY031JfEsRnjPS+0y2klngE6qzWYxmwUXHx0K3U+AxT2zS2YJnZa9dEYNIwYuCUXd+ohEDn+xiuUs3iRMEM//FCCN6z5RvYR98Hue8Ell3udASV51LKWcmQVy824GOGSehbIKdGQ==
Received: from DS7PR03CA0106.namprd03.prod.outlook.com (2603:10b6:5:3b7::21)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 04:25:44 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::91) by DS7PR03CA0106.outlook.office365.com
 (2603:10b6:5:3b7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Thu, 13 Jul 2023 04:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 04:25:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 12 Jul 2023
 21:25:27 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 12 Jul
 2023 21:25:27 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 12 Jul 2023 21:25:26 -0700
Date:   Wed, 12 Jul 2023 21:25:25 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <baolu.lu@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/13] iommu/arm-smmu-v3: Use the master-owned s1_cfg
Message-ID: <ZK98tZ2iMcRu4Jlf@Asurada-Nvidia>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-6-mshavit@google.com>
 <ZK9aChHZ3E9IcwJ/@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZK9aChHZ3E9IcwJ/@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ed833d-edce-4c48-8647-08db835939b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1gdRFf6Aj9YBdVaHscK5zh6Vb+QvCNQSXqv4P08z9pvmlwPhJkLquRXFb8MZplqBx5OfKYMimRCIHhRbg/rKmv3eOzQPrNVfbCVldzo/MIWCPKFFxXTcCusaLwEfZ8VAH752rM1qIsXjEgTYoSJzU0m9ptKOO41D7zcexhjF7B+0Q+ccbAPMQIuSewK7W6BwWMTi8ZnhuntB4Jdt8VrQZ6D3rKkbT+OQICzZoksWUwPuOjZNU+iWWR2ioXASni+xO2LWAHy55pTO2Zik5TQccDEvur+aJ8KRr9SSLtdgVFAPR9WL/s7w7mu9iZNY0RGyXZz28DQLM/3Uqg5BcKVi+ggq3WUfpnRjn4ijuXoOf0NcW9YTO6DA/u2HQXIVc3KNzGwL+000H0rya0AaGDCDWv4yo9bfpQAXIZl2YAnIY99LNAgyWLnnP6A24m7PdTkQgSGrf68HxdizjGkD3UBd/2+IgzJwIqknYHxMzritwXPnYSkiKx4g4dsQyGG7gLeo4w7DEreQcj3eruYEdH4z91PHPVBfcP/tAimqTcjmAU7f95h8GDXcFPmIliyse7FS85bLlbDKgmNt81haXREz79JTwrEddtalPvAZP/XSnIfx2oMRY8getdavNFzQ1SaQKUijMlGPgngQh8Jo936nQ/z3Las3yVaVlnKoKDguQrR2HjiJ3ZGEN+LmBkj7sNFpBo1lE/JCVsjjoMynFvdq9bzjiHJwluLDZiNGRuy4zu3mBXLZ9jskBYj1PfsvaiTW
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(336012)(426003)(186003)(40480700001)(55016003)(40460700003)(54906003)(82740400003)(356005)(7636003)(5660300002)(8936002)(8676002)(316002)(478600001)(86362001)(41300700001)(70206006)(6916009)(70586007)(4326008)(2906002)(36860700001)(26005)(33716001)(9686003)(47076005)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 04:25:44.5111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ed833d-edce-4c48-8647-08db835939b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 06:57:33PM -0700, Nicolin Chen wrote:
> On Wed, Jun 21, 2023 at 02:37:17PM +0800, Michael Shavit wrote:
>  
> > Insert CDs for STAGE_1 domains into a CD table owned by the
> > arm_smmu_master. Remove the CD table that was owned by arm_smmu_domain.
> 
> > @@ -718,10 +718,7 @@ struct arm_smmu_domain {
> > 
> >         enum arm_smmu_domain_stage              stage;
> >         union {
> > -               struct {
> >                 struct arm_smmu_ctx_desc        cd;
> > -               struct arm_smmu_s1_cfg          s1_cfg;
> > -               };
> >                 struct arm_smmu_s2_cfg          s2_cfg;
> >         };
> 
> So the arm_smmu_domain looks like an object representing either:
> 1) a CD table + (if !IDENTITY) an S1 IOPT for default substream
> 2) an S2 IOPT

["]
> I wonder if we need something like struct arm_smmu_subdomain to
> represent a substream, because now an IOMMU_DOMAIN_SVA domain is
> represented by this struct arm_smmu_domain too, which is neither
> of the two cases in the list above.
["]

I got this part incorrect: an SVA domain is actually represented
by an arm_smmu_sva_domain, so there's no nested arm_smmu_domain
situation. And we use arm_smmu_domain for other purpose, where I
got confused.

Please ignore this part, though I am still wondering if we could
name it in a way having a clear topology.

Thanks
Nicolin
