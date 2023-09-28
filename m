Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707197B18A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjI1KwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjI1KwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:52:22 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0266F195
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 03:52:20 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0652A40E014B;
        Thu, 28 Sep 2023 10:52:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ey6FPwKvaptu; Thu, 28 Sep 2023 10:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695898336; bh=xJ6aFn8v3LBAnMvkAcywq78rcq0pyCNw2EB/XQaoHdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDB09o3E/j1fc0tQQXCSz1PsD79qZlpxII0Rz2xS2AZ2o/Y3J7HkV5LCiNG+zUmT3
         8ONqBrnjoUYzxAcJ77DIPe83GhwYHwebH0nedmgY7YT6Q88jKhLPNYKn4KvedW5wTr
         UZjr75hRwUTIAFU+sl1qfVY6xZXl4q2mwR35VZESIaSOAEii1e4a/YLnSugNDfQohQ
         4EdMBKfVdYock3f/6W/XTD7Y0Q8ZWRs4Q7mz5YT/RbUjrxKWyiyuSVaMixaYIRKLGe
         3OkgbZBfF3e65syubYluH7+61qiOyfmOT3DWE7R8viIF0g7AODJM4v11ri+KN1OHxV
         Mry7R31ev8iP815UK19hwNZvzxKo9E2r9E557G7RHv7BVPlGhQ4v3Q+lMkHwmWvEEL
         yrhEYV3qdNtDGFdotIXrNki9z8U70D6+/eYkpHewc2VHT+vW5Uvi/xZMD/F68swDyD
         fipRMIrUGOUWKtuoBCsZdXkyiBQc+PUp9CqJmFVwTVUGgXCcTxscGBA++hYhGpOXm0
         /OU2sTlMXIxIsY9memtpfH7OK2wkb9eAPEu484CBrK19gV3AMULv4ExhSYQ3Yp+phh
         xeUWRl4EQnmjW38Hw6HyckA0O8gQzVoKy4cDO2wZrUgbyjY+s7MNSZPgLx1K7AaoMF
         MyBzDBVXnLw6XJAXQYAv1gAM=
Received: from nazgul.tnic (unknown [2.247.242.78])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17B1D40E0176;
        Thu, 28 Sep 2023 10:52:09 +0000 (UTC)
Date:   Thu, 28 Sep 2023 12:52:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 26/30] x86/microcode: Protect against instrumentation
Message-ID: <20230928105205.GAZRVa1Rl0CPi-_cxX@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.386652173@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065502.386652173@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:58:24AM +0200, Thomas Gleixner wrote:
>  	for (timeout = 0; timeout < USEC_PER_SEC; timeout++) {
> -		if (!atomic_read(cnt))
> +		if (!raw_atomic_read(cnt))
>  			return true;
> -		udelay(1);
> +
> +		for (loops = 0; loops < loops_per_usec; loops++)
> +			cpu_relax();
> +

Ah, you're dropping udelay because it is not noinstr...

> @@ -427,25 +464,43 @@ static void ucode_load_primary(unsigned
>  	}
>  }
>  
> -static bool microcode_update_handler(void)
> +static noinstr bool microcode_update_handler(void)
>  {
> -	unsigned int cpu = smp_processor_id();
> +	unsigned int cpu = raw_smp_processor_id();
>  
> -	if (this_cpu_read(ucode_ctrl.ctrl_cpu) == cpu)
> +	if (raw_cpu_read(ucode_ctrl.ctrl_cpu) == cpu) {
> +		instrumentation_begin();
>  		ucode_load_primary(cpu);
> -	else
> +		instrumentation_end();

Might as well make the load on the primary noinstr too. I wouldn't lose
any sleep over the late microcode loading code not being traceable.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
