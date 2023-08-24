Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066F5786AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbjHXJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbjHXJBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:01:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B224B1987
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:01:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692867679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s7VSepTzq6Nzp7ENl0zwOdnjoyoTXch0C00nzIIkbHI=;
        b=qfdzrsTLTVhxn7JpgVmDAxskzg+zAO60QpTxO1ow95h8dmW68Eeb7Sfq45msJxzni4Vt4S
        7qgxy75wWCMEpYId1vO8oTFj/uhIdv0zEoIqd+DAVyTsNfKFZb+9IHOSlc/JaR3Il/8iYw
        +OtiaIUUfOgApiZQwPiqnRenrPBMwQLnBuhDKjw0+UeD4h5Pt4PVnT38m9iKlXegaC56bv
        i/oe3emPlj2gRB/u5tB6DjCyG3QyqLteaOkH5sjv9A6XwlBANL/+CylHF0cBho5cVKyZCc
        Xum/j91oi83ol2iVcxZRVCAg5QkhNcSgipwafAdRNFcEs4o0L6QqqLkbcZw47g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692867679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s7VSepTzq6Nzp7ENl0zwOdnjoyoTXch0C00nzIIkbHI=;
        b=pN31rc3K6i8ibEbaMfGQuKUzmd/XuuckU1SkXDvXHd+KazpT0UElPvv/8tAU/PimPxxMSv
        T2QnLQoQeWvNioAQ==
To:     Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH] x86/fpu: set X86_FEATURE_OSXSAVE feature after enabling
 OSXSAVE in CR4
In-Reply-To: <20230823065747.92257-1-feng.tang@intel.com>
References: <20230823065747.92257-1-feng.tang@intel.com>
Date:   Thu, 24 Aug 2023 11:01:18 +0200
Message-ID: <87r0nsddb5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23 2023 at 14:57, Feng Tang wrote:
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 0bab497c9436..8ebea0d522d2 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -173,6 +173,9 @@ void fpu__init_cpu_xstate(void)
>  
>  	cr4_set_bits(X86_CR4_OSXSAVE);
>  
> +	if (!boot_cpu_has(X86_FEATURE_OSXSAVE))
> +		setup_force_cpu_cap(X86_FEATURE_OSXSAVE);

This is wrong in several aspects:

     1) You force the feature bit _before_ XSAVE is completely
        initialized. fpu__init_system_xstate() has error paths which
        disable XSAVE.

     2) This conditional should have been a red flag for you simply
        because fpu__init_cpu_xstate() is invoked on all CPUs not only
        on the BSP.

I fixed it up and added a proper comment explaining it.
