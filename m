Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F28797C95
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbjIGTNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjIGTM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:12:59 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E82A8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 12:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPMHk6dwRszr89qaqlrI8Malv7Q69gkr0Gkbh03bAghCuzqEEsYkR3zkE4twAUcwDakiB1Urxig9Kp9lakArpSjI+c5ciDs7pXPjFCg5in8pRnWppnU46KvFKsN6N4cKNrQHYhBwCR8F/jxVwaHs9DJpmvyJykYv2QhnNsWD38Plou492AgWAhgyoA1p5h2NF0cYlT1s5E4Mkp7QS6FihE2k10RXTnTZ368zqb16OHdG4LHFzRNTrClZjE9Q+cDMnNznXR5fdf2Vp7GM3huNPGKuYtMS6ER2ETYVgVIrGRzFrRCzBiZY9o8z6/b8auGd9Bt3TjXRcjK0cpdTvCNiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0l1AdAZiODMadtabvLl7+/kinAxrSSe/8nKQmy1aL4=;
 b=ME+Q/TBTW10sMEHO5scpb9SI/OHCH5dN59QDdsAlwhJZXRD++kZgy6f0Stz1heAnbFY5rb0w7zYZwE9XQK0mJsjOD3s9SeTmPhos0IGYKfOfjozgbR4aGNtfIsS7+jnM44n6NjAo0H4Gxtv1sO3eMJA7GrwBE0WxSwWrrY+5sjKew159oKw8vyLDD9xBCL17sPReIuCP9wJZ4Imq5CFW75WSFcVyRIv2M8JUbaSs8eHlGSb21CNv0kU1ZyAy5m+lLn6a6T8q/t+TLAnqD7Fg3rjRBEveMomMGbt73tS+tqEwKIlrgi2HfmHTLh3BCQSj7KpNd8owZyYPo/13I0tCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0l1AdAZiODMadtabvLl7+/kinAxrSSe/8nKQmy1aL4=;
 b=VkQJpe8loD/ipXnuIWQ7/KiqPdemT+zFFejqZoi1lNXst3Lz/sM+ORvnup/z0Se8nkazI2CpVhsoHpt946RWmCepgkbDfD4bwwk67lJ18sjYHUUGfhW+jcKKstSIASBMUmBt2nHKjXMC4dof8O0Z6a6nZ/YNSPdObHA8W8iMK9LSRriOuCkF8QUWnraM4A1hFCUVpPHzJfZZImLRV6sHn2FS7ZTSItaZy/1n/lZfsFCYi6XudtT1zV8O/UMKOo68SvgGD0WTHYGux9vTmz5aP5+Q+0cGBgQp37TCBTdNInu0x17m89HNR9IXS4zEE2YocCfqf8UR3BS97Zl8QPD+9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 19:12:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%5]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 19:12:51 +0000
Date:   Thu, 7 Sep 2023 16:12:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     ankita@nvidia.com
Cc:     maz@kernel.org, oliver.upton@linux.dev, catalin.marinas@arm.com,
        will@kernel.org, aniketa@nvidia.com, cjia@nvidia.com,
        kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com,
        acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Message-ID: <ZPogsU6YihY2+qR6@nvidia.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-2-ankita@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907181459.18145-2-ankita@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: abca863d-8c6e-4a1f-3e29-08dbafd66e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aAQiZic2d0f9fU3B176nE6cLDCRg2fWN5WOhhkMsLqDmg9zc4sggbySHzsog3wVu3lOLu9VkBhrTkWgA2SDI6D5eNuaIgSy9ZSSwtmc7wRg0hiwqyaC2xgyzQ53bh6mAkIwE6D6GfIDYL0CMDCGHfLxBExKoBpMGV1sPKVscBZ0DzQ/Msz9MYFMZpI/qfGgdvax1GvvhlubXBcU+qtIX+/frOed9e6kw1aI+WyUdBSdZ5jM47zsLTy6LyytdBxXojKsbj+e+7jf8yKP5+T3McYBQHa33SP8sYLEynlnPyW8/mduIvi3GBjLLRJYAZzglr9lAHDpL6AXpf8QDJvKa3le1Hj2UYOsl9j6ZQN8Zdpf9Gc6K/yp75WSY1P9DkgczolnAROH+4R4kPWUF/veChGKo0mnyMvbVAfMMdyanYYtwTyudG0Rt0K01nBjPQNwoeTdsMDToAOTDKq9o03b1vEzWfd8Ua/EdRgSkzD812Z93J2EscvZqORdlkEKcfJpwRau40ETMOQmCQV3vSUqrdxfgcjDNsld0wOOGi4ef/QdXswO6IMQSw/JrhES8RIGovOFNHHr+Sf7PDUqnGdmoQtO/yr+Hhv5LWLuWdb3iAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(186009)(1800799009)(451199024)(6486002)(6506007)(6512007)(83380400001)(478600001)(41300700001)(26005)(2906002)(66556008)(66476007)(37006003)(316002)(66946007)(34206002)(5660300002)(4326008)(6636002)(8676002)(8936002)(2616005)(86362001)(36756003)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XbUZ1+DGd3vkVJBzUWymEvGheqrRqboemBfE+F5rBdBqYHccaZSsaj5OkB1b?=
 =?us-ascii?Q?zUFtc32/1IPDEWZ/VvwYiK3iHbHqtKamQrZwt55y9G9rgX60GwIskpc8EcDp?=
 =?us-ascii?Q?1gMCQfyOTow5tvcqFZFvqR3lHuUP/WRcKvGJadYnMG/TfIAd71vg2mogHkHL?=
 =?us-ascii?Q?8vl82HKdtj7U7QWbbB537k6Y3LhIU/gFq9K6vQNBXDZT89GaIbEd3fmm7jl0?=
 =?us-ascii?Q?RRoHw0kxkDWq+iN7iY3uV19/UHPztUUxcvuIZpDsrjon5IhD8eK1fBF85UJJ?=
 =?us-ascii?Q?LloRQTCoozFhTog4xjWR8sopYl22MHrJ8aiROYQKaGPeyK0/uOFYkFWtKyk9?=
 =?us-ascii?Q?lkT+vWoVV1fbIaVIYtUMTu/4vjxDhWoVdFysoRWTwd8luU2kljiaKaCX0sas?=
 =?us-ascii?Q?lBqzhg2GGmuoJlDWSfjuUKtJUbm/7x0CyvKJ6U5BJJmhbij/EUTufE1nGqns?=
 =?us-ascii?Q?dNEH+EsLVraBplK0i8dqyA6RtzhzgAU/roiZxv3h9HdbjyZKu9PBpiGw+2W3?=
 =?us-ascii?Q?adWRw016L1SQ0emm7a7/67eAVAXHFQpY4fxIRV+i1zH1fyToTqQFT04wQ4wu?=
 =?us-ascii?Q?c4yav1XYA8SBtKZIS+Jp1Udihqhm5fJWlTwpYulytZSpFzj6BaDGeeAI1dHy?=
 =?us-ascii?Q?dBkiYkDFawJNcZU+kR4ZOlUh6Y1cp+sbNikWQt5fSbMpN2XhmOG4YTvy64+b?=
 =?us-ascii?Q?18/8NwAUD0SmeVA46YSezV+UAIZzpoyQc3XfE+PT49dekqANqCzBYbHGaBbV?=
 =?us-ascii?Q?7mofiSu1eALFS1Lir1XPJLPnoL6soS2ErSi9GtGnabYzH3evJB3q41Wvkq5a?=
 =?us-ascii?Q?tRCXNLXqlJdiLqdYlXGhV+B2Tbe6/wCyBEuEUh8vtJm5HOHaS2Cb7xRNBs4B?=
 =?us-ascii?Q?0Lph9QPt5WkScOiS2JT99+JLsoCA4Tpw80nso3ORrrfOZYkmm24wk7C2xLdr?=
 =?us-ascii?Q?SqZqVVo56LiJf63Tk7hegnQ903la+2F0yrqVX0r0C3Dd6APxWbaMGKW0cxYR?=
 =?us-ascii?Q?Z7oTGJHQmx1uIdEYJWAnSbNqJE1nIDpDsCAB4Z4UE8vs9EmzjsAqF3pj50sm?=
 =?us-ascii?Q?yH9YDU8lWHlG+zbAJagKV2J0ZEqANTGF+GS1U3zFocORrTUl1KfnrguKKc11?=
 =?us-ascii?Q?uV9o5cFRl/FrNf467djZOdFZdFEFzgSAylb1DMPBdFRSJk9E83WSr2FZjjab?=
 =?us-ascii?Q?kbVKndjvQPyAs7Da6+c7R+wTx2dbRt+UJ0N12Sni7PFOvEAF52NyfKQER9lg?=
 =?us-ascii?Q?UsbUwIGPzPEEoqoPsA7QTQC70l4ul6fYfseP2i14a7rDR5PFmg3optvpRkhm?=
 =?us-ascii?Q?KIV49yLw9wCItVFzL6hHFtsZatlZsNawhr/q22Z+n4huAt8VRq/Ad1jRbtvT?=
 =?us-ascii?Q?ByhhkLwVtybFETOFV5TG4sn1g3e0pCqGXcup5TSzF2HBwEs6ICnY6Q5JvAry?=
 =?us-ascii?Q?hz38In4gp7I/Xv6z5JjYxJ1FCMv3wCTu7NzJiRdBDQjd+awx44v/yjQtm+RB?=
 =?us-ascii?Q?E9+Br8eWRGJN/ZpQbHntC83ppLVP4KUnkRxFfzSOHBVKh4Esz/MuuLtevkvj?=
 =?us-ascii?Q?7DU41kQsT3rogdFSHJu/aAHM0/7YQK09X0CfQicM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abca863d-8c6e-4a1f-3e29-08dbafd66e25
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 19:12:51.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yM1oB2/8mNJLtboAG1XszrS7/Thz3lj9ZE7j1nfAjuaKzmGPi35S7mC4qY/qpSI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 11:14:58AM -0700, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> Currently KVM determines if a VMA is pointing at IO memory by checking
> pfn_is_map_memory(). However, the MM already gives us a way to tell what
> kind of memory it is by inspecting the VMA.
> 
> Replace pfn_is_map_memory() with a check on the VMA pgprot to determine if
> the memory is IO and thus needs stage-2 device mapping.
> 
> The VMA's pgprot is tested to determine the memory type with the
> following mapping:
> 
>  pgprot_noncached    MT_DEVICE_nGnRnE   device
>  pgprot_writecombine MT_NORMAL_NC       device
>  pgprot_device       MT_DEVICE_nGnRE    device
>  pgprot_tagged       MT_NORMAL_TAGGED   RAM
> 
> This patch solves a problems where it is possible for the kernel to
> have VMAs pointing at cachable memory without causing
> pfn_is_map_memory() to be true, eg DAX memremap cases and CXL/pre-CXL
> devices. This memory is now properly marked as cachable in KVM.
> 
> Unfortunately when FWB is not enabled, the kernel expects to naively do
> cache management by flushing the memory using an address in the
> kernel's map. This does not work in several of the newly allowed
> cases such as dcache_clean_inval_poc(). Check whether the targeted pfn
> and its mapping KVA is valid in case the FWB is absent before
> continuing.

Looking at this more closely, it relies on kvm_pte_follow() which
ultimately calls __va(), and the ARM 64 version of page_to_virt() is:

#define page_to_virt(x) ({                                              \
        __typeof__(x) __page = x;                                       \
        void *__addr = __va(page_to_phys(__page));                      \
        (void *)__tag_set((const void *)__addr, page_kasan_tag(__page));\
})

So we don't actually have an issue here, anything with a struct page
will be properly handled by KVM.

Thus this can just be:

	if (!stage2_has_fwb(pgt) && !pfn_valid(pfn)))

Then the last paragraph of the commit message is:

 As cachable vs device memory is now determined by the VMA adjust
 the other checks to match their purpose. In most cases the code needs
 to know if there is a struct page, or if the memory is in the kernel
 map and pfn_valid() is an appropriate API for this.

 Note when FWB is not enabled, the kernel expects to trivially do
 cache management by flushing the memory by linearly converting a
 kvm_pte to phys_addr to a KVA, see kvm_flush_dcache_to_poc(). This is
 only possibile for struct page backed memory. Do not allow non-struct
 page memory to be cachable without FWB.

> @@ -1490,6 +1499,18 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	gfn = fault_ipa >> PAGE_SHIFT;
>  	mte_allowed = kvm_vma_mte_allowed(vma);
>  
> +	/*
> +	 * Figure out the memory type based on the user va mapping properties
> +	 * Only MT_DEVICE_nGnRE and MT_DEVICE_nGnRnE will be set using
> +	 * pgprot_device() and pgprot_noncached() respectively.
> +	 */
> +	if ((mapping_type(vma->vm_page_prot) == MT_DEVICE_nGnRE) ||
> +	    (mapping_type(vma->vm_page_prot) == MT_DEVICE_nGnRnE) ||
> +	    (mapping_type(vma->vm_page_prot) == MT_NORMAL_NC))
> +		prot |= KVM_PGTABLE_PROT_DEVICE;
> +	else if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
> +		prot |= KVM_PGTABLE_PROT_X;
> +
>  	/* Don't use the VMA after the unlock -- it may have vanished */
>  	vma = NULL;
>  
> @@ -1576,10 +1597,21 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	if (exec_fault)
>  		prot |= KVM_PGTABLE_PROT_X;

You still didn't remove the kvm_is_device_pfn() check from this code,
I don't think it can really stay and make any sense..

Probably this:

   if (exec_fault && (prot & KVM_PGTABLE_PROT_DEVICE))
		return -ENOEXEC;

And these two should also be pfn_valid() [precompute pfn_valid]

	if (vma_pagesize == PAGE_SIZE && !(force_pte || !pfn_valid(pte))) {

	if (fault_status != ESR_ELx_FSC_PERM && pfn_valid(pte) && kvm_has_mte(kvm)) {

Makes sense?

Check if kvm_is_device_pfn() can be removed entirely.

Jason
