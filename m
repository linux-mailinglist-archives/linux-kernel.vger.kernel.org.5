Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8607F87D8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 03:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjKYCeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 21:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYCd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 21:33:59 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D1E19AE;
        Fri, 24 Nov 2023 18:34:05 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b709048d8eso2219468b3a.2;
        Fri, 24 Nov 2023 18:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700879644; x=1701484444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwDxPrBV1gye210dmGOK3P4MxuKjaUxc9oeTylrdKVk=;
        b=EAYKzt7wa84nfObW8UuTipq3DpXKs8tuLvZDkbA6GBeToyOwNpjqXHKQON/P2lMiw9
         muPNCPj7ZBj+u2lDdzJoQwRvlXdyP+jaslkPsJWIZAULh38Jgt6hi4b+y8ZIoUlcTa/7
         GR9QfR0Fl6r/UJcKKzuq4RGAMTlI0t5iAQ/YrkJlxJEEHF7WLo9Me5uWkiIrS4cxbXC0
         DYzf0oWWEQIQST43R7PL4mxxF203gU2UIT5cJiJPFpJ6Mg4O9Rj6oJYiOER0rKlLKJ2o
         ICStOfFy9VqIGFeeoWkbfGi72n4woAJ9yWBPlCVZLOZU8dh8uzlX6p3UAiRzNL60pHQJ
         0prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700879644; x=1701484444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwDxPrBV1gye210dmGOK3P4MxuKjaUxc9oeTylrdKVk=;
        b=XJQbYMDVKsRPm1b0hk1/7ogs5M8T8ahGS8AF+UzchAYWQqn6jQUd9H1ZX4cy49UY1e
         BGwuCwNNgu78aIuC2uYQ6zkb+FEHAIEfvCr8cVLpVmnXDDr3RBGIBx+eeqeSuRC9zPWy
         upjJgnXpjxQCqqcU2XJUZHYMWXkjVS9wjm1enOjw2cFQSfEygW3z0quiGmnBywN+Q+8V
         tb6Gm4jPcGGDlNqEfd9OoADCNDw+VMMmM5+ZTKGxPzZbQxGCL0aI0FALvwL0atusT8tF
         2Z8b0oZVOsOJh3MsjSaCSP837/tEtReJpeaydvEdGdqqOisJnAD8mAevD3mYKeXcMI1B
         rQ1g==
X-Gm-Message-State: AOJu0Yws8zpzpwWHEdQCW+KQJPWbNVKv9Qt/jyYZ56yxouqKWNL87KV8
        RJz0rEMgQaG+hpW/innAlDY=
X-Google-Smtp-Source: AGHT+IGn+LcE04+sPvS0bUrNhEsTVIrXUWbqE3J0aelwrU/x6umTcfKFPBvWITjK+TMsFaXQp+nbJQ==
X-Received: by 2002:a05:6a20:94c3:b0:18b:8b4:2de6 with SMTP id ht3-20020a056a2094c300b0018b08b42de6mr6582236pzb.37.1700879644585;
        Fri, 24 Nov 2023 18:34:04 -0800 (PST)
Received: from localhost.localdomain ([192.166.114.90])
        by smtp.gmail.com with ESMTPSA id mz22-20020a17090b379600b002839a4f65c5sm3611353pjb.30.2023.11.24.18.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 18:34:04 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm8250-xiaomi-elish: Enable usb_1 otg
Date:   Sat, 25 Nov 2023 10:33:43 +0800
Message-ID: <20231125023343.10939-3-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231125023343.10939-1-lujianhua000@gmail.com>
References: <20231125023343.10939-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change dr_mode to otg and set usb_role_swith property to enable
usb otg.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v2:
  1. a new patch that I missed to generate.

 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index ba2119da1979..6abca574398d 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -696,11 +696,12 @@ &usb_1 {
 };
 
 &usb_1_dwc3 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
 	maximum-speed = "high-speed";
 	/* Remove USB3 phy */
 	phys = <&usb_1_hsphy>;
 	phy-names = "usb2-phy";
+	usb-role-switch;
 };
 
 &usb_1_hsphy {
-- 
2.41.0

