Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FB0768B26
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjGaF3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaF3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:29:08 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F88EE5B;
        Sun, 30 Jul 2023 22:29:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D136F809E;
        Mon, 31 Jul 2023 05:29:05 +0000 (UTC)
Date:   Mon, 31 Jul 2023 08:29:04 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] bus: omap_l3_smx: identify timeout source before
 rebooting
Message-ID: <20230731052904.GB5194@atomide.com>
References: <20230730202240.898519-1-absicsz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730202240.898519-1-absicsz@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sicelo A. Mhlongo <absicsz@gmail.com> [230730 20:23]:
> Identify and print the error source before rebooting the board due to an l3
> application timeout error, by delaying the BUG_ON. This is helpful when
> debugging, e.g. via serial.

Makes sense to try to show some information, but please see the question
below.

> diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
> index bb1606f5ce2d..70f4903d5468 100644
> --- a/drivers/bus/omap_l3_smx.c
> +++ b/drivers/bus/omap_l3_smx.c
> @@ -170,11 +170,9 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
>  		status = omap3_l3_readll(l3->rt, L3_SI_FLAG_STATUS_0);
>  		/*
>  		 * if we have a timeout error, there's nothing we can
> -		 * do besides rebooting the board. So let's BUG on any
> -		 * of such errors and handle the others. timeout error
> -		 * is severe and not expected to occur.
> +		 * do besides rebooting the board after identifying the
> +		 * error source.
>  		 */
> -		BUG_ON(status & L3_STATUS_0_TIMEOUT_MASK);
>  	} else {
>  		status = omap3_l3_readll(l3->rt, L3_SI_FLAG_STATUS_1);
>  		/* No timeout error for debug sources */
> @@ -190,6 +188,12 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
>  		ret |= omap3_l3_block_irq(l3, error, error_addr);
>  	}
>  
> +	/*
> +	 * BUG on application timeout errors since they are severe and not
> +	 * expected to occur.
> +	 */
> +	BUG_ON(status & L3_STATUS_0_TIMEOUT_MASK);

Aren't you now checking the bit for both L3_SI_FLAG_STATUS_0 and
L3_SI_FLAG_STATUS_1 register values? I think it should be only for register
L3_SI_FLAG_STATUS_0 value?

Regards,

Tony
