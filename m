Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5A57777B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjHJMAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjHJMAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:00:18 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEBD268E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:00:17 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4248240E01A0;
        Thu, 10 Aug 2023 12:00:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pzsgd5F78_jl; Thu, 10 Aug 2023 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691668812; bh=wLtlz8RK2hza+xABI6/bNAx9i8IEvYhy94CIVlApHlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z5g59cRnemy1FACk0QAX9BGR/BJQBVEZQrW8Aw8DrReyUhi0lcPu3NmBXgYbjImcV
         +bcbC+RpJkjpBlq/WtNJSZWBuzKgukPUEF8wWI+nWfsrq0tk3CPLYDG1e6oipaJa0H
         zlR+lwL065xBP3M15BlDKwVdLsMg4FBO8+KhOTNQ+UYkVKL+xPQJf2b5sd9iYT21F8
         kr9joM7ETt3V92PVk7kNcGTS7eqaT76cUXwTdRud5KntXMqzUeW+/oe0DSN0l4iADP
         RgiVD8NF+EcTeoCPpmLaaJ4ezKI8zfkYPFpaV9JJjrp0/4FxsGgoiix3Qij6wy5uLS
         aFPQV9M2TwYFiNvWTcG+x5xWkgPGGi5ODcUnqU1vv4so5EK8TR+aYkx9WWDYGJSMy2
         wnRRZz3GsuzcycesxGqyaZmT53X9vVd6mrgZ7OITm4Dj1B2xNKkh+JP7Ynq3ob/yUK
         7ZIc1uvLFgR/9vO2KMS0bUnlLYx5tpEKN3L4rj1hRGEoofqpt/9hDW9PfR8+qWNBQ7
         kc0dzxe6vpafADiAmBz3vCnTX3F/ModiSaaI50/YMaWU1CWqni8bobrRielhtKFA1V
         vVqyW2PWUWFL1mOvWBhK1bS3QfzIsqduF57RpEwlfW9vextoA+EWYLeU1KQ7lLep/C
         Bl6Y6WRt13JxvIr0RfSc7Zn0=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A98B40E0185;
        Thu, 10 Aug 2023 12:00:05 +0000 (UTC)
Date:   Thu, 10 Aug 2023 14:00:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 03/17] x86/cpu: Make srso_untrain_ret consistent
Message-ID: <20230810120004.GFZNTRRPGlJuSBy8Du@fat_crate.local>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.646688083@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809072200.646688083@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:12:21AM +0200, Peter Zijlstra wrote:
> This does change srso_untrain_ret a little to be more consistent with
> srso_alias_untrain_ret (and zen_untrain_ret). Specifically I made
> srso_untrain_ret tail-call the srso_return_thunk, instead of doing the
> call directly. This matches how srso_alias_untrain_ret amd
> zen_untrain_ret also tail-call their respective return_thunk.
> 
> If this is a problem this can be easily fixed and a comment added to
> explain -- but this way they all end with a tail-call to their own
> return-thunk, which is nice and consistent.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/lib/retpoline.S |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -262,7 +262,7 @@ SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLO
>  	int3
>  	/* end of movabs */
>  	lfence
> -	call srso_safe_ret
> +	jmp srso_return_thunk
>  	int3
>  SYM_CODE_END(srso_safe_ret)
>  SYM_FUNC_END(srso_untrain_ret)

I don't see a problem with it but I'd let David comment here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
