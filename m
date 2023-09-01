Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C7178FC19
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbjIALKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjIALKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:10:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EA1107;
        Fri,  1 Sep 2023 04:10:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31781e15a0cso1500419f8f.3;
        Fri, 01 Sep 2023 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693566610; x=1694171410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eoe1/ChVUjSFSmLUE4WJGxelcTGXE6vWPUltvYJLI+4=;
        b=K25Fe3k5PQoXWOnGHlhTqdVkpVIQPPnqhJscXGDrt6Y5DN+qGiZf2FnDjyEzK/uPdN
         15kurwyWFMGNRrhRJRkaP4BVXDq7TvAgtNKj/sHqApP1YfpgR7GKuleVM8+9Ris0jcTo
         iGPolgd0EK+CPdyf2J3zZDb7QzEJuP+yiYP/384InNcOEOAvxefkat+lq7lgFob3rMFT
         k85RGyCGz0RHCKTt/4Pqg3FElyrxMKGqKLLofT3G5jl/JpUzBh8QBTl78Cg9oEOd+33t
         jK7zJCX0JJ0euAOaP9HWyRt4eqzCRMKrsg7aicrccdR8FoGHD5HFF+j6DgmsBweSeOOY
         d8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693566610; x=1694171410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoe1/ChVUjSFSmLUE4WJGxelcTGXE6vWPUltvYJLI+4=;
        b=Mk8EBR+FCL+uEtoms+bSz6XCtXsnf2o3fOY88+pr+GLzLWfLtcH+TCHrYdxO4sQBUw
         Qms8E5jZNhY0cglhaV7Vs7VciSX02dSlD3Qnfaw4zY1TWyTffIF33AWsRYv+/f0WLtDr
         81n7BXdayPKVvKrifCbEMaDfcfhp1M1ktKGfgKujMp1qdbFgIIJ7Bx8Oh0AMNxbr2eFO
         bPAr6ryvtxKUEFuvay6TU5ag4dca5HwNHladYr+MBQ16Xc7IuEI8fZuJqiCrlAaK4W67
         TNh8i+c3SNM5Lexm0n1PeklCPBKCiFB7YCNyuKsVvPthCmKjG3owh2/Qssei106cCxSt
         nJnw==
X-Gm-Message-State: AOJu0YyOF6sMi1sld5DQxukARBEiFdy5oh1aA/vEWgBx5t6vgy3fdHt3
        kqMsKGPkIsBTZxetBa5bhVU=
X-Google-Smtp-Source: AGHT+IHWXkKNZTnWFwfPFYrEdVN56j+KTfn8NoHTCp1OoCCvz7p2z92KmuU46u1Sh7AgXE5ITnNM7Q==
X-Received: by 2002:a05:6000:4b:b0:314:34dd:aaec with SMTP id k11-20020a056000004b00b0031434ddaaecmr1689758wrx.8.1693566610033;
        Fri, 01 Sep 2023 04:10:10 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:64d6:8737:b80d:a298])
        by smtp.gmail.com with ESMTPSA id h8-20020adf9cc8000000b0031c612146f1sm866827wre.100.2023.09.01.04.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 04:10:09 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] soc: renesas: Kconfig: For ARCH_R9A07G043 select the required configs if dependencies are met
Date:   Fri,  1 Sep 2023 12:09:36 +0100
Message-Id: <20230901110936.313171-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

To prevent randconfig build issues when enabling the RZ/Five SoC, consider
selecting specific configurations only when their dependencies are
satisfied.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308311610.ec6bm2G8-lkp@intel.com/
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 67604f24973e..5a75ab64d1ed 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -334,10 +334,11 @@ if RISCV
 config ARCH_R9A07G043
 	bool "RISC-V Platform support for RZ/Five"
 	select ARCH_RZG2L
-	select AX45MP_L2_CACHE
+	select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT
 	select DMA_GLOBAL_POOL
-	select ERRATA_ANDES
-	select ERRATA_ANDES_CMO
+	select ERRATA_ANDES if RISCV_SBI
+	select ERRATA_ANDES_CMO if ERRATA_ANDES
+
 	help
 	  This enables support for the Renesas RZ/Five SoC.
 
-- 
2.34.1

