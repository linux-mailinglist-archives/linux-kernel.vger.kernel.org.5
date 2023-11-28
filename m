Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E057FB1C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343628AbjK1GLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjK1GLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:11:22 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB99C4;
        Mon, 27 Nov 2023 22:11:28 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cf8b35a6dbso37380945ad.0;
        Mon, 27 Nov 2023 22:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701151888; x=1701756688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WilIeTT4aPVtkzqmbVOzffelzxGMsBk9SQwUslLNDU0=;
        b=HrEbRRh6B2rJhhbHCEPaLihY6NNO79GQboZtFQ70OT7t1LF0IE0FrOrrvB8NH/Pnro
         FOcQvQptuoOqA9r1ie4NwgRY9oyfltwMUyz2Ee9AnVmKBHs9KzskVyELC5giSFznwajr
         aAhcrxa6g7qVjOm2CmTYRIy9/O3DYYmKKbWKMo2MgMDaHNs/NIObyEW/Sp4jqxUPz8CX
         DXyAmmZKK1STiXb5asSAqSFkfnW1vddsf34MMqiTJ4/T7Xj7p2QUsswFWGmJWyrPP3PI
         8Tu8ZN9m7HxOuYX7X5G5Y93arzhLInKGmbMbzTFJGxFfxFSkazw6omklqtlSlM7oGfU8
         5VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701151888; x=1701756688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WilIeTT4aPVtkzqmbVOzffelzxGMsBk9SQwUslLNDU0=;
        b=cIIWatzLTS4YDKJuNnD8Ipl7+4tgWJbhI5BP8rho2ZuD/oUYIYip0ZFEy9Y8rWUXip
         esjOrwLixf7bBYcn/yHDCxzdQPYBsFdjLpDsWffrZWVD5+7Zqo3aJ6FiHrjgEUX0hRLB
         inROU04QQB6Z+oEVFQ9PdcwmIJwnxuAza+QpXxYvBeXDTNaQ8TOJOfeKDd+9Y7xXbHz0
         1/Av6Ha0SPZj066C/YKIOm31ket0SQgEwG/X4MAGyUkh3t9EN9YVb0pTqxks1xWifveQ
         a+Unprsy0uPXT843PSbl44qhG4hdZ5UXEEbwbrO26yeZx6/H9T+NF2ISh6YW259Jy9ZE
         MS4w==
X-Gm-Message-State: AOJu0YyphpYhVaiRSg0ISBRg04qN5p3EV/HBiFk2TJkAT3v6BuAQgAiL
        nELED42hZim3Nm/Op2EAovg=
X-Google-Smtp-Source: AGHT+IGJNunGEFgwsSsLRBm8NiscZ8xBnplJFN66CtUNkHSUigRrAaTF4biTHW0Nm2Qw5HMoRdpVDg==
X-Received: by 2002:a17:903:183:b0:1cf:55dd:9a0e with SMTP id z3-20020a170903018300b001cf55dd9a0emr16134453plg.15.1701151888123;
        Mon, 27 Nov 2023 22:11:28 -0800 (PST)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001c73f3a9b7fsm9402694plb.185.2023.11.27.22.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 22:11:26 -0800 (PST)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
Subject: [PATCH v2 1/4] dt-bindings: reset: Add syscon to nuvoton ma35d1 system-management node
Date:   Tue, 28 Nov 2023 06:11:15 +0000
Message-Id: <20231128061118.575847-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128061118.575847-1-ychuang570808@gmail.com>
References: <20231128061118.575847-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add a compatible 'syscon' to the system management node since the system
control registers are mapped by this driver. The other driver must access
the system control registers through 'regmap' using a phandle that
references this node.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml        | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
index 34c5c1c08ec1..3ce7dcecd87a 100644
--- a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     items:
       - const: nuvoton,ma35d1-reset
+      - const: syscon
 
   reg:
     maxItems: 1
@@ -37,7 +38,7 @@ examples:
   - |
 
     system-management@40460000 {
-        compatible = "nuvoton,ma35d1-reset";
+        compatible = "nuvoton,ma35d1-reset", "syscon";
         reg = <0x40460000 0x200>;
         #reset-cells = <1>;
     };
-- 
2.34.1

