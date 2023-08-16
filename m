Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8C577E6E7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbjHPQrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344934AbjHPQqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:46:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF861BE6;
        Wed, 16 Aug 2023 09:46:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bf91956cdso837277866b.3;
        Wed, 16 Aug 2023 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692204408; x=1692809208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVCphXM+aqgRDu6AzkHcmqdWrGaOaXUga/GtYv+auXA=;
        b=lY1nvlUgvYrQ0tfgd5z6BVb71BBbOHkP5+zfzSG4NqgqwHa8gEyZdAPJb6lmLYXIaP
         9pI1btBFl6SeIqKXQD+0gzJ4oNcHa4Uvb2CS+QbOhrwKPd6TwK9bFrKXcW2JJbBWo338
         kThA+n/R3OuQUrnzVSS52OCKrscJJ1DuTgFj9zYTNJ4bDdgaq4c6LkzyXks/9g52TE4u
         lhdBLnWOeiR9iWwctwozigOBaUit9+5Z6hSZLH+OfTka27FB3JOe9h9yWgl7xJDD7haC
         Nctr2c2DKmptulhBmXqJFdu1LsOLkKVf124E428R75ghXCPhAWaJSF2KzS+dzZfzmX41
         RL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692204408; x=1692809208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVCphXM+aqgRDu6AzkHcmqdWrGaOaXUga/GtYv+auXA=;
        b=aJqbkPbsUt003t+DoDVSbrdCF0srGiA29K/EMTNNYl6TgNTLsry566cqDTRPWyxGBJ
         6SrJ7tnZ9/cQoxw4Vc05BOvAFLY00cmTLVqERZ8Aca2dAjZ94vb6ajm7JFlg8oJ2vJZa
         GiWGLRYeoks/UdWhDmhDFCGH928zj21LSUDah4SSCSJEnX6RQC4h6FIr7d7ZFOAG9tHw
         A6xq7sIwJV+Zhn4GsPECJu0jdPG+ld44Jh5Tgkgaf3bVzhE/XPZL2mYLniJuXfTbJbUH
         1RwHVAlugJW5tEB3o7DarjJtR5NQbUROexQ3fJGVn4x3w9InvKvNF+j+1TaYiihmOaLe
         z5nQ==
X-Gm-Message-State: AOJu0Yx4cHotucIhNo1LSK9pSNZVFbuvr5DRbD7uyKFfFbZvLL3DWwS3
        z/+EHQE/Lz7tdwiUVzUkUBE=
X-Google-Smtp-Source: AGHT+IGqFMcH5HWtb5f73Bz235q1eo5hf/NR9vkc7sQ2UdHZh6Lai1Lng/dMztATx7E1N4FohSQ10Q==
X-Received: by 2002:a17:907:3e9a:b0:99b:d075:18ba with SMTP id hs26-20020a1709073e9a00b0099bd07518bamr2271107ejc.56.1692204408389;
        Wed, 16 Aug 2023 09:46:48 -0700 (PDT)
Received: from fedora.. (dh207-98-254.xnet.hr. [88.207.98.254])
        by smtp.googlemail.com with ESMTPSA id b15-20020a170906490f00b0099c971ba285sm8697400ejq.5.2023.08.16.09.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:46:47 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_mojha@quicinc.com
Cc:     computersforpeace@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 4/4] arm64: dts: qcom: ipq5018: indicate that SDI should be disabled
Date:   Wed, 16 Aug 2023 18:45:41 +0200
Message-ID: <20230816164641.3371878-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816164641.3371878-1-robimarko@gmail.com>
References: <20230816164641.3371878-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that SCM has support for indicating that SDI has been enabled by
default, lets set the property so SCM disables it during probing.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v3:
* Use the new boolean property
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 9f13d2dcdfd5..bd0198aaf8d0 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -57,6 +57,7 @@ L2_0: l2-cache {
 	firmware {
 		scm {
 			compatible = "qcom,scm-ipq5018", "qcom,scm";
+			qcom,sdi-enabled;
 		};
 	};
 
-- 
2.41.0

