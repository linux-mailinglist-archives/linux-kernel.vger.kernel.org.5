Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBD47ED56A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344707AbjKOVFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbjKOVFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:05:18 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B6C19BD;
        Wed, 15 Nov 2023 13:05:00 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c504a5e1deso905001fa.2;
        Wed, 15 Nov 2023 13:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700082298; x=1700687098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LuzKSdvR1du8T/9eWZvj/7thMH6CYFOCmDm+RmP0jR8=;
        b=axelKK0sCK7Ot2Yo2YxwJoTkrN6kZn7ZzozKCMyTMxToqLpgPdgE60MIyxXqpC5BpL
         jAd5T4ULuRKwy37psk0dLsGwjQ3MMrx2P/MrgUYXADPib6D7FQxf4+PKW1C05kkW4dil
         hNkSnJwnZW4VhBFEyEmRxtf9PRSaQDsaBRAZoKAyeeE4LPOSEHAmpSunJYCT2vbrd5Cu
         RGmjsC2ZmI282i4MouErT6i7A//Y2wc6w4FvACKUqCd3elGwSanj30VCu9RQ40BC4q0F
         kWuGNfud1xHqA4sThGexuwy2rYDx2RUbmhPujB3IdgliG9Qms+uW6hJPFV5hkNcZAtGw
         ijIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082298; x=1700687098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuzKSdvR1du8T/9eWZvj/7thMH6CYFOCmDm+RmP0jR8=;
        b=FlpOZ4kvw3vyG6TJixCiIWGUylaiKlRzoTrucFjgnoRH+4P2NLMNIoiE/Twv8l1a93
         YWsvC9nCXtd3ancgZ3GLVgIRzdSViIxqgMYboZ50aS5FaoT7dCyapDN+rvMRSzWJzV3s
         pnZ6NOhqX0Ec9+2Z5BvLeVektQxTF20nSxCH7UhcjVdq/Dghz4WzX0xZVZa3W6GjhZmB
         y2P6At0oCz5YMrVeFaRmgcf0XsxU4RzjHTtOaWHD34hLmObVYczHR2eN2sXk/4EYl69q
         u2zzlwQgSiJb0Aag5IIA5v0TaJboYY0PSrFsVcREhIulvCsBTTGK/O6Ivqzk4oMQNVR7
         uZLg==
X-Gm-Message-State: AOJu0YxX5YYxvaIVSX0DkRUgKhvvi8ZarCPLAvAf6kZBjzNJ56SRKb8Z
        yXPXjFIX3Mtta9RrjhdQeqVPTQWnTqk=
X-Google-Smtp-Source: AGHT+IFlYTBjGqhKEE5ak9EXGj1yavpZnydYl0Gaw2fiSKDF+4KFkGqGr7TmKt0+hjqqzZpQZhcmlQ==
X-Received: by 2002:a05:651c:4d1:b0:2c5:17c0:cd53 with SMTP id e17-20020a05651c04d100b002c517c0cd53mr5905903lji.42.1700082297892;
        Wed, 15 Nov 2023 13:04:57 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:e8e:4851:e049:93fd])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b00405959469afsm909249wmq.3.2023.11.15.13.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:04:57 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: net: renesas,etheravb: Document RZ/Five SoC
Date:   Wed, 15 Nov 2023 21:04:48 +0000
Message-Id: <20231115210448.31575-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The Gigabit Ethernet IP block on the RZ/Five SoC is identical to one
found on the RZ/G2UL SoC. "renesas,r9a07g043-gbeth" compatible string
will be used on the RZ/Five SoC so to make this clear and to keep this
file consistent, update the comment to include RZ/Five SoC.

No driver changes are required as generic compatible string
"renesas,rzg2l-gbeth" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/renesas,etheravb.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
index 3f41294f5997..8125e9023e8b 100644
--- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
@@ -55,7 +55,7 @@ properties:
 
       - items:
           - enum:
-              - renesas,r9a07g043-gbeth # RZ/G2UL
+              - renesas,r9a07g043-gbeth # RZ/G2UL and RZ/Five
               - renesas,r9a07g044-gbeth # RZ/G2{L,LC}
               - renesas,r9a07g054-gbeth # RZ/V2L
           - const: renesas,rzg2l-gbeth  # RZ/{G2L,G2UL,V2L} family
-- 
2.34.1

