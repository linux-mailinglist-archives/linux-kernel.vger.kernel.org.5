Return-Path: <linux-kernel+bounces-101777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786EF87AB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CEE28ED5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6644B626A2;
	Wed, 13 Mar 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djBkTlkO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5662168;
	Wed, 13 Mar 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347605; cv=none; b=EJSOTB1RNXJUo/CAvRJBPrr/SQkfy9Q6xdY4WuGjqAP3nSWXIe9yYzPDY/sggVIhKISYunjRP0E/gslWMyM+q2SmONJ849sdc/NY7+vvDXFkzgxZAqrgHLjvT8DYiz8biQ72bU36j/dVdlFY1yY/B1cuj4uvFhTfqvDs5m6nHZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347605; c=relaxed/simple;
	bh=NYr2Ltq/OsfLmNs7jVfPR5NqFaGjW2qIWgPwLQAP4rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT7a8vuGjjoUA+Kg/R+pqMloEbTr01dJ/T5ZPm+oOP/jd0v3JsdjtzMGdkWCGZgHNy9gO4O/Mwe4rNT/zep1V8EeWMK17iBI28MjeQ9voTnmGGsK8JzIuRK/WO38cDqQbdNilk2qgJJc+UdqryYsVaCF3iCe1b1KDS1Tb55jiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djBkTlkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF34C433C7;
	Wed, 13 Mar 2024 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347605;
	bh=NYr2Ltq/OsfLmNs7jVfPR5NqFaGjW2qIWgPwLQAP4rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=djBkTlkOS7bTxrISKm/MMNm9g4mzmVBYhZmMSH3Y0KXrJHCfNLaj+kpVQqpnboFE/
	 I/A3AdsG//CNnTU9H93+yMyFjOpZvnnlb9QzwzrceBwwmsvr1vn6Ma+Ge97aqkZl+s
	 G8CeVTOYZeYSxWV8OrC0avpgWIeukeLwtXNsKefgqXg9RHb9okjiF9zZiZkRAs8gwW
	 kCKO7oSfQgZFKgQlrlkN1JiqBLCGLOH2t+GcraarEl/kbbDwUwAIvUNP4ixQcCN99F
	 OjY5aPULmpSOkPXmmAn1d6M7hb5u2tLqcSeK6hzOU9x4GTrdSBkz1/Wv9iWyLU0OJ5
	 e8pX4/YZDvV6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Tobias Jakobi (Compleo)" <tobias.jakobi.compleo@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 38/61] net: dsa: microchip: fix register write order in ksz8_ind_write8()
Date: Wed, 13 Mar 2024 12:32:13 -0400
Message-ID: <20240313163236.613880-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "Tobias Jakobi (Compleo)" <tobias.jakobi.compleo@gmail.com>

[ Upstream commit b7fb7729c94fb2d23c79ff44f7a2da089c92d81c ]

This bug was noticed while re-implementing parts of the kernel
driver in userspace using spidev. The goal was to enable some
of the errata workarounds that Microchip describes in their
errata sheet [1].

Both the errata sheet and the regular datasheet of e.g. the KSZ8795
imply that you need to do this for indirect register accesses:
- write a 16-bit value to a control register pair (this value
  consists of the indirect register table, and the offset inside
  the table)
- either read or write an 8-bit value from the data storage
  register (indicated by REG_IND_BYTE in the kernel)

The current implementation has the order swapped. It can be
proven, by reading back some indirect register with known content
(the EEE register modified in ksz8_handle_global_errata() is one of
these), that this implementation does not work.

Private discussion with Oleksij Rempel of Pengutronix has revealed
that the workaround was apparantly never tested on actual hardware.

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/Errata/KSZ87xx-Errata-DS80000687C.pdf

Signed-off-by: Tobias Jakobi (Compleo) <tobias.jakobi.compleo@gmail.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Fixes: 7b6e6235b664 ("net: dsa: microchip: ksz8795: handle eee specif erratum")
Link: https://lore.kernel.org/r/20240304154135.161332-1-tobias.jakobi.compleo@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz8795.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 4bf4d67557dcf..9048d1f196110 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -49,9 +49,9 @@ static int ksz8_ind_write8(struct ksz_device *dev, u8 table, u16 addr, u8 data)
 	mutex_lock(&dev->alu_mutex);
 
 	ctrl_addr = IND_ACC_TABLE(table) | addr;
-	ret = ksz_write8(dev, regs[REG_IND_BYTE], data);
+	ret = ksz_write16(dev, regs[REG_IND_CTRL_0], ctrl_addr);
 	if (!ret)
-		ret = ksz_write16(dev, regs[REG_IND_CTRL_0], ctrl_addr);
+		ret = ksz_write8(dev, regs[REG_IND_BYTE], data);
 
 	mutex_unlock(&dev->alu_mutex);
 
-- 
2.43.0


