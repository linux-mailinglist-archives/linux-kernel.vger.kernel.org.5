Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AD177E90A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345648AbjHPStS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjHPStO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:49:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B07126A8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:49:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBA36D75;
        Wed, 16 Aug 2023 11:49:51 -0700 (PDT)
Received: from [10.57.90.114] (unknown [10.57.90.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51B603F6C4;
        Wed, 16 Aug 2023 11:49:08 -0700 (PDT)
Message-ID: <e9f19296-80e3-f0be-f0e5-a751b481f7e1@arm.com>
Date:   Wed, 16 Aug 2023 19:49:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
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
 <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-19 20:33, Tomasz Jeznach wrote:
> Enables message or wire signal interrupts for PCIe and platforms devices.
> 
> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>   drivers/iommu/riscv/iommu-pci.c      |  72 ++++
>   drivers/iommu/riscv/iommu-platform.c |  66 +++
>   drivers/iommu/riscv/iommu.c          | 604 ++++++++++++++++++++++++++-
>   drivers/iommu/riscv/iommu.h          |  28 ++
>   4 files changed, 769 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
> index c91f963d7a29..9ea0647f7b92 100644
> --- a/drivers/iommu/riscv/iommu-pci.c
> +++ b/drivers/iommu/riscv/iommu-pci.c
> @@ -34,6 +34,7 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_i
>   {
>   	struct device *dev = &pdev->dev;
>   	struct riscv_iommu_device *iommu;
> +	u64 icvec;
>   	int ret;
>   
>   	ret = pci_enable_device_mem(pdev);
> @@ -67,14 +68,84 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_i
>   	iommu->dev = dev;
>   	dev_set_drvdata(dev, iommu);
>   
> +	/* Check device reported capabilities. */
> +	iommu->cap = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAP);
> +
> +	/* The PCI driver only uses MSIs, make sure the IOMMU supports this */
> +	switch (FIELD_GET(RISCV_IOMMU_CAP_IGS, iommu->cap)) {
> +	case RISCV_IOMMU_CAP_IGS_MSI:
> +	case RISCV_IOMMU_CAP_IGS_BOTH:
> +		break;
> +	default:
> +		dev_err(dev, "unable to use message-signaled interrupts\n");
> +		ret = -ENODEV;
> +		goto fail;
> +	}
> +
>   	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>   	pci_set_master(pdev);
>   
> +	/* Allocate and assign IRQ vectors for the various events */
> +	ret = pci_alloc_irq_vectors(pdev, 1, RISCV_IOMMU_INTR_COUNT, PCI_IRQ_MSIX);
> +	if (ret < 0) {
> +		dev_err(dev, "unable to allocate irq vectors\n");
> +		goto fail;
> +	}
> +
> +	ret = -ENODEV;
> +
> +	iommu->irq_cmdq = msi_get_virq(dev, RISCV_IOMMU_INTR_CQ);
> +	if (!iommu->irq_cmdq) {
> +		dev_warn(dev, "no MSI vector %d for the command queue\n",
> +			 RISCV_IOMMU_INTR_CQ);
> +		goto fail;
> +	}
> +
> +	iommu->irq_fltq = msi_get_virq(dev, RISCV_IOMMU_INTR_FQ);
> +	if (!iommu->irq_fltq) {
> +		dev_warn(dev, "no MSI vector %d for the fault/event queue\n",
> +			 RISCV_IOMMU_INTR_FQ);
> +		goto fail;
> +	}
> +
> +	if (iommu->cap & RISCV_IOMMU_CAP_HPM) {
> +		iommu->irq_pm = msi_get_virq(dev, RISCV_IOMMU_INTR_PM);
> +		if (!iommu->irq_pm) {
> +			dev_warn(dev,
> +				 "no MSI vector %d for performance monitoring\n",
> +				 RISCV_IOMMU_INTR_PM);
> +			goto fail;
> +		}
> +	}
> +
> +	if (iommu->cap & RISCV_IOMMU_CAP_ATS) {
> +		iommu->irq_priq = msi_get_virq(dev, RISCV_IOMMU_INTR_PQ);
> +		if (!iommu->irq_priq) {
> +			dev_warn(dev,
> +				 "no MSI vector %d for page-request queue\n",
> +				 RISCV_IOMMU_INTR_PQ);
> +			goto fail;
> +		}
> +	}
> +
> +	/* Set simple 1:1 mapping for MSI vectors */
> +	icvec = FIELD_PREP(RISCV_IOMMU_IVEC_CIV, RISCV_IOMMU_INTR_CQ) |
> +	    FIELD_PREP(RISCV_IOMMU_IVEC_FIV, RISCV_IOMMU_INTR_FQ);
> +
> +	if (iommu->cap & RISCV_IOMMU_CAP_HPM)
> +		icvec |= FIELD_PREP(RISCV_IOMMU_IVEC_PMIV, RISCV_IOMMU_INTR_PM);
> +
> +	if (iommu->cap & RISCV_IOMMU_CAP_ATS)
> +		icvec |= FIELD_PREP(RISCV_IOMMU_IVEC_PIV, RISCV_IOMMU_INTR_PQ);
> +
> +	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IVEC, icvec);
> +
>   	ret = riscv_iommu_init(iommu);
>   	if (!ret)
>   		return ret;
>   
>    fail:
> +	pci_free_irq_vectors(pdev);
>   	pci_clear_master(pdev);
>   	pci_release_regions(pdev);
>   	pci_disable_device(pdev);
> @@ -85,6 +156,7 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_i
>   static void riscv_iommu_pci_remove(struct pci_dev *pdev)
>   {
>   	riscv_iommu_remove(dev_get_drvdata(&pdev->dev));
> +	pci_free_irq_vectors(pdev);
>   	pci_clear_master(pdev);
>   	pci_release_regions(pdev);
>   	pci_disable_device(pdev);
> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
> index e4e8ca6711e7..35935d3c7ef4 100644
> --- a/drivers/iommu/riscv/iommu-platform.c
> +++ b/drivers/iommu/riscv/iommu-platform.c
> @@ -20,6 +20,8 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct riscv_iommu_device *iommu = NULL;
>   	struct resource *res = NULL;
> +	u32 fctl = 0;
> +	int irq = 0;
>   	int ret = 0;
>   
>   	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> @@ -53,6 +55,70 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
>   		goto fail;
>   	}
>   
> +	iommu->cap = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAP);
> +
> +	/* For now we only support WSIs until we have AIA support */
> +	ret = FIELD_GET(RISCV_IOMMU_CAP_IGS, iommu->cap);
> +	if (ret == RISCV_IOMMU_CAP_IGS_MSI) {
> +		dev_err(dev, "IOMMU only supports MSIs\n");
> +		goto fail;
> +	}
> +
> +	/* Parse IRQ assignment */
> +	irq = platform_get_irq_byname_optional(pdev, "cmdq");
> +	if (irq > 0)
> +		iommu->irq_cmdq = irq;
> +	else {
> +		dev_err(dev, "no IRQ provided for the command queue\n");
> +		goto fail;
> +	}
> +
> +	irq = platform_get_irq_byname_optional(pdev, "fltq");
> +	if (irq > 0)
> +		iommu->irq_fltq = irq;
> +	else {
> +		dev_err(dev, "no IRQ provided for the fault/event queue\n");
> +		goto fail;
> +	}
> +
> +	if (iommu->cap & RISCV_IOMMU_CAP_HPM) {
> +		irq = platform_get_irq_byname_optional(pdev, "pm");
> +		if (irq > 0)
> +			iommu->irq_pm = irq;
> +		else {
> +			dev_err(dev, "no IRQ provided for performance monitoring\n");
> +			goto fail;
> +		}
> +	}
> +
> +	if (iommu->cap & RISCV_IOMMU_CAP_ATS) {
> +		irq = platform_get_irq_byname_optional(pdev, "priq");
> +		if (irq > 0)
> +			iommu->irq_priq = irq;
> +		else {
> +			dev_err(dev, "no IRQ provided for the page-request queue\n");
> +			goto fail;
> +		}
> +	}
> +
> +	/* Make sure fctl.WSI is set */
> +	fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> +	fctl |= RISCV_IOMMU_FCTL_WSI;
> +	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, fctl);
> +
> +	/* Parse Queue lengts */
> +	ret = of_property_read_u32(pdev->dev.of_node, "cmdq_len", &iommu->cmdq_len);
> +	if (!ret)
> +		dev_info(dev, "command queue length set to %i\n", iommu->cmdq_len);
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "fltq_len", &iommu->fltq_len);
> +	if (!ret)
> +		dev_info(dev, "fault/event queue length set to %i\n", iommu->fltq_len);
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "priq_len", &iommu->priq_len);
> +	if (!ret)
> +		dev_info(dev, "page request queue length set to %i\n", iommu->priq_len);

These properties are not documented in the binding, but are clearly 
Linux-specific driver policy which does not belong in DT anyway.

> +
>   	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>   
>   	return riscv_iommu_init(iommu);
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 31dc3c458e13..5c4cf9875302 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -45,6 +45,18 @@ static int ddt_mode = RISCV_IOMMU_DDTP_MODE_BARE;
>   module_param(ddt_mode, int, 0644);
>   MODULE_PARM_DESC(ddt_mode, "Device Directory Table mode.");
>   
> +static int cmdq_length = 1024;
> +module_param(cmdq_length, int, 0644);
> +MODULE_PARM_DESC(cmdq_length, "Command queue length.");
> +
> +static int fltq_length = 1024;
> +module_param(fltq_length, int, 0644);
> +MODULE_PARM_DESC(fltq_length, "Fault queue length.");
> +
> +static int priq_length = 1024;
> +module_param(priq_length, int, 0644);
> +MODULE_PARM_DESC(priq_length, "Page request interface queue length.");
> +
>   /* IOMMU PSCID allocation namespace. */
>   #define RISCV_IOMMU_MAX_PSCID	(1U << 20)
>   static DEFINE_IDA(riscv_iommu_pscids);
> @@ -65,6 +77,497 @@ static DEFINE_IDA(riscv_iommu_pscids);
>   static const struct iommu_domain_ops riscv_iommu_domain_ops;
>   static const struct iommu_ops riscv_iommu_ops;
>   
> +/*
> + * Common queue management routines
> + */
> +
> +/* Note: offsets are the same for all queues */
> +#define Q_HEAD(q) ((q)->qbr + (RISCV_IOMMU_REG_CQH - RISCV_IOMMU_REG_CQB))
> +#define Q_TAIL(q) ((q)->qbr + (RISCV_IOMMU_REG_CQT - RISCV_IOMMU_REG_CQB))
> +
> +static unsigned riscv_iommu_queue_consume(struct riscv_iommu_device *iommu,
> +					  struct riscv_iommu_queue *q, unsigned *ready)
> +{
> +	u32 tail = riscv_iommu_readl(iommu, Q_TAIL(q));
> +	*ready = q->lui;
> +
> +	BUG_ON(q->cnt <= tail);
> +	if (q->lui <= tail)
> +		return tail - q->lui;
> +	return q->cnt - q->lui;
> +}
> +
> +static void riscv_iommu_queue_release(struct riscv_iommu_device *iommu,
> +				      struct riscv_iommu_queue *q, unsigned count)
> +{
> +	q->lui = (q->lui + count) & (q->cnt - 1);
> +	riscv_iommu_writel(iommu, Q_HEAD(q), q->lui);
> +}
> +
> +static u32 riscv_iommu_queue_ctrl(struct riscv_iommu_device *iommu,
> +				  struct riscv_iommu_queue *q, u32 val)
> +{
> +	cycles_t end_cycles = RISCV_IOMMU_TIMEOUT + get_cycles();
> +
> +	riscv_iommu_writel(iommu, q->qcr, val);
> +	do {
> +		val = riscv_iommu_readl(iommu, q->qcr);
> +		if (!(val & RISCV_IOMMU_QUEUE_BUSY))
> +			break;
> +		cpu_relax();
> +	} while (get_cycles() < end_cycles);
> +
> +	return val;
> +}
> +
> +static void riscv_iommu_queue_free(struct riscv_iommu_device *iommu,
> +				   struct riscv_iommu_queue *q)
> +{
> +	size_t size = q->len * q->cnt;
> +
> +	riscv_iommu_queue_ctrl(iommu, q, 0);
> +
> +	if (q->base) {
> +		if (q->in_iomem)
> +			iounmap(q->base);
> +		else
> +			dmam_free_coherent(iommu->dev, size, q->base, q->base_dma);
> +	}
> +	if (q->irq)
> +		free_irq(q->irq, q);
> +}
> +
> +static irqreturn_t riscv_iommu_cmdq_irq_check(int irq, void *data);
> +static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data);
> +static irqreturn_t riscv_iommu_fltq_irq_check(int irq, void *data);
> +static irqreturn_t riscv_iommu_fltq_process(int irq, void *data);
> +static irqreturn_t riscv_iommu_priq_irq_check(int irq, void *data);
> +static irqreturn_t riscv_iommu_priq_process(int irq, void *data);
> +
> +static int riscv_iommu_queue_init(struct riscv_iommu_device *iommu, int queue_id)
> +{
> +	struct device *dev = iommu->dev;
> +	struct riscv_iommu_queue *q = NULL;
> +	size_t queue_size = 0;
> +	irq_handler_t irq_check;
> +	irq_handler_t irq_process;
> +	const char *name;
> +	int count = 0;
> +	int irq = 0;
> +	unsigned order = 0;
> +	u64 qbr_val = 0;
> +	u64 qbr_readback = 0;
> +	u64 qbr_paddr = 0;
> +	int ret = 0;
> +
> +	switch (queue_id) {
> +	case RISCV_IOMMU_COMMAND_QUEUE:
> +		q = &iommu->cmdq;
> +		q->len = sizeof(struct riscv_iommu_command);
> +		count = iommu->cmdq_len;
> +		irq = iommu->irq_cmdq;
> +		irq_check = riscv_iommu_cmdq_irq_check;
> +		irq_process = riscv_iommu_cmdq_process;
> +		q->qbr = RISCV_IOMMU_REG_CQB;
> +		q->qcr = RISCV_IOMMU_REG_CQCSR;
> +		name = "cmdq";
> +		break;
> +	case RISCV_IOMMU_FAULT_QUEUE:
> +		q = &iommu->fltq;
> +		q->len = sizeof(struct riscv_iommu_fq_record);
> +		count = iommu->fltq_len;
> +		irq = iommu->irq_fltq;
> +		irq_check = riscv_iommu_fltq_irq_check;
> +		irq_process = riscv_iommu_fltq_process;
> +		q->qbr = RISCV_IOMMU_REG_FQB;
> +		q->qcr = RISCV_IOMMU_REG_FQCSR;
> +		name = "fltq";
> +		break;
> +	case RISCV_IOMMU_PAGE_REQUEST_QUEUE:
> +		q = &iommu->priq;
> +		q->len = sizeof(struct riscv_iommu_pq_record);
> +		count = iommu->priq_len;
> +		irq = iommu->irq_priq;
> +		irq_check = riscv_iommu_priq_irq_check;
> +		irq_process = riscv_iommu_priq_process;
> +		q->qbr = RISCV_IOMMU_REG_PQB;
> +		q->qcr = RISCV_IOMMU_REG_PQCSR;
> +		name = "priq";
> +		break;
> +	default:
> +		dev_err(dev, "invalid queue interrupt index in queue_init!\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Polling not implemented */
> +	if (!irq)
> +		return -ENODEV;
> +
> +	/* Allocate queue in memory and set the base register */
> +	order = ilog2(count);
> +	do {
> +		queue_size = q->len * (1ULL << order);
> +		q->base = dmam_alloc_coherent(dev, queue_size, &q->base_dma, GFP_KERNEL);
> +		if (q->base || queue_size < PAGE_SIZE)
> +			break;
> +
> +		order--;
> +	} while (1);
> +
> +	if (!q->base) {
> +		dev_err(dev, "failed to allocate %s queue (cnt: %u)\n", name, count);
> +		return -ENOMEM;
> +	}
> +
> +	q->cnt = 1ULL << order;
> +
> +	qbr_val = phys_to_ppn(q->base_dma) |
> +	    FIELD_PREP(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, order - 1);
> +
> +	riscv_iommu_writeq(iommu, q->qbr, qbr_val);
> +
> +	/*
> +	 * Queue base registers are WARL, so it's possible that whatever we wrote
> +	 * there was illegal/not supported by the hw in which case we need to make
> +	 * sure we set a supported PPN and/or queue size.
> +	 */
> +	qbr_readback = riscv_iommu_readq(iommu, q->qbr);
> +	if (qbr_readback == qbr_val)
> +		goto irq;
> +
> +	dmam_free_coherent(dev, queue_size, q->base, q->base_dma);
> +
> +	/* Get supported queue size */
> +	order = FIELD_GET(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, qbr_readback) + 1;
> +	q->cnt = 1ULL << order;
> +	queue_size = q->len * q->cnt;

Um... What? We allocate an arbitrarily-sized queue, free it again, 
*then* check what the hardware actually supports, and maybe allocate 
another queue? I can't help thinking there's a much better way...

> +
> +	/*
> +	 * In case we also failed to set PPN, it means the field is hardcoded and the
> +	 * queue resides in I/O memory instead, so get its physical address and
> +	 * ioremap it.
> +	 */
> +	qbr_paddr = ppn_to_phys(qbr_readback);
> +	if (qbr_paddr != q->base_dma) {
> +		dev_info(dev,
> +			 "hardcoded ppn in %s base register, using io memory for the queue\n",
> +			 name);
> +		dev_info(dev, "queue length for %s set to %i\n", name, q->cnt);
> +		q->in_iomem = true;
> +		q->base = ioremap(qbr_paddr, queue_size);
> +		if (!q->base) {
> +			dev_err(dev, "failed to map %s queue (cnt: %u)\n", name, q->cnt);
> +			return -ENOMEM;
> +		}
> +		q->base_dma = qbr_paddr;
> +	} else {
> +		/*
> +		 * We only failed to set the queue size, re-try to allocate memory with
> +		 * the queue size supported by the hw.
> +		 */
> +		dev_info(dev, "hardcoded queue size in %s base register\n", name);
> +		dev_info(dev, "retrying with queue length: %i\n", q->cnt);
> +		q->base = dmam_alloc_coherent(dev, queue_size, &q->base_dma, GFP_KERNEL);

Note that dma_alloc_coherent only guarantees natural alignment here, so 
if you need a minimum alignment of 4KB as the spec claims you should 
really make clamp your minimum allocation size to that.

> +		if (!q->base) {
> +			dev_err(dev, "failed to allocate %s queue (cnt: %u)\n",
> +				name, q->cnt);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	qbr_val = phys_to_ppn(q->base_dma) |
> +	    FIELD_PREP(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, order - 1);
> +	riscv_iommu_writeq(iommu, q->qbr, qbr_val);
> +
> +	/* Final check to make sure hw accepted our write */
> +	qbr_readback = riscv_iommu_readq(iommu, q->qbr);
> +	if (qbr_readback != qbr_val) {
> +		dev_err(dev, "failed to set base register for %s\n", name);
> +		goto fail;
> +	}
> +
> + irq:
> +	if (request_threaded_irq(irq, irq_check, irq_process, IRQF_ONESHOT | IRQF_SHARED,
> +				 dev_name(dev), q)) {
> +		dev_err(dev, "fail to request irq %d for %s\n", irq, name);
> +		goto fail;
> +	}
> +
> +	q->irq = irq;
> +
> +	/* Note: All RIO_xQ_EN/IE fields are in the same offsets */
> +	ret =
> +	    riscv_iommu_queue_ctrl(iommu, q,
> +				   RISCV_IOMMU_QUEUE_ENABLE |
> +				   RISCV_IOMMU_QUEUE_INTR_ENABLE);
> +	if (ret & RISCV_IOMMU_QUEUE_BUSY) {
> +		dev_err(dev, "%s init timeout\n", name);
> +		ret = -EBUSY;
> +		goto fail;
> +	}
> +
> +	return 0;
> +
> + fail:
> +	riscv_iommu_queue_free(iommu, q);
> +	return 0;
> +}
> +
> +/*
> + * I/O MMU Command queue chapter 3.1
> + */
> +
> +static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
> +{
> +	cmd->dword0 =
> +	    FIELD_PREP(RISCV_IOMMU_CMD_OPCODE,
> +		       RISCV_IOMMU_CMD_IOTINVAL_OPCODE) | FIELD_PREP(RISCV_IOMMU_CMD_FUNC,
> +								     RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA);

Interesting indentation... :/

> +	cmd->dword1 = 0;
> +}
> +
> +static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cmd,
> +						  u64 addr)
> +{
> +	cmd->dword0 |= RISCV_IOMMU_CMD_IOTINVAL_AV;
> +	cmd->dword1 = addr;
> +}
> +
> +static inline void riscv_iommu_cmd_inval_set_pscid(struct riscv_iommu_command *cmd,
> +						   unsigned pscid)
> +{
> +	cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_PSCID, pscid) |
> +	    RISCV_IOMMU_CMD_IOTINVAL_PSCV;
> +}
> +
> +static inline void riscv_iommu_cmd_inval_set_gscid(struct riscv_iommu_command *cmd,
> +						   unsigned gscid)
> +{
> +	cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_GSCID, gscid) |
> +	    RISCV_IOMMU_CMD_IOTINVAL_GV;
> +}
> +
> +static inline void riscv_iommu_cmd_iofence(struct riscv_iommu_command *cmd)
> +{
> +	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_IOFENCE_OPCODE) |
> +	    FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IOFENCE_FUNC_C);
> +	cmd->dword1 = 0;
> +}
> +
> +static inline void riscv_iommu_cmd_iofence_set_av(struct riscv_iommu_command *cmd,
> +						  u64 addr, u32 data)
> +{
> +	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_IOFENCE_OPCODE) |
> +	    FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IOFENCE_FUNC_C) |
> +	    FIELD_PREP(RISCV_IOMMU_CMD_IOFENCE_DATA, data) | RISCV_IOMMU_CMD_IOFENCE_AV;
> +	cmd->dword1 = (addr >> 2);
> +}
> +
> +static inline void riscv_iommu_cmd_iodir_inval_ddt(struct riscv_iommu_command *cmd)
> +{
> +	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_IODIR_OPCODE) |
> +	    FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT);
> +	cmd->dword1 = 0;
> +}
> +
> +static inline void riscv_iommu_cmd_iodir_inval_pdt(struct riscv_iommu_command *cmd)
> +{
> +	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_IODIR_OPCODE) |
> +	    FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT);
> +	cmd->dword1 = 0;
> +}
> +
> +static inline void riscv_iommu_cmd_iodir_set_did(struct riscv_iommu_command *cmd,
> +						 unsigned devid)
> +{
> +	cmd->dword0 |=
> +	    FIELD_PREP(RISCV_IOMMU_CMD_IODIR_DID, devid) | RISCV_IOMMU_CMD_IODIR_DV;
> +}
> +
> +/* TODO: Convert into lock-less MPSC implementation. */
> +static bool riscv_iommu_post_sync(struct riscv_iommu_device *iommu,
> +				  struct riscv_iommu_command *cmd, bool sync)
> +{
> +	u32 head, tail, next, last;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iommu->cq_lock, flags);
> +	head = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_CQH) & (iommu->cmdq.cnt - 1);
> +	tail = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_CQT) & (iommu->cmdq.cnt - 1);
> +	last = iommu->cmdq.lui;
> +	if (tail != last) {
> +		spin_unlock_irqrestore(&iommu->cq_lock, flags);
> +		/*
> +		 * FIXME: This is a workaround for dropped MMIO writes/reads on QEMU platform.
> +		 *        While debugging of the problem is still ongoing, this provides
> +		 *        a simple impolementation of try-again policy.
> +		 *        Will be changed to lock-less algorithm in the feature.
> +		 */
> +		dev_dbg(iommu->dev, "IOMMU CQT: %x != %x (1st)\n", last, tail);
> +		spin_lock_irqsave(&iommu->cq_lock, flags);
> +		tail =
> +		    riscv_iommu_readl(iommu, RISCV_IOMMU_REG_CQT) & (iommu->cmdq.cnt - 1);
> +		last = iommu->cmdq.lui;
> +		if (tail != last) {
> +			spin_unlock_irqrestore(&iommu->cq_lock, flags);
> +			dev_dbg(iommu->dev, "IOMMU CQT: %x != %x (2nd)\n", last, tail);
> +			spin_lock_irqsave(&iommu->cq_lock, flags);
> +		}
> +	}
> +
> +	next = (last + 1) & (iommu->cmdq.cnt - 1);
> +	if (next != head) {
> +		struct riscv_iommu_command *ptr = iommu->cmdq.base;
> +		ptr[last] = *cmd;
> +		wmb();
> +		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_CQT, next);
> +		iommu->cmdq.lui = next;
> +	}
> +
> +	spin_unlock_irqrestore(&iommu->cq_lock, flags);
> +
> +	if (sync && head != next) {
> +		cycles_t start_time = get_cycles();
> +		while (1) {
> +			last = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_CQH) &
> +			    (iommu->cmdq.cnt - 1);
> +			if (head < next && last >= next)
> +				break;
> +			if (head > next && last < head && last >= next)
> +				break;
> +			if (RISCV_IOMMU_TIMEOUT < (get_cycles() - start_time)) {
> +				dev_err(iommu->dev, "IOFENCE TIMEOUT\n");
> +				return false;
> +			}
> +			cpu_relax();
> +		}
> +	}
> +
> +	return next != head;
> +}
> +
> +static bool riscv_iommu_post(struct riscv_iommu_device *iommu,
> +			     struct riscv_iommu_command *cmd)
> +{
> +	return riscv_iommu_post_sync(iommu, cmd, false);
> +}
> +
> +static bool riscv_iommu_iofence_sync(struct riscv_iommu_device *iommu)
> +{
> +	struct riscv_iommu_command cmd;
> +	riscv_iommu_cmd_iofence(&cmd);
> +	return riscv_iommu_post_sync(iommu, &cmd, true);
> +}
> +
> +/* Command queue primary interrupt handler */
> +static irqreturn_t riscv_iommu_cmdq_irq_check(int irq, void *data)
> +{
> +	struct riscv_iommu_queue *q = (struct riscv_iommu_queue *)data;
> +	struct riscv_iommu_device *iommu =
> +	    container_of(q, struct riscv_iommu_device, cmdq);
> +	u32 ipsr = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IPSR);
> +	if (ipsr & RISCV_IOMMU_IPSR_CIP)
> +		return IRQ_WAKE_THREAD;
> +	return IRQ_NONE;
> +}
> +
> +/* Command queue interrupt hanlder thread function */
> +static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
> +{
> +	struct riscv_iommu_queue *q = (struct riscv_iommu_queue *)data;
> +	struct riscv_iommu_device *iommu;
> +	unsigned ctrl;
> +
> +	iommu = container_of(q, struct riscv_iommu_device, cmdq);
> +
> +	/* Error reporting, clear error reports if any. */
> +	ctrl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_CQCSR);
> +	if (ctrl & (RISCV_IOMMU_CQCSR_CQMF |
> +		    RISCV_IOMMU_CQCSR_CMD_TO | RISCV_IOMMU_CQCSR_CMD_ILL)) {
> +		riscv_iommu_queue_ctrl(iommu, &iommu->cmdq, ctrl);
> +		dev_warn_ratelimited(iommu->dev,
> +				     "Command queue error: fault: %d tout: %d err: %d\n",
> +				     !!(ctrl & RISCV_IOMMU_CQCSR_CQMF),
> +				     !!(ctrl & RISCV_IOMMU_CQCSR_CMD_TO),
> +				     !!(ctrl & RISCV_IOMMU_CQCSR_CMD_ILL));
> +	}
> +
> +	/* Clear fault interrupt pending. */
> +	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_CIP);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Fault/event queue, chapter 3.2
> + */
> +
> +static void riscv_iommu_fault_report(struct riscv_iommu_device *iommu,
> +				     struct riscv_iommu_fq_record *event)
> +{
> +	unsigned err, devid;
> +
> +	err = FIELD_GET(RISCV_IOMMU_FQ_HDR_CAUSE, event->hdr);
> +	devid = FIELD_GET(RISCV_IOMMU_FQ_HDR_DID, event->hdr);
> +
> +	dev_warn_ratelimited(iommu->dev,
> +			     "Fault %d devid: %d" " iotval: %llx iotval2: %llx\n", err,
> +			     devid, event->iotval, event->iotval2);
> +}
> +
> +/* Fault/event queue primary interrupt handler */
> +static irqreturn_t riscv_iommu_fltq_irq_check(int irq, void *data)
> +{
> +	struct riscv_iommu_queue *q = (struct riscv_iommu_queue *)data;
> +	struct riscv_iommu_device *iommu =
> +	    container_of(q, struct riscv_iommu_device, fltq);
> +	u32 ipsr = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IPSR);
> +	if (ipsr & RISCV_IOMMU_IPSR_FIP)
> +		return IRQ_WAKE_THREAD;
> +	return IRQ_NONE;
> +}
> +
> +/* Fault queue interrupt hanlder thread function */
> +static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
> +{
> +	struct riscv_iommu_queue *q = (struct riscv_iommu_queue *)data;
> +	struct riscv_iommu_device *iommu;
> +	struct riscv_iommu_fq_record *events;
> +	unsigned cnt, len, idx, ctrl;
> +
> +	iommu = container_of(q, struct riscv_iommu_device, fltq);
> +	events = (struct riscv_iommu_fq_record *)q->base;
> +
> +	/* Error reporting, clear error reports if any. */
> +	ctrl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FQCSR);
> +	if (ctrl & (RISCV_IOMMU_FQCSR_FQMF | RISCV_IOMMU_FQCSR_FQOF)) {
> +		riscv_iommu_queue_ctrl(iommu, &iommu->fltq, ctrl);
> +		dev_warn_ratelimited(iommu->dev,
> +				     "Fault queue error: fault: %d full: %d\n",
> +				     !!(ctrl & RISCV_IOMMU_FQCSR_FQMF),
> +				     !!(ctrl & RISCV_IOMMU_FQCSR_FQOF));
> +	}
> +
> +	/* Clear fault interrupt pending. */
> +	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_FIP);
> +
> +	/* Report fault events. */
> +	do {
> +		cnt = riscv_iommu_queue_consume(iommu, q, &idx);
> +		if (!cnt)
> +			break;
> +		for (len = 0; len < cnt; idx++, len++)
> +			riscv_iommu_fault_report(iommu, &events[idx]);
> +		riscv_iommu_queue_release(iommu, q, cnt);
> +	} while (1);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Page request queue, chapter 3.3
> + */
> +
>   /*
>    * Register device for IOMMU tracking.
>    */
> @@ -97,6 +600,54 @@ static void riscv_iommu_add_device(struct riscv_iommu_device *iommu, struct devi
>   	mutex_unlock(&iommu->eps_mutex);
>   }
>   
> +/* Page request interface queue primary interrupt handler */
> +static irqreturn_t riscv_iommu_priq_irq_check(int irq, void *data)
> +{
> +	struct riscv_iommu_queue *q = (struct riscv_iommu_queue *)data;
> +	struct riscv_iommu_device *iommu =
> +	    container_of(q, struct riscv_iommu_device, priq);
> +	u32 ipsr = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IPSR);
> +	if (ipsr & RISCV_IOMMU_IPSR_PIP)
> +		return IRQ_WAKE_THREAD;
> +	return IRQ_NONE;
> +}
> +
> +/* Page request interface queue interrupt hanlder thread function */
> +static irqreturn_t riscv_iommu_priq_process(int irq, void *data)
> +{
> +	struct riscv_iommu_queue *q = (struct riscv_iommu_queue *)data;
> +	struct riscv_iommu_device *iommu;
> +	struct riscv_iommu_pq_record *requests;
> +	unsigned cnt, idx, ctrl;
> +
> +	iommu = container_of(q, struct riscv_iommu_device, priq);
> +	requests = (struct riscv_iommu_pq_record *)q->base;
> +
> +	/* Error reporting, clear error reports if any. */
> +	ctrl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_PQCSR);
> +	if (ctrl & (RISCV_IOMMU_PQCSR_PQMF | RISCV_IOMMU_PQCSR_PQOF)) {
> +		riscv_iommu_queue_ctrl(iommu, &iommu->priq, ctrl);
> +		dev_warn_ratelimited(iommu->dev,
> +				     "Page request queue error: fault: %d full: %d\n",
> +				     !!(ctrl & RISCV_IOMMU_PQCSR_PQMF),
> +				     !!(ctrl & RISCV_IOMMU_PQCSR_PQOF));
> +	}
> +
> +	/* Clear page request interrupt pending. */
> +	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PIP);
> +
> +	/* Process page requests. */
> +	do {
> +		cnt = riscv_iommu_queue_consume(iommu, q, &idx);
> +		if (!cnt)
> +			break;
> +		dev_warn(iommu->dev, "unexpected %u page requests\n", cnt);
> +		riscv_iommu_queue_release(iommu, q, cnt);
> +	} while (1);
> +
> +	return IRQ_HANDLED;
> +}
> +
>   /*
>    * Endpoint management
>    */
> @@ -350,7 +901,29 @@ static void riscv_iommu_flush_iotlb_range(struct iommu_domain *iommu_domain,
>   					  unsigned long *start, unsigned long *end,
>   					  size_t *pgsize)
>   {
> -	/* Command interface not implemented */
> +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> +	struct riscv_iommu_command cmd;
> +	unsigned long iova;
> +
> +	if (domain->mode == RISCV_IOMMU_DC_FSC_MODE_BARE)

That should probably not happen - things shouldn't be calling TLB ops on 
identity domains (and ideally your identity domains wouldn't even *have* 
iotlb callbacks...)

> +		return;
> +
> +	/* Domain not attached to an IOMMU! */
> +	BUG_ON(!domain->iommu);

However I'm not sure how iommu_create_device_direct_mappings() isn't 
hitting that?

Thanks,
Robin.

> +
> +	riscv_iommu_cmd_inval_vma(&cmd);
> +	riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> +
> +	if (start && end && pgsize) {
> +		/* Cover only the range that is needed */
> +		for (iova = *start; iova <= *end; iova += *pgsize) {
> +			riscv_iommu_cmd_inval_set_addr(&cmd, iova);
> +			riscv_iommu_post(domain->iommu, &cmd);
> +		}
> +	} else {
> +		riscv_iommu_post(domain->iommu, &cmd);
> +	}
> +	riscv_iommu_iofence_sync(domain->iommu);
>   }
>   
>   static void riscv_iommu_flush_iotlb_all(struct iommu_domain *iommu_domain)
> @@ -610,6 +1183,9 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
>   	iommu_device_unregister(&iommu->iommu);
>   	iommu_device_sysfs_remove(&iommu->iommu);
>   	riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> +	riscv_iommu_queue_free(iommu, &iommu->cmdq);
> +	riscv_iommu_queue_free(iommu, &iommu->fltq);
> +	riscv_iommu_queue_free(iommu, &iommu->priq);
>   }
>   
>   int riscv_iommu_init(struct riscv_iommu_device *iommu)
> @@ -632,6 +1208,16 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   	}
>   #endif
>   
> +	/*
> +	 * Assign queue lengths from module parameters if not already
> +	 * set on the device tree.
> +	 */
> +	if (!iommu->cmdq_len)
> +		iommu->cmdq_len = cmdq_length;
> +	if (!iommu->fltq_len)
> +		iommu->fltq_len = fltq_length;
> +	if (!iommu->priq_len)
> +		iommu->priq_len = priq_length;
>   	/* Clear any pending interrupt flag. */
>   	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR,
>   			   RISCV_IOMMU_IPSR_CIP |
> @@ -639,7 +1225,20 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   			   RISCV_IOMMU_IPSR_PMIP | RISCV_IOMMU_IPSR_PIP);
>   	spin_lock_init(&iommu->cq_lock);
>   	mutex_init(&iommu->eps_mutex);
> +	ret = riscv_iommu_queue_init(iommu, RISCV_IOMMU_COMMAND_QUEUE);
> +	if (ret)
> +		goto fail;
> +	ret = riscv_iommu_queue_init(iommu, RISCV_IOMMU_FAULT_QUEUE);
> +	if (ret)
> +		goto fail;
> +	if (!(iommu->cap & RISCV_IOMMU_CAP_ATS))
> +		goto no_ats;
> +
> +	ret = riscv_iommu_queue_init(iommu, RISCV_IOMMU_PAGE_REQUEST_QUEUE);
> +	if (ret)
> +		goto fail;
>   
> + no_ats:
>   	ret = riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_BARE);
>   
>   	if (ret) {
> @@ -663,5 +1262,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   	return 0;
>    fail:
>   	riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> +	riscv_iommu_queue_free(iommu, &iommu->priq);
> +	riscv_iommu_queue_free(iommu, &iommu->fltq);
> +	riscv_iommu_queue_free(iommu, &iommu->cmdq);
>   	return ret;
>   }
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 7dc9baa59a50..04148a2a8ffd 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -28,6 +28,24 @@
>   #define IOMMU_PAGE_SIZE_1G	BIT_ULL(30)
>   #define IOMMU_PAGE_SIZE_512G	BIT_ULL(39)
>   
> +struct riscv_iommu_queue {
> +	dma_addr_t base_dma;	/* ring buffer bus address */
> +	void *base;		/* ring buffer pointer */
> +	size_t len;		/* single item length */
> +	u32 cnt;		/* items count */
> +	u32 lui;		/* last used index, consumer/producer share */
> +	unsigned qbr;		/* queue base register offset */
> +	unsigned qcr;		/* queue control and status register offset */
> +	int irq;		/* registered interrupt number */
> +	bool in_iomem;		/* indicates queue data are in I/O memory  */
> +};
> +
> +enum riscv_queue_ids {
> +	RISCV_IOMMU_COMMAND_QUEUE	= 0,
> +	RISCV_IOMMU_FAULT_QUEUE		= 1,
> +	RISCV_IOMMU_PAGE_REQUEST_QUEUE	= 2
> +};
> +
>   struct riscv_iommu_device {
>   	struct iommu_device iommu;	/* iommu core interface */
>   	struct device *dev;		/* iommu hardware */
> @@ -42,6 +60,11 @@ struct riscv_iommu_device {
>   	int irq_pm;
>   	int irq_priq;
>   
> +	/* Queue lengths */
> +	int cmdq_len;
> +	int fltq_len;
> +	int priq_len;
> +
>   	/* supported and enabled hardware capabilities */
>   	u64 cap;
>   
> @@ -53,6 +76,11 @@ struct riscv_iommu_device {
>   	unsigned ddt_mode;
>   	bool ddtp_in_iomem;
>   
> +	/* hardware queues */
> +	struct riscv_iommu_queue cmdq;
> +	struct riscv_iommu_queue fltq;
> +	struct riscv_iommu_queue priq;
> +
>   	/* Connected end-points */
>   	struct rb_root eps;
>   	struct mutex eps_mutex;
