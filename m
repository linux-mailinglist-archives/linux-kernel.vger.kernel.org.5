Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40377779657
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbjHKRmD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Aug 2023 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbjHKRmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:42:00 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960B2115
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:42:00 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-56ddf189fa0so309847eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775720; x=1692380520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg7Z+vV9H9aEzcrA+mTUlFoFLA7yX9brjUzEw77uLqk=;
        b=AAJVQs/+2MRIbry7TNlKJ9GX6TyNfAiEOzRbVnBKz6P22oIIaKba10rTnljTlVdtIM
         PHqQy+I9G7JxvCfgq7SORXjx4qgCkDbgG2Id15C03MDEw3ehSaqPfROX69UnZEJZwl9K
         VuFgb6HVAXDOpeuHq6pYDvNVqLyshR/38x7xbSz7Jpkq7y1GhlfRwUZOqbmilTB3bRP5
         2AaypNza3CnHbZ+7+qY2wHUFoVEEScn7sA6MuyrNCtBdpeehAJLWGdqce3+MK/fAcUx1
         ihvLH9u9qdvI0Hw63FW6aaSATZ/60jiAvkFmrtYJthTTQ2SFY5EXQIzbIwt7BuHyXeyw
         90fg==
X-Gm-Message-State: AOJu0YwvuoVpbqNixuNd+8TXImGFebe58nYzmkT2sbZdoGIF7a/ara4n
        jbVTsXEZsX+GlgKyj/8gimoe2zryIteYvTW0+kqKqZqT2po=
X-Google-Smtp-Source: AGHT+IFWJsJDSw9eiURzgO/D9vc7t2YwY3MkNJ2WoTlwnzgAerT+EDpK8qRBpwbJbFTwNP02knrPOrKaZdLCtuVR+vM=
X-Received: by 2002:a05:6820:1687:b0:566:951e:140c with SMTP id
 bc7-20020a056820168700b00566951e140cmr2445285oob.1.1691775719854; Fri, 11 Aug
 2023 10:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230811170049.308866-1-frederic@kernel.org> <20230811170049.308866-10-frederic@kernel.org>
In-Reply-To: <20230811170049.308866-10-frederic@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 19:41:48 +0200
Message-ID: <CAJZ5v0hWjbp5ALCkiPP0=7CmDmWJzWE-zh2CP6EFLSbShTnVcQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] x86: Remove the current_clr_polling() call upon
 mwait exit
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
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
> mwait_idle_with_hints() is mostly called from cpuidle which already sets
> back TIF_NR_POLLING and fold TIF_NEED_RESCHED if necessary.
>
> The only non-cpuidle caller is power_saving_thread() which acts as an idle
> loop and is the only reason why mwait_idle_with_hints() carries a costly
> fully ordered atomic operation upon idle exit.
>
> Make this overhead proper to power_saving_thread() instead which already
> duplicates quite some cpuidle code.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  arch/x86/include/asm/mwait.h | 1 -
>  drivers/acpi/acpi_pad.c      | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
> index 920426d691ce..c1be3775b94a 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -134,7 +134,6 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
>                         }
>                 }
>         }
> -       current_clr_polling();
>  }
>
>  /*
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index 7a453c5ff303..5a44afafe185 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -174,6 +174,7 @@ static int power_saving_thread(void *data)
>                         stop_critical_timings();
>
>                         mwait_idle_with_hints(power_saving_mwait_eax, 1);
> +                       current_clr_polling();
>
>                         start_critical_timings();
>                         tick_broadcast_exit();
> --
> 2.34.1
>
