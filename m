Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387CA7B0AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjI0RRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjI0RRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:17:08 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20745F3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:17:07 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5EFBF40E01A4;
        Wed, 27 Sep 2023 17:17:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AnU-c8OR83pl; Wed, 27 Sep 2023 17:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695835020; bh=Azh0xabHz3PHnv8BJfnWJoxdcZ5ZZG053LrhvG+FvWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAhHTuaVaC0Y0FmGHboKjv4bRIOsThkPcv7kRDWAjL7napD5NysEsjE6065LHLhXV
         pcvuhkie9UaX2+IzE+SVcGv/e/V+DngaR+VTOBDHBGHIYTAF9BmoMlh/WwziZ6QUgX
         PKEw+FitlD7W7SW9oWgCsbDiHsHoUj3KkIH0ZpebpJOT48d65U/HJ4Z530oe7FYOkf
         hE744oFqdIMp8xN5p0tJ8wYUWfELnzL3SXGgtmLff9EevpClkIucW1NYIcQfr6RBch
         zNZcG91LoE6Lrses2vhED62Jx9qv2NpHokmluWZYtWWZ0Ca7dyQJAe/e5jo4AM0+Xx
         4ltoFPa5FLZx1O2TKPB3NQKmAZ/BO+/qhROaiuKgy71O0O8/0L1ZqAm0KMknLG1qdl
         SUwMoj9ZChqcWjnGyNo0JF3MzzR6KMd51fbdwafV4TkYa0EQFy4IvfqHc35VGYjUj6
         zrq3IBp/a7aGak7WFMTRRwaj8ZBwBtTMQWOEHJI573mtBwmIJeFR1YG4VDR0QEpc5O
         QZdDp0a44monxJZWW0I8f8uRU3wyQ0Mg0DgmZ8A9SZVOtfleK1jcAUSGTMhxqmCb1C
         VPfLu3WFj/oKSD78gbpEQfmdnpE/Z6xGyMMZXc0h1cz+AlNv18c+P9ChlUZGy+wWHV
         88tnUzcKjLJKKGPMRnk1mZKQ=
Received: from nazgul.tnic (cust-west-par-46-193-35-178.cust.wifirst.net [46.193.35.178])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F79640E00B3;
        Wed, 27 Sep 2023 17:16:54 +0000 (UTC)
Date:   Wed, 27 Sep 2023 19:17:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 25/30] x86/microcode: Rendezvous and load in NMI
Message-ID: <20230927171713.GBZRRjmUDQrV9HVxv-@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.327149876@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065502.327149876@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:58:23AM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> stop_machine() does not prevent the spin-waiting sibling from handling an
> NMI, which is obviously violating the whole concept of rendezvous.
> 
> Implement a static branch right in the beginning of the NMI handler which
> is NOOPed except when enabled by the late loading mechanism.
>
> The later loader enables the static branch before stop_machine() is

s/later/late/

> invoked. Each CPU has an nmi_enable in its control structure which
> indicates whether the CPU should go into the update routine.
> 
> This is required to bridge the gap between enabling the branch and actually
> being at the point where it makes sense.

Huh? "where it makes sense"?

> -static int ucode_load_cpus_stopped(void *unused)
> +static bool microcode_update_handler(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>  
> @@ -430,7 +436,29 @@ static int ucode_load_cpus_stopped(void
>  	else
>  		ucode_load_secondary(cpu);
>  
> -	/* No point to wait here. The CPUs will all wait in stop_machine(). */
> +	touch_nmi_watchdog();

AFAICT, you're touching the NMI watchdog even in the !use_nmi case.

> +	return true;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
