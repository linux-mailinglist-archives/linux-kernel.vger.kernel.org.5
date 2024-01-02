Return-Path: <linux-kernel+bounces-14921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC2E822477
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFDB1C22CCD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79D019BDC;
	Tue,  2 Jan 2024 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NX5xwfDX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DCF18B0D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28ca63fd071so1666557a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704232908; x=1704837708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MROdnZxFJAn7brM6ye/jIKPJcvVCbRqlgsjUSxtP0PY=;
        b=NX5xwfDXegsIZdZeD3oMwQwMHll3o+dryBRf6MwNR6F6IX4VNOGzcoupwUi0hInOhr
         h6sF53qbIWdDZj6Qgu4O+pdeZ+C9CECw8Y7lwEU4TONlqJ9Q8wa8OzdNURP/c/bf2QQc
         ro0tzJ7vCnxgAUvDgSgLW9K4RFISSOKH43jgvpkaFvYEEtN4TMa+QSZhoNyyTWW+sgc8
         YNS5kZFkfxv2lcIiMzufz2EQ8x+nGWpgKxnoG87ULrnUExvhQiFHPka+bgs7NfgAkuLe
         bQe19ylYJbvD8Xl448n8aB/05Vt5ui5sGcmfLmpAonKKDwtmm37SxcSLb0u68c9NTOFx
         rVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232908; x=1704837708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MROdnZxFJAn7brM6ye/jIKPJcvVCbRqlgsjUSxtP0PY=;
        b=UFqMNXlOfX78Q7InhSbI15FSi2sm+mJwX/taC0GkxQbM/6aP6Luk1Qahjrx3lf/gjN
         iMZtGkeiFeyrb3rHzlzsbkYkXCBnhlAM+L+/i8GMr2/SDhM7WofFLxSilR/+ppoKo5EA
         wGDCJO76jeWKxdE/eRmi8RLrvb/j8zgYiltkFIHCg/DAEc5ZY5Mkjwm/nEkr5nNFztUR
         PdzJbSSVkuQP+FRwXP5rl2rLhizl2qxr2j6kJBslYmh2LRqnhT8tvhLliBEbIem75xfE
         ZvUe37x2Ic5j9F2DtxdqjW3MROZ+ORGrujKeAmmRa3iP6CWMiflPQEpDePC2Iv/vUn0g
         iNGA==
X-Gm-Message-State: AOJu0YxOUlChG7ngwFnuj78SiRsgv46pNcq0Z+H4pVIa8552e+AVby6V
	tE9EAKHBb7LD00JnNaxcApNF3hvAC3N93g==
X-Google-Smtp-Source: AGHT+IFQ4MdRufOELZ2z13xg7yZ/1JoYbB5tE+2va7NZu/tN1uOevH1SKPh+nsWqBiMa4TjGPndiZg==
X-Received: by 2002:a17:90a:5c82:b0:28c:2e1f:8bf2 with SMTP id r2-20020a17090a5c8200b0028c2e1f8bf2mr4930306pji.84.1704232908323;
        Tue, 02 Jan 2024 14:01:48 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id r59-20020a17090a43c100b0028ce507cd7dsm101724pjg.55.2024.01.02.14.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:01:48 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 11/12] riscv: mm: Preserve global TLB entries when switching contexts
Date: Tue,  2 Jan 2024 14:00:48 -0800
Message-ID: <20240102220134.3229156-12-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240102220134.3229156-1-samuel.holland@sifive.com>
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


