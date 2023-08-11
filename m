Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2764779641
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbjHKRiJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Aug 2023 13:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbjHKRiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:38:08 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F5E115
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:38:07 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-56ddf189fa0so309331eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775487; x=1692380287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoZZv2wRN+gZLmzDHKQSshNvNLFeOauwtaSCVx28bRE=;
        b=MFrWiK/E6ymjenjCD0jUFFXesqq5OijIrDh1yLxFLTZkKZX4paInHhCPKizL0zid3H
         QrcilPMHe1KltH6JAVxSTqXZ2rKo/8titxBcjH5pMhQZVArZcRf40IWkBgOIFMYnX+vl
         wNMm3AuifZpaQ2ndWv6A03MQj42MBSFN1+/RRlkBao1RqxrB3Hy85GORH7dYqvPChd9B
         AHv4hE2pEjdrxDTKsV2gD3IGmgjdrefEJIAEY9k48MiWsX/6B1+wbmonRnhb6nca5dBL
         MSfX/9M1jD7oxw21NoQsmLa8wB49bJYsiPxqSVUm5zNQC+tWrdsUmGuKn+/Z02aVkoAM
         PMDg==
X-Gm-Message-State: AOJu0YwvJbjKfYccpOhvFZ1dPHkCUIA01PjkxgqfMAcalMJtCFNpur1O
        XrbWV4c9SggAWRrdGRsalyNq88xfphmjB/ObzOo=
X-Google-Smtp-Source: AGHT+IH1aNqS3xSZQBIxyEp4cd1jtr5qPEnvXthbhSMIxEjGSoh15c0/ejczgGm5HLwD35llz6lRoYPvq7xqalsY+pU=
X-Received: by 2002:a05:6820:1687:b0:566:951e:140c with SMTP id
 bc7-20020a056820168700b00566951e140cmr2434293oob.1.1691775486770; Fri, 11 Aug
 2023 10:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230811170049.308866-1-frederic@kernel.org> <20230811170049.308866-4-frederic@kernel.org>
In-Reply-To: <20230811170049.308866-4-frederic@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 19:37:55 +0200
Message-ID: <CAJZ5v0jUnOC4gABpmg3pX0KWXvYcYEzsHcjY1LqH8qzJ94QsvQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] cpuidle: Report illegal tick stopped while polling
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
> poll_idle() can't be called while the tick is stopped because it enables
> interrupts and only polls on TIF_NEED_RESCHED, which doesn't tell if an
> interrupt queues a timer that would require a tick re-programming.
>
> There is no point anyway to poll with the tick stopped so add a check
> to make sure it never happens.

I'd rather update governors so they never use polling states when the
tick has been stopped and then add the WARN_ON().

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  drivers/cpuidle/poll_state.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index 9b6d90a72601..009f46f121ae 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -7,6 +7,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/clock.h>
>  #include <linux/sched/idle.h>
> +#include <linux/tick.h>
>
>  #define POLL_IDLE_RELAX_COUNT  200
>
> @@ -19,6 +20,13 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
>
>         dev->poll_time_limit = false;
>
> +       /*
> +        * This re-enables IRQs and only polls on TIF_NEED_RESCHED.
> +        * A timer queued by an interrupt here may go unnoticed if
> +        * the tick is stopped.
> +        */
> +       WARN_ON_ONCE(tick_nohz_tick_stopped());
> +
>         raw_local_irq_enable();
>         if (!current_set_polling_and_test()) {
>                 unsigned int loop_count = 0;
> --
> 2.34.1
>
