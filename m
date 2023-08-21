Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD5782714
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjHUK3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjHUK3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:29:42 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B042CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:29:40 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d7485d37283so1527044276.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692613779; x=1693218579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HClNkkt1LPNSP32CQjmEgSvFflcpDxIkOOxKyLAh2QA=;
        b=UcrEdBjt5NDCsNnQMqLMtShcldwpYPw6Qaw3sLm8h2W1ugwrxDq1eA1ZRO2sXOdW+l
         FLX3BoMAU65JlVrdi7L/5WKTS/ijHmBmnzLEE8YXbKg5xpto2dKcuZJ/grBA1N+d933C
         nHFgvknea0t7vVBQxHGrRGQbO3b7mttnkITuD6WAVGcFcGBQsDcqDoioSDmwKeO9QhHJ
         XpCGNYIyIGkLfUaTTsdX6PsolR1/JGI0yaSdvq218wApvlalFLrs2vaItuyATBTLeeTY
         xuezyOhGw7Ucne08ZpplzxxOCy83lzwxoo/9CNOOECdAcWvH8GZqv5sZPRY+SIIRsB9F
         t2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692613779; x=1693218579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HClNkkt1LPNSP32CQjmEgSvFflcpDxIkOOxKyLAh2QA=;
        b=k+4dWrqLaZiMKQnrFpI6YPF67roveFMTkeyOIfegK3EGnkvG+n2BIklKkOBYvF6cPE
         G4zW0xQTy1EWZ3DckyqkrosTBV1KVf5oZXV5oMv0LvEVDqy31YqPHXl0upMNj4X7n1ap
         Ro1rXn6zbhkZFQukzfEhK/1HRVyPsQcYiFpNQ3eNF6wUum/TefdM4wV9Y4Pe56OxiwRM
         a7U3p2Wy6BWhN0YCh4TrXaTck7w1soxVM1BUIlwH/EXWaFpFgOWiOWIfuYWW1sTTcod2
         WSS/FzQx8vGp/pwENEwJ2Qwu5RA13+1WrFZwi1RoOdgaURBewL1j/Vi+4dLAQlgK5Ykm
         9bvA==
X-Gm-Message-State: AOJu0Yx1fvB4c01DoM61sLtay3n7EvFCrs0PWXyg3fsvGieUrWFxFl2f
        vXjCqwy7GTOk7+f8pSp22puUc42Eap92Ck+/1QW7xQ==
X-Google-Smtp-Source: AGHT+IElbpEXRCwCzwUjY67gH5o/HQteT8vWYdkfiv68uy64ksJ8qaKJ1LJHiNAKZvyM4n6ARgb33Tczj1IITBeA8zg=
X-Received: by 2002:a25:938c:0:b0:d62:796e:241f with SMTP id
 a12-20020a25938c000000b00d62796e241fmr6812080ybm.7.1692613779665; Mon, 21 Aug
 2023 03:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230818144850.1439-1-mario.limonciello@amd.com>
In-Reply-To: <20230818144850.1439-1-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Aug 2023 12:29:28 +0200
Message-ID: <CACRpkdaM820GMVyViKKkvFHfgAnNt2f3DvoZbC9HT1d7FBPBXg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Mask wake bits on probe again
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sachi King <nakato@nakato.io>, stable@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Shubhra Prakash Nandi <email2shubhra@gmail.com>,
        Carsten Hatger <xmb8dsv4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 4:49=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> Shubhra reports that their laptop is heating up over s2idle. Even though
> it's getting into the deepest state, it appears to be having spurious
> wakeup events.
>
> While debugging a tangential issue with the RTC Carsten reports that rece=
nt
> 6.1.y based kernel face a similar problem.
>
> Looking at acpidump and GPIO register comparisons these spurious wakeup
> events are from the GPIO associated with the I2C touchpad on both laptops
> and occur even when the touchpad is not marked as a wake source by the
> kernel.
>
> This means that the boot firmware has programmed these bits and because
> Linux didn't touch them lead to spurious wakeup events from that GPIO.
>
> To fix this issue, restore most of the code that previously would clear a=
ll
> the bits associated with wakeup sources. This will allow the kernel to on=
ly
> program the wake up sources that are necessary.
>
> This is similar to what was done previously; but only the wake bits are
> cleared by default instead of interrupts and wake bits.  If any other
> problems are reported then it may make sense to clear interrupts again to=
o.
>
> Cc: Sachi King <nakato@nakato.io>
> Cc: stable@vger.kernel.org
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Fixes: 65f6c7c91cb2 ("pinctrl: amd: Revert "pinctrl: amd: disable and mas=
k interrupts on probe"")
> Reported-by: "Shubhra Prakash Nandi" <email2shubhra@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217754
> Reported-by: "Carsten Hatger" <xmb8dsv4@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217626#c28
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Patch applied for fixes so we get some rotation in linux-next.

Thanks for looking into this Mario!

Yours,
Linus Walleij
