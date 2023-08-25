Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412CE788E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjHYSA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjHYSA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:00:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DF4E59
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:00:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692986422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFq8BNmg3sRXDOhP7DZbWDUSSoWoJA4FScQMW0wXJtY=;
        b=OTdgKHGPQQi/VaOz89bnGEq27mzQndhEe4U2e4Fu81M6tE8zCsivi9Cum4hTNrs0XvoSRd
        2IHHjSE5V1moiWcEUtRWiLUV/ZvmPtv2gyOa8Z0Jj/xVmeEmg8P9lYzBNMPWpoDqvZ3U7Y
        BCoj+PtF8PxqwQoaTetCr8QQPtzI095nM9ISl/jmchWgCRCkp6rA+tX8juwlpUyXSd28Ox
        u4wwzvdrMlBF51R8Ro65Ocqlc4IDmv2K13toclajkuP6gPcOJA63415BI2/yMzoiXYIqFy
        B9vXtV8OCVX0Z2Nr4pHxNdbGD38AW9/C1O98fjV0+GFiWdX7QyPZ2QgkMUUMCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692986422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFq8BNmg3sRXDOhP7DZbWDUSSoWoJA4FScQMW0wXJtY=;
        b=ayWP9a5VYJq5vbjG75OsVp/AkFMZ9g4RlcAYUsoCX87Ou6EiYNWbFJ8gAWaZ4eMOnFL3cR
        na4yI61ceY+iPSCQ==
To:     Jie Zhan <zhanjie9@hisilicon.com>, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhanjie9@hisilicon.com, prime.zeng@hisilicon.com,
        liyihang6@hisilicon.com, chenxiang66@hisilicon.com,
        shenyang39@huawei.com, qianweili@huawei.com
Subject: Re: [PATCH] irqdomain: Fix driver re-inserting failures when IRQs
 not being freed completely
In-Reply-To: <20230720122429.4123447-1-zhanjie9@hisilicon.com>
References: <20230720122429.4123447-1-zhanjie9@hisilicon.com>
Date:   Fri, 25 Aug 2023 20:00:21 +0200
Message-ID: <87msyfatoq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20 2023 at 20:24, Jie Zhan wrote:
> Since commit 4615fbc3788d ("genirq/irqdomain: Don't try to free an
> interrupt that has no mapping"), we have found failures when
> re-inserting some specific drivers:
>
> [root@localhost ~]# rmmod hisi_sas_v3_hw
> [root@localhost ~]# modprobe hisi_sas_v3_hw
> [ 1295.622525] hisi_sas_v3_hw: probe of 0000:30:04.0 failed with error -2
>
> This comes from the case where some IRQs allocated from a low-level domain,
> e.g. GIC ITS, are not freed completely, leaving some leaked. Thus, the next
> driver insertion fails to get the same number of IRQs because some IRQs are
> still occupied.

Why?

> Free a contiguous group of IRQs in one go to fix this issue.

Again why?

> @@ -1445,13 +1445,24 @@ static void irq_domain_free_irqs_hierarchy(struct irq_domain *domain,
>  					   unsigned int nr_irqs)
>  {
>  	unsigned int i;
> +	int n;
>  
>  	if (!domain->ops->free)
>  		return;
>  
>  	for (i = 0; i < nr_irqs; i++) {
> -		if (irq_domain_get_irq_data(domain, irq_base + i))
> -			domain->ops->free(domain, irq_base + i, 1);
> +		/* Find the largest possible span of IRQs to free in one go */
> +		for (n = 0;
> +			((i + n) < nr_irqs) &&
> +			 (irq_domain_get_irq_data(domain, irq_base + i + n));
> +			n++)
> +			;

For one this is unreadable gunk. But what's worse it still does not
explain what this is solving.

It's completely sensible to expect that freeing interrupts in a range
one by one just works.

So why do we need to work around an obvious low level failure in the
core code?

Thanks,

        tglx
