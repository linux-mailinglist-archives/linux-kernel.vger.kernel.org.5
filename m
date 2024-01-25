Return-Path: <linux-kernel+bounces-38805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699AF83C631
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20263294D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B475374E03;
	Thu, 25 Jan 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSvxk841"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E0745F1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195521; cv=none; b=V+DL+6UUxvv+sWOGPKTHCkjyCK5DvBuJpLcyfw2Sqp/A/9k/SYBQr+JSysIYHJsiqmrD96eFv4nXf9JRUxdYhhJ8/QfF2bF2zuiz0K+bkexuyGoXrnTR3d0zJlXUQAmVpyD1wHSdX0+pPuTUUr7EYPclo0rg5MqKp9oCYFWyTqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195521; c=relaxed/simple;
	bh=lQa90hyBkLuNQGPI6gmRovggw7RSn4HqbLkZoyCISio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGTfZGtww+cVeYN0R8uSyQKIFLPzsGUJjF4QTktwmMRTJsyia6hm3EiZn2SiWeHlhr0Upp8mLFJXcPRIUpwhTMOdTLMshBa5r+WEKVfvBbdd2/QiZcxA8TM+jfe6I2oidQ97VXAfkmD8feJhpWDrdSZlE4YlbZxuaTRtKZROWMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSvxk841; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08165C433C7;
	Thu, 25 Jan 2024 15:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706195520;
	bh=lQa90hyBkLuNQGPI6gmRovggw7RSn4HqbLkZoyCISio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DSvxk841kVJVmEf4He8NwMxVcYFLyFxsuI674Ebdd4b6L1RX4gAcaCYBnXUxFlaP7
	 p0a7XMaGgLwMu9eLSvy2e4HRngLmNotdK6jT+id/Ta+sSK5JumdHcVKChRiqAOTt7W
	 i45ayymlz9m5T36KREF7ZYyUxFYddYN8TuQXbVVhaEJYUGz5x0fuPv/L8ChhkvbNRV
	 gkI48DkJdAPmLS6vbaGRAx7xZRmzIzGt0AahTuW2S7d94uawJQm7xE5j0MJEHxhZt/
	 7UBJc/rrtAChZ916eK0pwGYfJv2j3KVEpscpLDQy1kWrRBdzJ7lCT+WnTt5esCkQME
	 Jr9iJ+lMf1/4A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3 2/2] riscv: cmpxchg: implement arch_cmpxchg64_{relaxed|acquire|release}
Date: Thu, 25 Jan 2024 22:59:07 +0800
Message-ID: <20240125145908.968-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125145908.968-1-jszhang@kernel.org>
References: <20240125145908.968-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After selecting ARCH_USE_CMPXCHG_LOCKREF, one straight futher
optimization is implementing the arch_cmpxchg64_relaxed() because the
lockref code does not need the cmpxchg to have barrier semantics. At
the same time, implement arch_cmpxchg64_acquire and
arch_cmpxchg64_release as well.

However, on both TH1520 and JH7110 platforms, I didn't see obvious
performance improvement with Linus' test case [1]. IMHO, this may
be related with the fence and lr.d/sc.d hw implementations. In theory,
lr/sc without fence could give performance improvement over lr/sc plus
fence, so add the code here to leave performance improvement room on
newer HW platforms.

Link: http://marc.info/?l=linux-fsdevel&m=137782380714721&w=4 [1]
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
---
 arch/riscv/include/asm/cmpxchg.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 2f4726d3cfcc..6318187f426f 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -360,4 +360,22 @@
 	arch_cmpxchg_relaxed((ptr), (o), (n));				\
 })
 
+#define arch_cmpxchg64_relaxed(ptr, o, n)				\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	arch_cmpxchg_relaxed((ptr), (o), (n));				\
+})
+
+#define arch_cmpxchg64_acquire(ptr, o, n)				\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	arch_cmpxchg_acquire((ptr), (o), (n));				\
+})
+
+#define arch_cmpxchg64_release(ptr, o, n)				\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	arch_cmpxchg_release((ptr), (o), (n));				\
+})
+
 #endif /* _ASM_RISCV_CMPXCHG_H */
-- 
2.43.0


