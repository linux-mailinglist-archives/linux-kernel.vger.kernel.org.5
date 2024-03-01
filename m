Return-Path: <linux-kernel+bounces-88156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2864186DDF6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A751C20E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F426A351;
	Fri,  1 Mar 2024 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Aheax1MW"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B8E6A333
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284516; cv=none; b=HtDKKbfyx0ejvJdZ16vQatD7sBI01ZPg1zap6uQIhYNmaLC/E7MYMyzhIDyAJTr4yZWk14hx/2WNX/Q8Pe/UqLsolM5nZ0hXNazjWN35rxRV1p11bF20YPkomy9rNo4u3fjdK0Nth7i2d7NxMSM2HV/vJccJnRpOo5HA3PptlQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284516; c=relaxed/simple;
	bh=tygbM0Nx204YWVn0xR7lvxEmcEDYSAVTdjNO1AFVCW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gdrjn2e1nInB8rfFOwXzk/ZUmr0/ous5ktODgNrWZ5WmfLdqkNURgNIqN1xEraT08M34M8Fvd+ShS2sfPwc9hCBsm/9s215ugwEvhEBZZrVnrrkmtFHrG0rz8aQb+5AgApDduiUSw0pAvZ27UVqnLbwsoRZXfgvWHTx5RyRsBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Aheax1MW; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d38c9ca5bso902127f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 01:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709284512; x=1709889312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yprVHevcC7ppzCMdOTaT3VuCvD5AQnHTkhMmW9/Yos8=;
        b=Aheax1MWECDmSkRbYs+jWeYwHCclhaa0KCo7ak+xiUPHkv7JhVV7L1MDXpLhHRjTV3
         WdLFXpr6oBA7f+kJScZLFBaKl8c7L+O7u4gbQ3jqe0jGObxCQijzdro5ALdU9Icg16t+
         I0FlYXPXPwytxdf7qJLyY+fz2eHHm4NOqTiSFCuEjkrmXjoFItmJvs2ydMnHXEXl24V9
         +ZOUYV/MqxTr/Sdw1spB+lBc50FmrnCekiuquSEaSxborj08UUJnuIPkGN7ry8EL0v4i
         PoVZ9HT+pTn4iaum1OQzicI9316Yk6MAaZiLHhqKxlRvvRwcggN/L7Z0N6l61KA8CzW8
         GaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709284512; x=1709889312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yprVHevcC7ppzCMdOTaT3VuCvD5AQnHTkhMmW9/Yos8=;
        b=XLp8Ewgp2IN+fvuqrUNCHAgjqMBNGPirVfjBuscOlNUZ/lJMnEOrjgqhknLqo5FdfD
         5+9kpTV/ViKB8MTvrdtKIVUnpePPPq0sYPXBoV6nXyEePOgHYSXNtDMtL2sqX5F5qTYE
         U2Wa8+Eb7/UCrniJ4/+SRZtqhwgXw7rH20yAb3N0482V7RS5JiLYtFXAyMNhzDHbBEFa
         CQ9HzGMvULxsUxIQcZyXtkLxuep0+HqnL2Yy1l3kvFeOQsx5R96kdUtBIeXK4IQRYu4z
         Vo1+ZMht645RGzLFzNi2gaPfZDjAp4lKEX5M617IpVx/O2HIlO2f0H3Jv9Pf0DGC0bCq
         3Z/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeDDuHjBscr3mQzarnDGL5/Sx0C20rnn8RRmkQ6cwaZZxPNAKILuHqAt1IyqnT+uYG/9oUt5hQCgKLcjXgdqQhLC0ue2UDCpQTThe5
X-Gm-Message-State: AOJu0YzCLXAj8a4Zm9INYiTkrBKt4c+lbZtP7NCs66qUQdCHsZ440MaF
	m+xzeKCUkpt8b+JRQgPIM36eBv7fp+PmXEeYB3kCH+jOYfDrhItkNIINVGgrDbc=
X-Google-Smtp-Source: AGHT+IHOEB7Wl0w/DP1jjp+wZ9IsZZPSGTyde6CCE7SA3irG+PXIOR/BUSU4UaYePPTrZ+YxqlSQWA==
X-Received: by 2002:a5d:5284:0:b0:33e:d27:2e40 with SMTP id c4-20020a5d5284000000b0033e0d272e40mr820688wrv.11.1709284512017;
        Fri, 01 Mar 2024 01:15:12 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d5503000000b0033dabeacab2sm4022712wrv.39.2024.03.01.01.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:15:11 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 0/9] Merge arm64/riscv hugetlbfs contpte support
Date: Fri,  1 Mar 2024 10:14:46 +0100
Message-Id: <20240301091455.246686-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset intends to merge the contiguous ptes hugetlbfs implementation
of arm64 and riscv.

Both arm64 and riscv support the use of contiguous ptes to map pages that
are larger than the default page table size, respectively called contpte
and svnapot.

The riscv implementation differs from the arm64's in that the LSBs of the
pfn of a svnapot pte are used to store the size of the mapping, allowing
for future sizes to be added (for now only 64KB is supported). That's an
issue for the core mm code which expects to find the *real* pfn a pte points
to. Patch 1 fixes that by always returning svnapot ptes with the real pfn
and restores the size of the mapping when it is written to a page table.

The following patches are just merges of the 2 different implementations
that currently exist in arm64 and riscv which are very similar. It paves
the way to the reuse of the recent contpte THP work by Ryan [1] to avoid
reimplementing the same in riscv.

This patchset was tested by running the libhugetlbfs testsuite with 64KB
and 2MB pages on both architectures (on a 4KB base page size arm64 kernel).

[1] https://lore.kernel.org/linux-arm-kernel/20240215103205.2607016-1-ryan.roberts@arm.com/

Alexandre Ghiti (9):
  riscv: Restore the pfn in a NAPOT pte when manipulated by core mm code
  riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
  mm: Use common huge_ptep_get() function for riscv/arm64
  mm: Use common set_huge_pte_at() function for riscv/arm64
  mm: Use common huge_pte_clear() function for riscv/arm64
  mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
  mm: Use common huge_ptep_set_access_flags() function for riscv/arm64
  mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
  mm: Use common huge_ptep_clear_flush() function for riscv/arm64

 arch/arm64/Kconfig                  |   1 +
 arch/arm64/include/asm/pgtable.h    |  59 +++++-
 arch/arm64/mm/hugetlbpage.c         | 291 +---------------------------
 arch/riscv/Kconfig                  |   1 +
 arch/riscv/include/asm/hugetlb.h    |   2 +-
 arch/riscv/include/asm/pgtable-64.h |  11 ++
 arch/riscv/include/asm/pgtable.h    | 120 +++++++++++-
 arch/riscv/mm/hugetlbpage.c         | 227 ----------------------
 mm/Kconfig                          |   3 +
 mm/Makefile                         |   1 +
 mm/contpte.c                        | 268 +++++++++++++++++++++++++
 11 files changed, 456 insertions(+), 528 deletions(-)
 create mode 100644 mm/contpte.c

-- 
2.39.2


