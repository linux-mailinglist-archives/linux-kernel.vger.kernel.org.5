Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141EE7B2751
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjI1VQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1VQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:16:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D309119D;
        Thu, 28 Sep 2023 14:16:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so17255907a12.0;
        Thu, 28 Sep 2023 14:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695935784; x=1696540584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XZTix1Mf7XTs+tXTEEd3SF8eZQ4E+jmYLihpcH3rUo=;
        b=GUdDkMllYJoTDklbC1QYJdVh/6BgtagQxPO+yFJbikVRioVr+R1IC8tpvTd9WZwxRY
         +7AM8XlaDHD6U6K955823CAVDGLJA807NVCHJ+Z2cdLg7TjvLqUBblo+X7LyQJeJhMnp
         87Ha2ygJfe4uyzoJG1FAhfFDeqSm5YYz1fvxF88EG89u6x4EQXC8V7z1qZmhaj1CD77n
         /fROLarCrL6EBvBlSrQuigk3zU32BucXWhaaV5CejzJRsRY/lrEoCkzY2Y305mlL9Vr3
         KsufM0j7AzcR19q5IDASkTGsAAf63ixiLsS5cIOUtlnX6EFYy41U1lQaLkO8Su9DIjNm
         BbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935784; x=1696540584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XZTix1Mf7XTs+tXTEEd3SF8eZQ4E+jmYLihpcH3rUo=;
        b=sOeAmHVqP/tHHowdfby2/L6KpRy63bzUFBTECwO2gkOAVOzEFCsknE3VGHJd/+yEDC
         oXPfDMf/1uHxM4Glz8O7yRprCap8GzheHOYKs6eJk9cIS+wx/ocV5LVb0h/JuQ+06AuN
         n1pBdxVvMO1QmpRP1WS1l6NUYDp7/FmoudCf5X+fgTBEgnsGK73iOpVVckDSh49mi8YH
         kaorAveKkQ+nX5pzBqOTouD29e/LswJBfyzTe6IeumzqQEZnZL5ccrUybvNuK2j7Vwhh
         Prw+bky3gFMzU72zVcbHgbMt4vmypGqpUwn03BWRkuTfOuO4CbS2fsZ71yxUeQNu7QYU
         B/Yw==
X-Gm-Message-State: AOJu0YwaJlMiae/LUYkjcLTQsE56YUtobXYogsqFzqu64v3QvyZjO+uZ
        neTD7nO6s/136/gZGWnZzdk=
X-Google-Smtp-Source: AGHT+IHbcaLWh47udGrDwolMOI1W/KhIeoJkTFxGfN/IKUTWR7QQARltc40jxhj+sDi2oFSAWY1UQg==
X-Received: by 2002:a05:6402:1810:b0:52f:c073:9c37 with SMTP id g16-20020a056402181000b0052fc0739c37mr2135424edy.3.1695935784190;
        Thu, 28 Sep 2023 14:16:24 -0700 (PDT)
Received: from fedora.. (dh207-99-57.xnet.hr. [88.207.99.57])
        by smtp.googlemail.com with ESMTPSA id o5-20020a50c905000000b0053448f23b33sm2933324edh.93.2023.09.28.14.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:16:23 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_tdas@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq8074: pass QMP PCI PHY PIPE clocks to GCC
Date:   Thu, 28 Sep 2023 23:15:21 +0200
Message-ID: <20230928211620.1278054-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928211620.1278054-1-robimarko@gmail.com>
References: <20230928211620.1278054-1-robimarko@gmail.com>
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

Pass QMP PCI PHY PIPE clocks to the GCC controller so it does not have to
find them by matching globaly by name.

If not passed directly, driver maintains backwards compatibility by then
falling back to global lookup.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 643b586c0dec..1f108ee2e8ba 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -407,8 +407,8 @@ qpic_pins: qpic-state {
 		gcc: gcc@1800000 {
 			compatible = "qcom,gcc-ipq8074";
 			reg = <0x01800000 0x80000>;
-			clocks = <&xo>, <&sleep_clk>;
-			clock-names = "xo", "sleep_clk";
+			clocks = <&xo>, <&sleep_clk>, <&pcie_qmp0>, <&pcie_qmp1>;
+			clock-names = "xo", "sleep_clk", "pcie0_pipe", "pcie1_pipe";
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
 			#reset-cells = <1>;
-- 
2.41.0

