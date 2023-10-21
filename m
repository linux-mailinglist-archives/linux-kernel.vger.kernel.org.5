Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EAD7D1E50
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 18:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjJUQjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 12:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJUQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 12:39:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BF3CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 09:39:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfHxbnFJe8ESsNlgME4BZcRr1cfoEow+mpZ8xFquireZiWq6xOd8ILeNzdAUt4pPj27p5B1cCHaHtNOzlTqZvHuIF1tvQRRnDd1VkEA0EwpYrLh62OhFczW60jrmu/PkX3bzXaIn+CHINsJe9YerVFKOYrKyLJ45kbelLH0I7Ev/Hz9zXHChetylZQn2cTfOycisiYxnCSWWIop+3KdKuKvEAp23WIToYJqAIY5PW5XYNJL1emsP9DW0wqopYghiqBVPmLBUMwt1c3r5DQAospdQPdZeikL4ENKUTQ1wiw4JyfMd62VDs9AvazxoQVk9tneGnkhQiC9stdQOVYDtYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa6wAix1uPp5UU2qqXC6qvD3pv/eNNxC/saAnmm3JBE=;
 b=muwm1PQDom1QZHCJGQ7TgXohdeR50zLcIUP7miNpPLkWBim5as6BHAno9lreIswUEqruxWXjo6DVMt20ySZrvo3vFL5Ccxmyrh4i7knui75jHYsAP+Xwq33j2Tu9Pj5IvMh9VYEahSV6tP8NvjAoolNtywtW8JdQ2nEedZWTMT5jlreOe3V7aUxECqiA8cHJoOpqw4GQwV3Gan9uZEkD/gnm0xqJ4PNk3NmonWrdWwYnZgYfoxmkM5jr2tf37iCr32G2wtyne2m3V+ZinR5G+DzM4HqwgqjF1WsoaR19127ZdLQ47gVSljSA7D+ccsy49r8/EUS1RUpGLyQnbFtU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa6wAix1uPp5UU2qqXC6qvD3pv/eNNxC/saAnmm3JBE=;
 b=oJdtoSZM77SlVCTL31C6rKIgmdev1eXvBsP9bH/IQjPgR/ZKu8uTqvWp1L4GLPGldL3XOBM7SNQdY4AkRszuYRc/bhE7EJVCPTXVVeno2nG3k+l2SKvK+1K8PNEJHgrnhC6GzeRqY6wOa4ZAqAaYOUPNEd30R8t8/BUoOfWAWRGBKhCs0eT3/36fhrl/hrVLWvfwrl4n3znlOEwbznjQfuCpgC/eqlSkGhlt36crfDn3MIW/V6bzNhWvOP6Thcg34hzJHwoDhj5zqQ5e785re1LIS45VjsgXH3EMVJ7ugzpMWkiPz8Vt7DxZms49pCizbOiun5BcDM2qj21mtIZUbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Sat, 21 Oct
 2023 16:39:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Sat, 21 Oct 2023
 16:39:08 +0000
Date:   Sat, 21 Oct 2023 13:39:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        yi.l.liu@intel.com
Subject: Re: [PATCH 0/2] iommufd: Only enforce_cache_coherency when
 allocating hwpt
Message-ID: <20231021163907.GM3952@nvidia.com>
References: <cover.1697848510.git.nicolinc@nvidia.com>
 <2201ae4d-b825-49a5-ba73-c6b310e2969c@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2201ae4d-b825-49a5-ba73-c6b310e2969c@linux.intel.com>
X-ClientProxiedBy: SA1P222CA0033.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b88ac7-0308-4294-4dad-08dbd2543f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1jLMIXsJd4jx6R653yVi8efWmrXw8XBRqqnpHFwkZ2m8d2k5NRPSXed296tP/2LE9Z4002I23s/ZzWPX4gZ0OveQilZGeus71KcBkKFCXt7xXQyde/NFbiOWmI6x72QRq9cIuL+goLI29Jh0FFYaZ5LJklmKRsf6qc0JzjhPuEVhlQ27d6AU6tD4+2gUDXMkQDKq8dHGvbquTLRB6fk5xoaGA/BwEbsohIuUqzCJZzpXpDCUq1F/mth7lYPJawTbtKQP4Cz+F57ksZS7i7Bzza2+aR70lt/r2ZeeI27QYPjEcXqs6muabQxdUSurj5/dO8vy+X7AHc3XKqBadDaPaRLAKKN5VCHrjGf5Z0UuFV2JDUd4vlJLLhekrB6jyVXQnxrmWg6zOpiUkl+LCPritWyaNBqBlkngvNjNaWeI5qbzRjJQa8tmcSK623nfB8u1PtGAbP0uV2XJbANG3wLBAWVkjieJ5t4luvT4wE45pVbU+onOxj1Hh2VDVmFPAIyNBxdXZ5NahP+YcEwxgrK466kIOvU+olgTy3OeAUAJ6hQVU5+bAQ2B3MTecYr9r1rvWhxHA0WrZejdGbqyCpmA9XlKaMJqEAkrulVTQyef4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66946007)(66556008)(66476007)(41300700001)(86362001)(5660300002)(6916009)(316002)(6506007)(6512007)(6486002)(966005)(478600001)(33656002)(36756003)(8936002)(4326008)(8676002)(2906002)(38100700002)(2616005)(26005)(1076003)(53546011)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YXPXvue6/jlw/LNiclwbGDA7yASdxVeSZ1C8UrEveMIuMjFTBGYrvR5BlWA2?=
 =?us-ascii?Q?7A69TEtcxEbBrNQMJbYzgJcgEMRagklBpdi0N+SGpvj+XxJMHxtpQoww7vHZ?=
 =?us-ascii?Q?i8hD/jF/VXN5i3GfQ4CFYzfY27fPogw4Hf5d8WnV9owptr52WjzsO7ghPp+J?=
 =?us-ascii?Q?P+1TQO2kkpTWa/MS7mN/mCQy7DnREBdRHHVNIMbPnOT4GeIgt7Tk/wSK5B5l?=
 =?us-ascii?Q?XMXnfIZikc3XyFw2pPd0PIgF/G3YvlEKJkTd2B1mig3zGYG5fy1KXyqFCXyS?=
 =?us-ascii?Q?fniOwMCijxBHie4ETH0RzuD26rJODvo9Ta2WQQYVBh2mdH2Z/VgT9BWHtoiV?=
 =?us-ascii?Q?1+KwO1lfuUOBIhmiFJARdNs/bO1vAm/DpK0K49HwDOPsgPsmGRvfhmaH8kKL?=
 =?us-ascii?Q?8aEPNGGHAM2gRCYX0fr/xiyCe5GEi6ooHYydprI073zpXyChoIG2pQaAO+Qo?=
 =?us-ascii?Q?VMnPl5OFdkPNnoI2Z4Xkrhi7LmgCtsfns2rWutmETrnFswiwW+6RA8MJHlSh?=
 =?us-ascii?Q?ZWJq5P4T4JO3TlOpGPw6neqv1febghaCN+axaqbfcXF9UUGoHsNJc9Ptv500?=
 =?us-ascii?Q?Ud6+foQAFdDT6u9hn3V82S2zR/M1UiqtbcJfaFkKO36f+VgyxlnbS3I7Pfig?=
 =?us-ascii?Q?D6Ba0hBomRpONNhvPwifxrS2tNyrMA3ILZjp9OsFZ7/ngrK64MnuVValqrW9?=
 =?us-ascii?Q?Uys+n+9keGiH68naQ7cb0xZqjA1yBXWbxPi3od/IIUnNd0mkk67+Qlym10hG?=
 =?us-ascii?Q?cd2NGghoO5ps7OUbzkZALUTU6kKt/oLCN28yz791GRR470odacyeNi7y6JhV?=
 =?us-ascii?Q?zr12ZsUZa09/kMDcn6ZUwBrNgChr/edpvsf5ZD3Wt6eS/k8945iVyv0S6ecT?=
 =?us-ascii?Q?N4dGBwiGjnWfUkjqOjn5vpqtxwi5TK+ZhiyMIoSgiysvlztzB28FPQSC+Lvl?=
 =?us-ascii?Q?+Tmtp+m/TH0SIKZePggbNieBLLO+YBi/qgdDym8A9XyLl5PhibOKnjUjn+S+?=
 =?us-ascii?Q?a5ArJraCiGKWivZsY1oSeCzx3epgWDn24jQeKwOEti1aP/btR24r7Ceo6bQ6?=
 =?us-ascii?Q?9z8SkUF4JGrSBWxMw50+jwFkXaCSw3hZptLSLauL6peAL5Xa7SW2gVHlrR8x?=
 =?us-ascii?Q?Dv0oONaY15wEJ82MUhP+76XivqfVnNFAwNVfUiGyerRalpl9hVEDV+anCu5L?=
 =?us-ascii?Q?2ZqFXW7Ntfc5hh/U9qI/7ih9dCH0Vp1TizuDjeiTJP/2oMMSLHKv2ugA8w/Y?=
 =?us-ascii?Q?sT31Rkdh3UNcYqBT7SFBwaBaFqWPgA7bx8KxFxLX/XESmPxiHxWJ903+l95f?=
 =?us-ascii?Q?yJd3NS6wtdlZmaBPrE3vw49u7xFNFrMsjUJPCz6iqVyWuq1wyx0y5uG1u3uc?=
 =?us-ascii?Q?z2W0ZAo7fNUpnh/B2P6+Wnb+yD1cdX/uj3u0PCKVWiVwvBsVvQGjSJraCqHM?=
 =?us-ascii?Q?WAFZZpG5jWJjl/ukRcGBh06WMH59MGuJDsi/iBK4/P3q9b6CXKJO1xYxNdYR?=
 =?us-ascii?Q?TTtciTPhurwMB2Y12+sR65ZQ9p55hop1cFM02FquOX8IiMAxipAHyPrgKQdq?=
 =?us-ascii?Q?ma0MZUKxuq7q/gjYxIk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b88ac7-0308-4294-4dad-08dbd2543f72
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 16:39:08.8095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTuvWUkCOAwCmvP28eaSnkM0ny/DT8bocAULx3bj2YbYX4r9P+xGJmGHXz8ufZ27
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 09:32:32AM +0800, Baolu Lu wrote:
> On 2023/10/21 8:37, Nicolin Chen wrote:
> > https://lore.kernel.org/linux-iommu/20231020135501.GG3952@nvidia.com/
> > The conversation above concluded that a hwpt should only enforce cache
> > coherency per device at the stage of its allocation, and it should not
> > be changed or updated in the attach/replace routines.
> > 
> > Add two patches dropping the enforce_cache_coherency calls from attach
> > and replce routines respectively, since they were introduced with two
> > different commits.
> > 
> > Nicolin Chen (2):
> >    iommufd/device: Drop enforce_cache_coherency in
> >      iommufd_device_do_replace
> >    iommufd/device: Drop enforce_cache_coherency in
> >      iommufd_hw_pagetable_attach
> > 
> >   drivers/iommu/iommufd/device.c          | 19 ++-----------------
> >   drivers/iommu/iommufd/hw_pagetable.c    |  2 +-
> >   drivers/iommu/iommufd/iommufd_private.h |  1 -
> >   3 files changed, 3 insertions(+), 19 deletions(-)
> 
> Hi Kevin and Jason,
> 
> With these two fixes, there's no issue in the intel driver any more. Do
> I understand it right?

I think so, as long as it is an allocation only time flag there isn't
much trouble for the driver.

VFIO, I think, still does the old algorithm however.

Jason
