Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BDA804DCB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjLEJ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjLEJ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:28:10 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637B99B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:28:15 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ce49d9d874so2013655b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701768495; x=1702373295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+Duv2eL4Rh6BmoQvomNjrPNP7WadF4MX+fx63CbvwQ=;
        b=npuOWRMl7QM4Mt3i1dtM3vrIJQJeroBuwn1gjmvWDNQY6qx6lD0SyRMTuU/lLEq8/x
         90lm00lWlHm89Yo4KOdOnePWBUSXN3JLLcNYRwScPja02eOnqzwpELIa7Um7TIPftpho
         3LBCfrJ+uzgOGED/nWL0r7ORz/xms0o1//MPlIDMXv4khxkUJpN6kio4ShhknsO29KHJ
         RYcl5sX9Yd7yXoAB0ryc7A0uJerxYBMCZs3vfMLDKINIU8n67rdkRj6f+ntdkl2kIzPF
         3znjaQIIv0AOqzeaqOKc8PSAOFVa0pOViUsWNUsi6ByycoQ0jyNMmw57JRDVExxM8wpy
         hRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768495; x=1702373295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+Duv2eL4Rh6BmoQvomNjrPNP7WadF4MX+fx63CbvwQ=;
        b=v92uJwzJ00WQ90C+O52khnzhEXf9Zw6tlPdRZREDq41xLEs66/NG4zyw03velOCb2Q
         TdOBwWrVPlwSNjlkuyiPR5zN7vYmM92sKy8ZsI5Fz/G8EcBG9fco6YQsZGbIe3ailKUV
         r2+CVpvJQWpetsU0hIXNTCog3xlv/aiCKZ1SoQw1/lcDP0q+046l1V1DACGkSnaXhc+D
         94Ue1IIGh8jWBGM4KDaA4WL2aWvf+U36AnO62bVrGqlMyu/dw9wvHonfB+sh9btsw7K+
         kN4yZtvM5wQSnA2ObyOCdVLo3Ew+/qdI1BcP3DhWnYusvD0CuI6UDtGn1UyuqtCt4n6L
         z4yw==
X-Gm-Message-State: AOJu0YwYwqbo59Xu7HRBAeKCvhhqqS9lwIZFWOqTDtn/kXHu3G6zTnIF
        PdIR1gXFY0nlVYVBVwn63rzCsg==
X-Google-Smtp-Source: AGHT+IHo8qyIK+a7xAlqBDFbhHitNbdyhcjGou5e7sEK1zHUFcXdJWS5bgBXVVX5Sw11ZixDo6r/6Q==
X-Received: by 2002:a05:6a20:160a:b0:18f:97c:9778 with SMTP id l10-20020a056a20160a00b0018f097c9778mr7394313pzj.96.1701768494761;
        Tue, 05 Dec 2023 01:28:14 -0800 (PST)
Received: from localhost.localdomain ([101.10.93.135])
        by smtp.gmail.com with ESMTPSA id l6-20020a056a00140600b006cdd723bb6fsm8858788pfu.115.2023.12.05.01.28.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2023 01:28:14 -0800 (PST)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        ebiggers@kernel.org, ardb@kernel.org, conor@kernel.org
Cc:     heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 01/12] RISC-V: add helper function to read the vector VLEN
Date:   Tue,  5 Dec 2023 17:27:50 +0800
Message-Id: <20231205092801.1335-2-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231205092801.1335-1-jerry.shih@sifive.com>
References: <20231205092801.1335-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

VLEN describes the length of each vector register and some instructions
need specific minimal VLENs to work correctly.

The vector code already includes a variable riscv_v_vsize that contains
the value of "32 vector registers with vlenb length" that gets filled
during boot. vlenb is the value contained in the CSR_VLENB register and
the value represents "VLEN / 8".

So add riscv_vector_vlen() to return the actual VLEN value for in-kernel
users when they need to check the available VLEN.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
 arch/riscv/include/asm/vector.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 9fb2dea66abd..1fd3e5510b64 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -244,4 +244,15 @@ void kernel_vector_allow_preemption(void);
 #define kernel_vector_allow_preemption()	do {} while (0)
 #endif
 
+/*
+ * Return the implementation's vlen value.
+ *
+ * riscv_v_vsize contains the value of "32 vector registers with vlenb length"
+ * so rebuild the vlen value in bits from it.
+ */
+static inline int riscv_vector_vlen(void)
+{
+	return riscv_v_vsize / 32 * 8;
+}
+
 #endif /* ! __ASM_RISCV_VECTOR_H */
-- 
2.28.0

