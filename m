Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EEE7880D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbjHYH0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjHYHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:25:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5270E1FC7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:25:37 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C1B371EC0338;
        Fri, 25 Aug 2023 09:25:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692948336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sbjaBP5z4PAmNwFYPYu1h+80zjUz7A6a7TBK/xVe4e0=;
        b=BFwWPkCHMB8j3WCE6iweWqDSNvDJ67nsNWs0asj3SKB1LHb5nMi1X7m/at0XxX1qSa1vfc
        i08K7O3rUIbeq3hF3kX/tLGXp+1YuzCyBUDmUhX6y7I/qd7GNidPW9oNnzz+Edk1tzgA6h
        xDDQnRRz1GvHe0y9Hd93a7xVEnCvlGo=
Date:   Fri, 25 Aug 2023 09:25:42 +0200
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
Subject: Re: [PATCH 13/22] x86/srso: Fix vulnerability reporting for missing
 microcode
Message-ID: <20230825072542.GFZOhXdgXpUidW51lC@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <eb3742847f3f374fb1761e8284890792ebcfaea1.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb3742847f3f374fb1761e8284890792ebcfaea1.1692580085.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 06:19:10PM -0700, Josh Poimboeuf wrote:
> + * 'Vulnerable: Safe RET, no microcode':
> +
> +   The "Safe Ret" mitigation (see below) has been applied to protect the

s/Ret/RET/

> @@ -2456,7 +2463,10 @@ static void __init srso_select_mitigation(void)
>  				setup_force_cpu_cap(X86_FEATURE_SRSO);
>  				x86_return_thunk = srso_return_thunk;
>  			}
> -			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
> +			if (has_microcode)
> +				srso_mitigation = SRSO_MITIGATION_SAFE_RET;
> +			else
> +				srso_mitigation = SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED;
>  		} else {
>  			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
>  		}

You missed one "no microcode" here at out_print:

[    0.553950] Speculative Return Stack Overflow: Vulnerable: Safe RET, no microcode, no microcode

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
