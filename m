Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35F87705CD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjHDQU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHDQU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:20:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87032D71
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E95A620A1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABF9C433C7;
        Fri,  4 Aug 2023 16:20:23 +0000 (UTC)
Date:   Fri, 4 Aug 2023 17:20:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/fpsimd: Only provide the length to cpufeature
 for xCR registers
Message-ID: <ZM0lRWTAE/b88V6U@arm.com>
References: <20230731-arm64-sme-fa64-hotplug-v2-1-7714c00dd902@kernel.org>
 <ZMvYSmpCfFQ2+m7q@arm.com>
 <3ccab5cb-9d19-40a2-ae9c-99d37996da9c@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ccab5cb-9d19-40a2-ae9c-99d37996da9c@sirena.org.uk>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 06:44:24PM +0100, Mark Brown wrote:
> On Thu, Aug 03, 2023 at 05:39:38PM +0100, Catalin Marinas wrote:
> > On Mon, Jul 31, 2023 at 02:58:48PM +0100, Mark Brown wrote:
> > > Since the only field we are interested in having the cpufeature code
> > > handle is the length field and we use a custom read function to obtain
> > > the value we can avoid these warnings by filtering out all other bits
> > > when we return the register value, if we're doing that we don't need to
> > > bother reading the register at all and can simply use the RDVL/RDSVL
> > > value we were filling in instead.
> 
> > Maybe that's the simplest fix, especially if you want it in stable, but
> 
> Yeah, it's definitely the sort of change we want as a fix - anything
> more invasive would be inappropriate.

I'd say it's still ok if we can just rip come code out safely (the fake
ID reg).

> > I wonder why we even bother with with treating ZCR_EL1 and SMCR_EL1 as
> > feature registers. We already have verify_sme_features() to check for
> > the mismatch. BTW, is vec_verify_vq_map() sufficient so that we can skip
> > the maximum vector length check?
> 
> Both enumeration mechanisms were added in the initial series supporting
> SVE for reasons that are not entirely obvious to me.  The changelogs
> explain what we're doing with the pseudo ID register stuff but do not
> comment on why.  There is a cross check between the answers the two give
> which appears to be geared towards detecting systems with asymmetric
> maximum VLs for some reason but I'm not sure why that's done given that
> we can't cope if *any* VL in the committed set is missing, not just the
> maximum.

We can cope with different VLs if the committed map is built during boot
(early secondary CPU bring-up). For any late/hotplugged CPUs, if they
don't fit the map, they'll be rejected. Not sure where the actual
maximum length matters in this process though (or later for user space).
I assume the user will only be allowed to set the common VLs across all
the early CPUs.

> The whole thing is very suspect but given that we don't currently have
> any ability to emulate systems with asymmetric vector lengths I'm a bit
> reluctant to poke at it.

The Arm fast models should allow such configuration, though I haven't
tried.

-- 
Catalin
