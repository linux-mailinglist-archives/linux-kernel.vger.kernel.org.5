Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7445F7B2BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjI2FnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjI2FmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:42:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BD21FFB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:40:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bf3f59905so1797801566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695966012; x=1696570812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxy7hugg4UkryDIMa4s8AtATMA0VYhplDs86iw31hOQ=;
        b=TriGYrBVLhtzjt/qVuKHXdAC7luqvSOjmTLUQHKBKaYAv5ZX+RzF2/DSL6a/bfyKoa
         WHIWc4Nue/6Ned/qZxcnv9Vn5LXkvL9lMktBGBGa1f5MFaRKH2SUWZfws4yAxd8uPWb3
         kXraV8MCxzBlryIVCVTDjtDcVtT9pXBirW5ZYnq7VVjm/ZA4BGndH0Aozf8kSaviXjee
         Z93gxC32w07nHE66X5VJELXqUsqi7uKCbUb98pTj1VhLyAhlAQrJEfeBwcPmmDL5NcND
         4u2avJKFpb/JmQMmviPyf9OjKQXQbPzD2jpNNdpMdfVnNKllbHAcVzAFrcYQMAkL5UHE
         G62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695966012; x=1696570812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxy7hugg4UkryDIMa4s8AtATMA0VYhplDs86iw31hOQ=;
        b=oElo3JGys30vJ6G/gvN3I81x6enpLZcCgzzsl6nzhyT/tdu4q+yK3hIjBbiMcNYygZ
         roTOWDGUzJ1GYG/0fInYc53YjVzwmhBfJ4K6NbWCIATk1nxBtOSt3wsP2wJxnrQO05Gw
         rmy8lBVi18EEKWpphiVQuijqgoh4bFHFe5aLmv/D8ZTG5fRPY6LK4ugXL90Qv1s1D+KK
         ciW4/yX3fEXtTJZHFNMEtKAkhSK4Nx4oJRYTRpQ3wjmLLw5NtWnnhXSh7nQC9Xr+0/7w
         Pz4RBmTzmIn3xgFgatrYiqZ0AEH53vj+il39oJmlWTXcnW028e6Ztzn73g8QfHGOKWHC
         qRsA==
X-Gm-Message-State: AOJu0YyJtcxhxJ33X6Z5EdtH/CFI4s4thQA3wZDzrqrvXXUPT5boGPSe
        OEEFCmTtBNL0x5jZgF+N2Q6GsNvxeOMqBJxO/XU=
X-Google-Smtp-Source: AGHT+IFjdkJ8pv4paZlOJE5w3vxwyMxycLeU7FNfeuTuZ5x96UbobcwdJecd6pVt0Z9PpK2qhSMmPA==
X-Received: by 2002:a17:906:714a:b0:9b2:baa1:5910 with SMTP id z10-20020a170906714a00b009b2baa15910mr3126522ejj.1.1695966012350;
        Thu, 28 Sep 2023 22:40:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:40:11 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 26/28] dt-bindings: arm: renesas: document SMARC Carrier-II EVK
Date:   Fri, 29 Sep 2023 08:39:13 +0300
Message-Id: <20230929053915.1530607-27-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Document Renesas SMARC Carrier-II EVK board which is based on RZ/G3S
SMARC SoM. The SMARC Carrier-II EVK consists of RZ/G3S SoM module and
SMARC Carrier-II carrier board, the SoM module sits on top of carrier
board.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- this patch is new in v2

 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 31d0539bb168..594a7d7a6ee4 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -486,6 +486,13 @@ properties:
           - const: renesas,r9a08g045s33 # PCIe support
           - const: renesas,r9a08g045
 
+      - description: RZ SMARC Carrier-II Evaluation Kit
+        items:
+          - const: renesas,smarc2-evk # RZ SMARC Carrier-II EVK
+          - const: renesas,rzg3s-smarcm # RZ/G3S SMARC SoM
+          - const: renesas,r9a08g045s33 # PCIe support
+          - const: renesas,r9a08g045
+
 additionalProperties: true
 
 ...
-- 
2.39.2

