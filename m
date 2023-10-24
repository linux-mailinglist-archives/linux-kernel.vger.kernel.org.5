Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8D87D5D32
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbjJXV0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344302AbjJXV02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:26:28 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41929A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:26:26 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9d922c039so41722545ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182785; x=1698787585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPMghuwp+tPA5DuqxMPybyD0q/nbyVUGg3y+BUmnhAU=;
        b=JCf9bsc8gsFmYEEN5FA/Mq1VcLZntjYOHPWNQUlkZ1hEP2lhwV9dA9Nr1muGijf7zm
         h7xEERbar6T2fPjFtWySQBQNVEKyNkWEUR4t5moPvQRcQztfiYcwcp9zso+sZ9q2p1iu
         h04Cw6fXmgVMKLJvO8Bj16FBULE9whIKqqo/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182785; x=1698787585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPMghuwp+tPA5DuqxMPybyD0q/nbyVUGg3y+BUmnhAU=;
        b=ddCaA+XTUh37ZWTBjRZhT4vozrzJ/xeVIsA4k4U67IAEWBCRXV5PYgF76wkwpmyKsv
         oq+YX3MvT7JIKXvrDwus+ueuz4FL9Vw3QYcYtJ4VKk4/O3iQe3mQStnTrEsLg0Jk3Azz
         1dSeen2Q5Lb+UueTOtb5fNv4trVy3dOtNEVd0W/DlhWH0l1EVdhZ1bXlsS7URwDJu60K
         Q/RfAkCdDnlesgUOGynnzJW2gvC48cwN9wFzDF3JRHAADUnT9bJjJTJs3Kem6CMkB6Yc
         Q8t8EVUivS9RzMu1wVxRmN4KK9M6ncBFxQfJf9Cnobvm/d7Ir/gq0w/MBjeuBQOzeOl4
         DuWg==
X-Gm-Message-State: AOJu0Ywy6kZyx63REX4leC2lHsOiA67wEcql7PHK/iTO4kFqGjCz0h7n
        1CLkAU8vdouEH+c/M+dykdoymw==
X-Google-Smtp-Source: AGHT+IFmCsigqtOmK3pF3vfTppVXjAMhmh8TLrWxud/qg3KLT70MRIgtqngZr0IQmbvT4J7nmCwjDA==
X-Received: by 2002:a17:903:200b:b0:1ca:8e79:53a2 with SMTP id s11-20020a170903200b00b001ca8e7953a2mr12674948pla.46.1698182785720;
        Tue, 24 Oct 2023 14:26:25 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:5a2d:c345:7f3f:d26c])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902e74900b001b850c9d7b3sm7824140plf.249.2023.10.24.14.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:26:25 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/7] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-katsu
Date:   Tue, 24 Oct 2023 14:22:24 -0700
Message-ID: <20231024212618.1079676-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231024212618.1079676-1-hsinyi@chromium.org>
References: <20231024212618.1079676-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add katsu sku32 and sku38 which uses different audio codec.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v1->v2: non sku38 is sku32
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index a5999b3afc35..4fe58cfe6f1b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -235,6 +235,13 @@ properties:
         items:
           - const: google,kappa
           - const: mediatek,mt8183
+      - description: Google Katsu (ASUS Chromebook Detachable CZ1)
+        items:
+          - enum:
+              - google,katsu-sku32
+              - google,katsu-sku38
+          - const: google,katsu
+          - const: mediatek,mt8183
       - description: Google Kodama (Lenovo 10e Chromebook Tablet)
         items:
           - enum:
-- 
2.42.0.758.gaed0368e0e-goog

