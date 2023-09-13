Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B185D79E8FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbjIMNR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbjIMNR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:17:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBE219B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LNTqy0CV/JnynyYe79VWfpo9fPHgFzgy3uVMFceLvNc=; b=kpxb6q4OP++hIlMwJ5ZN3CIhUZ
        VCJIVMl6Vba6ND6cWuw14N4CV8UduQxM7MaUyTaXyO8Gi8sa4gHx8zq7PscLCzDJUXXdgjPwfxbEF
        7ngg1QwtgovVaEMI6Yp3v6NHyihYDB6dk446ihCBtYjh+9rQYqJXYeQFBrbxzbbGk7KjU/35/haGL
        L0pbLleYxOYGdT7AtxIQlVsfBSu2WZYCho7oQG5Hz5VvpcZimDwRxLgwApv29eOpSxtN5l2JQ7iEa
        jw3MlFaJ+K2ophRgXcCxiVKP9grjjz8sG0D8nesKFX1AgCRa1GVzbGR2YN/2eznXPodbKTpPGgvdM
        +YqWqv2Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgPk3-0073t3-0N;
        Wed, 13 Sep 2023 13:17:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39785300451; Wed, 13 Sep 2023 15:17:16 +0200 (CEST)
Date:   Wed, 13 Sep 2023 15:17:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Babu Moger <babu.moger@amd.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC 4/4] x86/srso: Use CALL-based return thunks to reduce
 overhead
Message-ID: <20230913131716.GB22758@noisy.programming.kicks-ass.net>
References: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
 <20230821112723.3995187-5-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821112723.3995187-5-andrew.cooper3@citrix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:27:23PM +0100, Andrew Cooper wrote:

> 
>   vmlinux.o: warning: objtool: srso_fam17_return_thunk(): can't find starting instruction
> 

> @@ -288,26 +283,22 @@ SYM_START(srso_fam17_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
>   * and execution will continue at the return site read from the top of
>   * the stack.
>   */
> -SYM_INNER_LABEL(srso_fam17_safe_ret, SYM_L_GLOBAL)
> +SYM_INNER_LABEL(srso_fam17_return_thunk, SYM_L_GLOBAL)

This srso_safe_ret -> srso_fam17_safe_ret you forgot in the last patch,
is then here renamed yet again to srso_fam17_return_thunk.

And there is your objtool splat.

> +	UNWIND_HINT_FUNC
> +	ANNOTATE_NOENDBR
>  	lea 8(%_ASM_SP), %_ASM_SP
> +	ANNOTATE_UNRET_SAFE
>  	ret
>  	int3
>  	int3
>  	/* end of movabs */
>  	lfence
> -	call srso_fam17_safe_ret
> +	call srso_fam17_return_thunk
>  	ud2
> -SYM_CODE_END(srso_fam17_safe_ret)
> +SYM_CODE_END(srso_fam17_return_thunk)
>  SYM_FUNC_END(srso_fam17_untrain_ret)
>  __EXPORT_THUNK(srso_fam17_untrain_ret)
>  
