Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AC9761EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjGYQk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjGYQkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:40:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A221BE2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:40:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52222562f1eso4588407a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690303252; x=1690908052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ1gnj/eC9nPxCfASLTwleokcx+2HhZFD7BYZMiPCig=;
        b=yshi3Yy26azevSvOfouSdf9Wu4rv7nf7RJxkOLZE9hEzz8eGGgT2wjQ0tab+JthoyV
         aX5ZX6m2opqmjqwp8Yh+QqDyz3TNiF7t6Ax5rmOPmOKNs8TEarkcEACu07DY6P0HiLhz
         XxBFEh2CB17X/WhdlPZGUfks0TLdQcr2V/S31bdb2A/HBrmO+KfAfEet+pYPbQXZbIea
         Sr3A/EPLN5R0HtqJEMv4mVQbBBay9VJncju5kpfBYeUDFEq/CZ7fxoFvvIlPb/C4gZKi
         NhqhhnGNlX6WUSUvf6V14vvEv/SCcow6UqYakh1AUt8kjX/uKs+7QcaBQ1Z76f7djd0U
         QZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690303252; x=1690908052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZ1gnj/eC9nPxCfASLTwleokcx+2HhZFD7BYZMiPCig=;
        b=QNd/N3SXCpwvXW1dFJ+2g/Hg5208q1sf/mk0L+XljHRHT2Z4zIT5tEYuBL2MwtVmAG
         SfMIcK57AFSDOqiby0AeuQ8V+GeFlLuswK9SqIo4dDLwE4oUdyhoPqZadJ8qfgDlJwY4
         jYI4NZV5L3sSAGZwyJout+BsW0X+bYImuUiJNoMdiM9HSTsgUZ+fCYd4r2ANKV8UZ7JL
         Os4kjlmDFfdu0PWV6AjfnPReldcCLslAgP2VQYitb1RCVJ8qrR5mJwvPfhVBmhKY9PGb
         PtpvE2rAKxRcCZXE4EVYbTraEEVrSbU7mqhMDKAB7K5sujiUEcwUZ1Tj8pprTIMLkaG9
         Qn0w==
X-Gm-Message-State: ABy/qLa2exW0vOfbSyqb1t8iY1S1hAYiqMJdTpQHTO+7wvNHTCvh/oAi
        WIVo6XacPG96Q8/k6158AW8wfw==
X-Google-Smtp-Source: APBJJlG4Sl5G/jl6rzAdn8mnLSMnXi6DUFJxmlhJ0JxMpiqnb3gh+i39RHSwylVMpVzM1pcbHLbIXg==
X-Received: by 2002:a17:906:649a:b0:993:d616:7ca9 with SMTP id e26-20020a170906649a00b00993d6167ca9mr13955552ejm.23.1690303251816;
        Tue, 25 Jul 2023 09:40:51 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906960800b0099316c56db9sm8331201ejx.127.2023.07.25.09.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:40:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] regulator: dt-bindings: qcom,rpm: fix pattern for children
Date:   Tue, 25 Jul 2023 18:40:47 +0200
Message-Id: <20230725164047.368892-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "or" (|) in regular expression must be within parentheses,
otherwise it is not really an "or" and it matches supplies:

  qcom-apq8060-dragonboard.dtb: regulators-1: vdd_ncp-supply: [[34]] is not of type 'object'

Fixes: fde0e25b71a9 ("dt-bindings: regulators: convert non-smd RPM Regulators bindings to dt-schema")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/regulator/qcom,rpm-regulator.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml
index 8a08698e3484..b4eb4001eb3d 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml
@@ -49,7 +49,7 @@ patternProperties:
   ".*-supply$":
     description: Input supply phandle(s) for this node
 
-  "^((s|l|lvs)[0-9]*)|(s[1-2][a-b])|(ncp)|(mvs)|(usb-switch)|(hdmi-switch)$":
+  "^((s|l|lvs)[0-9]*|s[1-2][a-b]|ncp|mvs|usb-switch|hdmi-switch)$":
     description: List of regulators and its properties
     $ref: regulator.yaml#
     unevaluatedProperties: false
-- 
2.34.1

