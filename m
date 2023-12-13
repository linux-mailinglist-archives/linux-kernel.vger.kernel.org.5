Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C64811337
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378886AbjLMNqA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 08:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjLMNp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:45:59 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810B7B2;
        Wed, 13 Dec 2023 05:46:05 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-203223f3299so16224fac.0;
        Wed, 13 Dec 2023 05:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702475165; x=1703079965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aBnUrw2auNmCR4JylYCwXdWoHJEVE3iA2QJaSTM4hc=;
        b=POzbZFz9i2zHRpTD0Zqi30aSg8GWH+eP1LFs+QbnROgKJGl/KPjWEg2GoB99YuvpzA
         TWhwTzXZ3aQckzomUhD21HlQwRKAiE1eM79ii1vrNvg0NBx1DDmcjlnVHnkk8wJcUAvB
         lIvVgGWsZ7ZY4JDTDa6yP/SXl1FQ07hZuE5Wt1l7qF3fuk0FX2s90446WpZB7Cem2Y33
         BSaim1tygk2hTHKSCkXuUU/F6fvUjr6fXpZyGKk78B9GBGsFPWbJPgQFz8ZPa5q4CnTq
         sanUpExtjf6L5EqIYC3cJXw0u3EcWZR0SXBqMB6RP8+Wby1SUgBFhr7ylDiH/hz6EIkZ
         uUpw==
X-Gm-Message-State: AOJu0YyWqsX9BxfQtRxjNMuGn9QPkGHcP85oCA3qAEoFfwDb2LY7bcof
        nOLLBqeWsOmIPx1j0SJ478cf4B6D/gsnNh19v6I=
X-Google-Smtp-Source: AGHT+IFF1OU+JaCmlcPBJbNEsSUHPZJuxNB/1NU04QyHKBRsKos5UWHlHLDlzxP1EQZKrj0x9KfkOm85RsELDq0nhAY=
X-Received: by 2002:a05:6871:208c:b0:1fb:19d6:8715 with SMTP id
 ry12-20020a056871208c00b001fb19d68715mr14367276oab.4.1702475164701; Wed, 13
 Dec 2023 05:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20231213083251.186935-1-chris.feng@mediatek.com>
In-Reply-To: <20231213083251.186935-1-chris.feng@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Dec 2023 14:45:53 +0100
Message-ID: <CAJZ5v0jfEDYkDRPrqb0KirDG+o8W7aRUP9vqGBOiFOV-gHBDGg@mail.gmail.com>
Subject: Re: [PATCH v4] PM: hibernate: Avoid missing wakeup events during hibernation
To:     Chris Feng <chris.feng@mediatek.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, hua.yang@mediatek.com, ting.wang@mediatek.com,
        liang.lu@mediatek.com, chetan.kumar@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 9:33 AM Chris Feng <chris.feng@mediatek.com> wrote:
>
> Wakeup events that occur in the hibernation process's
> hibernation_platform_enter() cannot wake up the system. Although the
> current hibernation framework will execute part of the recovery process
> after a wakeup event occurs, it ultimately performs a shutdown operation
> because the system does not check the return value of
> hibernation_platform_enter(). In short, if a wakeup event occurs before
> putting the system into the final low-power state, it will be missed.
>
> To solve this problem, check the return value of
> hibernation_platform_enter(). When it returns -EAGAIN or -EBUSY (indicate
> the occurrence of a wakeup event), execute the hibernation recovery
> process, discard the previously saved image, and ultimately return to the
> working state.
>
> Signed-off-by: Chris Feng <chris.feng@mediatek.com>
> ---
> [PATCH v2]:
>  - Optimize the "if" condition logic.
>  - Link to v1: https://lore.kernel.org/all/20231024091447.108072-1-chris.feng@mediatek.com
> [PATCH v3]:
>  - Use pr_info instead of pr_err.
>  - Fix undeclared function 'swsusp_unmark' build error.
>  - Refine commit and printing message.
>  - Change the subject.
>  - Link to v2: https://lore.kernel.org/all/20231120081516.55172-1-chris.feng@mediatek.com
> [PATCH v4]:
>  - Define an empty swsusp_unmark() function for scenarios where
>    CONFIG_SUSPEND is not defined.
>  - Link to v3: https://lore.kernel.org/all/20231204021155.10434-1-chris.feng@mediatek.com
> ---
>  kernel/power/hibernate.c | 10 ++++++++--
>  kernel/power/power.h     |  2 ++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index dee341ae4ace..621326b3e679 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -642,9 +642,9 @@ int hibernation_platform_enter(void)
>   */
>  static void power_down(void)
>  {
> -#ifdef CONFIG_SUSPEND
>         int error;
>
> +#ifdef CONFIG_SUSPEND
>         if (hibernation_mode == HIBERNATION_SUSPEND) {
>                 error = suspend_devices_and_enter(mem_sleep_current);
>                 if (error) {
> @@ -667,7 +667,13 @@ static void power_down(void)
>                 kernel_restart(NULL);
>                 break;
>         case HIBERNATION_PLATFORM:
> -               hibernation_platform_enter();
> +               error = hibernation_platform_enter();
> +               if (error == -EAGAIN || error == -EBUSY) {
> +                       swsusp_unmark();
> +                       events_check_enabled = false;
> +                       pr_info("Hibernation process aborted due to detected wakeup event.\n");
> +                       return;
> +               }
>                 fallthrough;
>         case HIBERNATION_SHUTDOWN:
>                 if (kernel_can_power_off())
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 17fd9aaaf084..8499a39c62f4 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -175,6 +175,8 @@ extern int swsusp_write(unsigned int flags);
>  void swsusp_close(void);
>  #ifdef CONFIG_SUSPEND
>  extern int swsusp_unmark(void);
> +#else
> +static inline int swsusp_unmark(void) { return 0; }
>  #endif
>
>  struct __kernel_old_timeval;
> --

Applied as 6.8 material, but I have rephrased the pr_info() message
added by this patch.

Thanks!
