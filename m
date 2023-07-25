Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF497617A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjGYLvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjGYLvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:51:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AF91BFB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qs9aIHxvGs/ZvYLXe8hAdFKBmlXaFFAnAGBJ7IDUsxo=; b=RB00+q9B5TjXtH5OkWXuFm9gq9
        z5JLXBEJgGoDx5tPePtZcy15IzEDbI7Lys/qpaTDiPfwFjT4H0jdzO1mQBoe84ljUVCtUpQXztZ36
        Fb4xT1dvOGsjVwbMqB7XIBEmrfmsXFlDdQvdhuAq8q/mD3hJ29tRrOcNiQit+o+xSg7yejRjE/WjM
        ZkmIxoW42W2pjoldglKhUfkGE91ozKMx8SLyPzZDct1ZyIMJyhAUd3QdvtjhHzlpry16lSiy+waC2
        b9PsC+8qGR3lbBSBDT+huwrgBdTEnd0jO/yDf1JwBiJnhS/J4lyGAnkI+Ukji+0rjJ/tQzXYPECI8
        VZD/WBrw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOGZI-005Quq-N5; Tue, 25 Jul 2023 11:51:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2A8C300137;
        Tue, 25 Jul 2023 13:51:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8F252612ABE5; Tue, 25 Jul 2023 13:51:06 +0200 (CEST)
Date:   Tue, 25 Jul 2023 13:51:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v1 4/6] objtool/LoongArch: Enable orc to be built
Message-ID: <20230725115106.GC3765278@hirez.programming.kicks-ass.net>
References: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
 <1690272910-11869-5-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690272910-11869-5-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 04:15:08PM +0800, Tiezhu Yang wrote:

Previous Changelog had:

> Define update_cfi_state() as a weak function which may be overwritten
> by the arch-specific implementation.

And then this patch does:

> +int update_cfi_state(struct instruction *insn,
> +		     struct instruction *next_insn,
> +		     struct cfi_state *cfi, struct stack_op *op)
> +{
> +	struct cfi_reg *cfa = &cfi->cfa;
> +	struct cfi_reg *regs = cfi->regs;
> +
> +	/* ignore UNWIND_HINT_UNDEFINED regions */
> +	if (cfi->force_undefined)
> +		return 0;
> +
> +	/* stack operations don't make sense with an undefined CFA */
> +	if (cfa->base == CFI_UNDEFINED) {
> +		if (insn_func(insn)) {
> +			WARN_INSN(insn, "undefined stack state");
> +			return -1;
> +		}
> +		return 0;
> +	}
> +
> +	if (cfi->type == UNWIND_HINT_TYPE_REGS ||
> +	    cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL)
> +		return update_cfi_state_regs(insn, cfi, op);
> +
> +	switch (op->dest.type) {
> +	case OP_DEST_REG:
> +		switch (op->src.type) {
> +		case OP_SRC_ADD:
> +			if (op->dest.reg == CFI_SP && op->src.reg == CFI_SP) {
> +				/* addi.d sp,sp,si12 */
> +				cfi->stack_size -= op->src.offset;
> +				if (cfa->base == CFI_SP)
> +					cfa->offset -= op->src.offset;
> +			} else if (op->dest.reg == CFI_FP && op->src.reg == CFI_SP) {
> +				/* addi.d fp,sp,si12 */
> +				if (cfa->base == CFI_SP && cfa->offset == op->src.offset) {
> +					cfa->base = CFI_FP;
> +					cfa->offset = 0;
> +				}
> +			} else if (op->dest.reg == CFI_SP && op->src.reg == CFI_FP) {
> +				/* addi.d sp,fp,si12 */
> +				if (cfa->base == CFI_FP && cfa->offset == 0) {
> +					cfa->base = CFI_SP;
> +					cfa->offset = -op->src.offset;
> +				}
> +			}
> +			break;
> +		case OP_SRC_REG_INDIRECT:
> +			/* ld.d rd,sp,si12 */
> +			if (op->src.reg == CFI_SP &&
> +			    op->src.offset == (regs[op->dest.reg].offset + cfi->stack_size)) {
> +				restore_reg(cfi, op->dest.reg);
> +				/* GCC may not restore sp, we adjust it directly. */
> +				if (cfa->base == CFI_FP && cfa->offset == 0) {
> +					cfa->base = CFI_SP;
> +					cfa->offset = cfi->stack_size;
> +				}
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case OP_DEST_REG_INDIRECT:
> +		if (op->src.type == OP_SRC_REG)
> +			/* st.d rd,sp,si12 */
> +			if (op->dest.offset)
> +				save_reg(cfi, op->src.reg, CFI_CFA,
> +					 op->dest.offset - cfi->stack_size);
> +		break;
> +	default:
> +		WARN_FUNC("unknown stack-related instruction", insn->sec, insn->offset);
> +		return -1;
> +	}
> +
> +	return 0;
> +}

Why ?!? what is the actual irreconcilable difference?

If you want us to review this, you'll have to explain things.
