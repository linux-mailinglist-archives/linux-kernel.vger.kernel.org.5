Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D8077A07F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbjHLObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjHLOba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:31:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FA8C3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 07:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E6BC60BEA
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 14:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6195CC433C7;
        Sat, 12 Aug 2023 14:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691850692;
        bh=y6AJiNEbhNK+QaioOtFjtpe/0LpQ8n1L1c/K9pzA1Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nrB/q6aZl4CHe0AN6pFXD4AI+9X+wDhNbqhoyAbzu2IsClyz/ZCT8StauSGq0J30Z
         ux+iPjeYCrsMHiIjgBE1O06VBz5K2D4W/6KzAO3wN2dbYfvt+8RZhiIXHmYDT4WbV2
         HFQ5WQY9ZWNDE3HJRhdCGe6sqdCEp6cLnmiiq7RteL9UTYKspCdOGXNuMMjL/vJnPs
         hP5E/eJxL5xyKt1RB2YCvmV/yXKfbMGYDcGj3B79gNjfKhOAjqBTyB7AhhTL71uvji
         FqEIZr72i+k3ZGQ0zOSkh59o5h94NNRfUI0cwxcmt9V7Y/oZEncC3Jeu4s7B9LRr3R
         rR0xAF75mPkNQ==
Date:   Sat, 12 Aug 2023 07:31:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: Hang when booting guest kernels compiled with clang after SRSO
 mitigations
Message-ID: <20230812143130.GA3494185@dev-arch.thelio-3990X>
References: <20230810150706.GA42856@dev-arch.thelio-3990X>
 <20230810151410.GNZNT+wn/cLBWiU6dO@fat_crate.local>
 <20230810154831.GA38495@dev-arch.thelio-3990X>
 <20230810161414.GA4000@dev-arch.thelio-3990X>
 <20230811101456.GDZNYKIHs1k7ri8hrI@fat_crate.local>
 <20230811140941.GB193223@dev-arch.thelio-3990X>
 <ZNZbxhL5ZJD1Sd9P@google.com>
 <20230811161225.GIZNZd6QfLUoZv9TLO@fat_crate.local>
 <CAKwvOdmejxO=_KBuw1WZGgh=MXNNbfWH03TpEFO47vkKWq04Cg@mail.gmail.com>
 <20230812134642.GGZNeNQpebzu3H3NDh@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812134642.GGZNeNQpebzu3H3NDh@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 03:46:42PM +0200, Borislav Petkov wrote:
> Btw, this:
> 
> https://github.com/ClangBuiltLinux/linux/commit/150c42407f87463c27a2459e06845965291d9973
> 
> Is this fixing a current issue and so it needs to go to Linus now?
> 
> If so, I'll expedite it too.

Yes, that fixes an error at link time when building with LTO:

https://github.com/ClangBuiltLinux/linux/issues/1909

That is commit 973ab2d61f33 ("x86/retpoline,kprobes: Fix position of
thunk sections with CONFIG_LTO_CLANG") in x86/core, with the conflicts
against SRSO resolved and the fix that Andrew Cooper pointed out
squashed in, in case my comment in the commit message was not clear
enough :)

https://lore.kernel.org/lkml/20230803230323.1478869-1-andrew.cooper3@citrix.com/

With that change and the other ld.lld change you already picked up in
x86/bugs, our builds should go back to green, then we can decide what to
do about that runtime warning based on Peter's series and Nick's ability
to get back up and running (I have his patch applied locally somewhere
so I don't mind collecting tags and sending it next week).

Thanks again for helping us with this, I know it has been chaotic.

Cheers,
Nathan
