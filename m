Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1C277DE39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243744AbjHPKLi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Aug 2023 06:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243739AbjHPKLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:11:09 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D467E3;
        Wed, 16 Aug 2023 03:11:08 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6bca857accbso5362767a34.0;
        Wed, 16 Aug 2023 03:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692180667; x=1692785467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m88hfTY7ZX8PorgbUqZ8SmbWM9cMFxThUekcSoFTGW0=;
        b=Z0AKTUeadTiLMdP4xE7n2o9PV2UZXQ/FEHmPtJQYiI1x+BcXnMzh1o5turSgoU4FhT
         qZHD6a0n8pD1nxCEjytki0sgmbAvKznzpCOK+TFKs4PdU/zzd+bJ/41KhERYYijYgnkY
         Rezckz8cy1Olun9StcetOFJ58ckBtYP+wWoBBY6b64X3OI8JO84TBF6HT4x5Ymdnb8yT
         EMzvFXsTLTXdMhi1qkNzmyBuF4xKZNCKn6CpdVRhXE8XvP/uQBVLjHSbV5sgebghgaJ0
         gNzW7qlK4nPyspRhB11yk+zBLVKynchPH3OjMmJ8n+bEdXpawG6gGIkl5udzwa6oVzGo
         sK1g==
X-Gm-Message-State: AOJu0Yyws1+yxak/5ZFc3mb1dDkpQwXZiIFUVN8cWZKgxwp8cNozR9B3
        961qlmbQoYsjGc08piYwRAErLFth07mqcg==
X-Google-Smtp-Source: AGHT+IEehkDVEM81j25sOtHdILdm81/b7OBcd0Ee+51SLbPm1fC9bC9TUmyPkGuXp7tVZ7jPnaJd1w==
X-Received: by 2002:a9d:73d7:0:b0:6b9:e412:b02b with SMTP id m23-20020a9d73d7000000b006b9e412b02bmr1257255otk.2.1692180667332;
        Wed, 16 Aug 2023 03:11:07 -0700 (PDT)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id e16-20020a0568301e5000b006ba864f5b37sm5966617otj.12.2023.08.16.03.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:11:05 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-56dd69cbb18so4380430eaf.2;
        Wed, 16 Aug 2023 03:11:05 -0700 (PDT)
X-Received: by 2002:a05:6358:280b:b0:133:7c4:e752 with SMTP id
 k11-20020a056358280b00b0013307c4e752mr1517746rwb.26.1692180665426; Wed, 16
 Aug 2023 03:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220613094924.913340374@linuxfoundation.org> <20220613094928.793712131@linuxfoundation.org>
 <6283c4b1-2513-207d-4ed6-fdabf3f3880e@collabora.com>
In-Reply-To: <6283c4b1-2513-207d-4ed6-fdabf3f3880e@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 12:10:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrWotHv5qTW0j_=uZsmwv7Vrkg-rm-=U=YbffsSfwfCg@mail.gmail.com>
Message-ID: <CAMuHMdVrWotHv5qTW0j_=uZsmwv7Vrkg-rm-=U=YbffsSfwfCg@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shreeya,

On Wed, Aug 16, 2023 at 11:39 AM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
> On 13/06/22 15:40, Greg Kroah-Hartman wrote:
> > From: Saravana Kannan<saravanak@google.com>
> >
> > [ Upstream commit 5ee76c256e928455212ab759c51d198fedbe7523 ]
> >
> > Mounting NFS rootfs was timing out when deferred_probe_timeout was
> > non-zero [1].  This was because ip_auto_config() initcall times out
> > waiting for the network interfaces to show up when
> > deferred_probe_timeout was non-zero. While ip_auto_config() calls
> > wait_for_device_probe() to make sure any currently running deferred
> > probe work or asynchronous probe finishes, that wasn't sufficient to
> > account for devices being deferred until deferred_probe_timeout.
> >
> > Commit 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits
> > until the deferred_probe_timeout fires") tried to fix that by making
> > sure wait_for_device_probe() waits for deferred_probe_timeout to expire
> > before returning.
> >
> > However, if wait_for_device_probe() is called from the kernel_init()
> > context:
> >
> > - Before deferred_probe_initcall() [2], it causes the boot process to
> >    hang due to a deadlock.
> >
> > - After deferred_probe_initcall() [3], it blocks kernel_init() from
> >    continuing till deferred_probe_timeout expires and beats the point of
> >    deferred_probe_timeout that's trying to wait for userspace to load
> >    modules.
> >
> > Neither of this is good. So revert the changes to
> > wait_for_device_probe().
> >
> > [1] -https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com/
> > [2] -https://lore.kernel.org/lkml/YowHNo4sBjr9ijZr@dev-arch.thelio-3990X/
> > [3] -https://lore.kernel.org/lkml/Yo3WvGnNk3LvLb7R@linutronix.de/
>
> Hi Saravana, Greg,
>
>
> KernelCI found this patch causes the baseline.bootrr.deferred-probe-empty test to fail on r8a77960-ulcb,
> see the following details for more information.

Commit 9be4cbd09da820a2 ("driver core: Set default deferred_probe_timeout
back to 0.") in v5.19 contains a reference to the same commit as
mentioned in the Fixes tag.  Does backporting that help?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
