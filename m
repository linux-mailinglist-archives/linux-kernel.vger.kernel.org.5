Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DCC8013DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379580AbjLAUDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379565AbjLAUDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:03:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4798CB2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:03:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE5EC433C7;
        Fri,  1 Dec 2023 20:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701460995;
        bh=zlGJvgaDfOaydmVhAssBO1Q2xtvGzqBX82vPMeow6H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBUFM1U32mC5a5kuNSctBT/Fei8oX4ETaFZtXddMPB++K5JXpgPLe/pJmjPb6seMc
         LLxZ7zrTSEOFyYMDddaolGtJTT6BWMxR8MEtaIjW89DIZ/nl7F4kWfcABWasD/X6Uu
         RwJXWG5HphFmZXVTwMZQMLnJswrQI4jFBKkbwH64zOgUU1b/R/sUdgRDfwIglc3A1u
         /asI/HVmSEXQPIO0P7T8f2aCUej/5vQRM2qitHnCTk9KdHn8NE4aRHQwt61i1qdIfa
         GPVQzyWlFAWE83+BsHHiaWNaDYjK0qFsGyJMuztArG9nvN2VTEp4A9TFcgKPDCBU/A
         K6w/DEyCt32og==
Date:   Fri, 1 Dec 2023 12:02:47 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH  v4 6/6] KVM: VMX: Move VERW closer to VMentry for MDS
 mitigation
Message-ID: <20231201200247.vui6enzdj5nzctf4@treble>
References: <20231027-delay-verw-v4-0-9a3622d4bcf7@linux.intel.com>
 <20231027-delay-verw-v4-6-9a3622d4bcf7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231027-delay-verw-v4-6-9a3622d4bcf7@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 07:39:12AM -0700, Pawan Gupta wrote:
> -	vmx_disable_fb_clear(vmx);
> +	/*
> +	 * Optimize the latency of VERW in guests for MMIO mitigation. Skip
> +	 * the optimization when MDS mitigation(later in asm) is enabled.
> +	 */
> +	if (!cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF))
> +		vmx_disable_fb_clear(vmx);
>  
>  	if (vcpu->arch.cr2 != native_read_cr2())
>  		native_write_cr2(vcpu->arch.cr2);
> @@ -7248,7 +7256,8 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>  
>  	vmx->idt_vectoring_info = 0;
>  
> -	vmx_enable_fb_clear(vmx);
> +	if (!cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF))
> +		vmx_enable_fb_clear(vmx);
>  

It may be cleaner to instead check X86_FEATURE_CLEAR_CPU_BUF when
setting vmx->disable_fb_clear in the first place, in
vmx_update_fb_clear_dis().

-- 
Josh
