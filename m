Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336CA765A16
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjG0RT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjG0RTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:19:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90144204
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:18:56 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686f94328a4so491199b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690478336; x=1691083136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaruT2MVnDt5o7TOPEFxtNglDYQfaqWPyFiMR9pTN4g=;
        b=hgdda686kZFO1vLHm1NDDQgKMGxF5OW+sQo6xsjQ7tAlKRQ7WakT0MGXqu4LMABAIP
         ou6Q8z90ihSUOsfDh/jx80PQcNvRNylZJxOtIK6Sqil7kXLPW/zQIpv3RwKpyXVUi0K/
         6ycwk7L+TIw7978Zphy4DbuOi2q9CE8msmui8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478336; x=1691083136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaruT2MVnDt5o7TOPEFxtNglDYQfaqWPyFiMR9pTN4g=;
        b=WOBFaenaJBroBnygNv1xSq2GgstdKzE/RPhoH4/pjB9YMbYuO5SxFoVkwiguFmWpdM
         J2Rc7mXiWNIN6F4TTxnyD5PbNOuA/XziKexerGYpwQKCUkuxdYl2jc3A61sUfrqzFQ0V
         Ar8hF34QH8FsVMskj5a5QRWlwwgQpTAbv6JeDU/cB43qaL0tZlmOg9OkqiW8w89wZ9kK
         RB+MwbsZKHnHEtqnqm/+ENm/Hb4Yrb47Hh2vCSLtLvz4oZVeTOTpkj2Csp0vt+JiOhHW
         UHtWsMVji7J+Fc0l8PLmUZrX4QkWuchXboRpm79Wzhfqrnc7//NRthKrbJba002C02K6
         HPxQ==
X-Gm-Message-State: ABy/qLbHL48pbVyPIUEBxDY4kozyrsYFp21wn4HPz40OOjsh8GCEMAyW
        OneTtx5svdVj2y/5rf7+vAp97A==
X-Google-Smtp-Source: APBJJlFsnm2DtG3enU/g8ilsDzl+1tCZj5F1uaYXmvXRTu62nGbTjnuOz1OJlDQDmUcWf3ay9wkdUQ==
X-Received: by 2002:a05:6a00:3907:b0:668:7292:b2bc with SMTP id fh7-20020a056a00390700b006687292b2bcmr3313546pfb.10.1690478335986;
        Thu, 27 Jul 2023 10:18:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:2339:954b:b98f:611a])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79111000000b0064f76992905sm1702524pfh.202.2023.07.27.10.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:18:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-arm-msm@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        hsinyi@google.com, Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v4 11/11] arm64: dts: qcom: sc7180: Link trogdor touchscreens to the panels
Date:   Thu, 27 Jul 2023 10:16:38 -0700
Message-ID: <20230727101636.v4.11.Ia06c340e3482563e6bfd3106ecd0d3139f173ca4@changeid>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230727171750.633410-1-dianders@chromium.org>
References: <20230727171750.633410-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's provide the proper link from the touchscreen to the panel on
trogdor devices where the touchscreen support it. This allows the OS
to power sequence the touchscreen more properly.

For the most part, this is just expected to marginally improve power
consumption while the screen is off. However, in at least one trogdor
model (wormdingler) it's suspected that this will fix some behavorial
corner cases when the panel power cycles (like for a modeset) without
the touchscreen power cycling.

NOTE: some trogdor variants use touchscreens that don't (yet) support
linking the touchscreen and the panel. Those variants are left alone.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi        | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi      | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi         | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi        | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi   | 1 +
 6 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 8b8ea8af165d..b4f328d3e1f6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -104,6 +104,7 @@ ap_ts: touchscreen@5d {
 		interrupt-parent = <&tlmm>;
 		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
 
+		panel = <&panel>;
 		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
 
 		vdd-supply = <&pp3300_ts>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index b3ba23a88a0b..88aeb415bd5b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -116,6 +116,7 @@ ap_ts: touchscreen@14 {
 		interrupt-parent = <&tlmm>;
 		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
 
+		panel = <&panel>;
 		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
 
 		vdd-supply = <&pp3300_touch>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index 269007d73162..c65f18ea3e5c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -43,6 +43,7 @@ ap_ts: touchscreen@10 {
 		interrupt-parent = <&tlmm>;
 		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
 
+		panel = <&panel>;
 		post-power-on-delay-ms = <20>;
 		hid-descr-addr = <0x0001>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index 6c5287bd27d6..d2aafd1ea672 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -102,6 +102,7 @@ ap_ts: touchscreen@10 {
 		interrupt-parent = <&tlmm>;
 		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
 
+		panel = <&panel>;
 		post-power-on-delay-ms = <20>;
 		hid-descr-addr = <0x0001>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
index 62ab6427dd65..e5d6a7898f8c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
@@ -69,6 +69,7 @@ ap_ts: touchscreen@10 {
 		interrupt-parent = <&tlmm>;
 		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
 
+		panel = <&panel>;
 		post-power-on-delay-ms = <20>;
 		hid-descr-addr = <0x0001>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index 2efa8a4bcda6..0e2b4d06b490 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -123,6 +123,7 @@ ap_ts: touchscreen@1 {
 		interrupt-parent = <&tlmm>;
 		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
 
+		panel = <&panel>;
 		post-power-on-delay-ms = <70>;
 		hid-descr-addr = <0x0001>;
 
-- 
2.41.0.487.g6d72f3e995-goog

