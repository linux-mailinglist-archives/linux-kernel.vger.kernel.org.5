Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4569776A19
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjHIUfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjHIUfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:35:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0418C2112
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:35:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so1487305e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 13:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691613337; x=1692218137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2cvjbfix/wPh0u/PHG3ITrkDIPmnvtrUnb/pWLaP6c=;
        b=jj1+uWLCc+4FcR4qZUoxtzm4+9MlriK4bTUnuOslgEG390QjTtygyyyjXQZEbKBZba
         mn5IqC10OyupOZI8ITaiuSsvTgcO8Rg9PImx//+wxsDStBoQL0cvAdNbTVOXbIoSZEed
         nOksH3IrBlsS1SdZw0vPzdv3ARZNnMq/ASjD9iVh9UWhG//5WRTo6YyHTCe0Wgh82npx
         TyXXq5vLyww7VNVZxhM8Op86z2HruArUZjocnCzIYJYKGATRgkyjIrvpW2p8FCr2sDFz
         hFSZrQ4wUeq4uJlkqlLZc467tYWByBNRSV1cllmBuPAIcVAQyT8Nm6DPvhm0PtH/aKFv
         10wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613337; x=1692218137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2cvjbfix/wPh0u/PHG3ITrkDIPmnvtrUnb/pWLaP6c=;
        b=V9m66YGx19aILgNxIsJq/e9+/cHsP0mCdbfMcRjvGumWE0CHK1Ph0lUQfZ53mej2RW
         ixOvvJ0t3qoEBylFAyJkvtCJ4BfsJgNn/n14FNAnVhZsBRgvKiZzTDnBVS1Ftzv4nSjD
         qiR2LpFe+BPpauShOIrrylcrj4bc1qvveRCNruNUMw9SyidKkyyPOgCBjSRR4C55LMgO
         fBmNetBV58+c3q/+mp42Uq8+Ni81Ltfu6Kl7DlfGzTSukCbuLtoHAb/HkFSuI8e9a4dY
         zcbcAyrt7CLa8QKXbH982ERpu+rGV34+49oTsSeeCnVAzbP//S6RwRn+BY2FauvaMyIa
         cmZg==
X-Gm-Message-State: AOJu0YwNI3kP8Esl80qQWl7Qf7tNMjMzGjHu7Qc6+EcSCQD9ClcAflJY
        0C9brPR0qIy9QOaxizrRKGkC0w==
X-Google-Smtp-Source: AGHT+IHAofglJPs0oPNqBPoKh/jI6ZbUcFrRC/bkQ/hpY8gz2qEoxH3jaYn97GuGcNiA8pM9QzrsOQ==
X-Received: by 2002:a5d:522e:0:b0:317:54e2:26ca with SMTP id i14-20020a5d522e000000b0031754e226camr376873wra.50.1691613337493;
        Wed, 09 Aug 2023 13:35:37 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id x12-20020adfec0c000000b0031274a184d5sm17699490wrn.109.2023.08.09.13.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:35:37 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH 1/1] arm64: dts: qcom: sdm845: Enable CAMSS on the bare rb3 board
Date:   Wed,  9 Aug 2023 21:35:34 +0100
Message-Id: <20230809203534.1100030-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809203534.1100030-1-bryan.odonoghue@linaro.org>
References: <20230809203534.1100030-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CAMSS on the standard RB3 as it is possible to run the test pattern
generator (TPG) without any populated ports/endpoints.

media-ctl --reset
yavta --no-query -w '0x009f0903 9' /dev/v4l-subdev4
yavta --list /dev/v4l-subdev4
media-ctl -d /dev/media0 -V '"msm_csid0":0[fmt:SGRBG10_1X10/3280x2464]'
media-ctl -d /dev/media0 -V '"msm_vfe0_rdi0":0[fmt:SGRBG10_1X10/3280x2464]'
media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
media-ctl -d /dev/media0 -p
yavta -B capture-mplane --capture=5 -n 5 -I -f SGRBG10P -s 3280x2464 --file=TPG-SGRBG10-3280x2464-000-#.bin /dev/video2

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index d6b464cb61d6f..14f9afbd75e54 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -410,6 +410,13 @@ vreg_bob: bob {
 	};
 };
 
+&camss {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l26a_1p2>;
+};
+
 &cdsp_pas {
 	status = "okay";
 	firmware-name = "qcom/sdm845/cdsp.mbn";
-- 
2.39.2

