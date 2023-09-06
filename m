Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9592794418
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbjIFT6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243634AbjIFT6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:58:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE2B1BC3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Axsa9zJW+eC7m29fyYEzz33sTSDLk02wkvemBCnaKs=; b=J+2sOkI4p7HBILqvkRZPZrmKXb
        6lvNuKz3JPuXo2FxgaAqZhB/z4ROkwF7PeiLjEGG/Cv8m9t9tjzBxSF9ZqzNGKq73l9qTp5ouLoD+
        aO6b6ajTfnG4BzSsclu6BFq/SEs8dLL6HCEG0XUg3OigqMMTyLCpr1uuKYLqDGgLAklEZmxS/BIum
        iAqrXcox4HEYr+LrftpqGS6IAljL2zwzh/no+PD7FjPabnMOKAsDWYuXgfJGESHtNtPGwGG9//Wv8
        6xeJkPA5vpEH6SUstLclN+OLgTO4zf9odZ1Ph/Um5WtmlwuSEWg0CSX5x505SGH8KdHczwpqzo+bc
        mESB80GA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdyfF-001FmQ-16;
        Wed, 06 Sep 2023 19:58:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6976D300422; Wed,  6 Sep 2023 21:58:14 +0200 (CEST)
Date:   Wed, 6 Sep 2023 21:58:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Subject: Re: [PATCH] x86/vmlinux: Fix linker fill bytes for ld.lld
Message-ID: <20230906195814.GE28278@noisy.programming.kicks-ass.net>
References: <20230906175215.2236033-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906175215.2236033-1-song@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:52:15AM -0700, Song Liu wrote:
> With ":text =0xcccc", ld.lld fills unused text area with 0xcccc0000.
> Example objdump -D output:
> 
> ffffffff82b04203:       00 00                   add    %al,(%rax)
> ffffffff82b04205:       cc                      int3
> ffffffff82b04206:       cc                      int3
> ffffffff82b04207:       00 00                   add    %al,(%rax)
> ffffffff82b04209:       cc                      int3
> ffffffff82b0420a:       cc                      int3
> 
> Replace it with ":text =0xcccccccc", so we get the following instead:
> 
> ffffffff82b04203:       cc                      int3
> ffffffff82b04204:       cc                      int3
> ffffffff82b04205:       cc                      int3
> ffffffff82b04206:       cc                      int3
> ffffffff82b04207:       cc                      int3
> ffffffff82b04208:       cc                      int3
> 
> gcc/ld doesn't seem to have the same issue. The generated code stays the
> same for gcc/ld.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: x86@kernel.org
> Signed-off-by: Song Liu <song@kernel.org>

Please provide a Fixes tag, I'm thinking this (otherwise trivial commit)
wants to be backported for sanity.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 83d41c2601d7..41d56fb9bf92 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -156,7 +156,7 @@ SECTIONS
>  		ALIGN_ENTRY_TEXT_END
>  		*(.gnu.warning)
>  
> -	} :text =0xcccc
> +	} :text =0xcccccccc
>  
>  	/* End of text section, which should occupy whole number of pages */
>  	_etext = .;
> -- 
> 2.34.1
> 
