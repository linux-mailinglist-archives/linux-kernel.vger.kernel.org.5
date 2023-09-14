Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD7E7A0743
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbjINO1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjINO1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:27:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA50B9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rg4afThrd0boKj++tc2gp5IX8j6/oqBQQnl2Ndhwbw8=; b=LGDddFnqewuxTTVGO3/21p4nK0
        qBYceHdhjMDF3DDM4uvGRYIDHZBtIaHqwfYXeYxi6blUI1atxm19kehFcpZR4ijNk8EdYLXCCyBaT
        t3HaLClVDFfGctv8AaRdE5vKqtwGqu9xPwV8qq0ZIW+wf8dNJEX77OE15kHHe+WuqbyyYwxOheQ8b
        Qc1qJPnJhrBVmQ2skDuqhTS2REN7ZvocBsH0HsbdBnMATgZnNcxee4oTWsdWR/eJSbMV10K5C5lJ+
        J46vvMVAoO/9M757fY9J6+y/Tn55uEamWc/IkI0XluTNKM5Uji5jItVbYr90c0DdxZ3zqNbibD/wt
        6sUXZlZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgnIq-007vTK-00;
        Thu, 14 Sep 2023 14:26:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FB1430036C; Thu, 14 Sep 2023 16:26:45 +0200 (CEST)
Date:   Thu, 14 Sep 2023 16:26:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Huang, Kai" <kai.huang@intel.com>, lkp <lkp@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        matz@suse.de
Subject: Re: [tip:x86/tdx 8/12] vmlinux.o: warning: objtool:
 __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn
 annotation
Message-ID: <20230914142644.GC18948@noisy.programming.kicks-ass.net>
References: <202309140828.9RdmlH2Z-lkp@intel.com>
 <90f0a4d44704f9c296f3a4d8b72c57f2916aa09d.camel@intel.com>
 <377b1ce2ecd390f4b6f8cdf68d22c708f7cef6d1.camel@intel.com>
 <20230914072959.GC16631@noisy.programming.kicks-ass.net>
 <ZQMVz/wepyo9rlhE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQMVz/wepyo9rlhE@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 04:16:47PM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > It appears the __noreturn must be annotated to the function declaration 
> > > but not the function body.  I'll send out the fix as soon as I confirm 
> > > the fix with LKP.
> > 
> > FWIW, the reason being that...
> > 
> > The point of noreturn is that the caller should know to stop generating 
> > code. For that the declaration needs the attribute, because call sites 
> > typically do not have access to the function definition in C.
> 
> BTW., arguably shouldn't the compiler generate a warning to begin with, 
> when it encounters a noreturn function definition whose prototype doesn't 
> have the attribute?

Yeah, I would agree with that, but I think the problem is that gnu
attributes are all considered 'optional' and do not factor into the
actual signature.

Added Michael to Cc so he may clarify if I'm talking nonsense.
