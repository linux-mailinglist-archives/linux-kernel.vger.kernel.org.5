Return-Path: <linux-kernel+bounces-113502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ECF8884D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0D51F235BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736F13D62C;
	Sun, 24 Mar 2024 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDuMvQYH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D0313D60F;
	Sun, 24 Mar 2024 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320303; cv=none; b=QUmNSKnl6lumkN0n42G1gckKiwdcp+2Hvh2IT4bceWrC5BKs2YYyfqPFK/A71qg03gKfJTgmGfuWlgxiakyM2dKuSyuGQmoLjohBR/yKIGG9yEPifMhWmkELvuVMROqHKB3PV+qShoLL9jRaZCIENfwaimOxFjs9Tarb3lLBHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320303; c=relaxed/simple;
	bh=UbjWhGw39eex7ufjYGS0Vx+EZJu97EnVJ9Dwgi425+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVea9nmRujQEore+dJRx+LaQEWWsgb3p5nGM0aPO5c4DcGVpl0Nj0nHlVAwjz/iFbGI+bO81Xn4wlcpyTWh3chaoOqwFfG5srHsIDrh1HsAU+gee3BLAE2mwHuVz/Z4HRERMt3QJFuJKutbQvNqc96Yt7gDy7bNNMhAvW6o1DMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDuMvQYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0873C43394;
	Sun, 24 Mar 2024 22:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320303;
	bh=UbjWhGw39eex7ufjYGS0Vx+EZJu97EnVJ9Dwgi425+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDuMvQYHz2WGVVau6axavwzaSDPgkKpR0C0meXy1IScskskq3SHRhzCu6ijqhAg3n
	 qDdSSuRv7u9pqbjmialyHjVKWIfq3iYtAU7lweABaGNyGfb9mB0miUaeSqwHN2HYyd
	 RA16R5JH9xWYgVx60a9WEN9jmEBkx79iYBcyJ9M8LJ1Y2B55yfZY+3/VtOxO49+9Ys
	 sjKnqFFv3IR2NlODX+83B7e86aMDjAi5tzepqdW2mutQYcp4UFx80TUR6dwhKuJQ2b
	 QVG+I0gv3H3ICGo44xYk0ix5I+Q5T8F9KWC8Ga19aZmYFayqtc1a2Yg21WfIwzguZe
	 8WlPFKMC3ZQFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@seco.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 611/715] usb: phy: generic: Get the vbus supply
Date: Sun, 24 Mar 2024 18:33:10 -0400
Message-ID: <20240324223455.1342824-612-sashal@kernel.org>
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

From: Sean Anderson <sean.anderson@seco.com>

[ Upstream commit 75fd6485cccef269ac9eb3b71cf56753341195ef ]

While support for working with a vbus was added, the regulator was never
actually gotten (despite what was documented). Fix this by actually
getting the supply from the device tree.

Fixes: 7acc9973e3c4 ("usb: phy: generic: add vbus support")
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Link: https://lore.kernel.org/r/20240123225111.1629405-3-sean.anderson@seco.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/phy/phy-generic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 9ab50f26db607..16494030209ea 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -274,6 +274,13 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
 				     "could not get vbus regulator\n");
 
+	nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
+	if (PTR_ERR(nop->vbus_draw) == -ENODEV)
+		nop->vbus_draw = NULL;
+	if (IS_ERR(nop->vbus_draw))
+		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
+				     "could not get vbus regulator\n");
+
 	nop->dev		= dev;
 	nop->phy.dev		= nop->dev;
 	nop->phy.label		= "nop-xceiv";
-- 
2.43.0


