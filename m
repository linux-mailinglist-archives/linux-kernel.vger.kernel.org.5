Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB918013A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379531AbjLAThn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379411AbjLAThl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:37:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D564128
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:37:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483F9C433C9;
        Fri,  1 Dec 2023 19:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701459468;
        bh=KdVQmlMNK9VXP9HFIu2QT1p2mdpD1OBOQPPhAz2pg08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjxDnlKvyDQpbAfh092/uwT5swfIUKguaSbKYeBy4d0GaR7Uk+qzliJlFl6Uvcyb6
         +wYbjoLol29F9Y0kPWPuLg96ugn+JPoP5vWwCKDD5d4cFb9F3Wf/QyDOTrpXWTUHon
         KSS9c28X3t2GEApXRs2hWu2gxOClE9+1zWdCoFZIAi+irbqDG1J3cI4Npay6FkxsI2
         hW8hCKDYZJI7INF8VoVWCHZC4fnitrSdBXNBJ/Ot+Iq92FY/ZWZs1cEVw1SEzujK3J
         iOi7/r2EwPADi4tMKzmw38/SVNCPZw0smjnvBIAfoGe826M373VnC94tQ0i2NsmraA
         ++A/5J3ovt5/Q==
Date:   Fri, 1 Dec 2023 11:36:57 -0800
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alyssa Milburn <alyssa.milburn@intel.com>
Subject: Re: [PATCH  v4 1/6] x86/bugs: Add asm helpers for executing VERW
Message-ID: <20231201193657.mvzslo4nlcbuv2q4@treble>
References: <20231027-delay-verw-v4-0-9a3622d4bcf7@linux.intel.com>
 <20231027-delay-verw-v4-1-9a3622d4bcf7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231027-delay-verw-v4-1-9a3622d4bcf7@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 07:38:40AM -0700, Pawan Gupta wrote:
> +.pushsection .entry.text, "ax"
> +
> +.align L1_CACHE_BYTES, 0xcc
> +SYM_CODE_START_NOALIGN(mds_verw_sel)
> +	UNWIND_HINT_UNDEFINED
> +	ANNOTATE_NOENDBR
> +	.word __KERNEL_DS
> +.align L1_CACHE_BYTES, 0xcc
> +SYM_CODE_END(mds_verw_sel);
> +/* For KVM */
> +EXPORT_SYMBOL_GPL(mds_verw_sel);
> +
> +.popsection

This is data, so why is it "CODE" in .entry.text?

-- 
Josh
