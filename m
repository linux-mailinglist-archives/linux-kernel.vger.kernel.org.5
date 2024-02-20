Return-Path: <linux-kernel+bounces-72938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFB385BAE5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EFA3B23632
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A95B67A0F;
	Tue, 20 Feb 2024 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwjJmyhd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EFF6775E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429657; cv=none; b=WS5eGW3PyuUvE/lQTJf+OP5BIZk+zqor0pzNK5wl7iYuUEi7QTmUkRhEQB1U4+MkH0mzb6hdtqaX9BH9vTwFSDVCdW/UYcptX+HjMH/fOK0RI+OQb8q8XCT14Uc8tht6Y0XJtXAPUoVcLezb0Nk/DGY/wH1SIuUISUCz1j82Qco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429657; c=relaxed/simple;
	bh=X+ZqMf3IK+JD8CFxWrUuIKFK5IZbu0of21KCXRE6D6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RpO9dNMgvoATohoTHoBAjVzKtkMQn7JtNwtO26gCUdLEsg61xA4TekN5/Svmp26ZvLZTUh5FKAtiT/VfkDaW8zeuTGV7rhVTxmw+vjGGWw/YcTZIefXuLBJ1yyvUCWqwOCsw6WT4o2hX8BlYoEqA8jTE6LTROEqpTGQgCSXbLK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwjJmyhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E44C433F1;
	Tue, 20 Feb 2024 11:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708429656;
	bh=X+ZqMf3IK+JD8CFxWrUuIKFK5IZbu0of21KCXRE6D6E=;
	h=From:To:Cc:Subject:Date:From;
	b=RwjJmyhd5MtZxLjlIfA020w2JgutNuOVi8JavflhXQNUkW0ASaEuMKPPVU2U3bT/u
	 8R1bvicYO0Neszs6orB53+I4QoLqgl+6HBZqi7+FgNLMh8C6FEwIc2b+R5wsPBTZQ+
	 HkJgcOeUBQxNE4q4cfnmKCLdNx2Opo++bTU+XwEGp/AwmP8Tk5QDzE4Ytpt8DtBK0E
	 ccL11a69TCSM+WO4jpotUS/hGns6oRHhd7q3WkkJaT//VOcI50khmBT8ZcdFIZwcPX
	 GyOtLEVbBHD+FJQR+8BYnMAEkA+ZHM9kIjJcEI7fk90gdhm33w+EF2FTwtYRN4B+Wr
	 HyK7x+FjSb5gA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rcOb0-004u3X-H5;
	Tue, 20 Feb 2024 11:47:34 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH] genirq/irqdomain: Don't call ops->select for DOMAIN_BUS_ANY tokens
Date: Tue, 20 Feb 2024 11:47:31 +0000
Message-Id: <20240220114731.1898534-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, dmitry.baryshkov@linaro.org, biju.das.jz@bp.renesas.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Users of the IRQCHIP_PLATFORM_DRIVER_{BEGIN,END} helpers rely
on a fwspec containing only the fwnode (and crucially a number
of parameters set to 0) together with a DOMAIN_BUS_ANY token
to check whether a parent irqchip has probed and registered
a domain.

Since de1ff306dcf4 ("genirq/irqdomain: Remove the param count
restriction from select()"), we call ops->select unconditionally,
meaning that irqchips implementing select now need to handle
ANY as a match.

Instead of adding more esoteric checks to the individual drivers,
add that condition to irq_find_matching_fwspec(), and let it
handle the corner case, as per the comment in the function.

This restores the functionnality of the above helpers.

Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Fixes: de1ff306dcf4 ("genirq/irqdomain: Remove the param count restriction from select()")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20240219-gic-fix-child-domain-v1-1-09f8fd2d9a8f@linaro.org
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index aeb41655d6de..3dd1c871e091 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -449,7 +449,7 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 	 */
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(h, &irq_domain_list, link) {
-		if (h->ops->select)
+		if (h->ops->select && bus_token != DOMAIN_BUS_ANY)
 			rc = h->ops->select(h, fwspec, bus_token);
 		else if (h->ops->match)
 			rc = h->ops->match(h, to_of_node(fwnode), bus_token);
-- 
2.39.2


