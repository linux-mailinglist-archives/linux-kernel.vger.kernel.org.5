Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CC2793A4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbjIFKsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbjIFKsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:48:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A131709
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:47:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so546753366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693997273; x=1694602073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OL3pvg5NFCe01FzoWOjFMkiMy1Be8ZpjP3+0uAwNMxw=;
        b=b457nYdfDbMG/S3k+UP1GhdvbT3qGU7AgS1a6H3UYjc+rgQEhIG1gkhPNpvB7BOHOp
         nB9ZuzQLIF6TurO6mPycIYYqQy6ik9FjbaQxlryEj6wQoKUCHkQarzKO7H3NfNAC104u
         ni1l6f592QwAMtXoue24fhzPVYpbmyH9FSEG8DuANZnW5fIP58gnjSKEhJ9Jn30YUheY
         vDGMuyElgKsnl+RY1AoAbHD5avSVIge1ye3c7KGMSQdU3M5rS6sw+UdO8Q/M5jOJn6Vb
         iyzFr4KrU9ozQcEOr58KTRa24J1YJozgK9+EhjAElcsvnFb+/nNrjRxuyYfswnPAzsMf
         GEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693997273; x=1694602073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OL3pvg5NFCe01FzoWOjFMkiMy1Be8ZpjP3+0uAwNMxw=;
        b=l3y/ln5lBCu1Uel9pwegM3iZVmjaAKAh7KZIgeVysegMszPTGduxxJW4dPsGCtMCIs
         EsUYn73rEMIzpmpl3Dvw1PzadIdfqOEkBv1UBN1JSoRs4WzOCd0bkIfbf7qJSngGJWCw
         1318qGbl8/UdyoGMpnf6NQZSQXb5J7sjihH/NT7nsy6o9F2t8OQHqSa4Vs5tcXC/Y6h2
         HsNhs/bylCS9Wm+2Ju8uojW1OayA7KQpuxS8iwXCYTipXwQzUpDBCZPeahXs0zEgXUt0
         TBc0bRWYNCsP+C/Q5n5GEtVPCBu6XFqPiaYpiP8/MVCJTLsQsHjSq9e9sHZJ/Iarv824
         e4qw==
X-Gm-Message-State: AOJu0YwGqkTwHv5XwObPGsaKWo2Qn3tVdzeQevupoX+Er1fS8R+tdTFF
        WlDfzC17pNmnt2CfUxNgDZOPOQ==
X-Google-Smtp-Source: AGHT+IHr27lA/bi/eDUkgwMIKEw+D5z9lFk163cFVDHKZX1QPSghQ6+HGxHCDWtG0Gd/lIjqwZkpPA==
X-Received: by 2002:a17:907:a046:b0:9a2:256a:65cd with SMTP id gz6-20020a170907a04600b009a2256a65cdmr1795408ejc.4.1693997272740;
        Wed, 06 Sep 2023 03:47:52 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906248700b0099cc15f09a0sm8791163ejb.55.2023.09.06.03.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:47:52 -0700 (PDT)
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
Subject: [PATCH 6/6] arm64: dts: qcom: sm8350-mtp: add UFS host controller supply
Date:   Wed,  6 Sep 2023 12:47:44 +0200
Message-Id: <20230906104744.163479-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906104744.163479-1-krzysztof.kozlowski@linaro.org>
References: <20230906104744.163479-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to schematics the L9B regulator supplies VCCQ (already in DTS)
and the UFS controller pads (VDD_PX10, missing vdd-hba).  Add the
missing supply for full hardware description, even though it should not
have functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-mtp.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
index c5a6c8745606..8bee57f3b25a 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
@@ -325,6 +325,7 @@ &ufs_mem_hc {
 	vcc-max-microamp = <800000>;
 	vccq-supply = <&vreg_l9b_1p2>;
 	vccq-max-microamp = <900000>;
+	vdd-hba-supply = <&vreg_l9b_1p2>;
 };
 
 &ufs_mem_phy {
-- 
2.34.1

