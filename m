Return-Path: <linux-kernel+bounces-8702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD43181BB42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBF61F291EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AD153A07;
	Thu, 21 Dec 2023 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrvCX2NR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08192539FB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CF0C433C8;
	Thu, 21 Dec 2023 15:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703173630;
	bh=kiqcXfXL35XMTeW6LgSFV5UBR45DHKjf0aHb7WV1Q6o=;
	h=From:To:Cc:Subject:Date:From;
	b=VrvCX2NRzdN56Vj6vo6B2owEq0363n04aNvjwwnCDzGzAwP8C+WlYYEAG/YbPxFYc
	 X9q0XurKsMmHBVFyXRtadePJJoRivLqTBgfiZGPCkiM1ByqZbFYi84FbeUlIBdd5ya
	 pIBVPuyfrZKqxUTH61mHbux0ojhnBR3oowvTfilT9EUNm6EEG7JrWrMNTYGsRXydOS
	 KJb+/QUX1wz04E5XjTEOB7bRQ9wowlmjjzxpiuFnvvTUadPEsFeXTsdXyiZVxuftOx
	 2KZry1dmY59wIrVGh1jY5rRbi1Dl8fVj+ES2RmLwjP5TXwxa/+LRRZ3EOxFIubJiLE
	 DSz5aN2+eY0Gg==
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
Subject: [PATCH V2 0/4] riscv: mm: Fixup & Optimize COMPAT code 
Date: Thu, 21 Dec 2023 10:46:57 -0500
Message-Id: <20231221154702.2267684-1-guoren@kernel.org>
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
v2:
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

 arch/riscv/include/asm/pgtable.h   | 9 ++++-----
 arch/riscv/include/asm/processor.h | 6 ++----
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.40.1


