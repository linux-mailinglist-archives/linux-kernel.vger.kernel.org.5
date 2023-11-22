Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3E37F4501
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbjKVLkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343800AbjKVLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:40:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A0EED4A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:40:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5D531595;
        Wed, 22 Nov 2023 03:41:05 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.43.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED7423F7A6;
        Wed, 22 Nov 2023 03:40:16 -0800 (PST)
Date:   Wed, 22 Nov 2023 11:40:09 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Huang Shijie <shijie@os.amperecomputing.com>,
        catalin.marinas@arm.com, suzuki.poulose@arm.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        robh@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
        patches@amperecomputing.com
Subject: Re: [PATCH 0/4] arm64: an optimization for AmpereOne
Message-ID: <ZV3omRGtVS9l-tKk@FVFF77S0Q05N>
References: <20231122092855.4440-1-shijie@os.amperecomputing.com>
 <20231122094857.GA2959@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122094857.GA2959@willie-the-truck>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:48:57AM +0000, Will Deacon wrote:
> On Wed, Nov 22, 2023 at 05:28:51PM +0800, Huang Shijie wrote:
> > 0) Background:
> >    We found that AmpereOne benefits from aggressive prefetches when
> >    using 4K page size.
> 
> We tend to shy away from micro-architecture specific optimisations in
> the arm64 kernel as they're pretty unmaintainable, hard to test properly,
> generally lead to bloat and add additional obstacles to updating our
> library routines.
> 
> Admittedly, we have something for Thunder-X1 in copy_page() (disguised
> as ARM64_HAS_NO_HW_PREFETCH) but, frankly, that machine needed all the
> help it could get and given where it is today I suspect we could drop
> that code without any material consequences.
> 
> So I'd really prefer not to merge this; modern CPUs should do better at
> copying data. It's copy_to_user(), not rocket science.

I agree, and I'd also like to drop ARM64_HAS_NO_HW_PREFETCH.

Mark.
