Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0C67F3B02
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbjKVBIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbjKVBId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:08:33 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769FFD49
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:26 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6c115026985so6307211b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700615306; x=1701220106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MROdnZxFJAn7brM6ye/jIKPJcvVCbRqlgsjUSxtP0PY=;
        b=HQj+34PuOvMXL7ecc/kUppXI1cRtaZlO8glozZvsZ6jQc5lf6H79mfMraLq8jhQn82
         A984J/GFHnRxzJComBteltfgeESCtWYnIxRiG5+BMtsYt0OcjpKbHoi821Eh0Z7vmPFx
         zDXjYHpYmjSkQFQnnCHDB8wuVQqKl9/fiHtW7enbaJlkYsO0QCJfGO8iqmBIbG4WxV+n
         7zSLZhoV1frwMRdatBxyBQsx8Zyes2gY9AdYAKaocvjID3j6VjNuA5cpmwywaeiWaYPV
         OeKKMj5uMcrSapv80IoASjSRJuUtWcCMeUXVQTV1YxZx6IlGWY48abFVth1jmnXEz6T3
         2w5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700615306; x=1701220106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MROdnZxFJAn7brM6ye/jIKPJcvVCbRqlgsjUSxtP0PY=;
        b=sA6fGDHdbkpAS01mDaxllQrPqpWdsiP7/puD/MRVyaPxgIFLxkL51ibptxPoJ99vQm
         b74x1hmdHlaJ0hdCMPaVLXtjMJBe9Fkfpfz7TZ77+XUTW0emyF+ZN+uZMFod02+U1fM2
         otteYSPB2dtJkcT696X44OK3XHdPor3sBDZ8aLRJEJp0uUNw14SU2TkA3afqGog56S3U
         Vxub3JlhIKo5nDWM0dsOusXiyhTg1BhzHYQnXaDVrOYiTiI7vNA6PM5xehITESB7zdPm
         0vp/47h09FetMv0t3UIe69vXlWc0d+2tFnU4MVj+bBPMtoOSZjv8iYmbD7inBFEb1ltp
         dzCg==
X-Gm-Message-State: AOJu0Yw2IItFvXBQOKMvi70H28/cQN4EK8mUOEiSXXKetz60t0P/2J/n
        r6il5zwkZuJLs2Fc4g3RhWcvHhw8+jQPZnqizIY=
X-Google-Smtp-Source: AGHT+IFVZu+XEimHfZXOsjvtj11LrkIBAYyBlYwN/UfpJ7aqLGYZgxb4tCN+mMPanboANiNPoJtK3w==
X-Received: by 2002:a05:6a00:b54:b0:6cb:a1fe:5217 with SMTP id p20-20020a056a000b5400b006cba1fe5217mr1041980pfo.16.1700615306009;
        Tue, 21 Nov 2023 17:08:26 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056a00324500b006be047268d5sm8713961pfb.174.2023.11.21.17.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 17:08:25 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 7/8] riscv: mm: Preserve global TLB entries when switching contexts
Date:   Tue, 21 Nov 2023 17:07:18 -0800
Message-ID: <20231122010815.3545294-8-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122010815.3545294-1-samuel.holland@sifive.com>
References: <20231122010815.3545294-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

