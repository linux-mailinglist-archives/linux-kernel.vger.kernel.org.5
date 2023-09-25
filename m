Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2D87ADC52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjIYPuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjIYPu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:50:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38C7CF1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:48:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695656928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nIxg/Ujz545pz1uUk69VdG7hAbXi7YxGHlSiBDExfco=;
        b=cwKuH7UHAWvwZUJXR1Lg1hIyKppXvQ8bGNN6CIcvVo1KLyXw/zKMHWHQH8tSe5DPrKbmyr
        AXeHF9NLlhhF4sOJRbiTtGHS3j/LY7ZAQa2wKcE8nP5Qjrh6Jy0q3hLHohl9CYDCD4DYRt
        B2ry7GeBKZgKeZ5O9Gqz29IyjIykdExP2yKMIZ9K1eUdkdUDWC64abXOnRgEU8XkV4GVhI
        YDCt9s2uM5ofoX+uE0LU5gBpVsjdGb1X4JIYrxM6hM6NYqr6I9U1Hhohe28xMYa7Zjeyq0
        THmTfFyN87bdL2SmSQ6jHfPHVENmdCzXvs8UpnUir8Emjsq4Y1nti0j+NB2XWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695656928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nIxg/Ujz545pz1uUk69VdG7hAbXi7YxGHlSiBDExfco=;
        b=lN+JgiMYFuPX8AEASevQMSklh5h+a5SPgjL1BLvcupYaPU7zyUh0jF6GNY5rSoUJmrIuKq
        6NjZVUxonRMtfWDw==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 12/30] x86/microcode/intel: Reuse
 intel_cpu_collect_info()
In-Reply-To: <20230921104220.GHZQweDKyaJmkYdt4f@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065501.530637507@linutronix.de>
 <20230921104220.GHZQweDKyaJmkYdt4f@fat_crate.local>
Date:   Mon, 25 Sep 2023 12:47:16 +0200
Message-ID: <87zg1afs23.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21 2023 at 12:42, Borislav Petkov wrote:

> On Tue, Sep 12, 2023 at 09:58:02AM +0200, Thomas Gleixner wrote:
>>  static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
>
> You can get rid of that silly wrapper too and use
> intel_collect_cpu_info() in the function pointer assignment directly.
>
> Diff ontop:
>
> ---
>
> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index 4066dd3734ba..581ecfbaf134 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -75,7 +75,7 @@ extern __noendbr void cet_disable(void);
>  
>  struct cpu_signature;
>  
> -void intel_collect_cpu_info(struct cpu_signature *sig);
> +void intel_collect_cpu_info(int unused, struct cpu_signature *sig);

Eew. That's a function exposed to code outside of microcode and just
grows that unused argument for no value and you obviously forgot to
fixup the extern callsite :)
  
> diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
> index 051b7956d4fd..b3753025cd4a 100644
> --- a/arch/x86/kernel/cpu/microcode/internal.h
> +++ b/arch/x86/kernel/cpu/microcode/internal.h
> @@ -30,7 +30,7 @@ struct microcode_ops {
>  	 * See also the "Synchronization" section in microcode_core.c.
>  	 */
>  	enum ucode_state (*apply_microcode)(int cpu);
> -	int (*collect_cpu_info)(int cpu, struct cpu_signature *csig);
> +	void (*collect_cpu_info)(int cpu, struct cpu_signature *csig);
>  	void (*finalize_late_load)(int result);

Making this void makes sense, but that's a separate change.

Thanks,

        tglx


