Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1225770251
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjHDNw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHDNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:52:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA2149DA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2oxpKYbKt+gWPVvOOogCIi9Y04OnzVpuiJ6iGOkr8eVXFuZauhU4M5hx4DtJ5ZhEG6rZ2oWT1/VpP5/cGaR3140TudKjG9DqCwP0uB4uJHGvp1byUjZz+boAaNoYGAhEPGkvlvDhCVTk9OjVOsR5X9rivp67002mjOx7GRgmkfBdMbnMseV2n04tVy0VvaSDwIRf/t2t61aepB0nvG197MfVTI6T8tobEghc9PI27KczRUi57QgHEzfvhvU02sE8E8qs2NaW/fIq511zecz6onTneKna1dxAik5LiKf6tg8MWqnxgHGRXposIllUkuXP85IphQfcKso9g7gOKdcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddunVrvSDjfYQg5Kku60WYxypaMm4y72bIwNJgjUHNo=;
 b=jltLyuxJErBJYBb6gNCZBkZ3eMumb2ThtyQXB4Sz9278zTIMyuS8JzmoCNHV3nY89iDySUIoBoN4IdFuEM0Ae0GUyhxBWU8Go3rzFLUM35hg0ls9VJcnTzsDh0Ow3SCy2v6m+BvRB8lDV/XC36Tjb24PU0GHc5bw4de7SbQnDVgIy0nTagWQmU8TSvNa04ww9WE2CkqrN7DQJ6m9Z5quhZdZ+zQaSucTWpl9jG2YxxnOFgWPR0nmKCpKlziL5+qfIlPFs7Uv2NU54lqoAsY2GM6zCj+0up578wmOlbUIRqehjG+7E8fCiFGYScIFnZ2CshEWTKor/wctDYZ+umzB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddunVrvSDjfYQg5Kku60WYxypaMm4y72bIwNJgjUHNo=;
 b=Sb61eDDyBFVfTMbVJPEIiBNc3zzPiEKeWSVa8qDGVFeMzFP+/N4qZC9SpTJUx5IpVPn9vp+XZdEINd5cio4i5yBzPWSorqKL0rmwWpjOOVF6tA+50sk/q/3EtTwsqerJcurBv0wc/8fwZVdfentcI8H6+2PjyQEfomj0+Xyus6aMdwGLo/X7XZhU3fN+3wS9zm0Q/9or33HOstdcSLOBpN+t4BYUlOgw7wYv4LHBASO8Nj4rFcOzP64cWg5et0SLWapJjXoJ+fp24ipZAgO71l12bBxS4zMbTa8JARG7+8VpDY+57kKT6ljE7qz1Nn72hY2PKGSclcAsiwfrQY8I9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 13:51:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 13:51:47 +0000
Date:   Fri, 4 Aug 2023 10:51:46 -0300
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
Subject: Re: [PATCH v12 2/8] iommu: Move global PASID allocation from SVA to
 core
Message-ID: <ZM0CclrqXGYBKLjI@nvidia.com>
References: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
 <20230802212427.1497170-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802212427.1497170-3-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:207:3d::44) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 55bee366-ba0a-4dc6-a173-08db94f1f218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qt1Q2Ng9jMuPrSvyWMxg1D66+cVFrPGrGz6x9DbL5P6Mfq3vgGaS6pZvoa9/98c5cU+jyNCElRC2jMhPJKpWr7yc//etV/U48TiT+jueZvOL8KmQglGm/y+VHAVnwm0jW4/NKvxTwEmbQQJHxRQMKalQ5JMNachoriGG/uyxmqXMtyD+/sZisZgkZJcB65bKv8ZwXi2nHy28cu9xplqkicXF/XsBhT1eJRg2raXlOSm/1y1Vp37tjQ5E81vqF3+lhzCLuFGq1vbDDGVZbC75JCHqonUGs5SVLJa94Loyki/AgbajZCJ8f00d4Xg9V5gW3RMb/UuA4SSSr0+s5e/c+onxMQhTJATGz7D4dgDmLTeyf7j/3LcYzp3dJ1RfnP2IcOl7PcFcZxmaXvI47QwxHCW7gbbTb3mAZ4I30B3zGjoHatJoHBClb1tCFGqfX16ww3G1j9m3UjNu+ByYXDmc159mOplyXKKoxHXUSnel7HmCIX7X0ZfAWhfxdPrWZXR6Xu3Tq/17cndUFIJAvwQpHhAu4wubXF9kNClxZDNdjd4GdAqNJaBt4A6r4VWWqD0C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(1800799003)(186006)(41300700001)(8936002)(8676002)(83380400001)(26005)(6506007)(38100700002)(2616005)(86362001)(316002)(6916009)(478600001)(6486002)(6512007)(54906003)(66556008)(66476007)(4326008)(36756003)(2906002)(5660300002)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aim0AS61IYlgjHaI+nOQ/5uqhNSViKg16Zlfe6b7r0oYBhLgXejNvXrOku7J?=
 =?us-ascii?Q?w+trLhhrtZXg85OgrckHD3Y2u7OEiJBHAbk8/aSn7jEoUJ+xd7Yk1FJquI0o?=
 =?us-ascii?Q?losnMwpNDmXNn5EtQ5QNQSyIhkbOgVpc3S3YvMZTJrKVzkWCfKSKJ7jkCCSp?=
 =?us-ascii?Q?Nc9t8VTyJLezm9oJ96rakdy9en1t4GFP9CnLUS+1r+XHsyzSHTsEqxDQWwKd?=
 =?us-ascii?Q?GcMfGIq25W+9L6849aw2jFbc2mCO6WnLFcHkzuBqNB1TFf1atXDaGb9dpO3X?=
 =?us-ascii?Q?hkXCnVNTTZ8JfQAVCs5XkEKZ/denH2ZbU7edf21VSJtdaqyOYlTw+rt34YvS?=
 =?us-ascii?Q?rTtLiaCNCJ4Lo1cUqi++ZgApnm1sI6DhvpVJd3WxvIczQVIAri9ecBrd1Ir2?=
 =?us-ascii?Q?3GVDFxR+BlT/xQTXjH0DO0l57ylJWDx1K/KUATI6ULVI1c7RazDEy3/MvsL6?=
 =?us-ascii?Q?fU12+2ICaHewb5xIRxwPBRhKZ2smqNyGM/xc8ZGzFHTAXIXoPH0FNYw8WoaS?=
 =?us-ascii?Q?NVyGUzZwr1oMXsAnGRtMPnYuzUriSBmIPhHsdbptjzGd+lC0g+/TzW1fCrOo?=
 =?us-ascii?Q?osfbEX0N6e8Dz2AA5kkbZHK2z1TyJ18wAsNScxqJLFydDILTjvB1daUx4/+e?=
 =?us-ascii?Q?Gtg4spFftXNcuklWFJ0oW5ej3h4uv0Zn3sDjm9NI/3HJyVUYv4vKOG/Orqid?=
 =?us-ascii?Q?LK5rbsLo6CLeFVirI7PONCTVndNutbVmVmvs1PqdKRaLXhu2OtbYuJ3DECq0?=
 =?us-ascii?Q?FG+XBBAnt0GMx765qcuiO4kVo+0nHvGre5q8J/Mtvy9ltD9L2JaT8lbtkd6f?=
 =?us-ascii?Q?44btL0TwJpeMUofANOuUAhnvozwNJr/oGYiI19/dwzQx1+pICpaaTpetg4mv?=
 =?us-ascii?Q?RLW/LVdRyCVMHO6Xu3+aQORnqteXe6NrXvKl/Pe7d1Ku18eW7qrl+4EHd+ge?=
 =?us-ascii?Q?BUMI1sSqd0uI0MJ6oKMdTnX7b9+7CrUT30r3P8tiWAp/7HkKvrSVZRfI3dfe?=
 =?us-ascii?Q?bjkTNC7ENuuQxo07EvywquulJW34OZVVZI1XH10QzqYYjrEA9Mb2v2WJ0Oee?=
 =?us-ascii?Q?77pnn0p02VQBtRWl3sA5QyYtb6qWFEJt0HnMS/2/yghIBJNiK1wvhdpT3JYg?=
 =?us-ascii?Q?yI4vClIb48CZs0HQguDsKPCF+umrg4yua2z8qg3OSw83c5v9+P4+HVrZID3U?=
 =?us-ascii?Q?A+uwtVex4bT2GS1pTXH0GbramJTwiAmOaAcbH7mWFyNAnL7pILVT+9JJTzq6?=
 =?us-ascii?Q?2RwyeysGEPWsCVSoe+ayBpp26D+tgYweI/+dM3odqIwK98Wx77wSYUssjoLB?=
 =?us-ascii?Q?2KljtBoLsL0Fyay6rdoXXVHXyzMPUvtuPSDQIe3EXeOUXSB5OwYtqFWIlzRL?=
 =?us-ascii?Q?KQDjA9sELGVWmtZsOz1GPKShtWYfg+UNnGLhOjJpW6cLywwsHCm2T7EtswLZ?=
 =?us-ascii?Q?uzn894svRRCo7KZ3gHypKc8S6DJsAqBbq+Ckx/+9t5O5ewwCGesChLP++Tae?=
 =?us-ascii?Q?Sw5MPFRaJhVeTWbBuflhpxqmyJkR9osv+5onWFAFmCdRnjCHo2DdumcJwB7u?=
 =?us-ascii?Q?V5pH0i2G1v4skZ9d3odnPYxQxeVgXq7/dm3FIDQm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bee366-ba0a-4dc6-a173-08db94f1f218
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 13:51:47.4974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0FG1ew66y3JB2f5cVeF/9Sy8wwVXR/OvfBUu9cKp/KmI3Cg3Wk/yKormJlpwe6j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 02:24:21PM -0700, Jacob Pan wrote:
> Intel ENQCMD requires a single PASID to be shared between multiple
> devices, as the PASID is stored in a single MSR register per-process
> and userspace can use only that one PASID.
> 
> This means that the PASID allocation for any ENQCMD using device driver
> must always come from a shared global pool, regardless of what kind of
> domain the PASID will be used with.
> 
> Split the code for the global PASID allocator into
> iommu_alloc/free_global_pasid() so that drivers can attach non-SVA
> domains to PASIDs as well.
> 
> This patch moves global PASID allocation APIs from SVA to IOMMU APIs.
> Reserved PASIDs, currently only RID_PASID, are excluded from the global
> PASID allocation.
> 
> It is expected that device drivers will use the allocated PASIDs to
> attach to appropriate IOMMU domains for use.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v8: fix off-by-one in max_pasid check
> v7: simplify range check (Baolu)
> v6: explicitly exclude reserved a range from SVA PASID allocation
>     check mm PASID compatibility with device
> v5: move PASID range check inside API so that device drivers only pass
>     in struct device* (Kevin)
> v4: move dummy functions outside ifdef CONFIG_IOMMU_SVA (Baolu)
> ---
>  drivers/iommu/iommu-sva.c | 29 ++++++++++-------------------
>  drivers/iommu/iommu.c     | 28 ++++++++++++++++++++++++++++
>  include/linux/iommu.h     | 10 ++++++++++
>  3 files changed, 48 insertions(+), 19 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
