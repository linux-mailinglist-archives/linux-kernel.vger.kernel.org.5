Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DC5765B65
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjG0Sdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjG0Sdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:33:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73B926B2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxxOR/UGYKqmzqK5OFUr0jSAUIXkqDSFx40WIxQVr+i59Oun1TVxRrK0DF7xhLh68pE5enmf3yMaFC5HFvs/XSyg+Uts5RixY6ABfwWGjLqU6lEEVU6Jq/O7KuaRs8Gqs6MSIWpTPZ1MZmwdXe68NBZP94pztq0V9bDwOW+/3StyR9/69lST9l0EvbKGic/jdmzjyu7izbuREBewQ0/gyd/iaTN7Fot+KWV/8kLF6IBGQpelv96hD8he+4AcPGwa+8UbXxX0Bj1gx+zYhQy+8fER2PTiWEXyEB9NUuM3Fwe7kt/O0j1vVJU5j4JrcTL3jvl9q6ynQJ8fpu7wBYkGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmT0gAbnyy/QeCPYmNRBhdCBMGqN2xtRvZbis8Lm0ks=;
 b=LKExQUEjjFwu/G/0XXopEehvWUSs3wbFWzB3nZIH1Pw62z+kMFkNH8tWngx0RZkxxjo0nPPJiUqmZVJPfMWSW/m3cqkexH1CpGU+9dpbEd5sHGF9Xw2sJRaRsajFzEyBlJ6LmgS36MvRrv34E8acCLhJuJILPj0U66/NL2bKFfCu24W+7pD4l1rIuQjKzfqLWONevYeZbmtCo+E8nhrPOwvq7Cz8pl3a0jBbPhxvueicne0L8FPSk3eVynEWIDJS5v6PtXr/CtlLJOBPgwQUxF75MXap58ieL+3PtlGEOJCuJVW9Cex9TODHU2wNZ8k4IkpuZJSeY1Gy8d5/jZwQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmT0gAbnyy/QeCPYmNRBhdCBMGqN2xtRvZbis8Lm0ks=;
 b=VNi08fYowD6DdNFd7ajdJCWr/+/MeMuNark1mHYO6zpIVoA0hre7PNmz00hGR85cKLpxqYyP14TkIPgHW0DvINgogl1PknswF4H5cywrj7AtE+0TS0T6+C1t+MAX3ZRev75YdY3p18M7BgyrQwsRG+2ak01VPIqcwx9ZdOWeEkCRtvMIuf77KOZEAKehJn0AvCkQ8ud29taRL1Fhy+TbwftjJJ9U1/I38RAeJBB2c8omU0RtE3S33qrRrK6HyNqMCXobcMJxSLRf7e1Weg0p3XJXHksLHmzeaUWRWAXV2srvCI2JjRkV4FmC3ySUmIzbwZ6wtquBQSyuc4OnYZXtfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 18:33:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 18:33:43 +0000
Date:   Thu, 27 Jul 2023 15:33:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/7] iommu/arm-smmu-v3: Skip cd sync if CD table isn't
 active
Message-ID: <ZMK4hEJXb2m36VOF@nvidia.com>
References: <20230727182647.4106140-1-mshavit@google.com>
 <20230727182647.4106140-6-mshavit@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727182647.4106140-6-mshavit@google.com>
X-ClientProxiedBy: BYAPR11CA0086.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ea40d9-b374-49e4-4106-08db8ed001b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVjnJgtktfjmaEJRJqLmlZ00hPUg0n23XC8VARXWUsFtSSULRO314rGsytqjSzydSO0wGW17lQuMTV9meGIxEg2DAvURqpOxsedYXYY1rRma4dydiYBVD2c1vxVFXnMXzinIFPEQXEDKRCPphDchi7gCIMob3mjBwEDmqGV548CAOVrQnwRAwswjxc6iPBspcqxec8g1C/Iut8snH02pqPL5UqRmKSPJpEeOVwlZR4AagxR5omLMJsI+5QR0ykJc9HtA7VhnJ/Xi8ACQpyH2kseHb5vJ9beEzrFLFXlL04FMftuE79SgBK3qpNz06zcNTvF4Of3QQY+VA7uEzQvo2xcLk2hz26Q0H2rOqpVDL9EJ6PwZ6AsXxAeFMyHcC9V2twu0yGGNt8KR62hdBcRw4S732RUmO4Z82NZ0qBQM6yabqFzAkR86Bk4yV8blIGOQX07bdFfodVEiZQk9nSNnQ5ePyBmsZMxy5dtMtm8FMuutP7nXyjTc3wKAvdxNw88/V7kh23F2vW9SGAObGpT5r+4ubbYe+MNc6LB/dJaJUnvEaDs2D5x6yVNK6/USK+KN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(26005)(54906003)(6486002)(6512007)(186003)(6506007)(66476007)(2906002)(2616005)(66556008)(8676002)(41300700001)(316002)(5660300002)(66946007)(6916009)(8936002)(4326008)(38100700002)(86362001)(36756003)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IxYdL+1dODbUhDUPa1DJitA87IRc/oogv8mK2qRwh3AvhPSnBEeiyl0tg81R?=
 =?us-ascii?Q?VsNgsFG1Kd6996xEUjiXrxIYLAiNnoCmyF1nGTUFj+u5oEDka2rOZdVUnzMv?=
 =?us-ascii?Q?qpiWm7oDasfj86SKt1sBKTgPILqFivRy2dIg107IwzMa6CwNlw+BS0h4gcCk?=
 =?us-ascii?Q?COTNl7oXFbgmj5N/sIejr3AY+ToKiOzhwibmzimQlP8RgExCjFLB4ewlFb0I?=
 =?us-ascii?Q?dLdgg8TxZFyo1ewK000U9LIDRlUCYA9g+28nFquaEpdZ5oSA05QMRVFKZvDC?=
 =?us-ascii?Q?U8zjKCclGBStyvfhNYvmueDDuRdrfI/V2cWWyRc3S6WVS4JdzjQ/wcr6EhE2?=
 =?us-ascii?Q?cc9RW/a0mwJ/f/9mBsY9AKEyN0+6hToBZAzN/AquQNYvEWOna7vnRXl+wJQ1?=
 =?us-ascii?Q?E2Kp9RCWK/hTXvPb90KMPdB+adAcBnmk1VfsIlF872p7fhyxXRoAmS0m00xc?=
 =?us-ascii?Q?ePxt1P0sxyVQL9Mpx/dmpMVVIg8bafkScjoFfQF1c0GmnPGjOsAXFy+WoJl6?=
 =?us-ascii?Q?Kk9YkGlPceG5EGmfRv18DGDVp9V0ik1LeZzGYAAWGooStXvmaOrN3o75k89d?=
 =?us-ascii?Q?dmH6D6tdM3miym2uTlAqfrquhztgk61zAiF+crKGX9A8Js/FDgqt4/njbYMC?=
 =?us-ascii?Q?D21R3BsHffZryPz8/7wLgclYfC3N7Nc+uAriT1SFP0WV7pL+Fb+dCQ4/qbg9?=
 =?us-ascii?Q?GQlkym20LiBaGcpyXUO6xvsJQaL4PfCI61Se5rjoLPI5CXJDW3lO3QN3cVV6?=
 =?us-ascii?Q?dLGXTBVwvXVbAm6xBN8GXUXDnCyZDQ91fVIWKZF3J7Eyqxg5FLW0Voibq3TV?=
 =?us-ascii?Q?3G/15610TAu/VZhiDhxx05nHvIyHFSIPwPgn0QsNt7sNH7VkR81ujiKrrJ1o?=
 =?us-ascii?Q?yyd6t8T6Pxf3hP80E9G0V3NFrIlq+OT0O8SM2uPQuk9f/Gjp7Dl6Irty9Fh0?=
 =?us-ascii?Q?fRzP/w3XG309gwpLuy/L5kgUdDMGIRXE5bkbPgte+SOagufSJ9ok4ZrnkzVH?=
 =?us-ascii?Q?aV26dTYaYhTTgKpJnEASuprtJEFHp6FzHgc/BugdSgoyA8ULWhSVGg9wIvbE?=
 =?us-ascii?Q?GQUSD5TkBt7vd3kGnS+/V5Let3/UtwpZWbZA473AlbP6BEUCuKbkbfRwBhju?=
 =?us-ascii?Q?TWepWLScwOKhBmNQ1GGNZXnuPil0YWc9mvxob64HcxmhblJM92lTEr7Ry+os?=
 =?us-ascii?Q?WNUH94BQDoadfp8QjDumIVIiOxbxW/e8SvZKneJpc1M+S5K/AAtf80zOArpN?=
 =?us-ascii?Q?EEibMI1p1NCseV9hrWNHHRgK3cV+riCXp0CvhN8r4DaJgnOC2UdAqDzRUn7N?=
 =?us-ascii?Q?HcLtPoM5g02ctGbZSiYvZLf/It8lIgPTu54RN91IJG7zHghMdja2+66BYTC8?=
 =?us-ascii?Q?BV9pQkTWWunzs4o6VGrFcZ9CY1K3f30TgJTru83lMPEOD+7vLwbARVzbs/ks?=
 =?us-ascii?Q?E9G9GwWkSjFdu8UCkWSHOqa0nGzc6k7bVugw2QdwzLWq40mRaj3GdFmQb386?=
 =?us-ascii?Q?xkJXGQ40Rwbs9++9Pcz9vO/YJtwWQcII9XN/QUNs7v0nWOI3ZgIpaLK9V3JK?=
 =?us-ascii?Q?56TfonRM88ppxqXx0/D4Xz5YMJts6mhECZ2Z5H7H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ea40d9-b374-49e4-4106-08db8ed001b1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 18:33:43.7854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sh0Ib/ONlKcJt0GVd9tSuElpZkoQ6UE49/ecBl4iuiPTt9ShHQMkxdZArcBdqK3v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 02:26:21AM +0800, Michael Shavit wrote:
> This commit explicitly keeps track of whether a CD table is installed in
> an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
> was previously achieved through the domain->devices list, but we are
> moving to a model where arm_smmu_sync_cd directly operates on a master
> and the master's CD table instead of a domain.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 654acf6002bf3..af7949b62327b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -987,6 +987,9 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
>  		},
>  	};
>  
> +	if (!smmu_domain->cd_table.installed)
> +		return;
> +
>  	cmds.num = 0;
>  
>  	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> @@ -1368,6 +1371,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  				  cd_table->l1_desc ?
>  					  STRTAB_STE_0_S1FMT_64K_L2 :
>  					  STRTAB_STE_0_S1FMT_LINEAR);
> +		cd_table->installed = true;
>  	}
>  
>  	if (s2_cfg) {
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 0e55ca0d40e6b..f301efe90b599 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -599,6 +599,8 @@ struct arm_smmu_ctx_desc_cfg {
>  	u8				max_cds_bits;
>  	/* Whether CD entries in this table have the stall bit set. */
>  	bool				stall_enabled;
> +	/* Whether this CD table is installed in any STE */
> +	bool                            installed;

Do

u8 xx:1;
u8 yy:1;

For these things, Linus has complained about lists of bools in structs
before.

Jason
