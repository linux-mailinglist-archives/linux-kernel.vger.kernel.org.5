Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12908802A40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbjLDCXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjLDCXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:23:50 -0500
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50034CB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 18:23:56 -0800 (PST)
X-QQ-mid: bizesmtp82t1701656598t8frmqyu
Received: from HX09040029.powercore.com.cn ( [58.34.117.194])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 04 Dec 2023 10:23:15 +0800 (CST)
X-QQ-SSF: 01400000000000402000000A0000000
X-QQ-FEAT: hkpyk8INzQP5z8rsiS8kuwoY6xUdsRY8dW9WQcjJFdXel2qTU+ejDRcm6VyqC
        imh5Q0H5tFQijQhHaHLm0yo1zrgD2CtTy18O7IcZqVUghlE0gaZWgQDhPrlnVPOFnaEO7zC
        alJqNiPdXhaIesMDJkgqolVaLUKWezM+6qDO2jl2pnqJNzpZP2BwzSu9kDdnA2TAu4t8yNe
        i9tSPXYA7TrFaBpa3Eg4KbljeeX8cBB41xekY2eP0Iz4ZkeqB+k+kE8Vf6+hc2pm8XxV3fR
        o2iGDYNltm/I8WG/R83ot9cZSxCoCDEOBQQ/YhOAtKEvkinQ8AtAA3nbD/26WCW2JiNrPP/
        TSm8QIFMZfYlhC5WELPdSSAL3EbU9D7Gc5fxBTtn+OfUkwVlw7NZmQjQkxAnEN2YKELPWZs
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 18421861491899950962
From:   Luming Yu <luming.yu@shingroup.cn>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     luming.yu@gmail.com, ke.zhao@shingroup.cn, dawei.li@shingroup.cn,
        shenghui.qu@shingroup.cn, Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH 1/2] powerpc/locking: implement this_cpu_cmpxchg local API
Date:   Mon,  4 Dec 2023 10:23:01 +0800
Message-ID: <0EFBD0242622180B+20231204022303.528-1-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ppc appears to have already supported cmpxchg-local atomic semantics
that is defined by the kernel convention of the feature.
Add this_cpu_cmpxchg ppc local for the performance benefit of arch
sepcific implementation than asm-generic c verison of the locking API.

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
 arch/powerpc/include/asm/percpu.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
index 8e5b7d0b851c..ceab5df6e7ab 100644
--- a/arch/powerpc/include/asm/percpu.h
+++ b/arch/powerpc/include/asm/percpu.h
@@ -18,5 +18,22 @@
 #include <asm-generic/percpu.h>
 
 #include <asm/paca.h>
+#include <asm/cmpxchg.h>
+#ifdef this_cpu_cmpxchg_1
+#undef this_cpu_cmpxchg_1
+#define this_cpu_cmpxchg_1(pcp, oval, nval)	__cmpxchg_local(raw_cpu_ptr(&(pcp)), oval, nval, 1)
+#endif 
+#ifdef this_cpu_cmpxchg_2
+#undef this_cpu_cmpxchg_2
+#define this_cpu_cmpxchg_2(pcp, oval, nval)	__cmpxchg_local(raw_cpu_ptr(&(pcp)), oval, nval, 2)
+#endif
+#ifdef this_cpu_cmpxchg_4
+#undef this_cpu_cmpxchg_4
+#define this_cpu_cmpxchg_4(pcp, oval, nval)	__cmpxchg_local(raw_cpu_ptr(&(pcp)), oval, nval, 4)
+#endif
+#ifdef this_cpu_cmpxchg_8
+#undef this_cpu_cmpxchg_8
+#define this_cpu_cmpxchg_8(pcp, oval, nval)	__cmpxchg_local(raw_cpu_ptr(&(pcp)), oval, nval, 8)
+#endif
 
 #endif /* _ASM_POWERPC_PERCPU_H_ */
-- 
2.42.0.windows.2

