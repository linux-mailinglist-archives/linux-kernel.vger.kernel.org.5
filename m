Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBF47DAA26
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 01:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjJ1XOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 19:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjJ1XOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 19:14:00 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89A8191
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:56 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1ea4a3d0a44so2219336fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698534835; x=1699139635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MROdnZxFJAn7brM6ye/jIKPJcvVCbRqlgsjUSxtP0PY=;
        b=McM3n4oUqzaDTF5lv19KaayaUI9Y2y0FIeMtPE5+3B5VNGAmDxra6khHUcIZMLiWYx
         /cXpsmsAMrPSCGJP9u4T6ZhQ5ztdqDQ4AMcp0fVelgtBdUdqQaHxHU3IEJlymdJZt1qI
         B0QkLQFpNCu92n+pQ5RlbE+rk/mMuzQJJDzziF4YgST7qN5gmXCV3tDFZGl54VoW0G/r
         hx5UpLSUjbRswr/znEvQyoSiPnQ3OZhbA+K0IUfTJsTZWPgLfj8nJR0X+GOkl++t0DTK
         ud5KhNFzWfDdGiIm6fVXNmwZnQLlEhR7t90a66fai4CWu3aBKgm5n909vYvtu9QdVphs
         OLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698534835; x=1699139635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MROdnZxFJAn7brM6ye/jIKPJcvVCbRqlgsjUSxtP0PY=;
        b=XHnOdRNGLELzd0IkZlTnOnxEMSh+l99/q+tqDv+kNsqHR5Z1YAaU5L4UdkPgNdZqQV
         xSHe+jcrBaxOkCyZCdSuAU/iei5YXpzazij4bbwdMH8bkW8ES2dFbuLtf2c0yrQ/QSXz
         DlmvV7oZxcTEHYgFyLVw5wAR4b8KSX52sZrVMqMiNSYUc0Zn2fkM7QhRGj8HuPE77CXW
         0yFhuw998Pl97B9ldJwGVH8QZJyhEb23AuGi4C5tpXqgYnhQOFnfe/SN7/qqClDlVbLL
         XUDYTQ/pjsEQPxVjPlolCnerC128MHWEWtMy2CUwKmvuepcFA/uDaVwrlqubE31DXVJ4
         CIIw==
X-Gm-Message-State: AOJu0YwTAXJSGDQsIzyIu+a1yYqDn8onvtG9BZil1EcCH2k9OwvRjOKh
        f4xiRoun50rBzgJZcBqOQOaRdg==
X-Google-Smtp-Source: AGHT+IEpjr2TCXm5am55hbUBmsnjcw94CHvXcnlavbn7wyDrZYS6wclRzO1RWsfOFMjAji60OjxQDg==
X-Received: by 2002:a05:6358:5e08:b0:168:d6cd:7b2e with SMTP id q8-20020a0563585e0800b00168d6cd7b2emr6151237rwn.29.1698534835540;
        Sat, 28 Oct 2023 16:13:55 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001b8622c1ad2sm3679345ple.130.2023.10.28.16.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 16:13:54 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 10/11] riscv: mm: Preserve global TLB entries when switching contexts
Date:   Sat, 28 Oct 2023 16:12:08 -0700
Message-ID: <20231028231339.3116618-11-samuel.holland@sifive.com>
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

If the CPU does not support multiple ASIDs, all MM contexts use ASID 0.
In this case, it is still beneficial to flush the TLB by ASID, as the
single-ASID variant of the sfence.vma instruction preserves TLB entries
for global (kernel) pages.

This optimization is recommended by the RISC-V privileged specification:

  If the implementation does not provide ASIDs, or software chooses
  to always use ASID 0, then after every satp write, software should
  execute SFENCE.VMA with rs1=x0. In the common case that no global
  translations have been modified, rs2 should be set to a register
  other than x0 but which contains the value zero, so that global
  translations are not flushed.

It is not possible to apply this optimization when using the ASID
allocator, because that code must flush the TLB for all ASIDs at once
when incrementing the version number.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/mm/context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 43a8bc2d5af4..3ca9b653df7d 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -200,7 +200,7 @@ static void set_mm_noasid(struct mm_struct *mm)
 {
 	/* Switch the page table and blindly nuke entire local TLB */
 	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) | satp_mode);
-	local_flush_tlb_all();
+	local_flush_tlb_all_asid(0);
 }
 
 static inline void set_mm(struct mm_struct *prev,
-- 
2.42.0

