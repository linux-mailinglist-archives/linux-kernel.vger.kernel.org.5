Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD197870DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbjHXNvz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Aug 2023 09:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbjHXNvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:51:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B54EEA8;
        Thu, 24 Aug 2023 06:51:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FA2E1007;
        Thu, 24 Aug 2023 06:52:09 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB0603F762;
        Thu, 24 Aug 2023 06:51:26 -0700 (PDT)
Date:   Thu, 24 Aug 2023 14:50:25 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] arm64: dts: pinephone: Add pstore support for
 PinePhone A64
Message-ID: <20230824144952.5b908649@slackpad.lan>
In-Reply-To: <2235209.iZASKD2KPV@jernej-laptop>
References: <20230821160817.GA2227@bug>
        <20230822092358.309835-1-andrej.skvortzov@gmail.com>
        <2235209.iZASKD2KPV@jernej-laptop>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 21:36:51 +0200
Jernej Škrabec <jernej.skrabec@gmail.com> wrote:


Hi Andrey,

> send new revision as standalone e-mail, not as reply to old discussion.
> 
> Dne torek, 22. avgust 2023 ob 11:23:58 CEST je Andrey Skvortsov napisal(a):
> > This patch reserves some memory in the DTS and sets up a
> > pstore device tree node to enable pstore support.
> > 
> > In general any DRAM address, that isn't overwritten during a boot is
> > suitable for pstore.
> > 
> > Range from 0x40000000 - 0x50000000 is heavily used by u-boot for
> > internal use and to load kernel, fdt, fdto, scripts, pxefile and ramdisk
> > later in the boot process. Ramdisk start address is 0x4FF00000,
> > initramfs for kernel with some hacking features and debug info enabled
> > can take more than 100Mb and final address will be around 0x58000000.
> > Address 0x61000000 will most likely not overlap with that.  
> 
> There are other bootloaders as U-Boot, especially on PinePhone. Are you sure 
> it works there too? What about U-Boot configuration, will those addresses still 
> be used if configuration is changed?

Also going along with what Pavel said (that's it more a policy
decision, not a device property), I feel like this node should be added
by the bootloader then. And indeed U-Boot has support for that already.
From skimming over the code in cmd/pstore.c: if you enable
CONFIG_CMD_PSTORE and set CONFIG_CMD_PSTORE_MEM_ADDR to your chosen
address, then the U-Boot code will insert a reserved memory node on the
fly. Would that solve your problem?

Cheers,
Andre

> Best regards,
> Jernej
> 
> > 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > ---
> > 
> > Changes in v2:
> >  - Update commit description with information about why this base address is
> > used.
> > 
> >  .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi index
> > 87847116ab6d..84f9410b0b70 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > @@ -19,6 +19,22 @@ aliases {
> >  		serial0 = &uart0;
> >  	};
> > 
> > +	reserved-memory {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +
> > +		pstore_mem: ramoops@61000000 {
> > +			compatible = "ramoops";
> > +			reg = <0x61000000 0x100000>;
> > +			record-size = <0x20000>;
> > +			console-size = <0x20000>;
> > +			ftrace-size = <0x20000>;
> > +			pmsg-size = <0x20000>;
> > +			ecc-size = <16>;
> > +		};
> > +	};
> > +
> >  	backlight: backlight {
> >  		compatible = "pwm-backlight";
> >  		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;  
> 
> 
> 
> 
> 

