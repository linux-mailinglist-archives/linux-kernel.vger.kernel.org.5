Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F013C77CF79
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbjHOPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbjHOPo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:44:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A785E72
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:44:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68859ba3a93so378274b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692114298; x=1692719098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA3QjSCigQ8q8wip9gFTKQkaEIdBJK1A3l6+t1K7Bv0=;
        b=ejBR2jtUerzx5wnrj86G8N+bYfois34YCppqR75oLTPLq7/QzDutph+WKgbHb9TqkQ
         BRwskwQ64WTnA2SvrsJQrwU2R/Yf0P8FKH2BrA2mU1DIq1lqfoHLYujw3hlFqPKexAE0
         PjCMKLHX9eH8M7wWAqubZGqfJFjytNf2qHyGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692114298; x=1692719098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tA3QjSCigQ8q8wip9gFTKQkaEIdBJK1A3l6+t1K7Bv0=;
        b=C/pw1J3Bn7B/0uLCA2tm4JcNI8l46U63PFS2qpSTx5M2IHRhksRQScKztu1ruF7TQJ
         UTXVUM2GU3YkZO8qs3p1jwSaEgZa6PPuxWI3BWaUQMaqnJR+ev/T/I/W/UtyaGrBJ0R7
         PwwDZWfUmZsHAuJQnlmxXHEU3MpXskhd1qpVXurzySLNDK45CJvvF1dx3BoQ6qkUxoRA
         SZjd8F40scKj9DsudhSVKuBC7zMXtB6QTltthqyFtutykYCbo65QJLWsD61iiZGZmQtj
         zXwnmeB+1jQdcd4fNmdwKrevyKbDbZDVJtNPtUx3PdZwACP7DsuE6ZKzyzTB4L7JA+oU
         Sf+A==
X-Gm-Message-State: AOJu0Ywa9Aqv82rmjplDKoe2jCynm474UHUdjd4xRihWz3OoCb2oJQhA
        XmjGOAzZWy/EvXbO9mTKImm05g==
X-Google-Smtp-Source: AGHT+IG+MhhXs3J/eE7KIJtSsSOonQIqrRHLUlpGdM77zZQi1lncYBUpQPdXQrlw7WkocLYr2AbghA==
X-Received: by 2002:a05:6a00:2305:b0:687:2fa9:532d with SMTP id h5-20020a056a00230500b006872fa9532dmr11655270pfh.17.1692114298463;
        Tue, 15 Aug 2023 08:44:58 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:40cf:3807:f8c8:2d76])
        by smtp.gmail.com with ESMTPSA id n13-20020aa78a4d000000b0065e154bac6dsm9431247pfa.133.2023.08.15.08.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 08:44:58 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        "Miquel Raynal )" <miquel.raynal@bootlin.com>,
        "Richard Weinberger )" <richard@nod.at>,
        "Vignesh Raghavendra )" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 3/4] arm64: dts: mediatek: mt8183: disable quad mode for spi nor
Date:   Tue, 15 Aug 2023 23:31:54 +0800
Message-ID: <20230815154412.713846-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230815154412.713846-1-hsinyi@chromium.org>
References: <20230815154412.713846-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the SKUs are using gigadevice gd25lq64c flash chip. The chip
default enables quad mode, which results in the write protect pin set to
IO pin. In mt8183 kukui, we won't use quad enable for all SKUs, so apply
the property to disable spi nor's quad mode.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 6ce16a265e053..8e4761e2b8ff4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -877,6 +877,7 @@ w25q64dw: flash@0 {
 		compatible = "winbond,w25q64dw", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <25000000>;
+		disable-quad-mode;
 	};
 };
 
-- 
2.41.0.694.ge786442a9b-goog

