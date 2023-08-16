Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E6C77E9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345781AbjHPTaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345834AbjHPTaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945241FCE;
        Wed, 16 Aug 2023 12:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2572464D67;
        Wed, 16 Aug 2023 19:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318DFC433C8;
        Wed, 16 Aug 2023 19:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692214213;
        bh=oIxXPaRIkqCs8i/I4FiyhBgLLNGKo7/+cPI6zzKccDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lcSLThgNYCp/e549tRzEMjqQsXxX6lR7RH8XzGvLbNgS4WMhq+LkMt7U4RzzvH4Ll
         IDmqDGLPWMotMCbwi/DBjRjACaOYDh1xSoME44g0KSaJ6ryaI8TfZ2RcIdXqmacUNQ
         9pjygPjFBhaVh0nan2NWa97vebD5x1wkclULZ89/Rr+9El2JWbNUWyq1AvLDDBcxut
         L40/qo204bNMzL/dmA92SEzHlbll86s8JJuZHMjybPF4LU5Q5rOsX56xw1MLiITg9j
         3bKHzGn8xSHelx1r3grDUhbYXnd+f7YDWwJWloO8mlDzXsZ4qZZPaHHhFtHlRbzH10
         3Hm/NEvXW8m1g==
Date:   Wed, 16 Aug 2023 12:30:11 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230816193011.GA855169@dev-arch.thelio-3990X>
References: <20230814121148.842775684@infradead.org>
 <169217251663.27769.14430226618442726061.tip-bot2@tip-bot2>
 <20230816185839.GA3843691@dev-arch.thelio-3990X>
 <20230816192413.GPZN0iXRRpOGKVMm47@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816192413.GPZN0iXRRpOGKVMm47@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:24:13PM +0200, Borislav Petkov wrote:
> On Wed, Aug 16, 2023 at 11:58:39AM -0700, Nathan Chancellor wrote:
> > but it obviously gets fixed by commit a3fd3ac0a605 ("x86/cpu: Rename
> > srso_(.*)_alias to srso_alias_\1") so it is probably fine. I only
> > noticed it because I cherry-picked the first five changes to my patched
> > -next tree.
> 
> Gah, and I meant to merge that hunk into the right one when fixing the
> 32-bit builds.

Heh, fixups are always hard to get right across multiple patches, been
there, done that...

> So how did you trigger it? You do builds of every patch? Because that's
> the !CONFIG_CPU_SRSO case.

Just ARCH=i386 allmodconfig. CONFIG_CPU_SRSO depends on X86_64 so I
guess that is how it got triggered. I did not build between every patch,
just this one (since it should fix the runtime warning folks have been
noticing) and the final one (as I reported earlier).

> Oh well, lemme rebase and fix it.
> 
> Thx for letting me know.

No problem, hopefully most of the hard work around SRSO is behind us :)

Cheers,
Nathan
