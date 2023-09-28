Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D700A7B2754
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjI1VQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjI1VQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:16:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA98F3;
        Thu, 28 Sep 2023 14:16:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so16471367a12.1;
        Thu, 28 Sep 2023 14:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695935783; x=1696540583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRfD2frfJCrCV8FZTJoVzCkfiyFyj4/PvBoUWy9PR30=;
        b=E3Vc1spApcwEliAcMjTfYwHAnq+iXGeEmfFJQzSfoMZ+y4Q3ItZwdLqpR4FLNt32RC
         jPJFI0R1PX7O8c2SC6gyCw/rhUo0h73FEnnATRRflbcQTUQ0TvyCdnJE5GOfspZMzLTO
         aUU14jhbToaSNE1svtDK0mHCENT6o5NxAHYbhk9CKLjvc2OPMNZ8CJ+4jx7iObUpK19L
         72BGo9+JQ5y3EhiNRzvcYPAOs4NQe2bG3DvedEFvAKHpL38ogmczyBaT6B8ozbLVQIDi
         b47mqurJKy2CkYa3WBkY5WO67y/mLAgBbFhYuabAbsVDp0s8aBSkendy1BFUb6VykhXQ
         39VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935783; x=1696540583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRfD2frfJCrCV8FZTJoVzCkfiyFyj4/PvBoUWy9PR30=;
        b=ArzCQsPVv5ZyHz0OGpmS5CbumJV4eBiWivm4UW1jKl8EHTbst4vZ1yg7PzH8vKGCs8
         38CfiMfBfEDUJ4mAnn4+6ibGyfi51oT3/SnJdXCrL7qLKmLhs9q7ljqBTGc8yS05NoaC
         uvEORj6HBnT/6n4gzEkCwDSPI/6trHCS8aKTDcO7BiTKAHS/kbDhK/7llKZhTef7n7of
         b/JysXgikRn5S3bLgvNfQ8DdK8wGLXbg6TZegZ9d4u3oc1tNm9afvudpgdkEXcJrm5pe
         KFn1RinfQGZLrBqc3bdAX74x3Af/OwXh2NDiEHk6L3QXYbMY0gaMhKURzyXjl9rNF/x3
         GKsQ==
X-Gm-Message-State: AOJu0Yxj2kDS0m6sPd5rbs5gR5IS5ENL+JmtlJLbNpHEHkD6T83snvoe
        M6Tv3M8oj+DSvNb+ggXWNe/iXcBKKx/eog==
X-Google-Smtp-Source: AGHT+IE56xr0mbWbKfq9BwwKUgmkOlU0UH3fRy8LBaQr2sErquhJ8Ityq6TAFHZSCI+QfGq0lNYRXw==
X-Received: by 2002:a05:6402:3c1:b0:533:2449:7a59 with SMTP id t1-20020a05640203c100b0053324497a59mr2458774edw.11.1695935782949;
        Thu, 28 Sep 2023 14:16:22 -0700 (PDT)
Received: from fedora.. (dh207-99-57.xnet.hr. [88.207.99.57])
        by smtp.googlemail.com with ESMTPSA id o5-20020a50c905000000b0053448f23b33sm2933324edh.93.2023.09.28.14.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:16:22 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_tdas@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] dt-bindings: clocks: qcom,gcc-ipq8074: allow QMP PCI PHY PIPE clocks
Date:   Thu, 28 Sep 2023 23:15:20 +0200
Message-ID: <20230928211620.1278054-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Allow passing QMP PCI PHY PIPE clocks to the IPQ8074 GCC to avoid having
to do a global matching by name.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
index 52e7831a8d6d..2d44ddc45aab 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
@@ -27,11 +27,15 @@ properties:
     items:
       - description: board XO clock
       - description: sleep clock
+      - description: Gen3 QMP PCIe PHY PIPE clock
+      - description: Gen2 QMP PCIe PHY PIPE clock
 
   clock-names:
     items:
       - const: xo
       - const: sleep_clk
+      - const: pcie0_pipe
+      - const: pcie1_pipe
 
 required:
   - compatible
-- 
2.41.0

