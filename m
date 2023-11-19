Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1270A7F09FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 01:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjKTAMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 19:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKTAM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 19:12:29 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC502E0;
        Sun, 19 Nov 2023 16:12:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MobNXeuVd8uxO7aiuZs+b/yLEVz1uxRj0I44pYGyb/Yv9glF+YCzSl/+vGjq57LKcBePZt+Dx8BNOWPGrMGlBKB2/JY3AJobFaNCCwNUB0butsz67sxaoxqGCAjiu5bFwjUQ1TBK79AsD2qQH74n5R69xhMgAxZ9N4ZAzcACMPXSCyKNrhZqrba1cKyGdSxnK23KgXmXAIuKhaXiBY7WA/UBDum3Pva6LlEVV2GLSgCPydojlrqAVeXgmIosilW3oH+PMsXRUyliorIhmvDoxkl15dixY4pdeyXChrDWPJMPjorxOx8v7f9kIzZyS7PorVxQ/w5Iku2L7dWrUr0Ptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgjNY4NIGEzjsjQHPkywXnozGRT+pkDw7MyB0MXI4ks=;
 b=KOromIqZ6WjJI57Ra2zZduWXx+NJ8/YpcpmLr1LfLNMPWRl2rWVcsf4e/AhzDt+Okutwzw0Ohz6RNnuJxkEUnShMr6K6VYrMG2re3ch1Q270RbpYcldCklMUi89hLGioMFqsexnCOfC7cnZ7+4Ga214ZHxi7FzaWseowtCt40ZU6QORlPELQEPQZxRwP/biJ5p4m+ACYpu8d8fuy5XVUu5F49uWONyZasWfKFgKyxsDRt0IDaYM7IOIhi2sTl4U/QF5BXYX9UtRo7UDD+xFd30xQG5tveTGNN3Kz3GqDkv4vfrMZ2LOgsdPEAu5FmzOQBYVoibmv136bP5PTESrKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgjNY4NIGEzjsjQHPkywXnozGRT+pkDw7MyB0MXI4ks=;
 b=acsDS7tRS21qxIBlxi1ZkhzTXAsm5uJm5qOAHlIDoUfm83AWS9uIprGIJLY2jBRhw8UGbt7iafkiKObR7TtSZf97aVvO90fhmzLzThba0a7cx9iR6i9IwEJ7Hw5R7JySBrL7m+7KKBbaWsbcOQ7MQg+zYX8nmP9NSe33tVSAfevZYYhiwR3moNUd4108l1e9BzjmKcboWKUU6/owYXWVJoCrAWQ/XWxf0FfWj8yTutbQcvcsKeTIfrhOgnV0sIYFsmJE7eY/TbqqXVwqK6DXJlhlr14EV5RvfeA3Y5WwJHmTGHPVflXS9Qa/ceLzPgk58ThudYmt4bfIC9nBJJL0kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 00:12:21 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::fb09:9679:bd22:6bcb]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::fb09:9679:bd22:6bcb%7]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 00:12:20 +0000
References: <20231117090933.75267-1-baolu.lu@linux.intel.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Luo Yuzhang <yuzhang.luo@intel.com>,
        Tony Zhu <tony.zhu@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect cache invalidation for mm
 notification
Date:   Mon, 20 Nov 2023 10:57:43 +1100
In-reply-to: <20231117090933.75267-1-baolu.lu@linux.intel.com>
Message-ID: <87edgll1up.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0050.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: 44db5e48-c6cc-4665-0c2e-08dbe95d5c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O5fMrHESOa4OvMynCkRvEB4ryO9Ow/RFiPqoWcLOlMhNGlWb/Bj6oomYL2IcLf5gH5Ls2NsjhnubCYoIr8Nl0/8R+PyWhYwdzKvAjRg6me7uk2/ivIWuG02HkQYvkPDnGpBRHfBmMvFpu4keG2FDm3l4NkSKLDCEaNnAilHJK4lKlsurl+0KQhSBZKBB2jE3NTqOntLKe1WYUpuCKX3bCOO8NwB+qQgYfDXw38WPue9LLuyehH0gkPhMeGDRYq74+dih2n+y3DF99+LbWCwxk0K2PeeOaXj5FlYM+A8jToYWpuxTIPmuZeA/Yqah8evKQ44nAzkCDLMJhHU1l6ryFAd/HeviaVueNwPDlaShZXzv4tnpDqCTAlXTajDswAGQW3wWX84EUXIdF4oMgFkUUp5quDiAD+ZD/ZWKoEe2ZPIKx2mN2CMRxCxH+DX3kSM6dZBGz5Cm3mk3gM2cXontHreOh3HEHu4e/7CrN9xEC+2xq8sBtNsTnKdm+h3ZkpWxixqSn7Y+csjS01vECrERNdlZP3WoM5sUuqPlt7BURfly/Ba5W6uah+nCFgKYyhkq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(5660300002)(7416002)(2906002)(86362001)(6486002)(8936002)(83380400001)(6506007)(478600001)(6666004)(26005)(9686003)(6512007)(38100700002)(4326008)(8676002)(54906003)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oTKPXJJQGucwMaKDVGc8Z7WChF9BwgJK1+GfZ8F38LslhSiHyJ2kCnmuu0Mk?=
 =?us-ascii?Q?Bp/SSqCjVGJhgAXwgndCEpfgAfdXxMPFVfFOMYs9J3gGpOiKtVbduXf1Y8vJ?=
 =?us-ascii?Q?WEu53/JUhlIJ9fCcLE2umyHRNd3rNToP7wWE7aHnZqR544XQMSKafFNYwmgS?=
 =?us-ascii?Q?8iVyBDYdTgOu3FaDdKmZbNX18s7hgjjekjJ7d+QYjNrMD3x7i2nTRNT3hiU0?=
 =?us-ascii?Q?+PdSoM8J4K2y2ebhr1berDz5/smLXOBxkAnc+Y4ShzxzFOXWgmKG9s3VbGyF?=
 =?us-ascii?Q?mFN14zaTenHfSkZdyiBL/KQS/FAYu3madXtKX0OVBZMaNkfLXbZ5AnVblbU+?=
 =?us-ascii?Q?h/twLUDAmS3MDWfdZgxvET0BB98I96U+tDE9TRDK87WrgxJQ+9OXvPbjZ3tO?=
 =?us-ascii?Q?sCds1Q74seaaUyzWNxk8ZwGN79JdukYRSE873t8HIyrR5VZB6voCiy3juamv?=
 =?us-ascii?Q?ivVDEafEPzGXwG42gWdzE8zDk8u1cQd+CquiM8vJ0GiCYHTw7VMw5MWereG1?=
 =?us-ascii?Q?tVspTS1DrImUA3jrl4mBmwU9XuAViAiLtRSUBCf6LvTEmq9rQLmQpnTkySO/?=
 =?us-ascii?Q?gRAsnA32js7UFgRQnfGCdofMRMR/Ycfr9/5dnHNkv39tZbatfegu9S1GDF93?=
 =?us-ascii?Q?PU7VVninHv3izMbcXhxkzGyugoZg9DcI+DUxE0qqSoljThzbS39f4zepM4+s?=
 =?us-ascii?Q?Q6a4Nl6pCmWaJWGzIcMZul9cWYI16ONfHAdbUNadSaloVmemqbcnITDlK+M8?=
 =?us-ascii?Q?f+ZRMulK9AJR+p+NztPZ66RgLGjooYM9U/ylChoM0eUFXfaLi6XTui1nMoEd?=
 =?us-ascii?Q?OuEzVFCcB9lksMMXXYmop8/En+lQ9B1pQrwLz8x2fCjbYyNajy0oEFceq0PK?=
 =?us-ascii?Q?rRNGmWZv8uF2Pgmjn78QHVD8MI1uFjdkgqmXfc6cx+iDQIRbMMDYTdi6H+TL?=
 =?us-ascii?Q?mHpx4DawB/s0LhpUyiq6PL0qPtBY83UUf0G3wvoDsV7La2nE2tm7FlhXXTbI?=
 =?us-ascii?Q?8B2LpcLZzUWdXfij9XeZyiBfZ9mOuGIdw7oXOggJucnsf37/Fp8EsEjCL5Vz?=
 =?us-ascii?Q?b9BAxfIrphbDb4x7QvsqvIvoEAidHwXlW7OZ3JNkXcPU3hPwORvD/r9RTRQR?=
 =?us-ascii?Q?2HfXSeeKiyjXZ7z1KMH7NabwF0i+M1cispAcEetHCKsc/uktQj9iWtof6JAS?=
 =?us-ascii?Q?tp37bRx1dHmlB/1nzVH+bgpT9oXBf4VKk6SlNHXszO88bp5noQk9gjLT5ZWK?=
 =?us-ascii?Q?yeFUuAEFp1lHtY8AvZ3I0ZSMayXSH4WFJwtI3tmYa8KfaYYw6uU3NRrHGxqr?=
 =?us-ascii?Q?mRBLZwK+8gTfH1GUFpFhL/RAXoMnxwOGHd/c9N9USqSmWnFSxfLV1Q0VPcxx?=
 =?us-ascii?Q?1G8ep0LNfxJtkP31f1vkPDyNG5hnXkNDlI9m0qI6whs69scz5NMIuSCRNzrg?=
 =?us-ascii?Q?SFxJJo1VxSuxCk35wuMhbWM3s2jrfoNrdLAaub+94ty90Sduo273LBE4mbiR?=
 =?us-ascii?Q?OkxEoUC1aDbK8rdWJIxyZXEUXBUkFya+4BUW8oxIsr8QqnL140xoDGVoWJ5N?=
 =?us-ascii?Q?vvH0Lw3U+JMVxDMlsuF7u/4FQpCXGXmLSZxC/mzJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44db5e48-c6cc-4665-0c2e-08dbe95d5c6c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 00:12:19.7941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aswaJxaiobhrFYvUUUy5EpEtEUiL30lSKvHJnLhKrXTI96QJyQWquRxAdmq7wmdeda6nhs+izIasA+LxRF98Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lu Baolu <baolu.lu@linux.intel.com> writes:

> Commit 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when
> invalidating TLBs") moved the secondary TLB invalidations into the TLB
> invalidation functions to ensure that all secondary TLB invalidations
> happen at the same time as the CPU invalidation and added a flush-all
> type of secondary TLB invalidation for the batched mode, where a range
> of [0, -1UL) is used to indicates that the range extends to the end of
> the address space.
>
> However, using an end address of -1UL caused an overflow in the Intel
> IOMMU driver, where the end address was rounded up to the next page.
> As a result, both the IOTLB and device ATC were not invalidated correctly.

Thanks for catching. This fix looks good so:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

However examining the fixes patch again I note that we are calling
mmu_notifier_invalidate_range(mm, 0, -1UL) from
arch_tlbbatch_add_pending() in arch/x86/include/asm/tlbflush.h.

That seems suboptimal because we would be doing an invalidate all for
every page unmap, and as of db6c1f6f236d ("mm/tlbbatch: introduce
arch_flush_tlb_batched_pending()") arch_flush_tlb_batched_pending()
calls flush_tlb_mm() anyway. So I think we can probably drop the
explicit notifier call from arch_flush_tlb_batched_pending().

Will put togeather a patch for that.

 - Alistair

> Add a flush all helper function and call it when the invalidation range
> is from 0 to -1UL, ensuring that the entire caches are invalidated
> correctly.
>
> Fixes: 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when invalidating TLBs")
> Cc: stable@vger.kernel.org
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Tested-by: Luo Yuzhang <yuzhang.luo@intel.com> # QAT
> Tested-by: Tony Zhu <tony.zhu@intel.com> # DSA
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 50a481c895b8..588385050a07 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -216,6 +216,27 @@ static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
>  	rcu_read_unlock();
>  }
>  
> +static void intel_flush_svm_all(struct intel_svm *svm)
> +{
> +	struct device_domain_info *info;
> +	struct intel_svm_dev *sdev;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(sdev, &svm->devs, list) {
> +		info = dev_iommu_priv_get(sdev->dev);
> +
> +		qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, 0, -1UL, 1);
> +		if (info->ats_enabled) {
> +			qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
> +						 svm->pasid, sdev->qdep,
> +						 0, 64 - VTD_PAGE_SHIFT);
> +			quirk_extra_dev_tlb_flush(info, 0, 64 - VTD_PAGE_SHIFT,
> +						  svm->pasid, sdev->qdep);
> +		}
> +	}
> +	rcu_read_unlock();
> +}
> +
>  /* Pages have been freed at this point */
>  static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>  					struct mm_struct *mm,
> @@ -223,6 +244,11 @@ static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>  {
>  	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
>  
> +	if (start == 0 && end == -1UL) {
> +		intel_flush_svm_all(svm);
> +		return;
> +	}
> +
>  	intel_flush_svm_range(svm, start,
>  			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT, 0);
>  }

