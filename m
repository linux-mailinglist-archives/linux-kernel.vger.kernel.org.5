Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A181A7DE92F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbjKBABy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjKBABv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:01:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DB9122;
        Wed,  1 Nov 2023 17:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698883304; x=1730419304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M8msWLszZPb7Wc0YXeNVNV9srP1v8FBDUCNkoBEItec=;
  b=Qh7q9oMQzhO1tBeJBVSj3a9ByMQNLp9okIDlxkJQLrFhvNPSuDUpXvhQ
   xY0APrHhX58DZcXSMt0PwTt7gVWBF6ro1+CdeIfhOyZrOp/5RnRv41YSH
   c5p1jsCqdiUjuwahPK1MllwMvWSfLl4u5Bpeco0jiV5SX+0Grrmf8NI2P
   2zk/eUC+xyNu7e2AgPDN9NmPEdhBxB1nELu9ktridtJHszcPK2njtFtSM
   sDgUhfMIzwtIN1bk8qIGhdBiRwODHw32XRa9NKHF4v47q+06yTQtGyzvU
   QY6b2YfVlAASGOcJ4rsu7q6+IWjtvGAQp6Ftc2b+9cqT/EM/gsD/+E4Is
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="367947182"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="367947182"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 17:01:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="904837206"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="904837206"
Received: from dkammer-mobl2.amr.corp.intel.com (HELO desk) ([10.255.230.88])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 17:01:43 -0700
Date:   Wed, 1 Nov 2023 17:01:34 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, tony.luck@intel.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alyssa Milburn <alyssa.milburn@intel.com>
Subject: Re: [PATCH  v4 1/6] x86/bugs: Add asm helpers for executing VERW
Message-ID: <20231102000134.ophdmdy5ht6btlfi@desk>
References: <20231027-delay-verw-v4-0-9a3622d4bcf7@linux.intel.com>
 <20231027-delay-verw-v4-1-9a3622d4bcf7@linux.intel.com>
 <20231027153203.GJZTvX84mr+63lVWIH@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027153203.GJZTvX84mr+63lVWIH@fat_crate.local>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 05:32:03PM +0200, Borislav Petkov wrote:
> On Fri, Oct 27, 2023 at 07:38:40AM -0700, Pawan Gupta wrote:
> >   1. Kernel data accessed by an NMI between VERW and return-to-user can
> >      remain in CPU buffers ( since NMI returning to kernel does not
> 
> Some leftover '('

Ok.

> > In preparation for moving VERW to entry/exit asm code, create macros
> > that can be used in asm. Also make them depend on a new feature flag
> > X86_FEATURE_CLEAR_CPU_BUF.
> 
> The macros don't depend on the feature flag - VERW patching is done
> based on it.

Will fix.

> > @@ -20,3 +23,17 @@ SYM_FUNC_END(entry_ibpb)
> >  EXPORT_SYMBOL_GPL(entry_ibpb);
> >  
> >  .popsection
> > +
> > +.pushsection .entry.text, "ax"
> > +
> > +.align L1_CACHE_BYTES, 0xcc
> > +SYM_CODE_START_NOALIGN(mds_verw_sel)
> 
> That weird thing needs a comment explaining what it is for.

Right.

> > +#define X86_FEATURE_CLEAR_CPU_BUF	(11*32+27) /* "" Clear CPU buffers */
> 
> 									   ... using VERW

Ok.

> > +/*
> > + * Macros to execute VERW instruction that mitigate transient data sampling
> > + * attacks such as MDS. On affected systems a microcode update overloaded VERW
> > + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
> > + *
> > + * Note: Only the memory operand variant of VERW clears the CPU buffers.
> > + */
> > +.macro EXEC_VERW
> > +	verw _ASM_RIP(mds_verw_sel)
> > +.endm
> > +
> > +.macro CLEAR_CPU_BUFFERS
> > +	ALTERNATIVE "", __stringify(EXEC_VERW), X86_FEATURE_CLEAR_CPU_BUF
> > +.endm
> 
> Why can't this simply be:
> 
> .macro CLEAR_CPU_BUFFERS
>         ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF

This will not work in 32-bit mode that uses the same macro.

Thanks for the review.
