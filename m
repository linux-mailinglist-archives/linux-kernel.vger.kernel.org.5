Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22177A97EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjIUR2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjIUR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:28:02 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755F24F385
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:15:47 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4D68040E01A5;
        Thu, 21 Sep 2023 10:07:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1-bsyjNbzYQo; Thu, 21 Sep 2023 10:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695290848; bh=i5LLD7WLnKBMdVSUtI3jdRxCSy7DasvEpR6qADkCZ1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/7VsC4kL1JYkns/HwzYpKZ8CeEG9Hhl1Ra/WclQ8lLXM60/nCvKJYP6/sRTqaamJ
         98X8S91g2T2UfygnW66ILef7DHQyxxDlKKlM0ZiKLwSmuCDxquAi4/QmBPEqpA5pK9
         MHiNWegn3QCq3khchGjCyeEkwCQ/KMcWGbCn3sIWW/QnHy9VdHd61UGkY+09l4s2hF
         iqK9ncL0i1k4iicNTcricezT1j73a+uYck3IDrDPAww7kjjq5uw4JC3Ih8nSyyKkR9
         Gead7phD3O1ff4LGhtEMcDel9VnxCdmlBzVhQrborkjwPiMbcI38m+gUo0kHClsDQM
         0bFO++CwvxxVkkr7LVgTLTrPD4ke6QMAn4RkObweqMxqKzX+IXTm+i51E5GFuKskB3
         m9HqqTbKGsRvfqqZSzcn9PCjVoLWmqoGzetpNueUL1GAfdSI7pxv7hEFfdtDAaOevE
         vy1rghA5kpV72n+lYHG1GZMXAsgl/kq5G2Jm6rDMlN+pTn1RPVN2P7Y2wOYx8v0dPM
         xD/ZCRIroXeKV3rlZlsQ9eUY+rCRAooWYXLqlssz8wCop1IkqmcD1V9PmMJsOWnwaJ
         L4CPvpwQUA5TwngYiNW6FIx54mn2mlIMqNAkImoXkqUdNVzKLP1DwljXMeD8u7xAk9
         cFxd560JMGjrREqcJVsZplfk=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42D4240E014B;
        Thu, 21 Sep 2023 10:07:22 +0000 (UTC)
Date:   Thu, 21 Sep 2023 12:07:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 10/30] x86/microcode/intel: Unify microcode apply()
 functions
Message-ID: <20230921100717.GGZQwV1bIb+jHyXIwX@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065501.405080839@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065501.405080839@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:57:59AM +0200, Thomas Gleixner wrote:
> Deduplicate the early and late apply() functions.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/cpu/microcode/intel.c |  105 +++++++++++-----------------------
>  1 file changed, 36 insertions(+), 69 deletions(-)
> 
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -294,12 +294,11 @@ static __init struct microcode_intel *sc
>  	return size ? NULL : patch;
>  }
>  
> -static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci, bool early)
> +static enum ucode_state apply_microcode(struct ucode_cpu_info *uci, struct microcode_intel *mc,

Err, we have

struct microcode_ops.apply_microcode()

already. Can we disambiguate those pls?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
