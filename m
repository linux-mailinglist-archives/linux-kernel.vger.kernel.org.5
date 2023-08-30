Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934CA78E0F2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbjH3UuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbjH3UuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:50:21 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61A71A4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:49:44 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-565439b6b3fso132806a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693428501; x=1694033301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TmLk0fQBF61eW6D8ZlImNTOGih/aAgkyRTy6ROPKDY=;
        b=LfS784br5NUlyUIt5ff4Bq98xxRa7UIDkISOWN6wERwP7uAjI4nwQEFejcgT/4Jok9
         GtW408TN5b+ooVh/jXWi0VZ5tMWl+2OwPny3BhahA4Sn1DLfm9CiB3vQTToF6DilcyPe
         Sspa0TkxnkpvPnn0aGIOE1sHLlrbUS88L4+MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428501; x=1694033301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TmLk0fQBF61eW6D8ZlImNTOGih/aAgkyRTy6ROPKDY=;
        b=fmJwXHMFV1zz2Axbw1KoffoAVTxvUQW963LkwHpkHJcOcZmpmkQEN+0AIkREeKxqJS
         p/0K9EvK6nzwrphA6BzOZZbLElIBj300kRFW6kJ73J5CFKOCxme+5zIFGlfRXeQ1+HQX
         OHiouHS0MK7ktYeXTbzBJD7FoLDvdZY56W+fvYF3rc3nPIMEma1HnT8q8Lfppax8yT0h
         fRXpbdqkrbfDmMm1wYTWXDW4JIdUE3n45ZXAzoHejs91UnGLuVlVGjuqqsn+LFQ8kzD4
         gnTKHzlsiTaNGOm1PZY3g2+UJYz7YdJoc5TVYSo00PWH2CCJSXfM6Pnne01G5VoJsq/t
         YDSg==
X-Gm-Message-State: AOJu0YzSzXAsAn/m8/W/vFiaO7r+eoI4KbeJPoBtsCMX+egSxb8vU45h
        vvG7fRNmWY+S3JjoUMWZJyjFxDTvKz/csqO2UMH5ZBou9oZRnm8NQrU=
X-Google-Smtp-Source: AGHT+IEjRi05Wg22Qjjn/hflcI7CQBa5XMdC0mt0jO+fQBSO3iMmADiYtjmP70bxRwmPUSH03EeDMSyRdegww4AwyXw=
X-Received: by 2002:a4a:3416:0:b0:566:ec2f:36d0 with SMTP id
 b22-20020a4a3416000000b00566ec2f36d0mr3163656ooa.2.1693426449335; Wed, 30 Aug
 2023 13:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com>
 <20230828100313.3051403-1-benchuanggli@gmail.com> <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
 <CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com>
 <CAG-rBihBkTeZR6yMSF+5zg-h1U1pxGuN-nv=Y7DXLvxV435hDw@mail.gmail.com> <CACT4zj_84eCYOq56zdqaydaEGqyqBrXDrsTkDRyCntvVF78-0A@mail.gmail.com>
In-Reply-To: <CACT4zj_84eCYOq56zdqaydaEGqyqBrXDrsTkDRyCntvVF78-0A@mail.gmail.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Wed, 30 Aug 2023 16:13:58 -0400
Message-ID: <CAG-rBigLPfJ6u5LQZ4FwMMm_h3b5fQiRYFkwNjFHm4cDCN1VRw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        skardach@google.com, adrian.hunter@intel.com,
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

On Tue, Aug 29, 2023 at 10:27=E2=80=AFPM Ben Chuang <benchuanggli@gmail.com=
> wrote:
>
> >
> > - if /sys/devices/.../power/control is "on", then:
> >   <snip>
> >
> In this cas, after gl9763e_resume(), it is LPM disabled.
> Is there no chance for gl9763e to enter L1.x again when the system is idl=
e?
>

AFAIK the only way to disable runtime_pm is to write:
  $ echo on > /sys/devices/.../power/control
where
  $ echo auto > /sys/devices/.../power/control
      means: runtime_pm is actively managing the device, device can be "act=
ive"
      or "suspended".
  $ echo on > /sys/devices/.../power/control
      means: runtime_pm is not managing the device, device is "active" only=
.

In the "auto" case, we know what should happen: LPM negotiation is enabled =
when
idle, disabled when active.

What should be the LPM negotiation state in the "on" case? We have to
make a choice:
a) LPM negotiation disabled: normal performance, high power consumption, OR
b) LPM negotiation  enabled: low    performance, low  power consumption

If userspace disables our device's runtime_pm by writing "on", it expects t=
he
device to be always-on. It should then expect a higher power consumption.
It should then also expect a performance that is not-worse than the "auto" =
case.

So my suggestion would be to use (a), which is what this patch does.

Appreciate your thoughts.
