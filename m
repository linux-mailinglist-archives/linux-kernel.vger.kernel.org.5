Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D5A7B54F3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbjJBOKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbjJBOKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:10:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B589B0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:10:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso136234075e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696255836; x=1696860636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V91cYRIt8yJYSOx2f4FKH7CFK9UttvFj+gUpHbgWKyw=;
        b=pn60SBYQaqwGaVUHpjOuTuLTUBL1ISxsU8vXjrNHUAdSeFs1F2FLx5gP4fm53cXl32
         oQEE+2vHpiVBOfRJv1FYYoyRRVt9svfBltNk7n9ExWZsLB1SFKlLcHhh+TpJT8cD/FX7
         fk9zK4KEnnZ51hCHTX6CBh2c54sU5h5boCFz+toZh1iXrZHKs08sBlbPONEGLbTh5hjl
         fW1IkeqlrojC8om3S6f6f3JpgJILBgGt8TGsBSpFegM3NmKSM1iTkbFQloVk+FtWS9Kl
         p08PkPJEQN3/906EcjS250VL/eRdskDj0AqFqnmK1CWc4+485n0xGpSHWHJP22yt+dXD
         mEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696255836; x=1696860636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V91cYRIt8yJYSOx2f4FKH7CFK9UttvFj+gUpHbgWKyw=;
        b=BPEQyEINn23Q/rdcaZSlmjgMvX+yxzdnnGAH/Z8DH+LnZOiPqO2hkrwnkwAj9Tx99s
         FSR/S0GtGEnakgOEWgzSK3bzxZIhdl6aZAZh7W96fw5oV55ou7TojFz3OYqhfvipfISY
         SUSRxT5wxLmCDjom4Th7JFbwjTIWhhriuyXdESKEYlRPO5f/scJilSvTq8BhOBrdvtzW
         jdGiW0zTEBdCcfY4dWipXdaVw+q1OHJxSi24mxPA6oW54VGv8vwWe1flA0QDqEcPtbbu
         g4RorWkCAI/IILJ2hMntoWJ6rQhSJu5jBGiBt3hGaWJ9L3NQcTzaJ+Ycx+FQn3/UpCpd
         cS0Q==
X-Gm-Message-State: AOJu0YzKJkY6vFTz7jV/dGWoigHFUmcQT8+lWvboSl9BCPa9WQvK8frQ
        S1IIzwpK/FW05Iqb0rrlKf3XXA==
X-Google-Smtp-Source: AGHT+IH12gMfHz+WiKvadwSp8NrQkbn9hq0VDKvMaeWJbbqRL8bgMgmJ4ZngnP0ASA8/U+F6q3Nr3A==
X-Received: by 2002:a05:600c:255:b0:404:74e3:27a4 with SMTP id 21-20020a05600c025500b0040474e327a4mr10414923wmj.40.1696255836595;
        Mon, 02 Oct 2023 07:10:36 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:fcf2:65f1:853c:13be])
        by smtp.googlemail.com with ESMTPSA id k3-20020a05600c0b4300b003fe1fe56202sm7361911wmr.33.2023.10.02.07.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:10:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Da Xue <da.xue@libretech.co>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add libretech cottonwood support
Date:   Mon,  2 Oct 2023 16:10:19 +0200
Message-Id: <20231002141020.2403652-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231002141020.2403652-1-jbrunet@baylibre.com>
References: <20231002141020.2403652-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for the Libretech cottonwood board family

Co-developed-by: Da Xue <da.xue@libretech.co>
Signed-off-by: Da Xue <da.xue@libretech.co>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b7b0eda4164a..caab7ceeda45 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -155,6 +155,7 @@ properties:
           - enum:
               - bananapi,bpi-m2s
               - khadas,vim3
+              - libretech,aml-a311d-cc
               - radxa,zero2
           - const: amlogic,a311d
           - const: amlogic,g12b
@@ -196,6 +197,7 @@ properties:
               - hardkernel,odroid-hc4
               - haochuangyi,h96-max
               - khadas,vim3l
+              - libretech,aml-s905d3-cc
               - seirobotics,sei610
           - const: amlogic,sm1
 
-- 
2.40.1

