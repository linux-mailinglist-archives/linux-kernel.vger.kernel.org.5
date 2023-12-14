Return-Path: <linux-kernel+bounces-97-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE41813C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E26EEB2115A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EA92DF66;
	Thu, 14 Dec 2023 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaHAZekm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A026E5A5;
	Thu, 14 Dec 2023 20:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0499BC433C8;
	Thu, 14 Dec 2023 20:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702587326;
	bh=sO1yA3MRFf7NVPe6oN00hj9uMaVI9YFdkLzhks1q7xs=;
	h=From:To:Cc:Subject:Date:From;
	b=eaHAZekmu/N5erIKFfGzhRDNO5t75fWETQ9YjN8yvzstAhL0Sqyi8dqcn7TknLe6a
	 tMhh+Cw9ZSufkdTJeRJvFDrGpIX5CUR3WU6fFZQmPOpZm0N/E6snMfj4/gcmU03APc
	 FOC3WJZxv7dQb7aMCWWm+rQs+rosQQ/6tsjx0wJzNGbcuV2t+N1egYm0eJIDr+IBxO
	 4t1r3LtLB6S25UU3CdzQZtie4f4BHV8ssLi4/VgP18muqnGCqqUI2utkFnWuBTuM4+
	 Ovf4DtpUfdlR4jor2kxIVRKU4vKjjCrV2B9uCCIZnb5BCcIT+q5hk+76gwXgT8njqP
	 EnIRgEnAWiK3w==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"kernelci . org bot" <bot@kernelci.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Zi Yan <ziy@nvidia.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mips: fix r3k_cache_init build regression
Date: Thu, 14 Dec 2023 20:54:47 +0000
Message-Id: <20231214205506.310402-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

My earlier patch removed __weak function declarations that used to
be turned into wild branches by the linker, instead causing
a link failure when the called functions are unavailable:

mips-linux-ld: arch/mips/mm/cache.o: in function `cpu_cache_init':
cache.c:(.text+0x670): undefined reference to `r3k_cache_init'

The __weak method seems suboptimal, so rather than putting that
back, make the function calls conditional on the Kconfig symbol
that controls the compilation.

Reported-by: kernelci.org bot <bot@kernelci.org>
Fixes: 66445677f01e ("mips: move cache declarations into header")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
My broken patch is currently in linux-mm, so the fix should
be applied on top.
---
 arch/mips/mm/cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index e5d19f4a38ba..b7ce73fba998 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -205,14 +205,14 @@ static inline void setup_protection_map(void)
 
 void cpu_cache_init(void)
 {
-	if (cpu_has_3k_cache) {
+	if (IS_ENABLED(CONFIG_CPU_R3000) && cpu_has_3k_cache) {
 		r3k_cache_init();
 	}
-	if (cpu_has_4k_cache) {
+	if (IS_ENABLED(CONFIG_CPU_R4K_CACHE_TLB) && cpu_has_4k_cache) {
 		r4k_cache_init();
 	}
 
-	if (cpu_has_octeon_cache) {
+	if (IS_ENABLED(CONFIG_CPU_CAVIUM_OCTEON) && cpu_has_octeon_cache) {
 		octeon_cache_init();
 	}
 
-- 
2.39.2


