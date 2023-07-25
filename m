Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9618676239B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjGYUiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjGYUhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:37:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC6B2D50
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:37:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-267fc19280bso174436a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690317440; x=1690922240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZ7YK7+MOq9X+RTweOdEeLPvYNyqsXxq2qSFOs1mT3s=;
        b=BuN5tKldtTLx2sEHuuuAagR2QfiguR7+L5jScpcBlZCtNRwzluFw4euj+TZAsdvP26
         EDACAv0XTZF3vF/p2//utmh8C9vbXaUnVYNuAmPvGVxAktKJPkiFXYmd2itCZRx075gV
         Jy580G+wiVMstRe0Eq3zIfvwRU2mZmMau5NKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317440; x=1690922240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZ7YK7+MOq9X+RTweOdEeLPvYNyqsXxq2qSFOs1mT3s=;
        b=CG70tIKmc+bwNzTp+pZ6lexaNxhmEqbwnIgYU2euPudJ60TwqePzY8vK1+lrPxG2Kt
         RLueBevMB/99W9Bj0n2aZnHAYFBpSafEzsU/Ut/nxvFHB4bHDBfTktQJ54D8wvznGv1Y
         0EDl/Gikcd0JcvqlfPNkitZNFdxU4B2MNucXPutSJmG3KB+lV0gbcTtXVzOUx4YX/DK8
         DTNxPjBcqHke5laW6X267UYtT/yS9cTWcfaR7Sxsju4LtbMd4A4qO8TjVCJTgudre592
         gWly2CxKcwMrze/Owxqo4zaqhCZJFH4/5255zCs2g4zk3ZNblbROMyw2xGFJam6+IO/b
         3CYA==
X-Gm-Message-State: ABy/qLYzTWsPtSaFj4ASZRG3KCIp5Ak1L1xyNYkOGoXfY1m8sTJYKiow
        KdiECCk/NCmcYRJAW4qDKEzx1Q==
X-Google-Smtp-Source: APBJJlEgCBbPkr5YZubPWhaNBGqUI6g2VhIUIc6BoH6rzAKhCVoah7Aeybahr/mZ0cE03NvH+GwQSA==
X-Received: by 2002:a17:90b:1d90:b0:268:3ca4:6152 with SMTP id pf16-20020a17090b1d9000b002683ca46152mr180277pjb.15.1690317439920;
        Tue, 25 Jul 2023 13:37:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c363:4681:f5b8:301])
        by smtp.gmail.com with ESMTPSA id bg1-20020a17090b0d8100b002676e961261sm1396951pjb.1.2023.07.25.13.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:37:18 -0700 (PDT)
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
Cc:     cros-qcom-dts-watchers@chromium.org,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, hsinyi@google.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        yangcong5@huaqin.corp-partner.google.com,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 10/10] arm64: dts: qcom: sc7180: Link trogdor touchscreens to the panels
Date:   Tue, 25 Jul 2023 13:34:45 -0700
Message-ID: <20230725133443.v3.10.Ia06c340e3482563e6bfd3106ecd0d3139f173ca4@changeid>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230725203545.2260506-1-dianders@chromium.org>
References: <20230725203545.2260506-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

