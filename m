Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC0E7897C7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjHZPmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjHZPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:42:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160AD199F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F4ED6112E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94860C433C8;
        Sat, 26 Aug 2023 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693064527;
        bh=hOaNCqqt27RWOnKw81xQYpQ0mlMIgLKh1VaZrPKzs4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBLSqgPaK8znE1cGYxx00KU1Ur1R1EOPeQ+HgKag7E6IpocWl4u8O/3CvMXwftiSH
         AkoTtSAm6Ip4mPwZv3dXTWkpx1WRz+lhGLYQYEqcHNKsrfRtWyukTlcdgCFM1rhsTU
         /cN9X8JQX3i68PM3GJXinYVPs2VDrZJ6d/7WXd0IjCs0knVIjy3eeXW9KRZRgh3zLS
         lYu4pq9s0Ri9oWcMMAVXDzlWyMAT7KVAZDFK0OsWeGJdZ6sMaRXSGPyGVhiqIxhb0v
         Z1jIK7xamY3LMPU6IDdFt9JQiVEMjySzykL/psu4THQHhuf9SYNJ4TIpCQBx1Dqurf
         elMoXNLjCVHMw==
Date:   Sat, 26 Aug 2023 08:42:05 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 22/23] x86/nospec: Refactor UNTRAIN_RET[_*]
Message-ID: <20230826154205.6ejzfk6mmrrtvsm5@treble>
References: <cover.1692919072.git.jpoimboe@kernel.org>
 <d9ad341e6ce84ccdbd3924615f4a47b3d7b19942.1692919072.git.jpoimboe@kernel.org>
 <4f9ea97a-7023-f2b5-8dc8-3ce208197b28@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f9ea97a-7023-f2b5-8dc8-3ce208197b28@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 09:22:10PM +0300, Nikolay Borisov wrote:
> 
> 
> On 25.08.23 г. 10:01 ч., Josh Poimboeuf wrote:
> > Factor out the UNTRAIN_RET[_*] common bits into a helper macro.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >   arch/x86/include/asm/nospec-branch.h | 31 +++++++++-------------------
> >   1 file changed, 10 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > index 51e3f1a287d2..dcc78477a38d 100644
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -288,35 +288,24 @@
> >    * As such, this must be placed after every *SWITCH_TO_KERNEL_CR3 at a point
> >    * where we have a stack but before any RET instruction.
> >    */
> > -.macro UNTRAIN_RET
> > +.macro __UNTRAIN_RET ibpb_feature, call_depth_insns
> >   #if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
> >   	VALIDATE_UNRET_END
> >   	ALTERNATIVE_3 "",						\
> >   		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
> > -		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
> > -		     __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
> > +		      "call entry_ibpb", \ibpb_feature,			\
> > +		     __stringify(\call_depth_insns), X86_FEATURE_CALL_DEPTH
> 
> so this becomes __stringify(__stringify(RESET_CALL_DEPTH)) etc.

Apparently the gas macro un-stringifies the argument when using it, so
it needs to be re-stringified again.  ¯\_(ツ)_/¯

-- 
Josh
