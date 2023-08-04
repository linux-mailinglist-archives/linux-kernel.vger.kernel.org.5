Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143887707A2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjHDSNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjHDSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:13:02 -0400
X-Greylist: delayed 102874 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Aug 2023 11:13:01 PDT
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D66F4C05
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:13:01 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8295940E01E6;
        Fri,  4 Aug 2023 18:12:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tWIKDwiznOgB; Fri,  4 Aug 2023 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691172775; bh=PaA8LNmAurIKqpdyWZbLzxCucM5EGuGYrNWoBiwfPp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikq+rnLS9/HRQb3LWCLlIl7nUXuJ3K9M0HITzcPGD6j1CuhGC9Qr+YzkGya6ZsIf9
         Bg9yUgrXZA4GC4kw1eTbZOa3b0zpdvoEyaHCCSU7ZJPF7XBFFydniYtxn47q9/gT1Y
         DDQtVbjYVS1k5FLXR4u9vQvR/4uDrHV37L+ZDoYH+3Ea0pKbgBHbCrgdnRXK93AM+y
         uRQrFe2O0vO65AGbxpwgGmDFV+6hAUpP6fmSm22d4jI4qbq6EIvA0x6i0+sp+TDq8h
         0/RG/4TaKxUycRPcSM7AIp/qowx7UqK8Xp2r9nTjaFz4LsxP+gIyGTtIw6+Jn1qDob
         Rrki8hVc15Y2zy8QI3+NcqPcDmiw2bpVSvCaiwOSpIwcNJO9b7KchPeU97fywuUaM6
         H3dBtTtX2h5Wuz7b6Kexk6y0bHF7RYN6CqD4uq/pmDXFFmDVnsptc6nMV0u22lxS+G
         BZ8eSrIkXGT/6ie0JjfKndsEnx/pUKC7+jiLIIvDSwIhpvH/+4mI1WFHpTgQxbxk8P
         VoOFxd/9SUspDRkn5Q79zSJqJbNMaEmQWL+JwYemLjUF5rDEBS4p99AGdhGryWKDK6
         3kdv/Ej+/5pQV6Q3j8BpXUSndK3mSHwt4/PfUI4gcL87IlOhMTI5VbDSjJ5kV2KUIL
         UAWgQxdKGTd0CYeZ4QF3IMPg=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B88F40E01E4;
        Fri,  4 Aug 2023 18:12:44 +0000 (UTC)
Date:   Fri, 4 Aug 2023 20:12:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V3 02/40] x86/apic: Fake primary thread mask for XEN/PV
Message-ID: <20230804181243.GLZM0/m0xXb/wMpUcD@fat_crate.local>
References: <20230802101635.459108805@linutronix.de>
 <20230802101932.819070039@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802101932.819070039@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 12:21:01PM +0200, Thomas Gleixner wrote:
> The SMT control mechanism got added as speculation attack vector
> mitigation. The implemented logic relies on the primary thread mask to
> be set up properly.
> 
> This turns out to be an issue with XEN/PV guests because their CPU hotplug
> mechanics do not enumerate APICs and therefore the mask is never correctly
> populated.
> 
> This went unnoticed so far because by chance XEN/PV ends up with
> smp_num_siblings == 2. So smt_hot-plug_control stays at its default value

I think this means to say "cpu_smt_control". Committer, pls fix. :-)

> CPU_SMT_ENABLED and the primary thread mask is never evaluated in the
> context of CPU hotplug.
> 
> This stopped "working" with the upcoming overhaul of the topology
> evaluation which legitimately provides a fake topology for XEN/PV. That
> sets smp_num_siblings to 1, which causes the core CPU hot-plug core to
> refuse to bring up the APs.
> 
> This happens because smt_hotplug_control is set to CPU_SMT_NOT_SUPPORTED

Ditto.

> which causes cpu_smt_allowed() to evaluate the unpopulated primary thread
> mask with the conclusion that all non-boot CPUs are not valid to be
> plugged.
> 
> The core code has already been made more robust against this kind of fail,
> but the primary thread mask really wants to be populated to avoid other
> issues all over the place.
> 
> Just fake the mask by pretending that all XEN/PV vCPUs are primary threads,
> which is consistent because all of XEN/PVs topology is fake or non-existent.
> 
> Fixes: 6a4d2657e048 ("x86/smp: Provide topology_is_primary_thread()")
> Fixes: f54d4434c281 ("x86/apic: Provide cpu_primary_thread mask")
> Reported-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/apic/apic.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -36,6 +36,8 @@
>  #include <linux/smp.h>
>  #include <linux/mm.h>
>  
> +#include <xen/xen.h>
> +
>  #include <asm/trace/irq_vectors.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/pc-conf-reg.h>
> @@ -2344,6 +2346,15 @@ static int __init smp_init_primary_threa
>  {
>  	unsigned int cpu;
>  
> +	/*
> +	 * XEN/PV provides either none or useless topology information.
> +	 * Pretend that all vCPUs are primary threads.
> +	 */
> +	if (xen_pv_domain()) {
> +		cpumask_copy(&__cpu_primary_thread_mask, cpu_possible_mask);
> +		return 0;
> +	}

Can this be somewhere in the Xen init code instead?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
