Return-Path: <linux-kernel+bounces-18799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43115826328
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 07:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53A21F22062
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A812B6D;
	Sun,  7 Jan 2024 06:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCsTqYG8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5230125D7
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 06:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ECEC433C8;
	Sun,  7 Jan 2024 06:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704609035;
	bh=ckVsfHPc3uK0acXNhDkgPvynqmwbCY5jhnAZ2B9HdkA=;
	h=From:To:Cc:Subject:Date:From;
	b=eCsTqYG8qyxe8fRsfIsaNUFD1aY9ZuwMfsio5Rb4HQcdp+0I1SAQWCSrfejm3FgCZ
	 tjSpuCavDeJ8oUUPEEH+yeHWN/VcmPuG/sf+MxmRCgY8TyNlBkrUWol7sRnt3u9YI9
	 S64ZOxA8IjsECZaRXfwf4U9+ywyzxNRu8dQPt/JbfvschQuPif1wP/EiUdlVRSJAhA
	 huM3a3mcUYyWsHGLgt8SFjl3mDt/ws2a0/OxJNLjwxENsO3guArJhq24U+Rn5E23Rn
	 5pI9ZYJxJ3fZiP99sO7TljaNVP/BOXU+FLOQ0Nu7xVyk/lzQogDmCd8GRP0YyX1NaV
	 bYmxD+B63GWAA==
From: guoren@kernel.org
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	charlie@rivosinc.com,
	guoren@kernel.org,
	panqinglin2020@iscas.ac.cn,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	leobras@redhat.com,
	cleger@rivosinc.com,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 0/4] riscv: mm: Fixup & Optimize COMPAT mode
Date: Sun,  7 Jan 2024 01:30:21 -0500
Message-Id: <20240107063025.1628475-1-guoren@kernel.org>
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
v4:
 - Add "Reviewed-by" tags

v3:
https://lore.kernel.org/linux-riscv/20231222115703.2404036-1-guoren@kernel.org/
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


