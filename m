Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B1B77C180
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjHNUaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjHNU3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:29:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522C110;
        Mon, 14 Aug 2023 13:29:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317b31203c7so4436306f8f.2;
        Mon, 14 Aug 2023 13:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692044975; x=1692649775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phGWQqQcUgpdnM6txJP29u6yPK67tIQiA1bCjq6RfTI=;
        b=TZi0hYLN362cjsZT1oNEzmhRnBOccQDBG0Y2mUBeEyo9+omFOgNs7ZKt1Zy6yRNp9P
         WTPnTBE9ktmy45z2SgdLdeEUNs2Ii50+16AWo7PdV0jIKpw6CSLj61BaBIot/UjbeWof
         utdsi/V6UDr85zbvxE6sgzrV0JPuNFBZy/SRI3t8ZUrTbpBlXdjwrRfSXU1QdTUQbwn1
         qAjrnsmfAx9zisuh+1gkweC/Ku3zLlGyiGzB1grpyZHdCwyIFvaLfCIySqHVFsYRATeg
         Q22bk235+2rC9v+7MG+zKgfsMrZWFYRpXXGRah2jgDCCrAZ8xJMDlLbSIMzpENsG/3+K
         wL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692044975; x=1692649775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phGWQqQcUgpdnM6txJP29u6yPK67tIQiA1bCjq6RfTI=;
        b=g4abxWxHMgi+ven/ZY99qAhwe3qxi5O7ny1Od0orn8jYDwIJl/awnfkBnJdR0io8En
         VBB4XNrO4Nq0FIb5hFGLpNn40TbigedpxHlMWdIeTOdmZyCqDdbRwMW3DNxFxFB/T6iG
         ZVquS1OwZmb3EL/tGIsEx0990dr2CGNeJRtClYWr3ovTkyT35zurONxD1aKpm87hJCbM
         OAp0UYSUdmsHWsK/11INGZ6EHn9zTWJLeIKKm1cvB8T71esy6/GokuJNlcPPTw+57mxG
         nVjIwPxFLhvyRgnJI+RYKa74LI7uJx+pgG+mzXybimuJ9iSdrpHLRaccsrEXktUU9Kh9
         0TBw==
X-Gm-Message-State: AOJu0Yx3LfSC3EM/dNjWulsEWU8LSzDBzl7pnsI8NGOZ7Pe9yFViE96k
        saNBOii05U5Guxm081bTaQ1ZHjsNbCazBA==
X-Google-Smtp-Source: AGHT+IFUyJg4cY4seE25ARQXiaapGP7j3LA7z8+pdyjsJsyW90DXEm0xU7PIeqvENYTBC0jJL23K+w==
X-Received: by 2002:adf:e88d:0:b0:317:5d1c:9719 with SMTP id d13-20020adfe88d000000b003175d1c9719mr8005347wrm.9.1692044975128;
        Mon, 14 Aug 2023 13:29:35 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:20e9:baea:a4f7:d880])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003fd2d33ea53sm15181223wmj.14.2023.08.14.13.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:29:34 -0700 (PDT)
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
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: [(subset) PATCH v2 2/3] riscv: dma-mapping: skip invalidation before bidirectional DMA
Date:   Mon, 14 Aug 2023 21:28:20 +0100
Message-Id: <20230814202821.78120-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

