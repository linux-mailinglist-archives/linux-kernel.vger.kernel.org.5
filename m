Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8507787A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243753AbjHXVlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243745AbjHXVk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:40:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868E419A0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:40:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2050C6313A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D7CC433C7;
        Thu, 24 Aug 2023 21:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692913254;
        bh=VnIgZOsYuMfvNLV27JRIntctRbnkD24emyKs6rgPNOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDh1z40Uvp+DPCJQy9gCOCxp3RvPgV3VB+z5T23vIXXVDxj+GoiO04d58aBxvOink
         p+jZhHL39tyIkwl+Ji9id2F5haGQXBXH7P8fzl2yNqs6baZYT8dV+dPSQmfknp9pZ4
         ccWE8+YdL51KyFqKZyGma3AnYUErKFibm+PcztkogfXyM8nRC3ybGVJ3NchaIqJv6w
         Is9x7bNTFIoE+ZvXbGdHiVZPFtx8M9EFLfAC/gZkkPNVt4eujP1R9lkE8+0eN6/W9s
         3Zh5g5UXEoPbjn0svGuBKU/9c6NjgqlLUsO6H72zIct10RqPEP+ELOomABVeev26A1
         CiBpDpE3/tpCg==
Date:   Thu, 24 Aug 2023 14:40:52 -0700
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
Subject: Re: [PATCH 10/22] x86/srso: Print mitigation for retbleed IBPB case
Message-ID: <20230824214052.v2sxidqqdfounkrw@treble>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <3836b2e27c9537d95ecce2a1e33e53315176ebc1.1692580085.git.jpoimboe@kernel.org>
 <20230824044818.GDZObhEh3MWZN8vcfW@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824044818.GDZObhEh3MWZN8vcfW@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 06:48:18AM +0200, Borislav Petkov wrote:
> On Sun, Aug 20, 2023 at 06:19:07PM -0700, Josh Poimboeuf wrote:
> > When overriding the requested mitigation with IBPB due to retbleed=ibpb,
> > print the actual mitigation.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  arch/x86/kernel/cpu/bugs.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index da480c089739..4e332707a343 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -2427,7 +2427,7 @@ static void __init srso_select_mitigation(void)
> >  		if (has_microcode) {
> >  			pr_info("Retbleed IBPB mitigation enabled, using same for SRSO\n");
> 
> This print was supposed to do that. Now you have two for the IBPB case.
> If you want to print it using the usual format, then whack the above.

Sure, and in that case I'll just drop the other one which changes the
above from pr_err() to pr_info().

-- 
Josh
