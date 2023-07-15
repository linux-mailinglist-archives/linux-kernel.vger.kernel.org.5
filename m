Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B7754C12
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 23:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjGOVFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 17:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGOVFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 17:05:40 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A5A2738;
        Sat, 15 Jul 2023 14:05:39 -0700 (PDT)
Date:   Sat, 15 Jul 2023 21:05:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1689455137; x=1689714337;
        bh=p4IaxbwpaHv+xOOMu8SedVmfPdSj/FMf57pnmMhXBrA=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=oZPOyal7jiELXgpPFrXV4x0bXBjCM3MRG5a0sj+aF9n/iidZ+kzWf+KxNEdB97+eu
         cbE//hMFM96tzR2gii+/01V3p3ZKn5l61opRtARNe6unExvHnyh3d8xpFV95UNO1+J
         I/4CyiSSEw685i2AI6oVf3Y00yNFLQyKycFK65Iv4KjUgCr/bybpczD8ezQNQxkqYz
         BUvnEGRvH6csy4xhnawLQ61qhTPDTJCFMexnO66lR51xkiyLWhhwDwEXbo42lppHnd
         RAqTPXwcR4lOIXSKSpiPKl7ydEy4ynhNHKH6MDWGlrOoB5KNZTRMnclEqmOI2CLden
         S5kaPwopdJVLw==
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
Subject: [PATCH v2] arm64: dts: qcom: msm8916-samsung-e2015: Add accelerometer (v2)
Message-ID: <20230715210515.13783-1-linmengbo0689@protonmail.com>
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

v2: fix interrupt-parent =3D <&msmgpio>;

E5, E7 and Grand Max have ST LIS2HH12 accelerometer.
Add support for it.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../qcom/msm8916-samsung-e2015-common.dtsi    | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
index 0cdd6af7817f..6f65fd4b3ed3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
@@ -42,10 +42,27 @@ reg_touch_key: regulator-touch-key {
=20
 &blsp_i2c2 {
 =09/* lis2hh12 accelerometer instead of BMC150 */
-=09status =3D "disabled";
-
 =09/delete-node/ accelerometer@10;
 =09/delete-node/ magnetometer@12;
+
+=09accelerometer@1d {
+=09=09compatible =3D "st,lis2hh12";
+=09=09reg =3D <0x1d>;
+
+=09=09interrupt-parent =3D <&tlmm>;
+=09=09interrupts =3D <115 IRQ_TYPE_LEVEL_HIGH>;
+
+=09=09vdd-supply =3D <&pm8916_l5>;
+=09=09vddio-supply =3D <&pm8916_l5>;
+
+=09=09st,drdy-int-pin =3D <1>;
+=09=09mount-matrix =3D "1", "0", "0",
+=09=09=09       "0", "-1", "0",
+=09=09=09       "0", "0", "1";
+
+=09=09pinctrl-0 =3D <&accel_int_default>;
+=09=09pinctrl-names =3D "default";
+=09};
 };
=20
 &reg_motor_vdd {
--=20
2.39.2


