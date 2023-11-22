Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9087F54DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344279AbjKVXdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjKVXcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:32:53 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD45C10CB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:32:17 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cbc8199a2aso317189b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700695937; x=1701300737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTOEMFDe24CcawDbpqI8rRhvGeiKsZMYCpriyAZ9TQI=;
        b=yq4/JRfaBb4CRyLmq9pjTiCXW8nz2NeAGLTCuMxURiWE1L0HS+x+hO4RB0WzFK3pFJ
         gUiZ9kAOH0YMeO5aWnfboJD3xpcRpY8txMwIBokRbHc83FdC4qt1BMyGqOG4+k95t19l
         LMUN6/5XFck9jo2i1O+wKBZjuDwxdjUf3HzbNCDV/gEk6maY6LfdIA55sMdWi8hjlNNQ
         PX+V/mf2WCz6xhntL3YyPpz6/hJSgE2m/mTNRBGN+8/A1ta4PxaY+ludbr6casVn6OaX
         b03OY6ZNR/r6xPWMP0U+K/z10YkSlDxhwxp/3SNfza1uwVR7Pbbe6uSeSsUvJTcXnazc
         V7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700695937; x=1701300737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTOEMFDe24CcawDbpqI8rRhvGeiKsZMYCpriyAZ9TQI=;
        b=Lu8BiqEgu2wZlgBXspPfhBFESSXFzdQ0jWO2Dye8l8OEba7auX9mhj8kxjy5oHJZhk
         l0AzPSD5+NPNsYuUVDC92Z9VHdlIHE27SkvyELoZgNu+DA8mxPvjYy+/6mavL4OEZeeU
         uyC2LfFUDfiGfXPXHx5cr9TgNr8gMCfjl9S04w382ShK+SpTAI+TgTsplrmc2+9g6Hbn
         aEsvNdH+LUPUmWaZzzHhRk01MYCEbTT3RF9zArPRJY0aLoDSabhjoHXOuzopf9qKXcoh
         PvPAMIksrUyeiDRsrisSmILqUIC85TEVD9iQps8GlmBAkYYaAIcf8HS3NgLj0bKgakoA
         QaPw==
X-Gm-Message-State: AOJu0YySUZXNeQWS5rJpzCAVmszVi4lZlcgt/HlipnnmHpctUISqCNyG
        jnKfzXPhcZ0ZPWeVDclLxO4wDQ==
X-Google-Smtp-Source: AGHT+IEXMuZbVUcDIR5OaKBeEgk+i7PG7HnEzJbJhQ7rQEpMxdnnM7iLkA2DbE8LcD54zxaRSiz1vg==
X-Received: by 2002:a05:6a00:6c8e:b0:690:3b59:cc7b with SMTP id jc14-20020a056a006c8e00b006903b59cc7bmr4648756pfb.32.1700695936871;
        Wed, 22 Nov 2023 15:32:16 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78c56000000b006c875abecbcsm22603pfd.121.2023.11.22.15.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:32:16 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Wed, 22 Nov 2023 15:31:42 -0800
Subject: [PATCH v3 2/2] riscv: Correct type casting in module loading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-module_linking_freeing-v3-2-8e9e412a3305@rivosinc.com>
References: <20231122-module_linking_freeing-v3-0-8e9e412a3305@rivosinc.com>
In-Reply-To: <20231122-module_linking_freeing-v3-0-8e9e412a3305@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>,
        Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700695933; l=1122;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=JEDtvtgEBmFqCKNc+NtpG6SnBh4nM+PNkCAzWthvfGI=;
 b=agKzcrFlKLjzZJouJQrrVp+E78ppa6q038/I46LaMQxzZRAByfrJC5J1zXsrBngNF8BddyoyG
 ULuT+Dr5K2OBcOy66Mu2Kl/sIi2+HtIaRq7LtTQ2aV/x88utv/NoJX/
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __le16 with le16_to_cpu.

Fixes: 8fd6c5142395 ("riscv: Add remaining module relocations")
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>
---
 arch/riscv/kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index fd9a5533518c..b570988e7d43 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -66,7 +66,7 @@ static bool riscv_insn_valid_32bit_offset(ptrdiff_t val)
 
 static int riscv_insn_rmw(void *location, u32 keep, u32 set)
 {
-	u16 *parcel = location;
+	__le16 *parcel = location;
 	u32 insn = (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]) << 16;
 
 	insn &= keep;
@@ -79,7 +79,7 @@ static int riscv_insn_rmw(void *location, u32 keep, u32 set)
 
 static int riscv_insn_rvc_rmw(void *location, u16 keep, u16 set)
 {
-	u16 *parcel = location;
+	__le16 *parcel = location;
 	u16 insn = le16_to_cpu(*parcel);
 
 	insn &= keep;

-- 
2.42.0

