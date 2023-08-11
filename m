Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C527787C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjHKHCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjHKHCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:02:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196031FCF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d+rxFYBsUbWK5m7TywNWr6RFct7UvyDDc4wfiX3KjPE=; b=BgKvYkXIjiS1SWTf75J1aRav8l
        3iTRlemF1lLxjcZZEAkDjUkCxDdcfYjm3BiAOitCx2fe36qGDFj9jydyXuEMcp6X95A8I9auv+zh1
        SAfUn312dJqJxyDkjjP68lpV3ZXeJYAvjT+Kq2bP+wa0kM4nwL0p0V6+QR1NXeF+E1stUSthi+zaT
        QtHHYB2FLwT08+xfaDdisWMrySBJTJNQ1WAyJBjlGPOLX/Bj/yarZYy1UMvdXSuuJ+YmPuRKzxP0w
        IzDn2qEtGASuy4wtj96qsZ8owCyiMv4B6+rRAxVDHhX63/v1SrFaBxm60xjrzNBb0W2VdqezoEcoV
        jjEDwGwA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUM9E-00HJJj-7y; Fri, 11 Aug 2023 07:01:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E9A830020B;
        Fri, 11 Aug 2023 09:01:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58D232089BD65; Fri, 11 Aug 2023 09:01:23 +0200 (CEST)
Date:   Fri, 11 Aug 2023 09:01:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, matz@suse.de,
        Nick Desaulniers <ndesaulniers@google.com>,
        joao.moreira@intel.com, samitolvanen@google.com
Subject: Re: [RFC][PATCH 02/17] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230811070123.GD220434@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.543939260@infradead.org>
 <20230810115148.GEZNTPVLBmPL6uz4Af@fat_crate.local>
 <20230810123756.GY212435@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810123756.GY212435@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 02:37:56PM +0200, Peter Zijlstra wrote:

> After this patch things look equivalent to:
> 
> SYM_FUNC_START(foo)
> 	...
> 	ALTERNATIVE "ret; int3"
> 		    "jmp __x86_return_thunk", X86_FEATURE_RETHUNK
> 		    "jmp srso_return_thunk, X86_FEATURE_SRSO
> 		    "jmp srsi_alias_return_thunk", X86_FEATURE_SRSO_ALIAS
> SYM_FUNC_END(foo)
> 
> SYM_CODE_START(srso_return_thunk)
> 	UNWIND_HINT_FUNC
> 	ANNOTATE_NOENDBR
> 	call srso_safe_ret;
> 	ud2
> SYM_CODE_END(srso_return_thunk)
> 
> SYM_CODE_START(srso_alias_return_thunk)
> 	UNWIND_HINT_FUNC
> 	ANNOTATE_NOENDBR
> 	call srso_alias_safe_ret;
> 	ud2
> SYM_CODE_END(srso_alias_return_thunk)
> 

So it looks like the compilers are still not emitting int3 after jmp,
even with the SLS options enabled :/

This means the tail end of functions compiled with:

  -mharden-sls=all -mfunction-return=thunk-extern

Is still a regular: jmp __x86_return_thunk, no trailing trap.

  https://godbolt.org/z/Ecqv76YbE

If we all could please finally fix that, then I can rewrite the above to
effectively be:

SYM_FUNC_START(foo)
	...
	ALTERNATIVE "ret; int3"
		    "jmp __x86_return_thunk", X86_FEATURE_RETHUNK
		    "call srso_safe_ret, X86_FEATURE_SRSO
		    "call srso_alias_safe_ret", X86_FEATURE_SRSO_ALIAS
	int3 //  <--- *MISSING*
SYM_FUNC_END(foo)

Bonus points if I can compile time tell if a compiler DTRT, feature flag
or what have you in the preprocessor would be awesome.
