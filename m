Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DE17E7366
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjKIVJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345014AbjKIVIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:08:55 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59B6D5C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 13:08:53 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5bd306f86a8so1102876a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 13:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699564133; x=1700168933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXYSdd3Scp9s+p6eiKxC4NVMsyUlEkxWa4iBppHaBEE=;
        b=FSxjn2hkF/vwm3iZRy7tpk+yB0dQqTM5QYLhMRh675ewCpE9sEIzKf4AvhV03PzjCu
         cQPeUdnm6aeteE6STo1yph/FFw0gwIB7gHW6KEfHxzYnqS/CxxlwRPgGkT6PUjY6jlbc
         1765OiG8fmr3oF9v4Q+Ku1K/ccJ4a6N+G1zEJDJy77er5WF8EpEXLnyOTyavmmlPHO6j
         aRJWndlW9ah7ZpiwjNmdqk7Mvci/RxxyUqqkw/HKm1blRP+76MjXxuQPnJuTv+zc2Qz9
         ypdMwB/P+tdoIjPDt7+W2j6XP59dZGaL4wLaDOR8TaTuE/IVBOE182FS/xbnTQDwLRih
         S1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699564133; x=1700168933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXYSdd3Scp9s+p6eiKxC4NVMsyUlEkxWa4iBppHaBEE=;
        b=GiKwx5KQ6x5n6DuHhupW0Zjs6XWZnlsLZKc60Yv2RXJDgXL69VRc1253J9ABrNdR1r
         S2zcItJV0E62IkzWJcwuFl6dCMU7/6bh4JvHp+E/YrVnbl1YB8tm3bAq5ioG+ya0iHO8
         TbZhe8v/2rdJNHk8swcWx+VTi+5BNg2JvIwC0+FHopezehJqd0GOjmDtJAKj+GEX1f3S
         8FKNnRaIo8lN/xm5dSHRVSXj4AOPWTL32YozypHbeY4/Go8Of0Om2xSI/E66LqCDPWpy
         MH52s+Vihl6x9GCj73rYtBCQqNKhEnDddPDN0aZMpcELjwQAGOPjgrsQ80dPuWaWV3Tt
         Zywg==
X-Gm-Message-State: AOJu0YwPIoNKz/o+NsjFLJJtWy40aWv807uKeSjzhyw6G+MVHZHPMPd9
        gD34gturU03WXz26iTfXEqB8I2ztjUtuDqeXqBM=
X-Google-Smtp-Source: AGHT+IGh60LkvVoUewwOiyQyyAbZqFDIP9dvXGs8eA3ytBuDBE1V0tp4d1jeCNb5LdW0X8Y6k5UkMG/B8A20ouV1q+M=
X-Received: by 2002:a17:90b:3902:b0:280:31a8:191d with SMTP id
 ob2-20020a17090b390200b0028031a8191dmr2603322pjb.39.1699564133128; Thu, 09
 Nov 2023 13:08:53 -0800 (PST)
MIME-Version: 1.0
References: <20231109155101.186028-1-paul.heidekrueger@tum.de>
In-Reply-To: <20231109155101.186028-1-paul.heidekrueger@tum.de>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 9 Nov 2023 22:08:42 +0100
Message-ID: <CA+fCnZcMY_z6nOVBR73cgB6P9Kd3VHn8Xwi8m9W4dV-Y4UR-Yw@mail.gmail.com>
Subject: Re: [PATCH] kasan: default to inline instrumentation
To:     =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 4:51=E2=80=AFPM Paul Heidekr=C3=BCger
<paul.heidekrueger@tum.de> wrote:
>
> KASan inline instrumentation can yield up to a 2x performance gain at
> the cost of a larger binary.
>
> Make inline instrumentation the default, as suggested in the bug report
> below.
>
> When an architecture does not support inline instrumentation, it should
> set ARCH_DISABLE_KASAN_INLINE, as done by PowerPC, for instance.
>
> CC: Dmitry Vyukov <dvyukov@google.com>
> Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D203495
> Signed-off-by: Paul Heidekr=C3=BCger <paul.heidekrueger@tum.de>
> ---
>  lib/Kconfig.kasan | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index fdca89c05745..935eda08b1e1 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -134,7 +134,7 @@ endchoice
>  choice
>         prompt "Instrumentation type"
>         depends on KASAN_GENERIC || KASAN_SW_TAGS
> -       default KASAN_OUTLINE
> +       default KASAN_INLINE if !ARCH_DISABLE_KASAN_INLINE
>
>  config KASAN_OUTLINE
>         bool "Outline instrumentation"
> --
> 2.40.1
>

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you for taking care of this!
