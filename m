Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E7754C1F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 23:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjGOVlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 17:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGOVlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 17:41:17 -0400
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCEBD7;
        Sat, 15 Jul 2023 14:41:16 -0700 (PDT)
Date:   Sat, 15 Jul 2023 21:41:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1689457274; x=1689716474;
        bh=KldUTfmyH7/OUpsrrZmHdmob6ZlwyWT4KOLC0g0vHYA=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=rzjtXkmDbqrZHq9J+SPg3VzRUFhU2UzD1Kwd+b3aeA/9DFixM1vtljplQlY4PyTB6
         o0kRMQ6PvfNRR1B2ylnusPKU/JkwG85zB1F3gdNRMcDOPdAyxQV1xcyEThezL4dR4J
         QWHMpDFJa3Tu0JzkSCVqfQKE0htDmOaUGwvGBI24u4o4c/cn6dvmOI5DWug6rb0c8p
         bXyJcKpCkGpGW0pQRu3bGOJpQIRnHfvZrvn6JuZegV1UlKEnc/d11GAZRNjAcBwRE3
         DtQ3n+teHuBA22o6QtSDWHSrzKZmRxksBz11BUK0e1OKzth9hE/eanp0HSeMx3jwNJ
         Wi2OSZHwQk/+Q==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH] arm64: dts: qcom: msm8916-samsung-j5-common: Add touchscreen
Message-ID: <20230715214046.14902-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J5 and J5X use an Imagis IST3038C touchscreen that is connected to
blsp_i2c5. Add it to the device tree.

MFD driver for SM5703 is unavailable at the moment, which is required
to power up the touchscreen on J5, so it's disabled on J5 for now.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../dts/qcom/msm8916-samsung-j5-common.dtsi   | 29 +++++++++++++++++++
 .../boot/dts/qcom/msm8916-samsung-j5.dts      |  8 +++++
 .../boot/dts/qcom/msm8916-samsung-j5x.dts     | 26 +++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch=
/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index f4fd5d72b28b..cb0e4a7faf91 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -86,6 +86,26 @@ muic: extcon@25 {
 =09};
 };
=20
+&blsp_i2c5 {
+=09status =3D "okay";
+
+=09touchscreen: touchscreen@50 {
+=09=09compatible =3D "imagis,ist3038c";
+=09=09reg =3D <0x50>;
+
+=09=09interrupt-parent =3D <&tlmm>;
+=09=09interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09touchscreen-size-x =3D <720>;
+=09=09touchscreen-size-y =3D <1280>;
+
+=09=09vddio-supply =3D <&pm8916_l6>;
+
+=09=09pinctrl-0 =3D <&tsp_int_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
+
 &blsp_uart2 {
 =09status =3D "okay";
 };
@@ -162,6 +182,15 @@ muic_int_default: muic-int-default-state {
 =09sdc2_cd_default: sdc2-cd-default-state {
 =09=09pins =3D "gpio38";
 =09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09tsp_int_default: tsp-int-default-state {
+=09=09pins =3D "gpio13";
+=09=09function =3D "gpio";
+
 =09=09drive-strength =3D <2>;
 =09=09bias-disable;
 =09};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-j5.dts
index 0a32d33e9778..3e1ff5b4d2d7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
@@ -10,6 +10,14 @@ / {
 =09chassis-type =3D "handset";
 };
=20
+&blsp_i2c5 {
+=09status =3D "disabled";
+};
+
+&touchscreen {
+=09/* FIXME: Missing sm5703-mfd driver to power up vdd-supply */
+};
+
 &usb_hs_phy {
 =09qcom,init-seq =3D /bits/ 8 <0x1 0x19 0x2 0x0b>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts b/arch/arm64/=
boot/dts/qcom/msm8916-samsung-j5x.dts
index 7e1326cc13c5..b2fe109723d8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts
@@ -8,12 +8,38 @@ / {
 =09model =3D "Samsung Galaxy J5 (2016)";
 =09compatible =3D "samsung,j5x", "qcom,msm8916";
 =09chassis-type =3D "handset";
+
+=09reg_vdd_tsp_a: regulator-vdd-tsp-a {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "vdd_tsp_a";
+=09=09regulator-min-microvolt =3D <3000000>;
+=09=09regulator-max-microvolt =3D <3000000>;
+
+=09=09gpio =3D <&tlmm 108 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-0 =3D <&tsp_ldo_en_default>;
+=09=09pinctrl-names =3D "default";
+=09};
 };
=20
 &muic {
 =09interrupts =3D <121 IRQ_TYPE_EDGE_FALLING>;
 };
=20
+&touchscreen {
+=09vdd-supply =3D <&reg_vdd_tsp_a>;
+};
+
+&tlmm {
+=09tsp_ldo_en_default: tsp-ldo-en-default-state {
+=09=09pins =3D "gpio108";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+};
+
 &muic_int_default {
 =09pins =3D "gpio121";
 };
--=20
2.39.2


