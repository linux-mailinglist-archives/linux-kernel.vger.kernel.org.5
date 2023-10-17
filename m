Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78147CCA7F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344066AbjJQSSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjJQSSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:18:38 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7161D9E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:18:36 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a8ada42c2aso7867957b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697566715; x=1698171515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pVHS3JF0WmY4RrG5v1WfMzqjFUkn2A+1ShW83xfles=;
        b=MpRl43/0uCwJZQjST2kaM8pCOpoVQDSCjfxNN/abNR8bom2pMa2IO/Uw96Ll7xpXKs
         1T1kH2QM/P13fYDWRYN7F2sMBAGMaidx0Pv3Bdb42wyhNzt8XGVH5G+yoeJp7m5QVkYf
         xdx3ZVUxaB9ece3EEWk7/nCjawDmlLAl3BPd12PupUW31eF+fwsPIQSlVbQhXTg5h/BN
         zWfoDXid3gVWC+XliDqPfrqUtV9YEXD1d/KzJpBR/lBaTYUCOzct+v4120VPtnfsahg+
         FfbX2QF4aPU+2brvxdaoMTRifurAfif7QqaaVrWgDefXpDVMqZEJftfus/BzzHlrf/6j
         CCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697566715; x=1698171515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pVHS3JF0WmY4RrG5v1WfMzqjFUkn2A+1ShW83xfles=;
        b=mk/NwFc4i6mT0hcYeDnNYSMpGtuEMncIN+6XzTbQoB9IjT6ojcIPT/RAicz+YC12Bs
         3IMkx3lIBgcVCvZcmRdpCL+t/3J/JGxoDAIZ36Dx+6vmk7Y1G9EVBm12T8M0QYkJ1NPW
         pGIESobuoQAFTNIyG0wJpbGgTPFJAB9CYInnWAA8L1NvsIzROQU4qX9ky66F/a887c5p
         wo80APEWzE4UdR9Yzeg9z7j5W9QSkHhDqtNfTcVWKTRLRDBcykF6q67O1IN8Hp5+wbqK
         Rt/G1rS7zGk5Gh1VzNzDgKu5Ryfo2c0D1c1OOd2kFIYLyaKP0Okv2jJaociQRAXPPlNY
         4BTA==
X-Gm-Message-State: AOJu0YyD1L8cpLPCcC9X6bsSan/FTrnh9fd0wlFoge2CVbnABZCrQ9Pn
        vhHADp0BLcqRZOmXsPHG5+Zthn85zilaJtaUVCkMtw==
X-Google-Smtp-Source: AGHT+IHj+cnaEMh8TG1vD7wVxdO8jroB13r0G4NCfvURJbtyucyygE+mIGHOAzo6WrQRop/w8O/VaBiK4DNfZ6+m3Fs=
X-Received: by 2002:a05:690c:1a:b0:59f:72a6:da0e with SMTP id
 bc26-20020a05690c001a00b0059f72a6da0emr3976027ywb.41.1697566715604; Tue, 17
 Oct 2023 11:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Oct 2023 20:18:23 +0200
Message-ID: <CACRpkdbHJHsgJ=3pYveP-x-Vuwwf3ib6TnFOt3UpCrKevf=d1w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Revert "pinctrl: avoid unsafe code pattern in find_pinctrl()"
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 4:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The commit breaks MMC enumeration on the Intel Merrifield
> plaform.

The enumeration works, just that the probe order is different, right?

> Before:
> [   36.439057] mmc0: SDHCI controller on PCI [0000:00:01.0] using ADMA
> [   36.450924] mmc2: SDHCI controller on PCI [0000:00:01.3] using ADMA
> [   36.459355] mmc1: SDHCI controller on PCI [0000:00:01.2] using ADMA
> [   36.706399] mmc0: new DDR MMC card at address 0001
> [   37.058972] mmc2: new ultra high speed DDR50 SDIO card at address 0001
> [   37.278977] mmcblk0: mmc0:0001 H4G1d 3.64 GiB
> [   37.297300]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
>
> After:
> [   36.436704] mmc2: SDHCI controller on PCI [0000:00:01.3] using ADMA
> [   36.436720] mmc1: SDHCI controller on PCI [0000:00:01.0] using ADMA
> [   36.463685] mmc0: SDHCI controller on PCI [0000:00:01.2] using ADMA
> [   36.720627] mmc1: new DDR MMC card at address 0001
> [   37.068181] mmc2: new ultra high speed DDR50 SDIO card at address 0001
> [   37.279998] mmcblk1: mmc1:0001 H4G1d 3.64 GiB
> [   37.302670]  mmcblk1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
>
> This reverts commit c153a4edff6ab01370fcac8e46f9c89cca1060c2.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Relying on this probe order or whatever it is causing one or the other
to be enumerated first seems very fragile, I think this condition can be
caused by other much more random things in the probe path as well,
so it would be great if we could just hammer this down for good, as
it is apparently ABI.

In the past some file system developers have told us (Ulf will know)
that we can't rely on the block device enumeration to identify
devices, and requires that we use things such as sysfs or the
UUID volume label in ext4 to identify storage.

That said, device trees are full of stuff like this:

        aliases {
                serial0 =3D &uart_AO;
                mmc0 =3D &sd_card_slot;
                mmc1 =3D &sdhc;
        };

Notice how this enumeration gets defined by the aliases.

Can you do the same with device properties? (If anyone can
answer that question it's Dmitry!)

Yours,
Linus Walleij
