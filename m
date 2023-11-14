Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C4E7EB1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjKNOOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjKNOOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:14:04 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6035F173D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:49 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77891670417so55611885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699971228; x=1700576028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CepaQtX/sdwhUbmZetc41QOoUE9LfFVWHL973vxJ7UQ=;
        b=r4MsV3pUqHlMtM0U0eUSS3RLRXCYYDZHJuKDGcFHaMw6qb5hkSX+dJIGYacyH1qhAh
         Lhg7kY7fmo2pXm0T5kuc+p5Nxy3ncX8VwjG/UvNOBQ44lNkFhMfEjZis345yXfojY5zC
         eUDDdqtxnfQruhys9TYHAikQs8daWK7PeU5lNEVjFlg8bu6ZzyDlu6PSwYgA1D/fJ9Dj
         Fn7GFezFPsTYE6UPDwzBUUw4XNnF2MHpYMpJLxkJPy2bXEpZvEvu2TgA/2eaSGOaRoH7
         E/rWYgYy4e9Yru13n67l7byzQaopoX2AJUO0jRSYhtw4cAKkNCo8Wk/Og09Kh6pEh9AC
         pk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971228; x=1700576028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CepaQtX/sdwhUbmZetc41QOoUE9LfFVWHL973vxJ7UQ=;
        b=c6RnmOgzSAcdrJx5LWsjeaoObPd0W4siN9cKBWFPCTd6MybMscBn087O6HUXITvI4P
         MyIFWfzHW8hJ6NKEJTiaIFMqLyaFYJBn1qDgNxwNGrhJmFlWFLdqZHzlw8CGzyc1blbQ
         FWtVAFWtmne0f96ARwCyU5wJCPtoA+ydGkvScEyENgpxqRVOB7RUGydq5KYCu8xn0QpE
         gLKujv0DsMefaDHiO1R8ISPzDs+9/6WJx+LwtYRK9Vj7SfphxGYpEKqKHbDsvhOs1sfW
         vhLQDnLXigOhedYeo0RkHCeON/1RV6yR3bujEjhJ9Tf8+LV+KMQvQN7iFHZU4FvIkhoW
         oR6A==
X-Gm-Message-State: AOJu0YzUPj4XBofAL7gnRUWcLcMPfP651MvVM+K+XcDiSexC7xyClCDA
        cNBJpaECWPLBB1YuUlKi9Fts4g==
X-Google-Smtp-Source: AGHT+IF7WevyrXd//n4lH0ZEXB0TDnFlHM3i203ryiy76OKa7Bcf589Sc/lKHJHt3RYWXfpjbdBHtw==
X-Received: by 2002:a05:620a:31a8:b0:77a:69a1:b6a3 with SMTP id bi40-20020a05620a31a800b0077a69a1b6a3mr3097387qkb.1.1699971228077;
        Tue, 14 Nov 2023 06:13:48 -0800 (PST)
Received: from carbon-x1.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m2-20020a05620a220200b00777611164c5sm2701263qkh.106.2023.11.14.06.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:13:47 -0800 (PST)
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
        Jerry Shih <jerry.shih@sifive.com>
Subject: [PATCH v4 12/20] riscv: add ISA extension parsing for Zihintntl
Date:   Tue, 14 Nov 2023 09:12:48 -0500
Message-ID: <20231114141256.126749-13-cleger@rivosinc.com>
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

Add parsing for Zihintntl ISA extension[1] that was ratified in commit
0dc91f5 ("Zihintntl is ratified") of riscv-isa-manual[2].

Link: https://drive.google.com/file/d/13_wsN8YmRfH8YWysFyTX-DjTkCnBd9hj/view [1]
Link: https://github.com/riscv/riscv-isa-manual/commit/0dc91f505e6d [2]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 6a6ee93a3c9a..97d106fa0f54 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -80,6 +80,7 @@
 #define RISCV_ISA_EXT_ZVKT		65
 #define RISCV_ISA_EXT_ZFH		66
 #define RISCV_ISA_EXT_ZFHMIN		67
+#define RISCV_ISA_EXT_ZIHINTNTL		68
 
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 7182cf278b1c..e73ee4cfd84a 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -256,6 +256,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
 	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
+	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
-- 
2.42.0

