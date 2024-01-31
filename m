Return-Path: <linux-kernel+bounces-46747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46B9844389
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB5A28A176
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922DE12A15E;
	Wed, 31 Jan 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="maakPQV0"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242963C7
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716777; cv=none; b=hBtU9h3rmycQC2/y6gmvSdaxt544ae7ctnW3yDgsACGeqoC3559jm4tq1BhiPy9b4g/VyR82FOtMe1PbIxXpeYmQQeiD+OGyp0ncM3D/x1xBdbtGpp7iecE92FnYmbzlL3/NY/XO8iIqVlyt32+wB+8Cd4TNbL39+UD8gNd9KFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716777; c=relaxed/simple;
	bh=KxTha3Sw2me4wQD2ZIVM7exaX0/yMCyxiR7mnGOFOLY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y6ZolBe4IvT8VEuEpZOuVavnNqknqF54KaKmklCkxg3xN6MROEmtHL0Curgt9cf3T1Yij3fz22DXw9XINx5WVl1NE6/ytJ+bEJgRUP4nKvj0o/z8BX+9UjV92ghaT6z2uu5WgjrlvGkfCb/0SCvoaItd7HPCktVYnLstD19PWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=maakPQV0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so55905675e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706716773; x=1707321573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJEZ1qPaiDldAW8C05rM2rqR0hTzPI1igVobAmalZsY=;
        b=maakPQV07x86hzoHNYT3i9Df3t0aUIyYaJz0NKQqd9fS0Op0GFcCCI5uP3CgSg6jsm
         UxQtDlKyWO6cPk/Es8dgXS/SM5OuymQnsKwJcGfjieeD76Tn125URTvOnGNdIljlsVF6
         jVM9tvzWL/fxuBlji8zYEcOFj63FT/rGYYSJJTexxSfMACZbojeXiw7aW5kwNix3mW/5
         7Fn9N8lD5yj7G3PLDw0CrdlSg0ft7FjyhMF7IyFmIC6LtfaQewAy8TaQmAGxZzcYS1Xx
         Vfnka022pNgNs67dfc7PgkAq7u1FM6nBZJqQJsvvFL7wVJRm3rAeYljaTwf/v7EWxhw6
         zggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706716773; x=1707321573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJEZ1qPaiDldAW8C05rM2rqR0hTzPI1igVobAmalZsY=;
        b=a9VjV+yFzYakWaIg52yr2kLM5hT0js1shJP2xG3IUlXKrPhZrbSYISca8XS8Evf0iS
         i8RnaxQ6Udo2o/jyG4YGxF4UwiKOm7MPJJ9TixBO3VMxeEhqxBK95xQsDVaL+Y2oKM9I
         41JLbbpfG69p3PM/CI2w8CQ/CYmNjN9sTHtON0082k9nhqETT9tKGECCn2wcWDw/rGr3
         nL6HwMSllLwolZGwTkKWU8Vb9NVLB6yW9q+PLpPFmTtANTmfeD7YnZr8gqaUIntcBpok
         kIzaI73fCByhi+osLJdXnCo19vAuBPNLObi7wsEzjNsiDiqR/nf3PL7GOWxJ2rAKoV97
         nG9A==
X-Gm-Message-State: AOJu0Yx/bgpbMybMUWmbYW3qSXB+XnHkTFtIK5koA7x8DZ6p+l67kjdS
	AMoku7gwF9I8wXUBwLDOWM1/RxW6UB9M1HbahPf1QS2J8bZNQc3hohXy92TP9N8=
X-Google-Smtp-Source: AGHT+IE0y4HMNlJGrQQF1/vBmusVf+vGvj5kGeOQLs8zgDMsoQ9mThbIK2SfMvCJNZS4ESF4P8sD+g==
X-Received: by 2002:a05:600c:468b:b0:40e:e834:3d86 with SMTP id p11-20020a05600c468b00b0040ee8343d86mr1590072wmo.37.1706716772821;
        Wed, 31 Jan 2024 07:59:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5toVRodwweHTcQIyYJFP2Sf3z6pJe8uOj3kJL8Bf9n+o3G8oH7qCtVvtBB6ZzANPh3d2Znisr/JVcpjb5tj+mnQOtD0bGrsmT4CRsS6KdtKyxWKOCl38Giy/mwdkpg1+QQxv40odbMZlnkY5SYdo2XLk0XdYDTp7WRoTnVpNlAlYCWWsQHxNfcLCDVAWDcXk3GvVdHhPFZ62Gx3ql6nSu6/WKzbRDqzGUIYgkgqpdB1vq50EO2ieKr+XUNsum2CV+pMMxiPj9TkdU06yVd81ZbG9I+ff7kAkhj9IowwAQm+N5BwHjhUoaeye58UCta73W6pRJRoGC3DvGN4oHjbsgUSKWyszDmS4NdxPTBbwp2RdU2Ks6e9clrZ+UECY6zRr/NAd2cDDBxGCLVOmgvb+jVeV5smy1Xly69fTl7+hY8866CxoOjFO1I48MgVF0UdOI5C1yuLuymZyybFPw6nm1nAcMitNsxXW/PlXLReWUH5BFV6Jriyq2AKNFsNYuHKk6srdfiXlJ0B77YIP+V0E/i01m7OxC/pDhPX+9RSpIvCQkc7ZVpcu7PMqJqsCDBi7cS4PdMDvYQwktSWOvXekDuYCwO0eKbSeWmguapyXy15tDZbbtoRH2ScNNIwiU21PKEtXagxXWu+FGng==
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id t24-20020a1c7718000000b0040f0219c371sm1926678wmi.19.2024.01.31.07.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:59:32 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Matt Evans <mev@rivosinc.com>,
	Dylan Jhong <dylan@andestech.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH RFC v2 0/4] Svvptc extension to remove preventive sfence.vma
Date: Wed, 31 Jan 2024 16:59:25 +0100
Message-Id: <20240131155929.169961-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RISC-V, after a new mapping is established, a sfence.vma needs to be
emitted for different reasons:

- if the uarch caches invalid entries, we need to invalidate it otherwise
  we would trap on this invalid entry,
- if the uarch does not cache invalid entries, a reordered access could fail
  to see the new mapping and then trap (sfence.vma acts as a fence).

We can actually avoid emitting those (mostly) useless and costly sfence.vma
by handling the traps instead:

- for new kernel mappings: only vmalloc mappings need to be taken care of,
  other new mapping are rare and already emit the required sfence.vma if
  needed.
  That must be achieved very early in the exception path as explained in
  patch 3, and this also fixes our fragile way of dealing with vmalloc faults.

- for new user mappings: Svvptc makes update_mmu_cache() a no-op and no
  traps can happen since xRET instructions now act as fences.

Patch 1 and 2 introduce Svvptc extension probing.

It's still an RFC because Svvptc is not ratified yet.

On our uarch that does not cache invalid entries and a 6.5 kernel, the
gains are measurable:

* Kernel boot:                  6%
* ltp - mmapstress01:           8%
* lmbench - lat_pagefault:      20%
* lmbench - lat_mmap:           5%

Thanks to Ved and Matt Evans for triggering the discussion that led to
this patchset!

Any feedback, test or relevant benchmark are welcome :)

Changes in v2:
- Rebase on top of 6.8-rc1
- Remove patch with runtime detection of tlb caching and debugfs patch
- Add patch that probes Svvptc
- Add patch that defines the new Svvptc dt-binding
- Leave the behaviour as-is for uarchs that cache invalid TLB entries since
  I don't have any good perf numbers
- Address comments from Christoph on v1
- Fix a race condition in new_vmalloc update:

       ld      a2, 0(a0) <= this could load something which is != -1
       not     a1, a1    <= here or in the instruction after, flush_cache_vmap()
                            could make the whole bitmap to 1
       and     a1, a2, a1
       sd      a1, 0(a0) <= here we would clear bits that should not be cleared!

   Instead, replace the whole sequence with:
       amoxor.w        a0, a1, (a0)

Alexandre Ghiti (4):
  riscv: Add ISA extension parsing for Svvptc
  dt-bindings: riscv: Add Svvptc ISA extension description
  riscv: Stop emitting preventive sfence.vma for new vmalloc mappings
  riscv: Stop emitting preventive sfence.vma for new userspace mappings
    with Svvptc

 .../devicetree/bindings/riscv/extensions.yaml |  7 ++
 arch/riscv/include/asm/cacheflush.h           | 18 +++-
 arch/riscv/include/asm/hwcap.h                |  1 +
 arch/riscv/include/asm/pgtable.h              | 16 +++-
 arch/riscv/include/asm/thread_info.h          |  5 ++
 arch/riscv/kernel/asm-offsets.c               |  5 ++
 arch/riscv/kernel/cpufeature.c                |  1 +
 arch/riscv/kernel/entry.S                     | 84 +++++++++++++++++++
 arch/riscv/mm/init.c                          |  2 +
 arch/riscv/mm/pgtable.c                       | 13 +++
 10 files changed, 150 insertions(+), 2 deletions(-)

-- 
2.39.2


