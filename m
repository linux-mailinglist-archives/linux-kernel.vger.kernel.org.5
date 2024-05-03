Return-Path: <linux-kernel+bounces-167359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDD08BA86C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AC2BB22647
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1CD14F9C6;
	Fri,  3 May 2024 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtlsxWpt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA6114F13D;
	Fri,  3 May 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723945; cv=none; b=nWkZqxrMisL5B/K8p8ZOiuGHHFG88wSKVU9nqFWUIjja9Cfi6gu2mbXmaa/iK5+5ZrFS//VndwyBDINgEwwtyABLgZ2JOcZLN17NFCkpaLB/055MbK/eTrgoR/6BpLhVwo3lFu05xKQksZIV0XbxRovDFKReWsvrL4uB+3wPX6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723945; c=relaxed/simple;
	bh=S72kpyHE5KwejYv2p4il2qEZxWETqb6oKhqe7/jS/J4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=heB5H+qU/hKMZQYbvxffmPt9L57xT9+7mN6ErBmIrAo0ylBZLtZOx/zZ/kSpAEsSicAVLk9I2Nx8YRZpsp60q5ddd/9W7CD++ByO9Mzp2K151b1ki0nVPDVZzwEhvDxWvJ/Reb9sXlJjE+2mLkREb8YgW+o3Faowekz9fo/QofU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtlsxWpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AFBC4AF1B;
	Fri,  3 May 2024 08:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723945;
	bh=S72kpyHE5KwejYv2p4il2qEZxWETqb6oKhqe7/jS/J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UtlsxWpt7JYxL7mqgO8k87+lad+jPXKC5UBzw/EonERJEmY3BYFomFzpWgtQTifE1
	 CUD6bf4+HkWqbgBwBli48xIHacx8p97AUrMXAtgPeeJih2yaXzAnrQxoYIgFoEc4bE
	 KbM04k9gsFoPz01s797sf1qnDQwjAJ9uz0Ei4MbkIo6gy3zAOiw2eyKkHNiQ+zSq89
	 KBtsKoQAbk0nhoahNd95GeVVUZuFzgemR+NsFKAKqMhsr2YfUo3zwvNtYgA432Hwcc
	 bil3WVyHCLVji6Y8eORlMmpMeqRshN0MGU9t0eRg3KuFOr74Sxmt1+Wth3igzZ1pSX
	 OE/HMwdHMYUGg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-alpha@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] alpha: core_lca: take the unused functions out
Date: Fri,  3 May 2024 10:11:18 +0200
Message-Id: <20240503081125.67990-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503081125.67990-1-arnd@kernel.org>
References: <20240503081125.67990-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

the only user had been drivers/char/h8.c, and that got taken out
and shot back in 2004...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/core_lca.c | 44 ------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/arch/alpha/kernel/core_lca.c b/arch/alpha/kernel/core_lca.c
index 57e0750419f2..4616b11643d5 100644
--- a/arch/alpha/kernel/core_lca.c
+++ b/arch/alpha/kernel/core_lca.c
@@ -471,47 +471,3 @@ lca_machine_check(unsigned long vector, unsigned long la_ptr)
 	}
 #endif /* CONFIG_VERBOSE_MCHECK */
 }
-
-/*
- * The following routines are needed to support the SPEED changing
- * necessary to successfully manage the thermal problem on the AlphaBook1.
- */
-
-void
-lca_clock_print(void)
-{
-        long    pmr_reg;
-
-        pmr_reg = LCA_READ_PMR;
-
-        printk("Status of clock control:\n");
-        printk("\tPrimary clock divisor\t0x%lx\n", LCA_GET_PRIMARY(pmr_reg));
-        printk("\tOverride clock divisor\t0x%lx\n", LCA_GET_OVERRIDE(pmr_reg));
-        printk("\tInterrupt override is %s\n",
-	       (pmr_reg & LCA_PMR_INTO) ? "on" : "off"); 
-        printk("\tDMA override is %s\n",
-	       (pmr_reg & LCA_PMR_DMAO) ? "on" : "off"); 
-
-}
-
-int
-lca_get_clock(void)
-{
-        long    pmr_reg;
-
-        pmr_reg = LCA_READ_PMR;
-        return(LCA_GET_PRIMARY(pmr_reg));
-
-}
-
-void
-lca_clock_fiddle(int divisor)
-{
-        long    pmr_reg;
-
-        pmr_reg = LCA_READ_PMR;
-        LCA_SET_PRIMARY_CLOCK(pmr_reg, divisor);
-	/* lca_norm_clock = divisor; */
-        LCA_WRITE_PMR(pmr_reg);
-        mb();
-}
-- 
2.39.2


