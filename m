Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB94805B6D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346392AbjLEPwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346320AbjLEPwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:52:06 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DE4C3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:52:10 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-33348e711e0so1955592f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 07:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1701791529; x=1702396329; darn=vger.kernel.org;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVTdq6t/OSB6FE4R91UbvG7HbrsvSrimG/gzvVG23BM=;
        b=d7LYvaVyAKeJ5LgT3KPvovxqsmkBOCySMB/kGudYfq9WQLBreCixXL/CwXNeeOPT+S
         sx9Suz7uR5lMBJyO5CKXBGzZZ3y5KWv0RmIy3tfPO8v0G6DbbHBN1YAKzcD2vdTqWfXd
         rTsVHguH/GFQWshhCSIv5cLvXBfjJBSp3wbPDBc7sKj/MCgAO9ytEcu1lBteCU08hlFY
         Nay6iFi/jbw/gudz9qI++2RPLsBUZ0k/cbiaYtH9YtMRcztkXWgHQZWvZ6Cr1dJoPady
         ax72eu0ugB2jZXi5tzyGd42CHNGVqloOlyBFop/gTwOLONPhDjUqd9bHo/5yc/zTEHnM
         gUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791529; x=1702396329;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVTdq6t/OSB6FE4R91UbvG7HbrsvSrimG/gzvVG23BM=;
        b=oz8nEd+3SA9MEc1mLuhoj0ZFqI0a1vrg5YKhcGd9KfNul9orS/pTrJoGzvYlMkuCoc
         faC88Ow4t3c0CxpqyKi4wga9To/4xz28eMP7wWciaWlylO+f9KbIci+ZJsBWEqhTEQLN
         vc54sCaLfjI4IXEAl+Pf5qZxVVUcddy59IlaOKO8WKbo2mx1MQYqDDtpMFUkw0su2sJn
         x0Z2ClZ1oX7jZvEBEPzJhCJGNmMDkJJdff4WRV/ZlU8PHsuzEUGSdtAmkfDJ51Jyue4f
         CLCee1eJ/AbJUQMinCaeUlAZpkD3auBBbL2hjtWhlm7zXz2EeU10eqMFKAmbskzhdeQh
         LJgg==
X-Gm-Message-State: AOJu0YzhzR3fY9aTiENmhx73kidkCToCQlaXDRVnNUjLOxZrC9Lez3F7
        cujtPEG7t0scyy83x+3NsdnUBA==
X-Google-Smtp-Source: AGHT+IElMdXrz89RurD2RJoKi2kjRNtKZuLwgqSlkGPsYKj4csSCF4Fnczw3b5nc0Y11T0hPeWp81Q==
X-Received: by 2002:adf:f74c:0:b0:333:2fd2:51fc with SMTP id z12-20020adff74c000000b003332fd251fcmr4361255wrp.117.1701791528135;
        Tue, 05 Dec 2023 07:52:08 -0800 (PST)
Received: from fedora (p549451d5.dip0.t-ipconnect.de. [84.148.81.213])
        by smtp.gmail.com with ESMTPSA id f20-20020a1709067f9400b009fd7bcd9054sm6963138ejr.147.2023.12.05.07.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:52:07 -0800 (PST)
Date:   Tue, 5 Dec 2023 16:52:05 +0100
From:   Damian Tometzki <damian@riscv-rocks.de>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/4] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
Message-ID: <ZW9HJdIk-8r918Ma@fedora>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231129-th1520_mmc_dts-v7-0-c77fc19caa6f@baylibre.com>
 <20231129-th1520_mmc_dts-v7-2-c77fc19caa6f@baylibre.com>
 <CAJM55Z-qc7gc0fO-K8byqvpOBjDxFD4dP57mFHuijvpOzBWObQ@mail.gmail.com>
 <ZW8zHoVWf94FDTx7@xhacker>
 <CAJM55Z9tPTu4N4UVCBs1AJYWrWxMUDL+8FpVZtGx4yQgKenWSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z9tPTu4N4UVCBs1AJYWrWxMUDL+8FpVZtGx4yQgKenWSQ@mail.gmail.com>
User-Agent: Mutt
X-Operating-System: Linux Fedora release 39 (Thirty Nine) (Kernel 6.7.0-rc4)
Organization: Linux hacker
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05. Dec 06:48, Emil Renner Berthing wrote:
> Jisheng Zhang wrote:
> > On Mon, Dec 04, 2023 at 01:47:45AM -0800, Emil Renner Berthing wrote:
> > > Drew Fustini wrote:
> > > > Add node for the SDHCI fixed clock. Add mmc0 node for the first mmc
> > > > controller instance which is typically connected to the eMMC device.
> > > > Add mmc1 node for the second mmc controller instance which is typically
> > > > connected to microSD slot.
> > > >
> > > > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > > > ---
> > > >  arch/riscv/boot/dts/thead/th1520.dtsi | 25 +++++++++++++++++++++++++
> > > >  1 file changed, 25 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > > index ba4d2c673ac8..af4fdcd82e0b 100644
> > > > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > > > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > > @@ -146,6 +146,13 @@ uart_sclk: uart-sclk-clock {
> > > >  		#clock-cells = <0>;
> > > >  	};
> > > >
> > > > +	sdhci_clk: sdhci-clock {
> > > > +		compatible = "fixed-clock";
> > > > +		clock-frequency = <198000000>;
> > > > +		clock-output-names = "sdhci_clk";
> > > > +		#clock-cells = <0>;
> > > > +	};
> > > > +
> > > >  	soc {
> > > >  		compatible = "simple-bus";
> > > >  		interrupt-parent = <&plic>;
> > > > @@ -304,6 +311,24 @@ dmac0: dma-controller@ffefc00000 {
> > > >  			status = "disabled";
> > > >  		};
> > > >
> > > > +		mmc0: mmc@ffe7080000 {
> > > > +			compatible = "thead,th1520-dwcmshc";
> > > > +			reg = <0xff 0xe7080000 0x0 0x10000>;
> > > > +			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
> > > > +			clocks = <&sdhci_clk>;
> > > > +			clock-names = "core";
> > > > +			status = "disabled";
> > > > +		};
> > > > +
> > > > +		mmc1: mmc@ffe7090000 {
> > > > +			compatible = "thead,th1520-dwcmshc";
> > > > +			reg = <0xff 0xe7090000 0x0 0x10000>;
> > > > +			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
> > > > +			clocks = <&sdhci_clk>;
> > > > +			clock-names = "core";
> > > > +			status = "disabled";
> > > > +		};
> > > > +
> > >
> > > Hi Drew,
> > >
> > > This doesn't seem to match the documentation shared here:
> > > https://lore.kernel.org/linux-riscv/5f437109d2be2b8843f549a661054a2e3ec0d66e.camel@xry111.site/
> > > From the TH1520 System User Manual.pdf in there, I'd expect something like
> >
> > >
> > > 	emmc: mmc@ffe7080000 {
> > > 		compatible = "thead,th1520-dwcmshc";
> > > 		reg = <0xff 0xe7080000 0x0 0x10000>;
> > > 		...
> > > 	};
> >
> > Hi Emil,
> >
> > I think this isn't necessary. From other soc dts files, I see such
> > naming, but lots socs just use mmc0, mmc1, and so on.
> 
> No it certainly isn't necessary. Those labels are purely for us humans to read
> and are not present in the dtb. But that's exactly why I think it'd be a good
> idea match the labels with the documentation, so it will easier for us humans
> to match up the device tree source to documentation.
Hello together,

yes i agree to this too. It is easier for troubleshooting etc. 

Damian

> 
> > And IIRC, the host for sd and sdio can support both, IOW, below
> > sdio0/sdio1 may be used for sdcard.
> 
> Yes, all of the EMMC, SDIO0 and SDIO1 seem to be instances of the same IP.
> 
> /Emil
