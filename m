Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C442F7C02F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjJJRsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjJJRsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:48:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CBD99
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m7DQWBMz8yLU63XLUakLZSqJHmYw8jWnqgK8hjlHCfw=; b=OtehqaCgzj8JHUVLeIgT20tOws
        TAH65SYQlbthMPK0xK9AaonDMcE2tYOliylEjtUZSOGEVJdLNVP603y3DFr2BTWDGgHRvFXGirdvw
        nxRNfhjJ/l9AOGdkRfKJA+bOixvgm2TS399aSCe0D5U176kLRAzDRfT/jWXlb3XLAUSnOoUzWCWXU
        CaBEWO3nuJ0sYkE59uTkl5w4iIXP5B6sixr91j+01i/wv5NznyyIRktZA+iiVFVjDO19HtFsN8gfF
        8d6MjUQuwLGINQgvPvg/HcENpg230aRGVziLIPfKpQ4/WKpj6C1KHOcoLXU7DmRKdNNmWsihEuVsp
        dWsRnZMw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqGqQ-005wuc-5r; Tue, 10 Oct 2023 17:48:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2FD4300392; Tue, 10 Oct 2023 19:48:33 +0200 (CEST)
Date:   Tue, 10 Oct 2023 19:48:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Kaplan <david.kaplan@amd.com>
Cc:     x86@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 1/3] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Message-ID: <20231010174833.GG14330@noisy.programming.kicks-ass.net>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-2-david.kaplan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010171020.462211-2-david.kaplan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:10:18PM -0500, David Kaplan wrote:

>  arch/x86/kernel/vmlinux.lds.S | 3 +++
>  arch/x86/lib/retpoline.S      | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 9cdb1a7332c4..54a5596adaa6 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -132,7 +132,10 @@ SECTIONS
>  		LOCK_TEXT
>  		KPROBES_TEXT
>  		SOFTIRQENTRY_TEXT
> +#ifdef CONFIG_RETPOLINE
>  		*(.text..__x86.indirect_thunk)
> +		*(.text..__x86.return_thunk)
> +#endif
>  		STATIC_CALL_TEXT
>  
>  		ALIGN_ENTRY_TEXT_BEGIN
> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index db813113e637..3da768a71cf9 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -129,6 +129,8 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
>  
>  #ifdef CONFIG_RETHUNK

Perhaps elucidate the future reader with a comment here? Lest someone
tries removing it again.

>  
> +	.section .text..__x86.return_thunk
> +
>  #ifdef CONFIG_CPU_SRSO
