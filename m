Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38624777DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbjHJQKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbjHJQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:10:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B1447C3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B630C6628F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01839C433C8;
        Thu, 10 Aug 2023 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691683753;
        bh=saMmtusOIsagPogxdymebzcBm3pARqxzjSu/RHEAiCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=up1xr1m+hF5etTJeL6VYIsO3scvWhwZ2xdd7+I0wQF9Ze0Zt5ONPUwScxALs48aIF
         DaLuVPnlM5wuvS1+6vYZAOsOWn5c30CJWp9hTEu43BPzModJcE/HurfFAQ+MxPktl0
         rmql98mcyxWel4+FyUjhthQg3M0kL3JWOlH2SDGZyuJoGR3VVpcAIPn5j806fpNhOD
         AguUP6NLKdDCUE+NSPeTThVPP5mwQ3ZH88NycHa4AigfXRjfy5NMVpcZbSWn9aykxn
         p/SBQQ3QqfOYoezPH8g5rslC2/Smm3YAFE/OLEHLqvwIT6NIt8wxw7Ho9OPfvnTdhI
         OZFBP3x/X8jrg==
Date:   Thu, 10 Aug 2023 17:09:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Xiaobing Shi =?utf-8?B?KOWPsuWwj+WFtSk=?= 
        <Xiaobing.Shi@mediatek.com>,
        Chunhui Li =?utf-8?B?KOadjuaYpei+iSk=?= 
        <chunhui.li@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BUG kernel-5.15] aarch64: __pi_strncmp() out-of-bound error
Message-ID: <20230810160907.GA5951@willie-the-truck>
References: <e9f30f7d5b7d72a3521da31ab2002b49a26f542e.camel@mediatek.com>
 <ZNEOmRb2sYQlVYwj@FVFF77S0Q05N.cambridge.arm.com>
 <729b1505-c466-8a71-6079-4b0d9f81731d@arm.com>
 <20230810143118.GA5795@willie-the-truck>
 <10095b14-c005-c791-7e3e-d6561dac4dec@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10095b14-c005-c791-7e3e-d6561dac4dec@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 04:00:00PM +0100, Robin Murphy wrote:
> On 10/08/2023 3:31 pm, Will Deacon wrote:
> > On Thu, Aug 10, 2023 at 01:23:28PM +0100, Robin Murphy wrote:
> > > I'm not sure there's strictly a bug here. The C standard says:
> > > 
> > > "The strncmp function compares not more than n characters (characters that
> > > follow a null character are not compared) ..."
> > > 
> > > so although any characters between the first NULL and n must not be
> > > considered for the result of the comparison, there doesn't seem to be any
> > > explicit promise anywhere that they can't be *accessed*. AFAICT what happens
> > > here is in the request to compare at most 23 characters, it ends up in the
> > > do_misaligned case, loop_misaligned runs twice and finds no differences or
> > > NULLs in characters 0-7 and 8-15, so then done_loop loads characters 15-23
> > > to compare the last 7, and is tripped up by 22-23 not actually existing in
> > > src2. Possibly the original intent was that this case should have ended up
> > > in page_end_loop, and the condition for that was slightly off, but I'm not
> > > sure, and this code is obsolete now anyway.
> > 
> > The long backtrace above worries me, as it suggests that you can trigger
> > this from userspace. In that case I think it's a bug regardless of what
> > the C standard says.
> 
> Bleh, poor choice of words... obviously there is a bug overall, it just
> might arguably be in the caller's expectations rather than the strncmp()
> implementation itself. However I would concur that there's no way we're
> going over all ~3000 strncmp() callsites with the "well, actually" comb just
> for this. It was more to say I don't think it's worth digging much deeper
> into exactly why, and I agree the pragmatic thing to do is either rip it out
> or backport the newer MTE-safe implementation which should be more robust.

Heh, then we agree. I was worried you'd gone mad :)

Will
