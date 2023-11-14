Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCBF7EB1EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjKNOOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjKNOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:14:08 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733191702
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:51 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-779f81223ebso9062685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699971230; x=1700576030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5yYxDd+9V9reUvZ2DQpNcNkqEc4BDOdQVkeYdlaxbs=;
        b=MY51Ax27YlLXH6RdZ9FPltzrsU4CjToYoLGJjczl4zoY/6moxzyB2DhkuP9AeAy3tp
         b1o8+5toiyB6L2eS0HOBANnRsIl+zMEXS0gs/+PAdv1nBdMIQdMjQeLS4pFqCqMf+DGp
         l5bkevWMQ9Q50K91C2z9O4KInkCP8O3FwnLufOsaqGoLSAsMsiPMHEE1jJssRBW1D7j2
         eQuNtwCM6C1FaJiabShZ6jQw6i1kUvLmt/oLZZyBqCv0I/OWy2P2Wfz1ZFrf9LfK8EH+
         oQ+cHJvxnA0Uc2tTZfdWkqUoxaq5y3wwkuWO6JeHoTBUWSaMqQremWO+jZzOLEYiDY50
         FjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971230; x=1700576030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5yYxDd+9V9reUvZ2DQpNcNkqEc4BDOdQVkeYdlaxbs=;
        b=mByFM61rvaOQcw9KsaB4OWNr0mUXIb3DmRscpmlYn53VgMP8LlE+MwLY0q+CuLDt+B
         Ij2/0RzgSpHnBpLs1sBrEpW0Riuhe292dqbVDAt2gedy9jmJqNrVAUinnr2i14vtIqTr
         nXHl2Ued4t4bAr2xJNCcSP8moX5ON9lKf/r7h5akDwynH+G+dXM5O5eSWozEpMkJyg2H
         8TstUPKIuOyfbFxTOUo0w+5Rjd/73owZ3IvZxGq5OXamvUo0+ckosLtd7cigUZaqqB5e
         lOs4vcDNEJL0dG/V1MCj3NbCu2tLVM8duKfdNM5u8Gd4afKgpSjmb7sG9socYHT4Axkq
         SRXA==
X-Gm-Message-State: AOJu0Yz3RsYEb2Cp78QlAjiPLO9NccrZlf+cBkdRtXIBs0Iz6R0jAnK/
        Q86V6RPVcHmnQxvVdGxsu+SKtzUbBvKbj83QSLXjvQ==
X-Google-Smtp-Source: AGHT+IFptxx2Guy0DQYVfc+KvtPdCaNrZCEFFfEn6l2iik1hGkFfOg6ndZjt6u/AUGRVAMsa0MAFtQ==
X-Received: by 2002:a05:620a:370d:b0:774:17d6:31dc with SMTP id de13-20020a05620a370d00b0077417d631dcmr2397859qkb.4.1699971230375;
        Tue, 14 Nov 2023 06:13:50 -0800 (PST)
Received: from carbon-x1.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m2-20020a05620a220200b00777611164c5sm2701263qkh.106.2023.11.14.06.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:13:49 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Jerry Shih <jerry.shih@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 14/20] dt-bindings: riscv: add Zihintntl ISA extension description
Date:   Tue, 14 Nov 2023 09:12:50 -0500
Message-ID: <20231114141256.126749-15-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114141256.126749-1-cleger@rivosinc.com>
References: <20231114141256.126749-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for Zihintntl ISA extension[1].

Link: https://drive.google.com/file/d/13_wsN8YmRfH8YWysFyTX-DjTkCnBd9hj/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index f3c99e69619b..f953c49be90d 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -339,6 +339,12 @@ properties:
             The standard Zihintpause extension for pause hints, as ratified in
             commit d8ab5c7 ("Zihintpause is ratified") of the riscv-isa-manual.
 
+        - const: zihintntl
+          description:
+            The standard Zihintntl extension for non-temporal locality hints, as
+            ratified in commit 0dc91f5 ("Zihintntl is ratified") of the
+            riscv-isa-manual.
+
         - const: zihpm
           description:
             The standard Zihpm extension for hardware performance counters, as
-- 
2.42.0

