Return-Path: <linux-kernel+bounces-115724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E38889740
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32E329D07B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C49315D5A1;
	Mon, 25 Mar 2024 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLuGYgPN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9545121854C;
	Sun, 24 Mar 2024 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321795; cv=none; b=AvdyeCLfxjt7SJAkYeVktjkC7jPfe3zNlnO+TRDsI2tbQkLnPY4CEtW1isbViKp5ZRtOp/KxdjrKsycpKHeMob4DCrmeKYjPRYjdoU1uL87cLHi9WpuL9nRzNTuNvwYJ0W6mhsZCli9bcLG8ocTzHSy72e/8xgVKFtoaTIv67uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321795; c=relaxed/simple;
	bh=61ig6KY+3rHTaiDAJSpLkvKKNyy/0dKRoB4HO5zjqVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDR9zPoKL5wdmZFwU+Ehj3AcsxM0coVN1stvLKAknoPIDgM97ZfzKAexaG8AO3qPmkD6vKHFTRkWSZx+U778rWsdA0bP2hYt6V1j6BxVbrA6jWInFfi/8/W5Z+nTTdgSfuSVL2GeAtCLy5njDAmrG4ai5FDe6lWt2V29xvVjdFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLuGYgPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E52C433F1;
	Sun, 24 Mar 2024 23:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321795;
	bh=61ig6KY+3rHTaiDAJSpLkvKKNyy/0dKRoB4HO5zjqVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLuGYgPN2QrPtPoq8NzgvhLq8n+BX7Mtzq6HNL1dH3RlbkuFgf9Z81vq6uZOWvOHl
	 IYo0smqp6rWwzlj/twCWfW1QGa/GZSjx/2xjrVCDaUZ7Ok1CL40jPj/yVmHjueU53Z
	 +KI8AHlKya0RmOwhlMLr4kX+G+eMCZ+B9ia4NwFVq150AmaFRs4cRpescGCfXILmvG
	 1ZLNwxj4GO9yo9u/R1xzoXzGsD1gBHZZwFSkAFT9fMtejtPJNDkSFSB+QN3RUs0OWN
	 qKHeHKCA0PQR0sacMaoeEqZtYajEIN5/+AuuH2+uAQmf4vwGS+GypTmDFAP5FEZ9cE
	 XLgUnzrTarPNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dylan Hung <dylan_hung@aspeedtech.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 523/638] i3c: dw: Disable IBI IRQ depends on hot-join and SIR enabling
Date: Sun, 24 Mar 2024 18:59:20 -0400
Message-ID: <20240324230116.1348576-524-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dylan Hung <dylan_hung@aspeedtech.com>

[ Upstream commit 10201396ef6455a68ac671fa0163205d327ebb70 ]

Disable IBI IRQ signal and status only when hot-join and SIR enabling of
all target devices attached to the bus are disabled.

Fixes: e389b1d72a62 ("i3c: dw: Add support for in-band interrupts")

Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
Link: https://lore.kernel.org/r/20240119054547.983693-1-dylan_hung@aspeedtech.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/dw-i3c-master.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 9332ae5f64190..235235613c1b9 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1163,8 +1163,10 @@ static void dw_i3c_master_set_sir_enabled(struct dw_i3c_master *master,
 		global = reg == 0xffffffff;
 		reg &= ~BIT(idx);
 	} else {
-		global = reg == 0;
+		bool hj_rejected = !!(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_HOT_JOIN_NACK);
+
 		reg |= BIT(idx);
+		global = (reg == 0xffffffff) && hj_rejected;
 	}
 	writel(reg, master->regs + IBI_SIR_REQ_REJECT);
 
-- 
2.43.0


