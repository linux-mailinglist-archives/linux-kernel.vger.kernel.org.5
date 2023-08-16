Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED7C77EC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346615AbjHPVns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346635AbjHPVng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:43:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D99D61FD0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:43:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7E1FD75;
        Wed, 16 Aug 2023 14:44:15 -0700 (PDT)
Received: from [10.57.90.114] (unknown [10.57.90.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6748A3F762;
        Wed, 16 Aug 2023 14:43:32 -0700 (PDT)
Message-ID: <0b2b9365-5e8c-35a0-38ac-ffcbdfdb9886@arm.com>
Date:   Wed, 16 Aug 2023 22:43:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 10/11] RISC-V: drivers/iommu/riscv: Add MSI identity
 remapping
Content-Language: en-GB
To:     Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <660b7a8707e494a6bb2706e10569a7414c3640a7.1689792825.git.tjeznach@rivosinc.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <660b7a8707e494a6bb2706e10569a7414c3640a7.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-19 20:33, Tomasz Jeznach wrote:
> This change provides basic identity mapping support to
> excercise MSI_FLAT hardware capability.
> 
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>   drivers/iommu/riscv/iommu.c | 81 +++++++++++++++++++++++++++++++++++++
>   drivers/iommu/riscv/iommu.h |  3 ++
>   2 files changed, 84 insertions(+)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 6042c35be3ca..7b3e3e135cf6 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -61,6 +61,9 @@ MODULE_PARM_DESC(priq_length, "Page request interface queue length.");
>   #define RISCV_IOMMU_MAX_PSCID	(1U << 20)
>   static DEFINE_IDA(riscv_iommu_pscids);
>   
> +/* TODO: Enable MSI remapping */
> +#define RISCV_IMSIC_BASE	0x28000000
> +
>   /* 1 second */
>   #define RISCV_IOMMU_TIMEOUT	riscv_timebase
>   
> @@ -932,6 +935,72 @@ static irqreturn_t riscv_iommu_priq_process(int irq, void *data)
>    * Endpoint management
>    */
>   
> +static int riscv_iommu_enable_ir(struct riscv_iommu_endpoint *ep)
> +{
> +	struct riscv_iommu_device *iommu = ep->iommu;
> +	struct iommu_resv_region *entry;
> +	struct irq_domain *msi_domain;
> +	u64 val;
> +	int i;
> +
> +	/* Initialize MSI remapping */
> +	if (!ep->dc || !(iommu->cap & RISCV_IOMMU_CAP_MSI_FLAT))
> +		return 0;
> +
> +	ep->msi_root = (struct riscv_iommu_msi_pte *)get_zeroed_page(GFP_KERNEL);
> +	if (!ep->msi_root)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < 256; i++) {
> +		ep->msi_root[i].pte = RISCV_IOMMU_MSI_PTE_V |
> +		    FIELD_PREP(RISCV_IOMMU_MSI_PTE_M, 3) |
> +		    phys_to_ppn(RISCV_IMSIC_BASE + i * PAGE_SIZE);
> +	}
> +
> +	entry = iommu_alloc_resv_region(RISCV_IMSIC_BASE, PAGE_SIZE * 256, 0,
> +					IOMMU_RESV_SW_MSI, GFP_KERNEL);
> +	if (entry)
> +		list_add_tail(&entry->list, &ep->regions);
> +
> +	val = virt_to_pfn(ep->msi_root) |
> +	    FIELD_PREP(RISCV_IOMMU_DC_MSIPTP_MODE, RISCV_IOMMU_DC_MSIPTP_MODE_FLAT);
> +	ep->dc->msiptp = cpu_to_le64(val);
> +
> +	/* Single page of MSIPTP, 256 IMSIC files */
> +	ep->dc->msi_addr_mask = cpu_to_le64(255);
> +	ep->dc->msi_addr_pattern = cpu_to_le64(RISCV_IMSIC_BASE >> 12);
> +	wmb();
> +
> +	/* set msi domain for the device as isolated. hack. */

Hack because this should be implemented as a proper hierarchical MSI 
domain, or hack because it doesn't actually represent isolation? Nothing 
really jumps out at me from the IOMMU and IMSIC specs, so I'm leaning 
towards the hunch that there's no real isolation, it's more just 
implicit in the assumption that each distinct VM/process with devices 
assigned should get its own interrupt file. I can't easily see how that 
would be achieved for things like VFIO :/

Thanks,
Robin.

> +	msi_domain = dev_get_msi_domain(ep->dev);
> +	if (msi_domain) {
> +		msi_domain->flags |= IRQ_DOMAIN_FLAG_ISOLATED_MSI;
> +	}
> +
> +	dev_dbg(ep->dev, "RV-IR enabled\n");
> +
> +	ep->ir_enabled = true;
> +
> +	return 0;
> +}
> +
> +static void riscv_iommu_disable_ir(struct riscv_iommu_endpoint *ep)
> +{
> +	if (!ep->ir_enabled)
> +		return;
> +
> +	ep->dc->msi_addr_pattern = 0ULL;
> +	ep->dc->msi_addr_mask = 0ULL;
> +	ep->dc->msiptp = 0ULL;
> +	wmb();
> +
> +	dev_dbg(ep->dev, "RV-IR disabled\n");
> +
> +	free_pages((unsigned long)ep->msi_root, 0);
> +	ep->msi_root = NULL;
> +	ep->ir_enabled = false;
> +}
> +
>   /* Endpoint features/capabilities */
>   static void riscv_iommu_disable_ep(struct riscv_iommu_endpoint *ep)
>   {
> @@ -1226,6 +1295,7 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
>   
>   	mutex_init(&ep->lock);
>   	INIT_LIST_HEAD(&ep->domain);
> +	INIT_LIST_HEAD(&ep->regions);
>   
>   	if (dev_is_pci(dev)) {
>   		ep->devid = pci_dev_id(to_pci_dev(dev));
> @@ -1248,6 +1318,7 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
>   	dev_iommu_priv_set(dev, ep);
>   	riscv_iommu_add_device(iommu, dev);
>   	riscv_iommu_enable_ep(ep);
> +	riscv_iommu_enable_ir(ep);
>   
>   	return &iommu->iommu;
>   }
> @@ -1279,6 +1350,7 @@ static void riscv_iommu_release_device(struct device *dev)
>   		riscv_iommu_iodir_inv_devid(iommu, ep->devid);
>   	}
>   
> +	riscv_iommu_disable_ir(ep);
>   	riscv_iommu_disable_ep(ep);
>   
>   	/* Remove endpoint from IOMMU tracking structures */
> @@ -1301,6 +1373,15 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
>   
>   static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
>   {
> +	struct iommu_resv_region *entry, *new_entry;
> +	struct riscv_iommu_endpoint *ep = dev_iommu_priv_get(dev);
> +
> +	list_for_each_entry(entry, &ep->regions, list) {
> +		new_entry = kmemdup(entry, sizeof(*entry), GFP_KERNEL);
> +		if (new_entry)
> +			list_add_tail(&new_entry->list, head);
> +	}
> +
>   	iommu_dma_get_resv_regions(dev, head);
>   }
>   
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 83e8d00fd0f8..55418a1144fb 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -117,14 +117,17 @@ struct riscv_iommu_endpoint {
>   	struct riscv_iommu_dc *dc;		/* device context pointer */
>   	struct riscv_iommu_pc *pc;		/* process context root, valid if pasid_enabled is true */
>   	struct riscv_iommu_device *iommu;	/* parent iommu device */
> +	struct riscv_iommu_msi_pte *msi_root;	/* interrupt re-mapping */
>   
>   	struct mutex lock;
>   	struct list_head domain;		/* endpoint attached managed domain */
> +	struct list_head regions;		/* reserved regions, interrupt remapping window */
>   
>   	/* end point info bits */
>   	unsigned pasid_bits;
>   	unsigned pasid_feat;
>   	bool pasid_enabled;
> +	bool ir_enabled;
>   };
>   
>   /* Helper functions and macros */
