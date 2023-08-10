Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD44B77824A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjHJUqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjHJUqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:46:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5492123
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UWztl8vcPVfgGLDZDopQZ0wWq6wwFiGeSa4nVGSnH6A=; b=c8LOJjdqF708E+FvlCRMMhvThL
        gpg3qKds+0OobOq9HDnVOvxVLbmLhTiQANTR8cXHaVKySSNhSavq+VhlzTpmuUv6EooV2mWSETnOM
        pJPkdwSojnamSJrOWcha6akEczmY0xkIBqAhB8o0H1sUadmapZgStIwy5JjH13wTTv11KPQQTEqdi
        g/WWWYPF+crG3Xs6Kby4lElfth70hRkqmxU2bo9b9v8W/hZUdRN3glBRe91pEmkZALmuzlCpJWsTV
        6GyNXC4Ng9JKhcLLRiEP8I9GXDiVoBvuVx5mlDmVHeOIXoUFPfMlb9VRBQcj1mJxACo7o8X5fu2Td
        9H6xxjpw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUCXm-006kNF-2d;
        Thu, 10 Aug 2023 20:46:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1953B30026C;
        Thu, 10 Aug 2023 22:46:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC1E92103B6B3; Thu, 10 Aug 2023 22:46:05 +0200 (CEST)
Date:   Thu, 10 Aug 2023 22:46:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 28/30] x86/microcode: Handle "offline" CPUs correctly
Message-ID: <20230810204605.GF212435@hirez.programming.kicks-ass.net>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.562016788@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810160806.562016788@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 08:38:07PM +0200, Thomas Gleixner wrote:

>  	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
> +		/*
> +		 * Offline CPUs sit in one of the play_dead() functions
> +		 * with interrupts disabled, but they still react on NMIs
> +		 * and execute arbitrary code. Also MWAIT being updated
> +		 * while the offline CPU sits there is not necessarily safe
> +		 * on all CPU variants.
> +		 *
> +		 * Mark them in the offline_cpus mask which will be handled
> +		 * by CPU0 later in the update process.
> +		 *
> +		 * Ensure that the primary thread is online so that it is
> +		 * guaranteed that all cores are updated.
> +		 */
>  		if (!cpu_online(cpu)) {
> +			if (topology_is_primary_thread(cpu) || !allow_smt_offline) {
> +				pr_err("CPU %u not online, loading aborted\n", cpu);

We could make the NMI handler do the ucode load, no? Also, you just need
any thread online, don't particularly care about primary thread or not
afaict.

>  				return false;
>  			}
> +			cpumask_set_cpu(cpu, &cpu_offline_mask);
> +			per_cpu(ucode_ctrl, cpu) = ctrl;
> +			continue;
>  		}
