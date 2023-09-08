Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559457985B2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241995AbjIHKWQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 06:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbjIHKWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:22:16 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B641FD2;
        Fri,  8 Sep 2023 03:21:40 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-592976e5b6dso18624687b3.2;
        Fri, 08 Sep 2023 03:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694168415; x=1694773215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yb3+O+9HoQty/bjuC5BsQ49hiae76RKopBV4SSGNotE=;
        b=Ee4bysLZwv1VlOrZJ1ZEe2RAym5hE/jamayRQACOaDZxh9eZWq84sv9pu9II203jUn
         65EaYYiMy9XasPVAlJKv4PKdum/m/ytNZ7yrKdjQ2nAx+ButXlb0i43HbYIlbBaI+usU
         SPlisFVcwbBqrF/KDmfW8moQOnA+XlkToZoSJfB/3ir6bPJkT/G2VkUVZT7zUuulQqUH
         +gzrRZ1z8pDz7U/klfxah6o5dswNYVEMPBB2hwiU4Yp/q3DJf5w4+xyz9Jb16qq7O/f6
         WcV4l/Kfb1777VL9o4g3vWFYLYSBjWKZ9IopZimL+fxrhUHhbmhER5M1frGH+aTYs3qI
         cN8Q==
X-Gm-Message-State: AOJu0Ywbbs25r9B4t9APH/EL5Lfz+5Bi+GSlvreea5XET0vzacRFPkJ5
        LY37AQDN+u2idgbwJn0Er/JOPICR89hHHrbY
X-Google-Smtp-Source: AGHT+IHYarUqU18MEW4bkrb4z2WoTEZ9r0xfoLaAQ851V7n+9JmTjYaTzi1bQlexOjG1yIvtFZh2sg==
X-Received: by 2002:a81:9195:0:b0:568:8fa1:7a3 with SMTP id i143-20020a819195000000b005688fa107a3mr1872421ywg.5.1694168415225;
        Fri, 08 Sep 2023 03:20:15 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id v72-20020a81484b000000b0059b085c4051sm353204ywa.85.2023.09.08.03.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 03:20:14 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-58fa51a0d97so18597727b3.3;
        Fri, 08 Sep 2023 03:20:14 -0700 (PDT)
X-Received: by 2002:a25:698f:0:b0:d7b:9d44:76dc with SMTP id
 e137-20020a25698f000000b00d7b9d4476dcmr1942085ybc.38.1694168413909; Fri, 08
 Sep 2023 03:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230802184849.1019466-1-arnd@kernel.org> <20230802184849.1019466-4-arnd@kernel.org>
 <d737e5a40f7e2009222d98de7696cc78740869e3.camel@physik.fu-berlin.de>
In-Reply-To: <d737e5a40f7e2009222d98de7696cc78740869e3.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Sep 2023 12:20:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVf6pBn2O61ynkdk9MDj0WiMt-12ffvpzfgL51Kz4_Jfg@mail.gmail.com>
Message-ID: <CAMuHMdVf6pBn2O61ynkdk9MDj0WiMt-12ffvpzfgL51Kz4_Jfg@mail.gmail.com>
Subject: Re: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Fri, Sep 8, 2023 at 12:11 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Wed, 2023-08-02 at 20:48 +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > These functions were only used on the microdev
> > board that is now gone, so remove them to simplify
> > the ioport handling.
> >
> > This could be further simplified to use the generic
> > I/O port accessors now.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> >  void ioport_unmap(void __iomem *addr)
> >  {
> > -     if (sh_mv.mv_ioport_unmap)
> > -             sh_mv.mv_ioport_unmap(addr);
> >  }
> >  EXPORT_SYMBOL(ioport_unmap);
>
> Why aren't you removing the function ioport_unmap(void __iomem *addr) completely
> and just turn it into stub? Is it still referenced somewhere?

Because architectures are supposed to implement it (there is no
__weak default).

An alternative would be to provide a dummy static inline, like
e.g. m68k does:

arch/m68k/include/asm/kmap.h:#define ioport_unmap ioport_unmap
arch/m68k/include/asm/kmap.h:static inline void ioport_unmap(void __iomem *p)
arch/m68k/include/asm/kmap.h-{
arch/m68k/include/asm/kmap.h-}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
