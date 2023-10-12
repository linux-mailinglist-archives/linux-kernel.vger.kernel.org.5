Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6D67C7213
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344027AbjJLQIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbjJLQIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:08:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E04D3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:08:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB81C433C8;
        Thu, 12 Oct 2023 16:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697126883;
        bh=2UpTEfzKhwBh+bM5tqy6dBGC1ZFE2SP7YfTlFl2S0n0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nrkiYLiZteU+qHMsgX/qqUixOIkSSU7FECx5zVWC57C79UFUUmDZlnz4OCOrxrVju
         4P3SQHNWYjQV4R+4xbUIxvZREVOZJFOamfeuc8v8XE8iPTR8sPsCdsxdXOmkqUM3M0
         G0h/tceFyebqOZHGeQgB45ZvJJAQp+XEDl1V5BCT+mHTCb5amVhxr9Ynrlykk1LUlU
         DxE4BRM7MzKie2P0AiC8OT0Mj7L0+QjSnkaUl+pbjomFJCBzA3BHsw2664RosAsyMk
         X6JLpstSpjolOjpv/wZH6dUIGEmCzlr1mYzx/uG91nuYMo7raykTxYSOqO9Gz1DFWU
         ntUvDZUTL4nUA==
Date:   Thu, 12 Oct 2023 09:08:01 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Message-ID: <20231012160801.blc2t37gfqhlah5h@treble>
References: <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
 <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
 <CAFULd4afyYK0-wAOo3oJDapX0iyu86m5+vVn9c35gk8fd6iwRQ@mail.gmail.com>
 <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
 <ZScjptMn3fDmMFdg@gmail.com>
 <9b71932a-d410-4b92-b605-d6acc5d35069@zytor.com>
 <20231012013507.jrqnm35p7az6atov@treble>
 <ZSeP4vwQ9k/v63Cy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSeP4vwQ9k/v63Cy@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 08:19:14AM +0200, Ingo Molnar wrote:
> 
> * Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > Though, another problem is that .text has a crazy amount of padding
> > which makes it always the same size, due to the SRSO alias mitigation
> > alignment linker magic.  We should fix that somehow.
> 
> We could emit a non-aligned end-of-text symbol (we might have it already),
> and have a script or small .c program in scripts/ or tools/ that looks
> at vmlinux and displays a user-friendly and accurate list of text and
> data sizes in the kernel?
> 
> And since objtool is technically an 'object files tool', and it already
> looks at sections & symbols, it could also grow a:
> 
> 	objtool size <objfile>
> 
> command that does the sane thing ... I'd definitely start using that, instead of 'size'.
> 
> /me runs :-)

Yeah, that's actually not a bad idea.

I had been thinking a "simple" script would be fine, but I'm realizing
the scope of this thing could grow over time.  In which case a script is
less than ideal.  And objtool already has the ability to do this pretty
easily.

-- 
Josh
