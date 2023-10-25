Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573D87D7536
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjJYUKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjJYUKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:10:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D511D181
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:10:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698264642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wn7xQQYnR2+5VclCs5O0a1AvLeWm17Ko+U9dZaPP8hE=;
        b=PFgX1ooetJs07+Nsx4twHvjByXAHlHoA1WUXVmVN5Q2XPsAHYfxH2Vqoal+EJYolGq+PEM
        JoRQonzxyPdAXOzLw0ZCxhnU2PIMfWKDQ+8QSHMjjFqcRjtocFzSvRE20AreLwQ/pUDLnJ
        PKFWsvKc3vRnsuYUFmPfN4cTLG3tDnK5koMWOsGxlFtP/0Ym89PSyq4SFhjUl2feZ4Dtcx
        U4FPNIiNAoDNrJhvJ98Y+vRHbf3N8r7Nfa4iJSnLoqJChnMjIeEXEHZNXfz237Sjb1l0ov
        nrWRXcs8DJnP+wWPnFjEuWKg/iWc2QUPNwWcwuOArh2D3scyM8+6G28v7dhriA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698264642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wn7xQQYnR2+5VclCs5O0a1AvLeWm17Ko+U9dZaPP8hE=;
        b=LF1gD4UuA0kRzrBYIv3dB8RtAbq4p3tDtflqnUSv4p6dI0yLKgHGcvUpauvzMOHADC5PKK
        cnycCtn9w9dcbXAw==
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] genirq: Own affinity hint
In-Reply-To: <20231025141517.375378-1-jakub@cloudflare.com>
References: <20231025141517.375378-1-jakub@cloudflare.com>
Date:   Wed, 25 Oct 2023 22:10:41 +0200
Message-ID: <878r7q5upq.ffs@tglx>
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

On Wed, Oct 25 2023 at 16:15, Jakub Sitnicki wrote:
> @@ -55,26 +55,33 @@ static int alloc_masks(struct irq_desc *desc, int node)
>  {
>  	if (!zalloc_cpumask_var_node(&desc->irq_common_data.affinity,
>  				     GFP_KERNEL, node))
> -		return -ENOMEM;
> +		goto err_affinity;
> +	if (!zalloc_cpumask_var_node(&desc->irq_common_data.affinity_hint,
> +				     GFP_KERNEL, node))

This gets allocated for every interrupt descriptor but only a few or
even none will ever use it. Seriously no.

> +		goto err_affinity_hint;
>  
>  #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
>  	if (!zalloc_cpumask_var_node(&desc->irq_common_data.effective_affinity,
> -				     GFP_KERNEL, node)) {
> -		free_cpumask_var(desc->irq_common_data.affinity);
> -		return -ENOMEM;
> -	}
> +				     GFP_KERNEL, node))
> +		goto err_effective_affinity;
>  #endif
>  
>  #ifdef CONFIG_GENERIC_PENDING_IRQ
> -	if (!zalloc_cpumask_var_node(&desc->pending_mask, GFP_KERNEL, node)) {
> -#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
> -		free_cpumask_var(desc->irq_common_data.effective_affinity);
> -#endif
> -		free_cpumask_var(desc->irq_common_data.affinity);
> -		return -ENOMEM;
> -	}
> +	if (!zalloc_cpumask_var_node(&desc->pending_mask, GFP_KERNEL, node))
> +		goto err_pending_mask;
>  #endif
>  	return 0;
> +
> +err_pending_mask:

How is this supposed to compile with CONFIG_GENERIC_PENDING_IRQ=n ?

> +#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
> +	free_cpumask_var(desc->irq_common_data.effective_affinity);
> +#endif
> +err_effective_affinity:

and this with CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=n ?

Thanks,

        tglx
