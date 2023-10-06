Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612097BC225
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjJFWQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJFWQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:16:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3112BD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:16:20 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1885819a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 15:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696630580; x=1697235380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCChOiC5+OCDlbLLrEgPwNPe/HtuhSm+x2PIj6YN8Og=;
        b=fvq+qEKbKlRP8jv1g60fch3h/u4lr7PHQDfNyM7NBAuvJqfOTbA1Q5MWTIJijf4YXO
         z8CUCC2PR89Pu5SCf+C+jyNI8haDON3MZhNllNa0TcjKKSH6QuTaS8o+sGyyg55EQwJV
         84dxvQ8+QPfTctjC0foT7eqoItBhnMFYYBetE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696630580; x=1697235380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCChOiC5+OCDlbLLrEgPwNPe/HtuhSm+x2PIj6YN8Og=;
        b=MhZY4vKeSlM31mcego6ZR8tjYDlI7GZoXD3WCMQuRQaNPRhKX8ARphxT37t50h7GFI
         0ewsQ/wp/enl5dweBb0WP2LI4puwzUk1fpO+6dnXWpptmcPnsSR9japq4I9FmYKxsvOI
         yGWISqPN8+tXe2nO/4aCF5FDiYHZ9nkWi1wLiMkeKDXt1obVmWd2mcqK/EZRH3ehsR8f
         GNGSgy7ICLA5ScVchcwE2GRzVhSTUyvQLap5iI6EOvH0UGms7oibqE1DMVwqzwINIvz2
         XbZy2UMcj6iU136ZUKN3FRIy3XPGe3jspl65PSoTULUJ+pbSdXmgMmp+tx21ZpFJtt5Y
         XfgQ==
X-Gm-Message-State: AOJu0YyPscHILzZ41enliuQArVuJe0062PzWxtXkr3E8MIDGB/1uqfST
        tBXkVUF0exoqHITQ/F02gYUN5g==
X-Google-Smtp-Source: AGHT+IHKwJcVCOzr02nXWYBfeXvpup+ZejkzGxyBBUXwkHWHzNfLIWK/MnuToROxrwttI3fLYLoUug==
X-Received: by 2002:a17:90b:224d:b0:274:566a:3477 with SMTP id hk13-20020a17090b224d00b00274566a3477mr9047899pjb.39.1696630580472;
        Fri, 06 Oct 2023 15:16:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:1f37:5459:32bf:faf9])
        by smtp.gmail.com with ESMTPSA id rj6-20020a17090b3e8600b00276e8e4f1fbsm5946523pjb.1.2023.10.06.15.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:16:19 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Revert "arm64: smp: avoid NMI IPIs with broken MediaTek FW"
Date:   Fri,  6 Oct 2023 15:15:52 -0700
Message-ID: <20231006151547.2.I2c5fa192e767eb3ee233bc28eb60e2f8656c29a6@changeid>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231006151547.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
References: <20231006151547.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a07a594152173a3dd3bdd12fc7d73dbba54cdbca.

This is no longer needed after the patch ("arm64: Disable GiC
priorities on Mediatek devices w/ firmware issues").

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/kernel/smp.c      | 5 +----
 drivers/irqchip/irq-gic-v3.c | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 16ead57a583d..f36a97a54d2b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -964,10 +964,7 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 
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
index 737da1b9aabf..787ccc880b22 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -106,7 +106,7 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
  * - Figure 4-7 Secure read of the priority field for a Non-secure Group 1
  *   interrupt.
  */
-DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
+static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
 
 DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
 EXPORT_SYMBOL(gic_nonsecure_priorities);
-- 
2.42.0.609.gbb76f46606-goog

