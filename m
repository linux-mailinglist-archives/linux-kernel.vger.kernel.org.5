Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F90577E083
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244664AbjHPLf3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Aug 2023 07:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244752AbjHPLfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:35:18 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBF3E4F;
        Wed, 16 Aug 2023 04:35:17 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-58c531d9a4aso28842507b3.1;
        Wed, 16 Aug 2023 04:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692185716; x=1692790516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1TXDu+zgSSUXElwM6x2NcHaHgdAL86FtyCcicPVe4Q=;
        b=lzTjlypOmFXLMXEscFZXXogCeG51hXTIm0AZBdauKZepA9KtPlViE7vNtaxQWgYybw
         RGPPnTDiH0+TmMuAswZqfd7qnqu2+onGHoiIjaUb0znP1dfqPMworRpApY+qHRWYaFwm
         3xuDhyEP84lLK7Tiyvek1AeZXow4UjjNnLVB+jDopLbXC3xPwx2KkMGA8xDmrQYhjU2a
         avvLwm0MugDs7NyW/UZFs613zYc0JSKYkB46SYl/YFQgSn4gTtj9YgZjh3YjnKVr8eYC
         dUuwI6NnUv91z/1gN1clenJwUVSSWnjPNp0rWPdC27GILI/Kk80jZ9Xiumxan1Ec7wK7
         JMSA==
X-Gm-Message-State: AOJu0YyTMwLIjxtVxkv2uFyt1z3BYo/WZ+jc9TumieP6GLjppQT6hM/s
        WUS+CEsUJnbto/E15Na+VB6rHuH+oJZD7g==
X-Google-Smtp-Source: AGHT+IEEKufUe6FSX3gzXlv59hZUNSLSGSjZMZEXxXh45dPUhVvw7LEuYGQENejn/K81FbT7UgsAOA==
X-Received: by 2002:a0d:e84b:0:b0:58c:4dcf:78b6 with SMTP id r72-20020a0de84b000000b0058c4dcf78b6mr1900748ywe.21.1692185715370;
        Wed, 16 Aug 2023 04:35:15 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id y8-20020a0dd608000000b00589e84acafasm329281ywd.48.2023.08.16.04.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 04:35:14 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d678b44d1f3so6582805276.0;
        Wed, 16 Aug 2023 04:35:14 -0700 (PDT)
X-Received: by 2002:a25:abc7:0:b0:d71:99da:49b6 with SMTP id
 v65-20020a25abc7000000b00d7199da49b6mr1971998ybi.29.1692185714245; Wed, 16
 Aug 2023 04:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230801105932.3738430-1-arnd@kernel.org> <202308100045.WeVD1ttk-lkp@intel.com>
 <106a93ae-90f1-45fb-ae0a-034eb2d6faea@app.fastmail.com>
In-Reply-To: <106a93ae-90f1-45fb-ae0a-034eb2d6faea@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 13:35:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWAO=-Qc71YWF2UFBVhbp55Fog-iUAuENNtiEP4xqx5ig@mail.gmail.com>
Message-ID: <CAMuHMdWAO=-Qc71YWF2UFBVhbp55Fog-iUAuENNtiEP4xqx5ig@mail.gmail.com>
Subject: Re: [PATCH] rtc: stm32: remove incorrect #ifdef check
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        oe-kbuild-all@lists.linux.dev,
        Alessandro Zummo <a.zummo@towertech.it>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Amelie DELAUNAY <amelie.delaunay@foss.st.com>,
        Christophe Guibout <christophe.guibout@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Arnd,

On Wed, Aug 9, 2023 at 8:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Aug 9, 2023, at 18:36, kernel test robot wrote:
> > If you fix the issue in a separate patch/commit (i.e. not just a new
> > version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes:
> > https://lore.kernel.org/oe-kbuild-all/202308100045.WeVD1ttk-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >>> drivers/rtc/rtc-stm32.c:903:12: warning: 'stm32_rtc_resume' defined but not used [-Wunused-function]
> >      903 | static int stm32_rtc_resume(struct device *dev)
> >          |            ^~~~~~~~~~~~~~~~
> >>> drivers/rtc/rtc-stm32.c:893:12: warning: 'stm32_rtc_suspend' defined but not used [-Wunused-function]
> >      893 | static int stm32_rtc_suspend(struct device *dev)
> >          |            ^~~~~~~~~~~~~~~~~
>
> This is the warning you get if my patch is applied but the
> fb9a7e5360dc8 ("rtc: stm32: change PM callbacks to "_noirq()"")
> commit is not. If that patch is applied, mine is needed to address
> the other warning.

Although both are now in linux-next, kisskb reported for m68k/allmodconfig:

    drivers/rtc/rtc-stm32.c:904:12: error: ‘stm32_rtc_resume’ defined
but not used [-Werror=unused-function]
      904 | static int stm32_rtc_resume(struct device *dev)
          |            ^~~~~~~~~~~~~~~~
    drivers/rtc/rtc-stm32.c:894:12: error: ‘stm32_rtc_suspend’ defined
but not used [-Werror=unused-function]
      894 | static int stm32_rtc_suspend(struct device *dev)
          |            ^~~~~~~~~~~~~~~~~

Seems like you missed that the driver uses the old
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() instead of the new
NOIRQ_SYSTEM_SLEEP_PM_OPS().

Patch sent.
https://lore.kernel.org/r/20230816113326.1468435-1-geert@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
