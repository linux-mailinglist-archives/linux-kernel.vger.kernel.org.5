Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB4278A0E6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjH0SLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjH0SLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:11:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729E0C9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 11:11:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693159869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E1Dni0vu6ZgjY0n8cfwwItkvqaaAB41DGfshcIcxIXs=;
        b=3A2tMqjDkaQeri0eEng60q9esxUl4AqsMC2n9Grj6etcDljhU1Z56eONCbS4NhD9pWwzpg
        uquzmlRV6SuuM07uSAhfbXx+6NXl8CQbm2NQQXFTnW6dSQX8+zLx7q2w6ys3jfm1+b8TM5
        30B6goNl7pE1vvHvC1iWDBggPg54VIM1o3jtunvUUyvNnwebjnEMKX+PWeY+1U4bAjZE23
        qY8mCA1B7Iwv+S+c5fSpov4dpAG5679ScVlzJB7YghUPc5O6K3LK7KrOd8Ot2OowYsEFwK
        XDg0qx15w6kKMc1Afsf3WBEcZY1JLm+EXgpy1eYqKcEMZMXgPJxlgqgvkZHQ2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693159869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E1Dni0vu6ZgjY0n8cfwwItkvqaaAB41DGfshcIcxIXs=;
        b=SekzBwXfzJREjlTUbpXDibdWBOkQYrnkwCcO4DyFktd/taKrNtZLyXxxUQGikCzqIOTUSl
        08ByTn3xfDieWgCw==
To:     Li zeming <zeming@nfschina.com>, jstultz@google.com,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] kernel: time: clocksource: Remove unnecessary
 =?utf-8?B?4oCYMOKAmQ==?=
 values from ret
In-Reply-To: <20230808173611.3066-1-zeming@nfschina.com>
References: <20230808173611.3066-1-zeming@nfschina.com>
Date:   Sun, 27 Aug 2023 20:11:08 +0200
Message-ID: <8735049wzn.ffs@tglx>
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

On Wed, Aug 09 2023 at 01:36, Li zeming wrote:
> ret is assigned first, so it does not need to initialize the
> assignment.
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  kernel/time/clocksource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 91836b727cef..b4ad38812ef7 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -1289,7 +1289,7 @@ static int clocksource_unbind(struct clocksource *cs)
>   */
>  int clocksource_unregister(struct clocksource *cs)
>  {
> -	int ret = 0;
> +	int ret;
>  
>  	mutex_lock(&clocksource_mutex);
>  	if (!list_empty(&cs->list))

ret is only assigned a value when cs->list is not empty.

Can you please fix your analyzer or at least validate by inspection
whether your analyzer is correct?

While at it, please follow the instructions at:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-submission-notes

Thanks,

        tglx
