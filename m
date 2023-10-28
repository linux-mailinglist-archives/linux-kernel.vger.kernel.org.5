Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E947DAA25
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 01:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjJ1XOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 19:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjJ1XN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 19:13:59 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97110FA
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc3bb32b5dso3316305ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698534834; x=1699139634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8uQuAx5HbeGrqX4Ip/qQY7nv6lrxw4qacCJFbpKbko=;
        b=MmvkdMknLmTQClsjK8ugUVtqsyQmg6tVO/1w4J4VNZatWQs1MmVKK64hnOkzO21W//
         E1VkGeV2KWBlSEHmofbKNvp45//7TViS/QOFU8H5bJuRGRHtA2qdwXG/PFPs8aUy6BZp
         DREM4SCUqKv75EY3biEfCXGGjsewZoUJtklvl5QDDm1TWNI/jKM/0Kj8ClaM7dIWaiyv
         bILXd/eBfWblnwFScA7JHDxP5fWB9AfykeYDUdl9oSqTECQXg7k6Lu3f5VH8zD9LA/MW
         i8R6PWwSbdIEv7yVww+JTfQVTtVuc+XVRHxTgwWySboz+uqLlZxgqgsShzJZAQMAXKWi
         NxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698534834; x=1699139634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8uQuAx5HbeGrqX4Ip/qQY7nv6lrxw4qacCJFbpKbko=;
        b=HycajA64lMZKoyh+vP7GxH0lhHF/5wHEoTsG4N3v2W3PaZlVMwCaLhu+5uF/g4Csn6
         im1OjZMQMui8XJSJyDkhBw8jzAxnkyiCJw47NvS7qmwjdaXz/fPKPaNiGOV6knQcd/kk
         qbidbafSmyitq9fOUoUNnVwjJQ29AOL6K0LU3H2BjLg7iKae1cB4mpAWKvoTLOxWhDPC
         WnjjHRYuYtXmUbBraZ3cJIPYuDuvwerfk435DAzS5aICJ4oEv00NiIpEnkgA+Tvhcvuy
         4+koszpuIyhpxVywSud1dehaXiDjvbcWXZDEPsrnOSxH4IMlmVmCk0qmla8FI5nw4449
         0NoA==
X-Gm-Message-State: AOJu0YydTsaNld1ZSrdOIPArStVyCLjC+nspry7YYMWfPkbaX63WaQq/
        MA/dkDSwfSZnBUcqaOZhBHDeTQ==
X-Google-Smtp-Source: AGHT+IEXxDKHTizsqyBXjr5oqt/mWPSp5qFgTjueov73uPEcJh4MjB79gaQaqVj5Le1ZHH1qO9h3pA==
X-Received: by 2002:a17:902:c751:b0:1cc:29ef:df7d with SMTP id q17-20020a170902c75100b001cc29efdf7dmr3951181plq.65.1698534834011;
        Sat, 28 Oct 2023 16:13:54 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001b8622c1ad2sm3679345ple.130.2023.10.28.16.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 16:13:53 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 09/11] riscv: mm: Make asid_bits a local variable
Date:   Sat, 28 Oct 2023 16:12:07 -0700
Message-ID: <20231028231339.3116618-10-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231028231339.3116618-1-samuel.holland@sifive.com>
References: <20231028231339.3116618-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is only used inside asids_init().

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/mm/context.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index b5170ac1b742..43a8bc2d5af4 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -20,7 +20,6 @@
 
 DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 
-static unsigned long asid_bits;
 static unsigned long num_asids;
 
 static atomic_long_t current_version;
@@ -226,7 +225,7 @@ static inline void set_mm(struct mm_struct *prev,
 
 static int __init asids_init(void)
 {
-	unsigned long old;
+	unsigned long asid_bits, old;
 
 	/* Figure-out number of ASID bits in HW */
 	old = csr_read(CSR_SATP);
-- 
2.42.0

