Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C6B774249
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjHHRkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjHHRju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:39:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BD883E1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:17:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9a2033978so90744501fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511392; x=1692116192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OSNGkojbT+FsqpoKjJ9301dnAVYJ8YQV267IqvAEoPU=;
        b=grRAz6Jxfh2Nt12MkkdB9M0JiRacmg5Z22mgVg/5AHqDqncatY04PICZWinW0soI3L
         DwxSVN1Z9JUYvn/mGHjgL+8u1g1svmlG1hpcBZV+G4pJ7fM8PTZ5Rrb2ly77ejhUcoOf
         ibF71MyySfxTP3/UwvHeUG31o29YwwnU6TVP8IWocPH7cJtqJs/M6nK3tgSXlSJQAclf
         iMjQbtP86tfRy7zjs7leEG9DzdnCn2swJKrzVOJd2cpvFhPFVp/HUYAAcDhtT4OPGJyZ
         lw7FEghTHtYwczirHiArYYA/XoL1YA7tYgCmyaGpx6S7gYCPTW4s1KW6Lsw6LJ0cQHkx
         mYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511392; x=1692116192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSNGkojbT+FsqpoKjJ9301dnAVYJ8YQV267IqvAEoPU=;
        b=DjCeqoRJ/q2f4+NBrn8pe9SvfUvy8tMmqjYBM0OSdCS5vXdl516mt2TtOwwK+1JSO4
         qHr0Axwc/7r5HU9bXvejSe9/bItnxGvMXuOk5vFGTUWqTu7e8OwtG0Bfz9Fp8vrQ4dpf
         jYXI1YxTBOGNxNgsN7VAWX2QIytAPk2N+k8rB1cvnuKEYc+wfx6/uAJ+GyiLPlL4Ytww
         uPgIrNduU558yvA2XJjUUZkTW4YKINC8Jkrcgcw8EV37CO4kD2VOwX3F/qUbKJWp3f+M
         2C3WPtXNQVZZia1A+zTMzaRHIvG9jZgA4kD9atKxAiYriR1+BZXBzWMZoh7iMXqbiZXK
         dsBA==
X-Gm-Message-State: AOJu0Ywlqr7NTLwcERug+TajgS5iEfSvrqLAn8Hs7mWMgCvqNFOLbavs
        wdB63b9BtQlzHu/DxTTzGvKZ3umXMEf6s4HcB8s=
X-Google-Smtp-Source: AGHT+IGBUM9Eb5+0TWgDLF8LmOhVhKOR18zw7z8Wucg5zDszfG4kbd1nLl37Ej26nZOXcXHoLMXtdA==
X-Received: by 2002:a1c:4b0b:0:b0:3fe:2b8c:9f00 with SMTP id y11-20020a1c4b0b000000b003fe2b8c9f00mr8459725wma.24.1691476346737;
        Mon, 07 Aug 2023 23:32:26 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id z22-20020a1c4c16000000b003fbb25da65bsm12705726wmf.30.2023.08.07.23.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 23:32:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: rohm,bu27010: add missing vdd-supply to example
Date:   Tue,  8 Aug 2023 08:32:23 +0200
Message-Id: <20230808063223.80431-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings require vdd-supply but the example DTS was missing one.  This
fixes dt_binding_check error:

  Documentation/devicetree/bindings/iio/light/rohm,bu27010.example.dtb: light-sensor@38: 'vdd-supply' is a required property

Fixes: ae8c47c51e5c ("dt-bindings: iio: ROHM BU27010 RGBC + flickering sensor")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
index 8376d64a641a..bed42d5d0d94 100644
--- a/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
@@ -45,5 +45,6 @@ examples:
       light-sensor@38 {
         compatible = "rohm,bu27010";
         reg = <0x38>;
+        vdd-supply = <&vdd>;
       };
     };
-- 
2.34.1

