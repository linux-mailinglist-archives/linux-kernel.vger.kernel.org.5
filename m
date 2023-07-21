Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E13175C0C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjGUIGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjGUIGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:06:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAFB270A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+0/yr6svsCdiHhqlQ2volL3sLY0i9ywEXySoXECsi8s=; b=nAb7CozkP3/iMLdaZnOpgn+PrS
        PLStAVIg3Pf0gsFT1X98ZV0zyTAeaMTwdMO5PNhV4PS6k74GjwmkxWgra91WAXkdEZISkytFC2/OO
        2t/p0/aH7L43t34Z4oamPgjv3VeIoFmFv179+dsPOKWmZKtqHm3We/fyeZ+w7m8rk5ctQocX7Suon
        M/QAutUBdBqkvT+ojVSGPnlvw77hftlHo+eGO0cMMd7i3Ut6jEduxGJd7W3wAln5qHsVW0v8wx/8C
        8LuhvzJBm5qbJ63CpSx3vzMdjFHMbhBt2Mbf1LSws4ntk46eooVkbBKrJ493uq0/BXAk9q+InzZHh
        497swIBA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMl9X-000uka-1C; Fri, 21 Jul 2023 08:06:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A1083001E7;
        Fri, 21 Jul 2023 10:06:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8A2C314DED7D; Fri, 21 Jul 2023 10:06:18 +0200 (CEST)
Date:   Fri, 21 Jul 2023 10:06:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v2 00/11] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Message-ID: <20230721080618.GC3630545@hirez.programming.kicks-ass.net>
References: <cover.1689855280.git.kai.huang@intel.com>
 <20230720131608.GE3569127@hirez.programming.kicks-ass.net>
 <a23ce8fd289141cea3a1b4f3dace221dca847238.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a23ce8fd289141cea3a1b4f3dace221dca847238.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 12:18:23AM +0000, Huang, Kai wrote:

> Unfortunately I don't think it's feasible.  Sean pointed out that
> kvm_vcpu_arch::regs[] do follow the "register index" hardware layout in x86 (for
> which I missed sorry), so we cannot re-order KVM part.  
> 
> And unfortunately RBP (5) is in middle of those registers:
> 
> 	0 = RAX
> 	1 = RCX
> 	2 = RDX
> 	3 = RBX
> 	4 = RSP
> 	5 = RBP
> 	6 = RSI
> 	7 = RDI
> 	8–15 represent R8–R15, respectively...
> 
> Thus unless we add RBP to 'struct tdx_module_args', it's impossible to re-order
> the structure to match KVM's layout.

Adding RBP to the struct shouldn't be a problem, we'll just not use it.
Same as RSP, nobody sane would expect that to be used. If you worry
about it you can give them funny names like:

struct tdx_module_args {
	unsigned long ax;
	unsigned long cx;
	unsigned long dx;
	unsigned long bx;
	unsigned long __sp_unused;
	unsigned long __bp_unused;
	unsigned long si;
	unsigned long di;
	...
};

I mean, at this point the whole thing is just 128 bytes of data anyway.
