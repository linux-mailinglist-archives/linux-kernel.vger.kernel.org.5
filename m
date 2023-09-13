Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C50C79E819
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbjIMMc5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 08:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbjIMMcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:32:55 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2D119B4;
        Wed, 13 Sep 2023 05:32:51 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-58d9ba95c78so68170267b3.1;
        Wed, 13 Sep 2023 05:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694608370; x=1695213170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niAJ2PizX/sYOBYMEFf6M6THGMgT7grLXGG+lDou3LM=;
        b=tEE1/+SQ2YlF2rTLACLoTdeeCC947cXHxwP5s93NirDl1u+LzYnL3tuKv3p008E/tg
         LqbrV35gokGmO/N70aTMl/qUgoKvQB0bBZGw9NrNhITjYLHFH2Rz/3zX4NIo5X5EWObq
         Uayn6hSoUUOueQuOTMWaHC8Ro+gabe70jFRcjZPfjQBi88y7kmbUhN0opz1Ubdh6qtWM
         Zgpp3xn+nSDXUMWesS5FyT7449qSRt/4YmMpug3+CRhtMlHgXrRVMPoS6KjI+sTXeaSq
         ZJiepxrs6RgLD8W94in9FTsdhFUGO77joAKfXB8xGVUSJYbEMvjCOSwR43qr6rjYOAhI
         k9Qg==
X-Gm-Message-State: AOJu0Yx3/uV92a8aV8Bj5/yP9ivX+KAJljDFeaPJZBFOs7xuuZfyWuoY
        YyI9aX08VvHYZGDRcvR7NNQ0icX+05FwjQ==
X-Google-Smtp-Source: AGHT+IGrYZdSamip9uH0Ycvkzd6C98XJyNHlPK/YZl5vraY8oNgYtbkXYNExsGr9bseCTKzop0aaNw==
X-Received: by 2002:a81:5e54:0:b0:570:63d3:9685 with SMTP id s81-20020a815e54000000b0057063d39685mr2460721ywb.25.1694608370624;
        Wed, 13 Sep 2023 05:32:50 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id p63-20020a815b42000000b005837633d9cbsm3077942ywb.64.2023.09.13.05.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 05:32:50 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-579de633419so68063517b3.3;
        Wed, 13 Sep 2023 05:32:49 -0700 (PDT)
X-Received: by 2002:a25:d303:0:b0:d7a:def7:b96a with SMTP id
 e3-20020a25d303000000b00d7adef7b96amr2179608ybf.53.1694608369635; Wed, 13 Sep
 2023 05:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230802184849.1019466-1-arnd@kernel.org> <20230802184849.1019466-4-arnd@kernel.org>
In-Reply-To: <20230802184849.1019466-4-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Sep 2023 14:32:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVjmD357K-yxxW-jn-6vKsXTg+u1Psw9DftyxH=dQoMEg@mail.gmail.com>
Message-ID: <CAMuHMdVjmD357K-yxxW-jn-6vKsXTg+u1Psw9DftyxH=dQoMEg@mail.gmail.com>
Subject: Re: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Aug 2, 2023 at 8:49 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> These functions were only used on the microdev
> board that is now gone, so remove them to simplify
> the ioport handling.
>
> This could be further simplified to use the generic
> I/O port accessors now.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -181,7 +181,7 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)  \
>  {                                                                      \
>         volatile type *__addr;                                          \
>                                                                         \
> -       __addr = __ioport_map(port, sizeof(type));                      \
> +       __addr = (void __iomem *)sh_io_port_base + port;                \

Note that this adds unconditional users of sh_io_port_base, while
sh_io_port_base is provided by arch/sh/kernel/ioport.c, which is
currently only built if CONFIG_GENERIC_IOMAP=n.

This is not a problem yet, as the final part to enable GENERIC_IOMAP
on SH never made it upstream.  However, Sato-san's series enables
GENERIC_IOMAP for SH_DEVICE_TREE=y builds, leading to a link failure.

A quick fix would be to always build the relevant parts:

--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -23,8 +23,8 @@ obj-y := head_32.o debugtraps.o dumpstack.o
                 \

 ifndef CONFIG_GENERIC_IOMAP
 obj-y                          += iomap.o
-obj-$(CONFIG_HAS_IOPORT_MAP)   += ioport.o
 endif
+obj-$(CONFIG_HAS_IOPORT_MAP)   += ioport.o

 obj-y                          += sys_sh32.o
 obj-y                          += cpu/
--- a/arch/sh/kernel/ioport.c
+++ b/arch/sh/kernel/ioport.c
@@ -12,6 +12,7 @@
 unsigned long sh_io_port_base __read_mostly = -1;
 EXPORT_SYMBOL(sh_io_port_base);

+#ifndef CONFIG_GENERIC_IOMAP
 void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
        void __iomem *ret;
@@ -28,3 +29,4 @@ void ioport_unmap(void __iomem *addr)
 {
 }
 EXPORT_SYMBOL(ioport_unmap);
+#endif /* !CONFIG_GENERIC_IOMAP */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
