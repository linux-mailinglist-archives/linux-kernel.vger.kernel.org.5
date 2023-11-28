Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA37FC3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345612AbjK1Syx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjK1Syw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:54:52 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE99131
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1701197696;
        bh=g5ZQtgKHvReyc2FbFJdjdcOuj1Mex1OD2XH15wvt0xQ=;
        h=From:Date:Subject:To:Cc:From;
        b=UsY78Z+onca9EojgI9jD7Jla9fc3zmxsMioryJWG96SHdyXoUKgb3hkAodn3SkG3/
         sbW0zkfwTSfBHP3/sb2loAGcb/X9InCqO5nFOKCvKzQBTurDYOmlJOnZouQAhkBHgd
         BvJx8zx1QDBLYxKPzsFnG1omOWdJcAEDWR042NiI=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 28 Nov 2023 19:54:54 +0100
Subject: [PATCH] x86/cpu: Update power flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231128-powerflags-v1-1-87e8fe020a3d@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAH03ZmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQyML3YL88tSitJzE9GJdi+RUM7NES7M0szRjJaCGgqLUtMwKsGHRsbW
 1AEcnwoNcAAAA
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701197695; l=1122;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=g5ZQtgKHvReyc2FbFJdjdcOuj1Mex1OD2XH15wvt0xQ=;
 b=52wa1GJz31VPEzbWBaqm9xum2pA9yacoidwksoWRik5Os7VvN69m/qrOREF+DTTHV0Z0xNA/7
 9/RtLohigCLA7HVojfPZOB7vtYDSBuWGOLf9y+3NY5R/CjbMPeBSxNP
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described on page 99 of
"Processing Programming Reference (PPR) for AMD Family 19h Model 61h, Revision B1 Processor".
(AMD Documentation Hub Document 56713)

Tested on an "AMD Ryzen 7 7840U w/ Radeon  780M Graphics".

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/kernel/cpu/powerflags.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/powerflags.c b/arch/x86/kernel/cpu/powerflags.c
index fd6ec2aa0303..0c98405aeae2 100644
--- a/arch/x86/kernel/cpu/powerflags.c
+++ b/arch/x86/kernel/cpu/powerflags.c
@@ -21,4 +21,7 @@ const char *const x86_power_flags[32] = {
 	"eff_freq_ro", /* Readonly aperf/mperf */
 	"proc_feedback", /* processor feedback interface */
 	"acc_power", /* accumulated power mechanism */
+	"connected_standby", /* connected standby */
+	"rapl", /* running average power limit */
+	"fast_cppc", /* fast collaborative processor performance control */
 };

---
base-commit: df60cee26a2e3d937a319229e335cb3f9c1f16d2
change-id: 20231128-powerflags-8ce66a96f6f3

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

