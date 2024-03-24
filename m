Return-Path: <linux-kernel+bounces-113460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D7888484
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0754F1F245A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7361B16B3;
	Sun, 24 Mar 2024 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBpo3bxQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972511B0DFF;
	Sun, 24 Mar 2024 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320261; cv=none; b=AxNKhB/p7bBPgtp6SfIb7PlYJ1sXxQVTO2mIwvUqQyZGtWWf+NFbNopI6TzKfZxnfCcNEOpXXB7D2qAH+Murhf5zdKEmkNTYeje7zVNqULmiF4UpDbErA8dIMOlOm4pL7tbaRLNr+N9djL33fdnKUjva3nwnIbmVF7JW6h4DKIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320261; c=relaxed/simple;
	bh=4C25oCwPgly30uqHrAYSqQTvBxyzpXbGxKpIMOxu0jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYF9SSi3ZQ4W2jArmh3MtstToRKWFz610EoBvlbMbBNsMa5uztvA08OkxjPPP4p/vSbdhXzWCaZ33lAPMQQeHZrCPmWULcbS0Phv7qMseZMnh5dBpTcz2hxKYycgf5Fq3niO6+Zw0SIOd5dw6bOcUO+L0567zehaI0Pls9qIge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBpo3bxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB16FC433C7;
	Sun, 24 Mar 2024 22:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320261;
	bh=4C25oCwPgly30uqHrAYSqQTvBxyzpXbGxKpIMOxu0jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBpo3bxQ/7P0omDL7tjRyt39uv4DiNk2LH91j9AqHzBAbBSIqV6nYNRuu1q7bVOEd
	 hJZY5x5Ay302uUKMstW/IL9Iqk8OAkI4+ILwAEzZ95LxaNfiEszWnY6wWMMF9tUIO4
	 JQ6VZK1HwbjBsRLFznKZM5ASp1xdpiIEHc16VHlp5DuEaK8ksvW63UI73PQv6upmK5
	 C9nBJGibzUejIGT3avmrGeFWx7QLK46ikzhBQI8Pjf7brbAFKeAwkmOBNA5ZY4KDks
	 F/klgJOd5CSHSSClhquc+s+1Mwz8xFrTunMKErD551YVGaRw2hifcR1azWGdB5jV1T
	 aDP7yul9FDApg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dylan Hung <dylan_hung@aspeedtech.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 569/715] i3c: dw: Disable IBI IRQ depends on hot-join and SIR enabling
Date: Sun, 24 Mar 2024 18:32:28 -0400
Message-ID: <20240324223455.1342824-570-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index ef5751e91cc9e..276153e10f5a4 100644
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


