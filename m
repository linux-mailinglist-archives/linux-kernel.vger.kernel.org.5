Return-Path: <linux-kernel+bounces-101836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF6287AC03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D99F1C20BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CF46F07B;
	Wed, 13 Mar 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICgqVFRl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A566F068;
	Wed, 13 Mar 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347871; cv=none; b=tKM3h1+ILQd4t+MLIJvRA+9WSi3l70dE8jIEYjLDV46bbEVB+30Vyt5Sf/CahCHHVELausVYiMx1zuZH8YQpQul8kncpFgjRrpXdqLwSgUQvjGDz933Kfx7zv0Si1HcJglavkUbHTG6lD6eyowHewjjPnuI2X1oAboK/rmjPyKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347871; c=relaxed/simple;
	bh=gCc354VV2RHhC+3wRo+eHNpK+3QIIn//kY2xO+M8bo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnayeH4eVnPdKm/idlFbfV/Z+KX8o0QkClgdly45TJeaa3GO7v31UAphBAMPXsxMOVyduzuVYqdYClgVQ14h6Qak8+vsnI7k9h2JeTJBqvR6prK7zAABSEj2NWhKVGGwEfFPIkvOR82fx+zWXpNaCftPXKUJ+WGxvXEVdBSJROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICgqVFRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC87C433C7;
	Wed, 13 Mar 2024 16:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347871;
	bh=gCc354VV2RHhC+3wRo+eHNpK+3QIIn//kY2xO+M8bo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICgqVFRlue/wFFOGET/d1sIfgv9QuC3OTgXggl9uMukOED1WolecD02CA/CMACmzR
	 UAHxbs7h8RfmoXjxhtvwLGBl8skpKLAwSgLVd+nu1KyIw2Sb92QlRKL9poKPwPWyRJ
	 Ovo/AYhoXk7G4RtOOWHygIPMVVullruwJU6yXTL+Fd7MKuR+oxzy2B6FjO9y41iwnk
	 BBX+T2Cj4jh9cvhlLmP9J2HleiRXm2nA6GzUpI9tMBG56cml2DaGNxBjVvvRxILJrN
	 KmHPSP3sWcO+m5txA+Nb6krMhxUPxOZCBmgKXxWePYbA7J2tJ4qx+hYM+ZvOr7Sske
	 sx9+jpc9BI2cA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Tobias Jakobi (Compleo)" <tobias.jakobi.compleo@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 33/60] net: dsa: microchip: fix register write order in ksz8_ind_write8()
Date: Wed, 13 Mar 2024 12:36:40 -0400
Message-ID: <20240313163707.615000-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
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
index 91aba470fb2fa..28d7ada3ec067 100644
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


