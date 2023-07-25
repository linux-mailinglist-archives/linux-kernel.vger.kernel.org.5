Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05566761B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjGYOWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjGYOWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:22:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DC52682
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:21:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-314172bac25so4308305f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690294890; x=1690899690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UwYYe6ucZvdBvqF8iQhg0hDnshi1xav4hUdpbdxiqw=;
        b=WbIR7n/yzc9VAozw8Sk+VSB2504MVtOdu1vnFMj5noYjek5szstVImCB0Qp6a7sqFz
         Gz1gOgq/xvFNwR6NQej4DgG6nd0XEbv7N3vBqNr4x74ijnVGuP6dp2xAnyb09iyks1TD
         U3hriTLler5E7fm9b3s9X5Pv4EUZBMV+gFxGRvGwNfHZyV9OSzwvCZH1U0E6XOZvuUqY
         p07D4iEfPMttDvKhK+zGj8L1eAcWLj/Q3iN5wQ36akJ38bS8XiId2FJF9QSZk+K+/BxR
         fR8/8EV1BgMPvCEA5uZCfxHxHjuyY1xOUxXk1NtodoYq/XT1SGJTBfJWvqEg23Om2VK+
         P3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690294890; x=1690899690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UwYYe6ucZvdBvqF8iQhg0hDnshi1xav4hUdpbdxiqw=;
        b=ZeqqFJS+TJj92dg50qWlKyImV+JTzxRFCFI8QWhwYvBUlj7V9zXGp77Uxyeib1my9r
         bUtiX6h0GxbwT7Y3/4LtRzk3mboJi/K3hrFn92c3Rv2FJnGp0yTtOMHP6aMsX3Hhm8vd
         xG09a8IjAv7J2JjlYmzOr9larJK/szW07QTrEvsjwWcTRZfSpv4NxzpoUZJTWcD3UNaH
         AvGwcw6xBbczBkWDEaeSA5YCl61vpHqA00iWR/hpULpxb+NVddpnAZGYRbUIu7/wMsnv
         +yqRWAQ6+L9mxuF7KU9O8wi9X23z7e2/foFB2vCz32rsAYHoCT32UzHlvy0+4gDRZwW1
         czcQ==
X-Gm-Message-State: ABy/qLaj4aH4gHfIoTWPP8xmIIl+x9/JtCmMjyEuSgPTt+bwMdgPf4cA
        qQRTX6ycyZGM2lez80S1JK2/LQ==
X-Google-Smtp-Source: APBJJlHTPdf8WSeLzfqvdw+Iv3zNCwUMRolvKBj5Y5BArZHknPJjzTL9f7IYaGzso0TGmRYunEA55Q==
X-Received: by 2002:a5d:45c1:0:b0:313:ee5b:d4bc with SMTP id b1-20020a5d45c1000000b00313ee5bd4bcmr9304252wrs.5.1690294889769;
        Tue, 25 Jul 2023 07:21:29 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id x10-20020adff0ca000000b00314367cf43asm16503568wro.106.2023.07.25.07.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 07:21:29 -0700 (PDT)
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
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v6 3/3] Documentation: riscv: Update boot image header since EFI stub is supported
Date:   Tue, 25 Jul 2023 16:19:25 +0200
Message-Id: <20230725141926.823153-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230725141926.823153-1-alexghiti@rivosinc.com>
References: <20230725141926.823153-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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

