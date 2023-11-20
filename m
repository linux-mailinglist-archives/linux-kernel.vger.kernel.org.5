Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419397F0F24
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjKTJdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKTJdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:33:45 -0500
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1868A7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:33:40 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SYj4M0kwtzMq5wV;
        Mon, 20 Nov 2023 09:33:39 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SYj4L2f9jzMpnxv;
        Mon, 20 Nov 2023 10:33:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.io;
        s=20200409; t=1700472819;
        bh=anqWQNS0I72M2owQefb7VXUDy0DSr6CStGbfRFslnqE=;
        h=Date:Subject:From:Reply-To:To:Cc:References:In-Reply-To:From;
        b=x1DDRYbqVMTjxKUpVzo+weILZPXiHwYTqw8U0gBq55EV5oQT9XmKgOgAzSf8cfreo
         LY+eiAdRA6OB+v6fkqR/3O8WC2LRlirrimXzmmAaCU40cktwv0XmDxRreKfIhVygF1
         P3d5m7/FS0FHFRTFiQec48yHIF874rRT/f4FuJ00=
Message-ID: <6322fd4c1967a518310140c35ab34f65@mail.infomaniak.com>
Date:   Mon, 20 Nov 2023 10:33:38 +0100
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
From:   linux@bigler.io
Reply-To: linux@bigler.io
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Stefan Moring <stefan.moring@technolution.nl>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6IloxTld3ZTFSQ2tZeW9ma2tTa0VyMGc9PSIsInZhbHVlIjoiQW1YbkhvSUxyV2V1TWtRUEVHTDJDdz09IiwibWFjIjoiZDg4NmE0M2NmMGU5YTBhMTM3ZmNkMDc3ODVlOWYzODlhN2VhZDdiZjRjZjdkNDM1M2M3ZGMwMmI4MmE5OWViNSIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6Ik94a0poaGI1YjgzM05YS3hHV1cxUVE9PSIsInZhbHVlIjoibGd6aXFtQXp6U25ZNGlJL2kwOGxqUT09IiwibWFjIjoiN2ZlN2RkMDA3NDU5ODg0MzczYjNlOGIwMzk0YzlhNDE3M2M0MTBhMDViOGU2Y2VhODdjMWM3NWVlZWY0ZDFjZiIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.596)
References: <8a415902c751cdbb4b20ce76569216ed@mail.infomaniak.com>
 <e4f12422-1c47-4877-88b3-dfa9917331a2@leemhuis.info>
 <f4439fd1-7c2d-4a96-9116-1dbe04fceac0@leemhuis.info>
 <CAB3BuKA+qOY+UhWR-9Ov3qsz3wQr8q8n38MrEMf3FMCthr04yA@mail.gmail.com>
 <2fcdd99eee9ee4f5d34fa1abab2f51bb@mail.infomaniak.com>
 <CAB3BuKARgJhaVNFsP1FQ+2yLe18QU9H17fHKjc-Sf3izE+MZ1Q@mail.gmail.com>
 <86566391db9c5044f1a082bc8ec697a2@mail.infomaniak.com>
 <ZVsdNGyVrTJ/Kv3n@francesco-nb.int.toradex.com>
In-Reply-To: <ZVsdNGyVrTJ/Kv3n@francesco-nb.int.toradex.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco

I run the test and it worked fine. The transmitted data matches with the re=
cived data, no diff.

BUT!!! on the MDIO it is completly different !!!
When I request to send 4kB Data I measure on the line 16384Byte.

The data is again   3Dummy Bytes followed by the databyte.
So the error symetic on send and recive

Regards Stefan

Am 2023-11-20T09:47:48.000+01:00 hat Francesco Dolcini <francesco@dolcini.i=
t> geschrieben:
>  On Mon, Nov 20, 2023 at 09:27:10AM +0100, linux@bigler.io wrote:
>=20
> >    Load the spi-dma (imx-sdma 302c0000.dma-controller: loaded firmware
> >  4.5), run the spi_imx and the spidev as kenelmodule.
> > =20
> >  I run the code on a Toradex Verdin Development Board and use the
> >  imx8mm-verdin-nonwifi-dev.dts
> > =20
> >  To add the spidev I patched imx8mm-verdin.dtsi
> >  diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/a=
rm64/boot/dts/freescale/imx8mm-verdin.dtsi
> >  index 6f0811587142..262500940adc 100644
> >  --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> >  +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> >  @@ -209,6 +209,15 @@ &ecspi2 {
> >          cs-gpios =3D <&gpio5 13 GPIO_ACTIVE_LOW>;
> >          pinctrl-names =3D "default";
> >          pinctrl-0 =3D <&pinctrl_ecspi2>;
> >  +
> >  +       spidev@0{
> >  +               compatible =3D "micron,spi-authenta";
> >  +               reg =3D <0>;
> >  +               #address-cells =3D <1>;
> >  +               #size-cells =3D <0>;
> >  +               spi-max-frequency =3D <20000000>;
> >  +               status =3D "okay";
> >  +       };
> >   };
> > =20
> >  as a spidev test program I used=20
> >  https://raw.githubusercontent.com/raspberrypi/linux/rpi-3.10.y/Documen=
tation/spi/spidev_test.c
> =20
> Would you mind doing the following tests looping the SPI interface MISO/M=
OSI?
>=20
> ```
> cd /tmp
>=20
> dd if=3D/dev/urandom of=3D4k-spi-test-data.bin bs=3D1 count=3D4k
> spidev_test -D "$device" -s 4000000 -i 4k-spi-test-data.bin -o 4k-spi-tes=
t-result.bin
>=20
> dd if=3D/dev/urandom of=3D16bytes-spi-test-data.bin bs=3D1 count=3D16
> spidev_test -D "$device" -s 16000 -i 16bytes-spi-test-data.bin -o 16bytes=
-spi-test-result.bin
> ```
>=20
> with "$device" being your actual spidev device?
>=20
> Those tests are passing on 6.7.0-rc2 for me.
>=20
Francesco
