Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AAF7BC5DA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343755AbjJGH4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343739AbjJGHz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:55:59 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB3BA6;
        Sat,  7 Oct 2023 00:55:54 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ae214a077cso2104444b6e.0;
        Sat, 07 Oct 2023 00:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696665354; x=1697270154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyz/NFb2RrzFYehpdBMm3ykpV/RwzR3J4zJlz09rB0I=;
        b=Hpf+sDwC3ahfBT4ZTVYe9Eq4BFV9YKwzsWK82Nf3CfR4Uift4S71mvhjczcmKa3EGG
         x+2O+cd5qv/m8XX4fJEba8DbWgg0tbbDj7fJSVaSIFCAQZTCD3o6PqE7h5PYdTW04KaH
         Uwu/XNdRGfq7ztxSDt3VS6UeytQdpx5uJIUBFKE2aF4mzjh8zkTW5rPhzV6UfoLOMAPE
         k8Tpw1WbsLKoU3dM+Q51UYSmjPkr1tEyBl3IeEZ8P+Ufwem2g6EzvywnV1PeTkp+xmGF
         iU+m8yQnOmEyySz9T0z+3oMCWTKR8wxUcneHIIhc+wlpzF8MOC7hZL6ub769KVl80sHw
         U9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696665354; x=1697270154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyz/NFb2RrzFYehpdBMm3ykpV/RwzR3J4zJlz09rB0I=;
        b=V0+BEYLHm5R5N71O0XvHP4IC/x3oY6VMLN2Zms3fjiCqy9b7OBzPqKDI0LoQ/Z28Oe
         Vyzyq6AaYUXv+udvNG8wxqd7Zj6Aj+WGta0R1AHr4pQ3891JUJRjewjr6aXq0DYyUSW+
         GPSy145yRM8tSHiqczBWpZ0qE7daeddMTNt4RS/qZffu9vBzZWGt3Pqcg7fSxQaY9qE1
         nszEEfATjYLQ6cvasveTeRwAfefqCOArxX59r6qCAt42OsgKxp/7Yer0i2Ni5ebr8kOA
         SVjQysTagBZ/+ryLZv6SfRNDpip6uSYZVeRfPgnmf6phDbyfvSvduZe3Jht4tHTru45m
         Etvw==
X-Gm-Message-State: AOJu0YwaaKjlCZhQg2v9QN1eTDeiQfDsn/jE8eLPTzIxNU14M1zhQklX
        co3bLWn+905PNazfWObHyns=
X-Google-Smtp-Source: AGHT+IFtQR7vQoLjtYMGn4gNnfGRwBQWdenp2J6GsNGMrzno8OB6IiiSMFDAZeL3agfFD/JQvctO8g==
X-Received: by 2002:a05:6870:d1cf:b0:1c8:d334:a6f5 with SMTP id b15-20020a056870d1cf00b001c8d334a6f5mr12551879oac.7.1696665353690;
        Sat, 07 Oct 2023 00:55:53 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id y20-20020a0568301d9400b006b871010cb1sm858758oti.46.2023.10.07.00.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 00:55:52 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 05/10] dt-bindings: interrupt-controller: Add Sophgo SG2042 PLIC
Date:   Sat,  7 Oct 2023 15:55:46 +0800
Message-Id: <c639a1cd1e09c908c44f14d2156b643e577f0831.1696663037.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696663037.git.unicorn_wang@outlook.com>
References: <cover.1696663037.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wang <unicorn_wang@outlook.com>

Add compatible string for SOPHGO SG2042 plic.

Acked-by: Chao Wei <chao.wei@sophgo.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index dc1f28e55266..16f9c4760c0f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -65,6 +65,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-plic
+              - sophgo,sg2042-plic
               - thead,th1520-plic
           - const: thead,c900-plic
       - items:
-- 
2.25.1

