Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1767C70BF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376381AbjJLOxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjJLOw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:52:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59B4C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:52:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC7CC433C7;
        Thu, 12 Oct 2023 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697122375;
        bh=IYDm8ofYKOZAFbxQa32MHYpNBNA79HhiV1G9gyxN4IQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVnBLfyrM0aoLkeHm29EX0fPCHIKaXsix+jYVpXjcHwoD7xcD0ZAM4ePIeH3yU/nD
         7yTfYPhRsbMS1Z3U2ReHBjOxva0twYJOmkJ/Tl6SjS3UbEmLX0VZznvXCE1E7FYoce
         L5F/CHl8HjKMXjx0V/xYH23HX3iR6Xg4RN928MsGT6hzzWnszfyJ1Qqv4RdtP8/A6Z
         r4KKIp/Ouw7+MS75BHr8TGm6NhdiW96up4OgOQhbZ84qzAsGjaLLs4VJZQQ4TU6EEW
         B+4CVRtgTCiBDpgvzM7Abf8cjcNXUQRF+0x+NkdYmUAa+IrcfkiBPg7GahJs80WXmp
         hTjR0Ulm1rJ1A==
Date:   Thu, 12 Oct 2023 22:40:46 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] riscv: errata: thead: use riscv_nonstd_cache_ops
 for CMO
Message-ID: <ZSgFbuD203L0XL4J@xhacker>
References: <20231012141456.4078-1-jszhang@kernel.org>
 <ZSgA1BtMv/YDHzQX@xhacker>
 <20231012-remindful-coke-f9cfe950425f@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231012-remindful-coke-f9cfe950425f@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 03:36:28PM +0100, Conor Dooley wrote:
> On Thu, Oct 12, 2023 at 10:21:08PM +0800, Jisheng Zhang wrote:
> > On Thu, Oct 12, 2023 at 10:14:54PM +0800, Jisheng Zhang wrote:
> > > Previously, we use alternative mechanism to dynamically patch
> > > the CMO operations for THEAD C906/C910 during boot for performance
> > > reason. But as pointed out by Arnd, "there is already a significant
> > > cost in accessing the invalidated cache lines afterwards, which is
> > > likely going to be much higher than the cost of an indirect branch".
> > > And indeed, there's no performance difference with GMAC and EMMC per
> > > my test on Sipeed Lichee Pi 4A board.
> > > 
> > > Use riscv_nonstd_cache_ops for THEAD C906/C910 CMO to simplify
> > > the alternative code, and to acchieve Arnd's goal -- "I think
> > > moving the THEAD ops at the same level as all nonstandard operations
> > > makes sense, but I'd still leave CMO as an explicit fast path that
> > > avoids the indirect branch. This seems like the right thing to do both
> > > for readability and for platforms on which the indirect branch has a
> > > noticeable overhead."
> > > 
> > > To make bisect easy, I use two patches here: patch1 does the conversion
> > > which just mimics current CMO behavior via. riscv_nonstd_cache_ops, I
> > > assume no functionalities changes. patch2 uses T-HEAD PA based CMO
> > > instructions so that we don't need to covert PA to VA.
> > > 
> > > Hi Guo,
> > > 
> > > I didn't use wback_inv for wback as you suggested during v1 reviewing,
> > > this can be left as future optimizations.
> > > 
> > > Thanks
> > > 
> > > since v2:
> > >   - collect Reviewed-by tag
> > 
> > Oh, I missed the tag collection, but I know maintainers are using b4 which can
> > collect and apply tags automatically ;). let me know if want a new
> > version.
> 
> It doesn't collect tags (AFAIU) from earlier revisions though.

oops I didn't know this before, just sent out v4 with real tag collection to
make the merging progress smooth.
