Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9DF793BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240312AbjIFL5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240326AbjIFL5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:57:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B7E1982
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5L9jRbf3MGLFy6llElxr7NI5BpVKqLXfVLQiwOD81wM=; b=tIIQJqCpC/PJh5TLFBMIWzCNW9
        AyomvWu0PMpFok0TmLH0bkC0cgocq4wPelr8H90dqyNOWNX6L0v6z2Gf4vMCWi6ZpjgLBy5tB4lmi
        dnZVXaKLtsTeaCw2GbPpwFa/gIvdfbtsVgvDh4mNLx16IO+X42AJnvbGVTu+IJvwiSD5Pi8WhtbBS
        yVlPwVs5cFHnhSh0K10j4njBxadEmIJSH6bDNEd22No99wwdGYDPj9art402XvTdbTafDjnY0iSCh
        rLt9AaCii85nu730qdnKhQzcSbOnSP8H8QGqvDtKxVaNY7f7So40zkNKEc9XdWdDQbmID0PPBurXm
        x5tqDVbQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdr9p-0025MI-7L; Wed, 06 Sep 2023 11:57:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id D6D2B300472; Wed,  6 Sep 2023 13:57:16 +0200 (CEST)
Date:   Wed, 6 Sep 2023 13:57:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Message-ID: <20230906115716.GF38741@noisy.programming.kicks-ass.net>
References: <cover.1692096753.git.kai.huang@intel.com>
 <0728094e1d8751355360987f17fcc2db18b43ce7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0728094e1d8751355360987f17fcc2db18b43ce7.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 11:01:28PM +0000, Huang, Kai wrote:
> On Tue, 2023-08-15 at 23:01 +1200, Kai Huang wrote:
> > Hi Peter, Kirill,
> > 
> > This series unifies the assembly code for TDCALL/SEAMCALL and TDVMCALL.
> > Now all of them use one singe TDX_MODULE_CALL asm macro.  More
> > information please see cover letter of v2 (see link below).
> > 
> > Tested by booting TDX guest, initializing TDX module, and running TDX
> > guest successfully, all with this series applied.
> > 
> > 
> 
> Hi Peter,
> 
> Sorry to ping, but could you take a look whether you are OK with this series?
> 
> Basically Kirill has provided his Reviewed-by for all the patches except the
> last one (Add unused registers to 'struct tdx_module_args' to optimize VP.ENTER
> for KVM), which he didn't like.  But it is pretty much a standalone optimization
> patch we either can have or drop when applying, so I'll leave to you.
> 
> Also feel free to let me know if I can help you on anything to offload part of
> your load? :-)

This looks good, thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
