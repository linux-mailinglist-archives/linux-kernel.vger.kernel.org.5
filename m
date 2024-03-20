Return-Path: <linux-kernel+bounces-108787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE72E880FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2641C2316F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CEE3A1BB;
	Wed, 20 Mar 2024 10:30:32 +0000 (UTC)
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010A91426A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930632; cv=none; b=tqtU3NS/oswYmtKU2s6UacKiE1E5kFtXUdl+IXEtzCoITLLVFdxBpOmrk7zeTAuZC+Q75fWanT0nM7kH1knc9V5PBkeKSJapbrdEtVfX3QBnkP+dyNSUPzlmNJuQgqsoim7StOH2+Aoy7AQ0QfdJjGHERkukb0wugrPeUWkZJFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930632; c=relaxed/simple;
	bh=pINihG+7YHZfwoZMIr7lzlBBZzwKCYY7QMVa6cAANME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hXbVRsMKXX2L6FlO0oLGAIqDomHRrhIaZDBP1ispNVquHIRSA1QrzLsOSLQqD6lkGXL0HNab7wQd5uW2w85I7S5v58q/swpdHT9Y+UvR7uc4a1NCsa/JXFuvTULorUjjjuVI5kHmwlcZZYtGUX4BsII50NrO0hVHy51O9Q7HJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4V04c2215Bz4x1qc
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:30:26 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by michel.telenet-ops.be with bizsmtp
	id 0yWF2C00B0SSLxL06yWFel; Wed, 20 Mar 2024 11:30:19 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rmtCl-004BA6-93;
	Wed, 20 Mar 2024 11:30:15 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rmtD5-000te6-0r;
	Wed, 20 Mar 2024 11:30:15 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Saravana Kannan <saravanak@google.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clocksource/drivers/renesas-ostm: Avoid reprobe after successful early probe
Date: Wed, 20 Mar 2024 11:30:07 +0100
Message-Id: <bd027379713cbaafa21ffe9e848ebb7f475ca0e7.1710930542.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas OS Timer (OSTM) driver contains two probe points, of which
only one should complete:
  1. Early probe, using TIMER_OF_DECLARE(), to provide the sole
     clocksource on (arm32) RZ/A1 and RZ/A2 SoCs,
  2. Normal probe, using a platform driver, to provide additional timers
     on (arm64 + riscv) RZ/G2L and similar SoCs.

The latter is needed because using OSTM on RZ/G2L requires manipulation
of its reset signal, which is not yet available at the time of early
probe, causing early probe to fail with -EPROBE_DEFER.  It is only
enabled when building a kernel with support for the RZ/G2L family, so it
does not impact RZ/A1 and RZ/A2.  Hence only one probe method can
complete on all affected systems.

As relying on the order of initialization of subsystems inside the
kernel is fragile, set the DT node's OF_POPULATED flag after a succesful
early probe.  This makes sure the platform driver's probe is never
called after a successful early probe.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on RZ/A2 (after force-enabling the platform driver probe).
Regression-tested on RZ/Five (member of the RZ/G2L family).

In between commit 4f41fe386a94639c ("clocksource/drivers/timer-probe:
Avoid creating dead devices") and its revert 4479730e9263befb (both in
v5.7), the clocksource core took care of this.  Other subsystems[1]
still handle this, either minimally (by just setting OF_POPULATED), or
fully (by also clearing OF_POPULATED again in case of probe failure).

Note that despite the revert in the clocksource core, several
clocksource drivers[2] still clear the OF_POPULATED flag manually, to
force probing the same device using both TIMER_OF_DECLARE() and standard
platform device probing (the latter may be done in a different driver).

[1] See of_clk_init(), of_gpiochip_scan_gpios(), of_irq_init().
[2] drivers/clocksource/ingenic-sysost.c
    drivers/clocksource/ingenic-timer.c
    drivers/clocksource/timer-versatile.c
---
 drivers/clocksource/renesas-ostm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 8da972dc171365bc..37db7e23a4d29135 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -210,6 +210,7 @@ static int __init ostm_init(struct device_node *np)
 		pr_info("%pOF: used for clock events\n", np);
 	}
 
+	of_node_set_flag(np, OF_POPULATED);
 	return 0;
 
 err_cleanup:
-- 
2.34.1


