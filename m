Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BAE804CEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346444AbjLEIsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjLEIsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:48:37 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDBF1B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:48:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3333b46f26aso2621754f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701766119; x=1702370919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GBBOhYI+d0VUyAPFbgIHeqblC7WS3xrkGn9mj7w3QOg=;
        b=U9l3dYf1oUkyYmhOTn4MwC/K+DNjGt62rYE2zROPX1TWFayRR9bEPsD8mW2alPsucI
         O1o+Ff6NWudOER5S2A4P0C3gx5ylDNuUdOrWjI1UuSsKZp9uC4H8C8AamHP5tqar9iqL
         mWdRcV4jNfTLBMZEhinV9kfrwG40qK7gQbtqlBrXRRdIfGG63ZKKPjvUX0yCtN3ma4Ka
         wZYHWHUgwTK9qlgIWfLGQpdjuzyN4FrRkNOlLRSJxV0xs42onYBgRY8wPB/w9tjxVJBg
         Xu7r0lGY0LqxVy6v3VR5TcKOskM34tl57zeNSyx8XvXSQHGRhGHvyb07Xzth3CnD8cvs
         NG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701766119; x=1702370919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBBOhYI+d0VUyAPFbgIHeqblC7WS3xrkGn9mj7w3QOg=;
        b=rrdz7Ag0h9kfzEeU/pj145kWLNn3YBtStBka7eMCTIvlK9siJiTSBiAd/DiX/2lkrp
         t7HYtYUUK8lzt6D0W412ldmjMckuXVhr/dNrzkft2LyG9HDwma7YiLege2jDk5cgMZU9
         HXfybUhiKNZ+t0mE70e1lorUFG9ZyXisza2chdpr4KmmK8nnjbrCbZGcAKhH505dVsG9
         YHuJ4aBPq9mqgTjt9MtQD+ps3CDtxRwmiesJkLNGXlaK3j3saxkr4xyV1p1E5ekXOOr2
         Ac990Ws153ElLDH7gjX8qEaZLEGTE8hutxLmwTqkQLOeROOsrS/4EYB+S7abIRfmqjah
         OL0g==
X-Gm-Message-State: AOJu0YzLdCbj/w6NIBn5+rydbaGHIafsE40h5PE9y/nUucRNk4Y3vwSt
        3FUZOR8mutjY8ybe8fbWP4Icww==
X-Google-Smtp-Source: AGHT+IHdv7OQKiElGBn2/aqaAgE1wrKCNJvIOE4NT14r/t7kzAW4r8cfctQZQsNB8qK+z+rp6/kZQA==
X-Received: by 2002:a5d:5406:0:b0:333:3af7:a4ef with SMTP id g6-20020a5d5406000000b003333af7a4efmr2188899wrv.8.1701766119013;
        Tue, 05 Dec 2023 00:48:39 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id x18-20020adfffd2000000b00332fd9b2b52sm8323097wrs.104.2023.12.05.00.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:48:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] media: dt-bindings: ov8856: add missing second link frequency in example
Date:   Tue,  5 Dec 2023 09:48:35 +0100
Message-Id: <20231205084835.15871-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings and Linux driver require two link frequencies, so correct the
example:

  ov8856.example.dtb: camera@10: port:endpoint:link-frequencies:0: [360000000] is too short

Fixes: 066a94e28a23 ("media: dt-bindings: media: Use graph and video-interfaces schemas")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/media/i2c/ov8856.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
index 57f5e48fd8e0..bd1a55d767e7 100644
--- a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
@@ -126,7 +126,7 @@ examples:
                 wcam_out: endpoint {
                     remote-endpoint = <&mipi_in_wcam>;
                     data-lanes = <1 2 3 4>;
-                    link-frequencies = /bits/ 64 <360000000>;
+                    link-frequencies = /bits/ 64 <360000000 180000000>;
                 };
             };
         };
-- 
2.34.1

