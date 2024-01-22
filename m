Return-Path: <linux-kernel+bounces-33424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B32F8369BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE01B27C96
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD6E85C4D;
	Mon, 22 Jan 2024 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSPVquO+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9C682D9A;
	Mon, 22 Jan 2024 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936253; cv=none; b=jxCIPFUej6mAEHpXdylnvfJBokycoKftkuzF2MdYNo+4REXBbcs20H1SrZXNcjRJItcAc0T7l03LwVYNiiGiF+cgA6XP52jbiLKnMpI1Hy/huLfhaL2tCyvBpmFKSjYgAqE66Ob9LIdPZsp/vKN9tA/r/L4IRIOQL4dqeLgvpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936253; c=relaxed/simple;
	bh=RS24I3RMlh5SunniZKPOGnIwCQFjxcZVZKSV7iwDCkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0Ro5IXLesHqkyCPEzjq4N6riapLE2k7wn0qDLb9iHzkr1sLPACK0AHcPmSnGbHByfKs2z3a454soP1g6yeAaG9Cevc29doR/Cs7PxXADBc2SZwpSJgu3uA0Ngf3WDiO1SN+6aEcyCajjfmZneFjKKSStT4KQmAhzL10WMvRR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSPVquO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A10EC43399;
	Mon, 22 Jan 2024 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936252;
	bh=RS24I3RMlh5SunniZKPOGnIwCQFjxcZVZKSV7iwDCkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSPVquO+avespa4ESeU9fdza6Q9+/c/0wb1vi/o527CIOrynCzU/KKfQMRTtSmVNJ
	 3UqdILSvqLzxv8tzBxW5TRhw3jn3+6Dt4Hf+WXw2jSAKG5+z0Yoflwvddhyp7laTyo
	 tfSZOelNlO93hSGF8eDSmVB0UZtQsKu2kEXlPsTce5idPY7Q1tljbXtC58trcUtNRJ
	 XvePiDR8AAjeVnNiPLTTYJB9J376uLdgxn+7pRTBs8L9KVoJAHFxhuj2GJiJXbBMGo
	 gTROWwC2cPrNXHcF+w8crJ3Vhr8+gUfo9XVDgoja4NAk45Bj6oVQYqWJO3BnYfWsz+
	 ZIkIH5qtUIcZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Adam Ford <aford173@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dafna@fastmail.com,
	heiko@sntech.de,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 24/53] media: rkisp1: Fix IRQ handler return values
Date: Mon, 22 Jan 2024 10:08:25 -0500
Message-ID: <20240122150949.994249-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 3eb7910e1b16a2c136be26a8380f21469225b2f6 ]

The IRQ handler rkisp1_isr() calls sub-handlers, all of which returns an
irqreturn_t value, but rkisp1_isr() ignores those values and always
returns IRQ_HANDLED.

Fix this by collecting the return values, and returning IRQ_HANDLED or
IRQ_NONE as appropriate.

Link: https://lore.kernel.org/r/20231207-rkisp-irq-fix-v3-2-358a2c871a3c@ideasonboard.com

Tested-by: Adam Ford <aford173@gmail.com>  #imx8mp-beacon
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c  | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index e2352a056098..01c831fb3240 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -442,17 +442,25 @@ static int rkisp1_entities_register(struct rkisp1_device *rkisp1)
 
 static irqreturn_t rkisp1_isr(int irq, void *ctx)
 {
+	irqreturn_t ret = IRQ_NONE;
+
 	/*
 	 * Call rkisp1_capture_isr() first to handle the frame that
 	 * potentially completed using the current frame_sequence number before
 	 * it is potentially incremented by rkisp1_isp_isr() in the vertical
 	 * sync.
 	 */
-	rkisp1_capture_isr(irq, ctx);
-	rkisp1_isp_isr(irq, ctx);
-	rkisp1_csi_isr(irq, ctx);
 
-	return IRQ_HANDLED;
+	if (rkisp1_capture_isr(irq, ctx) == IRQ_HANDLED)
+		ret = IRQ_HANDLED;
+
+	if (rkisp1_isp_isr(irq, ctx) == IRQ_HANDLED)
+		ret = IRQ_HANDLED;
+
+	if (rkisp1_csi_isr(irq, ctx) == IRQ_HANDLED)
+		ret = IRQ_HANDLED;
+
+	return ret;
 }
 
 static const char * const px30_isp_clks[] = {
-- 
2.43.0


