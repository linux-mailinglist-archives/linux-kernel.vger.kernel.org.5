Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528BC7AD4AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjIYJk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjIYJk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:40:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AABBE;
        Mon, 25 Sep 2023 02:40:49 -0700 (PDT)
Date:   Mon, 25 Sep 2023 09:40:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695634847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=89QGxiAnkMO5e/O0iPpXiUamYcNaTnIQNHMFTNCzS/Y=;
        b=qWDCdjV18rDyY4ZwhIaDaTewkCKoGNRyPDEYy15NWOpjDMJZFijDWPL3llArYzxtXtJsF5
        LeIWS8sVoT9n8Dcf1xERqa7X7Ur6HoxJdXzhK//Lx97rl5TV8VwWcO/UjI2sFmYSWWEuCM
        plHtvWtMmfnUC3yUHK9YIrgcbZuuTQRRm5n/f3vOd8Zmbs5WvzsXIExbXhcWBdU4jJ/4pU
        02XgGwVOd3Xa52yCVbUnBAVMaTGyZ27KrxlKuXYhyKF7Sh1jealA1ECM71DyFSE0CiTCS5
        QD1XfTLFvGa9q1mq4Ws79LKuDN/IJ0qe/a1QXcVQrjl1f6DouJYflMkqDU1q5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695634847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=89QGxiAnkMO5e/O0iPpXiUamYcNaTnIQNHMFTNCzS/Y=;
        b=BLlQjiQrJHeC5ajKDREQOuW9idwblwEvgfToLIasQp5UBT5uGfx+DfywDFXNBYlaWD8QBc
        +yF78+JeZXhSwxDQ==
From:   "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd: Do not WARN() on every IRQ
Cc:     Jirka Hladky <jhladky@redhat.com>,
        Breno Leitao <leitao@debian.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169563484702.27769.17534862657597994839.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     599522d9d2e19d6240e4312577f1c5f3ffca22f6
Gitweb:        https://git.kernel.org/tip/599522d9d2e19d6240e4312577f1c5f3ffc=
a22f6
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Thu, 14 Sep 2023 19:58:40 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Sep 2023 11:30:31 +02:00

perf/x86/amd: Do not WARN() on every IRQ

Zen 4 systems running buggy microcode can hit a WARN_ON() in the PMI
handler, as shown below, several times while perf runs. A simple
`perf top` run is enough to render the system unusable:

  WARNING: CPU: 18 PID: 20608 at arch/x86/events/amd/core.c:944 amd_pmu_v2_ha=
ndle_irq+0x1be/0x2b0

This happens because the Performance Counter Global Status Register
(PerfCntGlobalStatus) has one or more bits set which are considered
reserved according to the "AMD64 Architecture Programmer=E2=80=99s Manual,
Volume 2: System Programming, 24593":

  https://www.amd.com/system/files/TechDocs/24593.pdf

To make this less intrusive, warn just once if any reserved bit is set
and prompt the user to update the microcode. Also sanitize the value to
what the code is handling, so that the overflow events continue to be
handled for the number of counters that are known to be sane.

Going forward, the following microcode patch levels are recommended
for Zen 4 processors in order to avoid such issues with reserved bits:

  Family=3D0x19 Model=3D0x11 Stepping=3D0x01: Patch=3D0x0a10113e
  Family=3D0x19 Model=3D0x11 Stepping=3D0x02: Patch=3D0x0a10123e
  Family=3D0x19 Model=3D0xa0 Stepping=3D0x01: Patch=3D0x0aa00116
  Family=3D0x19 Model=3D0xa0 Stepping=3D0x02: Patch=3D0x0aa00212

Commit f2eb058afc57 ("linux-firmware: Update AMD cpu microcode") from
the linux-firmware tree has binaries that meet the minimum required
patch levels.

  [ sandipan: - add message to prompt users to update microcode
              - rework commit message and call out required microcode levels ]

Fixes: 7685665c390d ("perf/x86/amd/core: Add PerfMonV2 overflow handling")
Reported-by: Jirka Hladky <jhladky@redhat.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/all/3540f985652f41041e54ee82aa53e7dbd55739ae.16=
94696888.git.sandipan.das@amd.com/
---
 arch/x86/events/amd/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index ed626bf..e249765 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -886,7 +886,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	struct hw_perf_event *hwc;
 	struct perf_event *event;
 	int handled =3D 0, idx;
-	u64 status, mask;
+	u64 reserved, status, mask;
 	bool pmu_enabled;
=20
 	/*
@@ -911,6 +911,14 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		status &=3D ~GLOBAL_STATUS_LBRS_FROZEN;
 	}
=20
+	reserved =3D status & ~amd_pmu_global_cntr_mask;
+	if (reserved)
+		pr_warn_once("Reserved PerfCntrGlobalStatus bits are set (0x%llx), please =
consider updating microcode\n",
+			     reserved);
+
+	/* Clear any reserved bits set by buggy microcode */
+	status &=3D amd_pmu_global_cntr_mask;
+
 	for (idx =3D 0; idx < x86_pmu.num_counters; idx++) {
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
