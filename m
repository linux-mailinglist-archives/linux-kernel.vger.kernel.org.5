Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9B575DBF3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGVLhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGVLhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:37:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72984359F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:37:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fd2f298712so1197185e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690025826; x=1690630626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dia79abijhqNuyOI1X7cuUqq5ei10OSh1lyxFY8ZqEI=;
        b=gFee1fF2iHGRz/47PvRpgdT+WGD2XMVbRI8srdPWpV/H/ekYNozwb9X2w7LVg1vhqJ
         dJhrqklruLlhNCN9gBDAU0H1z3leeaE+LMDwDyXzMIvQBbqQs2yqQpqSb3wtDy/Vhu4C
         wPeyOXc4bW50dYHy2+gn9P0XAT9YoOfoFyEo33miDMeQZbfIVrqoqInBJEbGD4UxPbqf
         S/3gIVuW5No5OH8wZE2MwF0L8GweSWBRAp+rFhmLLi/ymXv5NKZ1C1FOwVOyi1VQ/P4E
         34BJHPg2i0pWbYC8Fa9RfQUcOaqipWJCDB2TPdtLBxNakWNze1BE2ThgCD3uk3x/b4jx
         RqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690025826; x=1690630626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dia79abijhqNuyOI1X7cuUqq5ei10OSh1lyxFY8ZqEI=;
        b=IUKb0/C+o8AIo2KzUk+Q+PhOBNUaNR/vUiRlzuY1aZM2+fT+3mAXmDeomP5w7i3V9H
         wapIwuJsyH+JTuCL5zoAG4Ld0qB6nDSBlXrXOIVXum5oYVb767fDQz5W2Qi2n6COH45x
         ti5L978GmLzXz9x1FlfVfzKG8qlkFf1k+oo+VMPUIxzbb5ipND4mt0nL+1qhqM03Yf9G
         OU6XnesbAT5f+BzMv/zrlASNmPsVlhKne5nGvPEoTnnPVKa8P/AaXyBVLNo1zBmcJcnO
         Q8q94FjLMVP1IfGhvmMQ4Co02+/u5h5mfAvbrNd8s6pg/hMpeAjOS7UWO/UGnul7oRph
         Ru0w==
X-Gm-Message-State: ABy/qLYCnBDRukAt5i2BlJacQCJdUN0yZ0rorMbcbgN6CjbrCcBtJEiu
        pvX52NtMaZQoR2yAfx4HE/uVoA==
X-Google-Smtp-Source: APBJJlHdUFYwWBgP9YwVZejWD0BEkyDQp4m0NFOwqwPjXSpnUNHV74dw2XItoce9Xsv4xVzhgDkR1A==
X-Received: by 2002:adf:f3c5:0:b0:314:32b6:af3 with SMTP id g5-20020adff3c5000000b0031432b60af3mr2740008wrp.5.1690025825975;
        Sat, 22 Jul 2023 04:37:05 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id c16-20020adfe750000000b0030fb828511csm6728788wrn.100.2023.07.22.04.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 04:37:05 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v5 3/3] Documentation: riscv: Update boot image header since EFI stub is supported
Date:   Sat, 22 Jul 2023 13:34:45 +0200
Message-Id: <20230722113445.630714-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722113445.630714-1-alexghiti@rivosinc.com>
References: <20230722113445.630714-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
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

The EFI stub is supported on RISC-V so update the documentation that
explains how the boot image header was reused to support it.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
- Changes in v5:
  * Rebase on top of docs-next

 Documentation/riscv/boot-image-header.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/riscv/boot-image-header.rst
index a4a45310c4c4..df2ffc173e80 100644
--- a/Documentation/riscv/boot-image-header.rst
+++ b/Documentation/riscv/boot-image-header.rst
@@ -28,11 +28,11 @@ header in future.
 Notes
 =====
 
-- This header can also be reused to support EFI stub for RISC-V in future. EFI
-  specification needs PE/COFF image header in the beginning of the kernel image
-  in order to load it as an EFI application. In order to support EFI stub,
-  code0 should be replaced with "MZ" magic string and res3(at offset 0x3c) should
-  point to the rest of the PE/COFF header.
+- This header is also reused to support EFI stub for RISC-V. EFI specification
+  needs PE/COFF image header in the beginning of the kernel image in order to
+  load it as an EFI application. In order to support EFI stub, code0 is replaced
+  with "MZ" magic string and res3(at offset 0x3c) points to the rest of the
+  PE/COFF header.
 
 - version field indicate header version number
 
-- 
2.39.2

