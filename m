Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A27BA75A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjJERKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjJERJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:09:00 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFF33A85
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:55:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxBycpNSKFxYDkBPukqqxZ6IOl68AE0KtDE2jOybSxfepFz5BQvxZYEuwX/0H/YCxW5rQDP3AlQbz6Szf4zkMGjfCRvchGAWy6418+xwN+23e9g2qHneK8Wei4XKbkIcc7Z7idGEDOLR2Xwr9oZy5qfgW1AvSLd5GQcULLS5pY1lP8ft3z2ifUkHjVJ6RBy9erUUd1U57I7HyD+l3+XyL00WfJ6t5Mj5ImRXq6Jp3cy1ty9L5Jiy0vrpx3SbGTfAc5b+VJnG7z1iNJwFGwmNyOzQ11ssFcabzKm7Um7/xbOrSEAygTvxUIbld47grrqatsknzDR+LYO21QcNgKshcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HawAixTkYw72tOcpxHSOWDLSlPtG5yNXvfApMiKckMk=;
 b=PMb+Nb767jR15LZZhRKzRRgTFhMuxKw4OXImjEdUOxBGA/XYhzyWI03KEM05ogYKdnBVVCbApld0zKPwCkK/0qLQ7kfl+qTcswP7HAkFtmlJYlIDRmq3fhB9HbDqxZnNoNa4zQY8Zamn3Q2h4DdPwGcF6vz+Mwh8LtOhC7H4n0KqcToiPLLZMvlvd0JwA4zUKIz7KB/+jwRT2eRCJY6m08zLhfd39NHuyBP9GzB7v6+o3lbi5E0kb7TAP8vZXWry1l8ku4I74jbi0hd3S7sEPc1Dduf0FkP6+czH10HgMt9wcszkfhQr2+JnR+JyApGfDXpB2divFwRJmMORQ4P6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HawAixTkYw72tOcpxHSOWDLSlPtG5yNXvfApMiKckMk=;
 b=XnAl74YIsbo9l2+q0ZF6D7NJR5Lk5qdsehMxW2QipK1OPTeeF5pSJhNs7GtWgzYChp0+AlXCN2h2lKInZZGQlnBobIBEVCopqEtIJQFg6gZOJpxAjKE6v8YzdfA2r9OrihGqeFFDWRZ5LNJ2RYb3o9PJHYYwu+73GartnM9fIW80V003jaGD4+Hf+9p7ZtajAs3xqEw4kl+vAdDKMm98SkIZhyG18ONWhA4HKmxljSWsmneMWchsmM1D7Z1cQA+QjHsel4vtt4NWAqHM7EQGbZA/A7xuL2z/JfcA93l76vKNQgvEm7vwLx5M9qHnxl0gB+hRDI50mYN8BcBEPJQ29w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Thu, 5 Oct
 2023 16:54:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 16:54:59 +0000
Date:   Thu, 5 Oct 2023 13:54:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        will@kernel.org, aniketa@nvidia.com, cjia@nvidia.com,
        kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com,
        acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Message-ID: <20231005165458.GM682044@nvidia.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-2-ankita@nvidia.com>
 <ZR7hKYU1Wj+VTqpO@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR7hKYU1Wj+VTqpO@arm.com>
X-ClientProxiedBy: BL0PR1501CA0035.namprd15.prod.outlook.com
 (2603:10b6:207:17::48) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb383cb-8b9b-462f-ba01-08dbc5c3cf57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/vIOcB8bS6NYLi6I7GTGKczNihNtC+8JX1bp1ECID2SS/bSzqzRDEIDOkmbnvcD4JFHVQrFxKnnvqBuqwhJ+A31x+g+9pxzNSjebLbA9yg5ubLLFVDk+eTlFOHjAZaFBEk00B4whL3wPCytUh2A2v/zNacFqa6/hJcb8WEKGROyxZFUgjTVuiSDiXk8RSVdvJzy5eM/I5LU0S2zmA/wyHg1bl92UsYI4Ebg2pzbpGVSMzSdlZJoPXHlybhyNtBL6d6B93VsfG3uL8hoEfQExDxlCfZxv+9Tg9dA6ELZix6K4b1E/QSud3mtUDnTqeQpd+BI9ikE8zevB2G6zN3tNNzMDhYlhXcM8a1s3NWj98KfqUp7CxqtB1Kyw0JpjzPaBtzKI+I6NsMzKhZvdbyXhXvHH6hms6hGKjIu4awRqv7nGhBDHUa3YA3qiRx00vgiwDty7myJjtCFpILWqv4ZSLwsisM1NwyJsRvYxS9BH5knZYInBT9nwPaX+Ar2UfgU6WIREAKFAli4wUtLqzRXvJutQ4zhnu6Bm7iglgm7yxntRLvnwPX9M35G1mg2qxqH+pnkEJ2pNf+XRRQsfpUVpNFqUm23zZQvNCByxg3nI+gI/DJo1tx68s8TaxAXo0l7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(36756003)(2616005)(6486002)(478600001)(1076003)(26005)(6512007)(38100700002)(83380400001)(33656002)(86362001)(66556008)(316002)(66946007)(6506007)(41300700001)(66476007)(6916009)(5660300002)(8936002)(66899024)(8676002)(4326008)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FB8s+X9R3ExJo79SgJG3fo/y/N4yAkjBGOK5khM+cmJ5AW9DH4xneyZys8+U?=
 =?us-ascii?Q?fLmrPptVOrcHcVxTYtxKC7ojWtOlxJzVfocPBb/4po/wTRTgUnjdJ5bPOgyZ?=
 =?us-ascii?Q?hF4R6eXm1/Jkc8+1aSzBacdZm16fZRszA0B0Job4zAVLUZgQI5XPJDrul0hE?=
 =?us-ascii?Q?FZmV2EgtTyY+wFxtmWlmkQc850+XLiU/6Zciwwr+IpNgMzpx0WNwBgG0/rg0?=
 =?us-ascii?Q?z1RtRwELA+XD5rD1/6rWWZjBEzENlEIdW78ewJQ0WeiNcjUW8siNTgQqs2Cj?=
 =?us-ascii?Q?iUvn1Jmdq171SwUM1MXSiEXbYN4c7ZVF4Zue16pTkjrrCNrJc1IIbz+NGa05?=
 =?us-ascii?Q?THw85+Tu7HT2ZE9PpQPZ5LdiPuc98VxO2ag7qufgLFgWs5mewxYIJeTHJZhx?=
 =?us-ascii?Q?Teev9D9wfwYKOlzL2xKDnUYVKsm6hx5RSNESIbYqox7W9pRSP/5GS8dLOpPJ?=
 =?us-ascii?Q?mW0K3yAgRBRYSZzfeZqJUWwUAwLK10k3powf/vY8KvLLcc17XsJC4kjM4QZ7?=
 =?us-ascii?Q?XIwOgTFANoiklLiVsaOitd9PJZW1NZSsoP8XckwvdOn6CQey5ByZLGRaV07x?=
 =?us-ascii?Q?QBEPHM7L9THtzlk630ckoLFC47x42tXtV4Ppcz8YNflOJKRPadbhlXlhZ01w?=
 =?us-ascii?Q?yRLc1uMkUdExuXJBfRt3Znta5IFDGkr8S7uMsW4bFZbxY/TP/l7Y7WEUanwB?=
 =?us-ascii?Q?lf/XZtM54P+gtHq9Q8uIk/m3ENol2ltbaEzEITX/uBcmqSNfoJVvDpia+2dq?=
 =?us-ascii?Q?eFPN5ppZunWuNoo6HIJfPXsWIfUCzQBmpG8eEjlSoq0ob4dMJMQgI3xoXHT6?=
 =?us-ascii?Q?j2fZ8YRDx+7S7OeAZtWWhgtFSzW5U4OVYvgCliVyjT3Y08RHSEn2iIqaBk6s?=
 =?us-ascii?Q?7wqFHbZa4k6XmXSUt9ZnNiJVENIovjAB/nrPOJSnr24Pi4wlIMxWyEBzK4NM?=
 =?us-ascii?Q?FX3urLLbF3gqnFSvusiBUNFWIe2ccn6PmG3rq6PqgGiJrpmmYI3d5NNC5VOZ?=
 =?us-ascii?Q?jWAoj9hg8KjQ89iV13q/Sy8sAQSR8V/7V7jLm+H/H7MBWbaU+HqpFIqXSDAy?=
 =?us-ascii?Q?mef17klxHDpJPlhRAW08ry/NdM6P8FN/MYwrnSn2sbYBUAtsa8JYXUn0EyIe?=
 =?us-ascii?Q?56nlguGqhMUS9La9GyWZKR//Vc8Rs63DY343ca31f6eU9MyFbZRTIowlKJ8C?=
 =?us-ascii?Q?zZq7Xi32ezu9fDlMwxmzvukjhBNUiGu1s6C5L5KxT2KVDfLZCk9yWUghUBPq?=
 =?us-ascii?Q?12ugZOqA0gALYXykZJx8ZvZl824OGQp5PqbemC6spODBuCyzUEDP/NF7j/yj?=
 =?us-ascii?Q?acPCJRJ8L3B/Qj371BrhaUMelIpJkCwBgLMXcrkfJCv4CskPQY+IhGsRsjek?=
 =?us-ascii?Q?Yz6/9e3Agi0sQIMdKQTeIKo8t0AP+U+blOC88TLp7mqg5W5To7HEO+zEYjua?=
 =?us-ascii?Q?pY1cjumtQcvr4Mw2KK7WXb/0Nk6cL4PYUF5tJzeCXSgL+j/1SqJKu40/KbZd?=
 =?us-ascii?Q?pyyfYygEvaVUKilOc6u3RoWIeEhQQXMK6vln9C0DsE8R/gVrP/0Wudb2BAht?=
 =?us-ascii?Q?1Bn6HeYnTI6onzG7iM0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb383cb-8b9b-462f-ba01-08dbc5c3cf57
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 16:54:59.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UftFGmicggknswD61Fh19pOecxaJhthyc6+wxuizFIVAN3ibxHk4OraNJ9dpJe5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 05:15:37PM +0100, Catalin Marinas wrote:
> On Thu, Sep 07, 2023 at 11:14:58AM -0700, ankita@nvidia.com wrote:
> > From: Ankit Agrawal <ankita@nvidia.com>
> > 
> > Currently KVM determines if a VMA is pointing at IO memory by checking
> > pfn_is_map_memory(). However, the MM already gives us a way to tell what
> > kind of memory it is by inspecting the VMA.
> 
> Well, it doesn't. It tells us what attributes the user mapped that
> memory with, not whether it's I/O memory or standard RAM.

There is VM_IO which is intended to be used for address space with
side effects.

And there is VM_PFNMAP which is intended to be used for address space
without struct page (IO or not)

And finally we have the pgprot bit which define the cachability.

Do you have a definition of IO memory that those three things don't
cover?

I would propose that, for KVM's purpose, IO memory is marked with
VM_IO or a non-cachable pgprot

And "standard RAM" is defined by a cachable pgprot. Linux never makes
something that is VM_IO cachable.

?

> I would move the second patch to be the first, we could even merge that
> independently as it is about relaxing the stage 2 mapping to Normal NC.
> It would make it simpler I think to reason about the second patch which
> further relaxes the stage 2 mapping to Normal Cacheable under certain
> conditions.

Make sense
 
> > Unfortunately when FWB is not enabled, the kernel expects to naively do
> > cache management by flushing the memory using an address in the
> > kernel's map. This does not work in several of the newly allowed
> > cases such as dcache_clean_inval_poc(). Check whether the targeted pfn
> > and its mapping KVA is valid in case the FWB is absent before continuing.
> 
> I would only allow cacheable stage 2 mappings if FWB is enabled.
> Otherwise we end up with a mismatch between the VMM mapping and whatever
> the guest may do.

Does it need to be stronger? If FWB is disabled and the cache flush
works then what is the issue?

> > +	/*
> > +	 * Figure out the memory type based on the user va mapping properties
> > +	 * Only MT_DEVICE_nGnRE and MT_DEVICE_nGnRnE will be set using
> > +	 * pgprot_device() and pgprot_noncached() respectively.
> > +	 */
> > +	if ((mapping_type(vma->vm_page_prot) == MT_DEVICE_nGnRE) ||
> > +	    (mapping_type(vma->vm_page_prot) == MT_DEVICE_nGnRnE) ||
> > +	    (mapping_type(vma->vm_page_prot) == MT_NORMAL_NC))
> > +		prot |= KVM_PGTABLE_PROT_DEVICE;
> > +	else if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
> > +		prot |= KVM_PGTABLE_PROT_X;
> 
> Does this mean that we can end up with some I/O memory also mapped as
> executable?

Yes. We don't have cachable memory with side effects in Linux?

> Is there a use-case (e.g. using CXL memory as standard guest
> RAM, executable)?

Certainly.

> > +
> >  	/* Don't use the VMA after the unlock -- it may have vanished */
> >  	vma = NULL;
> >  
> > @@ -1576,10 +1597,21 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >  	if (exec_fault)
> >  		prot |= KVM_PGTABLE_PROT_X;
> >  
> > -	if (device)
> > -		prot |= KVM_PGTABLE_PROT_DEVICE;
> > -	else if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
> > -		prot |= KVM_PGTABLE_PROT_X;
> > +	/*
> > +	 *  When FWB is unsupported KVM needs to do cache flushes
> > +	 *  (via dcache_clean_inval_poc()) of the underlying memory. This is
> > +	 *  only possible if the memory is already mapped into the kernel map
> > +	 *  at the usual spot.
> > +	 *
> > +	 *  Validate that there is a struct page for the PFN which maps
> > +	 *  to the KVA that the flushing code expects.
> > +	 */
> > +	if (!stage2_has_fwb(pgt) &&
> > +	    !(pfn_valid(pfn) &&
> > +	      page_to_virt(pfn_to_page(pfn)) == kvm_host_va(PFN_PHYS(pfn)))) {
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> 
> My preference would be to keep most of the current logic (including
> pfn_is_map_memory())

Why? I think this pfn_is_map_memory() is actually not desired, it
doesn't deal with modern memory hotplug or pgmap stuff? Isn't
pfn_valid() more appropriate?

> as an ABI change but I don't think it matters, it mostly brings
> cacheable I/O mem mappings in line with standard RAM (bar the exec
> permission unless there is a use-case for it).

I would discourage the concept of "cacheable I/O mem mappings".

Cachable memory located on a NUMA node close to the CPU should have
exactly the same treatement as cachable memory located on a NUMA node
distant from the CPU.

I think when you say "cachable I/O memory" it really just means normal
memory that lives on a NUMA node that is located on an IO device.

At the KVM level we don't care about the NUMA locality, we only care
if it is normal cachable system memory.

I think there are two issues here. 

1) KVM uses pfn_is_map_memory() which does not cover all our modern
NUMA and memory hotplug cases for normal struct page backed cachable
memory.

2) KVM doesn't work with normal cachable memory that does not have
struct pages.


For 1 the test should be 'does the pfn have a struct page, does the
struct page refer to cachable memory?'

For 2 the test should be 'does the VMA have pgprot = cachable,
VM_PFNMAP and not VM_IO (both implied)'

Jason
