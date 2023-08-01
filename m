Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD4376B714
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbjHAOSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjHAOS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:18:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC04BF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4sJxw8Q7G1XHHqT30jd2ICe42WR7QqcOYBeuRrH3fGFIDfub+5pQ5LbM8kDre5p47DSAjYuVqANmSnyA1LIZcKsRcmYItGU/nztYK2jkrYXHfCTBQiDrYzHsXjuWZEB1apjgw6uyGQ5O4rp8qWXGddtRajIr8K7zNlDJX7XzA01RhREM1/fRi064EAknLTjfR74QLivk6pKIryFiTYLQ30tkXxt7OV9xJYIycFWbDlJ6qeYp3SwCZwfZKomLUtlcGjnQxnLLr6urtMgl38tHPpy7/+JIaTSeCrUBdpXS89v4ChDsHibpVfC3G4HO96s6BkkFPpRmzOxmbBw7kIbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXGUIb8uGTWEcL49swnwRgG6PikMFpHW2H9ofMrx5l0=;
 b=b6MHvANn+516BMKbPXxLnTMbGI3O9KSg/qQwRA+7oF4yw1MrGQ3svP5bMRDAge7ECKaZfqsIXNrpvSyLaIZhwdCiRW3yBrfaWWB79wfA7ljQXEBuXH+W7NbUYMQtmc9idx5MSRbNTa3NhAP41JabQdVrTGttIKiOEhYqt1EQz2TSvM+YlcwjFUXVygnilSd8rgjIociyKf6i9aC4ZHDa4l+3wbEHJplpXFxgQmmgNbyOQ5tS8IWkXSUnQnRCpUA8xiSEP5NPW9+O9ggmZvrTbTriCYgERmiWAajW4O9CsCbd99NTtWquJ+C+utz/HzwMoxyIsQQRNwRn1hEoPb5FYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXGUIb8uGTWEcL49swnwRgG6PikMFpHW2H9ofMrx5l0=;
 b=S3iWg0vzUTXgJifKpEfP+EIkUWdF5UMGYSF0/QXC2AqlMrXvHnZiEQUSDCo1oCqu4kKac7jmXHRkFsw26EGj+h16IQbYJXRZwngVd7Ikf+ZUWadtlWuZ/UuSQH+VAw/FVLcAVgZYsUHCLYdzCqeYQifeN2kbwjOWPk54u98DBHDFpTu8I2lGkEF3fa+PQ4eGztKJiswot8R23Xi5+yXTD9f8jneukrMroS0my8T2HIYn05r+xvllaCHSxcpDKDZY1KgfHcfv2WV9s+YJU50CQ0X23+OPa3a7OQgYKKPe77AmRJcr5wTNGCQ0QHzDmbqRCJXy3k9gFX3iAZ2wFMJGZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:18:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:18:23 +0000
Date:   Tue, 1 Aug 2023 11:18:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v2 6/8] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <ZMkULTvwIIE3zo5+@nvidia.com>
References: <20230731104833.800114-1-mshavit@google.com>
 <20230731184817.v2.6.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731184817.v2.6.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
X-ClientProxiedBy: YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9d8d59-f2b5-4f72-0155-08db929a2a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eucq8zAQfcxWrqwR80JzZlH3Fy4DLuGN5P5ZEYxMk8PsCcBygMDl1TVWSJjbc428EpoIFvCJ+zzM4InELzrb+ydv3693Z12rEJHiHfQTs6uDrTJbuLRCG6Yrtc0TgGjsVJIGazIn9a5CQ8tc4bLkKnyK8IR7wvn1Ok+9f/z5UhcPcdDWY/fgS53LpfFLLODt0xD/hDoGRGR2t8OgI1X9LVum+lzKk92B9ybsY6TsLPD3sqB9Uwf/8iYs4/n1XqQnFZdqgUTcmkVb3S7dZ/iu6DJ9i2qOyeCb0NhXOf4XZ9kccY++4h3FiEu2N+ccXbx3SR+OI+3UiISv4Ma0Fi77PhDHZkLY7kb8EgbbWgEuNR8W8ukYvdA+Pzzu51j1Kg0GGP/5ntxkoMEZBE29QyF2sD7eIZF+WSkYES9OI1uRqLNFZ47DCFO8U1QEohbceCV8oCDTzzoz94S6M+WmJjBEQ3fi7FnxdDTYG2d+vvoFjyWr+Tcax+7xq/+SbyeUhYIzdDEXIfj7O525AErAM9aMiZfzwOGksWVK3eZa4cSl/X9Q6RHRtXaN3BBodWDn00IY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(38100700002)(66476007)(86362001)(8676002)(8936002)(316002)(5660300002)(4326008)(6916009)(66946007)(66556008)(41300700001)(478600001)(2906002)(36756003)(6512007)(6486002)(6506007)(26005)(83380400001)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3EGPX0RHalPbnL7h/JU9AyQUiJe5wjh/TAcQ/IltCWFIwgIN4rNUs9hWt5SZ?=
 =?us-ascii?Q?3tTmlJ8xDen51crhfjhklVWH/uJ5HfWL7ZRQ0D/neqGy0CYFG1lKFDRsdGN4?=
 =?us-ascii?Q?PE7n7m+aGBJvZxe4EkYnsSqnyThvpOMmq6zNgHqNeBd1p4yye8au2Rxe7kir?=
 =?us-ascii?Q?MCYBx2s4VMy/p2NMZZR3ipQRFOvjzA6VDjuDesZfa1VSNy4L4W5oVmnrTPBl?=
 =?us-ascii?Q?4ZtjveU85G9Dv4inlymlG7p6hwXW8+gSH/kYedT6DA6O3NjAVXLoeX3JoD2M?=
 =?us-ascii?Q?ADTBFx4XIh9pCwBrtcRVkw7h4R9t6EH6snnOP1czPki49JazMQvuKe7hRI3b?=
 =?us-ascii?Q?4ZtJ/mDW3soLRKKxZ0iMh33B+9TfdCRETH8TOBVa9djXCTgDukT5GwjOqKKp?=
 =?us-ascii?Q?PFDii0rWaOxROGqFxaiiAozDaQUW5JJ3xWFPOo8ZsfnEnVTeHmqm/kOExeYL?=
 =?us-ascii?Q?xjISa8ZNk0hSCqeVzMg4OW590Ns67HUU3CCjNvbVKouJ3FHBnCD1tqJDAZV1?=
 =?us-ascii?Q?CtRiCney5/vYPdhXbk35DHBzykqil1vNWTjfR3FoA8jZ8nf7FoBdLu4vZbGA?=
 =?us-ascii?Q?wL1Q7PnJPo3oc0wvacto1XF4msop0Tz7H0GabVrd2f/eDL85TAPk3KN4Bcaq?=
 =?us-ascii?Q?SBUGNXKzr3K1u7UA0SEFDvyhlKWugzHFA+afkOYl9okuQ+NlGQd5dWuhgYFT?=
 =?us-ascii?Q?k/VDQfDADkd66cCk27K03z4vnUGYLx3h49PnOH1oyNAfAijZ37rliuJtSboU?=
 =?us-ascii?Q?37MxqkZfd40NHPDb2FhAvsGf6eYXs/yjlhY0Dh/XX2bfCCFTzopjO5+UYcci?=
 =?us-ascii?Q?lw9MrSEXrh9cWwYptLVrIoBKKgIrklxQzwL0sz6HwzkKxWKM+54xRw4pGsiQ?=
 =?us-ascii?Q?hzuGV11lSglBQCKW2jdrMCEoYyfIxNeUz4yMSW0/zASyZGfFzWuMJzberjgY?=
 =?us-ascii?Q?5n4dnu3JbHZpJFtCyOBEi2n6vmbZJ8WMY5KJXcPHyJ65fixro6b3u2JFJK2u?=
 =?us-ascii?Q?Fqg5qGrZHKY8Wv9TdyBeqHXE6qWX2AeBQtHjXgBnxeQaTNkahdFe1OSCpyjb?=
 =?us-ascii?Q?r29sg/aqR4a2UVkxhbS3F4+FumBLKVe1GR5DUsT7fVy4yn5J9l2hEpfxA15x?=
 =?us-ascii?Q?IOjY1zGQtI41BbnFIAHWFk/1xGJSXvBDc+lJppKOBMJDUmgShejyg4JOgnJh?=
 =?us-ascii?Q?UMmDeklwLX/UN4RXm7qfF2gcpX8XoOYUQ8FQ7CtZsHru4XbNq1p5078Mud+O?=
 =?us-ascii?Q?Arbw6UO68pGYbBg588A6OvvpmZ0jdAd1LV3xASDFo9eaLJ6MSqQ7kRk7KgmL?=
 =?us-ascii?Q?NupcPZBIARhdiitbjwMMUaCm1POzbRU6JUmWF2vYpJafKCS4KEDUF9h2NFBt?=
 =?us-ascii?Q?JRrkFgz3b9UuaZ8J8gN+8xdlPBwNaXDO/W93BlCds+I83fcQuRoZVE2c3r4T?=
 =?us-ascii?Q?l2Q313kxURG5RSRh3BbxTd4QPqFbSZlhP9hm+Ya4iNWmdF2jur9AjYiwhPSl?=
 =?us-ascii?Q?BRTDdnhVEGmsidkpzxFW6m+K+yeqVh7+HeJAUQKnhnGHzCCj79+Gwol5dfDa?=
 =?us-ascii?Q?MhgC5jw30/DPHmGaLBGMVBwT+zDsLKOOkkNa02S5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9d8d59-f2b5-4f72-0155-08db929a2a0b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:18:23.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gK6hkQxwRTT6oDRteyb0IeuDkYhMjaRU9uTi8wF8PBGo7eJgsoDC3l2/g6vtzAcF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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

On Mon, Jul 31, 2023 at 06:48:16PM +0800, Michael Shavit wrote:
> Update arm_smmu_write_ctx_desc and downstream functions to operate on
> a master instead of an smmu domain. We expect arm_smmu_write_ctx_desc()
> to only be called to write a CD entry into a CD table owned by the
> master. Under the hood, arm_smmu_write_ctx_desc still fetches the CD
> table from the domain that is attached to the master, but a subsequent
> commit will move that table's ownership to the master.
> 
> Note that this change isn't a nop refactor since SVA will call
> arm_smmu_write_ctx_desc in a loop for every master the domain is
> attached to despite the fact that they all share the same CD table. This
> loop may look weird but becomes necessary when the CD table becomes
> per-master in a subsequent commit.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
> Changes in v2:
> - minor style fixes
> 
> Changes in v1:
> - arm_smmu_write_ctx_desc now get's the CD table to write to from the
>   master parameter instead of a distinct parameter. This works well
>   because the CD table being written to should always be owned by the
>   master by the end of this series. This version no longer allows master
>   to be NULL.
> 
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 33 +++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 59 ++++++++-----------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
>  3 files changed, 53 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 968559d625c40..8242ee3405f2d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -45,9 +45,11 @@ static struct arm_smmu_ctx_desc *
>  arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>  {
>  	int ret;
> +	unsigned long flags;
>  	u32 new_asid;
>  	struct arm_smmu_ctx_desc *cd;
>  	struct arm_smmu_device *smmu;
> +	struct arm_smmu_master *master;
>  	struct arm_smmu_domain *smmu_domain;
>  
>  	cd = xa_load(&arm_smmu_asid_xa, asid);
> @@ -80,7 +82,11 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>  	 * be some overlap between use of both ASIDs, until we invalidate the
>  	 * TLB.
>  	 */
> -	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +		arm_smmu_write_ctx_desc(master, 0, cd);
> +	}

I think it is typical kernel style to not include the single statement
{}

> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  
>  	/* Invalidate TLB entries previously associated with that context */
>  	arm_smmu_tlb_inv_asid(smmu, asid);
> @@ -211,6 +217,8 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  {
>  	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
>  	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
> +	struct arm_smmu_master *master;
> +	unsigned long flags;
>  
>  	mutex_lock(&sva_lock);
>  	if (smmu_mn->cleared) {
> @@ -222,7 +230,11 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
>  	 * but disable translation.
>  	 */
> -	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &quiet_cd);
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +		arm_smmu_write_ctx_desc(master, mm->pasid, &quiet_cd);
> +	}
> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);

And here

>  	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
>  	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
> @@ -248,7 +260,9 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
>  			  struct mm_struct *mm)
>  {
>  	int ret;
> +	unsigned long flags;
>  	struct arm_smmu_ctx_desc *cd;
> +	struct arm_smmu_master *master;
>  	struct arm_smmu_mmu_notifier *smmu_mn;
>  
>  	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
> @@ -279,7 +293,11 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
>  		goto err_free_cd;
>  	}
>  
> -	ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +		ret = arm_smmu_write_ctx_desc(master, mm->pasid, cd);
> +	}
> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);

And here..

>  	if (ret)
>  		goto err_put_notifier;
>  
> @@ -296,6 +314,8 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
>  
>  static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
>  {
> +	unsigned long flags;
> +	struct arm_smmu_master *master;
>  	struct mm_struct *mm = smmu_mn->mn.mm;
>  	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
>  	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
> @@ -304,7 +324,12 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
>  		return;
>  
>  	list_del(&smmu_mn->list);
> -	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, NULL);
> +
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +		arm_smmu_write_ctx_desc(master, mm->pasid, NULL);
> +	}
> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
  

And here..

You know, you should try to keep the function instead of duplicating
these

arm_smmu_write_ctx_desc_devices()

And put the four lines in there?

> @@ -987,19 +985,14 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
>  		},
>  	};
>  
> -	if (!smmu_domain->cd_table.installed)
> +	if (!master->domain->cd_table.installed)
>  		return;

BTW, do you have locking for this? I didn't check carefully

Jason
