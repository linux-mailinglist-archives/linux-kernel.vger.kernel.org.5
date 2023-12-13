Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC57811325
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjLMNlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbjLMNld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:41:33 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E88EF5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:41:39 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3363ebb277bso372257f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702474898; x=1703079698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ49MRAnZaoKSqZNsnflibhrI2GDBa//jCKbcK+lB+o=;
        b=eZ6eGpEurp11HPKzhLqCy/FIwIvrgmvRNkqTxnNllZt0+89VSoYQ9hmtkcJeH+eezp
         KkNopDSGu7/Olrr3OgKy5Ys1X1vCszIWDIYR8uF3X2SDuzU4y9dglBBF9RlopNAx/ZKB
         3+y7MKVlCKSwPhXKWsuu0KzvwpKn32+/kQ5topk09kApy/Rp5fyrusJqUzysiY5o0tdl
         0r47XK0NKRQDK7u4fWFBW2RH7OiCi1ZeFY7wjmBXuMYUqbMQhtS811WPvbgQU6U8Hvg0
         swZzQq1D3dl9OM0cVgyHGGLgrbAOA8VGLlz46+9MoQMqCVsGkfDgHQFC//gzj9RdqD7H
         5vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474898; x=1703079698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQ49MRAnZaoKSqZNsnflibhrI2GDBa//jCKbcK+lB+o=;
        b=vJnWroRjVkS+lyAnPPprFgEI+qZtTvPtWiTRVbsS2mgJlo5C2qThK9m6689kKRKFxM
         mwZ75c/himJ7kTte2QQQIDp11V97qkYnfuBMF3jIBZUpAUtycd8AVsXwdV1TEazqLIuk
         FMIUkgLBoADv6ylyyBLe1usMcpgYs+3mecjKSPmD/cKwnGPQ41tbTM2QmC2g6q8CrhU2
         AoJABghQIvHHV/VRiEUpNusEBfliUOsRmENp8ia088/P3Wxyf5Ww/l1ulPg+gc2vdg0P
         sNsyqHi0GWI3ceC04f7q263BuiXbiNzQvFDawiMVzaEr270EctG/xFeJCYdex/Y0/Dnq
         zTCg==
X-Gm-Message-State: AOJu0YxFlHXCNSn3g4Z3F7SGn8/PG51gIEd+wfG22QKfgK3NMMJQrEyY
        bHQUbnXtDBYQQqj5BHRUb6MICgEb/jUDuAfW10w=
X-Google-Smtp-Source: AGHT+IFledKSQxkLvWN5/hdYdgtJiVfumPSWSLZ+0cxSIF4oZd6/yqylAtH64M3UQVWfAY1CCImLFA==
X-Received: by 2002:a7b:c4ca:0:b0:40c:386b:9356 with SMTP id g10-20020a7bc4ca000000b0040c386b9356mr3819421wmk.72.1702474897639;
        Wed, 13 Dec 2023 05:41:37 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id bd21-20020a05600c1f1500b0040c25abd724sm23043332wmb.9.2023.12.13.05.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:41:37 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes 1/2] riscv: Fix module_alloc() that did not reset the linear mapping permissions
Date:   Wed, 13 Dec 2023 14:40:26 +0100
Message-Id: <20231213134027.155327-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213134027.155327-1-alexghiti@rivosinc.com>
References: <20231213134027.155327-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After unloading a module, we must reset the linear mapping permissions,
see the example below:

Before unloading a module:

0xffffaf809d65d000-0xffffaf809d6dc000    0x000000011d65d000       508K PTE .   ..     ..   D A G . . W R V
0xffffaf809d6dc000-0xffffaf809d6dd000    0x000000011d6dc000         4K PTE .   ..     ..   D A G . . . R V
0xffffaf809d6dd000-0xffffaf809d6e1000    0x000000011d6dd000        16K PTE .   ..     ..   D A G . . W R V
0xffffaf809d6e1000-0xffffaf809d6e7000    0x000000011d6e1000        24K PTE .   ..     ..   D A G . X . R V

After unloading a module:

0xffffaf809d65d000-0xffffaf809d6e1000    0x000000011d65d000       528K PTE .   ..     ..   D A G . . W R V
0xffffaf809d6e1000-0xffffaf809d6e7000    0x000000011d6e1000        24K PTE .   ..     ..   D A G . X W R V

The last mapping is not reset and we end up with WX mappings in the linear
mapping.

So add VM_FLUSH_RESET_PERMS to our module_alloc() definition.

Fixes: 0cff8bff7af8 ("riscv: avoid the PIC offset of static percpu data in module beyond 2G limits")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/module.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index aac019ed63b1..862834bb1d64 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -894,7 +894,8 @@ void *module_alloc(unsigned long size)
 {
 	return __vmalloc_node_range(size, 1, MODULES_VADDR,
 				    MODULES_END, GFP_KERNEL,
-				    PAGE_KERNEL, 0, NUMA_NO_NODE,
+				    PAGE_KERNEL, VM_FLUSH_RESET_PERMS,
+				    NUMA_NO_NODE,
 				    __builtin_return_address(0));
 }
 #endif
-- 
2.39.2

