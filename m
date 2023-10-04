Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC97B80BB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbjJDNWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242622AbjJDNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:22:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29D9398
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:22:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E2C2DA7;
        Wed,  4 Oct 2023 06:23:07 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B7B83F59C;
        Wed,  4 Oct 2023 06:22:27 -0700 (PDT)
Date:   Wed, 4 Oct 2023 14:22:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v3 14/17] KVM: arm64: FFA: Remove access of endpoint
 memory access descriptor array
Message-ID: <ZR1lGOUNyr77qtGp@bogus>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
 <20230929-ffa_v1-1_notif-v3-14-c8e4f15190c8@arm.com>
 <86leciog2w.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86leciog2w.wl-maz@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:08:23AM +0100, Marc Zyngier wrote:
> On Fri, 29 Sep 2023 16:03:03 +0100,
> Sudeep Holla <sudeep.holla@arm.com> wrote:
> > 
> > FF-A v1.1 removes the fixed location of endpoint memory access descriptor
> > array within the memory transaction descriptor structure. In preparation
> > to remove the ep_mem_access member from the ffa_mem_region structure,
> > provide the accessor to fetch the offset and use the same in FF-A proxy
> > implementation.
> > 
> > The accessor take the boolean argument that indicates if the memory access
> > descriptor versions is v1(old format) or not. Currently it is set true as
> > FF-A proxy supports only v1.0
> > 
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Oliver Upton <oliver.upton@linux.dev>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Quentin Perret <qperret@google.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/ffa.c | 8 ++++++--
> >  include/linux/arm_ffa.h       | 6 ++++++
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > index 6e4dba9eadef..5f956f53e6bf 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > @@ -423,6 +423,7 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
> >  	DECLARE_REG(u32, fraglen, ctxt, 2);
> >  	DECLARE_REG(u64, addr_mbz, ctxt, 3);
> >  	DECLARE_REG(u32, npages_mbz, ctxt, 4);
> > +	struct ffa_mem_region_attributes *ep_mem_access;
> >  	struct ffa_composite_mem_region *reg;
> >  	struct ffa_mem_region *buf;
> >  	u32 offset, nr_ranges;
> > @@ -452,7 +453,8 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
> >  	buf = hyp_buffers.tx;
> >  	memcpy(buf, host_buffers.tx, fraglen);
> >  
> > -	offset = buf->ep_mem_access[0].composite_off;
> > +	ep_mem_access = (void *)buf + ffa_mem_desc_offset(buf, 0, true);
> > +	offset = ep_mem_access->composite_off;
> >  	if (!offset || buf->ep_count != 1 || buf->sender_id != HOST_FFA_ID) {
> >  		ret = FFA_RET_INVALID_PARAMETERS;
> >  		goto out_unlock;
> > @@ -504,6 +506,7 @@ static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
> >  	DECLARE_REG(u32, handle_lo, ctxt, 1);
> >  	DECLARE_REG(u32, handle_hi, ctxt, 2);
> >  	DECLARE_REG(u32, flags, ctxt, 3);
> > +	struct ffa_mem_region_attributes *ep_mem_access;
> >  	struct ffa_composite_mem_region *reg;
> >  	u32 offset, len, fraglen, fragoff;
> >  	struct ffa_mem_region *buf;
> > @@ -528,7 +531,8 @@ static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
> >  	len = res->a1;
> >  	fraglen = res->a2;
> >  
> > -	offset = buf->ep_mem_access[0].composite_off;
> > +	ep_mem_access = (void *)buf + ffa_mem_desc_offset(buf, 0, true);
> > +	offset = ep_mem_access->composite_off;
> >  	/*
> >  	 * We can trust the SPMD to get this right, but let's at least
> >  	 * check that we end up with something that doesn't look _completely_
> > diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> > index 748d0a83a4bc..7be240e37f36 100644
> > --- a/include/linux/arm_ffa.h
> > +++ b/include/linux/arm_ffa.h
> > @@ -357,6 +357,12 @@ struct ffa_mem_region {
> >  #define CONSTITUENTS_OFFSET(x)	\
> >  	(offsetof(struct ffa_composite_mem_region, constituents[x]))
> >  
> > +static inline u32
> > +ffa_mem_desc_offset(struct ffa_mem_region *buf, int count, bool mem_desc_v1)
> > +{
> > +	return COMPOSITE_OFFSET(0);
> > +}
> 
> If the goal of this patch is to introduce some versioning, why not
> define this last parameter as an actual version number, PSCI style
> (with a minor and major, each on a 16bit field)?
> 

Fair enough. I am being optimistic that the memory descriptor format doesn't
change with each FF-A version. And the v2 of the memory descriptor format is
quite flexible to provide backward compatibility for some time(I agree that
is controversial :))

> Even the name is pretty misleading, as both FFA versions are v1 (v1.0
> vs v1.1...).
>

I was referring to the memory descriptor format version. The intention was
to keep it separate from the FF-A version. But if using FF-A version makes
things simpler I can go for that.

-- 
Regards,
Sudeep
