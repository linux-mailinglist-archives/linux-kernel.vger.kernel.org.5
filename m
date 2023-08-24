Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859A07866D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbjHXEnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbjHXEnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:43:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47FB10E4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:43:15 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E7801EC04CD;
        Thu, 24 Aug 2023 06:43:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692852193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=B8NpXQxKGZgz1rZwZxC5RTfWq223qMj1uQPFU9SUTck=;
        b=Is1BNA0Eb7VfZzW9ERg+X/Ze0BxHgIF8z4/o7djBjT/dVIhYKEipttmp9kBVmApcc5DsuZ
        w6wltdafRLY2VovTRVJ0qEPlrjXiQsEAuEzyPYyEqQdBennSIFJRhyiAE3I/eKubzihxz9
        2PSnfUKmxLs1mSK1kc987cD6SpKGe4E=
Date:   Thu, 24 Aug 2023 06:43:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 08/22] x86/srso: Downgrade retbleed IBPB warning to
 informational message
Message-ID: <20230824044326.GCZObf7lYYkx0XvICT@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <49b321ad997bce6068c694a6cd0ecdcd5cd2a1e4.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49b321ad997bce6068c694a6cd0ecdcd5cd2a1e4.1692580085.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 06:19:05PM -0700, Josh Poimboeuf wrote:
> This warning is nothing to get excited over.  Downgrade to pr_info().
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/kernel/cpu/bugs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index cda4b5e6a362..e59e09babf8f 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2425,7 +2425,7 @@ static void __init srso_select_mitigation(void)
>  
>  	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
>  		if (has_microcode) {
> -			pr_err("Retbleed IBPB mitigation enabled, using same for SRSO\n");
> +			pr_info("Retbleed IBPB mitigation enabled, using same for SRSO\n");
>  			srso_mitigation = SRSO_MITIGATION_IBPB;
>  			goto pred_cmd;
>  		}
> -- 

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
