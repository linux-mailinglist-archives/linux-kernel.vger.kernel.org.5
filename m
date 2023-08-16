Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0367677EDCB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbjHPXYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347148AbjHPXXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:23:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B89271E;
        Wed, 16 Aug 2023 16:23:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31956020336so236981f8f.0;
        Wed, 16 Aug 2023 16:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692228227; x=1692833027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGdlWqc1rkzIUGoDyoTEaUD3c+T74fuHGIBlF6hhRXE=;
        b=i1rMqkAX0KYQmr3hX4gpHJcpZAnDSPY8FLQjmOcFH3IWzsZwip4k+YHeb5V/KxJnpF
         q4TAqYenmaiCEY3J97LGLYQGw7eJ2N/2/dohn9ZdiJpMRm8Bej5E6vNa/L/rNEbX4Pwd
         hGhjFUsAvEUj3b7xE3U1OtrsvSSninqiC2JU+tamUiDAcQOpP87MxwfCpaVsQCw8ymh2
         FztCPo83D2R4gVCMS/kU/XhbDdDdPFnhiNZu5FI4YCkQFkFJZycKAVLvazdTOH5OEmGn
         U7zf/orzzZgyY6Sn8ZjbSSglKNIJRoRTb6+PNjK87rFAEFx1Ou7YFmyFIlWI9PDI9iCM
         k+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692228227; x=1692833027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGdlWqc1rkzIUGoDyoTEaUD3c+T74fuHGIBlF6hhRXE=;
        b=kqMGF/pv8BnnMKKRjm81iP/Aswik3PjBWlQsFkUVlk+NCeti6Msad3FH40f4NXovKF
         vcoYaqVI6xOqzY9E7ShA5buDPyMKd7XemHtpag/m41mAjoulgljzXeRM04RRwtEULKBI
         dsIpn7MsCpNE8lSpYgILTu79HlRLjgIQxTwD6p5TBXsdw4Y0oQ1yiB3ICf7Nww04V/aA
         lTLdWut+EOSnbFZrbHkcUM9J6ENAmVnJduRzwc1M7BWffZojoNKAHFt5Lv+S8TIyjWXh
         5tr7leKFvnrTml9M1V9GKAcLXGqg/kB8xMgX8rJt575wpnfJYkNA1B2CgZBZ8t4/HlXS
         ONeA==
X-Gm-Message-State: AOJu0YwtT7yoQLC50zAJiKCZE9ARHDByYw7d7Lz/I+tjCVGsrOYpVnN1
        xDUSdggbaAcwgOE8RrF0ZxA=
X-Google-Smtp-Source: AGHT+IHmS0dmKyTUvNIRhuKNUSwUXxoC4kjuGiODOZEK2LaKsTUEMw6dOQBcO1DBZTrwrVq3tbjfOg==
X-Received: by 2002:adf:e78e:0:b0:314:2f3e:dca5 with SMTP id n14-20020adfe78e000000b003142f3edca5mr791297wrm.28.1692228226969;
        Wed, 16 Aug 2023 16:23:46 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:aeb8:832b:ebc0:1bbf])
        by smtp.gmail.com with ESMTPSA id q4-20020adff944000000b003143c9beeaesm22752617wrr.44.2023.08.16.16.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:23:46 -0700 (PDT)
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
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v3 2/3] riscv: dma-mapping: skip invalidation before bidirectional DMA
Date:   Thu, 17 Aug 2023 00:23:35 +0100
Message-Id: <20230816232336.164413-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816232336.164413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230816232336.164413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

For a DMA_BIDIRECTIONAL transfer, the caches have to be cleaned
first to let the device see data written by the CPU, and invalidated
after the transfer to let the CPU see data written by the device.

riscv also invalidates the caches before the transfer, which does
not appear to serve any purpose.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3
* No change

v1->v2
 * Included RB and ACKs
---
 arch/riscv/mm/dma-noncoherent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index 94614cf61cdd..fc6377a64c8d 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -25,7 +25,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
 		break;
 	case DMA_BIDIRECTIONAL:
-		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
 		break;
 	default:
 		break;
-- 
2.34.1

