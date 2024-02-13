Return-Path: <linux-kernel+bounces-63319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D1A852D91
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92936B25168
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF6122F08;
	Tue, 13 Feb 2024 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WarX6W84"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1BC225D7;
	Tue, 13 Feb 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819133; cv=none; b=KLdfYuNDRuLOAKDFVl4N7ZhryP6vxTRZbNumW1ZW/mAI7ygt7WaR5HlpU9p6wRHc62fzLH50sT3y3rO5ttZjxXgfilatHScL7YEsu6t+kw/bHETlaMHeAdyy6+YA1W4CoGWaO47T7+fQF3r8GupnWqZRLR5hTq2eUA76sQvWtGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819133; c=relaxed/simple;
	bh=FYsp97vFbDiqatkf1UqYPH39ft6E0mUS7CzZXsJpk5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=opyLBvaZS6l+KGuD/RJak14sqtnt9ZC0bt4T2dpOlRj+eH58oYguiLzWzmgpvdKx67klDKY+yj5bGbur1gGL6O0X0DV1icbLSlo2MRiBboKsGdKKHXUji4ZXHIQZryNaaOxeKU6fDsS2yKqhuFG3lCQaC8WCuGR2+oCZ1bOBWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WarX6W84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CD7C43394;
	Tue, 13 Feb 2024 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819133;
	bh=FYsp97vFbDiqatkf1UqYPH39ft6E0mUS7CzZXsJpk5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WarX6W8402RK6EJ2bQjfEIFEb6JGg4S+xOhyWQYRFC2bV92GNHC6kZmpSPzvetnZ1
	 czegp3GfMGUbkOZ05z3gVzKTl+q2e6vuny672EFAG+dukKOyhTajePpDqCm+rlADYw
	 Cow/zY0fupw/WmtF7NULqrO/QEdf5+yvtjC36YxrHOEG/7l3pProD0qc6elNTBae0R
	 aTlu5A9zJtXHswKxhlZyqOMieezKWlKW5ea1RsZp5NlglFxi606j0bU3GDjWys2UiD
	 L9MRjvZRLQASGUJkcDFxqUnZDfeGGFnVGhikGcBfFl99F3V2ggDmcWQ3+L+ikUOh+Q
	 ohZJ443Dg4NEg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rZplr-002j7r-4j;
	Tue, 13 Feb 2024 10:12:11 +0000
From: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kunkun Jiang <jiangkunkun@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] irqchip/gic-v3-its: Restore quirk probing for ACPI-based systems
Date: Tue, 13 Feb 2024 10:12:05 +0000
Message-Id: <20240213101206.2137483-3-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213101206.2137483-1-maz@kernel.org>
References: <20240213101206.2137483-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, jiangkunkun@huawei.com, lpieralisi@kernel.org, yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
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
Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
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


