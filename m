Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAC277CBA7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbjHOLZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbjHOLZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:25:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3537FE73
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bCJjNR6nUpI/K29p3igoc4+HK5NIvHS1+F6LWx1yohM=; b=TN7k4zT4L0gdAOuVbzB1+NU4o1
        d5yYHTmiMOhI9+ztAURyZHRBNwVXzGPmgteuGAj58HvPfeawxE4VwC1Gzr5yIEUi/IhsuLUurZFli
        HjG0EDIEhkFURS9QxSKOf8tPKQwAQ79VUO66REfmMF+R+XLEgYBuXHepyYse8pBtGs/fipf0j1gJQ
        MjtGnQNgoRFu0jjRnMfS159ke7iRcE7rZLYKpKomQkbVXiIs5URcdQkEPG310pgnvnsK85zT0e37f
        5E4Pw4zqiR8GFu+7f1D2C5+yG189US8XjEnjJaixGVSQ/WN1HSZFm/SO7OAql74j9MjvnNUXmwv3g
        t9gYeyGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVsAu-007uQu-7R; Tue, 15 Aug 2023 11:25:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AAD1730020B;
        Tue, 15 Aug 2023 13:25:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C94F2074B3D9; Tue, 15 Aug 2023 13:25:23 +0200 (CEST)
Date:   Tue, 15 Aug 2023 13:25:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86_64: Show CR4.PSE on auxiliaries like on BSP
Message-ID: <20230815112523.GB927051@hirez.programming.kicks-ass.net>
References: <103ad03a-8c93-c3e2-4226-f79af4d9a074@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <103ad03a-8c93-c3e2-4226-f79af4d9a074@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 07:53:18PM -0700, Hugh Dickins wrote:
> Set CR4.PSE in secondary_startup_64: the Intel SDM is clear that it does
> not matter whether it's 0 or 1 when 4-level-pts are enabled, but it's
> distracting to find CR4 different on BSP and auxiliaries - on x86_64,
> BSP alone got to add the PSE bit, in probe_page_size_mask().

Specifically I think the point is that PSE bit is completely without
meaning in long mode IIRC.

But yes, having the same CR4 bits set across BSP and APs is definitely
sane.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  arch/x86/kernel/head_64.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index c5b9289837dc..72e36739c407 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -181,8 +181,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	movl	$0, %ecx
>  #endif
>  
> -	/* Enable PAE mode, PGE and LA57 */
> -	orl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
> +	/* Enable PAE mode, PSE, PGE and LA57 */
> +	orl	$(X86_CR4_PAE | X86_CR4_PSE | X86_CR4_PGE), %ecx
>  #ifdef CONFIG_X86_5LEVEL
>  	testl	$1, __pgtable_l5_enabled(%rip)
>  	jz	1f
> -- 
> 2.35.3
> 
