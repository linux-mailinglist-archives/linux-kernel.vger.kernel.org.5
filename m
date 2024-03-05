Return-Path: <linux-kernel+bounces-93039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7DA872A0B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A3DB2386F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9D512D1F4;
	Tue,  5 Mar 2024 22:18:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62E118E29;
	Tue,  5 Mar 2024 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677117; cv=none; b=f9d9Di1UOzjOCpj1QgwaK0pKMNvcfZKUvEKK/y8Gb+lCMCYfvYv+wZs0OQkVW/T6M0B1WacO+nWJEgd1ubSpHmLBKtSNFr6MxceB5Qti+FZYgGk7iNuvGk7yhNcx5ccYjGsGoMAFUp6DhEW1vrBJqYSwoeyQ8Jk7bT+gEXgrrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677117; c=relaxed/simple;
	bh=rOMbBrw6dKCy0QI69rgKxwVJpe5Z9XH8c/ETM0PM1tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/J33RPTTNB1NzxVPtw4QDnqNDZkyPV12rZrJuH4xaeCyymzxjg9zSTyT29VMTuDqL1wQOBJVW2YM1c5oo+Z9ppTyGdrkUj38z4Wn+BXm35x9f7VP4ifmem8SiX0s9x9akdI2YMVi15LMdTUgV3IEVqkvItJtSiYTFoQ6hsOvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E73031FB;
	Tue,  5 Mar 2024 14:19:05 -0800 (PST)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 990143F738;
	Tue,  5 Mar 2024 14:18:28 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	keescook@chromium.org,
	Jason@zx2c4.com,
	gustavoars@kernel.org,
	mark.rutland@arm.com,
	rostedt@goodmis.org,
	arnd@arndb.de,
	broonie@kernel.org,
	guohui@uniontech.com,
	Manoj.Iyer@arm.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 0/1] Bring kstack randomized perf closer to unrandomized
Date: Tue,  5 Mar 2024 16:18:23 -0600
Message-ID: <20240305221824.3300322-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Currently with kstack randomization there is somewhere on the order of
5x worse variation in response latencies vs unrandomized
syscalls. This is down from ~10x on pre 6.2 kernels where the RNG
reseeding was moved out of the syscall path, but get_random_uXX()
still contains a fair amount of additional global state manipulation
which is problematic.

So, lets replace the full get_random_u16 in the syscall path with
prandom_u32_state(). This also has the advantage of bringing the
randomized and unrandomized overall syscall performace much closer
together. Although in the syscall path, prandom_u32_state() remains
measurably worse than other architectures relying on non-random
functions (cycle counters) with respect to perf/latency
measurements. By comparison, the algorithm presented in the RFC which
had basically no impact given recent OoO cores are able to hide all of
the overhead from the the handful of additional instructions.

I'm still looking for suggestions reseeding prandom_u32_state() if
needed or improving the performace of get_random_u16. so consider this
somewhate more than an RFC and maybe less of a full patch request.

RFC->V1:
	Replace custom inline RNG with prandom_u32_state

Jeremy Linton (1):
  arm64: syscall: Direct PRNG kstack randomization

 arch/arm64/kernel/syscall.c | 42 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

-- 
2.43.0


