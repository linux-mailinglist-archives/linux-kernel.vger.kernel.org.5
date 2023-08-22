Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6517841C4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjHVNOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbjHVNOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:14:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A09CD5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVGx8Nf26Kj3RDqc8iiq6jUPPvyqg13YUkZFqHk+98uPRoiJaaKaWsIz+i8g3824avK03YZlsGTS9uz3WAXRUVShGx46L+AdcMf03gMQdJjd2czbv4iaEuNJWaxPH/9qf/7xufwUCF4WHP+RDjOk5crnQIj0VDyWzbBY1ZfYtDlHeh6qYu0oY6DBNjO0ciNyCc4+rdBKsh7MHCiaQurRzRL6xZEU2IzN2zYEETVfTdcahtHDoQvMZolc15m3ww7qLtIcEy6uNkh4Fn3vYFf87mxtBu2cCqt75eeFS8utkFmKRCSik1FdVFqGN3gnwlMxfWh34cWnnwbcxiPeG6nBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZD5ivyuAgZkRGuqmzjtqOKmyKyigHvR9xGjGJGqfEvM=;
 b=dVFj1+KCd5NE/2ApvZ9Ep+NwetpqpijPoAVIjTeVIkrtoRX43kOMMC7flN0ZUu6tvyU/TATKwxbrIa3de3BYrGasRo+fQcgSDsasPeTDnuOJRNxnlZHRotPtZXOmb1B5ZC/ZLOhsoyamxWn0gvmYHsO+hYRyGQjsMnnOO+nNbEV41dkjx63HpkdMD8QeXQtrixAKq14oxtgECX+gqiOcnqFlRB+jrkeJ0/gsCTc5YpU6U0+vyaj0XWkuHb4UzAo15O1b6WHpYSpOayWVk1oje/YD2+2DcDnzSSanIOKoN4H4sXI1dB2t29eXETNTIQ50COQqHekEAAsqJYcED3Y33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZD5ivyuAgZkRGuqmzjtqOKmyKyigHvR9xGjGJGqfEvM=;
 b=S+MvpOuix7K/mx1N4kgCtKewFFLp6GyUz4QxonEKHy56J411Xgkk3tBYiSqg2X7B8ha74ZsIKCnjFXsIVneDSPT/S5pQYXFR2xl6OZQ7VWpi9EpwQ25a0og/SUWYCJh0pIjvhTpnRt07UyJrvr7dRom1B28ac3J0CF7raxdzlTGecQZJII2g/6dsCHUOHPU6zoqVs6I/YnWVE5xQTrT5DIF7PfykpF8oeGpIEoAbJ2yNKSpBAp4yZKENK9p3mgDL20R02qRILCD6FB/7GWXMJsxwyTCbJ9kr+796xLtEso1QubpWy4v0kzrqiXSuHfr6Zl3naJRTrzSOn0nxZxkazQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 13:14:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 13:14:11 +0000
Date:   Tue, 22 Aug 2023 10:14:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org, will@kernel.org,
        robin.murphy@arm.com, Dawei Li <set_pte_at@outlook.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v2 3/9] iommu/arm-smmu-v3: Issue invalidations
 commands to multiple SMMUs
Message-ID: <ZOS0ocsjy34N5s4l@nvidia.com>
References: <20230822105738.1607365-1-mshavit@google.com>
 <20230822185632.RFC.v2.3.I0f149f177e5478e28dc3223c2d10729d8f28d53a@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822185632.RFC.v2.3.I0f149f177e5478e28dc3223c2d10729d8f28d53a@changeid>
X-ClientProxiedBy: BL0PR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:207:3d::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 819a9fcb-3dc0-4875-e966-08dba311acac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFQfan4nHiJYfPpkYpruo7EQ32n6vCXTQCVs8Ze1vibEu4y+bt+ccRZ58tXdYVJ31RZtfU8f0DpjmA3n/f2iW8HQycgmNEU3AioHS8j/H9bp9IhCEHKuYR87FOd5tp+ZGYri4hUL5noibgLV+tjglTXKJgOP5xxOJCAoLYj7jiAKWbix2bLXWyQYzj4avqZ5FzEpRL/sgBWWXX3byrLDbzbMqeNJ2u4IyIp5AB3fo1Cp1CYs5OukDinKVyJGP6efA2piUDGb1ZjsjLFnvgx1gLX3FkQWWVSJmuwVPGhQVQPTP3k1O654pqaydxVR+/3JcWl3PxvyPp8drHogF22Gev02koVSZplzok2Bhe9KQVfu08jJXjwYwgHv53YaJMCZKVQ5noxdZqpJy+Da/KQM3+5h95wMVin2sth6SRkusCdj7ikczKSRGa6gqVOZ7BB6c5QECpjSIN4RqJ/iSXcPOKZx+v/hmODVgFBQa7oyv+Cdjd2iAxbfzVtkeQjcohnoHCB7Tzt8sw8DZStUCNLmC76El0Sw83t6DZNHidh7YWAzPp6pi4z31Uqgx73CEs5t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199024)(186009)(1800799009)(86362001)(5660300002)(66556008)(2616005)(66476007)(66946007)(316002)(6916009)(2906002)(54906003)(7416002)(8676002)(478600001)(4326008)(8936002)(41300700001)(6486002)(38100700002)(6506007)(6512007)(26005)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mhLnjLAYZnkIQXT3Ut93WXGYItJU+JPO1j4gM8c16JghOcjhaAvv7tCvETsH?=
 =?us-ascii?Q?e5ky4iApjjtE083bwddX36XOFRAHKb3EuK1FJ530AeOS4bHTrU+ezgEz/vbD?=
 =?us-ascii?Q?LPR3LpXRFu1IYw4nEOyMgoXnEy20OyKfiB4QRqrKNL+g3mY51SXdh6oeUeOg?=
 =?us-ascii?Q?mZnYBkE1zHGPP9hBRJDf3dS5OwCnGZR3MsIHPcqQUn9RfrckdwF49vEOExcw?=
 =?us-ascii?Q?zIGXzr5u7uGp+IO+kgoA0PpY+OkvFQzuhkK1YB1jquUZwbX6P9z2ZfYF0MxV?=
 =?us-ascii?Q?tfF+WICnAfV8MzsiKaJpjPJwrNmiTKdhwW6FcWTkOy1OvcXwfDPBAKFJMKH+?=
 =?us-ascii?Q?5mdL/hOQ7Q6Ab9walbuW8sAgvhCXNKE8ng48DXRwy87mHV1oXCrOZ8clMzWR?=
 =?us-ascii?Q?BmCt2lsboyAyZANB7GVE/UmqQYkwr9/hSfpdK6cfeAJ34l717rhcqwACrlSC?=
 =?us-ascii?Q?DTmoJriK9/7fUwQBlsjJMj2fbdDmx03Pg+c7cqDjyrWGdmJvruqqjonLNHmr?=
 =?us-ascii?Q?71VBl3w6mKwMU0RBY21GJcfMonYCutLEZAuLWoMOX66pe+giDE3qYEbDcPiu?=
 =?us-ascii?Q?c0AFwNmdqBOL/BqHhtWMt//L2DQZKUDE3BMbd/iJ53JPYO2xpfJQwW6EmvTq?=
 =?us-ascii?Q?ylPp1Cx+c+nfztAMYx1R51+Z93aTsCkzHXI3ttFyBHC/tRzsBveCj9X5ET+N?=
 =?us-ascii?Q?V7X4xHvYfax1auXr2KAVcAmoFrTpyIroQF9Fyn/NPfUf4/EEP1pASF+Amkuc?=
 =?us-ascii?Q?HZ0qzvfmtv/TeHN5ERi0lRc2jth+eIRa8GdrZVQyvSIExM/AEY0msuTYQzIY?=
 =?us-ascii?Q?jVeaxnWFK/SsGU0836bhbPfcY1JaqEZ2FynBUvG5QpzTN2bVOGivEbVsol4c?=
 =?us-ascii?Q?X86miYTViuXQ442MIvjc5LNmy9Mrp4gcq+ll6BjdjJ52WEYtia9685BjkxuR?=
 =?us-ascii?Q?B/1qGQ6A2TLP0fcNWHHatk6iDKTDG5uGXXABz1Sou8yBEIh8QYpxCUjSsd9S?=
 =?us-ascii?Q?8AXVhxnerwIr6AAIJWSIDX6jhiQy9eQb2QZYr4m3M3Uvx/47JM1kuVmizVyl?=
 =?us-ascii?Q?QDHaYjaxpRpbX/zZ3aVCKehLazGn9Qn2pz44sO8lq9x5JycYmBb4ZibviR4h?=
 =?us-ascii?Q?ddV9EidKPNIq1CnIciADAhUPkOH+yqWQCAFuRMq9GFlg8h9zLD1uTyPDO2gW?=
 =?us-ascii?Q?326BHCbkEz/BkXPq2d6vwrA7dB6HljatQDCap80QY08cJJ8fK61FNo8xt1u0?=
 =?us-ascii?Q?EbimAkS+IDxecba8dKijoHq+GFWT3OSmdOTAgqI8IHcev8tpGxhbJuYHuswP?=
 =?us-ascii?Q?7JAvcyTP7C9SFl9H6q2LeqkK2aihIYa4S5ECVHJwoE0UCPBOsoIQMTagMLmY?=
 =?us-ascii?Q?7ctpSdSieF8B56jWjUFiYLNakCp5Yo0X4r/vwDiuN3BrZlCSHEZxKCC9BQsc?=
 =?us-ascii?Q?xWFoYkDOnBaqOWd6zDpIXD6YtM6bLZm9s7bpbJ2XBKJeB8orQghJTsf8KBUU?=
 =?us-ascii?Q?WsGTzVOGeMiJ0O/vjJVX+cHoedt8Kt1UqEEPhCQkjYZHRDuIAnZF7mnI3WJk?=
 =?us-ascii?Q?WYvlFRlOPIRPEe5hNQbcw9FF/Qz/VCkZs4wViinb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819a9fcb-3dc0-4875-e966-08dba311acac
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 13:14:11.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SELu2ItiPNCSG7p9uaMnu8x6nEnsnXdfeN/dslbN336MnVbrEgOWJAPcGkoytIlw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 06:56:59PM +0800, Michael Shavit wrote:
> Assume that devices in the smmu_domain->domain list that belong to the
> same SMMU are adjacent to each other in the list.
> Batch TLB/ATC invalidation commands for an smmu_domain by the SMMU
> devices that the domain is installed to.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
> Changes in v2:
> - Moved the ARM_SMMU_FEAT_BTM changes into a new prepatory commit
> 
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   6 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 134 +++++++++++++-----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   2 +-
>  3 files changed, 104 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 53f65a89a55f9..fe88a7880ad57 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -112,7 +112,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>  	arm_smmu_write_ctx_desc_devices(smmu_domain, 0, cd);
>  
>  	/* Invalidate TLB entries previously associated with that context */
> -	arm_smmu_tlb_inv_asid(smmu, asid);
> +	arm_smmu_tlb_inv_asid(smmu_domain, asid);
>  
>  	xa_erase(&arm_smmu_asid_xa, asid);
>  	return NULL;
> @@ -252,7 +252,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  	 */
>  	arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd);
>  
> -	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
> +	arm_smmu_tlb_inv_asid(smmu_domain, smmu_mn->cd->asid);
>  	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
>  
>  	smmu_mn->cleared = true;
> @@ -340,7 +340,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
>  	 * new TLB entry can have been formed.
>  	 */
>  	if (!smmu_mn->cleared) {
> -		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
> +		arm_smmu_tlb_inv_asid(smmu_domain, cd->asid);
>  		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
>  	}
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index db4df9d6aef10..1d072fd38a2d6 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -960,15 +960,28 @@ static int arm_smmu_page_response(struct device *dev,
>  }
>  
>  /* Context descriptor manipulation functions */
> -void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
> +void arm_smmu_tlb_inv_asid(struct arm_smmu_domain *smmu_domain, u16 asid)
>  {
> +	struct arm_smmu_device *smmu = NULL;
> +	struct arm_smmu_master *master;
>  	struct arm_smmu_cmdq_ent cmd = {
> -		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
> -			CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID,
>  		.tlbi.asid = asid,
>  	};
> +	unsigned long flags;
>  
> -	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master, &smmu_domain->devices,
> +			    domain_head) {
> +		if (!smmu)
> +			smmu = master->smmu;
> +		if (smmu != master->smmu ||
> +		    list_is_last(&master->domain_head, &smmu_domain->devices)) {

Finding the end of the list seems too complicated, just:

	struct arm_smmu_device *invalidated_smmu = NULL;
	list_for_each_entry(master, &smmu_domain->devices,
			    domain_head) {
             if (master->smmu == invalidated_smmu)
	          continue;
             cmd.opcode = smmu->features & ARM_SMMU_FEAT_E2H ?
			CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID,
             arm_smmu_cmdq_issue_cmd_with_sync(master->smmu, &cmd);
	     invalidated_smmu = master->smmu;
        }

> @@ -1839,28 +1851,56 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
>  	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
>  
>  	cmds.num = 0;
> -
>  	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
>  	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
>  		if (!master->ats_enabled)
>  			continue;
> +		if (!smmu)
> +			smmu = master->smmu;
> +		if (smmu != master->smmu ||
> +		    list_is_last(&master->domain_head, &smmu_domain->devices)) {
> +			ret = arm_smmu_cmdq_batch_submit(smmu, &cmds);
> +			if (ret)
> +				break;
> +			cmds.num = 0;
> +		}
>  
>  		for (i = 0; i < master->num_streams; i++) {
>  			cmd.atc.sid = master->streams[i].id;
> -			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
> +			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
>  		}
>  	}

Doesn't the IOTLB invalidate have to come before the ATC invalidate?

So again, use the pattern as above?

>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  
> -	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
> +	return ret;
> +}
> +
> +static void arm_smmu_tlb_inv_vmid(struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_device *smmu = NULL;
> +	struct arm_smmu_master *master;
> +	struct arm_smmu_cmdq_ent cmd = {
> +		.opcode = CMDQ_OP_TLBI_S12_VMALL,
> +		.tlbi.vmid = smmu_domain->s2_cfg.vmid,
> +	};
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master, &smmu_domain->devices,
> +			    domain_head) {
> +		if (!smmu)
> +			smmu = master->smmu;
> +		if (smmu != master->smmu ||
> +		    list_is_last(&master->domain_head, &smmu_domain->devices))
> +			arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> +	}
> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  }

I count three of these, so a macro helper is probably a good
idea. Something approx like:

static struct arm_smmu_master *smmu_next_entry(struct arm_smmu_master *pos,
					       struct arm_smmu_domain *domain)
{
	struct arm_smmu *smmu = pos->smmu;

	do {
		pos = list_next_entry(pos, domain_head);
	} while (!list_entry_is_head(pos, domain->devices, domain_head) &&
		 pos->smmu == smmu);
	return pos;
}

#define for_each_smmu(pos, domain, smmu)                                       \
	for (pos = list_first_entry((domain)->devices, struct arm_smmu_master, \
				    domain_head),                              \
	    smmu = (pos)->smmu;                                                \
	     !list_entry_is_head(pos, (domain)->devices, domain_head);         \
	     pos = smmu_next_entry(pos, domain), smmu = (pos)->smmu)

> @@ -1949,21 +1987,36 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
>  					  size_t granule, bool leaf,
>  					  struct arm_smmu_domain *smmu_domain)
>  {
> +	struct arm_smmu_device *smmu = NULL;
> +	struct arm_smmu_master *master;
>  	struct arm_smmu_cmdq_ent cmd = {
>  		.tlbi = {
>  			.leaf	= leaf,
>  		},
>  	};
> +	unsigned long flags;
>  
> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> -		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
> -				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
> -		cmd.tlbi.asid	= smmu_domain->cd.asid;
> -	} else {
> -		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
> -		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +		if (!smmu)
> +			smmu = master->smmu;
> +		if (smmu != master->smmu ||
> +		    list_is_last(&master->domain_head, &smmu_domain->devices)) {
> +			if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> +				cmd.opcode = smmu->features &
> +							     ARM_SMMU_FEAT_E2H ?
> +						     CMDQ_OP_TLBI_EL2_VA :
> +						     CMDQ_OP_TLBI_NH_VA;
> +				cmd.tlbi.asid = smmu_domain->cd.asid;
> +			} else {
> +				cmd.opcode = CMDQ_OP_TLBI_S2_IPA;
> +				cmd.tlbi.vmid = smmu_domain->s2_cfg.vmid;
> +			}

These calculations based on smmu domain shouldn't be in the loop, the
smmu_domain doesn't change.

> -	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +		if (!smmu)
> +			smmu = master->smmu;
> +		if (smmu != master->smmu ||
> +		    list_is_last(&master->domain_head, &smmu_domain->devices)) {
> +			if (skip_btm_capable_devices &&
> +			    smmu->features & ARM_SMMU_FEAT_BTM)
> +				continue;
> +			cmd.opcode = smmu->features & ARM_SMMU_FEAT_E2H ?
> +					     CMDQ_OP_TLBI_EL2_VA :
> +					     CMDQ_OP_TLBI_NH_VA;

There are 3 places doing this if, maybe it should be in a wrapper of
__arm_smmu_tlb_inv_range ?

Jason
