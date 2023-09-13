Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B680779ED34
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjIMPfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjIMPfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:35:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D50C1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:35:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so73679755e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694619336; x=1695224136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IqhDGN0q1K8XUZqE/r9ClfBnQGg9OFu7r8WfZswLLwk=;
        b=Nd/ji+w6Uejw67NqZe1tD+fMWa/1Fke6CRX5J0j01X0fAKZO0MT188A3QvSWlYAoiN
         Bcms5g/W4xnYinPUZs246Gb4qPt8c1ybmmen90fQF/ojCJ2T+m67OfqCFUfy6/BHWFXM
         Iqc02xiQHMYQ+nXYxKM3p2DOA+dGx3OfsJzXmbhtR1hEl+muEuXwy+azHqj4UNjtegVl
         /ECKbs1GNQ2pN8YkG6agczIqwtAhWHnTL1pQBrmVGiteskyNUjy93Y5JgAn4fimfm5Ro
         NzHPCJXhFxLmnXho2xilvDchj/nJaZQl5WhwExrV58kzemWfrYscn4Ub1Fk4kXVxZN0h
         HWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694619336; x=1695224136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqhDGN0q1K8XUZqE/r9ClfBnQGg9OFu7r8WfZswLLwk=;
        b=xGst5ELvTsvGFi1Pp2EWPzSITmWlIj9f2dhtDHQdWOqkOiVflliLyUzahxLVH606D6
         cLeOPDkLiHtk/10SM7A0VBi0v1SyFc2oF+CBwr3V/D0B+natCEJl8L5qkQgybPoESQB/
         lxZ6q/bB/oWD9eYtyn08tYkwCT9qrNdSWB1jMAUBkhU+YMT8siRXou0lkEAyGgOI6cQI
         8oWZJGzOChUli0teaLuSO4H5E/DGFgAIUNbJbYsYQ2JbURH2jmWIcIcNpcFOKTCHH/n/
         1JZ1g5hFrwZ3r+P8pyl/vAHw6sqicK1aPys/Ju9QY9Cwlva57PWGRFxHYBSSzjrLsLgC
         CgeA==
X-Gm-Message-State: AOJu0Yz4MWkE6HTbQ7BTdfvA7hAf6UqXKg/6oPZtuEk3gkFXm7Zig/eX
        NYPvxfOZudw3rmQcbcW0H3/lIQ==
X-Google-Smtp-Source: AGHT+IEcxLrH+tnCBz0k0JsdV60yzkYS5v2M+TY2eCeNR9XmfWCK8lMQcqp+jXnOF22JfEoEY3riwA==
X-Received: by 2002:adf:f8cb:0:b0:314:3b1f:8ea2 with SMTP id f11-20020adff8cb000000b003143b1f8ea2mr2526999wrq.6.1694619336162;
        Wed, 13 Sep 2023 08:35:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:3b50:bca5:a754:7463])
        by smtp.gmail.com with ESMTPSA id e11-20020adffc4b000000b0031f65cdd271sm15750315wrs.100.2023.09.13.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:35:35 -0700 (PDT)
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: crypto: ice: document the sa8775p inline crypto engine
Date:   Wed, 13 Sep 2023 17:35:28 +0200
Message-Id: <20230913153529.32777-1-bartosz.golaszewski@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible string for QCom ICE on sa8775p SoCs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index 7da9aa82d837..ca4f7d1cefaa 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,sa8775p-inline-crypto-engine
           - qcom,sm8450-inline-crypto-engine
           - qcom,sm8550-inline-crypto-engine
       - const: qcom,inline-crypto-engine
-- 
2.39.2

