Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611E9782E80
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbjHUQg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbjHUQg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:36:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35908100
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:36:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE7B863613
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83D6C433C7;
        Mon, 21 Aug 2023 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692635812;
        bh=LhJh0sKqpBRm5DdU+eaYN8SDji/vv26srnniC6AhiyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZX+pdoddRIB8n0wckphMScNLe1YB2PSBZAAx36hgQTdDVW3zt2ZR+ulCiCqZZpdw3
         XZhzeZoEuwOaohBnZ4qSNdLk0AfIJxMRVE8yaENvQ9s1C9HEDq5ambVYfpHWeGulQa
         WiHWhb4UFna1O6Kxv3eSysYgc692tk0kBK5mAtsandmLu8XuOXu3+01SSBvn3bct/Y
         5ckLjkudErdepVySj81CeNa+R2jG0WSEZveIEgs8jzeyIGW27LJIyDvF7JYeKU3Wn4
         Z1hkfkbHJw/KFR3RvcSQCKtWcTD+L7/sTVs6UNIM5jgkCiod1E1b6W1voF12P1GWge
         AY6VBUP3/aaEg==
Date:   Mon, 21 Aug 2023 09:36:49 -0700
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
Subject: Re: [PATCH 04/22] x86/srso: Fix SBPB enablement for
 spec_rstack_overflow=off
Message-ID: <20230821163649.dyhxdeewlf6eerda@treble>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <23a121e309d5e880eb35c441d9bdfa642d6d59f4.1692580085.git.jpoimboe@kernel.org>
 <20230821141619.GCZONxs5OdbbXFYSq2@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821141619.GCZONxs5OdbbXFYSq2@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 04:16:19PM +0200, Borislav Petkov wrote:
> On Sun, Aug 20, 2023 at 06:19:01PM -0700, Josh Poimboeuf wrote:
> > If the user has requested no SRSO mitigation, other mitigations can use
> > the lighter-weight SBPB instead of IBPB.
> > 
> > Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  arch/x86/kernel/cpu/bugs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index b0ae985aa6a4..10499bcd4e39 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -2433,7 +2433,7 @@ static void __init srso_select_mitigation(void)
> >  
> >  	switch (srso_cmd) {
> >  	case SRSO_CMD_OFF:
> > -		return;
> > +		goto pred_cmd;
> 
> Can't do that - you need to synchronize it with retbleed. If retbleed
> has selected IBPB mitigation you must not override it.

Hm?  How exactly is this overriding the retbleed IBPB mitigation?

-- 
Josh
