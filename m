Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF257F0E19
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjKTIsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjKTIs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:48:26 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C12A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:47:57 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id CCF61207B8;
        Mon, 20 Nov 2023 09:47:52 +0100 (CET)
Date:   Mon, 20 Nov 2023 09:47:48 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux@bigler.io
Cc:     Stefan Moring <stefan.moring@technolution.nl>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
Message-ID: <ZVsdNGyVrTJ/Kv3n@francesco-nb.int.toradex.com>
References: <8a415902c751cdbb4b20ce76569216ed@mail.infomaniak.com>
 <e4f12422-1c47-4877-88b3-dfa9917331a2@leemhuis.info>
 <f4439fd1-7c2d-4a96-9116-1dbe04fceac0@leemhuis.info>
 <CAB3BuKA+qOY+UhWR-9Ov3qsz3wQr8q8n38MrEMf3FMCthr04yA@mail.gmail.com>
 <2fcdd99eee9ee4f5d34fa1abab2f51bb@mail.infomaniak.com>
 <CAB3BuKARgJhaVNFsP1FQ+2yLe18QU9H17fHKjc-Sf3izE+MZ1Q@mail.gmail.com>
 <86566391db9c5044f1a082bc8ec697a2@mail.infomaniak.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86566391db9c5044f1a082bc8ec697a2@mail.infomaniak.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 09:27:10AM +0100, linux@bigler.io wrote:
> Load the spi-dma (imx-sdma 302c0000.dma-controller: loaded firmware
> 4.5), run the spi_imx and the spidev as kenelmodule.
> 
> I run the code on a Toradex Verdin Development Board and use the
> imx8mm-verdin-nonwifi-dev.dts
> 
> To add the spidev I patched imx8mm-verdin.dtsi
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> index 6f0811587142..262500940adc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> @@ -209,6 +209,15 @@ &ecspi2 {
>         cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_ecspi2>;
> +
> +       spidev@0{
> +               compatible = "micron,spi-authenta";
> +               reg = <0>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               spi-max-frequency = <20000000>;
> +               status = "okay";
> +       };
>  };
> 
> as a spidev test program I used 
> https://raw.githubusercontent.com/raspberrypi/linux/rpi-3.10.y/Documentation/spi/spidev_test.c

Would you mind doing the following tests looping the SPI interface MISO/MOSI?

```
cd /tmp

dd if=/dev/urandom of=4k-spi-test-data.bin bs=1 count=4k
spidev_test -D "$device" -s 4000000 -i 4k-spi-test-data.bin -o 4k-spi-test-result.bin

dd if=/dev/urandom of=16bytes-spi-test-data.bin bs=1 count=16
spidev_test -D "$device" -s 16000 -i 16bytes-spi-test-data.bin -o 16bytes-spi-test-result.bin
```

with "$device" being your actual spidev device?

Those tests are passing on 6.7.0-rc2 for me.

Francesco



