Return-Path: <linux-kernel+bounces-25921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D83E182D84E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B85C1F22266
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC3E2C689;
	Mon, 15 Jan 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McgEaJNp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C9DF4C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 11:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4A9C433C7;
	Mon, 15 Jan 2024 11:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705318105;
	bh=h5IJpMjZyx3Hv96LPVu1lr+n0HvSatz0eWIAf4u7zWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=McgEaJNpYAqBZQ1UROvwQP8n6TV7E2wwkv+CKdS05NHvexCD52F/dXO9sdey/SJqh
	 3+rh35Cz0ev4gCNLJHfgf2pbwtjvcQlEKa7IFJUfd9afCzTJUjaLgvbdt3H1t8+slf
	 g8tEe82d28bHd4vdY9w260XPaMMSHjLjpEYRMGlN5vb9fXNDW0S2AIKDyiPQATuwsI
	 8nYLM9+kLXUtKW+OKH2aZRQ+Eckq8hwzGmYwtAwH3O4oz+1M/8+r7KkC8Lgn4vBv8i
	 jYBulu7M0RDFvEYugY1UQ+RlPywpWeHoYNvpyloGkekYuife1N5n+uoae4kQ7aP3IH
	 fCaul4Tq7mWsA==
Date: Mon, 15 Jan 2024 12:28:20 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip/gic-v3-its: Handle non-coherent GICv4
 redistributors
Message-ID: <ZaUW1Oo9RRKamhMb@lpieralisi>
References: <20240114124429.2433890-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114124429.2433890-1-maz@kernel.org>

On Sun, Jan 14, 2024 at 12:44:29PM +0000, Marc Zyngier wrote:
> Although the GICv3 code base has gained some handling of systems
> failing to handle the shareability attributes, the GICv4 side of
> things has been firmly ignored.
> 
> This is unfortunate, as the new recent addition of the
> "dma-noncoherent" is supposed to apply to all of the GICR tables,
> and not just the ones that are common to v3 and v4.
> 
> Add some checks to handle the VPROPBASE/VPENDBASE shareability
> and cacheability attributes in the same way we deal with the
> other GICR_BASE registers, wrapping the flag check in a helper
> for improved readability.
> 
> Note that this has been found by inspection only, as I don't
> have access to HW that suffers from this particular issue.
> 
> Fixes: 3a0fff0fb6a3 ("irqchip/gic-v3: Enable non-coherent redistributors/ITSes DT probing")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 37 +++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 12 deletions(-)

I missed this, sorry - the bug reports we got were for HW platforms
where the v4 side of things would not apply but the Fixes commit above
is generic and it must have included this hunk, so apologies.

FWIW:

Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 9a7a74239eab..bdc2c8330479 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -207,6 +207,11 @@ static bool require_its_list_vmovp(struct its_vm *vm, struct its_node *its)
>  	return (gic_rdists->has_rvpeid || vm->vlpi_count[its->list_nr]);
>  }
>  
> +static bool rdists_support_shareable(void)
> +{
> +	return !(gic_rdists->flags & RDIST_FLAGS_FORCE_NON_SHAREABLE);
> +}
> +
>  static u16 get_its_list(struct its_vm *vm)
>  {
>  	struct its_node *its;
> @@ -2710,10 +2715,12 @@ static u64 inherit_vpe_l1_table_from_its(void)
>  			break;
>  		}
>  		val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR, addr >> 12);
> -		val |= FIELD_PREP(GICR_VPROPBASER_SHAREABILITY_MASK,
> -				  FIELD_GET(GITS_BASER_SHAREABILITY_MASK, baser));
> -		val |= FIELD_PREP(GICR_VPROPBASER_INNER_CACHEABILITY_MASK,
> -				  FIELD_GET(GITS_BASER_INNER_CACHEABILITY_MASK, baser));
> +		if (rdists_support_shareable()) {
> +			val |= FIELD_PREP(GICR_VPROPBASER_SHAREABILITY_MASK,
> +					  FIELD_GET(GITS_BASER_SHAREABILITY_MASK, baser));
> +			val |= FIELD_PREP(GICR_VPROPBASER_INNER_CACHEABILITY_MASK,
> +					  FIELD_GET(GITS_BASER_INNER_CACHEABILITY_MASK, baser));
> +		}
>  		val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, GITS_BASER_NR_PAGES(baser) - 1);
>  
>  		return val;
> @@ -2936,8 +2943,10 @@ static int allocate_vpe_l1_table(void)
>  	WARN_ON(!IS_ALIGNED(pa, psz));
>  
>  	val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR, pa >> 12);
> -	val |= GICR_VPROPBASER_RaWb;
> -	val |= GICR_VPROPBASER_InnerShareable;
> +	if (rdists_support_shareable()) {
> +		val |= GICR_VPROPBASER_RaWb;
> +		val |= GICR_VPROPBASER_InnerShareable;
> +	}
>  	val |= GICR_VPROPBASER_4_1_Z;
>  	val |= GICR_VPROPBASER_4_1_VALID;
>  
> @@ -3126,7 +3135,7 @@ static void its_cpu_init_lpis(void)
>  	gicr_write_propbaser(val, rbase + GICR_PROPBASER);
>  	tmp = gicr_read_propbaser(rbase + GICR_PROPBASER);
>  
> -	if (gic_rdists->flags & RDIST_FLAGS_FORCE_NON_SHAREABLE)
> +	if (!rdists_support_shareable())
>  		tmp &= ~GICR_PROPBASER_SHAREABILITY_MASK;
>  
>  	if ((tmp ^ val) & GICR_PROPBASER_SHAREABILITY_MASK) {
> @@ -3153,7 +3162,7 @@ static void its_cpu_init_lpis(void)
>  	gicr_write_pendbaser(val, rbase + GICR_PENDBASER);
>  	tmp = gicr_read_pendbaser(rbase + GICR_PENDBASER);
>  
> -	if (gic_rdists->flags & RDIST_FLAGS_FORCE_NON_SHAREABLE)
> +	if (!rdists_support_shareable())
>  		tmp &= ~GICR_PENDBASER_SHAREABILITY_MASK;
>  
>  	if (!(tmp & GICR_PENDBASER_SHAREABILITY_MASK)) {
> @@ -3880,14 +3889,18 @@ static void its_vpe_schedule(struct its_vpe *vpe)
>  	val  = virt_to_phys(page_address(vpe->its_vm->vprop_page)) &
>  		GENMASK_ULL(51, 12);
>  	val |= (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
> -	val |= GICR_VPROPBASER_RaWb;
> -	val |= GICR_VPROPBASER_InnerShareable;
> +	if (rdists_support_shareable()) {
> +		val |= GICR_VPROPBASER_RaWb;
> +		val |= GICR_VPROPBASER_InnerShareable;
> +	}
>  	gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
>  
>  	val  = virt_to_phys(page_address(vpe->vpt_page)) &
>  		GENMASK_ULL(51, 16);
> -	val |= GICR_VPENDBASER_RaWaWb;
> -	val |= GICR_VPENDBASER_InnerShareable;
> +	if (rdists_support_shareable()) {
> +		val |= GICR_VPENDBASER_RaWaWb;
> +		val |= GICR_VPENDBASER_InnerShareable;
> +	}
>  	/*
>  	 * There is no good way of finding out if the pending table is
>  	 * empty as we can race against the doorbell interrupt very
> -- 
> 2.39.2
> 

