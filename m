Return-Path: <linux-kernel+bounces-38801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75CC83C628
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C8DB24E08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFA06EB71;
	Thu, 25 Jan 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tue9wRNh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254FB6EB55
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195517; cv=none; b=WhqFdIu4mS/W1SZI+XjVuVucDY9TxPFU7L2inqw+c7Oh3MbRCnYtyBHmWujjLfxgoE/i0LeLuaKCsPC+BXDxbe2wacqJNvFqA/iA3VomO7fPX8nd9ZRLTObio9fWlWan0hx3zRYXUeJeNBx6qZHlN9/zsp1nj3Jxmgk4y4U8CiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195517; c=relaxed/simple;
	bh=qqT5s5v8kHRYnSn/7vdNCIRU1OWwV2sCCtz6w1JM1Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RosvTBAcgjTlCIWnr+Y7esN83kbQnidY2mpsiGg11ZRxXfenK8Ik4A8z4xOXhp8MW/ApjZFszC5xJzO9OpoU8A75Y5oyM+qG8SK5OK7vMTlaM7aDEoTUmkEtu1Pm2XmQ1S0o4GE6h1Ni29IiatKCSGLHUGLO9LkRqsPqgF5rSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tue9wRNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4302C433B1;
	Thu, 25 Jan 2024 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706195516;
	bh=qqT5s5v8kHRYnSn/7vdNCIRU1OWwV2sCCtz6w1JM1Uc=;
	h=From:To:Cc:Subject:Date:From;
	b=Tue9wRNhjMqZFzK9146TlHqSh0uS3ptUAk+FbgZLPMoo5orbTE+F/5izGNNkfxOnL
	 cSpfL9FJ7/q3eNwQhDZTh4C7UzTy5Rz2tGw84k3NlUHq0VtjAYRNS9NwXMWGgy6cBA
	 8Mv4z7gyOxW46+SAVZYb41ehlqkVFEqWK0AFEJLuq2QgX4+kDMfe45s5i9yfEa4dIF
	 6asoOd75OLoQXMMJQOhKt0DuCwVCycuNQgR2CaArJsLts1byjJ9bfGhbD+XTnLs5Ui
	 zUJ8G/U2/VczZsQR+2qtSouhJn5K68Wty5B84vIVtkJbwdGsPq2SSkHIZvCWZgWfax
	 PMXyVsmyAsroA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] riscv: enable lockless lockref implementation
Date: Thu, 25 Jan 2024 22:59:05 +0800
Message-ID: <20240125145908.968-1-jszhang@kernel.org>
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


