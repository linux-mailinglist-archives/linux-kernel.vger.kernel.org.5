Return-Path: <linux-kernel+bounces-9678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C4E81C972
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A021C226D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E7C17993;
	Fri, 22 Dec 2023 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgCgP9Hk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B776C17983
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50EEC433C8;
	Fri, 22 Dec 2023 11:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703246230;
	bh=5kuuzvzsTLj+b569PmL/dnbV7dULNml61yAjeVKDzIQ=;
	h=From:To:Cc:Subject:Date:From;
	b=hgCgP9HkXEwZHkP1Pup6spJ03f0E19AJjTl5UpglvdkcM6BudaR5a++14mPhrrPab
	 bk6qY6HzJK8JOg5GwVC06aXwEs2fZ25n95/SGPU1unTT7pmrV55NsPiJKHu+P3Nxrs
	 bqgyvBQw0nB8YE2jBMRJhowZsHX81LYW8b+wFt6ekZZk1f+YAlJ+XftF73RydTD3zc
	 FcOGamCgjiFglkfTQkT/NopwYvyv2iw0ixFlejMTDAD8uo9KuJgbNegmBVlxQuwIIT
	 ne/rCC5KPrwdcaQR3junEXDD41vUxKRJXMHUGWZzHVNe5mmHN37P5jT3MJlZN9j59d
	 0DbttuZ/gAIqw==
From: guoren@kernel.org
To: linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	guoren@kernel.org,
	david@redhat.com,
	panqinglin2020@iscas.ac.cn,
	rick.p.edgecombe@intel.com,
	willy@infradead.org,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	leobras@redhat.com
Cc: linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 0/4] riscv: mm: Fixup & Optimize COMPAT code
Date: Fri, 22 Dec 2023 06:56:59 -0500
Message-Id: <20231222115703.2404036-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

When the task is in COMPAT mode, the TASK_SIZE should be 2GB, so
STACK_TOP_MAX and arch_get_mmap_end must be limited to 2 GB. This series
fixes the problem made by commit: add2cc6b6515 ("RISC-V: mm: Restrict
address space for sv39,sv48,sv57") and optimizes the related coding
convention of TASK_SIZE.

Changelog:
v3:
 - Remove wrong modification of arch_get_mmap_end
 - Remove is_compat_task optimization
 - Update comment log

v2:
https://lore.kernel.org/linux-riscv/20231221154702.2267684-1-guoren@kernel.org/
 - Separate rename from fixup
 - Add STACK_TOP_MAX fixup for compat
 - Add Cleanup & rename patches

v1:
https://lore.kernel.org/linux-riscv/20231219111701.1886903-1-guoren@kernel.org/

Guo Ren (4):
  riscv: mm: Fixup compat mode boot failure
  riscv: mm: Fixup compat arch_get_mmap_end
  riscv: mm: Remove unused TASK_SIZE_MIN
  riscv: mm: Optimize TASK_SIZE definition

 arch/riscv/include/asm/pgtable.h   | 7 +++----
 arch/riscv/include/asm/processor.h | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.40.1


