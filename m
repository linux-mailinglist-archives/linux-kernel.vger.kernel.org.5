Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0F076DF66
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 06:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjHCE15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 00:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHCE1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 00:27:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF28DF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 21:27:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5230d2b8128so449266a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 21:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691036866; x=1691641666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zc4fKZpvtCamX6sgBaS463wBLKH4MpwEP9vDGVPDIZs=;
        b=Egl2+MgBN+YIyuX/3RSTHmzC4j0m+vmprmny8glLiHeN3qb4t9FK2El2eXAxeBFwf2
         BpU1zJX2iFbwLXkQRVmHH59VKITRjWahkpsgR8BaH46srfiIsDLpjSsOLfuUMwOfs33h
         KRqYCz4Mjcx06EoWWyH6ZG+sYmKzy6kzp5llzggEA+mRoL4yfLzeHmYLVYUXxcU4hF0U
         9XcD140gRuVq6swTilOXJPNehGezj/UhSROAmF6OkF9QiicPc8f8Swv9nDGpqYnJMpu2
         lirINJYQVBWT+aEZCscGvBEQPXhJ6mUp0TN8wpzYIVXimXPZb8S29OwcVQa3mkk+mSlY
         PQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691036866; x=1691641666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zc4fKZpvtCamX6sgBaS463wBLKH4MpwEP9vDGVPDIZs=;
        b=BbGim1VbW7c+2JtukEHzXNDbpmYmwFCMm43OEvPAtTOpeU5h3ve9f+ALWCIl3ytfY/
         NZM7qtEcBvTxn2V2j3zfI8HHrtjWB0gSjFpwvUCHX4IpuqD2NRQuCvAWVx5ZZg7E9tSL
         h+M7bevz9T8f4/tapo82U4eFyQx+EG+Ntyjc33+xY3HOf6gDqlOBzFWQ3xMeLGh3EBra
         aeFzpNaGkuVR5Beu22io27FSrxRbNLc+Q+2ggSx94odEmZZDq78wpKkR8Cl47pBqgvZD
         TZgiJypAVMthl7aIuFn5EBkWIMV7DUP0xm4cCnjBTn5AOxgfds6pwAgTE0fV9KAm0Ugi
         folg==
X-Gm-Message-State: AOJu0YzClccLeINHq+DXEzbRxDX7f4woaBhrWqCrv/CTWy1h9QkOjzTu
        M+UyPpP0V6+ANTaxKi3XhSw=
X-Google-Smtp-Source: AGHT+IGv7afoJa7YCQjcrnx3h7TVpsBXcfQhpdU+L/BetHl7PXElFdOIgObMjCHWcm6S4ULc2zSMmQ==
X-Received: by 2002:a05:6402:1b08:b0:523:73d:84c8 with SMTP id by8-20020a0564021b0800b00523073d84c8mr1608703edb.12.1691036865844;
        Wed, 02 Aug 2023 21:27:45 -0700 (PDT)
Received: from andrea.. (host-82-57-177-142.retail.telecomitalia.it. [82.57.177.142])
        by smtp.gmail.com with ESMTPSA id u12-20020aa7d54c000000b0052217b3a10dsm9337094edr.63.2023.08.02.21.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 21:27:44 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v2] riscv,mmio: Fix readX()-to-delay() ordering
Date:   Thu,  3 Aug 2023 06:27:38 +0200
Message-Id: <20230803042738.5937-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Section 2.1 of the Platform Specification [1] states:

  Unless otherwise specified by a given I/O device, I/O devices are on
  ordering channel 0 (i.e., they are point-to-point strongly ordered).

which is not sufficient to guarantee that a readX() by a hart completes
before a subsequent delay() on the same hart (cf. memory-barriers.txt,
"Kernel I/O barrier effects").

Set the I(nput) bit in __io_ar() to restore the ordering, align inline
comments.

[1] https://github.com/riscv/riscv-platform-specs

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
Changes since v1:
  https://lore.kernel.org/lkml/20230711133348.151383-1-parri.andrea@gmail.com/

  - surrendered to the intricacies of NOMMU/RV32 builds: dropping #2
    (takers are welcome! ;-) )


 arch/riscv/include/asm/mmio.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/mmio.h b/arch/riscv/include/asm/mmio.h
index aff6c33ab0c08..4c58ee7f95ecf 100644
--- a/arch/riscv/include/asm/mmio.h
+++ b/arch/riscv/include/asm/mmio.h
@@ -101,9 +101,9 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  * Relaxed I/O memory access primitives. These follow the Device memory
  * ordering rules but do not guarantee any ordering relative to Normal memory
  * accesses.  These are defined to order the indicated access (either a read or
- * write) with all other I/O memory accesses. Since the platform specification
- * defines that all I/O regions are strongly ordered on channel 2, no explicit
- * fences are required to enforce this ordering.
+ * write) with all other I/O memory accesses to the same peripheral. Since the
+ * platform specification defines that all I/O regions are strongly ordered on
+ * channel 0, no explicit fences are required to enforce this ordering.
  */
 /* FIXME: These are now the same as asm-generic */
 #define __io_rbr()		do {} while (0)
@@ -125,14 +125,14 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #endif
 
 /*
- * I/O memory access primitives. Reads are ordered relative to any
- * following Normal memory access. Writes are ordered relative to any prior
- * Normal memory access.  The memory barriers here are necessary as RISC-V
+ * I/O memory access primitives.  Reads are ordered relative to any following
+ * Normal memory read and delay() loop.  Writes are ordered relative to any
+ * prior Normal memory write.  The memory barriers here are necessary as RISC-V
  * doesn't define any ordering between the memory space and the I/O space.
  */
 #define __io_br()	do {} while (0)
-#define __io_ar(v)	__asm__ __volatile__ ("fence i,r" : : : "memory")
-#define __io_bw()	__asm__ __volatile__ ("fence w,o" : : : "memory")
+#define __io_ar(v)	({ __asm__ __volatile__ ("fence i,ir" : : : "memory"); })
+#define __io_bw()	({ __asm__ __volatile__ ("fence w,o" : : : "memory"); })
 #define __io_aw()	mmiowb_set_pending()
 
 #define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })
-- 
2.34.1

