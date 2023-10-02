Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D2B7B5856
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbjJBQqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbjJBQqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:46:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89748D7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:46:14 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5859b06509cso2383822a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696265174; x=1696869974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aLqyuV3WHU1tmRucfRRbNKiUdX9Z1rFjqb2ZE34s0NQ=;
        b=CaHKVNGliyYtM9Fb0sKWpA+KcRNU5qTHzmNc/IJOKFYYOjDzswi9zOhkK2mhgF0Aix
         ohiNH1VaomGyVPARikWgxgmuOabKGhGEroCRYK2zeAwxaqp+nWGdyb7slIU7QnCYe+v9
         JfpYaIoLu2os/jp81jFr6wErV6ezqlb/ltFRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265174; x=1696869974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLqyuV3WHU1tmRucfRRbNKiUdX9Z1rFjqb2ZE34s0NQ=;
        b=LC7LM6t6ZhnfWXQdvc2V/Kq0W3Hd96G4eXEKb6vBSTsTVQqMsTWJm8MWq0cPb4dy0s
         YhMt2G7lMPufcchkZIlxZJBe1WOmCLH54j+B9vzM9xMd9HxIX8bVHk/Hk/shupRD98OZ
         Ov7hQj5edu/wbo6tbXIiwV935b/tb0I7zsgQsAKXxZyo+jEsb5Xw8tCtO+zMU23jv4y0
         GnlSxDVoGVFy0ZQUwKqC7pO9c5xyJQAehJaUv1HP2Ai4HRpROklbGQn/8xUN4sLCVOtt
         OxLagssPW2CAiHeHdFVaO5rJthqSD3jL9jc01rVR9+11R+jIZjwS37iioNRGtt/unc+v
         G4KQ==
X-Gm-Message-State: AOJu0Ywh5zvpxPd0ced07/wYmDKMyExgm7BaY3HitnWcXreebeAFK63x
        +oPRv1z10gDFkGxHKhmIJmLkIg==
X-Google-Smtp-Source: AGHT+IFuyESTg1qXH/EpmpZCYlorecz5cuQHSkF+/6rKpci8edHI/LtYiWRbzzYyGr4lSooBLvepRg==
X-Received: by 2002:a05:6a20:a110:b0:13d:1d14:6693 with SMTP id q16-20020a056a20a11000b0013d1d146693mr12076717pzk.45.1696265173921;
        Mon, 02 Oct 2023 09:46:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:bb:b2b6:1831:5edd])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902d2c300b001c737950e4dsm8455904plc.2.2023.10.02.09.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:46:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Misono Tomohiro <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] arm64: smp: Fix pseudo NMI issues w/ broken Mediatek FW
Date:   Mon,  2 Oct 2023 09:45:29 -0700
Message-ID: <20231002094526.1.Ie8f760213053e3d11592f892b30912dbac6b8b48@changeid>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some mediatek devices have the property
"mediatek,broken-save-restore-fw" in their GIC. This means that,
although the hardware supports pseudo-NMI, the firmware has a bug
that blocks enabling it. When we're in this state,
system_uses_irq_prio_masking() will return true but we'll fail to
actually enable the IRQ in the GIC.

Let's make the code handle this. We'll detect that we failed to
request an IPI as NMI and fallback to requesting it normally. Though
we expect that either all of our requests will fail or all will
succeed, it's just as cheap to keep a per-IPI bitmap and that keeps us
robust.

Fixes: 331a1b3a836c ("arm64: smp: Add arch support for backtrace using pseudo-NMI")
Reported-by: Chen-Yu Tsai <wenst@chromium.org>
Closes: https://issuetracker.google.com/issues/197061987#comment68
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/kernel/smp.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 814d9aa93b21..0a6002243a8c 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -87,6 +87,7 @@ enum ipi_msg_type {
 static int ipi_irq_base __ro_after_init;
 static int nr_ipi __ro_after_init = NR_IPI;
 static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
+DECLARE_BITMAP(ipi_is_nmi, MAX_IPI);
 
 static void ipi_setup(int cpu);
 
@@ -986,7 +987,7 @@ static void ipi_setup(int cpu)
 		return;
 
 	for (i = 0; i < nr_ipi; i++) {
-		if (ipi_should_be_nmi(i)) {
+		if (test_bit(i, ipi_is_nmi)) {
 			prepare_percpu_nmi(ipi_irq_base + i);
 			enable_percpu_nmi(ipi_irq_base + i, 0);
 		} else {
@@ -1004,7 +1005,7 @@ static void ipi_teardown(int cpu)
 		return;
 
 	for (i = 0; i < nr_ipi; i++) {
-		if (ipi_should_be_nmi(i)) {
+		if (test_bit(i, ipi_is_nmi)) {
 			disable_percpu_nmi(ipi_irq_base + i);
 			teardown_percpu_nmi(ipi_irq_base + i);
 		} else {
@@ -1022,17 +1023,21 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 	nr_ipi = min(n, MAX_IPI);
 
 	for (i = 0; i < nr_ipi; i++) {
-		int err;
+		int err = -EINVAL;
 
 		if (ipi_should_be_nmi(i)) {
 			err = request_percpu_nmi(ipi_base + i, ipi_handler,
 						 "IPI", &cpu_number);
-			WARN(err, "Could not request IPI %d as NMI, err=%d\n",
-			     i, err);
-		} else {
+			if (err)
+				pr_info_once("NMI unavailable; fallback to IRQ\n");
+			else
+				set_bit(i, ipi_is_nmi);
+		}
+
+		if (err) {
 			err = request_percpu_irq(ipi_base + i, ipi_handler,
 						 "IPI", &cpu_number);
-			WARN(err, "Could not request IPI %d as IRQ, err=%d\n",
+			WARN(err, "Could not request IPI %d, err=%d\n",
 			     i, err);
 		}
 
-- 
2.42.0.582.g8ccd20d70d-goog

