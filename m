Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3DA8110D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjLMMQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjLMMQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:16:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AE3D5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:16:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0788C433C7;
        Wed, 13 Dec 2023 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702469771;
        bh=FqzyTNak1M7GLTbKygDFdAG7bdZ6TRCmwCyv2gpQrOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IjhFz/VDOcVnE8XbtuP1EplU8kstgfiHicAUzy5nobzNK6FfAm/SnCfdqRdlBPeEn
         C0THqgjPppFmPbKOy3mzvlpsD1eAoK+nsYyOzjCx/Sw4NXgLRniP6MWXY2BhwUBmWM
         gJ5fJRWhNs1MqorUbu4GvbU4sNVXsL/bYOlr8S5weu2reRwk2g0uUCpVpJdZVjHwTH
         t9xUvdq/BzFsoSBEytRcOb26LDud0Dn5R2vJrhJlr47V3nTBUIYHxvTjE9HAte1ppc
         GC4f7dy7xJmxnFnLldw3XVzuTYXPY8CCrbWaK122BJSnF+zast3r36vWOPMBjIte7s
         A19QhL9Ib7yIA==
Date:   Wed, 13 Dec 2023 12:16:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Alexander Potapenko <glider@google.com>, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, alexandru.elisei@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v9 1/4] arm64: mte: implement CONFIG_ARM64_MTE_COMP
Message-ID: <20231213121605.GB31326@willie-the-truck>
References: <20231113105234.32058-1-glider@google.com>
 <20231113105234.32058-2-glider@google.com>
 <ZXiVX5FAWZqHfr7m@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXiVX5FAWZqHfr7m@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 05:16:15PM +0000, Catalin Marinas wrote:
> On Mon, Nov 13, 2023 at 11:52:30AM +0100, Alexander Potapenko wrote:
> > The config implements the algorithm compressing memory tags for ARM MTE
> > during swapping.
> > 
> > The algorithm is based on RLE and specifically targets buffers of tags
> > corresponding to a single page. In many cases a buffer can be compressed
> > into 63 bits, making it possible to store it without additional memory
> > allocation.
> > 
> > Suggested-by: Evgenii Stepanov <eugenis@google.com>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> > +void mte_tags_to_ranges(u8 *tags, u8 *out_tags, unsigned short *out_sizes,
> > +			size_t *out_len)
> > +{
> [...]
> > +}
> > +EXPORT_SYMBOL_NS(mte_tags_to_ranges, MTECOMP);
> 
> I may have asked before, what the reason for EXPORT_SYMBOL_NS? Is it for
> the kunit tests? Otherwise we don't expect those to be accessed from
> modules.

It looks like it. The Kconfig option for the test is tristate and it calls
this symbol directly.

Will
