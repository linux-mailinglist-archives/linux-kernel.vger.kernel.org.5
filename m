Return-Path: <linux-kernel+bounces-101882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C48F187AC68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A6FB2193B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C08D79929;
	Wed, 13 Mar 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI6DMlYT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA4578B73;
	Wed, 13 Mar 2024 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348017; cv=none; b=MKZMqm31Tab6CN4oHwKI6rYbNQ1ZpI/JLwM+1xbQK0in/dL0P51RDiiHXCKdYwJh+b+j7oDIcLkYC4rhSaxwqHiKSaKNJfR2OablMxFuNpIJCBTfWRm0gI/HPyN1Xjq0wvFVSZkShaK28PsZ2BpGdpXhRgODw29v4nxJGSIB4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348017; c=relaxed/simple;
	bh=JiesEdlzoVGe/xKN+QRJDdEeXgxYM7KmKZPfFDARIQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g54q+8l14s8a9s1PC4PPKFBZyLN+QA9dm2SfV1aNoJ7vH234peSkxKvV3g4KhMeXt7KbzEuQuY1kFzSR4xBLDUWHXsjxKgKcVN9PN2PcRg7j1ZTxV8wIAiqWgr47ji3tqwEao3VotWwRrST7sUyc/y6qI68djw6/R8TgHgUNBEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI6DMlYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D023C43390;
	Wed, 13 Mar 2024 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348017;
	bh=JiesEdlzoVGe/xKN+QRJDdEeXgxYM7KmKZPfFDARIQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pI6DMlYTXbgKPDB/RV78gN7zpGH9EHr6F7mRv5oNCy1nNrB6a3nB9dLQ2cP/6UicI
	 Uc4IiSOA/r+naUE2XRkCWbTXjqtvGw1G04AiiAephlWL54kf1PY6cuxb9/K/wtNiaK
	 yFtjXBwMhANFdyrOWfaffWrRubO2HjsjrW4eRuc7u0C4d3514Z9mLOvPsJxNzkiBOm
	 Bz1GkLuOhbfyPkUhbWz0j5RiJKEUCTqiexUWcbBAtOgMPqn9b2jKRQJtluCN3Lw1Xy
	 BVY0MYY3AYdeF3WfA6f+QI4xA5Z9psS2UPs8Y7Z6gPPXTx9fxF/+X4jUgOsKIlPW2D
	 +17V32ZuZub3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Tobias Jakobi (Compleo)" <tobias.jakobi.compleo@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 14/71] net: dsa: microchip: fix register write order in ksz8_ind_write8()
Date: Wed, 13 Mar 2024 12:39:00 -0400
Message-ID: <20240313163957.615276-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
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
index c63e082dc57dc..934600eccbaf2 100644
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


