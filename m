Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB4C782E25
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbjHUQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbjHUQRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98191A1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E45F63D88
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42576C433C9;
        Mon, 21 Aug 2023 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692634628;
        bh=bAkJ3uGiZwHnF58XEvUhzERR6lpWrMcpcYnXnqaz7G4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RaZmu0JF+X4O+YZgucszPEFMf9icZeL3AzyvZVU0+gb5qO7+05fuIhHdkifF+Q3m2
         NDVKrucuZ5G7o9vGh3MP3BVKML6KaZF4VVeeDp8BAxvD4S5S0pnJcpO8pIJAStOTMu
         wyUsXwDirj60UnPZh9/urKS/mVVIKPnbueTAWx06TS9CF/Cw+rb2729wO+PMA8qQ2v
         7gtNqaLFq6WDDfjr5IyORFLXaLrhCwOsy9+p49VXosP6ufBLQwadW+OOdUplN1rIlr
         O4nsIIK4HJFov4T5engrV0G9ehHCaxXI8erZT7CsY9tgRnVbWLg+Zl/OMtHnle32/i
         e8IWlLhh2+LEQ==
Date:   Mon, 21 Aug 2023 09:17:06 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/22] x86/srso: Fix srso_show_state() side effect
Message-ID: <20230821161706.s62ecp7zhiunt5oy@treble>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <fc64c4e5749d10b398c86b60902d6f9394eb5012.1692580085.git.jpoimboe@kernel.org>
 <20230821060416.GBZOL+YJeVj4tbkT78@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821060416.GBZOL+YJeVj4tbkT78@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 08:04:16AM +0200, Borislav Petkov wrote:
> On Sun, Aug 20, 2023 at 06:18:58PM -0700, Josh Poimboeuf wrote:
> > Reading the 'spec_rstack_overflow' sysfs file can trigger an unnecessary
> > MSR write, and possibly even a (handled) exception if the microcode
> > hasn't been updated.
> > 
> > Avoid all that by just checking X86_FEATURE_IBPB_BRTYPE instead, which
> > gets set by srso_select_mitigation() if the updated microcode exists.
> > 
> > Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  arch/x86/kernel/cpu/bugs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index f081d26616ac..bdd3e296f72b 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -2717,7 +2717,7 @@ static ssize_t srso_show_state(char *buf)
> >
> 
> Please put here a comment - something along the lines of:
> 
> "X86_FEATURE_IBPB_BRTYPE gets set as a result of the presence of the
> needed microcode so checking that is equivalent."
> 
> so that it is clear why it is ok to check this feature bit.

I could do that, but this check ends up getting replaced by a later
patch anyway.

Would you want this comment in srso_select_mitigation()?  After the next
patch it has:

  bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);

Though that seems clear to me already.

-- 
Josh
