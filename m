Return-Path: <linux-kernel+bounces-59656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DA484F9F0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F303C28F7CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72557EEF5;
	Fri,  9 Feb 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pROYfgBW"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3AA7AE6D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496955; cv=none; b=H+xuDkTFwvwgctz/KyiMpBSfVcvx+vsDkQPmV/0joOhdsNBfIe6c/k707YyesnyxZTNNnFxsOWSMUtHqLZOUlvDkR5W65VZ0+/PfU5KhbOouQUKKKEEoYu226mEGbocVWuVa9OpJh6iQByJMd9qYDOOkxl0Rq7YQYdR1505EdCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496955; c=relaxed/simple;
	bh=73v1jlcrUjX+TThF8BCM1EfyndATwh2pzzht7eMkx9c=;
	h=Date:Subject:CC:From:To:Message-ID; b=jXOJUXDhod30h+KBDWxU9AskyN4OUYU2PRAdng1Z+7vDn2qSZd2QN/ICu10sslYuYmRgLeD0VHRaDgw6O6n84KgN3JbPhKFxDwsO/69RMLNI+q+UIrc8jVBrvCo4L36nrEB8+MZTdTkc6ea8s2qVHmL2xmRd7Jxv/YajVJw4n38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pROYfgBW; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e05d958b61so988992b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707496953; x=1708101753; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1v5hrasURtpD/QMj4+535HVGtxG6NrfgYnEY0yoBLM=;
        b=pROYfgBWkZzcv4Y6k29KMRuJB26LoShh9ZObkmLfsomkLX687Uovc7BY7w03lrxVG2
         vgI39l1Rx/ZqKbiHUAtOkWC/lkpQHVIDJAHgN8dhdGrQxR48SL/UstQjzuPlCQ20ULPQ
         LVuoihyH/FxGHTTkQepCuAwWVA5HHxckY4wWxMgsFSl+YGNXu2ZiFo+K/LZy7GjN8z9Q
         L48LxtrwQDe1Ex3i7IXrNdaL03xCb8f4UGPAyAghALrXsP5SSAes4xRTu0j/2vUusXX6
         mnHCZsOx2APW4zE2OutpD1+w7cp4AYTWC0leCmk03dpVM/yNeTz7oFoV1h28cxdi5DBW
         fgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496953; x=1708101753;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1v5hrasURtpD/QMj4+535HVGtxG6NrfgYnEY0yoBLM=;
        b=sv9e5N1d7mkspcBTBBpvn7K1J8NoiKy0AoIulhFB+F3KnBynLH3pWESHIWdXMLLm4J
         YTG+IafexbvXekung/YAriSCVUL/JOnHkwtI1oDx+3sqQ6/A/HJPI4XJFs5mNW71nV+E
         DQ1zRVtQ2Nr80luHPARFtdXyTeAVJnl3gvUSYwYl4xHz8+EuZJ7wU96+qOb2iWXxKKLB
         xJBiGqOpJBphjz8sS6R0M6MfsP34lANG+jTiEdhHKlETAhd03MpsRsJ3jpMHYtWl1x0B
         cTuvQJQhNsdgA5iuZ7u/T+0hFiJu4qfTv7GzVkFxzH4ogJfKD5MmbWvADew73DP6V13t
         TyJA==
X-Forwarded-Encrypted: i=1; AJvYcCVAoLgaHeJPfas4mPsbeOILJEmaNNfq2wmUfOZjnL18Mr3xiztKwdGwqAP2ma2n/jX5ALUDlZVXnd9jL1qbb8qn3FRbU7kGzdbNcqYn
X-Gm-Message-State: AOJu0Yz97VfMlW5nTafulUH1v+B89rxsEjBeNJmir6rbSpmC17zeG9tF
	NvDXanHscbWkGH9yd9AJ3C/K55Vy3v/keheHF7lM6W3nSZXnjHvvGl+fpaZP1drhkAxiP+DiQ5j
	Q
X-Google-Smtp-Source: AGHT+IHQ8ulGq5yLVFV55EPMdjwvCn4c4QEOlCrtTBjH67j3LIx3p7IRoBVmzb9VXfX8b1kwPgADgg==
X-Received: by 2002:a05:6a20:6f88:b0:19e:a3cc:2496 with SMTP id gv8-20020a056a206f8800b0019ea3cc2496mr2620520pzb.10.1707496952759;
        Fri, 09 Feb 2024 08:42:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWn5RWWHW8OAa0SKSbuR1orGWLhvB+3zYtjirNj6oNZzHvH3Co8RgbpDbPSFdNKd55FRmpA6YKQv494p3WCS1VpeoU/AC8QH5n9f3Hn
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id x40-20020a056a000be800b006dde10a12b6sm722039pfu.211.2024.02.09.08.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:42:32 -0800 (PST)
Date: Fri, 09 Feb 2024 08:42:32 -0800 (PST)
X-Google-Original-Date: Fri, 09 Feb 2024 08:42:19 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 6.8-rc4
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-cb58eea8-c84e-4aaf-ab71-f445d3b46de0@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.8-rc4

for you to fetch changes up to 3951f6add519a8e954bf78691a412f65b24f4715:

  riscv: Fix arch_tlbbatch_flush() by clearing the batch cpumask (2024-02-07 10:19:37 -0800)

----------------------------------------------------------------
RISC-V Fixes for 6.8-rc4

* A fix for a missing TLB flush during early boot on SPARSEMEM_VMEMMAP
  configurations.
* A handful of fixes to correctly implement the break-before-make
  behavior requried by the ISA for NAPOT mappings.
* A fix for a missing TLB flush on intermediate mapping changes.
* A fix for a build warning about a missing declaration of
  overflow_stack.
* A fix for a performace regression related to incorrect tracking of
  completed batch TLB flushes.

----------------------------------------------------------------
Alexandre Ghiti (5):
      riscv: Fix set_huge_pte_at() for NAPOT mapping
      riscv: Fix hugetlb_mask_last_page() when NAPOT is enabled
      riscv: Flush the tlb when a page directory is freed
      riscv: Fix arch_hugetlb_migration_supported() for NAPOT
      riscv: Fix arch_tlbbatch_flush() by clearing the batch cpumask

Ben Dooks (1):
      riscv: declare overflow_stack as exported from traps.c

Palmer Dabbelt (1):
      Merge patch series "svnapot fixes"

Vincent Chen (1):
      riscv: mm: execute local TLB flush after populating vmemmap

 arch/riscv/include/asm/hugetlb.h    |  3 ++
 arch/riscv/include/asm/stacktrace.h |  5 +++
 arch/riscv/include/asm/tlb.h        |  2 +-
 arch/riscv/include/asm/tlbflush.h   |  1 +
 arch/riscv/mm/hugetlbpage.c         | 78 ++++++++++++++++++++++++++++++++++---
 arch/riscv/mm/init.c                |  4 ++
 arch/riscv/mm/tlbflush.c            |  4 +-
 7 files changed, 90 insertions(+), 7 deletions(-)

