Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7863877E010
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbjHPLNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244106AbjHPLNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:13:42 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD956E40;
        Wed, 16 Aug 2023 04:13:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6887059f121so1042400b3a.3;
        Wed, 16 Aug 2023 04:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692184421; x=1692789221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm81nC8rB3VzLel+OfuFxkON060dPDiSqreycVsTwMo=;
        b=eubpGZKZdtUlDma5v7VtzST+cwk5d89BRRi25Ui5cEJgyyotGtOn/Anu3WIKjD69aw
         JkFWTpZtf3OYhv+NFaFNkz2DWqlVapx5pzDmWzG3MhDeCdMeRlMqknQ9CxC+RfQAbnCo
         1XtjhvT6+rV1wriU5/vtfTDHaAdIQ0gA40/PBRaif6u5znE0gumRqgi9+W5WnBmV0bxE
         wne2iRqwakHXPbVUwtktI9tkgE67IDockIxLR9JQE1uqu42yGFyettbQQozrWbLMvz3b
         2B/yT+i8LBo1ol5Y2pVzVSDMWhjWm+QGq1LKFPqrClNqYYVLC3Tfh2JrHq5TdorUaIVH
         oM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692184421; x=1692789221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qm81nC8rB3VzLel+OfuFxkON060dPDiSqreycVsTwMo=;
        b=WxD/mpUOErWiJgJkQdn3L+UgMzh2m3jUVXozm+ap0zPALsb86zhmIHEb2DLQbPAYST
         l85FXbrBwwHHPt0vfANWZYgycZu1SLXXVoTF+rRipA6GMXI0Tm6ELwl7tnagnphY0VTL
         A7eFRBfCO+p4FOnWj/BDpEmdkVt7VtaiE5yXRF8u5NcDm5N2JgIBHsFJLVMPo0HpsG4B
         uu7oHmvk72WXNWpcNfsfoB2zp7KWTJ5wM5xk6IWWb8GVfQdc0QlGdRa4PbkBiipRU2x6
         Q3QxVBYTNCEMg6StfrCDKNm2i0HxlVWYPcl28yeSVaLV8pg+h6lRPR1FJIJy2WdZ6pk7
         3Lfg==
X-Gm-Message-State: AOJu0YxlNoyQbYENiJoOZVFSbZmqJX05T2g5C6Cq2I7m1hfV9toLf/F4
        ftWOcPgDZnBYkjVtGm4daIXGYjADE9zS0v7V
X-Google-Smtp-Source: AGHT+IHp/UBlrm7Wmg56gTJI2NUyWBp3UP45sEbs7ElgZ4/A+1ZkHovpiIKiJuh25Vefk0Ws27spbA==
X-Received: by 2002:a05:6a00:130d:b0:682:4de1:adcc with SMTP id j13-20020a056a00130d00b006824de1adccmr1733294pfu.12.1692184420705;
        Wed, 16 Aug 2023 04:13:40 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id r8-20020a638f48000000b00563e1ef0491sm11750627pgn.8.2023.08.16.04.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 04:13:40 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
Date:   Wed, 16 Aug 2023 19:13:07 +0800
Message-Id: <20230816111310.1656224-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816111310.1656224-1-keguang.zhang@gmail.com>
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
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

Add Loongson LS1B and LS1C compatibles for system controller.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Make the syscon compatibles more specific

 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 8103154bbb52..d701fff02abe 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -49,6 +49,8 @@ properties:
               - hisilicon,peri-subctrl
               - hpe,gxp-sysreg
               - intel,lgm-syscon
+              - loongson,ls1b-dwmac-syscon
+              - loongson,ls1c-dwmac-syscon
               - marvell,armada-3700-usb2-host-misc
               - mediatek,mt8135-pctl-a-syscfg
               - mediatek,mt8135-pctl-b-syscfg
-- 
2.39.2

