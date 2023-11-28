Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A626A7FC86E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345139AbjK1Vjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1Vjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:39:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A687594
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:39:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAECC433C7;
        Tue, 28 Nov 2023 21:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701207582;
        bh=Bd7jZSwUsBMVnbLjx0m4br3VZc9EAqszuySIYe5cwEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CDzFZWXSsGgRJbKrFbqp868TFqsDpcYx6gffaKcL9iAhxCjt4ok79HpjoUYXTjpDU
         dhwghCrhahqNnFeAxCIs5w+b0ryqX1xYOOy5GVKg8TLGxoyyFBSPEoGS7pGVQgEm5E
         HkiMV0alG0UQOznZU3dWb/yOYApJZddPHHgZ1UtNNshJXWSXT8Y1Ft7gw8kOA8FhKM
         NgCfdpThgyKHMNi0P3wq9L7mJBkzTrDOLfuxCH/jx3pCYlDuaiuE1lzJ/jTM2LJ1QJ
         BGahbNID6a725cOK4N2XZSzxp1aR16mdwkqwDtu5WL4e/XgIezo2JrOrAeMuPQj+YZ
         uNecGeen9fyuQ==
Date:   Tue, 28 Nov 2023 22:39:39 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peng Liu <pngliu@hotmail.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        liupeng17@lenovo.com
Subject: Re: [PATCH v2 2/2] tick/nohz: Remove duplicate between
 tick_nohz_lowres_handler() and tick_nohz_highres_handler()
Message-ID: <ZWZeG_1ulVp97YQz@localhost.localdomain>
References: <20231127083118.145704-1-pngliu@hotmail.com>
 <TYCP286MB2146FA111842EAD33796AF5EC6BCA@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCP286MB2146FA111842EAD33796AF5EC6BCA@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Nov 28, 2023 at 05:24:13PM +0800, Peng Liu a écrit :
> From: Peng Liu <liupeng17@lenovo.com>
> 
> tick_nohz_lowres_handler() does the same work as tick_nohz_highres_handler()
> plus the clockevent device reprogramming, so should reuse the latter.
> 
> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
> ---
> Changes in v2:
> - Fix build warning: Function parameter or member 'mode' not described in 'tick_setup_sched_timer'
> - Fix build error: use of undeclared identifier 'tick_nohz_highres_handler'
> - Fix build error: use of undeclared identifier 'sched_skew_tick'
> ---
>  kernel/time/tick-sched.c | 28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 96fcf5cb1b49..c2142b38c31d 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1383,36 +1383,25 @@ void tick_nohz_idle_exit(void)
>  	local_irq_enable();
>  }
>  
> +static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer);

Then please move the entire function in this case. You'll need to move it to
a place where it is available both for CONFIG_NO_HZ_COMMON and
CONFIG_HIGH_RES_TIMERS. Below tick_sched_handle() for example.

Thanks!
