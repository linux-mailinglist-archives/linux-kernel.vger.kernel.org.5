Return-Path: <linux-kernel+bounces-13651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03494820A5E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B725282A73
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE7E320C;
	Sun, 31 Dec 2023 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3VrHiZc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE27323D9
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 08:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49B3C433C7;
	Sun, 31 Dec 2023 08:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704011406;
	bh=aZhtYj/T/UdJIfbSV07e0EOQZDtYDIT0xAMU5nB5hU0=;
	h=From:To:Cc:Subject:Date:From;
	b=D3VrHiZcMw2M0LJxuM7GYDRB+1Fb/LQKhlkIV7VDradB7BcD7/1uLIRcy8sy2gzjO
	 Oui9ZAwWD87lisYtxCBg3NgC1Ekuw+knyUqyBH2HCrLcNDtZI8xUrojoyoE2Lc9Lwz
	 WDJKnyNIjh23gm1qbRyq3XeW+itsHf72Mwo47ZRkr89HiSFnQeUq22qpaapK9j1MZr
	 bj6JfNvAIiXqCLG9B7xKi58so+NL+B3olYel9NIsApj8iljT24Ldi6iZMd7WOebAqL
	 A/iDLywTaiIMiBfgcRu6QATP7wRJx9qozUH/iel95RD5bp3NKY/5VPEiKkS6mIkRbL
	 MBOlezQSLb8QA==
From: guoren@kernel.org
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	guoren@kernel.org,
	panqinglin2020@iscas.ac.cn,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	leobras@redhat.com,
	peterz@infradead.org,
	keescook@chromium.org,
	wuwei2016@iscas.ac.cn,
	xiaoguang.xing@sophgo.com,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	uwu@icenowy.me,
	jszhang@kernel.org,
	wefu@redhat.com,
	atishp@atishpatra.org,
	ajones@ventanamicro.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 0/3] riscv: Add Zicbop & prefetchw support
Date: Sun, 31 Dec 2023 03:29:50 -0500
Message-Id: <20231231082955.16516-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

This patch series adds Zicbop support and then enables the Linux
prefetchw feature. It's based on v6.7-rc7.

PATCH[1] - Add Zicbop support
PATCH[2] - Add prefetchw support
PATCH[3] - Enhance xchg_small

Changelog:
V2:
 - Separate from the qspinlock series
 - Optimize coding convention with last review advice
 - Add DEFINE_INSN_S type in insn-def.h
 - Add CBO_PREFETCH_I/R/W

V1:
https://lore.kernel.org/linux-riscv/20230910082911.3378782-4-guoren@kernel.org/

Guo Ren (3):
  riscv: Add Zicbop instruction definitions & cpufeature
  riscv: Add ARCH_HAS_PRETCHW support with Zibop
  riscv: xchg: Prefetch the destination word for sc.w

 arch/riscv/Kconfig                 | 15 ++++++++
 arch/riscv/include/asm/cmpxchg.h   |  4 +-
 arch/riscv/include/asm/hwcap.h     |  1 +
 arch/riscv/include/asm/insn-def.h  | 60 ++++++++++++++++++++++++++++++
 arch/riscv/include/asm/processor.h | 16 ++++++++
 arch/riscv/kernel/cpufeature.c     |  1 +
 6 files changed, 96 insertions(+), 1 deletion(-)

-- 
2.40.1


