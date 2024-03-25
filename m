Return-Path: <linux-kernel+bounces-116930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D8888A544
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985071F24AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C23515AD9D;
	Mon, 25 Mar 2024 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiBSWOIG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A08153BD3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365834; cv=none; b=guzMXryiSfOvmQnMWUzDzP9+02FgbtV9bQ7S3NVFt+sFWchALXsmBQlZuUIluk+CISJpLml+1yB/EetC31tplTfRgytLMV0o9LLQwFG6Y1VCrye1hsNqqNVVaCaVZ3m3r0uP59y4d8azXywfJiFAWQ/7Jezo8hUZHAMjLHZXY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365834; c=relaxed/simple;
	bh=qqT5s5v8kHRYnSn/7vdNCIRU1OWwV2sCCtz6w1JM1Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MuzapkAZdQbpqiFm2B14R18HRplbFxLxWAPcrjscD76aGJxpP1383MKh8SvqdBpYCjDXMwTM1TUIivr/plo6LHGp3+Bw2IkPwXvsdfH0+nHpFapatzQ5XqYky2ubYjx5ILz5GN5Ech9kQ8C9Ktdd4IhEQifZphNxGE5+kv/g9sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiBSWOIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34608C433C7;
	Mon, 25 Mar 2024 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711365833;
	bh=qqT5s5v8kHRYnSn/7vdNCIRU1OWwV2sCCtz6w1JM1Uc=;
	h=From:To:Cc:Subject:Date:From;
	b=eiBSWOIG2pSRASD6PO69pP2hPiCQKWE+AVg6i3TV6bCwHMH0ewGmYQ5ChxBRots+j
	 xacNlooNv1+qpgk4aXRe7X7q/Xtp0lmkwDmQa2xDL5MCgekHdADjWqmisgwY+eq8kR
	 dKhEY8AejhTpwQ+aup/+I78sGVjl0prRB3+f7UZuZrWuYi9140owjxaW2EibMAt/V/
	 JGVdl75CbIyxVe1lYaVyF7w3/YGvOrgN7XraaaW/J5Y3QW88ByToMWLYLGj9H5kLbd
	 QIJR5zGm7tUotSa7Q5Zycx/pu3mw9zqKtEN+DnQjddKKAP9ZLHTo8qeSebTVJlFuT0
	 evMHazH1Sj2Gw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 RESEND 0/2] riscv: enable lockless lockref implementation
Date: Mon, 25 Mar 2024 19:10:36 +0800
Message-ID: <20240325111038.1700-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series selects ARCH_USE_CMPXCHG_LOCKREF to enable the
cmpxchg-based lockless lockref implementation for riscv. Then,
implement arch_cmpxchg64_{relaxed|acquire|release}.

After patch1:
Using Linus' test case[1] on TH1520 platform, I see a 11.2% improvement.
On JH7110 platform, I see 12.0% improvement.

After patch2:
on both TH1520 and JH7110 platforms, I didn't see obvious
performance improvement with Linus' test case [1]. IMHO, this may
be related with the fence and lr.d/sc.d hw implementations. In theory,
lr/sc without fence could give performance improvement over lr/sc plus
fence, so add the code here to leave performance improvement room on
newer HW platforms.

Link: http://marc.info/?l=linux-fsdevel&m=137782380714721&w=4 [1]

Since v2:
  - rebase on v6.8-rc1
  - collect Reviewed-by tag

Since v1:
  - only select ARCH_USE_CMPXCHG_LOCKREF if 64BIT

Jisheng Zhang (2):
  riscv: select ARCH_USE_CMPXCHG_LOCKREF
  riscv: cmpxchg: implement arch_cmpxchg64_{relaxed|acquire|release}

 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/cmpxchg.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

-- 
2.43.0


