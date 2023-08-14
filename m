Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4E877C17F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjHNU37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjHNU3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:29:32 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57B8110;
        Mon, 14 Aug 2023 13:29:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so42888835e9.2;
        Mon, 14 Aug 2023 13:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692044970; x=1692649770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgES1U2rAJt0vkuQ5rZJ9UhsIJ2P8NX/YjkPZttVOXs=;
        b=cmKgegzaVqNxEVWiR+prIVGiodpzFr31luuavYINSMhzPNf0kg/2oheiHveCXdOsTM
         2EIfOD017s+20lW79kUrZfcIDOCar7OwuHJ8bei6vYZxv7lEwooIJjS8FapzdcwnoBDt
         S2AfbR+QPq3H3ny4W1/2uhxAxuzlnzM3Kuh0j977bM9+IX8Q/4eCso1fia1z2YwwK4w+
         XF5cb6AsvOkBALOVgaQ3ZcpJ6nrjx7RGhxIX+Yk8UfAczVKwq4LaRHCSb+U7EiQoWz42
         uVOdvp7wdtKUhdQi0YfT3FHut/qI9HYbFKroI3djWyhQz/G0vxyJp2GGM8qzyvlsClX1
         3Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692044970; x=1692649770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgES1U2rAJt0vkuQ5rZJ9UhsIJ2P8NX/YjkPZttVOXs=;
        b=QeaVHA6cAryCFx9ym5b1QgLKbRlhT1Mb7soimHP66Cm248oMpWwYgFqBPRTS2xPJTT
         wqwWmHAjEwZSyPp6uEWfY4Gv3JzYmSPDi3Fa3mATuqJUv4FAf0XcUMG4hZP8Kd6fTTCj
         bEjyemyk8Dup19NBi/99mwv9mKhQQsNhjWjY07F4vMdujaU1Lhg7Ve08eshuYSryEvPF
         ONdM5Bi6zx6LVc7ncSKLoOnu1ZKgPHrB3cMHv4/yrqey5UH2Kr/izR9PIpX4Banpb29D
         qc5851x4DCjzcwsslNGXjqz1kDUKMpyJaqmQ0+kjQFc9xWk4NCd2cWpUyjSAKr83aNw8
         hNnw==
X-Gm-Message-State: AOJu0YxsWH9TJYO9Uit0HWrkgkjYa2Dhq+dyCuoX/PXbfF4XlE+DJ2fM
        h6R8RonX7otN7FMpSFnBO3o=
X-Google-Smtp-Source: AGHT+IE5AyDcYJd4G1UT7NTo1tKSeic6cgBusYnNxNedxa7HhjLy9CDCy4a8k4YcD2ORKou12eQPoA==
X-Received: by 2002:a7b:c4d0:0:b0:3fd:3006:410b with SMTP id g16-20020a7bc4d0000000b003fd3006410bmr8182828wmk.34.1692044969972;
        Mon, 14 Aug 2023 13:29:29 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:20e9:baea:a4f7:d880])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003fd2d33ea53sm15181223wmj.14.2023.08.14.13.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:29:29 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [(subset) PATCH v2 1/3] riscv: dma-mapping: only invalidate after DMA, not flush
Date:   Mon, 14 Aug 2023 21:28:19 +0100
Message-Id: <20230814202821.78120-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814202821.78120-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230814202821.78120-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

No other architecture intentionally writes back dirty cache lines into
a buffer that a device has just finished writing into. If the cache is
clean, this has no effect at all, but if a cacheline in the buffer has
actually been written by the CPU,  there is a driver bug that is likely
made worse by overwriting that buffer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Fixed typo drive->driver
* Included RB and ACKs
---
 arch/riscv/mm/dma-noncoherent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index d51a75864e53..94614cf61cdd 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -42,7 +42,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		break;
 	case DMA_FROM_DEVICE:
 	case DMA_BIDIRECTIONAL:
-		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+		ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
 		break;
 	default:
 		break;
-- 
2.34.1

