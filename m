Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CB37AEF43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbjIZPEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjIZPEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:04:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B7C10E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:03:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3200b181b67so1192065f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695740632; x=1696345432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQDAxN5g1vMcAJWLoIEgGtbs3vH3NsC3JS3eiLLd1tc=;
        b=RSu2dlzSLD/MQbHRXs/I7tNPqUsZIF4qAWabMji12OIWw1ls8Th9dnbWmSBGZrj5Bm
         /IB+CXnhMk6tBmfylXPjM5MDd77T1fnYghsehbVWjN/iioPqMcIcup7OYXr/l4WXpAM0
         I7A9P3ZR1Fe1bsv33FnFXHXIcBCfIIo6s4sr2CIm+mg3pOeaKSoVf51gPsRNk7GFlDC3
         IN47s+g5kNiZMvK0qJkAzTFHty/i2HfBtsZlJbezzHqV5tFHjN7dqvAEue5ti5dggiuW
         MKzVB20JM+aE54eP4bHOeuWwKvHfmQPQ15+OilLLABdvS6ioqC7G5d/5pxYUaOx928No
         ha0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740632; x=1696345432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQDAxN5g1vMcAJWLoIEgGtbs3vH3NsC3JS3eiLLd1tc=;
        b=W+1+9vGbHgCO7Na/mf/sdA90dvDkE4Y/uciqMvcy6ig1Ss7dz4mmJ/As6KdNDIawe9
         XaamRdlpluFqezBCOATZyENw2tm33eLqMrq3krahrbuuQhKbI617KmOVvBcTjZdvV5r9
         5GclXlE/VaIlKfJCWUf1PB6CzoVfdgevlqM509j59FK5VYlEnr93+bhiahDqBStCcDZu
         jZ/oN2zFkt+VtoNToroxmWhgj4IDgki4dtVZjqUHYMT38lffktyjREexobFRp+C1yG2p
         dCaK0LwzSSFwNk+CxiJeLld8Ma/qszv2/GBzZDUPnIeUqUSckWtBbAVE3gBUosXJhNHZ
         QZlQ==
X-Gm-Message-State: AOJu0Yy1IFYOq/hZpJcMK9VNCAlO6HcnbGThhj7g0EcD05lbACSWub2e
        T/XCenNMObDZlkL4vpk4yEf+ew==
X-Google-Smtp-Source: AGHT+IH9PRCXtJEPxMLZQ5j5Z5+cpNGCxbKpqseY8qd18eONWrD2LaNnzT+g47bz5kOVc9HeGDcZ5g==
X-Received: by 2002:adf:a456:0:b0:323:2df9:618f with SMTP id e22-20020adfa456000000b003232df9618fmr3634053wra.0.1695740632703;
        Tue, 26 Sep 2023 08:03:52 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:2b3d:6c70:9dbf:5ede])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d650b000000b00318147fd2d3sm14926060wru.41.2023.09.26.08.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 08:03:52 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
Subject: [PATCH 1/7] riscv: remove unused functions in traps_misaligned.c
Date:   Tue, 26 Sep 2023 17:03:10 +0200
Message-Id: <20230926150316.1129648-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230926150316.1129648-1-cleger@rivosinc.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macros by the only two function calls that are done from this
file, store_u8() and load_u8().

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 46 +++++-----------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 378f5b151443..e7bfb33089c1 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -151,51 +151,19 @@
 #define PRECISION_S 0
 #define PRECISION_D 1
 
-#define DECLARE_UNPRIVILEGED_LOAD_FUNCTION(type, insn)			\
-static inline type load_##type(const type *addr)			\
-{									\
-	type val;							\
-	asm (#insn " %0, %1"						\
-	: "=&r" (val) : "m" (*addr));					\
-	return val;							\
-}
+static inline u8 load_u8(const u8 *addr)
+{
+	u8 val;
 
-#define DECLARE_UNPRIVILEGED_STORE_FUNCTION(type, insn)			\
-static inline void store_##type(type *addr, type val)			\
-{									\
-	asm volatile (#insn " %0, %1\n"					\
-	: : "r" (val), "m" (*addr));					\
-}
+	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
 
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u8, lbu)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u16, lhu)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(s8, lb)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(s16, lh)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(s32, lw)
-DECLARE_UNPRIVILEGED_STORE_FUNCTION(u8, sb)
-DECLARE_UNPRIVILEGED_STORE_FUNCTION(u16, sh)
-DECLARE_UNPRIVILEGED_STORE_FUNCTION(u32, sw)
-#if defined(CONFIG_64BIT)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u32, lwu)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u64, ld)
-DECLARE_UNPRIVILEGED_STORE_FUNCTION(u64, sd)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(ulong, ld)
-#else
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u32, lw)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(ulong, lw)
-
-static inline u64 load_u64(const u64 *addr)
-{
-	return load_u32((u32 *)addr)
-		+ ((u64)load_u32((u32 *)addr + 1) << 32);
+	return val;
 }
 
-static inline void store_u64(u64 *addr, u64 val)
+static inline void store_u8(u8 *addr, u8 val)
 {
-	store_u32((u32 *)addr, val);
-	store_u32((u32 *)addr + 1, val >> 32);
+	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
 }
-#endif
 
 static inline ulong get_insn(ulong mepc)
 {
-- 
2.40.1

