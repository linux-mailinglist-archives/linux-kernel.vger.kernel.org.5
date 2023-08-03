Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA1B76E61A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbjHCLBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjHCLBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:01:05 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF3E49D0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1691060419;
  x=1722596419;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=IIK+/Ibszq5Q7MtD+HETHlaqPMsGqvrHx1bhq6MXAIg=;
  b=KxE9o1R8d7KLq+USy6dtOQ5bamUG4rGlSgrSYnfpmKAc4MnzJOcnqcWw
   RpZWaKUkp7Hgm554NEcZ3b0md8j0xV/vNIUGRVgXPrKC1b40F61rlHboN
   HYwvh1xkDYrBZORVBwHcsbpiQ+iQp+LROItKi2DIgXdsDpTcf3ybPXXF+
   Ikpoe9Egv3QIH3ezYSD41RvLPPGpVB/n4g3oyCkPK98Iay7JjaOuZy9Pr
   LojancxSOmGwCx9VSIj8GDSRwd+pJAj/0M+MOxRXGHOY69q+c3ttY+F0g
   SdmGLOovaRhi0gTElB4kUVcICSxiNssb9NskY2Jtye46eYqBoD+8lQ9tc
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Thu, 3 Aug 2023 12:59:49 +0200
Subject: [PATCH] ARM: fix stack depot IRQ stack filter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230803-arm-irqentry-v1-1-8aad8e260b1c@axis.com>
X-B4-Tracking: v=1; b=H4sIAKSIy2QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNj3cSiXN3MosLUvJKiSl2zZFNTc0uDtEQD0zQloJaCotS0zAqwcdG
 xtbUAcFzl9V4AAAA=
To:     Russell King <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place IRQ handlers such as gic_handle_irq() in the irqentry section even
if FUNCTION_GRAPH_TRACER is not enabled.  Without this, the stack
depot's filter_irq_stacks() does not correctly filter out IRQ stacks in
those configurations, which hampers deduplication and eventually leads
to "Stack depot reached limit capacity" splats with KASAN.

A similar fix was done for arm64 in commit f6794950f0e5ba37e3bbed
("arm64: set __exception_irq_entry with __irq_entry as a default").

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/arm/include/asm/exception.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/exception.h b/arch/arm/include/asm/exception.h
index 58e039a851af..3c82975d46db 100644
--- a/arch/arm/include/asm/exception.h
+++ b/arch/arm/include/asm/exception.h
@@ -10,10 +10,6 @@
 
 #include <linux/interrupt.h>
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 #define __exception_irq_entry	__irq_entry
-#else
-#define __exception_irq_entry
-#endif
 
 #endif /* __ASM_ARM_EXCEPTION_H */

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230803-arm-irqentry-6c55790fa05f

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

