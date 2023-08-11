Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB72577964A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbjHKRk1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Aug 2023 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbjHKRk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:40:26 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23E8115
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:40:25 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-563393b63dbso401451eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775625; x=1692380425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trnEbkr1xArrg7I2HvIjZ1ezo6dbU3bi+6iBe5mO6tc=;
        b=eBoXuwctTJlsMhB4ns8lUU0WdgdLmHBoecUnbdQbxY3fSnvJ5ixJpTvnMjML7aHfvq
         UAAlS+AddftWKCs85QuirOXiBx2YmVeiokU7fGW8w4O9Ca+OLst8HGA6ndjhN8ocaKV8
         urhK3kr7x19U4bisUnzzRXhHvZyE/yb1KYlxGlzUN1b/lEYswWfAdaEEj5hsXpPmF8g6
         2SD+HI4Kuf0CmSgaR5N6AgQXAeZyI+wrrZJI3uAyCF63lN4eswsE+eAKj5MDIN5wGkAS
         B6TZXZdE93kLUJmkTW1ZHLyoG6nnox8uJZXNT/QUOqf44ezqcb6IVADw5Lyy8Sjz1rwE
         /jtw==
X-Gm-Message-State: AOJu0Yw2NLjLAQfzjlQY8pqCKZPV/auY1MARUZsH7PzqUV/Is9dneVF1
        WYVOZBR017z27yiLi+f+lgDJu8QZHSp8QvOQymI=
X-Google-Smtp-Source: AGHT+IF38p0iGCqe35+TO/gp5sEsT9lZX4RZZH8B9EtObeVOJyj0hImAUfarYXiNbK4U8N7833LStMFirARaD3o2E9A=
X-Received: by 2002:a05:6820:1c07:b0:56c:484a:923d with SMTP id
 cl7-20020a0568201c0700b0056c484a923dmr1785871oob.1.1691775625195; Fri, 11 Aug
 2023 10:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230811170049.308866-1-frederic@kernel.org> <20230811170049.308866-8-frederic@kernel.org>
In-Reply-To: <20230811170049.308866-8-frederic@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 19:40:14 +0200
Message-ID: <CAJZ5v0hwXuYDyJ4FxK_svbDemiN_CUjJ5SF5G9b8grKBQV8R7Q@mail.gmail.com>
Subject: Re: [PATCH 07/10] cpuidle: Remove unnecessary current_clr_polling()
 on poll_idle()
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 7:01 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> There is no point in clearing TIF_NR_POLLING and folding TIF_NEED_RESCHED
> upon poll_idle() exit because cpuidle_idle_call() is going to set again
> TIF_NR_POLLING anyway. Also if TIF_NEED_RESCHED is set, it will be
> folded and TIF_NR_POLLING will be cleared at the end of do_idle().
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/cpuidle/poll_state.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index 009f46f121ae..44a656464d06 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -48,8 +48,6 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
>         }
>         raw_local_irq_disable();
>
> -       current_clr_polling();
> -
>         return index;
>  }
>
> --
> 2.34.1
>
