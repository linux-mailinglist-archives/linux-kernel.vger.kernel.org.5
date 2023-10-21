Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF017D1FB6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 23:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjJUVBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 17:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjJUVBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 17:01:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863C01A8;
        Sat, 21 Oct 2023 14:01:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA24EC433C7;
        Sat, 21 Oct 2023 21:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697922094;
        bh=M+M3q5sxfvxUvyeRGABwgSGpQ53ingORdN/e2crghb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o0Ht/7LnWMWbBtI4Nl6SK0U3pct/JGTwno/rTY8N9ECE7uDG/oKvZPG/MBSoUrpNQ
         1JYl9QkpSAcVakb4/mqRlWI14WClVe6sOaiJe0fXujVr4BLLhhqyfvcxB0bdTYT8bl
         rMCIkBJKkyrTpiEl6qIK7G087ud4lJybQJ/q6fsneyk5GIjvyhBaYG5PCByrm/bpGU
         d9eR5Lc0Hfpqp0aXZrvK3vxhByEzdXxtSa0XVhRXvEEOCTlnl20XK7KmkdIXZsJ8kN
         h5XOsKQDu+6CzSmRazKfUVqPYXCwzeCHqxdqoyZTOxZ3JGQNUBYlkb63NhQYRWjIqH
         QisVVVRyLiiIA==
Date:   Sat, 21 Oct 2023 14:05:13 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com,
        quic_sukadev@quicinc.com, quic_pdaly@quicinc.com,
        quic_sudaraja@quicinc.com, djakov@kernel.org
Subject: Re: [PATCH 3/6] iommu/arm-smmu-qcom: Add Qualcomm TBU driver
Message-ID: <ljbzuewnsi52qyolombjowuouiqmv5ybwbqf2z6ok34yuiacjc@7hwfysvidjqm>
References: <20231019021923.13939-1-quic_c_gdjako@quicinc.com>
 <20231019021923.13939-4-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019021923.13939-4-quic_c_gdjako@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 07:19:20PM -0700, Georgi Djakov wrote:
> Add driver for the Qualcomm implementation of the ARM MMU-500 TBU.
> The driver will enable the resources needed by the TBU and will
> configure the registers for some debug features like checking if
> there are any pending transactions, capturing transactions and
> running ATOS (Address Translation Operations). ATOS/eCATS are used
> to manually trigger an address translation of IOVA to physical
> address by the SMMU hardware.

I still don't think this commit message clearly enough describe the
problem you're trying to solve.

Not until I had read the Kconfig help text did I pay attention to the
significance of the words "some debug features" in the middle of the
paragraph.


Please describe your changes in accordance with [1], i.e. clearly
describe the problem you're trying to solve, then discuss the technical
solution in the patch.

[1] https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

[..]
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
[..]
> +#ifdef CONFIG_ARM_SMMU_QCOM_TBU
> +
> +struct qsmmuv500_tbu {
> +	struct device *dev;
> +	struct arm_smmu_device *smmu;
> +	u32 sid_range[2];
> +	struct list_head list;
> +	struct clk *clk;
> +	struct icc_path	*path;
> +	void __iomem *base;
> +	spinlock_t halt_lock; /* protects halt count */

But in particular it makes sure that multiple halt or resume can't
execute concurrently.

> +	int halt_count;
> +};
> +
> +static DEFINE_SPINLOCK(ecats_lock);
> +
> +static struct qsmmuv500_tbu *qsmmuv500_find_tbu(struct qcom_smmu *qsmmu, u32 sid)
> +{
> +	struct qsmmuv500_tbu *tbu = NULL;
> +	u32 start, end;
> +
> +	mutex_lock(&qsmmu->tbu_list_lock);
> +
> +	list_for_each_entry(tbu, &qsmmu->tbu_list, list) {
> +		start = tbu->sid_range[0];
> +		end = start + tbu->sid_range[1];
> +
> +		if (start <= sid && sid < end)
> +			break;
> +	}
> +
> +	mutex_unlock(&qsmmu->tbu_list_lock);
> +
> +	return tbu;
> +}
> +
> +static int qsmmuv500_tbu_halt(struct qsmmuv500_tbu *tbu, struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	int ret = 0, idx = smmu_domain->cfg.cbndx;
> +	unsigned long flags;
> +	u32 val, fsr, status;
> +
> +	spin_lock_irqsave(&tbu->halt_lock, flags);

Does this really need to run with interrupts disabled?

> +	if (tbu->halt_count) {
> +		tbu->halt_count++;
> +		goto out;
> +	}
> +
[..]
> +static phys_addr_t qsmmuv500_iova_to_phys(struct arm_smmu_domain *smmu_domain,
> +					  dma_addr_t iova, u32 sid)
> +{
[..]
> +	/* Only one concurrent atos operation */
> +	spin_lock_irqsave(&ecats_lock, flags);

Does this require interrupts to be disabled?

> +
> +	/*
> +	 * After a failed translation, the next successful translation will
> +	 * incorrectly be reported as a failure.

"So if the ECATS translation fails, attempt the lookup more time."

> +	 */
> +	do {
> +		phys = qsmmuv500_tbu_trigger_atos(smmu_domain, tbu, iova, sid);
> +
> +		fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> +		if (fsr & ARM_SMMU_FSR_FAULT) {
> +			/* Clear pending interrupts */
> +			arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> +			/*
> +			 * Barrier required to ensure that the FSR is cleared
> +			 * before resuming SMMU operation.
> +			 */

Better be clear on what this actually does, for future readers' sake:

	 /* Ensure that FSR and RESUME operations aren't reordered. */

But is this really necessary, the two writes are for the same device,
can they still be reordered?

> +			wmb();
> +
> +			if (fsr & ARM_SMMU_FSR_SS)
> +				arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME,
> +						  ARM_SMMU_RESUME_TERMINATE);
> +		}
> +	} while (!phys && needs_redo++ < 2);

"needs_redo" sounds like a boolean to me. I think "attempt" would be a
better fit here.

> +
> +	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, sctlr_orig);
> +	spin_unlock_irqrestore(&ecats_lock, flags);
> +	qsmmuv500_tbu_resume(tbu);
> +
> +	/* Read to complete prior write transcations */
> +	readl_relaxed(tbu->base + DEBUG_SR_HALT_ACK_REG);
> +
> +	/* Wait for read to complete */

That's not what rmb() does. You don't need to do anything here,
readl_relaxed() returns when the read is done.

> +	rmb();
> +
> +disable_clk:
> +	clk_disable_unprepare(tbu->clk);
> +disable_icc:
> +	icc_set_bw(tbu->path, 0, 0);
> +
> +	return phys;
> +}
> +#endif
> +
>  static void qcom_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
>  				int sync, int status)
>  {
> @@ -588,3 +895,80 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>  
>  	return smmu;
>  }
> +
> +#ifdef CONFIG_ARM_SMMU_QCOM_TBU
> +
> +static const struct of_device_id qsmmuv500_tbu_of_match[] = {
> +	{ .compatible = "qcom,qsmmuv500-tbu" },
> +	{ }
> +};

Place this below the remove function, as most other drivers do.

> +
> +static int qsmmuv500_tbu_probe(struct platform_device *pdev)
> +{
[..]
> +	mutex_lock(&qsmmu->tbu_list_lock);
> +	list_add_tail(&tbu->list, &qsmmu->tbu_list);

"tbu" is devres allocated, but you don't pull it off the list (or
synchronize) during remove.

> +	mutex_unlock(&qsmmu->tbu_list_lock);
> +
> +	dev_set_drvdata(dev, tbu);
> +
> +	return 0;
> +}
> +
> +static void qsmmuv500_tbu_remove(struct platform_device *pdev)
> +{
> +	struct qsmmuv500_tbu *tbu = dev_get_drvdata(&pdev->dev);
> +
> +	clk_disable_unprepare(tbu->clk);

This isn't balanced.

> +	clk_put(tbu->clk);
> +	icc_put(tbu->path);
> +}
> +
> +static struct platform_driver qsmmuv500_tbu_driver = {
> +	.driver = {
> +		.name           = "qsmmuv500-tbu",
> +		.of_match_table = of_match_ptr(qsmmuv500_tbu_of_match),

Won't of_match_ptr() result in a build warning if built without
CONFIG_OF?

> +	},
> +	.probe  = qsmmuv500_tbu_probe,
> +	.remove_new = qsmmuv500_tbu_remove,
> +};
> +module_platform_driver(qsmmuv500_tbu_driver);

This file acts as a library for the arm-smmu driver today, adding a
platform_driver here makes it look like this is a separate driver.

Which makes me wonder, why is this a separate driver? Why not just
loop over the subnodes and build the tbu_list in qcom_smmu_impl_init()?

Regards,
Bjorn
