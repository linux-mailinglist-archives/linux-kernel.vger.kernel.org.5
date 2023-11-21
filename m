Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95BA7F372D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjKUUPF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 15:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKUUPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:15:03 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1C11A1;
        Tue, 21 Nov 2023 12:15:00 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58a106dd421so289493eaf.0;
        Tue, 21 Nov 2023 12:15:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700597699; x=1701202499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UP8hESYtpQcRpZlJ15KqFtLFayiF39ggrDfb/BLbyrA=;
        b=iMx9WpSq/ej2bmuLlFxH0mbn5K7UfYeheDIP7skrPvXQ1QPVksdQZDNGfMAfWkX8M2
         WRSwPSVPyaCihLop6w2GD4suAzLe5Z7xGz86URgKPuF/pQtNWv7qt21Xgvuz7Ej+HL5n
         k/R8vg6LoS9Zy5p7a9KG4xLpePEQ+WCCA15fHb9x1wrFnS/JVPK/cYQQhE0ONqM1dXB8
         v9cyEa0clvc73wWlAhvGsNUjV6EmPUuSKN50ivPWegUXpnkvep0bnp/xZE2x5AqhNAt2
         9RHZHhjCv6ucBE/hsbYv8Xzc6ZINHoqDkBQPqaZ0GK98SjJtkFiVW8boALzRr/YHKsRH
         FGOg==
X-Gm-Message-State: AOJu0Yw73U3mtGd8tidEe5boRGye8oNmHATw1HwuVExYQLSyqqD/n2CB
        RQF5nqXak6H8wrqo0cPiLUmM2cDQt6xKpOUH5Vc=
X-Google-Smtp-Source: AGHT+IHlw+nqBE34QxQ+n37MPYuwO+K3I9M7HUGacBube/dA9hEwVNSXcBdS7KPi+GIWd7FBAc9ZcmHLrbexD8KxeM8=
X-Received: by 2002:a4a:a604:0:b0:589:daaf:44a1 with SMTP id
 e4-20020a4aa604000000b00589daaf44a1mr574171oom.0.1700597699531; Tue, 21 Nov
 2023 12:14:59 -0800 (PST)
MIME-Version: 1.0
References: <430a1271-a45c-4f5a-90c7-a62703ac7cf4@ancud.ru> <CAJZ5v0gHgfscDCGo3P5JVn73uUTBkpfCqRJV3QcOnFt8FP7FhQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gHgfscDCGo3P5JVn73uUTBkpfCqRJV3QcOnFt8FP7FhQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Nov 2023 21:14:48 +0100
Message-ID: <CAJZ5v0jGSSevWuBKFK0z+bQ2QB9+GT=ofnY=MF=53N-r7QEhSw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: LPIT: fix u32 multiplication overflow
To:     Nikita Kiryushin <kiryushin@ancud.ru>
Cc:     Len Brown <lenb@kernel.org>,
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

On Tue, Nov 21, 2023 at 8:56 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 9, 2023 at 7:09 PM Nikita Kiryushin <kiryushin@ancud.ru> wrote:
> >
> > In lpit_update_residency there is a possibility of overflow
> > in multiplication, if tsc_khz is large enough (> UINT_MAX/1000).
>
> That would be a TSC ticking at hundreds of millions of kHz if I'm not
> mistaken.

That should be "hundreds of thousands of kHz", so I was mistaken.

But anyway:

> Why is it really a concern?
>
> > Change multiplication to mul_u32_u32.
>
> So why is this better?
>
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Fixes: eeb2d80d502a ("ACPI / LPIT: Add Low Power Idle Table (LPIT) support")
> > Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> > ---
> >   drivers/acpi/acpi_lpit.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
> > index c5598b6d5db8..794962c5c88e 100644
> > --- a/drivers/acpi/acpi_lpit.c
> > +++ b/drivers/acpi/acpi_lpit.c
> > @@ -105,7 +105,7 @@ static void lpit_update_residency(struct
> > lpit_residency_info *info,
> >                 return;
> >         info->frequency = lpit_native->counter_frequency ?
> > -                               lpit_native->counter_frequency : tsc_khz * 1000;
> > +                               lpit_native->counter_frequency : mul_u32_u32(tsc_khz, 1000U);
> >         if (!info->frequency)
> >                 info->frequency = 1;
> >   -- 2.34.1
> >
