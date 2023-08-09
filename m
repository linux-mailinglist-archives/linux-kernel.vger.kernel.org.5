Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD60775E91
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjHIMLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjHIMLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:11:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A801FF6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:11:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bdcade7fbso928557066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691583077; x=1692187877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFvAA/v39L86qjDqi6cHkK3yiYvvs9Qa9ISV4luSpBA=;
        b=zSTpFBWgAy+W9hQ3BJaNASIGGp6eg6Rwzp4IfUNiRpwt5fq8c13KGfO2DcU18ydb7v
         WdFJRBmkzrAUqgik6ksekivDMVymFBbq7daOUZ28HBr5mjNxxIJR5GZNpby3v9WXLacZ
         K8WRTnIaT4f7Psu2fWYwgodwosf5pymQVEEJye5VcRgBLu5OV5MCRPWkyNNqBJbYJpjs
         d3WN//tLkRKwxgms/uhO70yu/pzbQqlX02amAHdDAZlY0WpCHflzj6Q+qVx+xqLyLbLd
         xV32CF3SsjYuCc/Vz6Xy8FQqHvCgFx1WOYLhxn09W9TZ7Zx0ysu4Aj3JxtuGLOMuIZLT
         DF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691583077; x=1692187877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFvAA/v39L86qjDqi6cHkK3yiYvvs9Qa9ISV4luSpBA=;
        b=gF7pa0Hb2MVS+3XfKg13lJ86lyVRFVNTLomd7e17vbrXjxVGChenuaNisUx5STFL3H
         k6SjzlZ3yKigMsRexk/Kd4NqpF5t92AWmBJT7NCMSSiN4vKSyI7QO136M4iBnJtpDYBQ
         hStSgKHhsTVASUvy8ic0Gbt9foj5oZwzMRZcrZ0cbZI0/O+DEg99NnIuYmGOmCLERSpJ
         Nnt7afC2xqP/Pg5leSfzIgKNPSsTrWtmf6J56WvURxUpOSV8u9ihBZJLQCNjxpEheuJ9
         +vFjF/02m5Or7nfjEOD8I64JAEIVP45SedcHyCY/hdP11cmm5DuRGeFJJxur4Gx9Mrg5
         sOPQ==
X-Gm-Message-State: AOJu0YwtdCARrzwndl+JUg/EE3M6VaI9Du3QMcmhCztPBnnCB0HfX2pV
        krktL1n70vc9gykp1H5ThrWDskEeYQrAX/qDi6U=
X-Google-Smtp-Source: AGHT+IFdMKH9L8wd2454RCyOpWWrJie6RwmaDWZQZMXoneh38svP9bLig4ymV9a7EA2LKFm1dKwF8g==
X-Received: by 2002:a05:600c:248b:b0:3fb:b530:a4e4 with SMTP id 11-20020a05600c248b00b003fbb530a4e4mr2033263wms.8.1691582678366;
        Wed, 09 Aug 2023 05:04:38 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b003fe1a96845bsm1808573wmi.2.2023.08.09.05.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 05:04:37 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, loic.poulain@linaro.org, rfoss@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH 2/7] arm64: dts: qcom: apq8016-sbc: Fix ov5640 data-lanes declaration
Date:   Wed,  9 Aug 2023 13:04:27 +0100
Message-Id: <20230809120432.1036405-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809120432.1036405-1-bryan.odonoghue@linaro.org>
References: <20230809120432.1036405-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The yaml constraint for data-lanes is [1, 2] not [0, 2]. The driver itself
doesn't do anything with the data-lanes declaration save count the number
of specified data-lanes and calculate the link rate so, this change doesn't
have any functional side-effects.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 75b4e5ff7c95c..0481a4a82090a 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -291,7 +291,7 @@ camera_rear@3b {
 
 		port {
 			ov5640_ep: endpoint {
-				data-lanes = <0 2>;
+				data-lanes = <1 2>;
 				remote-endpoint = <&csiphy0_ep>;
 			};
 		};
-- 
2.39.2

