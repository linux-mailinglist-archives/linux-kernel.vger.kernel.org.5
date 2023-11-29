Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7700E7FD8E9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjK2OFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjK2OFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:05:36 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997A5DD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:05:42 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a00a9c6f1e9so968529466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701266741; x=1701871541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MQ8xtOf7SPY4n43K7AQFcp4yw6pnczR2hfrcA2zNKh8=;
        b=v3yzIOkfFadhqPhGKQCzWKANSK51Sg9KBXlQP4IfJwapYPKGtgNgqEeMMs0/Y3qv46
         rDKBr174nkdSv+Ruot3atuNe4j1QBW4Y3jZRUBJClmhlHhLNZ1f83X1TCyHC7zJs3T2l
         QqixzXPqjcpS8Cqzfnjy8cxZuWP6a/PGKx95G6YaJPkNy9LZm7erajMx8p+V0xi7oJV/
         Q5XyI7pNM4ui8yEI76JjbGSRJ7IP6Vv1YwuDnSwHzsFl/8ulcwinAAEvNyM+R0RJALDV
         LiJMMsuEoHy0t7DVNEh/lqTrq48QrJ9dHSs+2nIV8IOfyYMliWDtBIp7r74F0JitUkEN
         OW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701266741; x=1701871541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQ8xtOf7SPY4n43K7AQFcp4yw6pnczR2hfrcA2zNKh8=;
        b=ex4t7vVPfq2yZYRtuIcMxyPuDxhFYlrQoC5EtImbbMFwncDvhEcmVr9eVTrHB9M8Qi
         6iXu04T6eeCtDAAcyulyrJ61L1De1YcmwENAJbNGl8bOREPX7RQ1eJJJ0hkiILEVEvpA
         Dvd5t4NyQz+n7Pjmq7+xdz1Hle3cBgcxLiK0PvdbngopdpGWoxr4pwIwTbLD41YAEmSi
         FWvxwJEXyiH0fsYmUZiig5sCwOyZ97td6VS3lRXzVWOtbchtEUnnYM8DZCoYjWUaW9EA
         84Co9Ji/kK45cBNcpvKzPsd4O1Dr4nn72A4oMCDrvNK8FssHo7gBHCtIC4L7FaGcifpv
         4dXg==
X-Gm-Message-State: AOJu0YxQ0p6aOnVfsXzuIKtV+bHQ279WGew9HkcUUhyZWIfqc98Hw0Qh
        LtHmryDSyk/lfLCv2uwYC390Sw==
X-Google-Smtp-Source: AGHT+IEJRq0imNqnhlsR+uCWHbDWbTPaUjfqnej06A/skJff8aDf/UUnunxlBDdm3ZLjEsqjYvGRSg==
X-Received: by 2002:a17:906:fcc:b0:9bd:a75a:5644 with SMTP id c12-20020a1709060fcc00b009bda75a5644mr12183367ejk.16.1701266741102;
        Wed, 29 Nov 2023 06:05:41 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id o14-20020a1709062e8e00b009fe3e9dee25sm7947530eji.61.2023.11.29.06.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:05:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 1/2] arm64: dts: qcom: sm8450: correct TX Soundwire clock
Date:   Wed, 29 Nov 2023 15:05:36 +0100
Message-Id: <20231129140537.161720-1-krzysztof.kozlowski@linaro.org>
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

The TX Soundwire controller should take clock from TX macro codec, not
VA macro codec clock, otherwise the clock stays disabled.  This looks
like a copy-paste issue, because the SC8280xp code uses here correctly
clock from TX macro.  The VA macro clock is already consumed by TX macro
codec, thus it won't be disabled by this change.

Fixes: 14341e76dbc7 ("arm64: dts: qcom: sm8450: add Soundwire and LPASS")
Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Considering that in Downstream, the TX Soundwire is part of VA macro,
there is no clear reference code explaining this. Let's just go with
SC8280xp approach because it seems reasonable, but don't ask me "why".
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index a305f8c03f9e..28207c7423f0 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2314,7 +2314,7 @@ swr2: soundwire@33b0000 {
 				     <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "core", "wakeup";
 
-			clocks = <&vamacro>;
+			clocks = <&txmacro>;
 			clock-names = "iface";
 			label = "TX";
 
-- 
2.34.1

