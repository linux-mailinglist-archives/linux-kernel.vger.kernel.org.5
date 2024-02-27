Return-Path: <linux-kernel+bounces-82608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4480B868709
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF7D288C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCA6FC0C;
	Tue, 27 Feb 2024 02:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b="apFl0Xw2"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E8CD304
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000840; cv=none; b=kErVTQXLB/oqg4sZ2j1dzYqHRbTG+uzlt2DCtFVUxIXenHGvXOT4JYrUXnOijgOLNI1gZ0LPUd2p5HYTjW8Olx7ErEjlf6ozM1mibIfmFNI2dqb75JAbdE6Kzmw9vRk0c4gqZlwOpo+tjyH/7+3Sqhy43DcKTrP6Yp+cOcPVWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000840; c=relaxed/simple;
	bh=pBmOsK1nMIBed8xEut39AOlAcE+zkF5NFZiRp+8Eems=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IyQ6b2YFaf6HjV/laRfXoEusq4kpte2rMrTHqyV/LKI0SnsFhpxJJ463R/qLBDwJhWnJdCQukmaP36q6G2bi1sMHczklVTHGMD8oYhvqp8U+1ehFgBkYITSr5WkUBb6+fvm7nhFLYTB/VGEcOU0TjQMGD1QPGfHMKdj0CIEFjTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw; spf=pass smtp.mailfrom=csie.ntu.edu.tw; dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b=apFl0Xw2; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csie.ntu.edu.tw
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so2962143a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie.ntu.edu.tw; s=google; t=1709000835; x=1709605635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpQtl74gw/hNqeFlBJTt3cd3UkRyyWRIFg0ixYHJbjI=;
        b=apFl0Xw2W/lqHl00VVXl5G50ZEpMHSVXBQz89CyTJ5iiBuzuZOOmBGA7Gto8WWfnv7
         dmUjGfIvRF2SdrGrGanvc4giZ7SaDAHx1QyQ/2Qo2//bqFhzFz1Rqp6ylHh/x55lupDf
         QhGPXpus9EEwJ63AXumBNCe6csgVrrmSx0UwRa+rtfCvlQEmho7qlKmvuCGUG0xSvdYj
         IkYg1PMYQfNXJ2kVE9SDumaFbXZ0dNS5WIewQCaAKrbtA9Sj/ZvnPM2rVtZ5rkrlIHXP
         E7c6oa/uQsG025SUP5ZVe9ScjRCcNQot/moJq5MedhQx4ARu7TQswRLWeM06q2ccdIch
         4mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709000835; x=1709605635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpQtl74gw/hNqeFlBJTt3cd3UkRyyWRIFg0ixYHJbjI=;
        b=gWfs44LsEwh7fxFTNioNIJJhecAqzACarC/WoWzz9gBZA8SM+Uz2Kg1/b2AK1AIrmp
         hD+LVRqoqPRfhFV0Azim+IwGHjWcVn/gi1K6B4cG/HqQiUqmdWLabzcQ3vW93qjragSz
         OrmXtE6mLtIdoVi53zwJ3R+GxrJNumE90Zdkjwq4c7c8Yjlrjt2Z0ufODxwxV8yQ7fkT
         7Qk4dkDt5RK+dX6d+tw0o0Gz/3fwLNVwXRcHerszLqVUwPCHmyFYa7+yN3fqHPozlO8V
         zePIwrjsqkQwbT3q/8b6i9AwD+NR1aHUGRGrza1QEFsxDUB1dRKGSOwn+xwSfEqJ7BJ1
         rI2w==
X-Forwarded-Encrypted: i=1; AJvYcCVcHPVM+rVh3Ne9JecsBfKsoxVBMjWdsm0VIUDcpJcFi3vgEuvWRr1G4KTYam4nyOPa+xLwoxsqLVY0lH4CaFN6YH76B2pVW76IbVtF
X-Gm-Message-State: AOJu0YysR7ZllKzQoFGm6LZLOVTnbH7X6wf9QNI0ewScVAffPBXl1Dmi
	OKXlgsRUOBLjxf8qGWXtU4OMINUQaJGDdNMLTYTWvRC2XwY5hYq6SgGyiM4Gi6JUEnnd3hF2zgd
	B1HJbYYLBWIIgk9mS7B8qga42s9YuHgoX3XyUzNZHKEotj4JXYd35nvI=
X-Google-Smtp-Source: AGHT+IEV6nYjUcy3iXvrh39zN0VkKae0r9fMIdFYgAli/kIPRZVyxM5GdJDfs09nLHB2przP2tIuAQ==
X-Received: by 2002:a17:90a:d597:b0:29a:b4c5:eba7 with SMTP id v23-20020a17090ad59700b0029ab4c5eba7mr6989156pju.0.1709000835126;
        Mon, 26 Feb 2024 18:27:15 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2ad-835c-ed53-0269-d508-76bd.emome-ip6.hinet.net. [2001:b400:e2ad:835c:ed53:269:d508:76bd])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a2e0600b0029681231ae1sm5234235pjd.28.2024.02.26.18.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 18:27:14 -0800 (PST)
From: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To: maz@kernel.org
Cc: oliver.upton@linux.dev,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sauravsc@amazon.com,
	eric.auger@redhat.com
Subject: Re: [PATCH 1/1] KVM: arm64: Affinity level 3 support
Date: Tue, 27 Feb 2024 10:27:08 +0800
Message-Id: <20240227022708.795214-1-r09922117@csie.ntu.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <86frxg3i6u.wl-maz@kernel.org>
References: <86frxg3i6u.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Sun, 25 Feb 2024 11:19:05 +0000,
Marc Zyngier <maz@kernel.org> wrote:
>
> [+Eric who was looking into something related recently]
> 
> Hi Wei-Lin,
> 
> Thanks for looking into this.
> 
> On Sun, 25 Feb 2024 09:02:37 +0000,
> Wei-Lin Chang <r09922117@csie.ntu.edu.tw> wrote:
> > 
> > Currently, KVM ARM64 avoids using the Aff3 field for VCPUs, which saves
> > us from having to check for hardware support in ICH_VTR_EL2.A3V or the
> 
> That's not strictly true. We do check for A3V support at restore time.
> 
> > guest's execution state. However a VCPU could still have its Aff3 bits
> > set to non-zero if the VMM directly changes the VCPU's MPIDR_EL1. This
> > causes a mismatch between MPIDR_EL1.Aff3 and GICR_TYPER[63:56] since 0s
> > are always returned for the latter, failing the GIC Redistributor
> > matching in the VM.
> > 
> > Let's fix this by only allowing userspace to write into the Aff3 field
> > of MPIDR_EL1 if Aff3 is valid.
> 
> What does "valid" means here? 0 *is* a valid value. Or do you mean a
> non-zero value? Also, this now creates a dependency between GICR_TYPER
> and MPIDR_EL1. How is userspace supposed to order those when restoring
> a VM?
> 
> > Additionally, extend reset_mpidr and
> > vgic_mmio_{read,write}_irouter to fully support Aff3. With theses
> > changes, GICR_TYPER can then safely return all four affinity levels.
> > 
> > Suggested-by: Saurav Sachidanand <sauravsc@amazon.com>
> > Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
> > ---
> >  arch/arm64/kvm/sys_regs.c          | 24 +++++++++++++++++++++---
> >  arch/arm64/kvm/vgic/vgic-debug.c   |  2 +-
> >  arch/arm64/kvm/vgic/vgic-mmio-v3.c | 18 +++++++++++-------
> >  include/kvm/arm_vgic.h             |  7 ++++++-
> >  4 files changed, 39 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 30253bd199..6694ce851a 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -239,6 +239,19 @@ static u8 get_min_cache_line_size(bool icache)
> >  	return field + 2;
> >  }
> >  
> > +static int set_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
> > +		   u64 val)
> > +{
> > +	bool aff3_valid = !vcpu_el1_is_32bit(vcpu) && kvm_vgic_has_a3v();
> 
> What does this mean for a guest that doesn't have a GICv3?
> 
> > +
> > +	if (!aff3_valid)
> > +		val &= ~((u64)MPIDR_LEVEL_MASK << MPIDR_LEVEL_SHIFT(3));
> > +
> > +	__vcpu_sys_reg(vcpu, rd->reg) = val;
> > +
> > +	return 0;
> > +}
> > +
> >  /* Which cache CCSIDR represents depends on CSSELR value. */
> >  static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
> >  {
> > @@ -817,10 +830,12 @@ static u64 reset_actlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> >  static u64 reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> >  {
> >  	u64 mpidr;
> > +	bool aff3_valid = !vcpu_el1_is_32bit(vcpu) && kvm_vgic_has_a3v();
> 
> Same thing.
> 
> >
> >  	/*
> > -	 * Map the vcpu_id into the first three affinity level fields of
> > -	 * the MPIDR. We limit the number of VCPUs in level 0 due to a
> > +	 * Map the vcpu_id into the affinity level fields of the MPIDR. The
> > +	 * fourth level is mapped only if we are running a 64 bit guest and
> > +	 * A3V is supported. We limit the number of VCPUs in level 0 due to a
> >  	 * limitation to 16 CPUs in that level in the ICC_SGIxR registers
> >  	 * of the GICv3 to be able to address each CPU directly when
> >  	 * sending IPIs.
> > @@ -828,6 +843,8 @@ static u64 reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> >  	mpidr = (vcpu->vcpu_id & 0x0f) << MPIDR_LEVEL_SHIFT(0);
> >  	mpidr |= ((vcpu->vcpu_id >> 4) & 0xff) << MPIDR_LEVEL_SHIFT(1);
> >  	mpidr |= ((vcpu->vcpu_id >> 12) & 0xff) << MPIDR_LEVEL_SHIFT(2);
> > +	if (aff3_valid)
> > +		mpidr |= (u64)((vcpu->vcpu_id >> 20) & 0xff) << MPIDR_LEVEL_SHIFT(3);
> 
> From virt/kcvm/kvm_main.c:
> 
> static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
> {
> 	int r;
> 	struct kvm_vcpu *vcpu;
> 	struct page *page;
> 
> 	if (id >= KVM_MAX_VCPU_IDS)
> 		return -EINVAL;
> 
>         [...]
> }
> 
> So vcpu_id is capped at KVM_MAX_VCPU_IDS, which is 512 on arm64. How
> does this ever produce anything other than 0? This is, by the way,
> already true for Aff2. Which is why I have always found this change
> extremely questionable: why do you need to describe 2^32 CPUs when you
> can only create 512?
> 
> >  	mpidr |= (1ULL << 31);
> >  	vcpu_write_sys_reg(vcpu, mpidr, MPIDR_EL1);
> >  
> > @@ -2232,7 +2249,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
> >  
> >  	{ SYS_DESC(SYS_DBGVCR32_EL2), trap_undef, reset_val, DBGVCR32_EL2, 0 },
> >  
> > -	{ SYS_DESC(SYS_MPIDR_EL1), NULL, reset_mpidr, MPIDR_EL1 },
> > +	{ SYS_DESC(SYS_MPIDR_EL1), NULL, reset_mpidr, MPIDR_EL1,
> > +	  .get_user = NULL, .set_user = set_mpidr },
> >  
> >  	/*
> >  	 * ID regs: all ID_SANITISED() entries here must have corresponding
> > diff --git a/arch/arm64/kvm/vgic/vgic-debug.c b/arch/arm64/kvm/vgic/vgic-debug.c
> > index 85606a531d..726cf1bd7b 100644
> > --- a/arch/arm64/kvm/vgic/vgic-debug.c
> > +++ b/arch/arm64/kvm/vgic/vgic-debug.c
> > @@ -206,7 +206,7 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
> >  		      "    %2d "
> >  		      "%d%d%d%d%d%d%d "
> >  		      "%8d "
> > -		      "%8x "
> > +		      "%8llx "
> >  		      " %2x "
> >  		      "%3d "
> >  		      "     %2d "
> > diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> > index c15ee1df03..ea0d4ad85a 100644
> > --- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> > +++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> > @@ -195,13 +195,13 @@ static unsigned long vgic_mmio_read_irouter(struct kvm_vcpu *vcpu,
> >  {
> >  	int intid = VGIC_ADDR_TO_INTID(addr, 64);
> >  	struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, NULL, intid);
> > +	bool aff3_valid = !vcpu_el1_is_32bit(vcpu) && kvm_vgic_has_a3v();
> 
> Hint: if you need to write the same expression more than once, you
> probably need a helper for it. Meaning that you will only have to fix
> it once.
> 
> >  	unsigned long ret = 0;
> >  
> >  	if (!irq)
> >  		return 0;
> >  
> > -	/* The upper word is RAZ for us. */
> > -	if (!(addr & 4))
> > +	if (aff3_valid || !(addr & 4))
> >  		ret = extract_bytes(READ_ONCE(irq->mpidr), addr & 7, len);
> >
> >  	vgic_put_irq(vcpu->kvm, irq);
> > @@ -213,11 +213,12 @@ static void vgic_mmio_write_irouter(struct kvm_vcpu *vcpu,
> >  				    unsigned long val)
> >  {
> >  	int intid = VGIC_ADDR_TO_INTID(addr, 64);
> > +	bool aff3_valid = !vcpu_el1_is_32bit(vcpu) && kvm_vgic_has_a3v();
> >  	struct vgic_irq *irq;
> >  	unsigned long flags;
> >  
> > -	/* The upper word is WI for us since we don't implement Aff3. */
> > -	if (addr & 4)
> > +	/* The upper word is WI if Aff3 is not valid. */
> > +	if (!aff3_valid && addr & 4)
> >  		return;
> >  
> >  	irq = vgic_get_irq(vcpu->kvm, NULL, intid);
> > @@ -227,8 +228,7 @@ static void vgic_mmio_write_irouter(struct kvm_vcpu *vcpu,
> >  
> >  	raw_spin_lock_irqsave(&irq->irq_lock, flags);
> >  
> > -	/* We only care about and preserve Aff0, Aff1 and Aff2. */
> > -	irq->mpidr = val & GENMASK(23, 0);
> > +	irq->mpidr = val & MPIDR_HWID_BITMASK;
> >  	irq->target_vcpu = kvm_mpidr_to_vcpu(vcpu->kvm, irq->mpidr);
> >  
> >  	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
> > @@ -323,7 +323,11 @@ static unsigned long vgic_mmio_read_v3r_typer(struct kvm_vcpu *vcpu,
> >  	int target_vcpu_id = vcpu->vcpu_id;
> >  	u64 value;
> >  
> > -	value = (u64)(mpidr & GENMASK(23, 0)) << 32;
> > +	value = MPIDR_AFFINITY_LEVEL(mpidr, 3) << 56 |
> > +		MPIDR_AFFINITY_LEVEL(mpidr, 2) << 48 |
> > +		MPIDR_AFFINITY_LEVEL(mpidr, 1) << 40 |
> > +		MPIDR_AFFINITY_LEVEL(mpidr, 0) << 32;
> 
> Maybe it is time to describe these shifts in an include file, and use
> FIELD_PREP() to construct the whole thing. It will be a lot more
> readable.
> 
> > +
> >  	value |= ((target_vcpu_id & 0xffff) << 8);
> >  
> >  	if (vgic_has_its(vcpu->kvm))
> > diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> > index 8cc38e836f..b464ac1b79 100644
> > --- a/include/kvm/arm_vgic.h
> > +++ b/include/kvm/arm_vgic.h
> > @@ -143,7 +143,7 @@ struct vgic_irq {
> >  	unsigned int host_irq;		/* linux irq corresponding to hwintid */
> >  	union {
> >  		u8 targets;			/* GICv2 target VCPUs mask */
> > -		u32 mpidr;			/* GICv3 target VCPU */
> > +		u64 mpidr;			/* GICv3 target VCPU */
> 
> Do we really need to grow each interrupt object by 4 bytes, specially
> when we at most use 4 bytes? I'd rather we store the affinity in a
> compact way and change the way we compare it to the vcpu's MPIDR_EL1.
> 
> >  	};
> >  	u8 source;			/* GICv2 SGIs only */
> >  	u8 active_source;		/* GICv2 SGIs only */
> > @@ -413,6 +413,11 @@ static inline int kvm_vgic_get_max_vcpus(void)
> >  	return kvm_vgic_global_state.max_gic_vcpus;
> >  }
> >  
> > +static inline bool kvm_vgic_has_a3v(void)
> > +{
> > +	return kvm_vgic_global_state.ich_vtr_el2 & ICH_VTR_A3V_MASK;
> > +}
> > +
> 
> I can see multiple problems with this:
> 
> - this is the host state, which shouldn't necessarily represent the
>   guest state. It should be possible to restore a VM that have a
>   different A3V value and still have the same guarantees.  There is
>   however a small nit around ICV_CTLR_EL1.A3V, which would require
>   trapping to emulate the A3V bit.
> 
> - this assumes GICv3, which is definitely not universal (we support
>   GICv2, for which no such restriction actually exists).
> 
> Finally, I don't see VM save/restore being addressed here, and I
> suspect it hasn't been looked at.
> 
> Overall, this patch does too many things, and it should be split in
> discrete changes. I also want to see an actual justification for Aff3
> support. And if we introduce it, it must be fully virtualised
> (independent of the A3V support on the host).

Hi Marc,

Really appreciate for the feedback. I think I understand most of your
comments and agree with them. It appears that I don't fully understand
the changes that I am doing with this. Thanks for explaining.

Cheers,
Wei-Lin Chang

