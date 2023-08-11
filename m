Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E04779649
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjHKRjq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Aug 2023 13:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHKRjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:39:45 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0267EA8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:39:45 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-563393b63dbso401380eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775584; x=1692380384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4zKNSxN5Y4igsDIrDshN3Ha63T6gvcAcBAD1PqTYC4=;
        b=bJRJyUSCLGJoSnVmjtiWRL2gabWgNT2fW8VsumpB2qgC7XAuOAmPU4gni/vau4t9Sv
         c/DJVsJ0w3ZfCPpK4VDt0a1M9CsdjPWyU0CXMFGJVy+IEtMYd9KTtXSYhIgmRVhxNpIA
         zMTFOqeuKhPJMFJxHrdicINqevvaYleCv9LKpo0e1cjPaO6LwN18r6eymYFHUMFlnxXy
         6XGPF1lQb1PTdJa+u8PVoVGlAKkzOK8btu71o95eZPVdhs+Fl+bMnuaJDqVNwfTApKvE
         wvddDfP3X2wGfYjAQdzcaONj+D7OaiAjpkLoontkAzN1g2Vi1WGrmbK+qOzPGDxh17fY
         PMZQ==
X-Gm-Message-State: AOJu0Yxp8b9mIoCHCThXypokw/xvut9tDlB5x2B+Nv9F1b+T1JkmO0Mp
        tRrhdHPkftof/z607GFQxwQEPoIznEPppXhCYDk=
X-Google-Smtp-Source: AGHT+IGRwAnVEYaB/QQd9FEuEVZA/UAX7NpCYUns1QGwYxvgVHAjHCHsDPglxhWP9gcfz0NRhAzItedBUOjneB0ZhDs=
X-Received: by 2002:a4a:e04e:0:b0:569:a08a:d9c5 with SMTP id
 v14-20020a4ae04e000000b00569a08ad9c5mr2110253oos.0.1691775584173; Fri, 11 Aug
 2023 10:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230811170049.308866-1-frederic@kernel.org> <20230811170049.308866-7-frederic@kernel.org>
In-Reply-To: <20230811170049.308866-7-frederic@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 19:39:32 +0200
Message-ID: <CAJZ5v0gOU7cC+QsYWik5-6ePRnq8h6Qba3TWDSQQvsN92s34fw@mail.gmail.com>
Subject: Re: [PATCH 06/10] cpuidle: Remove unnecessary current_clr_polling_and_test()
 from haltpoll
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
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
> When cpuidle drivers ->enter() callback are called, the TIF_NR_POLLING
> flag is cleared already and TIF_NEED_RESCHED checked by call_cpuidle().
>
> Therefore calling current_clr_polling_and_test() is redundant here and
> further setting of TIF_NEED_RESCHED will result in an IPI and thus an
> idle loop exit. This call can be safely removed.
>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/cpuidle/cpuidle-haltpoll.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
> index e66df22f9695..b641bc535102 100644
> --- a/drivers/cpuidle/cpuidle-haltpoll.c
> +++ b/drivers/cpuidle/cpuidle-haltpoll.c
> @@ -28,11 +28,8 @@ static enum cpuhp_state haltpoll_hp_state;
>  static int default_enter_idle(struct cpuidle_device *dev,
>                               struct cpuidle_driver *drv, int index)
>  {
> -       if (current_clr_polling_and_test()) {
> -               local_irq_enable();
> -               return index;
> -       }
>         arch_cpu_idle();
> +
>         return index;
>  }
>
> --
> 2.34.1
>
