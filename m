Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52F077DE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243810AbjHPKP0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Aug 2023 06:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243811AbjHPKPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:15:17 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401B1C1;
        Wed, 16 Aug 2023 03:15:16 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-589f784a972so28106987b3.0;
        Wed, 16 Aug 2023 03:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692180915; x=1692785715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRnD5MJxMIbxOVX7RD5xV6IP488gaBEltwZdndXE0OY=;
        b=HwXDakdLeNz44a49xn/Rv+iajFP6WCGlVnxN5GRFpZSjQGDMrLhJOsuNr045YUJmnR
         7mqYv8BuWhiaXqqxubHi/9DFcMbcEDOSUCts181P8KiO3zqWB/ZWZxJMuX4NbApN226I
         vZFEwKcW9kYxtRJFtTSTapWSBtMj4AD6Kt+TU4bUOQXCGGUyzNGYM5d8iK+oOspLJ2Mm
         JARkcFNwQ+4y+EGcWkA5pYs2qkaZ+S0+hHpRUopuYsMkAnY6Vv4Pke1K5BI9+0aRSkhh
         RitT/PVPO9Gwcsy8q5IYsf/N5G9pcwpbCMxoYxn5K2khyw1pTtzCky86m8PiqymuwlBj
         AWHA==
X-Gm-Message-State: AOJu0YzvWXJYTPTJNMUpicsaGPmeXHeagXaN+qE9VGIuEmJZ0TKockOp
        Zy4YPC1Wb9+MM03avIs3hOAj3dTtOP2zKg==
X-Google-Smtp-Source: AGHT+IHaLsl7oSDfHyspteEO0LXv7RWtke3UU0t3aHd5FbGEUtWt2Onlk8SqzjLrcQC6YCxiiXdrjA==
X-Received: by 2002:a0d:d447:0:b0:569:479f:6d7f with SMTP id w68-20020a0dd447000000b00569479f6d7fmr1088635ywd.43.1692180915237;
        Wed, 16 Aug 2023 03:15:15 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id c126-20020a814e84000000b00589e68edac6sm2272106ywb.39.2023.08.16.03.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:15:14 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d71c3a32e1aso315388276.3;
        Wed, 16 Aug 2023 03:15:14 -0700 (PDT)
X-Received: by 2002:a5b:e8f:0:b0:d62:b8f5:d745 with SMTP id
 z15-20020a5b0e8f000000b00d62b8f5d745mr1066703ybr.52.1692180913900; Wed, 16
 Aug 2023 03:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220613094924.913340374@linuxfoundation.org> <20220613094928.793712131@linuxfoundation.org>
 <6283c4b1-2513-207d-4ed6-fdabf3f3880e@collabora.com> <CAMuHMdVrWotHv5qTW0j_=uZsmwv7Vrkg-rm-=U=YbffsSfwfCg@mail.gmail.com>
In-Reply-To: <CAMuHMdVrWotHv5qTW0j_=uZsmwv7Vrkg-rm-=U=YbffsSfwfCg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 12:15:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXo-p3H2s+38bJzcg_MqjdBumO_cKkZu+uSeuusw_CBCw@mail.gmail.com>
Message-ID: <CAMuHMdXo-p3H2s+38bJzcg_MqjdBumO_cKkZu+uSeuusw_CBCw@mail.gmail.com>
Subject: Re: [PATCH 5.17 127/298] driver core: Fix wait_for_device_probe() &
 deferred_probe_timeout interaction
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     saravanak@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Stultz <jstultz@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo_Navarro?= 
        <ricardo.canuelo@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        usama.anjum@collabora.com, kernelci@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:10 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Aug 16, 2023 at 11:39 AM Shreeya Patel
> <shreeya.patel@collabora.com> wrote:
> > On 13/06/22 15:40, Greg Kroah-Hartman wrote:
> > > From: Saravana Kannan<saravanak@google.com>
> > >
> > > [ Upstream commit 5ee76c256e928455212ab759c51d198fedbe7523 ]
> > >
> > > Mounting NFS rootfs was timing out when deferred_probe_timeout was
> > > non-zero [1].  This was because ip_auto_config() initcall times out
> > > waiting for the network interfaces to show up when
> > > deferred_probe_timeout was non-zero. While ip_auto_config() calls
> > > wait_for_device_probe() to make sure any currently running deferred
> > > probe work or asynchronous probe finishes, that wasn't sufficient to
> > > account for devices being deferred until deferred_probe_timeout.
> > >
> > > Commit 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits
> > > until the deferred_probe_timeout fires") tried to fix that by making
> > > sure wait_for_device_probe() waits for deferred_probe_timeout to expire
> > > before returning.
> > >
> > > However, if wait_for_device_probe() is called from the kernel_init()
> > > context:
> > >
> > > - Before deferred_probe_initcall() [2], it causes the boot process to
> > >    hang due to a deadlock.
> > >
> > > - After deferred_probe_initcall() [3], it blocks kernel_init() from
> > >    continuing till deferred_probe_timeout expires and beats the point of
> > >    deferred_probe_timeout that's trying to wait for userspace to load
> > >    modules.
> > >
> > > Neither of this is good. So revert the changes to
> > > wait_for_device_probe().
> > >
> > > [1] -https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com/
> > > [2] -https://lore.kernel.org/lkml/YowHNo4sBjr9ijZr@dev-arch.thelio-3990X/
> > > [3] -https://lore.kernel.org/lkml/Yo3WvGnNk3LvLb7R@linutronix.de/
> >
> > Hi Saravana, Greg,
> >
> >
> > KernelCI found this patch causes the baseline.bootrr.deferred-probe-empty test to fail on r8a77960-ulcb,
> > see the following details for more information.
>
> Commit 9be4cbd09da820a2 ("driver core: Set default deferred_probe_timeout
> back to 0.") in v5.19 contains a reference to the same commit as
> mentioned in the Fixes tag.  Does backporting that help?

Anyway, remembering the days (weeks?) spent in investigating
subtle issues with fw_devlinks and deferred probe, collecting all the
fixes for backporting to stable may be a very hard job...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
