Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184C878CABD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbjH2RSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbjH2RSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D5910C4;
        Tue, 29 Aug 2023 10:17:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99cce6f7de2so609080166b.3;
        Tue, 29 Aug 2023 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329447; x=1693934247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwaGmtZUPA/dwS41wMl1NXhL27pNtpsYsBs+oXIwgzU=;
        b=HWwZSJR7G5j/UlzgJ/xk2k5cG0brSXt+VPqGoGnypzwtKwlkY10UxvRwUP+LqtPTLb
         /gSA3sT/uvZwI16Ta7YRBOgqw315u4p38rJzQ1ARmo41k3TgI5bh9Q+2NYWq20txZ46j
         mNrmVV6dQrvyn3tWzsy85kHN3SA9rjmJySwAlKu+cRXAnYBTfZTXyqHEjmUpfORjofM2
         bJvoWqHaoFrHmL+gIQClU6YikQJUwBQraSsVNwP9bLl8qVZCVa4J9tBF0LJedLPNFf6s
         3CAeOwU/qcU9eUyUvDzocAqVbWYEyQIbo35bgDFKUnm1gqcDXkeTQQdfzncZ+h/VFzdM
         S3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329447; x=1693934247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwaGmtZUPA/dwS41wMl1NXhL27pNtpsYsBs+oXIwgzU=;
        b=RRJbXSYwqBBM6Bm3IAWAGorydjSfKLdd0Qpf+Kq0JHeURPL1ufBZJ3lJQLLrCL7BqJ
         MrDnHQfxnJF1RmUdlC2v5sOqf5Uk3XKyWmrqltbjb1aXFS1F9LO/gNF4UdjHkTBEOhg0
         UHtVuIK1Z6hsIUtCoRO75meTf4y03hm6+adA+ux/dL6I6QJFQaI+RkfRFrxCklE9Q6o/
         fChmhrteJpKhiVsHc1h/pt8QIXcvNxSrJylv8I/BmsUbHtk0DQHdh3unus1CLh7pRlEY
         zjtXePWyDkAovTbmslzz+cPwtceX99aTo1TM1ESoxbY2vA9NlDEQHp75QsUg8C7GHFI7
         apgg==
X-Gm-Message-State: AOJu0Ywxx57jBUFLt3mKiWJbpCJpgYkc05H9zATGVHp5z13HpX6enI/p
        uJ8k0ynlYcC8TmCCyYYTH/HuQHsQSQ==
X-Google-Smtp-Source: AGHT+IHgDpcosA9S74bQEeR2hEnEpLMTHmHxkazGsrlnCTREbmknY2DDkcIyWAd5FuMN90wtDYQDVw==
X-Received: by 2002:a17:906:3195:b0:9a5:d657:47e8 with SMTP id 21-20020a170906319500b009a5d65747e8mr1405316ejy.52.1693329447156;
        Tue, 29 Aug 2023 10:17:27 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:26 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 03/31] dt-bindings: ASoC: rockchip: Add compatible for RK3128 spdif
Date:   Tue, 29 Aug 2023 19:16:19 +0200
Message-ID: <20230829171647.187787-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829171647.187787-1-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for RK3128's S/PDIF.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
index 4f51b2fa82db..c3c989ef2a2c 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
@@ -26,6 +26,7 @@ properties:
       - const: rockchip,rk3568-spdif
       - items:
           - enum:
+              - rockchip,rk3128-spdif
               - rockchip,rk3188-spdif
               - rockchip,rk3288-spdif
               - rockchip,rk3308-spdif
-- 
2.42.0

