Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B079FF43
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbjINI7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbjINI7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:59:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392CDA8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=767aOcIiPAu+a4xSMgdj3nN/8LUSwQTBQXYqcr4vSMA=; b=kgFcO0zVBVsnq/RZPRCNd5HN35
        p8VN7t6TqAXFG6k7to+8XkKW7wL8LCf5SehsFSaqHD1AaIkwUt6v9G2sujMmd6go9KeAUzOGU01vx
        PYa0S46uqrKSX3jShgHJkktVfOlmzHDOg2ho7ZBTjqgVdzrTHOKn/CIiDgDu8KMOdpJz1Uf4t8cZB
        mkldwNURQ48hqWknD2F7GZZfCkoI0YizQDxNpSXmolQGtbUktQR1xoQy7ez4O+c6ItAKXp/lFS+JS
        BoFU8x/UBhieJ/Bvqul8Z+OeyrunOe/Gt0KfqlGMKVFlH5l+ThDhPqD/Zgv6ogKRNs0R6jdW0uRjj
        NjgP8vBQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgiBt-001xaT-HM; Thu, 14 Sep 2023 08:59:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35FEA30036C; Thu, 14 Sep 2023 10:59:13 +0200 (CEST)
Date:   Thu, 14 Sep 2023 10:59:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip:x86/tdx 8/12] vmlinux.o: warning: objtool:
 __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn
 annotation
Message-ID: <20230914085913.GD16631@noisy.programming.kicks-ass.net>
References: <202309140828.9RdmlH2Z-lkp@intel.com>
 <90f0a4d44704f9c296f3a4d8b72c57f2916aa09d.camel@intel.com>
 <377b1ce2ecd390f4b6f8cdf68d22c708f7cef6d1.camel@intel.com>
 <20230914072959.GC16631@noisy.programming.kicks-ass.net>
 <9eb77be3a64c25b3264d5011a93242d006b88627.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eb77be3a64c25b3264d5011a93242d006b88627.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 07:54:10AM +0000, Huang, Kai wrote:

> > The point of noreturn is that the caller should know to stop generating
> > code. For that the declaration needs the attribute, because call sites
> > typically do not have access to the function definition in C.
> 
> Ah that makes perfect sense.  Thanks!
> 
> Then I assume we don't need to annotate __noreturn in the function body, but
> only in the declaration?  Because the compiler must already have seen the
> declaration when it generates the code for the function body.

I think so, I'm sure it'll tell you if it disagrees :-)

> Btw, I happened to notice that the objtool documentation suggests that we should
> also add the the function to tools/objtool/noreturns.h:
> 
> 3. file.o: warning: objtool: foo+0x48c: bar() is missing a __noreturn annotation
> 
>    The call from foo() to bar() doesn't return, but bar() is missing the
>    __noreturn annotation.  NOTE: In addition to annotating the function
>    with __noreturn, please also add it to tools/objtool/noreturns.h.
> 
> Is it a behaviour that we still need to follow?

Yes. objtool has some heuristics to detect noreturn, but is is very
difficult. Sadly noreturn is not something that is reflected in the ELF
object file so we have to guess.

For now manually adding it to the objtool list is required, we're trying
to get to the point where it is generated/validated by the compiler,
perhaps with a plugin, but we're not there yet.
