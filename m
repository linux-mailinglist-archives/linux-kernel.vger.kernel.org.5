Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1713C7E3A95
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjKGK4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbjKGK4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:56:22 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2012D57
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:56:15 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9bf60bba6f8so165967966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699354574; x=1699959374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+noeIiO0ZzRdCBLgjz9J+sy56GBx1867ixAgWMD4Wc=;
        b=1wIith9BIdnPlLltM/62yqwKTVZcSImm4+ad2Gk0VDRpQe2WzCvLgT+Hr7usm7OxSz
         jk41Km8ltUuWCE51dGojhIp2PnB3+3h5T48M7DxyZaBZD5m6ohFmSfE8FryJ2qORZ9ko
         iM8/gj6pnR5A9H6KcwrlWhMefYGY3QCfYUcl3axE2UrISp77HH0atxKDB46GS8BQTnsF
         QsX8bOZJV0b1RqGC6plEWYzuA/Oiod+ZjMOqTacw62vWk1BplxOj6W/lMDLpJcrfzL4k
         eN487W+x+n9sc5MGPqrc2BIb2ZU/jiYBfDDsiAn5vPde8l7w1T4/8m9ATxXdzRSmtZko
         ruIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699354574; x=1699959374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+noeIiO0ZzRdCBLgjz9J+sy56GBx1867ixAgWMD4Wc=;
        b=ScjHEkNDoaijlOxC7R3vCKFo2VJj86/UQ5MP4loebRIxEyrSUFBVCQBy8+oCGCTXT3
         JCzrIT7KlZe9W6gIU6wYC3fO6DdqoCS5bl8XLAJSk0gy1gajF9bxexx+zAC5ZkU7thDt
         WAfLpnpIOtYybyuCol4gtC8TC0ZlksNUVM8E8QXjA8kRUdzCaEmuCAOzdocFs+Wk5WFv
         FipD7jbSITloU/Aj6hJJDdCRLvSmlrnbhkJSD+6NreAbEfuMRAyPvckrp61bska7pLFd
         VnqiwrbEq4UuJ2JaJ0lc6lr/KIUN4H19Jtxc4B9/P5/tF6YpdJUvPZGYSC/t7FyeL/U5
         b3DQ==
X-Gm-Message-State: AOJu0Yx2jK/Y1Z1N5tV5vGR2cGenwE2W9YEQn9q0f+iLLwIxahh7js3R
        dXp19gqAqplMn3i9MJc4r+3DmA==
X-Google-Smtp-Source: AGHT+IGQ52RAx3C3PSFQKflfCCfN+v4u5QXrEdDEyMd6Gzx8ZtOWMB3t8ixpUgsMGHhCAPNhRGbMJA==
X-Received: by 2002:a17:907:6d02:b0:9c9:603c:407e with SMTP id sa2-20020a1709076d0200b009c9603c407emr28520448ejc.0.1699354573974;
        Tue, 07 Nov 2023 02:56:13 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7db3:bdd9:4cab:2ee3])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b00405442edc69sm15396853wmr.14.2023.11.07.02.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:56:12 -0800 (PST)
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
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 11/20] dt-bindings: riscv: add Zfh[min] ISA extensions description
Date:   Tue,  7 Nov 2023 11:55:47 +0100
Message-ID: <20231107105556.517187-12-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107105556.517187-1-cleger@rivosinc.com>
References: <20231107105556.517187-1-cleger@rivosinc.com>
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

Add description of Zfh[min] ISA extensions[1] which can now be reported
through hwprobe for userspace usage.

Link: https://drive.google.com/file/d/1z3tQQLm5ALsAD77PM0l0CHnapxWCeVzP/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/riscv/extensions.yaml       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index b68edfd1fb43..62b5fe40b4a3 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -214,6 +214,19 @@ properties:
             instructions as ratified at commit 6d33919 ("Merge pull request #158
             from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
 
+        - const: zfh
+          description:
+            The standard Zfh extension for 16-bit half-precision binary
+            floating-point instructions, as ratified in commit 64074bc ("Update
+            version numbers for Zfh/Zfinx") of riscv-isa-manual.
+
+        - const: zfhmin
+          description:
+            The standard Zfhmin extension which provides minimal support for
+            16-bit half-precision binary floating-point instructions, as ratified
+            in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
+            riscv-isa-manual.
+
         - const: zk
           description:
             The standard Zk Standard Scalar cryptography extension as ratified
-- 
2.42.0

