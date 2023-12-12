Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222C680F7ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377354AbjLLUa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjLLUa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:30:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DD4CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:30:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46CFC433C7;
        Tue, 12 Dec 2023 20:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702413033;
        bh=lJ7TjUTNGLGKt05CTrfDgwIXhWJ2nCGi3+BsvF6xJp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggi7OEoGg12Dr3HRp9DDY87kc5CkZEFVrsUnbPggPaOC/K0bLHhYa0sVRR3qGMMkJ
         Xcs5Gw25L9wi3JNPcFP0KmPytLmDnLGi67hjAnPE7ATJe+TOLBCGVc2IlBWYHkwsfn
         QvUD2LOrX+sN7uTbhGTCWuA6UBySotNAfT8Iz+huk1QEAMRd68r5hw547iBCEdWoNT
         KGKWrMJN8K2+OqbrBKqBYG/B4R2wDK2LsTQOBGDbcbiyOa3ocgAR50odWWW6xyjN7w
         di+yrBO4VISZRzes1I4eP0lyGQzsGxbrRZSuFUjbD9JELtIR1yiAbhLAcCOb7mNBN1
         IqbEU13R+skDA==
Date:   Tue, 12 Dec 2023 12:30:31 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Make objtool check actually fatal upon fatal
 errors
Message-ID: <20231212203031.uudk57xhegi5yziz@treble>
References: <20231212185339.1562967-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212185339.1562967-1-dimitri.ledkov@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 06:53:38PM +0000, Dimitri John Ledkov wrote:
> Currently function calls within check() are sensitive to fatal errors
> (negative return codes) and abort execution prematurely. However, in
> all such cases the check() function still returns 0, and thus
> resulting in a successful kernel build.
> 
> The only correct code paths were the ones that escpae the control flow
> with `return ret`.
> 
> Make the check() function return `ret` status code, and make all
> negative return codes goto that instruction. This makes fatal errors
> (not warnings) from various function calls actually fail the
> build. E.g. if create_retpoline_sites_sections() fails to create elf
> section pair retpoline_sites the tool now exits with an error code.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>

We had problems trying this before, but we can try again.  Maybe we'll
have better luck now :-)

>  	if (opts.orc && nr_insns) {
>  		ret = orc_create(file);
>  		if (ret < 0)
>  			goto out;
>  		warnings += ret;
>  	}
>  
>  	free_insns(file);
>  
>  	if (opts.verbose)
>  		disas_warned_funcs(file);
>  
>  	if (opts.stats) {
>  		printf("nr_insns_visited: %ld\n", nr_insns_visited);
>  		printf("nr_cfi: %ld\n", nr_cfi);
>  		printf("nr_cfi_reused: %ld\n", nr_cfi_reused);
>  		printf("nr_cfi_cache: %ld\n", nr_cfi_cache);
>  	}
>  
>  out:
>  	/*
>  	 *  For now, don't fail the kernel build on fatal warnings.  These
>  	 *  errors are still fairly common due to the growing matrix of
>  	 *  supported toolchains and their recent pace of change.
>  	 */
> -	return 0;
> +	return ret;

Here it should check for ret < 0, since orc_create() or some other
function might have returned non-fatal warnings (ret > 0).

Also the comment is no longer relevant.

-- 
Josh
