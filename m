Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE079766DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbjG1Mzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjG1Mzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:55:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A5B30FA;
        Fri, 28 Jul 2023 05:55:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690548929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lC9d12Ft1vaZl1r5oaRHCKBKWx9YmTaYlRn9mDI8X2U=;
        b=GoKGm+akHT+hB9vRSCpMfYGpBobhIc11qZ001utqipWUHSb9C6eoGKvkxtNxt2OMbvI1Ea
        sSbJ4H5Xjpe9+KiXZ0xr/9ykNF8/oCyr7Nt9B8N0SyO36C31KU/Q8/cSMa9X0EfKsQ+gdR
        KX/H6+LPUexJqDqLLpL/3d4+P9AewlNTvzROhWI6cLfXP7qZ7Z4aYRF3T1VW8D+oTxgtSb
        pqrJD8ZspCvWnKQWpGskb9JaBMEuXMNJbtv02XUb4b+3ckqeZsgVaOqyAHwJutWTmH7rem
        xz8MKMSvrZjJDAYyHBxFfIavPxRIGpmCZ33+TaBLRS/f4cDKE6+bsTL6sBkTIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690548929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lC9d12Ft1vaZl1r5oaRHCKBKWx9YmTaYlRn9mDI8X2U=;
        b=iQOrrT3PGFmHIXkxPrBajQTbMYj6hUK2KHWRHTWQKkSzEaZEAZHpLGbBwmv+M18bh0AhVM
        CrnGCbTpjBfyX5CQ==
To:     Zhang Rui <rui.zhang@intel.com>, peterz@infradead.org,
        bp@alien8.de, rafael.j.wysocki@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, feng.tang@intel.com
Subject: Re: [RFC PATCH] x86/acpi: Ignore invalid x2APIC entries
In-Reply-To: <87jzukqjvf.ffs@tglx>
References: <20230702162802.344176-1-rui.zhang@intel.com> <87jzukqjvf.ffs@tglx>
Date:   Fri, 28 Jul 2023 14:55:28 +0200
Message-ID: <87h6poqjpb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28 2023 at 14:51, Thomas Gleixner wrote:
> On Mon, Jul 03 2023 at 00:28, Zhang Rui wrote:
>>  
>> +static bool has_lapic_cpus;
>
> Yet another random flag. Sigh.
>
> I really hate this. Why not doing the obvious?
>
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2452,6 +2452,9 @@ int generic_processor_info(int apicid, i
>  	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
>  				phys_cpu_present_map);
>  
> +	if (physid_isset(apicid, phys_cpu_present_map))
> +		return -EBUSY;
> +
>  	/*
>  	 * boot_cpu_physical_apicid is designed to have the apicid
>  	 * returned by read_apic_id(), i.e, the apicid of the
>
> As the call sites during MADT parsing ignore the return value anyway,
> there is no harm and this is a proper defense against broken tables
> which enumerate an APIC twice.

In fact that function should not have a return value at all, but because
it's not clearly separated between boot time and physical hotplug, it
has to have one ...
