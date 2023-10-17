Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE4B7CC457
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbjJQNQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343838AbjJQNPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:15:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C4610B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-406aaccb41dso18299575e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697548536; x=1698153336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWnPq2gaUY6Bw+QhkV+/+BvTRtvqF4BIiAlwEf1vKGM=;
        b=dOZ25igJytRqCFx+02/whVtQZ+4db7VtNy56yNr34omCyC19Q7ftnT4nBNG+8l+itS
         8e/1GQY1tywkRBVigwGY5IePkvht4uLyon03ZukrXArgZs8kZr/WWdj8mKtwTC6jXkXd
         wuZIgliOrwijtHFozT5lFKMxO/NfMToDq9oltwCNE+jVPlFMhfotBcIikfEkKr9pNr+S
         P4XuHnqfRVUAuOXxC8IgFp3YAS9lApiqyoAFM0gDDtELf5p5q7Hvjpo24ODKXC9nIDDp
         DWfNV/qgoQ2IPgbszDgyBqEQuRgIA8tm46ALVuRycaqgeG3sY4r8lpzRiFgUzFMfAv2T
         dryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548536; x=1698153336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWnPq2gaUY6Bw+QhkV+/+BvTRtvqF4BIiAlwEf1vKGM=;
        b=Oyp4vew9wcrRvAqmEUcu0nCbAlGC5ea3vYUVaflSynTymVedqkAQ+JsPmhCZ3mx4CX
         u01KQoBUCxLV1vktCxrh6IcOZEKcY1QE+OqtryixCMgh6iEV2wNugp8Hu2coUKG/zspH
         mXKRUBnGSo+cL/nzo3u0Rsdr4Os0cANntL/j1MNzV0AYpKnvZx3DxkwELZYmb2pgDiR6
         k6pfE5tznt1M6l7dakSr/ehj2ayeeSMkz188ImIrbK4KVA9wcY7r6b3Y1lwF1MLWjvdN
         HG8ZUnP0ctktBt21Z/4eUjv6NuWXihu03dnufRQWcojW+5IWZqoE8w7BrSs8Cw0htRoN
         EUZQ==
X-Gm-Message-State: AOJu0YxTI3fJg6n8hu20IpOVX/ojn6+OUmYquqJLfEGLyHOlKGiFNkOe
        Al8bg+evGf91MN2AKRalqq58uQ==
X-Google-Smtp-Source: AGHT+IEySb+/Q17ICv3l76yF8jJjBFEiH3hFuZYYjFi7wwKXT2ljs/AM5fR+ARSo4sgAbdGf5BuQog==
X-Received: by 2002:a05:600c:1d9b:b0:408:3836:525f with SMTP id p27-20020a05600c1d9b00b004083836525fmr251193wms.1.1697548536185;
        Tue, 17 Oct 2023 06:15:36 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:96:820c:ecf7:a817])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm9873393wmb.2.2023.10.17.06.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:15:35 -0700 (PDT)
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
Subject: [PATCH v2 10/19] dt-bindings: riscv: add Zfh[min] ISA extensions description
Date:   Tue, 17 Oct 2023 15:14:47 +0200
Message-ID: <20231017131456.2053396-11-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017131456.2053396-1-cleger@rivosinc.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 93beb9872900..b0a0d1bdf369 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -208,6 +208,19 @@ properties:
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

