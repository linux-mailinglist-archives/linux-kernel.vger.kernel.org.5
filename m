Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4077687E4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjG3UVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjG3UVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:21:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79817191
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 13:20:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so2456879a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690748458; x=1691353258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8f/MgDrEv8Tw5VaLnW3VcLxIwrS6Qd/GuTI2klbB/as=;
        b=pb/mOZGqU4gvRpiwlnn7bHtk5y1t8Zlci00vsSjMi6KXB/5z7EnVF7UnwFF37vxs/q
         /JHPiF+WDMD6TvloGE+goL0s1lISx0gQbq5tx44PSBhQYQjGgY+r5D+eOmlStfkPvEUD
         pcCajAVX91Ef6RusRfytRtiqHFm5/0ziEfUzmS/a/p0G2egsQ1I3+wEq57FusDQESfRn
         k1HrTjBw+9smfgGqFWDlBKHL7JZQ8f9JpPTALclXnCE3/Pi5aCQ+AN1Ohu9d/QfsGFPo
         CUJbXY4EF+invy4vpmU8CDPYI9T4MYXNf3lKe0rtc6I4r0uuzSYXwrsnLJ58i+MfjoF3
         /yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690748458; x=1691353258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8f/MgDrEv8Tw5VaLnW3VcLxIwrS6Qd/GuTI2klbB/as=;
        b=RmwUuFfuEXEPasAZ0YH0lHAkrmV0t4dJH9E80RgjsEsNufQkc7FMSGwFuVYa8+a0FP
         yWL1LcZ349hE786IOwoy10z+mxeIenm9F1PgeY9ioHZDGgOixuyJj3tr4mdhs9uh0P1I
         HSvTHnoeCEqh2M0yz5+SSh+PnKtHIjLQ7Jpo/IiuQ6xRHRWSPk5BJuRLsmeQmSBS6rPQ
         2O/hszu1GS6M7He4Lv1lWHiBnuM23uykG50BMGw27f5YJPvroOVUq4LZqxmGHnODSJFk
         S2SMogRmje88DXS9FrCD7UV+E3VRpiH9BfxXLpqkRlL+vCco9zX6qvOs7LrqCW3Mvt8t
         mBhQ==
X-Gm-Message-State: ABy/qLbdagtjxMWtuwhjnKkLvA/f/shZW8PlM0fZfFyL1/LwpWcypmFm
        dAMTTKGOMr8i5i/e8bK+A6+g9w==
X-Google-Smtp-Source: APBJJlGU7AKTZgnUH7tZLhdoNMXBGmqsRp6wlJ6rIt/BwPXPqtzqgMF4PF4altfte1iWVEf70DFpAQ==
X-Received: by 2002:a17:906:329b:b0:988:9621:d855 with SMTP id 27-20020a170906329b00b009889621d855mr4326827ejw.61.1690748457920;
        Sun, 30 Jul 2023 13:20:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id h19-20020a17090634d300b0098e422d6758sm5066254ejb.219.2023.07.30.13.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 13:20:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: msm8953-daisy: use new speaker maxim,interleave-mode
Date:   Sun, 30 Jul 2023 22:20:51 +0200
Message-Id: <20230730202051.71099-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX98927 speaker amplifier "interleave_mode" property was never
documented.  Corrected bindings expect "maxim,interleave-mode" instead,
which is already supported by Linux driver.  Change is not compatible
with older Linux kernels.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on:
https://lore.kernel.org/linux-devicetree/20230730201826.70453-2-krzysztof.kozlowski@linaro.org/T/#u
---
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
index 790d19c99af1..a5957e79b818 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
@@ -125,7 +125,7 @@ speaker_codec: audio-codec@3a {
 
 		vmon-slot-no = <1>;
 		imon-slot-no = <1>;
-		interleave_mode = <0>;
+		maxim,interleave-mode;
 
 		#sound-dai-cells = <0>;
 	};
-- 
2.34.1

