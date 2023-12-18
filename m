Return-Path: <linux-kernel+bounces-2964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF84816545
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E0B28112B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1274B3D8E;
	Mon, 18 Dec 2023 03:14:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC623C0C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp71t1702869266tp6lsvnj
Received: from HX09040029.powercore.com.cn ( [58.34.117.194])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Dec 2023 11:14:23 +0800 (CST)
X-QQ-SSF: 01400000000000402000000A0000000
X-QQ-FEAT: fmY4SgAPM3slIzyLYur0WBpW/RTrgfiYkLSU8cSt6wuysWhvu08Z99fSf9eWz
	bKG73zarUNRBOQvL6DiaJOscOyuPb1ZmFcFlLiJ/teAX/q10RRN9y80nvBtinp7zWe/ZIw0
	uHwE/HtMpgiVNFP8CMi61za4iP61BhvHx4uxpEJqZMUgpk9i34RgHoqSoS1WAsLM/wsKlRi
	yBt2cACO+mLQXY+IU4QlFrCo/3aMUgSTI46C8G+UkywtDtd9chmWXn1+33zcY+5fZnI5IlB
	FZWUEwFKStcaQFspg90PzopQaRpSsFK+8/qOdcSswKgl+P6aedSms2q5g0ZQbtr28haSefF
	wXq01TOM2x4vnSowTOm8LzRXNVC3EWgcNZ+3n7WrvkFQbFcPKKlFkvrKDd5M3ROUZHG21kB
	842HVHETayS4DY/5L1kVwQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7532627385370386625
From: Luming Yu <luming.yu@shingroup.cn>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu
Cc: luming.yu@gmail.com,
	ke.zhao@shingroup.cn,
	dawei.li@shingroup.cn,
	shenghui.qu@shingroup.cn,
	Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH 1/1] powerpc/io: enable dma-contiguous API
Date: Mon, 18 Dec 2023 11:14:19 +0800
Message-ID: <F73A5182F488C472+20231218031420.2112-1-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

enable HAVE_DMA_CONTIGUOUS for general use of
CMA on powerpc.

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
 arch/powerpc/Kconfig               | 1 +
 arch/powerpc/kernel/setup-common.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b968068cc04a..e21f72bcb61f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -231,6 +231,7 @@ config PPC
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_STACKOVERFLOW
+	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if ARCH_USING_PATCHABLE_FUNCTION_ENTRY || MPROFILE_KERNEL || PPC32
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS	if ARCH_USING_PATCHABLE_FUNCTION_ENTRY || MPROFILE_KERNEL || PPC32
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 9b142b9d5187..50d09363352d 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -35,6 +35,7 @@
 #include <linux/of_irq.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
+#include <linux/dma-map-ops.h>
 #include <asm/io.h>
 #include <asm/paca.h>
 #include <asm/processor.h>
@@ -975,6 +976,7 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	kvm_cma_reserve();
 	gigantic_hugetlb_cma_reserve();
+	dma_contiguous_reserve(0);
 
 	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
 
-- 
2.42.0.windows.2


