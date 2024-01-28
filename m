Return-Path: <linux-kernel+bounces-41594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FE183F51B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DF21C20F02
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5548E1F19A;
	Sun, 28 Jan 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkhrNOQ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E91EB2C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706440983; cv=none; b=RBi+1JpipCZWPzC1XkKtJOR+beCtbw2mVSkRSufIQHqXoE5iLNqX/6xp4Rba5pRZRlE/9bS7xKt+M/cf1juFnrKT3nAXr4dnLlkcdAHhNVSReVPNUOIXrMq6EXSGOYV2BxxCduWqUHgqfwHC6B1L7Z1tCogGU+QdXX2uCI4SOmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706440983; c=relaxed/simple;
	bh=FoqEX1cRVe0NITYGpOghxAdM7Y1pgwLjfNaiHFus6Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmZLhrieAMekWi1ffc8AQuU946H5MpkkDli1v3tmPNVu89sInI9ChQOdSpJLdZKFX0jMw9XszMYJDQhEe+kDyQ5jP/3L3QkWJDETvu7jktyQD9dUfHANSa/fa1nTlDmS1atnPDPWYQ4VLNHIU4BxhhpvvLOF42s7656xFUddzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkhrNOQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE08DC433C7;
	Sun, 28 Jan 2024 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706440983;
	bh=FoqEX1cRVe0NITYGpOghxAdM7Y1pgwLjfNaiHFus6Ts=;
	h=From:To:Cc:Subject:Date:From;
	b=EkhrNOQ6ulzMyD9V4IxKWn9bKK2oTSCUhJqxcv3YDM1s9DanNaBph3qAaJ16mTOoC
	 9iGbMhn9M6p641OQhYqNYOQcFJd9nnWNphe22vARm+EjUAQJYIwZPBReBGGy7cPAQH
	 zdUlJsivPFe0HRbgC3XUXAPSxAC71dDBbnB8bh7kPj3CiiN7RZuZrBCBayCogEL/Au
	 YRt+IPQ85RTh8IOXU6ORn7kufldUbS7AVBeo3JGdWoqHu4VD9YgEreLiFfAq1i8uvm
	 SXet5T3SpLyS3YzUmTPZOvYEd9hug4TUK0CYSH+N4+qIX5VqAOlg3jnCamLyHUAlHT
	 g0/FbtHw78raw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] riscv: optimize memcpy/memmove/memset
Date: Sun, 28 Jan 2024 19:10:10 +0800
Message-ID: <20240128111013.2450-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is to renew Matteo's "riscv: optimized mem* functions"
sereies.

Compared with Matteo's original series, Jisheng made below changes:
1. adopt Emil's change to fix boot failure when build with clang
2. add corresponding changes to purgatory
3. always build optimized string.c rather than only build when optimize
for performance
4. implement unroll support when src & dst are both aligned to keep
the same performance as assembly version. After disassembling, I found
that the unroll version looks something like below, so it acchieves
the "unroll" effect as asm version but in C programming language:
	ld	t2,0(a5)
	ld	t0,8(a5)
	ld	t6,16(a5)
	ld	t5,24(a5)
	ld	t4,32(a5)
	ld	t3,40(a5)
	ld	t1,48(a5)
	ld	a1,56(a5)
	sd	t2,0(a6)
	sd	t0,8(a6)
	sd	t6,16(a6)
	sd	t5,24(a6)
	sd	t4,32(a6)
	sd	t3,40(a6)
	sd	t1,48(a6)
	sd	a1,56(a6)
And per my testing, unrolling more doesn't help performance, so
the "c" version only unrolls by using 8 GP regs rather than 16
ones as asm version.
5. Add proper __pi_memcpy and __pi___memcpy alias
6. more performance numbers.

Per my benchmark with [1] on TH1520, CV1800B and JH7110 platforms,
the unaligned medium memcpy performance is running about 3.5x ~ 8.6x
speed of the unpatched versions's! Check patch1 for more details and
performance numbers.

Link:https://github.com/ARM-software/optimized-routines/blob/master/string/bench/memcpy.c [1]

Here is the original cover letter msg from Matteo:
Replace the assembly mem{cpy,move,set} with C equivalent.

Try to access RAM with the largest bit width possible, but without
doing unaligned accesses.

A further improvement could be to use multiple read and writes as the
assembly version was trying to do.

Tested on a BeagleV Starlight with a SiFive U74 core, where the
improvement is noticeable.


Matteo Croce (3):
  riscv: optimized memcpy
  riscv: optimized memmove
  riscv: optimized memset

 arch/riscv/include/asm/string.h |  14 +-
 arch/riscv/kernel/riscv_ksyms.c |   6 -
 arch/riscv/lib/Makefile         |   9 +-
 arch/riscv/lib/memcpy.S         | 110 -----------
 arch/riscv/lib/memmove.S        | 317 --------------------------------
 arch/riscv/lib/memset.S         | 113 ------------
 arch/riscv/lib/string.c         | 187 +++++++++++++++++++
 arch/riscv/purgatory/Makefile   |  13 +-
 8 files changed, 206 insertions(+), 563 deletions(-)
 delete mode 100644 arch/riscv/lib/memcpy.S
 delete mode 100644 arch/riscv/lib/memmove.S
 delete mode 100644 arch/riscv/lib/memset.S
 create mode 100644 arch/riscv/lib/string.c

-- 
2.43.0


