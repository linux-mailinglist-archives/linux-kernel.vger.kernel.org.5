Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E17E80795D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379539AbjLFU0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjLFU0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:26:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D299AD1;
        Wed,  6 Dec 2023 12:26:57 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701894416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kqh7GJ3rdYwLUSDYgl+gNKDmu46Ojy1zKysyN8CB3PA=;
        b=Dx3zUkXnBMm4PIrqdahEibZhO1yy5UJQsEexfAvFuyvV+nW6+zBezgyCZo+LL6QhzGrqSu
        TSfYMIh9rn+gK/uOHTyzZbDwudn2yF9Ai82oaYimTHIvldekh+tLWACpNm9g/wmnRmxC38
        07CpNlabWYsqEF/CUR7K+s12Y8RbfhU/4juyiJJv9Qbx/1PtvxwHNOgiWlkq9B6fqAfoeX
        VgCo8h7aCC2yd6opZKrtTgQnNdXzvLNU2TOSkscwChU89zqDgbnPA9uPeLrF7KnZo41W2U
        IkqGyjVPLXedUpPK2UEr+dmBCUJfb3Cn778WjDuw9yEwwqnEc/BzukSPVyeNPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701894416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kqh7GJ3rdYwLUSDYgl+gNKDmu46Ojy1zKysyN8CB3PA=;
        b=cm4lSW9GTi7RqBu3Yh/KXEw7CN9Ktdug13v2YXI4gYKAtP8Ow02khQivs91iaWtlha6u1V
        fsm8DveWhxUy1NAQ==
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
        iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org,
        peterz@infradead.org, seanjc@google.com,
        Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH RFC 13/13] iommu/vt-d: Enable posted mode for device MSIs
In-Reply-To: <20231112041643.2868316-14-jacob.jun.pan@linux.intel.com>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-14-jacob.jun.pan@linux.intel.com>
Date:   Wed, 06 Dec 2023 21:26:55 +0100
Message-ID: <87zfynt6uo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11 2023 at 20:16, Jacob Pan wrote:
>  #ifdef CONFIG_X86_POSTED_MSI
>  
>  static u64 get_pi_desc_addr(struct irq_data *irqd)
> @@ -1133,6 +1144,29 @@ static u64 get_pi_desc_addr(struct irq_data *irqd)
>  
>  	return __pa(per_cpu_ptr(&posted_interrupt_desc, cpu));
>  }
> +
> +static void intel_ir_reconfigure_irte_posted(struct irq_data *irqd)
> +{
> +	struct intel_ir_data *ir_data = irqd->chip_data;
> +	struct irte *irte = &ir_data->irte_entry;
> +	struct irte irte_pi;
> +	u64 pid_addr;
> +
> +	pid_addr = get_pi_desc_addr(irqd);
> +
> +	memset(&irte_pi, 0, sizeof(irte_pi));
> +
> +	/* The shared IRTE already be set up as posted during alloc_irte */

-ENOPARSE

> +	dmar_copy_shared_irte(&irte_pi, irte);
> +
> +	irte_pi.pda_l = (pid_addr >> (32 - PDA_LOW_BIT)) & ~(-1UL << PDA_LOW_BIT);
> +	irte_pi.pda_h = (pid_addr >> 32) & ~(-1UL << PDA_HIGH_BIT);
> +
> +	modify_irte(&ir_data->irq_2_iommu, &irte_pi);
> +}
> +
> +#else
> +static inline void intel_ir_reconfigure_irte_posted(struct irq_data *irqd) {}
>  #endif
>  
>  static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
> @@ -1148,8 +1182,9 @@ static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
>  	irte->vector = cfg->vector;
>  	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
>  
> -	/* Update the hardware only if the interrupt is in remapped mode. */
> -	if (force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
> +	if (ir_data->irq_2_iommu.posted_msi)
> +		intel_ir_reconfigure_irte_posted(irqd);
> +	else if (force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
>  		modify_irte(&ir_data->irq_2_iommu, irte);
>  }
>  
> @@ -1203,7 +1238,7 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
>  	struct intel_ir_data *ir_data = data->chip_data;
>  	struct vcpu_data *vcpu_pi_info = info;
>  
> -	/* stop posting interrupts, back to remapping mode */
> +	/* stop posting interrupts, back to the default mode */
>  	if (!vcpu_pi_info) {
>  		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
>  	} else {
> @@ -1300,10 +1335,14 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
>  {
>  	struct irte *irte = &data->irte_entry;
>  
> -	prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);
> +	if (data->irq_2_iommu.mode == IRQ_POSTING)
> +		prepare_irte_posted(irte);
> +	else
> +		prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);
>  
>  	switch (info->type) {
>  	case X86_IRQ_ALLOC_TYPE_IOAPIC:
> +		prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);

What? This is just wrong. Above you have:

> +	if (data->irq_2_iommu.mode == IRQ_POSTING)
> +		prepare_irte_posted(irte);
> +	else
> +		prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);

Can you spot the fail?

>  		/* Set source-id of interrupt request */
>  		set_ioapic_sid(irte, info->devid);
>  		apic_printk(APIC_VERBOSE, KERN_DEBUG "IOAPIC[%d]: Set IRTE entry (P:%d FPD:%d Dst_Mode:%d Redir_hint:%d Trig_Mode:%d Dlvry_Mode:%X Avail:%X Vector:%02X Dest:%08X SID:%04X SQ:%X SVT:%X)\n",
> @@ -1315,10 +1354,18 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
>  		sub_handle = info->ioapic.pin;
>  		break;
>  	case X86_IRQ_ALLOC_TYPE_HPET:
> +		prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);
>  		set_hpet_sid(irte, info->devid);
>  		break;
>  	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
>  	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
> +		if (posted_msi_supported()) {
> +			prepare_irte_posted(irte);
> +			data->irq_2_iommu.posted_msi = 1;
> +		} else {
> +			prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);
> +		}

Here it gets even more hilarious.
