Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8907BC224
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjJFWQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJFWQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:16:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3BEBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:16:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27736c2a731so1991713a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 15:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696630578; x=1697235378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0RzCHBb9WoSeOhmw11duqctRmWYwOtRpdu2I7EOG8ak=;
        b=WkYQiGNVDUcCXR6JU3Sl/cHSiT343fFRVd2S7kDVw3Y+wnGIPxJtOzCJeWZuThrOS2
         AA1Iitm6skr5rYDMcSawFGBrhrHKVbztHKd7FipiGz822QxHQYQKm2qtadDWT2dv7FQc
         Oy0k3r3NojgeiU3T41/mD+az/uxLPNGeSY9Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696630578; x=1697235378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RzCHBb9WoSeOhmw11duqctRmWYwOtRpdu2I7EOG8ak=;
        b=aFupcgcKZjYFLbnZrBKaKhr9MpWvBThgIMz9cA1IZy+D++h7TP/Fq1rsiSmEG7lKrZ
         AnJRnZDkhHm2PRoaFAwAYnNMd4h1gFKDz4QDJdBMO6g97vjBOLBbMYWjOSjDVPy+qmnD
         NjSjvaB0EQHaBNPmJlHmnHj8W9KQT3UUqjmrcIXL6Jtb9pdxNOXG+qX1c9OczJzaaLpt
         iDDluF39cDQ4lOtoKyDVqGCn5OTfnI/GQoqruHy934ZyOcfde+5QcgJQ7XTAXtfdNKg5
         KW/2q4uhWd8cRmsCCG9I6/g1NzirGfTMPb2gNj/qpU5TEeKCRGOncelcAHRMC1ckNQSB
         jc5Q==
X-Gm-Message-State: AOJu0YzA7/uNa5W7tsdpza09M5W+zNjNwpz/dRGhfbBDaD8a1IPHiJCG
        V3kuiZHgQ5DZKVJbGmHvuwaRAQ==
X-Google-Smtp-Source: AGHT+IHF+LblYJeVzXRHb4Z5bbsiKZ6oGjIBxOn4gbb3wXUJcmjP+I9SQqkZQJ0WyiuqATULZb/vbA==
X-Received: by 2002:a17:90a:f3c4:b0:277:4057:b752 with SMTP id ha4-20020a17090af3c400b002774057b752mr9638126pjb.46.1696630578523;
        Fri, 06 Oct 2023 15:16:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:1f37:5459:32bf:faf9])
        by smtp.gmail.com with ESMTPSA id rj6-20020a17090b3e8600b00276e8e4f1fbsm5946523pjb.1.2023.10.06.15.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:16:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/3] arm64: Disable GiC priorities on Mediatek devices w/ firmware issues
Date:   Fri,  6 Oct 2023 15:15:51 -0700
Message-ID: <20231006151547.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
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

In commit 44bd78dd2b88 ("irqchip/gic-v3: Disable pseudo NMIs on
Mediatek devices w/ firmware issues") we added a method for detecting
Mediatek devices with broken firmware and disabled pseudo-NMI. While
that worked, it didn't address the problem at a deep enough level.

The fundamental issue with this broken firmware is that it's not
saving and restoring several important GICR registers. The current
list is believed to be:
* GICR_NUM_IPRIORITYR
* GICR_CTLR
* GICR_ISPENDR0
* GICR_ISACTIVER0
* GICR_NSACR

Pseudo-NMI didn't work because it was the only thing (currently) in
the kernel that relied on the broken registers, so forcing pseudo-NMI
off was an effective fix. However, it could be observed that calling
system_uses_irq_prio_masking() on these systems still returned
"true". That caused confusion and led to the need for
commit a07a59415217 ("arm64: smp: avoid NMI IPIs with broken MediaTek
FW"). It's worried that the incorrect value returned by
system_uses_irq_prio_masking() on these systems will continue to
confuse future developers.

Let's fix the issue a little more completely by disabling IRQ
priorities at a deeper level in the kernel. Once we do this we can
revert some of the other bits of code dealing with this quirk.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/kernel/cpufeature.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 2806a2850e78..e35efab8efa9 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2094,9 +2094,30 @@ static int __init early_enable_pseudo_nmi(char *p)
 }
 early_param("irqchip.gicv3_pseudo_nmi", early_enable_pseudo_nmi);
 
+static bool are_gic_priorities_broken(void)
+{
+	bool is_broken = false;
+	struct device_node *np;
+
+	/*
+	 * Detect broken Mediatek firmware that doesn't properly save and
+	 * restore GIC priorities.
+	 */
+	np = of_find_compatible_node(NULL, NULL, "arm,gic-v3");
+	if (np) {
+		is_broken = of_property_read_bool(np, "mediatek,broken-save-restore-fw");
+		of_node_put(np);
+	}
+
+	return is_broken;
+}
+
 static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
 				   int scope)
 {
+	if (are_gic_priorities_broken())
+		return false;
+
 	/*
 	 * ARM64_HAS_GIC_CPUIF_SYSREGS has a lower index, and is a boot CPU
 	 * feature, so will be detected earlier.
-- 
2.42.0.609.gbb76f46606-goog

