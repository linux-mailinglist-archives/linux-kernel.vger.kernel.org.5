Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3716F7D43A0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjJXAHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJXAHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:07:33 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9269D6E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:07:31 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5b5354da665so2089989a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698106051; x=1698710851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh7y/+UHR4rfaD1MdlnQhy3jizucTRA5pP5JKPfuUQY=;
        b=nrkN6uCNYGxPAFIdUxs7gefv8tQ8Tv8Ckk4+2vKLmZqcgbfXZTgrEA+0pctk4Y1nQD
         445mu0UyzNm5pLsuo0WeUdIVI/vqwt1sgYyhGMDeeNMRD+38TJUvnm92MEpsNYP7qLjd
         uG9yBBRyMrAv4g3a0II1Ww3Y7PXivuwxoXW5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106051; x=1698710851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nh7y/+UHR4rfaD1MdlnQhy3jizucTRA5pP5JKPfuUQY=;
        b=kQ5a9Re0u5H0z5ysJXgjvV8eufA/gX/w4sxKgMgOSK7nRNuTU/dvwd415iGmReSq/S
         dxYMPauKpkrUGGpeqUJ0QuQTVcrtLNAnqqIomAbVW/bugnkux36tu5Q1Gj1JP5LAgfxZ
         VMozGeNkkSAlBbJhJ/ETIATL+/FLh6rJO565h/JSZQJZ+zobJyGAVDrt9xHr4opG9Kbm
         +bcC4Pby0oSKzoL4tXfn5GXrDMRivT96Em07Wgx8K8GekJdvnnbYjG6WR0lPGvkzQpHe
         bdqUzjXKAHreD5INeOsjQtB5WQHUuSV56vrXdXNHYW5WxPmKP4gE78XaREhscQiqJgOz
         iPAQ==
X-Gm-Message-State: AOJu0YzqqjWCpJYEGOLUGKou1zxO6/Ef1LoXu21HULAkkrVCrdNAvZCy
        tPBOe1Oyf7eGebymzH6wt2cJ/g==
X-Google-Smtp-Source: AGHT+IEnbELuJfwTbSKJpQL3L82YAF2nHCHHuweCeoPOIKHXo8oxA5ZYmCAL+Ez/OQucHg3ovI5ADw==
X-Received: by 2002:a17:902:ea09:b0:1c8:9d32:339e with SMTP id s9-20020a170902ea0900b001c89d32339emr8959999plg.50.1698106051216;
        Mon, 23 Oct 2023 17:07:31 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:5a2d:c345:7f3f:d26c])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ecca00b001c5dea67c26sm6505510plh.233.2023.10.23.17.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:07:30 -0700 (PDT)
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
Subject: [PATCH 1/6] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-katsu
Date:   Mon, 23 Oct 2023 17:02:24 -0700
Message-ID: <20231024000724.57714-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231024000724.57714-1-hsinyi@chromium.org>
References: <20231024000724.57714-1-hsinyi@chromium.org>
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

Add katsu and katsu sku38 which uses different audio codec.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index a5999b3afc35..fe8c488a3207 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -235,6 +235,12 @@ properties:
         items:
           - const: google,kappa
           - const: mediatek,mt8183
+      - description: Google Katsu (ASUS Chromebook Detachable CZ1)
+        items:
+          - enum:
+              - google,katsu
+              - google,katsu-sku38
+          - const: mediatek,mt8183
       - description: Google Kodama (Lenovo 10e Chromebook Tablet)
         items:
           - enum:
-- 
2.42.0.758.gaed0368e0e-goog

