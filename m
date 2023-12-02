Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3103801CBE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 13:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjLBMwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 07:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjLBMv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 07:51:58 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96959184;
        Sat,  2 Dec 2023 04:52:03 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1915034144so343829166b.0;
        Sat, 02 Dec 2023 04:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701521522; x=1702126322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TpM4rIE4qqT65pAaY9eqEHRHauyEUGalgmDwr8uKk4=;
        b=DvzB+4SVvaZ5E7kgZq/vNnIrEy7ZKY1oIecH8mwiuMSBafsNMYf8C/8SPTd8e6gCHO
         W686GAE2pYDYdj7Y7XO00+4TsjmVUthBfuWdYmoXch4GXhMrIBc3EjxeuVUI/EMQM3Xv
         OCG9ogq4RZFyPoDX4qw3NTss7qFo8/ZYlbRE7T6oYk68wH63r+QSDDYMoF/hhIHH1d30
         bPYVTPE+iyRqaGxPrjVa18J6bu1GBFp9gsmt5Tqu0bXKyZkf5FGyU2dumFe4dZXcMga1
         l54PUu3uyfgX3yaRjSJ4jWlZ0sZZPmiNm6XcTnqenPcqcIkc1UgtlxNJZnBoHInHubxY
         ja0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701521522; x=1702126322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TpM4rIE4qqT65pAaY9eqEHRHauyEUGalgmDwr8uKk4=;
        b=nPk3HkSMg7+1xTS1nnWztwXE/TSmfEjMJCLJ3yz4oXoyrDf0HqIu7/zQmQWecnzqsf
         bSVYGQ4deXZ03OTIRcZCjqGivuggr0lbmQkUqWJ3nprl2gr6dn+KcVDrRnte9ifLgA/Q
         mOqxvCFyKqOE58bqmuqWW2d5oDeJ8PfS9JJAd/+O5xkA4tEoEbh5I1aw9jijIeAj2Bsq
         BA81wbji/07e/SxfwoV8wK1i+QJkQFzI9B5JwYEwiyQZSx/c6wSXC6Bp6AmMWVn40Hel
         nZfoCQw8DWiI82BLP+PmpfIeW6ks1S+LXd9WQtTfafuXR51GClah0OASa2nJCzs4iPLd
         YtjA==
X-Gm-Message-State: AOJu0YzTcR93AN9jRRVR2d4hnB5YUxnxl+mgR0jgKhoom1xz/Dmy6Ex2
        xM4AmqNqvujgh9nAra4Ty8oFniz8yQ==
X-Google-Smtp-Source: AGHT+IEyleq1fwiEbFjEWs4F50ggLLxGB/KOmVoOHqA2365tzKaQw281kj2swtpYsUJqACRktkUtTA==
X-Received: by 2002:a17:906:3b43:b0:a16:92f1:2f47 with SMTP id h3-20020a1709063b4300b00a1692f12f47mr1536630ejf.57.1701521522024;
        Sat, 02 Dec 2023 04:52:02 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:908e:b829:354b:f8ee])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906198500b009c5c5c2c5a4sm3018161ejd.219.2023.12.02.04.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 04:52:01 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/5] dt-bindings: gpu: mali-utgard: Add Rockchip RK3128 compatible
Date:   Sat,  2 Dec 2023 13:51:42 +0100
Message-ID: <20231202125144.66052-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202125144.66052-1-knaerzche@gmail.com>
References: <20231202125144.66052-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip RK312x SoC family has a Mali400 MP2.
Add a compatible for it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index 0fae1ef013be..abd4aa335fbc 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -29,6 +29,7 @@ properties:
               - allwinner,sun50i-a64-mali
               - rockchip,rk3036-mali
               - rockchip,rk3066-mali
+              - rockchip,rk3128-mali
               - rockchip,rk3188-mali
               - rockchip,rk3228-mali
               - samsung,exynos4210-mali
-- 
2.43.0

