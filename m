Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3E7792C74
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjIERb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjIERbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:31:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9226325EAC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 09:57:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso27112045e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693932959; x=1694537759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1I6IwceD9yMG95Xy3C5UFcBdFWUjpLzegH+tNAfDOaI=;
        b=fOgxu5j7X9Spgjc7WQGQQ+/vodUDV8sP8cQHeF7K6kti0DemHfEbNudMAoVryY7uJE
         U0yNNud8Jxl/C8thbsruG4j7/wUnhOUb+X80E48aREWLn6zB0ukyPRO3nUa85pRn6A9e
         3UH72GnbdEbljAVLYuNqvH5LIKLmV9mLO4JDpYDI8ecudWiqJCutRMv4o53Z1ZmomfAp
         qUF3+Z1CD/ijU8O/aniP8EpIbiGT2Rhz+f01Cn6c2qUyIB1TqQl/SbqiA576qjN/JZLD
         +w2/6SxWu+1zW6BlP4ei0Rn3HSoBNELzDBngJdwWAPngJEik2xWSmuXpu9Rkqr6CTbMU
         /JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693932959; x=1694537759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1I6IwceD9yMG95Xy3C5UFcBdFWUjpLzegH+tNAfDOaI=;
        b=A9TL9qR3vWD08LiXjRAEmaiEk0Oh9dqm/BELEjz3/xKthaXamlCbMnjZSudWoYblYY
         +t5SWUgjTE84TisK9bkwSmNOicQBCv46MR7I/9JXzk0jF8n9rp2fi1kklmce5GLAsQKc
         uVjdXdyuo76c0ijWKDRxlDzHgniNbROOOjMDKfVve6Z3Y9yQyru6jHRifbggewa+MDi7
         qjyAA/5bwfWjuWKzQXrDSV+KKpBuCgZD/qvP5vzG3qYL5FDz8WYFk+SUHNRDg0U1NyHG
         VVCZtmGnfhwaEqaf4CtecaDkiFDe3kgSahTHBX1tChxhwyupBSd6FfZDlqbRZekx+iMD
         HkLQ==
X-Gm-Message-State: AOJu0YyumQs+3hfn7l8ZiwL9T2IJl1JCaHe2YFteG+iZQTUTE2kc9nk8
        5ErY1KUwA8ETBZkftXspeRDL0TNjhUhx//V6TEY=
X-Google-Smtp-Source: AGHT+IE652HnpOuqvnVBGDDLrT5wGDbZm60/a3Eibz5HpmZ0r1doLgr270vkCnEhcqO3UeDgCRLTVw==
X-Received: by 2002:a17:906:1db2:b0:9a6:4fe0:4552 with SMTP id u18-20020a1709061db200b009a64fe04552mr203290ejh.46.1693930770138;
        Tue, 05 Sep 2023 09:19:30 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id v26-20020a170906489a00b0099cc36c4681sm7743165ejq.157.2023.09.05.09.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 09:19:29 -0700 (PDT)
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
Subject: [PATCH 02/12] arm64: dts: qcom: sm6125-sprout: correct UFS pad supply
Date:   Tue,  5 Sep 2023 18:19:10 +0200
Message-Id: <20230905161920.252013-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905161920.252013-1-krzysztof.kozlowski@linaro.org>
References: <20230905161920.252013-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm UFS phy switched from dedicated driver to QMP phy driver.
Eventually the old driver was removed in commit 02dca8c981b5 ("phy:
qcom: remove ufs qmp phy driver").  The original driver and its binding
used vddp-ref-clk regulator supply, but the new one did not and left the
supply unused.

The Qualcomm UFS phy bindings were also migrated to newer ones and
dropped support for vddp-ref-clk regulator in commit dc5cb63592bd
("dt-bindings: phy: migrate QMP UFS PHY bindings to
qcom,sc8280xp-qmp-ufs-phy.yaml").

It turns out that this regulator, although with inaccurate name
vddp-ref-clk, is actually needed to provide supply for VDD_PX10 (or
similar, depending on the SoC) used by UFS controller.

Bring back handling of this supply by using more appropriate regulator -
UFS controller host supply.  This also fixes dtbs_check warning:

  sm6125-xiaomi-laurel-sprout.dtb: phy@4807000: 'vddp-ref-clk-supply' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
index 90b5f22ea9dc..a49d3ebb1931 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
@@ -400,13 +400,13 @@ &ufs_mem_hc {
 	vccq2-supply = <&vreg_l11a>;
 	vcc-max-microamp = <600000>;
 	vccq2-max-microamp = <600000>;
+	vdd-hba-supply = <&vreg_l18a>;
 	status = "okay";
 };
 
 &ufs_mem_phy {
 	vdda-phy-supply = <&vreg_l4a>;
 	vdda-pll-supply = <&vreg_l10a>;
-	vddp-ref-clk-supply = <&vreg_l18a>;
 	status = "okay";
 };
 
-- 
2.34.1

