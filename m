Return-Path: <linux-kernel+bounces-2963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D14816543
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D1E2813B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E997A566E;
	Mon, 18 Dec 2023 03:14:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9193C0C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp74t1702869227t11cgp0b
Received: from HX09040029.powercore.com.cn ( [58.34.117.194])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Dec 2023 11:13:44 +0800 (CST)
X-QQ-SSF: 01400000000000402000000A0000000
X-QQ-FEAT: ojreUey1GAJh8hL6tFNRr/A8uhfy7W4zq3Yz29fwbmPUxIt/sWXzmwhmi3hB7
	HEBw4koeQHjL3Qi/cVxpCKaWJG5ZGMO+/cXTzN6SfHcl0ULH600a3DcvPjlj6tyg2k/gKZu
	XSOQdClx+ydjQqzaULB6SML3BiQ88F2+h4RH4MXzqVhRMbVF5h5paqDpm/uMIfWMj1a8USz
	yihH3cUqAKqL9Ft5UEzlFMMSIrKJ4u45WR3Xcv+g+sI78M384cTjXLiJitHs42w41v9XQcG
	MGI0xeEB6FDlyTxOgcbMO4SEFL5vJL4qeb1zaXB4g4Db2+0uqy5u5u8U+IklyT7SGiEXHO7
	CnY03CRLj3jo60/R0YoLOMehhGvZCJwedC2KtL5v7sPa0tku5w+sPOoCOD6XFJwROfl/I1u
	7HpqbRCfybjinFJ3Xga9lQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4197664245729680774
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
Subject: [PATCH v1 2/2] powerpc/debug: hook to user return notifier infrastructure
Date: Mon, 18 Dec 2023 11:13:37 +0800
Message-ID: <B375A36C9C4D73FF+20231218031338.2084-1-luming.yu@shingroup.cn>
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

Before we have powerpc to use the generic entry infrastructure,
the call to fire user return notifier is made temporarily in powerpc
entry code.

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
 arch/powerpc/kernel/interrupt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index c4f6d3c69ba9..7fe704946e96 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -19,6 +19,7 @@
 #include <asm/time.h>
 #include <asm/tm.h>
 #include <asm/unistd.h>
+#include <asm/entry-common.h>
 
 #if defined(CONFIG_PPC_ADV_DEBUG_REGS) && defined(CONFIG_PPC32)
 unsigned long global_dbcr0[NR_CPUS];
@@ -245,6 +246,8 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 	/* Restore user access locks last */
 	kuap_user_restore(regs);
 
+	arch_exit_to_user_mode_prepare(regs, ti_flags);
+
 	return ret;
 }
 
-- 
2.42.0.windows.2


