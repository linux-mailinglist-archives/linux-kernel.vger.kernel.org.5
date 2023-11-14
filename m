Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181597EB1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjKNOPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbjKNOOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:14:39 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E831FD0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:14:00 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77891670417so55614285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699971238; x=1700576038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rR6IoEmFXflq9Qi2M8/M8/Q1NwDbTzc9ULqQpExnZtc=;
        b=N/thXekKUOrWo0W1g0hZeBjK984McFlvDKnUJ93Fg8G3BU7BA6AIUwkYGUAmFm1W/c
         pZw+T6EVvJIIZiB8u9myTSLXJBGSJw+lsGbyCeIlFbeDS/vbeoEReROE9AWog3Tyo2TO
         NET3HmTC0cHI44r4kyrrPEQaSEhR5ldV2pKeY/KuPtg8THRluZTLIQHwpjRgufMxL442
         e89inI/nfS+OuSmybuAEElEkpOTcX3xCECORk97WbBS3fzMI+Ck7opbLbKtL0Ga4iXZR
         vvLwhfOAQIndX5luSPMJ5xGPWEXoEs+k6F6P/E55EuZIopDNCJoYnNuZ6HfBadt0/S+2
         Hblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971238; x=1700576038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rR6IoEmFXflq9Qi2M8/M8/Q1NwDbTzc9ULqQpExnZtc=;
        b=HWYzzEYiC4IBJuejaQGpZJFVmCnuZVZOHIzabZjQWJ5Irc9d6BKAK6fOrbDEZeDwgG
         FGUxXIlPHT2qbwFU6BFj1WNo9xkfoMNRLGsh5Dd1CpRFbmTajB3RW2ZFpPXS/awvk/Q8
         x9t+BA7bI+gS8L0ST2WVzUAYg3Rlqk+daqsvJ69+InT31EivZNZcSRhNXjbiv5b9YBaz
         gYMiQwrUv5tWIdoosYrK6d1tuRgWHziLO3iBzCw43pw6J4YPLbq43y1GkGPsp9bYfj0X
         H+CSy43k4voWLHZlh+XfgL9/3401VDv1FUNjiBTjqdUd1+T4vobK7IfNrUxctuuQSU56
         6MEw==
X-Gm-Message-State: AOJu0YxflsbHrHfHeAmjP3Nfy9SMpIZD16rNmlBMnEciVI/WlfaCf10t
        1Np/e9snZeWy/vOPB7wm6KY/1w==
X-Google-Smtp-Source: AGHT+IGC6MfMYTQMl9dKfVeKwBQV9tnSgNOr1rIW41NsUM7O4nwiZO4ELAHWdrBbYXRRG7zqxSN9cw==
X-Received: by 2002:a05:620a:461f:b0:774:17d6:31f1 with SMTP id br31-20020a05620a461f00b0077417d631f1mr2492695qkb.4.1699971238436;
        Tue, 14 Nov 2023 06:13:58 -0800 (PST)
Received: from carbon-x1.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m2-20020a05620a220200b00777611164c5sm2701263qkh.106.2023.11.14.06.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:13:57 -0800 (PST)
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
Subject: [PATCH v4 20/20] dt-bindings: riscv: add Zfa ISA extension description
Date:   Tue, 14 Nov 2023 09:12:56 -0500
Message-ID: <20231114141256.126749-21-cleger@rivosinc.com>
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

Add description for the Zfa ISA extension[1].

Link: https://drive.google.com/file/d/1VT6QIggpb59-8QRV266dEE4T8FZTxGq4/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index b91d49b7c3a0..3574a0b70be4 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -214,6 +214,12 @@ properties:
             instructions as ratified at commit 6d33919 ("Merge pull request #158
             from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
 
+        - const: zfa
+          description:
+            The standard Zfa extension for additional floating point
+            instructions, as ratified in commit 056b6ff ("Zfa is ratified") of
+            riscv-isa-manual.
+
         - const: zfh
           description:
             The standard Zfh extension for 16-bit half-precision binary
-- 
2.42.0

