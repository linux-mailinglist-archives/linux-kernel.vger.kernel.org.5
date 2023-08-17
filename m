Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FA877F75C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351332AbjHQNLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351220AbjHQNKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:10:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC86C3A94
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:10:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5257e2b5d12so3003177a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692277782; x=1692882582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dia79abijhqNuyOI1X7cuUqq5ei10OSh1lyxFY8ZqEI=;
        b=3nb6Lx91hP38MJ3GLl8uaDcXhmdsFacX63aBoL59zCMgJncHjeenKLbguGHpu3TTET
         3CAawoe5G94N+Zlg0PjwH+2WnqRPe3YDrJPMrPzQHaT0FI6oiSgOYnaIM2iiSt7hMkx1
         JXe0yDUxjjCa67x2MTZagetgaYShcRqgjxGBDh6Al02vtsCsgSm4dXmSnDNPl9g4DdYU
         GDN9edqu/82jOUuqLQuz2DVd3EWcnUVWvVVvY8SygZZ/Hjs1bXVaRZDAEu0IKkSVW6DK
         hx7/Sl76DMH9q2ilOlpGLf4ueapRgEXDufjufHMeOcHsnUf/s+wgpSVFP2vUZAuwQBHt
         dwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692277782; x=1692882582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dia79abijhqNuyOI1X7cuUqq5ei10OSh1lyxFY8ZqEI=;
        b=gJEjNi0BI5PK8MD0/Zzsw1UtEId5g32eRRW1dOWHSbiEQw7Pt+o5AsnIK0hSrqZw7d
         EhfmltFaWU2jYTzNyV/YVIR8fGvlRlN1+S33OaFa0cL8RbYJfJQvbzR/DpFhhwQqDCnZ
         JYSi2i7wlfMIOmP2pqR1Yzl1yjp1xkdi+hJT/kBZeDacVE/AsnUAc/Lz18U3MwlwaMZz
         ESJar3sLlDsKjJ/EeVVjrx07EllsgIzJWDYPRHAg14v7BD3yWHuI6xc8XTs4ByNCmnnb
         I4bfEx/ccjIKMvCC1vvgtqb0F7sGvDi8tSwamanBYZhPoglvek6Emoe1+mESTT1ooyco
         OeDA==
X-Gm-Message-State: AOJu0YxbluOMSIulU0Y0PuN4NP9VEwo7napLW0KbR343cF3nEr8dA80G
        06qMZ2UKUCnKkIzfAFMfIoMVvw==
X-Google-Smtp-Source: AGHT+IHPEG0Uf4bUW9nG0gFKJH77vR45Ar5vo3OmomUBR3HmWHPm8EAlptOc0vd76nvl6VVmMrqFKg==
X-Received: by 2002:aa7:db58:0:b0:522:3a37:a463 with SMTP id n24-20020aa7db58000000b005223a37a463mr4006086edt.20.1692277781929;
        Thu, 17 Aug 2023 06:09:41 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([77.205.22.0])
        by smtp.gmail.com with ESMTPSA id h2-20020aa7de02000000b005232e637c24sm9912829edv.84.2023.08.17.06.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 06:09:41 -0700 (PDT)
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
Subject: [PATCH v7 3/3] Documentation: riscv: Update boot image header since EFI stub is supported
Date:   Thu, 17 Aug 2023 15:07:34 +0200
Message-Id: <20230817130734.10387-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230817130734.10387-1-alexghiti@rivosinc.com>
References: <20230817130734.10387-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

