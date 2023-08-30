Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CDA78E2DF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244119AbjH3WzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbjH3WzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:55:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B549DE46;
        Wed, 30 Aug 2023 15:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 873EE609FA;
        Wed, 30 Aug 2023 22:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C412C433C7;
        Wed, 30 Aug 2023 22:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693436017;
        bh=YiYP51thRw37HnPsOr/Uizkplcy/kYRjh3WYIFuGBL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afe149zYuF3gJVRd3JnIJFfQrQEZLY4PyVj2239yGEA0awb4H5GyEexniHSygeeYo
         ZFRI0mB/zt/BwOHTBALVV0gOE+psqmBGndsi85l6fYvF1epqH4bWoZGdRWd+wfBoOS
         lx+o/B8gzEs61PtXHye9zvl7m+Qhcq7quda9F6ID2JL+Sp7KlarIFPs2A6B5uyhkUy
         nNJwp/FZD4e2GYYWIO2sl7322ZlYLwzcyQqexLOl68GvxXVqLhGnTn3olk4hkfjhaU
         4OoGeWXpVagPdbvruqqrCWKJqWPjUi0SVXoTxA1ymILgNLsH1wI2BgEUCUYUBs7Imw
         rUQjjyUlFI2xQ==
Date:   Wed, 30 Aug 2023 15:53:35 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [GIT PULL] non-MM updates for 6.6-rc1
Message-ID: <20230830225335.kmdj5er253fr7rk4@treble>
References: <20230828225431.354d3d2d3b80ee5b88e65eb5@linux-foundation.org>
 <CAHk-=wgsKp2ZPxQ_WvRGLJXtZG6Z2TrqC_jNppukfniCZB9doQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgsKp2ZPxQ_WvRGLJXtZG6Z2TrqC_jNppukfniCZB9doQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 03:20:37PM -0700, Linus Torvalds wrote:
> On Mon, 28 Aug 2023 at 22:54, Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > Linus, please pull mm.git's non-MM updates for this cycle.
> 
> Hmm. For some non-obvious (to me) reason this triggers
> 
>   vmlinux.o: warning: objtool: ibt_selftest+0x18: sibling call from
> callable instruction with modified stack frame
> 
> which didn't happen before, even though the pull doesn't actually
> change that file at all.
> 
> I see that Josh has a patch to fix this by making it be real assembly
> code rather than a hacky inline asm in a C file, but it's a bit
> surprising, and I don't see why it's triggered now when it wasn't
> before.
> 
> At a guess it's related to the Kconfig changes, but I have nothing to
> back that guess up with.
> 
> Slightly annoying, but I guess I'll live with the warning for now.

As far as I can tell this warning only shows up with the rare
combination of CONFIG_X86_KERNEL_IBT and CONFIG_UNWINDER_FRAME_POINTER
(the latter being pretty much deprecated at this point).

Did you manage to enable frame pointers somehow?

The fix (to rewrite the IBT selftest) was merged into tip/x86/shstk.
Presumably it'll be in a pull request soon-ish.

-- 
Josh
