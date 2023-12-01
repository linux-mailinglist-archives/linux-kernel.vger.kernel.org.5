Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B38013E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379584AbjLAUFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379559AbjLAUFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:05:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85B810F4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:05:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6952FC433C8;
        Fri,  1 Dec 2023 20:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701461112;
        bh=VZNoAqDPTg8yDoctRcEB3F3opYWUlSBiujMwK2WyTQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJ1WjZYZ+qso1UgSidqe3y+J/eJKvHShQw2R3MIzQEk70r87eQP1DebG3EQAiSLIj
         IUqhHtHkfHjsuBzdihsJ/ioN6yOXRd3wk9v9HE6RTary1ugjedS5FIL4PVk+6wU/ez
         g9DPCfWdfABoNpMiyisxXIZsO0px3oHHZYB77AAaBAGg1g+WXNqe/+ZY/8Xs6oj+ud
         LBLNz8APsX4gnPGHkBG46TW0JkbA7erLdKsm+gCXkSOaxRnSHnSGmTAZx6/Eo8gWe0
         0lOj7Mfj5wmuVLHJTKpo4wPE5uVmAJClr6yxMBQ67sBDQKBPKWsKgwaxLyKpz+g8rk
         EBv4asusLbiFg==
Date:   Fri, 1 Dec 2023 12:04:42 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, tony.luck@intel.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alyssa Milburn <alyssa.milburn@intel.com>
Subject: Re: [PATCH v4 1/6] x86/bugs: Add asm helpers for executing VERW
Message-ID: <20231201200442.lvyep5uqc6oa7kwj@treble>
References: <20231027-delay-verw-v4-0-9a3622d4bcf7@linux.intel.com>
 <20231027-delay-verw-v4-1-9a3622d4bcf7@linux.intel.com>
 <20231201193657.mvzslo4nlcbuv2q4@treble>
 <c61402de-c61e-4d7f-a2b1-3eaa13e4ef33@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c61402de-c61e-4d7f-a2b1-3eaa13e4ef33@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 07:39:05PM +0000, Andrew Cooper wrote:
> On 01/12/2023 7:36 pm, Josh Poimboeuf wrote:
> > On Fri, Oct 27, 2023 at 07:38:40AM -0700, Pawan Gupta wrote:
> >> +.pushsection .entry.text, "ax"
> >> +
> >> +.align L1_CACHE_BYTES, 0xcc
> >> +SYM_CODE_START_NOALIGN(mds_verw_sel)
> >> +	UNWIND_HINT_UNDEFINED
> >> +	ANNOTATE_NOENDBR
> >> +	.word __KERNEL_DS
> >> +.align L1_CACHE_BYTES, 0xcc
> >> +SYM_CODE_END(mds_verw_sel);
> >> +/* For KVM */
> >> +EXPORT_SYMBOL_GPL(mds_verw_sel);
> >> +
> >> +.popsection
> > This is data, so why is it "CODE" in .entry.text?
> 
> Because KPTI.

Urgh... Pawan please add a comment.

-- 
Josh
