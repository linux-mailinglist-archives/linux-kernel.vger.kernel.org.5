Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071927E8A0F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 10:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjKKJqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 04:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKKJqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 04:46:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9576C3C02
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 01:46:49 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so7949155e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 01:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699696008; x=1700300808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ELU8BWj3UezYO30gLQwRtm3c+Jv6QFB8wi14JfcKk5c=;
        b=P4jLphEk4Lj3ppQqHd7bkf2piWTTOo6KtPGaFdhTR+eJhrr53So2d73aXrJtOEP3/J
         y1KHM1eVbUCJeB86je4+4lFPARwXk2dD6Ik/3hsb9qM9u9f8s2DXE/NPtakWfrqo79wK
         I877/3dk0wPrfJRDwrpecIeGI/ukr5h3Rnmmfv/P1aOOfKC2LlrP3cOc2X0QvBCK19Rm
         F8zDAFCLD0SuXUrO7R1Zd4Up2VMiGdE+qYd0A5Yyk6RUapjNreVbBtap++bXe91r0/HG
         xUZM/GlsoiCcmojY9YrGHaQpFtVfP4oabzDKfW3vXlmfWtJmmI6rggsaLaMt40y6ej18
         MLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699696008; x=1700300808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELU8BWj3UezYO30gLQwRtm3c+Jv6QFB8wi14JfcKk5c=;
        b=MKJ6MqETRlsCnA3hVzrlda9XnB0mzu5VPjXclzH6pEa8dP3/m+6nGEn/pYpPISalvP
         DacLq8Tt68jMfrnWUO2e6mboWIR9z2MND5TX1YXM0vq9ieAmSOmdTK3daNr13F/S4gbD
         IvbBLZPHSS/sF9bqv6iW2kRJ8KAZHbhz0MQNLrQyxuvCCatLywNA8UCwvcce5Xj+rldk
         L6OXyBpCFAql01nVpp+Z9bdCsztcjW/iBebJqKnYSrwJDAi+va8ujLaiuJ/xOS/B81Zu
         doUPK0vuu8BcCClR+pN4cHW7iKDdmWVU17YFW5jAPD+lO7+jHrkBO4Is7NT9ejrqHZAN
         p6hA==
X-Gm-Message-State: AOJu0YxGuQxZseKVsYuQ3+6C1RWx8WKvxG8uainCGaL1MgahZt3GbrXb
        3ZEC1fMRiDgQfY6bMBFokuiOHw==
X-Google-Smtp-Source: AGHT+IEs7kwlts3D777qvrvpDrhlx4qvK/RLFwowrBUUFMfroCNyBGamwukZFSYmFjh9ADJoZCBZYw==
X-Received: by 2002:a05:600c:34d6:b0:409:703c:b9b1 with SMTP id d22-20020a05600c34d600b00409703cb9b1mr1405900wmq.40.1699696007560;
        Sat, 11 Nov 2023 01:46:47 -0800 (PST)
Received: from krzk-bin.monzoon.net (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c354a00b004053e9276easm7568533wmq.32.2023.11.11.01.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 01:46:47 -0800 (PST)
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
Subject: [PATCH] arm64: dts: qcom: Revert "arm64: dts: qcom: qrb5165-rb5: enable DP altmode"
Date:   Sat, 11 Nov 2023 10:46:45 +0100
Message-Id: <20231111094645.12520-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b3dea914127e9065df003002ed13a2ef40d19877.

The commit introduced unsupported and undocumented properties:

  qrb5165-rb5.dtb: pmic@2: typec@1500:connector: 'altmodes' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index c8cd40a462a3..3bd0c06e7315 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1423,13 +1423,6 @@ PDO_FIXED_DUAL_ROLE |
 					 PDO_FIXED_USB_COMM |
 					 PDO_FIXED_DATA_SWAP)>;
 
-		altmodes {
-			displayport {
-				svid = <0xff01>;
-				vdo = <0x00001c46>;
-			};
-		};
-
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.34.1

