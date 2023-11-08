Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D997E5243
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343756AbjKHI7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjKHI7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:59:46 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7291E1716
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gVg/BkXKsNwGudM+L56Wgnqmj1mUU2FtDJSXo8eK0ks=; b=YobceBSdYvBf+I9XqFS2+lDBB/
        /lddbiLSi4YJgRp2Ac9zK66IcKqnkd8AbBV4pBlXTA9rv4kvcok7lLgBtAiO1Mv4cDXKRVPYRtGzK
        v71ArJyCb+nanfXTfTrjaEVPI+C7ShICzHwXCAlERvF0pmWIJPaW5fV5WxPpmhulX0egyrzpIg3c8
        TINdSKSBMsDxDn/6nT7/1/BMkrY94/hB88ZJORIh0K1Zd8rKs8/Nmpwt1j4NbAkZ09Os0bkRYmfB/
        c6pGJYMJR6GiQ9KsaXPXq9iZn2IRT/ijyUifGBk35FnduplWymvk5FoIKY4Za6ED1Y0uf6L7B/8oa
        EdyEyMoQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0eOJ-00DMoq-20;
        Wed, 08 Nov 2023 08:58:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C31D30049D; Wed,  8 Nov 2023 09:58:27 +0100 (CET)
Date:   Wed, 8 Nov 2023 09:58:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 34/86] thread_info: accessors for TIF_NEED_RESCHED*
Message-ID: <20231108085827.GE8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-35-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-35-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:57:20PM -0800, Ankur Arora wrote:
> Add tif_resched() which will be used as an accessor for TIF_NEED_RESCHED
> and TIF_NEED_RESCHED_LAZY. The intent is to force the caller to make an
> explicit choice of how eagerly they want a reschedule.
> 
> This interface will be used almost entirely from core kernel code, so
> forcing a choice shouldn't be too onerous.
> 
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

> ---
>  include/linux/thread_info.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 9ea0b28068f4..4eb22b13bf64 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -59,6 +59,27 @@ enum syscall_work_bit {
>  
>  #include <asm/thread_info.h>
>  
> +#ifndef TIF_NEED_RESCHED_LAZY
> +#error "Arch needs to define TIF_NEED_RESCHED_LAZY"
> +#endif
> +
> +#define TIF_NEED_RESCHED_LAZY_OFFSET	(TIF_NEED_RESCHED_LAZY - TIF_NEED_RESCHED)
> +
> +typedef enum {
> +	RESCHED_eager = 0,
> +	RESCHED_lazy = TIF_NEED_RESCHED_LAZY_OFFSET,
> +} resched_t;
> +
> +static inline int tif_resched(resched_t r)
> +{
> +	return TIF_NEED_RESCHED + r;
> +}
> +
> +static inline int _tif_resched(resched_t r)
> +{
> +	return 1 << tif_resched(r);
> +}

So either I'm confused or I'm thinking this is wrong. If you want to
preempt eagerly you want to preempt more than when you're not eager to
preempt, right?

So an eager preemption site wants to include the LAZY bit.

Whereas a site that wants to lazily preempt would prefer to not preempt
until forced, and hence would not include LAZY bit.


