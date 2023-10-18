Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992587CE5C0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344865AbjJRSAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344726AbjJRSAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:00:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07F098
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:59:47 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9b70b9656so45957795ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697651987; x=1698256787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KIX8roHs6Y2xfB0yyrc9fz1uKsUCw1ugcleeV2Jgmg8=;
        b=IVi8JOrRGInH9OWBomhXtdus3PvgOWYQZG9XrtiREWZ+AsTsBl0ZFFeK4dtI33x31s
         TPKTPi8OFCH7pOlVs+y0yjGxf7rDb6NQrqY5lnrSZXXLc+f4mb7LYT8rz5bHliVwcgXk
         TFAQZ/DMvyqpgj8oTx/wDe9fteQvWEBoHoG3oZMUf1EtnnegfZht2URaHDW4D4HgEboE
         UAiUV+55vMim6OGef1x/lK1JGam0eCoxnSjZw7r4hm0QTbYnGsIcSQg7zEqW5foF930C
         sf9Yb8Rkr1P+/NALj7XrZnkdRZv0V+kD5NzW6IAMlYed0tA1x4fNVIj/fCNfcIXm3sRw
         +HVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697651987; x=1698256787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIX8roHs6Y2xfB0yyrc9fz1uKsUCw1ugcleeV2Jgmg8=;
        b=CSB0XkF8AlsdphJ3YAQ0UeARjvD0v8Y/o/jKEJS/pFb+jgJEGTtin2L8sB8VUl6uq5
         wshAiz8zaLJvzDfDqAjWuBz3FWWjly/8CWDMQBci2Wo9+rf0YDuPv43FMLBy01pvracr
         cuYEBM5Og0FuZTSGwJM2mx33keuYZiVKirb2c7rTr8EkkhPVqQMg+aGv3lzQe7/rW42n
         b9g66ntfxD5Ted3syuKLKYW850uBTDBQZNyE6W82k7GKGXOgIjl0rB5mW1yEGRuiGRqw
         0YH6eBtR9+Qzg/Mubk9Kt2pCsXAxEHXMnBGSUgn1QPBIBv+R/aMZLGg5617B7/DuasYF
         1h4g==
X-Gm-Message-State: AOJu0YzOXFjYHT3J/83uHk3ZKrR1QAmPfGsS/vxpo+9DRniyp0jJC5F5
        B8BfXw+qszF60NQbR4Llxj5oLg==
X-Google-Smtp-Source: AGHT+IFuRZYdlOYu8jcYT7a+dm4yo2n/AMX0UeXuajz4t3w2UbaA9ylak4iJyUvNX3BWgaHQgHTx6Q==
X-Received: by 2002:a17:903:1110:b0:1c8:9832:827f with SMTP id n16-20020a170903111000b001c89832827fmr102594plh.20.1697651986953;
        Wed, 18 Oct 2023 10:59:46 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:3b92:d9c:239b:cd56])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b001c5f7e06256sm214183plg.152.2023.10.18.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:59:46 -0700 (PDT)
Date:   Wed, 18 Oct 2023 10:59:43 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 6/7] riscv: dts: thead: Enable BeagleV Ahead eMMC
 controller
Message-ID: <ZTAdD/28PTNCWvWp@x1>
References: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com>
 <20231017-th1520-mmc-v2-6-4678c8cc4048@baylibre.com>
 <20231018-dating-yogurt-d7f3a65a873e@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-dating-yogurt-d7f3a65a873e@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 02:57:50PM +0100, Conor Dooley wrote:
> On Tue, Oct 17, 2023 at 01:43:52PM -0700, Drew Fustini wrote:
> > Add properties to the emmc node and enable it and set the frequency for
> > the sdhci clock.
> > 
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> >  arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > index 70e8042c8304..bf55319ba950 100644
> > --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > @@ -52,6 +52,10 @@ &uart_sclk {
> >  	clock-frequency = <100000000>;
> >  };
> >  
> > +&sdhci_clk {
> > +	clock-frequency = <198000000>;
> > +};
> > +
> >  &dmac0 {
> >  	status = "okay";
> >  };
> > @@ -59,3 +63,13 @@ &dmac0 {
> >  &uart0 {
> >  	status = "okay";
> >  };
> > +
> > +&mmc0 {
> > +	bus-width = <8>;
> > +	max-frequency = <198000000>;
> > +	mmc-hs400-1_8v;
> > +	non-removable;
> > +	no-sdio;
> > +	no-sd;
> > +	status = "okay";
> > +};
> 
> Is this file meant to be in alphanumerical order?
> 

Good point, I should add the new nodes in alphabetical order.

Thanks,
Drew
