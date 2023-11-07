Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEA87E45E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbjKGQVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbjKGQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:21:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E175B3C1F;
        Tue,  7 Nov 2023 07:54:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DDFC433C9;
        Tue,  7 Nov 2023 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372491;
        bh=eKjKjQtuQioPfr0c0G9e9b9Y+FsoGklLlT1SbbgQHBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2YGqYQCMmwD+mD65G4Zzur+yg/QcKkT8m/odaVR+8QjwsE8IBW+Gf2mPuaCspO50
         8KxHS6DG5Hx7NfdjRxcMglxYeRjOe2wnAnYcvs+rd89PsnDUrD+bFFYpvqUEk+IFkA
         t0eSY/OGo5/waXnFN4WY1YJVF7R1B0GKI0h9IJ8+hc9N4CK0q9oWelqU0hvTeP8Uxf
         eP9zOEgOkuxe7DJao94S+OV4mUX5lNg0YmR2NnXqQnXuvGdtCDAfr7CM7KSDXhevB5
         KQQesey1tysAoVIh6wAeLEeEfRtWSQgzGeJCoOreY9Bd/R67Mhii5KnoqF/sLWKQsW
         cnp63DolU63Eg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 07/11] ARM: 9320/1: fix stack depot IRQ stack filter
Date:   Tue,  7 Nov 2023 10:54:15 -0500
Message-ID: <20231107155430.3768779-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155430.3768779-1-sashal@kernel.org>
References: <20231107155430.3768779-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.297
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

[ Upstream commit b0150014878c32197cfa66e3e2f79e57f66babc0 ]

Place IRQ handlers such as gic_handle_irq() in the irqentry section even
if FUNCTION_GRAPH_TRACER is not enabled.  Without this, the stack
depot's filter_irq_stacks() does not correctly filter out IRQ stacks in
those configurations, which hampers deduplication and eventually leads
to "Stack depot reached limit capacity" splats with KASAN.

A similar fix was done for arm64 in commit f6794950f0e5ba37e3bbed
("arm64: set __exception_irq_entry with __irq_entry as a default").

Link: https://lore.kernel.org/r/20230803-arm-irqentry-v1-1-8aad8e260b1c@axis.com

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/exception.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/exception.h b/arch/arm/include/asm/exception.h
index 58e039a851af0..3c82975d46db3 100644
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
-- 
2.42.0

