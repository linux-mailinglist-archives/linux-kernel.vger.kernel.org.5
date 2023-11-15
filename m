Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A989F7ED5EA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbjKOVSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjKOVSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:18:45 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11EAC1;
        Wed, 15 Nov 2023 13:18:41 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so1032781fa.3;
        Wed, 15 Nov 2023 13:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700083120; x=1700687920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ig4LRrmPOfrn/JSeDbvG3vZIgD2UhFkj1Wn3HjDdh+A=;
        b=GYHjSUsD/ZmicPFwYS+yaJoO4lsIHoYmZRWpQ4Rl/Uk2IGVhpKhRQgvyiXqyEqiSjz
         RnWVQFIO6bKCnw+pTkvYDPFYfW1rLVuz5Ur0Tmq35xuNbMEeUFsSQjWpstKFl94jBA2b
         +6IWwvqzQtsB/UZukccPfnSbqrjLFxArvbADNOOmon6F5nwzefGPFZtSCVmEjeVSTegb
         2Pgsx6Z/YvzuggN7y5BmDjxWZiZ9FTdFUN89KFwUJ/f6CZm5k47rfwetLn8uZ8o9Pbnp
         dH5bX2XRM/Nc8AxVFH1crSs1nkuRBE7HR03Pm0eRA7mgpvd7fCHuDVMjBNcdKQ83D+0F
         VJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700083120; x=1700687920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ig4LRrmPOfrn/JSeDbvG3vZIgD2UhFkj1Wn3HjDdh+A=;
        b=HEiQ6fPw3CjX+E0ZHwaJeuV9e9grx8iZg5EGmkEHbnag07HKgj8Qhj7+XzdKgXwzBN
         uf+6BGnueCrZjtO/mqiPikx0a04i93ajX2fZ6oNDKtTQsOqQNFDskf71sVqZp3/thEox
         cmSYJx6rEr2R7YAWVw5n+AN0VxRNIDBczNzIF9CF4zOB4lspcgb3c1IskrVf5md7VtRv
         nYT/33nl90U8eLqkY7DtxbH1ZC8ewHt3zBHbLrq7ZqwMdnxeAtzhnFNSiIGsF2GMb7fA
         a1e1a/zyOoBEMG4FW/rIqGeMVa55LcZ0eSVweRL+SLiCjdwGPvxfhHyxCik6VXZoaBUE
         +ZFA==
X-Gm-Message-State: AOJu0Yx8eRXxdrCVMsAZCjHN37OqzCIw+hz0UxbTGbD9fCfMjO0Svx/F
        LKxxToHDa2ZCJ84qx6+jULY=
X-Google-Smtp-Source: AGHT+IHTScj9ysDRsY7wFK7xItgqWuQEN+ChknevPY+a5J9RpOc9/TQg/lX1D78M7plkN0kvgag0cQ==
X-Received: by 2002:a2e:7a14:0:b0:2c5:f54:2477 with SMTP id v20-20020a2e7a14000000b002c50f542477mr4946967ljc.40.1700083119722;
        Wed, 15 Nov 2023 13:18:39 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:e8e:4851:e049:93fd])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c204300b00406408dc788sm882079wmg.44.2023.11.15.13.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:18:39 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/Five SoC
Date:   Wed, 15 Nov 2023 21:18:29 +0000
Message-Id: <20231115211829.32542-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The USBPHY Control Device on the RZ/Five SoC is identical to one found on
the RZ/G2UL SoC. "renesas,r9a07g043-usbphy-ctrl" compatible string will be
used on the RZ/Five SoC so to make this clear and to keep this file
consistent, update the comment to include RZ/Five SoC.

No driver changes are required as generic compatible string
"renesas,rzg2l-usbphy-ctrl" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
index 731b8ce01525..03c18611e42d 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
+++ b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
@@ -17,7 +17,7 @@ properties:
   compatible:
     items:
       - enum:
-          - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL
+          - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
           - renesas,r9a07g054-usbphy-ctrl # RZ/V2L
       - const: renesas,rzg2l-usbphy-ctrl
-- 
2.34.1

