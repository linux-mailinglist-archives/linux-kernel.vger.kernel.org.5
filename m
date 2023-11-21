Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D71E7F33EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjKUQih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjKUQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:38:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC829E7;
        Tue, 21 Nov 2023 08:38:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1008C433C8;
        Tue, 21 Nov 2023 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700584712;
        bh=I9ZH/e6KtTHN2UHi0fUQgC/I219UZFtlAoAwKkrjbcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIuck4j4FS3Th2Qg6/yfyYjczl8E2bvtKdh8PF0v8/T1n7u5A3PTNFdZmXNNkVwY5
         3lRB+7j8NjJHp4GSIMKmhmMO6UZs+6JnKEK4YK6avhOQ7k+Th+QxH9whbGIqzgeFHS
         NFZQwEF5iHtTXdRDw1SYU8iSsfejNVCoDA6LSHiBCBT9CL6uQNU49cmrIc2Q6KwLKn
         /drPNzhKzZbcBz0MTX9Bh4ek04c6IA887OqF08oLR7WtSdrW4sKrzZK8gm8xMAFGNf
         BnQVtsjMLGUnys8OpppGt7itl83rfcA5+hzKjZ5dFi3oagDSHiPwbG7UjCSmyy5ZyX
         OX64f7FCJfZAQ==
Date:   Tue, 21 Nov 2023 09:38:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Maria Yu <quic_aiquny@quicinc.com>, linux@armlinux.org.uk,
        mhiramat@kernel.org, kernel@quicinc.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_lijuang@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] ARM: kprobes: Explicitly reserve r7 for local
 variables
Message-ID: <20231121163830.GA3437094@dev-arch.thelio-3990X>
References: <20231120032909.19186-1-quic_aiquny@quicinc.com>
 <CAMj1kXHLT6PhT0v6=9DWS1bXDV+QSZDwnYDo=+KvpzrCBqPNrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHLT6PhT0v6=9DWS1bXDV+QSZDwnYDo=+KvpzrCBqPNrw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:11:56AM -0500, Ard Biesheuvel wrote:
> On Sun, 19 Nov 2023 at 22:29, Maria Yu <quic_aiquny@quicinc.com> wrote:
> >
> > Registers r7 is removed in clobber list, so compiler may choose r7 for
> > local variables usage, while r7 will be actually updated by the inline asm
> > code. This caused the runtime behavior wrong.
> > While those kind of reserved registers cannot be set to clobber list
> > because of error like "inline asm clobber list contains reserved
> > registers".
> > Explicitly reserve r7 by adding attribute no-omit-frame-pointer for this
> > file, then in T32 asm code r7 is used as a frame pointer and is not
> > available for use as a general-purpose register.
> > Note that "no-omit-frame-pointer" will make the code size a little bigger
> > to store the stack frame pointer.
> >
> > Fixes: dd12e97f3c72 ("ARM: kprobes: treat R7 as the frame pointer register in Thumb2 builds")
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/arm/probes/kprobes/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/probes/kprobes/Makefile b/arch/arm/probes/kprobes/Makefile
> > index 6159010dac4a..b1f21e78950b 100644
> > --- a/arch/arm/probes/kprobes/Makefile
> > +++ b/arch/arm/probes/kprobes/Makefile
> > @@ -8,6 +8,7 @@ test-kprobes-objs               := test-core.o
> >
> >  ifdef CONFIG_THUMB2_KERNEL
> >  obj-$(CONFIG_KPROBES)          += actions-thumb.o checkers-thumb.o
> > +CFLAGS_actions-thumb.o         += -fno-omit-frame-pointer
> >  test-kprobes-objs              += test-thumb.o
> >  else
> >  obj-$(CONFIG_KPROBES)          += actions-arm.o checkers-arm.o
> >
> 
> If Nathan is happy with this, I think we can drop this into the patch tracker.

I have no qualms with this approach, there are no issues with the couple
of LLVM versions that I tested.

Cheers,
Nathan
