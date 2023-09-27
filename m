Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329ED7AFE63
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjI0I25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjI0I23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:28:29 -0400
Received: from out-199.mta1.migadu.com (out-199.mta1.migadu.com [95.215.58.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4D0180
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:28:27 -0700 (PDT)
Date:   Wed, 27 Sep 2023 08:28:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695803306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JsXW76YQkWWd3KcbYHc5LUjz+hl6N7YHm4uh3HGSGpg=;
        b=LtQiyZ0uGVb8Rv3QD8dC2/G/zWWQ27meJIFYdXmORPcx9sijsUdn9u4ERK8b39FP/ukuy8
        BCwdmxf2jvUydfPuh8l4+/VfBqpgi+cJEQg26cLsFreEJdOvIXD9YkQ4iqFwAnVgrLYM+Y
        LbqEHZKO/CXJnfFtvt7NvdbReUkAVB4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: arm64: Add handler for MOPS exceptions
Message-ID: <ZRPnpHwiRhrYwfSM@linux.dev>
References: <20230922112508.1774352-1-kristina.martsenko@arm.com>
 <20230922112508.1774352-2-kristina.martsenko@arm.com>
 <87sf734ofv.wl-maz@kernel.org>
 <9f731870-ed36-d2e4-378b-f7fbf338ebd6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f731870-ed36-d2e4-378b-f7fbf338ebd6@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 04:16:06PM +0100, Kristina Martsenko wrote:

[...]

> > What is the rationale for advancing the state machine? Shouldn't we
> > instead return to the guest and immediately get the SS exception,
> > which in turn gets reported to userspace? Is it because we rollback
> > the PC to a previous instruction?
> 
> Yes, because we rollback the PC to the prologue instruction. We advance the
> state machine so that the SS exception is taken immediately upon returning to
> the guest at the prologue instruction. If we didn't advance it then we would
> return to the guest, execute the prologue instruction, and then take the SS
> exception on the middle instruction. Which would be surprising as userspace
> would see the middle and epilogue instructions executed multiple times but not
> the prologue.

I agree with Kristina that taking the SS exception on the prologue is
likely the best course of action. Especially since it matches the
behavior of single-stepping an EL0 MOPS sequence with an intervening CPU
migration.

This behavior might throw an EL1 that single-steps itself for a loop,
but I think it is impossible for a hypervisor to hide the consequences
of vCPU migration with MOPS in the first place.

Marc, I'm guessing you were most concerned about the former case where
the VMM was debugging the guest. Is there something you're concerned
about I missed?

-- 
Thanks,
Oliver
