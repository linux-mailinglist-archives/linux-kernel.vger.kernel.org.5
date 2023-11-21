Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750A57F36FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjKUT46 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 14:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKUT45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:56:57 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C344D19B;
        Tue, 21 Nov 2023 11:56:47 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d7e4e61bedso61948a34.1;
        Tue, 21 Nov 2023 11:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700596606; x=1701201406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZOeqvRu3LxXiXrSd8uRhoWsi+0XXhfdsm4I1VLjf3E=;
        b=rJIJzUrRnpbYgZK6BkjlbrWcfpssqPzIHQB3LBNOHypWzREeicTzqfu7ffvU0EbpPp
         1PhyBExusenPeV3CVQinpZxJc62ZOem5jBi7BOqB/KzRXGkqOJ2rWHsYQ45Q0HoVS8Hn
         79N6ayKJpPXLcAhQ2l687o2ajBpRlXbUkJZhDmhEE8MsLC8TTQ/LepMYrH0aXHIuSK4s
         HPizehaAJPd5OU/Kzag0NLTYMZs8kRg0BqlmOWQwrBPa5zg4BvdQjOFbfjn/JUaP2Qfq
         3NzX4buu/zfcn5hyHShX+s/02l59ZauC4H1QE+VMHBeJaWaKphbSyoGANyQr8sXalaDP
         wTOA==
X-Gm-Message-State: AOJu0YzDJjk2tBzKjKjoHkIL9qZY4XWRanEowdD/I61Tq64VjF2SXUa+
        PnrAE37E4FsbVeK3dIY1YzaOC7luafdBuWGh7g0=
X-Google-Smtp-Source: AGHT+IGfoh2AoQ1+r30cMz7Wi8VaxFkshXC+ngX/S9+JfPwwxHfOaJ4eH6D9XO8XC+cmqNdq15Zv1NpUwr2qAfyohqM=
X-Received: by 2002:a05:6820:311:b0:58c:e80a:537d with SMTP id
 l17-20020a056820031100b0058ce80a537dmr411410ooe.1.1700596606357; Tue, 21 Nov
 2023 11:56:46 -0800 (PST)
MIME-Version: 1.0
References: <430a1271-a45c-4f5a-90c7-a62703ac7cf4@ancud.ru>
In-Reply-To: <430a1271-a45c-4f5a-90c7-a62703ac7cf4@ancud.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Nov 2023 20:56:35 +0100
Message-ID: <CAJZ5v0gHgfscDCGo3P5JVn73uUTBkpfCqRJV3QcOnFt8FP7FhQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: LPIT: fix u32 multiplication overflow
To:     Nikita Kiryushin <kiryushin@ancud.ru>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
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

On Thu, Nov 9, 2023 at 7:09 PM Nikita Kiryushin <kiryushin@ancud.ru> wrote:
>
> In lpit_update_residency there is a possibility of overflow
> in multiplication, if tsc_khz is large enough (> UINT_MAX/1000).

That would be a TSC ticking at hundreds of millions of kHz if I'm not
mistaken.  Why is it really a concern?

> Change multiplication to mul_u32_u32.

So why is this better?

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: eeb2d80d502a ("ACPI / LPIT: Add Low Power Idle Table (LPIT) support")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
>   drivers/acpi/acpi_lpit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
> index c5598b6d5db8..794962c5c88e 100644
> --- a/drivers/acpi/acpi_lpit.c
> +++ b/drivers/acpi/acpi_lpit.c
> @@ -105,7 +105,7 @@ static void lpit_update_residency(struct
> lpit_residency_info *info,
>                 return;
>         info->frequency = lpit_native->counter_frequency ?
> -                               lpit_native->counter_frequency : tsc_khz * 1000;
> +                               lpit_native->counter_frequency : mul_u32_u32(tsc_khz, 1000U);
>         if (!info->frequency)
>                 info->frequency = 1;
>   -- 2.34.1
>
