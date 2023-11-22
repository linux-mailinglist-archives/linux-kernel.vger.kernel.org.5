Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324497F51FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjKVVBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjKVVBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:01:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87DF1A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:01:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FCBC433C7;
        Wed, 22 Nov 2023 21:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700686871;
        bh=LFJYP+QjzywPPTWxrzmRwkBKvDt/8qXL2sn05QMF5tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+DAYlmapEZKrvTtUqKHYNU1PFaL2I5a3UWtBmUXQnpFrfGztZvuFATKxUxEua+km
         o9poCmNBo3TSnLW8W00G5Aublxu5IHhZdFDhkcxDpbLWR0FA5kcXnQClCAXVzv1yE9
         wMc/KP+WN3bwkqrEH/dFx8f4jlZ5ovi/mjLtORd7JUQfO/xmzRxx1vTiuez7FIjChU
         Gp8OcAXR4KM6kjXJ8KMA99gEH4cJFtjXYdYO6EAJQ6zJHYbjxsWl2fLjygceo5x1cA
         HbRyx4cb968mZf8x0Q1/ox9qbFm2KUBBvEvCTbSeaali2AzdhrNL59WN/whMesx+C2
         T3LF4R2qu3cfQ==
Date:   Wed, 22 Nov 2023 22:01:07 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] cpuidle: Remove unnecessary current_clr_polling() on
 poll_idle()
Message-ID: <ZV5sEwwnQTjh-QXm@localhost.localdomain>
References: <20231113220326.7933-1-frederic@kernel.org>
 <20231113220326.7933-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231113220326.7933-3-frederic@kernel.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Nov 13, 2023 at 05:03:26PM -0500, Frederic Weisbecker a écrit :
> There is no point in clearing TIF_NR_POLLING and folding TIF_NEED_RESCHED
> upon poll_idle() exit because cpuidle_idle_call() is going to set again
> TIF_NR_POLLING anyway. Also if TIF_NEED_RESCHED is set, it will be
> folded and TIF_NR_POLLING will be cleared at the end of do_idle().
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Please discard this one, I'm taking a new way to deal with that.

Thanks.

> ---
>  drivers/cpuidle/poll_state.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index 9b6d90a72601..d5cb3eb85a54 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -40,8 +40,6 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
>  	}
>  	raw_local_irq_disable();
>  
> -	current_clr_polling();
> -
>  	return index;
>  }
>  
> -- 
> 2.42.1
> 
