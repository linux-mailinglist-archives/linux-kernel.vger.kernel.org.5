Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C02B791E05
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjIDUAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjIDUAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:00:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229141730
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:59:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c337aeefbdso10230365ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1693857544; x=1694462344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fek8HxM1sqQEDL9Khn6Uyo9b2PBeQlrpLwpl5iq+Vg=;
        b=Vk8l9Us9ky0ArP1AFS5OWqdO0A0riqFwDZUiKb//fiKC7ToguCpO40wwgtHORDE48N
         NgoKlEOYrdC443QORyNvIRykbmQWJyl9l7OPUyLumirP0w1KgRdYdZfqusc7M212PXDd
         9EEmjeUCm+jR1454JMFt5lonfbKC0KM1RXtfS7+e++WeDzTne0/4eyzp/tuGFAjX0Vw5
         ps12OFAimlr0dxmTIKZkZQM2l6/vubomrg5Rrj79NR90ICGkmLEmS1v4j4bVMv5vSSxz
         zb611G2tpYy3Z9kyrrPwGLTrsEd5ayY0i+qrVMPuSf2QQ79MZfNuii/qxB6E/djLoiLZ
         1xCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693857544; x=1694462344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fek8HxM1sqQEDL9Khn6Uyo9b2PBeQlrpLwpl5iq+Vg=;
        b=fpT7Dvr9i8PpEj+yqads8aTv22Hi6uWwOl4PjRC7cU18arSarrq+XzCA/1pd+yWVw9
         WnbuQtPzFAA3kGbB+GPOH8yk7xhjTcXmlSoka8p87bMoTTXL23b8rv0WxSZglWRjcQhH
         BAclcBFOxX4Ex5QZoKr6SnZweaOWBH9TkffLAUJVR2KZV1jKbjws8xIElEfdFrGyrHbk
         1Ib47YP+76/4ce0aAxk93zTEQnH1GezeLjhbEMgEIN1CyB2rGQoQ+PmgJofI87BbylGb
         9e8ORn7j09xKfvG/VE2oFerldtY2Yj08Lo+zowTfdVVYF/byO2GyEi0pcSwHxxmCEkrU
         lVzA==
X-Gm-Message-State: AOJu0YzjhBmWpfOjG1wPUKItWoFFmmeH1RXgiXmHYBOVGJBYrm0t3TcW
        y7d8f4JmAU+WYuJCo9NyfENxSA==
X-Google-Smtp-Source: AGHT+IHPTpkZX6Wn7xLRr3ok2P/SuL60WGAoFAY1m9/iCjATnd2NwJiFdX9tASOBk2VR8QWrXxQ6pg==
X-Received: by 2002:a17:902:d504:b0:1c0:ec66:f2b5 with SMTP id b4-20020a170902d50400b001c0ec66f2b5mr13820261plg.57.1693857544593;
        Mon, 04 Sep 2023 12:59:04 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:5de2:2323:20de:e26d])
        by smtp.gmail.com with ESMTPSA id d1-20020a170903230100b001b9dab0397bsm7896702plh.29.2023.09.04.12.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 12:59:04 -0700 (PDT)
Date:   Mon, 4 Sep 2023 12:59:02 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 1/2] riscv: errata: fix T-Head dcache.cva encoding
Message-ID: <ZPY3BpYMzs6FbrNS@x1>
References: <20230827090813.1353-1-jszhang@kernel.org>
 <20230827090813.1353-2-jszhang@kernel.org>
 <ZPYzXeYGyGCxJUuK@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPYzXeYGyGCxJUuK@x1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 12:43:25PM -0700, Drew Fustini wrote:
> On Sun, Aug 27, 2023 at 05:08:12PM +0800, Jisheng Zhang wrote:
> > From: Icenowy Zheng <uwu@icenowy.me>
> > 
> > The dcache.cva encoding shown in the comments are wrong, it's for
> > dcache.cval1 (which is restricted to L1) instead.
> > 
> > Fix this in the comment and in the hardcoded instruction.
> > 
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > Tested-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/errata_list.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> > index fb1a810f3d8c..feab334dd832 100644
> > --- a/arch/riscv/include/asm/errata_list.h
> > +++ b/arch/riscv/include/asm/errata_list.h
> > @@ -100,7 +100,7 @@ asm volatile(ALTERNATIVE(						\
> >   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> >   *   0000001    01001      rs1       000      00000  0001011
> >   * dcache.cva rs1 (clean, virtual address)
> > - *   0000001    00100      rs1       000      00000  0001011
> > + *   0000001    00101      rs1       000      00000  0001011
> >   *
> >   * dcache.cipa rs1 (clean then invalidate, physical address)
> >   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> > @@ -113,7 +113,7 @@ asm volatile(ALTERNATIVE(						\
> >   *   0000000    11001     00000      000      00000  0001011
> >   */
> >  #define THEAD_inval_A0	".long 0x0265000b"
> > -#define THEAD_clean_A0	".long 0x0245000b"
> > +#define THEAD_clean_A0	".long 0x0255000b"
> >  #define THEAD_flush_A0	".long 0x0275000b"
> >  #define THEAD_SYNC_S	".long 0x0190000b"
> >  
> > -- 
> > 2.40.1
> > 
> 
> Tested-by: Drew Fustini <dfustini@baylibre.com>
> 
> I applied this on top of the emmc series [1] and the dma-noncoherent dts
> patch [2]. SDMA is now working with this patch applied. Before this
> patch, the filesystems on the emmc were corrupted after mounting. It
> makes sense that problem is solved by the correct cache clean
> instruction being used.

Even better, ADMA is now working in sdhci-of-dwcmshc too.

I'll respin my eMMC series.

Thanks,
Drew
