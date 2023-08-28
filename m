Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB68578BB32
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjH1Wvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjH1WvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:51:17 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D247011C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:51:14 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bda8559fddso2853445a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693263074; x=1693867874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DIqwskK0oYqXSVa28hgr5U7LAJbKxCjHL8WYKkpGDQ=;
        b=ITw2jWGaLstQYHZ9c72vF7WGCcIAi19eDX3cFfRNLdrfimlVzgIXnxJl8E8LemmLJw
         gBq9DJpbixcO13fzBluyjR3E4nO1TUEm1DoAI3raq0fYmHI2k7BAc/MClLntR3pIj9Sm
         6W3wYpTON1B7JhNkVSddmHJCF0yCvYoWE0JIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693263074; x=1693867874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DIqwskK0oYqXSVa28hgr5U7LAJbKxCjHL8WYKkpGDQ=;
        b=KLb6wIuPXljZM+jzlc1NCdV/kQIZY8ihUfUOhUbeCJ8GQI5RpzryTbKAR2XHjL44/q
         JPm5tizq7cIbJoo4W6ISvM6vP5OlwuznahhbjdG41X7cXkAYg06TsBZt/zxFoNxPXkES
         x0PyiLE350cXsMpZ8nTdM+hzODgjF6sqsCcbpny4doP/a4usMCZo7qFT1J7VgEifd1if
         MnZ0KEs50gFyIO2H8719xCkVrg0jKKJx+CJ8nifCRoazhEb8qX6mhlhYaCvBqGnnSfq/
         dIjXDMDChNXj0sGBXv2w4ZJpm6YfCvKz2teky8/X27QwNprMEhdyfPanVydCxZZXIN8+
         HnoQ==
X-Gm-Message-State: AOJu0Yx/+2dV17jlhUXtZWQRCewqPyx3YpR6WxZgpnBbi5J+2YTFx51I
        8thqA2uXoDbTLk9ypn68MFp3bRBspIewiaV5n2mAiw==
X-Google-Smtp-Source: AGHT+IFhaBwbYY6NH5M8NCoCeXN2tAsEyjtJJk1uTx2T543prAKt6iO221j6wbVTc68tchaDYZOJGox5XoJSGcAlo+Y=
X-Received: by 2002:a05:6870:3906:b0:1c8:bf19:e1e4 with SMTP id
 b6-20020a056870390600b001c8bf19e1e4mr13435455oap.37.1693263074222; Mon, 28
 Aug 2023 15:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com> <20230828100313.3051403-1-benchuanggli@gmail.com>
In-Reply-To: <20230828100313.3051403-1-benchuanggli@gmail.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Mon, 28 Aug 2023 18:51:03 -0400
Message-ID: <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, SeanHY.chen@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        reniuschengl@gmail.com, skardach@google.com,
        stable@vger.kernel.org, ulf.hansson@linaro.org,
        victor.shih@genesyslogic.com.tw, victorshihgli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben, thank you for reviewing this patch. See below.

On Mon, Aug 28, 2023 at 6:03=E2=80=AFAM Ben Chuang <benchuanggli@gmail.com>=
 wrote:
>
> There is a situation for your reference.
> If `allow_runtime_pm' is set to false and the system resumes from suspend=
, GL9763E
> LPM negotiation will be always disabled on S0. GL9763E will stay L0 and n=
ever
> enter L1 because GL9763E LPM negotiation is disabled.
>
> This patch enables allow_runtime_pm. The simple flow is
> gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled -> (=
a)
> (a) -+--> idle -->  gl9763e_runtime_suspend() -> LPM enabled
>      |
>      +--> no idle -> gl9763e_runtime_resume() -> LPM disabled
>
> This patch disables allow_runtime_pm. The simple flow is
> gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled (no =
runtime_pm)
>
> Although that may not be the case with the current configuration, it's on=
ly a
> possibility.
>

Thanks so much for bringing this up. We have discussed internally and
as far as we know, the current patch will work correctly in all cases.
Could you verify our argument please?

The following assumptions are key:

1. If CONFIG_PM is set, the runtime_pm framework is always present, i.e. th=
ere
cannot exist a kernel which has PM but lacks runtime_pm.
2. The pm_runtime framework always makes sure the device is runtime
active before
calling XXX_suspend, waking it up if need be. So when XXX_suspend gets call=
ed,
the device is always runtime active.
3. if CONFIG_PM is set, runtime_pm can only be disabled via
echo on > /sys/devices/.../power/control, and then the runtime_pm framework
always keeps the device in runtime active. In such case LPM negotiation is
always disabled.

Using these assumptions, we get:

Runtime_pm allowed:
=E2=80=94------------------
gl9763e_runtime_resume() -> LPM disabled -> gl9763e_suspend() -> LPM enable=
d
-> gl9763e_resume() -> LPM disabled -> (a)
(a) -+--> idle --> gl9763e_runtime_suspend() -> LPM enabled
|
+--> no idle -> nothing - already runtime active -> LPM disabled

Runtime_pm not allowed:
=E2=80=94----------------------
gl9763e_runtime_resume() always called -> LPM always disabled
gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled

In all above cases the LPM negotiation flag is correct.

> >
> > sdhci doesn't know anything about the bus.  It is independent
> > of PCI, so I can't see how it would make any difference.
> > One of the people cc'ed might know more.  Jason Lai (cc'ed)
> > added it for runtime PM.
> >
>
> As far as I know, when disabling LPM negotiation, the GL9763E will stop e=
ntering
> L1. It doesn't other side effect. Does Jason.Lai and Victor.Shih have any=
 comments
> or suggestions?

Sounds like everyone assumes that you can freely change LPM
negotiation on the PCIe
bus after the cqhci_suspend() and sdhci_suspend_host() calls, so we will as=
sume
that too.
