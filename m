Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF05477893A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjHKIwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHKIwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:52:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1846D2712;
        Fri, 11 Aug 2023 01:52:09 -0700 (PDT)
Date:   Fri, 11 Aug 2023 10:52:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691743927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YBpK1gVUIGuSu6Q8X/sPY0RHI56c2CcVVsMSn3o9lA8=;
        b=YWmCxuqaPyFXZYtbg8XLRgNpfoYLNLJSKGUCKhFKvFLrGDHXLM26uabgv6jy09o5+6jy6V
        /XfjpmaKFXkr4697KMW704FdOvM7oBEqhFJHylsdmdbHnnYzKWydAFNUqz2SAO/lXbkfkm
        mdkDGIHnTraqPNIabhn1EdjR2jSMexVyg3wPbczML3trXbrRRr+9oSxOKLVy4pwvlpJ0m5
        0b80LkbA39SwoIbKY30NemxDCVnPQIcmCXwQ1BuEJfTyWcKiN+1P2bLGKBlZrZiqueM6vt
        cblFnORjWeCqNXslsiEcxVbA/IIDQ47rq8O4Po0PXL2OAInFxo8j2+o/3+sNAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691743927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YBpK1gVUIGuSu6Q8X/sPY0RHI56c2CcVVsMSn3o9lA8=;
        b=pxCiC7Jt0Obuam3FqrqxN5tnlucxLXzuCNe3hwJsD/PbnJCni+ZThWUIpdjinNsBfH2OwF
        xF+xChq9KIe+ZbAQ==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Subject: Re: [RFT][PATCH v2 2/3] cpuidle: teo: Skip tick_nohz_get_sleep_length()
 call in some cases
In-Reply-To: <2167194.irdbgypaU6@kreacher>
Message-ID: <28e2d9ce-89db-807a-9d39-f2fcccfb2ad4@linutronix.de>
References: <5712331.DvuYhMxLoT@kreacher> <2167194.irdbgypaU6@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Thu, 3 Aug 2023, Rafael J. Wysocki wrote:

> Index: linux-pm/drivers/cpuidle/governors/teo.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/teo.c
> +++ linux-pm/drivers/cpuidle/governors/teo.c
> @@ -166,6 +166,12 @@
>   */
>  #define NR_RECENT	9
>  
> +/*
> + * Idle state target residency threshold used for deciding whether or not to
> + * check the time till the closest expected timer event.
> + */
> +#define RESIDENCY_THRESHOLD_NS	(15 * NSEC_PER_USEC)
> +

I would like to understand why this residency threshold is a fixed value
and not related to TICK_NSEC. I'm sure there is a reason for it - but for
me it is not obvious. Can you please explain it to me?

Thanks,

	Anna-Maria

