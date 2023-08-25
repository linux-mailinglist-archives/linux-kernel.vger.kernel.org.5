Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAC47880A0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjHYHJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbjHYHJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:09:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAB11B2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:09:32 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB5881EC0338;
        Fri, 25 Aug 2023 09:09:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692947371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LwoXIyU5IlYx8qU6cDl7+Ob/m7JucFSg8dhhhRcSGUc=;
        b=WHSp2o6oAillS6J2RfnIWi3Swm4j4ioz0NXFKa1QknIkAJzwdY4aCMWJThM8zA6Pi9x5VF
        UaPyFb0bvU2gwHqqzv33U49+M38L5G4/4B5av2jBDlRml/5a7Cy2pYoQlmSA4DL3IIloTp
        4K0hIfsrWU2+6dPSioOZIJtk6iqHPVU=
Date:   Fri, 25 Aug 2023 09:09:36 +0200
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
Subject: Re: [PATCH 12/22] x86/srso: Remove redundant X86_FEATURE_ENTRY_IBPB
 check
Message-ID: <20230825070936.GEZOhTsPiTLhY1i9xH@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <bb018289827a8709d11b22f28345690753597fa5.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb018289827a8709d11b22f28345690753597fa5.1692580085.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 06:19:09PM -0700, Josh Poimboeuf wrote:
> The X86_FEATURE_ENTRY_IBPB check is redundant here due to the above
> RETBLEED_MITIGATION_IBPB check.  RETBLEED_MITIGATION_IBPB already
> implies X86_FEATURE_ENTRY_IBPB.  So if we got here and 'has_microcode'
> is true, it means X86_FEATURE_ENTRY_IBPB is not set.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/kernel/cpu/bugs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index b27aeb86ed7a..aeddd5ce9f34 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2475,7 +2475,7 @@ static void __init srso_select_mitigation(void)
>  
>  	case SRSO_CMD_IBPB_ON_VMEXIT:
>  		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
> -			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
> +			if (has_microcode) {
>  				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
>  				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
>  			}

Well, frankly, I'd prefer to keep this check explicit as it is also
documenting the situation. And it is also protecting against future,
potential mistakes done while refactoring. And it is not such a complex
condition so that it stands in the way and makes the code too
unreadable, while removing it makes it a bit too subtle considering the
amazing maze we're in.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
