Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62996782B11
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjHUOAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbjHUOAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:00:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF737BE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:00:09 -0700 (PDT)
Received: from nazgul.tnic (dynamic-089-015-236-044.89.15.236.pool.telefonica.de [89.15.236.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A9161EC0103;
        Mon, 21 Aug 2023 16:00:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692626407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZoHKnHNaxNUF4nN6/spTMrlYIZuhKTyY4KTcJqNbxiU=;
        b=cajTSI8jeuQFES2X4yoFHUN3RqbCOZMYqHZmR+8qgcF7M6hRkgcRaCiBQt0Vx5gW0ulx+/
        YxoQOsHD6teqW1mQExzLvE3k/SrKlF/e0kQ/lgirjzMky8fo2w5l3e2FzQ4YpedDO/jYW4
        7EpN0FbBybjonIF7txdyHrltpDgYpOI=
Date:   Mon, 21 Aug 2023 15:59:57 +0200
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
Subject: Re: [PATCH 02/22] x86/srso: Set CPUID feature bits independently of
 bug or mitigation status
Message-ID: <20230821135957.GAZONt3W2U/krVX9jH@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <caf4d0a1233ccc1c33f4ff8d3fe302c9289f4bea.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <caf4d0a1233ccc1c33f4ff8d3fe302c9289f4bea.1692580085.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 06:18:59PM -0700, Josh Poimboeuf wrote:
> Booting with mitigations=off incorrectly prevents the
> X86_FEATURE_{IBPB_BRTYPE,SBPB} CPUID bits from getting set.
> 
> Also, future CPUs without X86_BUG_SRSO might still have IBPB with branch
> type prediction flushing, in which case SBPB should be used instead of
> IBPB.  The current code doesn't allow for that.
> 
> Also, cpu_has_ibpb_brtype_microcode() has some surprising side effects
> and the setting of these feature bits really doesn't belong in the
> mitigation code anyway.  Move it to earlier.
> 
> Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/include/asm/processor.h |  2 --
>  arch/x86/kernel/cpu/amd.c        | 28 +++++++++-------------------
>  arch/x86/kernel/cpu/bugs.c       | 13 +------------
>  3 files changed, 10 insertions(+), 33 deletions(-)

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
