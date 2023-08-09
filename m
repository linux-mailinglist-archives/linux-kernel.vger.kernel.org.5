Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47B577678C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjHISm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjHISm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:42:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54010DC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:42:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691606543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/G5x28dNg7GMIHWjkdXyKIsCbog68qMAXixeAIS5e5I=;
        b=ErFAYrLuPJhgtLnt1PQeV97MDT3vjpbXf1UOE0eX1GaspvJ6pL1vMRx23OROk8UED5qgZn
        9n1XUA5ttSBH2ncpZOZOyb8xo9yws1b/8VjvlrHC/9qltDdFyM3tR36trCjFW/od+O21In
        YIqK9t+QtiFJgpQ2qVOVVLRm4ODwND6ulnTNhtumddEitgni5ozQ0WubOXRtzFFcIDh59C
        MoOydyjWgWWc1VNWd4Fw45BVwTuKie0WVcX//Hb+N38hp2MdolKvzArseNRmv5/b8ey3hx
        cYNoObm0X2uSvrdtmbEWeyXFPpKJYPh1zNeUgeJzhdvyU1GjBy/JGBfz6dMk1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691606543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/G5x28dNg7GMIHWjkdXyKIsCbog68qMAXixeAIS5e5I=;
        b=k7yvAzKW45jGN7rQ+a6M/RLd0fBGbTQ47fufJjg6WQqIB44q0ioP8xHftnPXQtmY4Hgzc9
        zQHZYOYmeldZKZBQ==
To:     Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de,
        mingo@redhat.com, Vasant Hegde <vasant.hegde@amd.com>,
        Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Subject: Re: [PATCH] x86/smp: Validate APIC ID before parking CPU in INIT
In-Reply-To: <20230719051302.15801-1-vasant.hegde@amd.com>
References: <20230719051302.15801-1-vasant.hegde@amd.com>
Date:   Wed, 09 Aug 2023 20:42:23 +0200
Message-ID: <87fs4sjbw0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19 2023 at 05:13, Vasant Hegde wrote:
> Below commit is causing kexec to hang in certain scenarios with >255 CPUs.
>
> Reproduce steps:
>   - We are using 2 socket system with 384 CPUs
>   - Booting first kernel with kernel command line intremap=off
>     This disabled x2apic in kernel and booted with apic mode
>   - During kexec it tries to send INIT to all CPUs except boot CPU
>     If APIC ID is 0x100 (like in our case) then it will send CPU0
>     to INIT mode and system hangs (in APIC mode DEST field is 8bit)

It took me a while to decode the above.

> Fix this issue by adding apic->apic_id_valid() check before sending
> INIT sequence.

Sigh, yes.

> Fixes: 45e34c8af58f ("x86/smp: Put CPUs into INIT on shutdown if possible")
> Reported-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  arch/x86/kernel/smpboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index e1aa2cd7734b..e5ca0689c4dd 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1360,7 +1360,7 @@ bool smp_park_other_cpus_in_init(void)
>  		if (cpu == this_cpu)
>  			continue;
>  		apicid = apic->cpu_present_to_apicid(cpu);
> -		if (apicid == BAD_APICID)
> +		if (apicid == BAD_APICID || !apic->apic_id_valid(apicid))
>  			continue;
>  		send_init_sequence(apicid);
>  	}
