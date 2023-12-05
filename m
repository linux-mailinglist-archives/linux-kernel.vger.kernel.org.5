Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921258060BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345746AbjLEVYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLEVYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:24:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C2AA5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:24:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD60C433C8;
        Tue,  5 Dec 2023 21:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701811493;
        bh=ziKcsiIBH+rVgZNoT8/bVPVFDuiUG8Ohd3nbih5ZSno=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eA4NeptRfWGP7RLlgV6CwB/RCO8zJvjm+FnpVCfH/n2QN2xI21GwNZG5xrmz3d3O3
         1FgZpw89cd+LbAipWDBToGBVvr27rX6YcPXkXC81dWlzwt7Entb+gzzVSvi2WBZzH6
         qJOPUZ+SGN30v32YbnJeUXj+oZC/8QeIb7h3XVMM=
Date:   Tue, 5 Dec 2023 13:24:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     tanzirh@google.com, Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-Id: <20231205132452.418722bea8f6878dca88142a@linux-foundation.org>
In-Reply-To: <CAKwvOdn+VTM+LY6ALcgaZTL57JpiKt5rBPMSPNXsgS3MCENhDQ@mail.gmail.com>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
        <20231205130449.8e330a26ecbed1f7b5ad5d7a@linux-foundation.org>
        <CAKwvOdn+VTM+LY6ALcgaZTL57JpiKt5rBPMSPNXsgS3MCENhDQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2023 13:14:16 -0800 Nick Desaulniers <ndesaulniers@google.com> wrote:

> >
> > The preferred way to import bit-fiddling stuff is to include
> > <linux/bits.h>.  Under the hood this may include asm/bitsperlong.h.  Or
> > it may not, depending on Kconfig settings (particularly architecture).
> >
> 
> Just triple checking my understanding; it looks like
> include/linux/bits.h unconditionally includes asm/bitsperlong.h (which
> is implemented per arch) most of which seem to include
> asm-generic/bitsperlong.h.
> 
> include/linux/bits.h also defines a few macros (BIT_MASK, BIT_WORD,
> BITS_PER_BYTE, GENMASK, etc).  If lib/string.c is not using any of
> those, why can't we go straight to #including asm/bitsperlong.h?  That
> should resolve to the arch specific impl which may include
> asm-generic/bitsperlong.h?

It's just a general rule.  If the higher-level include is present, use
that.  Because of the above, plus I guess things might change in the
future.

We've been getting better about irregular asm/include files.

But bits.h is a poor example.  A better case to study is spinlock.h. 
If this tool recommended including asm/spinlock.h then that won't work
on any architecture which doesn't implement SMP (there is no
arch/nios2/include/asm/spinlock.h).
