Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817127ED600
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344909AbjKOVYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjKOVYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:24:46 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D6792;
        Wed, 15 Nov 2023 13:24:43 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40790b0a224so665535e9.0;
        Wed, 15 Nov 2023 13:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700083482; x=1700688282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=of+hBS/1vxGoQEjHInTVG1yToe4mkNTd0Roy8SORSbI=;
        b=Xylnh/WID/1IFlThce1isxfssE6Rib9awT1A7x9S2KEarKrBIu0QBQYyDS2Vsq3m7b
         R00vSufCFom4n6jghyhEQKu6c4D1IinVwbK/0YUlcyEhr81ZGbH1s49M6sPY3JTWBAVt
         5f4Q2seiS5spRhaMf1tRTR0fii8Kp6wbaQSSmB0d9gABBt9MuOI7ON9S3vb7h93AIOrR
         5D2VjQE58wT7NTS4j7SIiLQygwwwCUu6qK3/o4cAR+sYIalewadqd6ZvvnuOmFpvKlYS
         y1Yr8xWfx1Gs8poQtgtOFJlbCte8bHbditRNpdMHZfLAX15uBvXNJxnyMOEWlTWMB+Gp
         mihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700083482; x=1700688282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=of+hBS/1vxGoQEjHInTVG1yToe4mkNTd0Roy8SORSbI=;
        b=iINzkTZkavj89m5ECeWvbKknp2twhh4HFQ2+MvbdlDdKCozHQp4Zjx0Sk9XJRbTXRJ
         P4JnBWjKqU0VYzUh1K6mfvdsFGdx3hMqcBRWOiKP1Mt4ewxjIvLcPdrG9G925dw7eNLf
         WOcCPFgenlVexxHJMhLnE8M8+y3a1sQAlonBBUayJJLlriLwjYbhjQgz+YWGypjQgRtM
         JdKwUoHOtey6+m8CV7P0MKmKHYnXpePXmoub/e51jEjhU+p4W6BHMyLNYN6r4UGcTFdH
         qWHgZWNArdgF+teyVU90RSko22u7nnPJOSKVocTEOz4XwjnycWdqBkyBVYfhT8z/fpt6
         P2DA==
X-Gm-Message-State: AOJu0Yzup716ebs1CmefJOLAUb8e40dJZV3r/c4vcIsA9bXbr0gNyQo+
        YsUrIiNPFT3BJqn1bZlLV9o=
X-Google-Smtp-Source: AGHT+IFJIW+jb6ynBCWuoASAZ3cq+ntXLe8x7yzBP03ZM2Ch5SgnNh7fTP2ZWadFQUgKPMhtw6TIYA==
X-Received: by 2002:a05:600c:354f:b0:407:8f23:cf3 with SMTP id i15-20020a05600c354f00b004078f230cf3mr11373253wmq.26.1700083482003;
        Wed, 15 Nov 2023 13:24:42 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:e8e:4851:e049:93fd])
        by smtp.gmail.com with ESMTPSA id n21-20020a7bc5d5000000b003fbe4cecc3bsm913621wmk.16.2023.11.15.13.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:24:41 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: serial: renesas,sci: Document RZ/Five SoC
Date:   Wed, 15 Nov 2023 21:24:31 +0000
Message-Id: <20231115212431.32872-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The SCI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
SoC. "renesas,r9a07g043-sci" compatible string will be used on the RZ/Five
SoC so to make this clear and to keep this file consistent, update the
comment to include RZ/Five SoC.

No driver changes are required as generic compatible string "renesas,sci"
will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,sci.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci.yaml b/Documentation/devicetree/bindings/serial/renesas,sci.yaml
index 9f7305200c47..64d3db6e54e5 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,sci.yaml
@@ -17,7 +17,7 @@ properties:
     oneOf:
       - items:
           - enum:
-              - renesas,r9a07g043-sci     # RZ/G2UL
+              - renesas,r9a07g043-sci     # RZ/G2UL and RZ/Five
               - renesas,r9a07g044-sci     # RZ/G2{L,LC}
               - renesas,r9a07g054-sci     # RZ/V2L
           - const: renesas,sci            # generic SCI compatible UART
-- 
2.34.1

