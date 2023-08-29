Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A7278C9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbjH2Qfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237496AbjH2QfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:35:22 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0B4194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:35:20 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57358a689d2so2467890eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693326918; x=1693931718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0pWbpInDstIHBeP/BS4VOTRMTkNBmu1VJYzwpZwV48=;
        b=mfRZRWbghdgh0zjCP5AmsjeyhQDj/khco0H/tA3gxDMc0QrOgFq/kvqlvs+R9YQDuP
         XAkfzfLzsKH+qlyoeeORg3tnPEYuSLDN+OuUD5STnwjIhHlG7uFZv0EJcV7nJxpSfPYV
         4GMH/NhgRY2yaAqGR5DD7PmxJwAVgrcf66RY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693326918; x=1693931718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0pWbpInDstIHBeP/BS4VOTRMTkNBmu1VJYzwpZwV48=;
        b=X3xnO2eaVNsknGklnPfSuD4kvdLgjtyHjoEe2pfM9rH5UnF7x/NYWoiYGAa+0cy2Xb
         rUSb69CNt+mxDCusaAvJe4iysJDoEgtGlRayfZ+2C+fO2k3ZtGwwk62YwTjBBY1XKFWI
         en+u4GsET82Kuj0Zf/Fh6lRDYyhQ0/tje7oW8sfH/nrLiDGgiOkX0lkttiSPqgrWIDmH
         28KvuvS3Z9LvRmaeHoyAAwsVgv1fxALyGupQ1y33do207HgBdyANkgAUOj1weaJmjzHa
         otDK6rNELz4T5PtHHfUEMSADzZIzsOzQ7mAFquLf4AaVQDcwAJjnss/BU8le4FH5kXGd
         t6WQ==
X-Gm-Message-State: AOJu0YwuG+qtQ23JtUskFwRB7H4V6fN196l4zQlf6kvJ/OYF8rEEESah
        dCK6sw42q5uxuONYKuo5XM4kDIytbdTL/sGmXpdfew==
X-Google-Smtp-Source: AGHT+IGc5a3RHIDC903KhYAdCNp4NhyszcvbVEQ3ozZ1UJetLD8jl2bwSLKwJYPtWPl7FhSb4DGeiiI4ID14JE+nfzg=
X-Received: by 2002:a4a:765b:0:b0:571:28d5:2c72 with SMTP id
 w27-20020a4a765b000000b0057128d52c72mr15448838ooe.7.1693326918612; Tue, 29
 Aug 2023 09:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com>
 <20230828100313.3051403-1-benchuanggli@gmail.com> <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
 <CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com>
In-Reply-To: <CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Tue, 29 Aug 2023 12:35:07 -0400
Message-ID: <CAG-rBihBkTeZR6yMSF+5zg-h1U1pxGuN-nv=Y7DXLvxV435hDw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Ben Chuang <benchuanggli@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     skardach@google.com, adrian.hunter@intel.com,
        SeanHY.chen@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, reniuschengl@gmail.com,
        stable@vger.kernel.org, ulf.hansson@linaro.org,
        victor.shih@genesyslogic.com.tw, victorshihgli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rafael for advice on runtime_pm corner cases.

On Mon, Aug 28, 2023 at 10:48=E2=80=AFPM Ben Chuang <benchuanggli@gmail.com=
> wrote:
>
>
> My concern is that when runtime_pm is false, gl9763e is disabled LPM
> negotiation, gl9763e can't enter L1.x and s0ix may fail.
> It seems that runtime_pm will always exist and that's ok.
>

Thank you. I believe we can address your concern.

- XXX_suspend/XXX_resume (i.e. classic suspend/resume) depends on
  CONFIG_PM_SLEEP. This always selects CONFIG_PM. This always includes
  the runtime_pm framework. So, if XXX_suspend/XXX_resume gets called,
  the runtime_pm framework is always present, but may not be actively
  managing the device.

- "when runtime_pm is false" AFAIK the only way to disable runtime_pm
  when CONFIG_PM is set, is to write "on" to /sys/devices/.../power/control=
.
  See https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-po=
wer
  In that case, the runtime_pm framework will activate the device, calling
  XXX_runtime_resume() if necessary. Are there other ways of disabling it?

- if /sys/devices/.../power/control is "on", then:
  gl9763e_runtime_resume() always called -> LPM always disabled
  gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled
  In between "classic" XXX_suspend and XXX_resume, LPM will be enabled,
  so the device can enter L1.x and S0ix.

And the LPM negotiation flags look correct.
Does that address your concerns?
