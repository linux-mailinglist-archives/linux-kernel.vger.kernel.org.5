Return-Path: <linux-kernel+bounces-10878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7F581DDB5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 04:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0E21F21D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 03:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FEFA51;
	Mon, 25 Dec 2023 03:00:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DAA7F2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 03:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp83t1703473175t0fjew5d
Received: from HX09040029.powercore.com.cn ( [58.34.117.194])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 25 Dec 2023 10:59:32 +0800 (CST)
X-QQ-SSF: 01400000000000501000000A0000000
X-QQ-FEAT: cbck7jzG4waTzGVHJSvhz4fDlwNvrHHZVHRG9jP7o3SoKAw8V4l7n0Oav1nTf
	FBeh1tF3Wl3f0I+Ro3O88RaWd96B9qDptSY+EsOxFmkomli6trBZ/+mlmvy7huXEg2uuImE
	MwevjdvOPii9JHotGgzSrVaclNisM4tKUVu9fkfAdex6HtdJKLb4uLxZpdDfgVXvVVTqaem
	HJiXXHwUc+MdXvM+XCAd+WhlJyrMIAQqtxjLlbJhRu+CfIIetCahBJdEogxbMRmBo0gv1P2
	mRLtZuij7ptin7KA/pCrf1XRoBJMaM0VM2p7OXJTLF/35I2wPodTisLeRZkfvBt5qTAuZHI
	LJ59YXG5+mLTzflSO5oL+ct/b26VxNabq3E6F2muOi+AK/eikpYqlswI8hNqduHpPvrVy4V
	aXI4eqUDZgM=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8344457211181323372
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
Subject: [PATCH 1/1] powerpc/powernv: fix up kernel compile issues
Date: Mon, 25 Dec 2023 10:58:24 +0800
Message-ID: <1655B2CD28DA1F77+20231225025824.830-1-luming.yu@shingroup.cn>
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

up kernel is quite useful to silicon validation, despite
it is rare to be found in server productions. the fixes are
obvious. Not like IBM pSeries, it may be not necessary
to have powernv SMP forced. It is difficult to compile a
up kernel for pSerises as I've tried.

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
 arch/powerpc/platforms/powernv/Kconfig    | 1 -
 arch/powerpc/platforms/powernv/opal-imc.c | 1 +
 arch/powerpc/sysdev/xive/common.c         | 2 ++
 arch/powerpc/sysdev/xive/spapr.c          | 5 ++++-
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 70a46acc70d6..40b1a49379de 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -15,7 +15,6 @@ config PPC_POWERNV
 	select CPU_FREQ
 	select PPC_DOORBELL
 	select MMU_NOTIFIER
-	select FORCE_SMP
 	select ARCH_SUPPORTS_PER_VMA_LOCK
 	default y
 
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 828fc4d88471..6e9e2b0a5bdc 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -13,6 +13,7 @@
 #include <linux/of_address.h>
 #include <linux/crash_dump.h>
 #include <linux/debugfs.h>
+#include <asm/smp.h>
 #include <asm/opal.h>
 #include <asm/io.h>
 #include <asm/imc-pmu.h>
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index a289cb97c1d7..d49b12809c10 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1497,7 +1497,9 @@ static int xive_prepare_cpu(unsigned int cpu)
 				  GFP_KERNEL, cpu_to_node(cpu));
 		if (!xc)
 			return -ENOMEM;
+#ifdef CONFIG_SMP
 		xc->hw_ipi = XIVE_BAD_IRQ;
+#endif
 		xc->chip_id = XIVE_INVALID_CHIP_ID;
 		if (xive_ops->prepare_cpu)
 			xive_ops->prepare_cpu(cpu, xc);
diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index e45419264391..7298f57f8416 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -81,6 +81,7 @@ static void xive_irq_bitmap_remove_all(void)
 	}
 }
 
+#ifdef CONFIG_SMP
 static int __xive_irq_bitmap_alloc(struct xive_irq_bitmap *xibm)
 {
 	int irq;
@@ -126,7 +127,7 @@ static void xive_irq_bitmap_free(int irq)
 		}
 	}
 }
-
+#endif 
 
 /* Based on the similar routines in RTAS */
 static unsigned int plpar_busy_delay_time(long rc)
@@ -663,6 +664,7 @@ static void xive_spapr_sync_source(u32 hw_irq)
 	plpar_int_sync(0, hw_irq);
 }
 
+#ifdef CONFIG_SMP
 static int xive_spapr_debug_show(struct seq_file *m, void *private)
 {
 	struct xive_irq_bitmap *xibm;
@@ -680,6 +682,7 @@ static int xive_spapr_debug_show(struct seq_file *m, void *private)
 
 	return 0;
 }
+#endif
 
 static const struct xive_ops xive_spapr_ops = {
 	.populate_irq_data	= xive_spapr_populate_irq_data,
-- 
2.42.0.windows.2


