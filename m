Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A89E7F1369
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjKTMeJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 07:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTMeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:34:07 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A21F7;
        Mon, 20 Nov 2023 04:34:03 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6d31666d89cso623177a34.1;
        Mon, 20 Nov 2023 04:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700483642; x=1701088442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOYntcNL1KZc0ge/tQKhNBAvlh0SCDjd66OAjfQiGAw=;
        b=MMaRxzfKYzW/awQ2p7UPLGJTsQyb8Wiuog40dmQAjx0z3fIn4t7+XRniVFx2+0FIti
         Ej7pZqwi3P1slFZyC/m3//5RgpTMDDsrp9dggTN/VdWKIwZbVMHsexB78gtfDvRXXHX6
         973chT+6x28kQLb1+NU+2geF7glHqCvIX9aVlsayiO6VtFln2r7OouQRyOyxASaanscU
         8j6yMoDfKrKo5LRt9BGHVLO8UViEz2XasHUa856ClZloHTKmi2dZmqHi1se56UJNhEO5
         j06C5ozYUmeklfm9AMBtvKoViQUTi2Q1A/fCO/J5ySb0ezh6SW2T8EFqcqyl0E+6usBD
         Vr4g==
X-Gm-Message-State: AOJu0YzpeL0AYGto5P3qo3AIZme75nfWTik7vVa3M8xmOi4jbwG6gfMg
        C1mzFtBdtfiUOm+NC0RUqgVdR5bU/RIIyASVGdc=
X-Google-Smtp-Source: AGHT+IHOhga94JMqtY8hoAxuRge3pX+yrowVNWJ1RcCc2pGQgiUNtVlE+tAxUR7Q7yYHZcKpMtKT5b8WQ/iMJBS5YbM=
X-Received: by 2002:a05:6820:169:b0:583:fc94:c3fd with SMTP id
 k9-20020a056820016900b00583fc94c3fdmr6797935ood.0.1700483642570; Mon, 20 Nov
 2023 04:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20231120081516.55172-1-chris.feng@mediatek.com>
In-Reply-To: <20231120081516.55172-1-chris.feng@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Nov 2023 13:33:49 +0100
Message-ID: <CAJZ5v0g1zQvgqRrThoAenm+YAfTNdeAkn=hCu6Hk8MtGrcEXNA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: Fix the bug where wake events cannot
 wake system during hibernation
To:     Chris Feng <chris.feng@mediatek.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, hua.yang@mediatek.com, ting.wang@mediatek.com,
        liang.lu@mediatek.com, chetan.kumar@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 9:15 AM Chris Feng <chris.feng@mediatek.com> wrote:
>
> Wake-up events that occur in the hibernation process's
> hibernation_platform_enter() cannot wake up the system. Although the
> current hibernation framework will execute part of the recovery process
> after a wake-up event occurs, it ultimately performs a shutdown operation
> because the system does not check the return value of
> hibernation_platform_enter(). Moreover, when restoring the device before
> system shutdown, the device's I/O and DMA capabilities will be turned on,
> which can lead to data loss.

This isn't correct, because devices are enabled to do IO and DMA
already before saving the hibernation image.

The problem really only is that if a wakeup event occurs before
putting the system into the final low-power state, it will be missed,
so the patch subject should be something like "Avoid missing wakeup
events during hibernation".

> To solve this problem, check the return value of
> hibernation_platform_enter(). When it returns -EAGAIN or -EBUSY, execute
> the hibernation recovery process, discard the previously saved image, and
> ultimately return to the working state.
>
> Signed-off-by: Chris Feng <chris.feng@mediatek.com>
> ---
> [PATCH v2]:
>  - Execute the hibernation recovery process and return to the working state
>    when the return value of the function hibernation_platform_enter() is
>    -EAGAIN or -EBUSY. Both of the two values may indicate the occurrence of
>    a wake-up event.
> ---
>  kernel/power/hibernate.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 8d35b9f9aaa3..7e39a9baca9e 100644
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
> +                       pr_err("Hibernation Abort.\n");

This is not an error condition, so pr_err() is not the right level.
pr_info() would suffice.

Also the message needs to be more precise, so whoever reads it will
know that this is about a (legitimate) wakeup event.

> +                       return;
> +               }
>                 fallthrough;
>         case HIBERNATION_SHUTDOWN:
>                 if (kernel_can_power_off())
> --
