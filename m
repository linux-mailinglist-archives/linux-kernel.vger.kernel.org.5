Return-Path: <linux-kernel+bounces-10891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 598CE81DE20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 05:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60CA1F21428
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 04:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BEF10F1;
	Mon, 25 Dec 2023 04:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qrat2D9m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E039EA6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 04:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E6BC433C7;
	Mon, 25 Dec 2023 04:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703480091;
	bh=UArUSyBZsPKxLkpUFilgpFD8aka1iX7bL7/0EeJ4W9s=;
	h=From:To:Cc:Subject:Date:From;
	b=Qrat2D9mqhj5ram8CGulN/a4AthJQBzq+uzfRUGEqVXSIEIdizPmerD1Gb9BqkX5j
	 yOScpSvVveHperCPxKtZsxuFilvN/6urpCPsJfjdZTndKgpLv72pa3/9tTaDrfvutM
	 Nzu5gTXzT+kiqck1CCNcUEqWq3AV+HIyWsp+2zID73GSrcNmCUeAH0iDwet5KQiJs+
	 +77xdqrGRHyrPTZZt8KuNkIjRBj/ahjruXT35opTqY58rphamGKD+utB3Bm/EJlNUr
	 OfW4KpJjZWz8zfl4rLRmu+uanCkWxztq3OKLNvol0FDa+ASb4dvwpiMThiFiPWizz6
	 SPmxwG+W4/eNA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Qingfang DENG <dqfext@gmail.com>
Subject: [PATCH v4 0/2] riscv: enable EFFICIENT_UNALIGNED_ACCESS and DCACHE_WORD_ACCESS
Date: Mon, 25 Dec 2023 12:42:05 +0800
Message-Id: <20231225044207.3821-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some riscv implementations such as T-HEAD's C906, C908, C910 and C920
support efficient unaligned access, for performance reason we want
to enable HAVE_EFFICIENT_UNALIGNED_ACCESS on these platforms. To
avoid performance regressions on non efficient unaligned access
platforms, HAVE_EFFICIENT_UNALIGNED_ACCESS can't be globally selected.

To solve this problem, runtime code patching based on the detected
speed is a good solution. But that's not easy, it involves lots of
work to modify vairous subsystems such as net, mm, lib and so on.
This can be done step by step.

So let's take an easier solution: add support to efficient unaligned
access and hide the support under NONPORTABLE.

patch1 introduces RISCV_EFFICIENT_UNALIGNED_ACCESS which depends on
NONPORTABLE, if users know during config time that the kernel will be
only run on those efficient unaligned access hw platforms, they can
enable it. Obviously, generic unified kernel Image shouldn't enable it.

patch2 adds support DCACHE_WORD_ACCESS when MMU and
RISCV_EFFICIENT_UNALIGNED_ACCESS.

Below test program and step shows how much performance can be improved:

 $ cat tt.c
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>

 #define ITERATIONS 1000000

 #define PATH "123456781234567812345678123456781"

 int main(void)
 {
         unsigned long i;
         struct stat buf;

         for (i = 0; i < ITERATIONS; i++)
                 stat(PATH, &buf);

         return 0;
 }

 $ gcc -O2 tt.c
 $ touch 123456781234567812345678123456781
 $ time ./a.out

Per my test on T-HEAD C910 platforms, the above test performance is
improved by about 7.5%.

Since v3:
  - adopt Eric's suggestions, such as better Kconfig help msg and so on.

Since v2:
  - Don't set "-mstrict-align" CFLAGS if HAVE_EFFICIENT_UNALIGNED_ACCESS
  - collect Reviewed-by tag

Since v1:
  - fix typo in commit msg
  - fix build error if NOMMU


Jisheng Zhang (2):
  riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
  riscv: select DCACHE_WORD_ACCESS for efficient unaligned access HW

 arch/riscv/Kconfig                      | 14 +++++++++++
 arch/riscv/Makefile                     |  2 ++
 arch/riscv/include/asm/asm-extable.h    | 15 ++++++++++++
 arch/riscv/include/asm/word-at-a-time.h | 27 +++++++++++++++++++++
 arch/riscv/mm/extable.c                 | 31 +++++++++++++++++++++++++
 5 files changed, 89 insertions(+)

-- 
2.40.0


