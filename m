Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6FA7FACF0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjK0WFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjK0WFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:05:11 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503901AE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:05:18 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1f03d9ad89fso2782347fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701122717; x=1701727517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfeJYmvvAj2atuMBwfCs8cMnsgt/tYWyP8ZyRNbK1QQ=;
        b=mJiv2LT6JN0NDh/ICNZwSDXURNv3cL1UIGN1PwZ7OfatV3xZiI8FDgN1PYJ1iOuy/H
         L6PPLqA+e5uI6FxVL8iddt/86kfDkWbjYfXaffQZghHI2kHQ8nzv9pR/taFcysjA6WLw
         NkhqImP3J4M0eMWpWRUBxz8C+I7B2UV3Mv0AvNiuT+Ru59p9l8oLadSnyFRQA5lCHIS5
         mAXkj2mGXkZUwIU0uoARjZEEpUCkHGXj8O1G/0B36yYfqAU9TmZvCV0N+fdwdNx3oKI3
         eedNWjOaTzSYYlKYrkImgsqPw0v0ANo12nJdqL8zTlWJ3wVeF3+xUzML+jidd9t2lXhd
         Bavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122717; x=1701727517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfeJYmvvAj2atuMBwfCs8cMnsgt/tYWyP8ZyRNbK1QQ=;
        b=xVCXuQh/Cds/kwcJDWrghRQAjgvxqps2ewNYwal4gdexDMuwJBoG4cubQOQFxE0QaS
         XukBJGRsJbHYKq9uUHuT9OcRR/EzaDyXNFUMJvscUzfvx5VYHsbubS3gqjkf7O3RM0Hs
         7GKFkGqqfU1EIGydBEqsBf14pN0eHsyoXOFc9j2YXvpfUi19jKOZdVngFbyyCvp868yi
         02I9yzte/Ak+YmKSBkt7I5Z2zXrHjiQE8ym97Q3kZWm3Ex2jdy4Sd55J+VvqiFkiytpa
         tXnW1AgOy4kNCX8nQhMoxiQX8055YX8wcZpRRhY+V3Tcn6pSBNCBrx316I4WsYkpz+HS
         m3IA==
X-Gm-Message-State: AOJu0YyKLEDZK6bU1TLQUE1AYfu3/QW/M5ubzauiQ3gKNeNE4kxP8BHd
        Nbm1Ltlc35WH3zsH1mzeILqXiw==
X-Google-Smtp-Source: AGHT+IGlTcZvaCuq9bLaYFKrLM9gzn7wml0OyTvdUNctquyivQSM+6s2M7QMasRuVCMWpyINa3zUCg==
X-Received: by 2002:a05:6870:1d1:b0:1fa:3b81:5b1f with SMTP id n17-20020a05687001d100b001fa3b815b1fmr8762544oad.30.1701122717675;
        Mon, 27 Nov 2023 14:05:17 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id x23-20020a056830115700b006d679b53e8asm1458890otq.24.2023.11.27.14.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 14:05:17 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Mon, 27 Nov 2023 14:05:00 -0800
Subject: [PATCH v4 2/2] riscv: Correct type casting in module loading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-module_linking_freeing-v4-2-a2ca1d7027d0@rivosinc.com>
References: <20231127-module_linking_freeing-v4-0-a2ca1d7027d0@rivosinc.com>
In-Reply-To: <20231127-module_linking_freeing-v4-0-a2ca1d7027d0@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>,
        Samuel Holland <samuel.holland@sifive.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701122714; l=1122;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=gKtfd5M4f/12qT968kmTbpH+FPE5A73SSgTlwm9+2vg=;
 b=n0mTJP+LYH0N4DSIuQTOKLB4SExsBvS4/o0PIOTxDPx23GVbSNKIkufpsBdKBOvb6R7paXCcV
 fHMdu6GDl3eAEQWplkrU6P3PL2M0orVhoFEVV10vqJHYN2WN6KTtQAy
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
index 53593fe58cd8..aac019ed63b1 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -55,7 +55,7 @@ static bool riscv_insn_valid_32bit_offset(ptrdiff_t val)
 
 static int riscv_insn_rmw(void *location, u32 keep, u32 set)
 {
-	u16 *parcel = location;
+	__le16 *parcel = location;
 	u32 insn = (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]) << 16;
 
 	insn &= keep;
@@ -68,7 +68,7 @@ static int riscv_insn_rmw(void *location, u32 keep, u32 set)
 
 static int riscv_insn_rvc_rmw(void *location, u16 keep, u16 set)
 {
-	u16 *parcel = location;
+	__le16 *parcel = location;
 	u16 insn = le16_to_cpu(*parcel);
 
 	insn &= keep;

-- 
2.42.0

