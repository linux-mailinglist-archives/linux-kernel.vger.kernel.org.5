Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42637ACBD9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 22:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjIXUiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 16:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXUiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 16:38:05 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC9EE8;
        Sun, 24 Sep 2023 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail3; t=1695587873; x=1695847073;
        bh=uidef/P3KDtYZismR6gqXsHsKkj8yimkGdt20wsKK78=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=PyrH3GnXIUa2ge2X53+S+x5qTWT35QZv6XtRf1fvbvnLyh7mAjf47xKXB4Zj/T1qz
         6sDqs6AHH1kGP3h3J3OwhqrUzQ9u3/qlvMV3vrgjojlIkNS1Mq/jiUrFJvWGTB3EqB
         rymbE2676fWKdovQgaYUHdyMjMborv7WqLqQJKRMisyfxaFblFt7k/sVdjfKRREDtx
         goxAREzQyem/od4jsEjSRgWEEgglhhwLb9cl9qjMzez38WAedjmJBqQAhqSp5R2iz9
         5adj06hzbBDsgw90jCUQaWTGNfMMIKzKVgcbBBpdrLqVJBsurn1p2tpzsvXPDXkySm
         0yut3M3ZjEZ8g==
Date:   Sun, 24 Sep 2023 20:37:45 +0000
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        FUKAUMI Naoki <naoki@radxa.com>,
        =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>,
        Jagan Teki <jagan@edgeble.ai>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
From:   =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH] arm64: dts: rockchip: Add sdio node to rock-5b
Message-ID: <20230924203740.65744-1-tszucs@protonmail.ch>
Feedback-ID: 53029:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SDIO on Radxa ROCK 5 Model B M.2 Key E. Add sdio node and alias as m=
mc2.
Add regulator for the 3.3 V rail bringing it up during boot. Make sure EKEY=
_EN
is muxed as GPIO.

Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch>
---
 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/b=
oot/dts/rockchip/rk3588-rock-5b.dts
index 8ab60968f275..d1c3f9e10b3d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -12,6 +12,7 @@ / {
 =09aliases {
 =09=09mmc0 =3D &sdhci;
 =09=09mmc1 =3D &sdmmc;
+=09=09mmc2 =3D &sdio;
 =09=09serial2 =3D &uart2;
 =09};
=20
@@ -76,6 +77,21 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 =09=09regulator-max-microvolt =3D <1100000>;
 =09=09vin-supply =3D <&vcc5v0_sys>;
 =09};
+
+=09vcc3v3_wf: vcc3v3-wf-regulator {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "vcc3v3_wf";
+=09=09regulator-always-on;
+=09=09regulator-boot-on;
+=09=09regulator-min-microvolt =3D <3300000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+=09=09enable-active-high;
+=09=09gpios =3D <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&vcc3v3_wf_en>;
+=09=09startup-delay-us =3D <50000>;
+=09=09vin-supply =3D <&vcc5v0_sys>;
+=09};
 };
=20
 &cpu_b0 {
@@ -222,6 +238,12 @@ vcc5v0_host_en: vcc5v0-host-en {
 =09=09=09rockchip,pins =3D <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 =09=09};
 =09};
+
+=09m2e {
+=09=09vcc3v3_wf_en: vcc3v3-wf-en {
+=09=09=09rockchip,pins =3D <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+=09=09};
+=09};
 };
=20
 &pwm1 {
@@ -258,6 +280,27 @@ &sdmmc {
 =09status =3D "okay";
 };
=20
+&sdio {
+=09max-frequency =3D <200000000>;
+=09no-sd;
+=09no-mmc;
+=09non-removable;
+=09bus-width =3D <4>;
+=09cap-sdio-irq;
+=09disable-wp;
+=09keep-power-in-suspend;
+=09wakeup-source;
+=09sd-uhs-sdr12;
+=09sd-uhs-sdr25;
+=09sd-uhs-sdr50;
+=09sd-uhs-sdr104;
+=09vmmc-supply =3D <&vcc3v3_wf>;
+=09vqmmc-supply =3D <&vcc_1v8_s3>;
+=09pinctrl-names =3D "default";
+=09pinctrl-0 =3D <&sdiom0_pins>;
+=09status =3D "okay";
+};
+
 &spi2 {
 =09status =3D "okay";
 =09assigned-clocks =3D <&cru CLK_SPI2>;
--=20
2.40.1


