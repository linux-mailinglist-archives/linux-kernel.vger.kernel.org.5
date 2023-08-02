Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1DE76D087
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbjHBOs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjHBOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:48:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A08A2D5F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7/ldryD55fHPSNXJW1vDYmjWnH9f97PjMXH7YR/LUsJ7UO8AfAviXn5qRgq7cWE4HiObtujIquzAXWvb0M9qi7rz0Cay5uf0U9ENgpj0FaP6W9s3IXAmfW4XvW9wxxNvvbZlWQYoU7KPtf75A3bsACRdNDZ9lygi7NeUNh3cDFYygcFxTYrJAtrXZPeEZZFMN8ESPeqsOdxEqsaJWoa3oJ9GdXc5bpXmyGvc3dXoyOKbHo/6W5ExSZp4JWxNc1Q0ncACK9X+rZFfaUBF9YWAtvXQGMrN5i+T2qF+IICqeo0oYEKikNWA1pBOs2f29DIG+6DTEm4KWKcrf1zZknQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggPtWTXEXy4DGH9vLVn5ANUrPjZjqDCp18f2/K8SQD4=;
 b=ig5cU5z4L/ZBuXmNW9dJbzArxtici/+XhAtBrYhtmm9rnFEEUlaHt92mX6LqgCkrBqei3niHV7ijKiUDTFQmT0N+K74E7I3dvb3XZ72F8SfzoMSZoqJdQPsXZRH+2kjO7bVsPhJVjImRqp1+L59kRt2xVGdqyYnil9zuyQQiEM1TMl9fuDkdqUDaCR+6IQXX3IrGNpXZzvPUG59YXFd5Qd3m67uKSr6AGBNIDiwXiB1KigdWgBU+gXYgZEG/nWwFlxaJh8UNLJ68JwBc4oWlVdk9nu1BBfEcUB1rhppHH/fhXgYibOz2HEvUH4pvfXuODOu0Ub8my7iFRIw7ml05Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggPtWTXEXy4DGH9vLVn5ANUrPjZjqDCp18f2/K8SQD4=;
 b=OTGwlAmVwt+pIaEwYphwtApxNVsW5chEG4f4MaSGpSbkCc445cnjieoaAK3PqQbf+kvMjw7GIQ8Frp8iqGhQ0zboK4R2SRDDIALeU7MKVHgjvXN7oSdAKJQKSM9eli/DsoagVEYjHfThRk2zlW3iCxJX8O7PG1/Xy2uG80mHuVzvNHVnWOxvhUVpwcnJOySvskkrf8SzXScdbxvFqIP2Gkk1EW/ytXZoTCdNNJMt25xXr2y0wz3vHn9lJ58AcQurIpqip/DogWg/LfGXXV7FwTtdZAmQEI9QfavPPGjoW5Vmx9GNUmS+JO6mCLraYLuJSkcMTDa8shTVXVM8HHKpRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 14:48:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:48:18 +0000
Date:   Wed, 2 Aug 2023 11:48:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v11 2/8] iommu: Move global PASID allocation from SVA to
 core
Message-ID: <ZMpsr3FbcEYRs/G8@nvidia.com>
References: <20230724222538.3902553-1-jacob.jun.pan@linux.intel.com>
 <20230724222538.3902553-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724222538.3902553-3-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: BY5PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ee60d1-f036-4f3b-9f5b-08db9367829f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQjcjeVAV9CqVQuL6jZCKKgfteoHsCDrAq5qIpru2dmcB3ZaLglja3Un8ZU4B4xdcHedUBShTcEsE5UHulgEbUy+RSLzlZfjMkqLlt0P26ow1bw65YX4rmDX8X9Rm6Fu5S3Ccpde6Fh6SPcZmSp6Le3CwzNsgICPu0JlQtMUh9LCKCU+3xyIhURzW4WGcLF/+XMP5DhjeFvb7VZuSiQRE3T4Y5gnEPsg4UeFBoroIhAUhdxjqv+aGGUgpwRFwf+A9BndM4Bl+59XeWqk6P/PD71MfLH2Ngd90nCSOC7g899mvaGSHi5kIdlXw4oCoiKagYghaVMgc1RGfvFGtVVbQEOqWoUpnENxqIPC8JXyplychAqZjEMxMGeTfgqUVnrYYxugPeioBf90iSzjzYPDkhqjVZSzRDFRqMHgcB++6O7qBV9x9COhOqewJeK+Qi+ZPgRBfPqKpnVMLvfS+4ywaY9FpKhlcasDazMXQbr98m89GiLJtmHdM+hMkupxM/ThvO8Jm2P5FHfFgQqeOSDO0pxhncQM/P9qYaE9kcoUFhTFpnQwZDB5SvDTsf1KVVJX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(26005)(41300700001)(2906002)(7416002)(36756003)(2616005)(478600001)(54906003)(38100700002)(316002)(86362001)(6506007)(6486002)(66946007)(66556008)(66476007)(6666004)(4326008)(6916009)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DPE5H/xZiwMALJmUtE74mlZdjAA2WZ1ffs9CWDgTQuNkUeYEsA8E6EyubkAb?=
 =?us-ascii?Q?39rvacl0zCCyiRkiBO/WFgC6DfNHIJ28jHlIsVWRZvcGm9ebQB7n8DfP84hS?=
 =?us-ascii?Q?Lh3HKgTwZmKd/KhkpfVE/QnKPya3qM54PU7hjQzL95Sv23ZJm+scLPe893Tp?=
 =?us-ascii?Q?PV4pUnQZwtd++ShSrThx32lMB2bxcaUsUMMvFtzcH/4Avvwymryss0dK8Cdm?=
 =?us-ascii?Q?TIcPcRrkAhhpB1mcH1qwSY1nXYO7LjS8hHva9fqT8tb0jfHX8qswmbwGtCCy?=
 =?us-ascii?Q?L58zq1CUxWBxbK7QsZSP428DJ5/khIFICJuqkCVmDefUlMLknDqcJzrn1ZTv?=
 =?us-ascii?Q?HLV8Qv3dxqu/yaMb4ZluFduAzXzOsG+TAuNQXM9RHc9iEQC1VOE+BfK08uVx?=
 =?us-ascii?Q?IendOwoRVRwOmtd9fWfQTtPW6CLZXHwBSCLVIFtUncTfV5V3vr9LCTyxyAk6?=
 =?us-ascii?Q?Cw2UXkP9dBbH2rLQqY1/peBs2CanPqauMzyyDHqcdcbaT+C/vY1yut0ILQep?=
 =?us-ascii?Q?Zx+t7zZnzm/vKEgB53nMlopbi7fB7X1H/BYjck2HAhCHXGNSm0sbfF9x7x+2?=
 =?us-ascii?Q?H5aP4satJffuQraoc8bnV346t+IW1fhtgqX3VfEe3eEGwz1qtv0oLeQ1jTvc?=
 =?us-ascii?Q?uudze6ZKErIpk8jJGfOjp5DYnb2GbDrpMn0f9oGfU3F7R0mWbOUIFzwzyNOy?=
 =?us-ascii?Q?tAVCNiOS9xII4dw9UwwlydChsVEn+v7uB/XMAqAyKoBZszFQOi8AoZbmd0Qq?=
 =?us-ascii?Q?hVO6pE9f7hE38vSA6mfTlUwZKcNkFSVfer0YO4Mij9k8GaUYjNxeI384dQQt?=
 =?us-ascii?Q?vsasa9NgSQ1CZWdwZW7i52oePSWnaOH9RDTvJZ9b+aAN32dDAZnP79AlaSni?=
 =?us-ascii?Q?GJkAQBW6IkUKsaYyyEqn572G21dayTRf8Z5ElSiAMYw09fNm5ZCuq+NpE+jj?=
 =?us-ascii?Q?Zj/kLPScFFp9gBgioUun+rbFyu44zcsJD3tAb+STC1Uzg7FytrWuHJfdqZ4l?=
 =?us-ascii?Q?TFEkc4zTxNn4C8dUFIPquZnJXcLNLC74yj6MOuF8yg2w3AFIqjrAFolh2lxI?=
 =?us-ascii?Q?kHh4TnRd5RwlMKh5v5q+stHx9tL2nOcowLO+Jn9JtlsZQUY56A9PflPEGlZ2?=
 =?us-ascii?Q?wVAAisBPVk/dc9uCqndADBsbdpbXR7KQwlbsxJJcStEu2GACM5b6oKZT/a2C?=
 =?us-ascii?Q?t25KXU7INGUAHqcGtupSvpqzmcGO6ycXe54ENZ3qhSZFRsqpGNX2VMo+Cx/P?=
 =?us-ascii?Q?tnErNDAgLOcptYHpyad1IosCwc6E1f0TwfP+kCTq3kH14RS8S56SN43DPtVO?=
 =?us-ascii?Q?Pm9/dcMueY6+4AyopCH9jMYMgkIdJfTeDTxKHuYXTMrnMeljCVrZuPKU2Cw7?=
 =?us-ascii?Q?w9603qolUAflyKtBedzQO+jWgYT4OTj9Q+Rfdm1KSvsNLp4/7qahEPv0BXRa?=
 =?us-ascii?Q?hjFznaeDFEYNuaOiubw/kKbzMzjgwtvAg7hP9oFbb9hfIzAEXY0R2FPQTQaq?=
 =?us-ascii?Q?KKHMQ/CNJvWDzNHwy+osLhF/llW+y7kcEkGI2eNS1QrCDkfFlRBBEGTdTrKy?=
 =?us-ascii?Q?rVsG5rmhQORjAAzLgrNeLEVNYQNeh0RGOltLjUxd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ee60d1-f036-4f3b-9f5b-08db9367829f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 14:48:18.7404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjoFX4brOY8ez1I2a7rTqKiT5S7/A+ld6h5A4LYCI28NOWkLtDSOq03dLVBnDPcI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 03:25:32PM -0700, Jacob Pan wrote:
> Global PASID can be used beyond SVA. For example, drivers that use
> Intel ENQCMD to submit work must use global PASIDs in that PASID
> is stored in a per CPU MSR. When such device need to submit work
> for in-kernel DMA with PASID, it must allocate PASIDs from the same
> global number space to avoid conflict.

This is a bit misleading, maybe:

==
Intel ENQCMD requires a single PASID to be shared between multiple
devices, as the PASID is stored in a single MSR register per-process
and userspace can use only that one PASID.

This means that the PASID allocation for any ENQCMD using device driver
must always come from a shared global pool, regardless of what kind of
domain the PASID will be used with.

Split the code for the global PASID allocator into
iommu_alloc/free_global_pasid() so that drivers can attach non-SVA
domains to PASIDs as well.
==

The code looks fine, though I would eventually like to see the SVA
code not hardwired to the global allocator too :\

Jason
