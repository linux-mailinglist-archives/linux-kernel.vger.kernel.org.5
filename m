Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156767DF199
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbjKBLq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjKBLqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:46:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7409137
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vpp2Uxr7P1r+KWM6T9cEExjrYczEsClmj3xLm7KkeJ4=; b=i1iywDuXiIwiloBmtE1zOwLAdq
        12wJ0w9end9erLtLUmTNn9VqpmIIcbUgP3TqeoL5pL46Mt6rOqDd0LGy5k79y0b6oMC6g+QsbxLBL
        rcKyRf8cVbWWkFY1jSPOvT4GsJimNxvxviDY+1jgtrBc4HrjmMajm3MWaSy8MprJ5kjzUZrNBe1ff
        cXxXZjVWX8PvNmySpdO/fmd3qzp+0owmF4TnibGTfh+w4fhUPby3dNFsHhPIxQzWtNPx9bh8dudIc
        3wKPD6zbroSWFZhh0kE943qBoV+nLDy9u4xt+ODdhWfA6x/I9ZBxDfRMUVfvnql6C8F0f2b8qFa+P
        32d0uvlw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qyW7b-004G9W-4A; Thu, 02 Nov 2023 11:44:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE7A93004AB; Thu,  2 Nov 2023 12:44:22 +0100 (CET)
Date:   Thu, 2 Nov 2023 12:44:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/3] x86/callthunks: Handle %rip-relative relocations in
 call thunk template
Message-ID: <20231102114422.GB3818@noisy.programming.kicks-ass.net>
References: <20231102112850.3448745-1-ubizjak@gmail.com>
 <20231102112850.3448745-3-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102112850.3448745-3-ubizjak@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 12:25:47PM +0100, Uros Bizjak wrote:

> @@ -166,13 +168,51 @@ static const u8 nops[] = {
>  	0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90,
>  };
>  
> +#define apply_reloc_n(n_, p_, d_)				\
> +	do {							\
> +		s32 v = *(s##n_ *)(p_);				\
> +		v += (d_);					\
> +		BUG_ON((v >> 31) != (v >> (n_-1)));		\
> +		*(s##n_ *)(p_) = (s##n_)v;			\
> +	} while (0)
> +
> +static __always_inline
> +void apply_reloc(int n, void *ptr, uintptr_t diff)
> +{
> +	switch (n) {
> +	case 4: apply_reloc_n(32, ptr, diff); break;
> +	default: BUG();
> +	}
> +}
> +
> +static void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src)
> +{
> +	for (int next, i = 0; i < len; i = next) {
> +		struct insn insn;
> +
> +		if (WARN_ON_ONCE(insn_decode_kernel(&insn, &buf[i])))
> +			return;
> +
> +		next = i + insn.length;
> +
> +		if (insn_rip_relative(&insn))
> +			apply_reloc(insn.displacement.nbytes,
> +				    buf + i + insn_offset_displacement(&insn),
> +				    src - dest);
> +	}
> +}

Isn't it simpler to use apply_relocation() from alternative.c?

Remove static, add decl, stuff like that?
