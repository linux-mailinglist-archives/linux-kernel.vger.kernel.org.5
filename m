Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC67E4367
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343858AbjKGP1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbjKGP13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:27:29 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842D110F1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:27:26 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5bda105206fso1189922a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699370846; x=1699975646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2SccpyfV2fl1KuQVt090nerznp46yA/P71X1kRc3n4=;
        b=VRoCrDSGcH1n31Rl2p8av09ehrKMMN0ItOpSsjozprt8YYIzHfuh2rqCRUL+M0ujbV
         6E8RcDNCAXeB9sk1gtfoLJCtR9P982jVnIIRPNs+zvBZGNR1nTwc19xW54VLBuRrHntU
         OKd8JHJvrzHOlcgo6Z2XsFIMxvj3s0t36dK2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699370846; x=1699975646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2SccpyfV2fl1KuQVt090nerznp46yA/P71X1kRc3n4=;
        b=XQqEgtj15p9+FZHt1O/pWQyDm0ypXxvBsUrS6nGPI13hInvpuN1fM9fCvMrXwCxTzM
         ZsuAByWAvkRm/ESeyM3Kw3JfjCQTU3mooK68XLWw5E4+Z4l2GbcDrjwsaFr/JVBzmRTr
         Athqxa2xhPMu862p/1pQDp5bXgna6VhjH60ZjHgT61aFXJV9NgFvlQQrqgUYJsMw/x09
         dGvaAmm07LtXqV4ULANjPArO6rJqIDvJFie/mdPx5DuYtaSvPplFYdp6mZOwQKB0/aiV
         ytUTycBvTn4CjKbPWe5kufFWZjq3EARw/GDaxWw/rHIiGUspeD9nfSuwDmmBW0xmjQ5q
         OldA==
X-Gm-Message-State: AOJu0YwrQnzLZRNUQG1H74GbZ1pLTmhN5P57d0AVQGRyKz9C0iPxaH72
        5AwT/NGrDcTOP/Etej6UzsMZ2w==
X-Google-Smtp-Source: AGHT+IFcVuXr5lafjKMACmRmx/5rgib+c25BB9nXqxYoKEEpiMb9Ejom7vRw0FX77iFcLePPMQDMkQ==
X-Received: by 2002:a17:90a:7547:b0:280:2609:6d47 with SMTP id q65-20020a17090a754700b0028026096d47mr21545310pjk.19.1699370845953;
        Tue, 07 Nov 2023 07:27:25 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:16a7:2c01:9126:36a4])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090a49c700b002808c9e3095sm7066259pjm.26.2023.11.07.07.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:27:25 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Revert "arm64: smp: avoid NMI IPIs with broken MediaTek FW"
Date:   Tue,  7 Nov 2023 07:26:57 -0800
Message-ID: <20231107072651.v2.2.I2c5fa192e767eb3ee233bc28eb60e2f8656c29a6@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231107072651.v2.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
References: <20231107072651.v2.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a07a594152173a3dd3bdd12fc7d73dbba54cdbca.

This is no longer needed after the patch ("arm64: Move Mediatek GIC
quirk handling from irqchip to core).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Fixed typo in subject: s/GiC/GIC.

 arch/arm64/kernel/smp.c      | 5 +----
 drivers/irqchip/irq-gic-v3.c | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index be95b523c101..defbab84e9e5 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -965,10 +965,7 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 
 static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
 {
-	DECLARE_STATIC_KEY_FALSE(supports_pseudo_nmis);
-
-	if (!system_uses_irq_prio_masking() ||
-	    !static_branch_likely(&supports_pseudo_nmis))
+	if (!system_uses_irq_prio_masking())
 		return false;
 
 	switch (ipi) {
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 1ba674367ee3..98b0329b7154 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -105,7 +105,7 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
  * - Figure 4-7 Secure read of the priority field for a Non-secure Group 1
  *   interrupt.
  */
-DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
+static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
 
 DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
 EXPORT_SYMBOL(gic_nonsecure_priorities);
-- 
2.42.0.869.gea05f2083d-goog

