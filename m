Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B287E5184
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjKHIAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjKHIAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:00:53 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA48F192
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:00:50 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40839807e82so2718485e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 00:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699430449; x=1700035249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEPgDTMpIXvshpOSSpINtGH8/u8zbO38mo5vAWcHcCQ=;
        b=zK+/KzLYnCYjgj+AA77Pf451n8n+O0t1TlhJbOS25oxolH4SHXgafULBHmW9t7comH
         ZLrP/xDEZMnm4/sZicSe51ep/KhgTNLMvv3XyWvNaQWyuFV+aUrAJuzcY/Kt+1PAYMHS
         slmaGkobd3aNa8AusUpV8WnNX64tNXZ5NCq40OEDoxF43A08EUBYk1x/8DWj0fw+pR+H
         yPqT/qaZchlyDfPXcxmWEwWJUyoJXiL7HetMOF+Lt8/lgSwioSpVC6paOVKlxPUOWT7t
         9s5At5ioHj7uZWZV5nB4vUNOVCxdA0+jZN0Eq2q1mHmhTORMU5ob1QNZdsvMT/SLUN8K
         TAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699430449; x=1700035249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEPgDTMpIXvshpOSSpINtGH8/u8zbO38mo5vAWcHcCQ=;
        b=BgBpfRQy10+JkW+GLzuks9Znk8kG7HdPY3DvOVf6/5srEbHo+RVZJjNkCXMYpTJgPE
         r/gNnD3cfBA8qK5UxYIKE6E0DghjrmWJ8AlFmCuZbEVX3x4JtdzUGXd0+6mWCiZ+di+e
         FZDe8s/ldTMCoCALLN2pcnwyqbnJxru3tOUuGEEHOaM2iC+33iQy9OWfFXOb0mGpEelq
         cY/SEcXnGAlpp3y9cZYH5ZdF+FNPQOWcvNcKZoL4ZzwkaR+iHwKY6bckgqncLow8fy6h
         n5sKFfAWWYF/qLX6wEuQvD6+tTffUmNWJobN/O2JVnx/aH1lMkwLaGpJ56DfDSWJzOKE
         TAcQ==
X-Gm-Message-State: AOJu0YxZQRi2cJEyLRL1Nbzyq3yT4DKq/c93fgTQTk1I4l09Fyys1oK6
        KHgegWX0Ld9da3m+T9jVkcVT2w==
X-Google-Smtp-Source: AGHT+IGgFRraslXtVrVNm+Gd+pCruKXk0cuRYB74JEpgEQMyF+kTP3abCXagtaT+2hcD2YAAZd1MRw==
X-Received: by 2002:a05:600c:4f8f:b0:407:da06:2016 with SMTP id n15-20020a05600c4f8f00b00407da062016mr1241590wmq.12.1699430449297;
        Wed, 08 Nov 2023 00:00:49 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c419600b00401d8181f8bsm17679141wmh.25.2023.11.08.00.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 00:00:48 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH RESEND v2 1/2] riscv: Don't use PGD entries for the linear mapping
Date:   Wed,  8 Nov 2023 08:59:29 +0100
Message-Id: <20231108075930.7157-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108075930.7157-1-alexghiti@rivosinc.com>
References: <20231108075930.7157-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagating changes at this level is cumbersome as we need to go through
all the page tables when that happens (either when changing the
permissions or when splitting the mapping).

Note that this prevents the use of 4MB mapping for sv32 and 1GB mapping for
sv39 in the linear mapping.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0798bd861dcb..6dc61d3c392f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -664,16 +664,16 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
 				      phys_addr_t size)
 {
-	if (!(pa & (PGDIR_SIZE - 1)) && !(va & (PGDIR_SIZE - 1)) && size >= PGDIR_SIZE)
-		return PGDIR_SIZE;
-
-	if (!(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
+	if (pgtable_l5_enabled &&
+	    !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
 		return P4D_SIZE;
 
-	if (!(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >= PUD_SIZE)
+	if (pgtable_l4_enabled &&
+	    !(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >= PUD_SIZE)
 		return PUD_SIZE;
 
-	if (!(pa & (PMD_SIZE - 1)) && !(va & (PMD_SIZE - 1)) && size >= PMD_SIZE)
+	if (IS_ENABLED(CONFIG_64BIT) &&
+	    !(pa & (PMD_SIZE - 1)) && !(va & (PMD_SIZE - 1)) && size >= PMD_SIZE)
 		return PMD_SIZE;
 
 	return PAGE_SIZE;
-- 
2.39.2

