Return-Path: <linux-kernel+bounces-41166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BCB83ECCD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FE41F22FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2906F200C7;
	Sat, 27 Jan 2024 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/FXF07P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F491EA90;
	Sat, 27 Jan 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706353628; cv=none; b=NU7/mtxxjWQxxVGu+QVWN7Wv4mHDYMippz/P8e8nQIx/sho4ZyBq4yQnaYuUM9f8L87pmsOyuUcbIwXQIi4DLJzSMM+r/iBOcZN5OewYABkGe1wCml5SbOjbvaNOAU3lzVCbxQVhlJEykYcKBGQc0/CVekGAVFCRpsapWsccxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706353628; c=relaxed/simple;
	bh=qe/aJOd+xQG/BxiEuD+b3seWRLQAsRPSIUxpziPYzZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dotacqgHAM9Ey3zCSR1TR93IfjHEas1wlDpX6obqp3m9JySNcSAHJCaCnHtvr8uITH+WySX7XrWM3+uwtbIoljX6MwD1tAYBJ867fNHV9bPSAfM0+KCo2n8y3U1fPdRkNIQIGNAl2rs6/KrsKOHKjEJXnvnssCo9Edt/4mnhcfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/FXF07P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3DFC433F1;
	Sat, 27 Jan 2024 11:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706353627;
	bh=qe/aJOd+xQG/BxiEuD+b3seWRLQAsRPSIUxpziPYzZc=;
	h=From:To:Cc:Subject:Date:From;
	b=t/FXF07P0bGtTDbRB5QLdPEVF41f60ONKjKTgeTYWc/zs0SpTwH6PGK+oi0pBLJsF
	 ngdVKQgu5fQQNBXMT1Obk3UIlaZaEaxA3WSVmz9V0l94ioJFd4l0P2Ang3D2KRBp8d
	 1UvxwZNr86s1WNsIP0JFBjl0ImZbZzQG7nZtEvwVqqxS4ioIBR6wuSbtvKRt+Yeu6O
	 VBoKejH/70SvRpfPNqgZjsoYBE/fTSzJ3HVskNXw48gj3anUpN3vFtdx13P7BVf2Ua
	 cxKRsZ3Kg9O2Pktj9PiI7SeaRKzuJRsSwDOiM5ldJ/1vD08Aso5mhRR2laxTBIm2oA
	 UYOEQoa7wd2tw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rTgWf-00FKUL-4Q;
	Sat, 27 Jan 2024 11:07:05 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	yuzenghui@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH] irqchip/gic-v3-its: Restore quirk probing for ACPI-based systems
Date: Sat, 27 Jan 2024 11:07:02 +0000
Message-Id: <20240127110702.4068488-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, lpieralisi@kernel.org, yuzenghui@huawei.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

While refactoring the way the ITSs are probed, the handling of
quirks applicable to ACPI-based platforms was lost. As a result,
systems such as HIP07 lose their GICv4 functionnality, and some
other may even fail to boot, unless they are configured to boot
with DT.

Move the enabling of quirks into its_probe_one(), making it
common to all firmware implementations.

Fixes: 9585a495ac93 ("irqchip/gic-v3-its: Split allocation from initialisation of its_node")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fec1b58470df..250b4562f308 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5091,6 +5091,8 @@ static int __init its_probe_one(struct its_node *its)
 	u32 ctlr;
 	int err;
 
+	its_enable_quirks(its);
+
 	if (is_v4(its)) {
 		if (!(its->typer & GITS_TYPER_VMOVP)) {
 			err = its_compute_its_list_map(its);
@@ -5442,7 +5444,6 @@ static int __init its_of_probe(struct device_node *node)
 		if (!its)
 			return -ENOMEM;
 
-		its_enable_quirks(its);
 		err = its_probe_one(its);
 		if (err)  {
 			its_node_destroy(its);
-- 
2.39.2


