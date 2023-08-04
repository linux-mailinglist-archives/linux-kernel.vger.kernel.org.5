Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE56770255
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjHDNww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjHDNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:52:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815E21BC3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4vM4eXYDEJhcTvp5H0tOoTYeDJpQpQxd3kM0UdVD67Icg+zkZ36+QgVaiuE2Yyj4XJYvTrcz5tTFuJDiCaGNXaBhU8wDXFXURWwCFvwIqGhQUCwD9/EP8U4cNao9hv4Kk1H8qBAPJtkAi9iqVoQDUNykSflGpJkLJQnGmrHvKbDIQcSptc9tKLv5QfW/LN9qoU1BosWOEpvLhQZnz9E7zK7N8WSF+PNHuduIh9WYhUzsKF/EY14uq0OQfc12k6E4GfeS4Y13yt6zOHpDtdYj37LfQ95Ld9tFhh7o4JjTVqEuXEyY1JbRncGuctYyPUMZKtH6+ZzjUc2zjOKjmZo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zaot2hMHy8rlD0N1QKu8W+ZaGnEpDtco90wgAR3zsLM=;
 b=ajy5jxKNOCdsX6GWQl9aqdcDYD53hKQx9+9+XJE0fTxLa8WIstZ0pituzJlnOOPD4SIN490yRASf2puSlTOiJpgfO+Z+0KOx9tvjDsgd0EQf6JUbO8mgR0N5RwwIxWx710DJw1z3KJ7QG3l24jCUxDj7e4UYNd6BciyvdV6VW3uXXLLwOUL/EW/xCpI67/98GxG/6+DQDO1dl+Q44Fi8bqfmFYzKDE6DppDbYTSYBburWPuG07cJVhE/GSBcWhim+HNa2vZZwsBascAglHFKYbm0os1HrMqR6EGvprN4v+qeSNZj70/CcYgmjhqNMVrZv7IJWo2j9CAqGrdreRYdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zaot2hMHy8rlD0N1QKu8W+ZaGnEpDtco90wgAR3zsLM=;
 b=aVXc3g7kbJznZxgstdd91KaO5hQ5Xrnbx/j7z/SlV1c3qpAwpxBysiV+F/gF1trHhQlXueogUebkPor4eIHj21J2kck/VDi8WP/8sIu8g7FK1HccLPn8lLALW7pgY7BGWb6snt7Fw1mYcJuzgRxVbSqnT9Nj2tJCZ9VkmUVC99xeAEbuB1KGj/jnGdTdMJKx9QFc6wfpJpE7yxhDDc22E2NISY3Xq3YGWFamp52GZtT7/AVfKmgyfwPNHnk3+uqu3I+uykrAJn9n7EUP6EkNT/BatJR5WAM1cdS3XFjOj9ccP6w0Jq73NYD53P5qCvG5VS9Fn2vYU04zy1pqfqmqJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 13:52:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 13:52:00 +0000
Date:   Fri, 4 Aug 2023 10:51:59 -0300
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
        Tony Luck <tony.luck@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v12 1/8] iommu: Generalize PASID 0 for normal DMA w/o
 PASID
Message-ID: <ZM0Cf4p43/S4qGof@nvidia.com>
References: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
 <20230802212427.1497170-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802212427.1497170-2-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 70cf1928-96db-4816-0b09-08db94f1fa1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H19Dul3yAfqvGeNemo96kthZOhDpw4gwWyg2WRSmFL2dmug5Ajw52JTmwd/vdZugqSyDHdOXrQYUCfS/1P9TR4qVvqyR9IBb6BXlSoixwSkCoavGDCZeloykJDUB9VYfUqImlxS5iJINyA68UQ6B9eHdT9dQZdyRWk9RwdXgxIJLnapRcThOWcD4EbisLMwS4KA6/3UCXnQNF+qvelx0dtgTogoYVgQEMnEhs92LfIOca0IOm85MGx6j9z8Jpr2O4426+kS2wm4+28s4eQAorcwCjBUcyora73xZGHM/4JQqJi2uGWUcmbHMsr+Hl9jzy1xrh0I+VpPvLpO/BqRlhwYPjDOgd3W7Ok1uMB/SNfzdslQyb0xqNZW/uU1P/GgdGeSbhVCRyIxv4N6fQwRcp7Cyc6H3U3dDyYyoSa4zInhvUMASs7rjjbNsashTFDOUbXKQ4MrExOPT/34P4L8J+Qa+uENxu4p2d68L6m5u1gBj53QUeJnZQbB/G1qqnwjTyrPx237SaAg6/VMeNh9NC/zonyHr9U6uhTRDklPq67zZZmRk7BJR8p5Fj/VE2Kky
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(1800799003)(186006)(41300700001)(8936002)(8676002)(83380400001)(26005)(6506007)(38100700002)(2616005)(86362001)(316002)(6916009)(478600001)(6486002)(6512007)(54906003)(66556008)(66476007)(4326008)(36756003)(2906002)(5660300002)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J2TnRG9GHm6k9ZnK5uk3ebME+fjcWbpksU8gqZiqfeXvl3+cfV+uckCnjiek?=
 =?us-ascii?Q?UDjtzZf6xFs9LfQqBT3vlXX27VhjDQuYRjmQrH5I/EtecCUmBc+Nm9TnKrKb?=
 =?us-ascii?Q?4GBe/7oJEgOGz5lAbk0fq3xWkIPOwaYPtu0ia95nvsSoKipr6znKQIfHIm03?=
 =?us-ascii?Q?2tMlm00zt3JTK8jgPZ7e6ydaL8MosneNvFanlDvUSAt/vcR8wV1g4frf7JeQ?=
 =?us-ascii?Q?7/otbhoPX6rTtdWzl0k3B+kfK4F+13kut/db8B2HTBaPPw8YTvI56xNsOOYA?=
 =?us-ascii?Q?u8f2Edkkd727zQE10zLSdmwZy0xA5b0YmTP40PHqxqPdbtGqFtCehKMmNrNZ?=
 =?us-ascii?Q?UGVXO9JrqDe0SBdbQZAdltjI+AoXvU/2phsjew6zpe55xaHJHmU2q3nTgtpJ?=
 =?us-ascii?Q?YTZYIooot+qqTbzHuFNj3qyJFzcA+HXDesuyMOGGmQtkRrdPl8IF9RNLxE1d?=
 =?us-ascii?Q?M4wozWduxXkm9B1MXUkiUrHhaQMaWlpazNSrhqr9AIQEewYKYCUucBTtu2xh?=
 =?us-ascii?Q?fN4uPYLANzJaZlAuZtHPysajX3z7L5BoFLNXv0KT7tAr/GW3T7pDkN59IBgf?=
 =?us-ascii?Q?lRUn19j6E9GbLk9KyJsnJG58a6KfiUnTdsAOIiQ1zGQA3MjojvjkNoj+eSbc?=
 =?us-ascii?Q?5d4sHsoa4mev27Yr/uhME0y2KmreKk91cAZ7TiqavvbYx+f8/CkT5e4abqdh?=
 =?us-ascii?Q?w0Bhdsqi6WPBm6PHgAmI0wQYUFHEwF71Lgcqc5QZKyk2tiRLQWlfHlYjEQH4?=
 =?us-ascii?Q?prnLstM+GffaxRKR5ilksWrVv9Ns/nn0BWGuiSckaMVB1fIdiZcmm8XYT1KO?=
 =?us-ascii?Q?ISJ6h2zJMdR8NREGKvz8d61JwGNTn99ID70RGNpNwzNxrFEydG9/93dQb18J?=
 =?us-ascii?Q?XOcUr6queBwhNKV0LlPsDk03YGTfx0KUyh+5tRAN3rsBnsrBuKRf1UuXfiaz?=
 =?us-ascii?Q?x+FI+4gNUyETlCXZ4SGRqxudbNJIvJso0NTee1rDO/H7IYaaEtQRaWfsKIGw?=
 =?us-ascii?Q?K/hHdfJQD1a3+jpxpIOsNqtUv5zyMfwCXEkrdzoeYLjC8HZFjq/CURMFRDWV?=
 =?us-ascii?Q?n8r8Uo63JyH1piv6vsCDY259xcqELO0IKFX/S6WXwvT8WNsvm7z/+vUCDdu7?=
 =?us-ascii?Q?LKdfGCVGsu3oedMrj3idaYmn5SdqvEtQv6336SYckBfJSlbiRpTSSnbkj4dI?=
 =?us-ascii?Q?a4/0Bukpd/prUQopnkrurRsthKYLV14FoGv34q/MUtPqRtuv+TeW5F20FRsV?=
 =?us-ascii?Q?2OcB2pH1UwmBb/vGVQQqDG0vGTd0l8GAsnbquvc0gf9RjSlY3VauUxKm7UOE?=
 =?us-ascii?Q?ujdCtdybUHtmnckQy/zr9RQEjwXSFaXXlVP1sQvsfvqAB/IQg86+/97PNFQz?=
 =?us-ascii?Q?0+ffHNNRbwjKjHCmsszvPz1KgofH5COtwZUSm9927I/ZpCA2uGJbT7mXhnnt?=
 =?us-ascii?Q?FBgRn7wTluYEtz02kpKZgJdOsmxylELWpti5f3fP8Vhlb7tuA7QcakmeIRlT?=
 =?us-ascii?Q?Kykm8q6JqEy8G1KPrw+71vrWTLPdcRqiBNKaK6VWFmmnEfjhIY2x6RCsK0FW?=
 =?us-ascii?Q?ua2tiizYN9nGyYXlDDOXrV05Vk439o89Zr8lzAFi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cf1928-96db-4816-0b09-08db94f1fa1d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 13:52:00.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGzNQmhAPyrvv/6VUW8UvxQzvUgAdy1y/MbzENxqIUj9yfNP8uK/m7B0sV3UzlcI
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

On Wed, Aug 02, 2023 at 02:24:20PM -0700, Jacob Pan wrote:
> PCIe Process address space ID (PASID) is used to tag DMA traffic, it
> provides finer grained isolation than requester ID (RID).
> 
> For each device/RID, 0 is a special PASID for the normal DMA (no
> PASID). This is universal across all architectures that supports PASID,
> therefore warranted to be reserved globally and declared in the common
> header. Consequently, we can avoid the conflict between different PASID
> use cases in the generic code. e.g. SVA and DMA API with PASIDs.
> 
> This paved away for device drivers to choose global PASID policy while
> continue doing normal DMA.
> 
> Noting that VT-d could support none-zero RID/NO_PASID, but currently not
> used.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v8:
>    - make consistent use of NO_PASID in SMMU code
>    - remove PASID_MIN
> v7:
>    - renamed IOMMU_DEF_RID_PASID to be IOMMU_NO_PASID to be more generic
> v6:
>    - let SMMU code use the common RID_PASID macro
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 16 ++++++-------
>  drivers/iommu/intel/iommu.c                   | 24 +++++++++----------
>  drivers/iommu/intel/pasid.c                   |  2 +-
>  drivers/iommu/intel/pasid.h                   |  2 --
>  include/linux/iommu.h                         |  1 +
>  6 files changed, 23 insertions(+), 24 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
