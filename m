Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BD27CE897
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjJRUQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJRUQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:16:15 -0400
Received: from out-210.mta0.migadu.com (out-210.mta0.migadu.com [91.218.175.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262B39F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:16:13 -0700 (PDT)
Date:   Wed, 18 Oct 2023 20:16:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697660171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fPLtuTGYTVo4UUno2md5tw86cZhr4lZbco5YHPP43Ik=;
        b=NIktaay0bmmzF0xiaPTkjKBpVM4aV3yO9O44h5w18vBYh3t+220YuGPv4XiR3saxv4EKB5
        0jIuZ7uoKSKvI62Mw8ElXy/5rZKcFnYwLQdMDVjiONKHyU1omjx8gr6cpn8vBjrEs1BmwN
        39ebQuOiwHGSOwPeXqy0v9w4FnSGpps=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Independently update HDFGRTR_EL2 and HDFGWTR_EL2
Message-ID: <ZTA9BlmagUv1teh7@linux.dev>
References: <20231018030007.1968317-1-anshuman.khandual@arm.com>
 <86r0lsm7cq.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86r0lsm7cq.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:40:37PM +0100, Marc Zyngier wrote:
> On Wed, 18 Oct 2023 04:00:07 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> > 
> > Currently PMSNEVFR_EL1 system register read, and write access EL2 traps are
> > disabled, via setting the same bit (i.e 62) in HDFGRTR_EL2, and HDFGWTR_EL2
> > respectively. Although very similar, bit fields are not exact same in these
> > two EL2 trap configure registers particularly when it comes to read-only or
> > write-only accesses such as ready-only 'HDFGRTR_EL2.nBRBIDR' which needs to
> > be set while enabling BRBE on NVHE platforms. Using the exact same bit mask
> > fields for both these trap register risk writing into their RESERVED areas,
> > which is undesirable.
> 
> Sorry, I don't understand at all what you are describing. You seem to
> imply that the read and write effects of the FGT doesn't apply the
> same way. But my reading of the ARM ARM is that  behave completely
> symmetrically.

nBRBIDR is an asymmetric bit (bit 59 of HDFGWTR_EL2 is RES0). While the
architecture *could* repurpose this WTR bit for something else, that
feels rather implementation and software hostile. I don't think there's
a practical issue here, especially since the architecture has already
allocated another pair of debug trap registers to make room for more
bits.

> So what has changed here, aside from clobbering an extra register? The
> masks are the same, the initial values are the same... Is it in
> preparation for some other work?

Yeah, it feels as though this patch is taken out of context. Without a
justifying functional change I don't see the value in fiddling with this
code.

-- 
Thanks,
Oliver
