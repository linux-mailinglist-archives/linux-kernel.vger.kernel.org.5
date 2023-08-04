Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC2977072C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjHDRdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjHDRdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:33:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2724EA9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B40DA620D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 17:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173C7C433C7;
        Fri,  4 Aug 2023 17:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691170390;
        bh=dnWlwvaPnL16cTC8ijLOxs1uggOtQe0XY2hrk+YTBGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J6YaTsD6QPeFmQ30poWaU6dNgzYSBjx3IKA0/HcHkABClRo6J9SyxI69icKW1js3x
         GqiMHQYoAU+u3EPGHczjoozhpeoF07JeTtKIfiEdTvyEUKcQw2DJhPoXKSsOJ2Izjj
         MztWGCM6iQHiz5vFRiL0nLl7PjM+8uNejhk66FR1DciMO9saJQujtAeQwKQNH2mGLJ
         7ryaySjgBoRw2du7fSzPm7aeEdH4AAAOI/PizH6ztoytyGzF6R2Ln3s7AD0M3I0vZg
         c7ax46DIbU/n7wytdDJshHHSf7zQhfu9ABLq9U8JmLAcLJ79E+t+erqC8c9KiY9hxL
         RVEjZr3XTBMGA==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qRyfj-002Ix4-Ij;
        Fri, 04 Aug 2023 18:33:07 +0100
MIME-Version: 1.0
Date:   Fri, 04 Aug 2023 18:33:07 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 1/1] irqdomain: Refactor error path in
 __irq_domain_alloc_fwnode()
In-Reply-To: <20230804164932.40582-1-andriy.shevchenko@linux.intel.com>
References: <20230804164932.40582-1-andriy.shevchenko@linux.intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <84f2ea9ee0c08c8826c0f26c4a6291c9@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: andriy.shevchenko@linux.intel.com, johan+linaro@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-04 17:49, Andy Shevchenko wrote:
> First of all, there is no need to call kasprintf() if the previous
> allocation failed. Second, there is no need to call for kfree()
> when we know that its parameter is NULL. Refactor the code accordingly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/irq/irqdomain.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 0bdef4fe925b..d2bbba46c808 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -81,6 +81,8 @@ struct fwnode_handle
> *__irq_domain_alloc_fwnode(unsigned int type, int id,
>  	char *n;
> 
>  	fwid = kzalloc(sizeof(*fwid), GFP_KERNEL);
> +	if (!fwid)
> +		return NULL;
> 
>  	switch (type) {
>  	case IRQCHIP_FWNODE_NAMED:
> @@ -93,10 +95,8 @@ struct fwnode_handle
> *__irq_domain_alloc_fwnode(unsigned int type, int id,
>  		n = kasprintf(GFP_KERNEL, "irqchip@%pa", pa);
>  		break;
>  	}
> -
> -	if (!fwid || !n) {
> +	if (!n) {
>  		kfree(fwid);
> -		kfree(n);
>  		return NULL;
>  	}

What are you trying to fix?

We have a common error handling path, which makes it easy to
track the memory management. I don't think this sort of bike
shedding adds much to the maintainability of this code.

Now if you have spotted an actual bug, I'm all ears.

       M.
-- 
Jazz is not dead. It just smells funny...
