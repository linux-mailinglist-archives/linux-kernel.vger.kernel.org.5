Return-Path: <linux-kernel+bounces-114644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D53888B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCC328C30D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D231F136E0C;
	Sun, 24 Mar 2024 23:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdzJMhJ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40109236CF1;
	Sun, 24 Mar 2024 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322306; cv=none; b=BSOrWVQfQBNJXfdzcPUOzxg87XwrBDVMAYhpMc0ytxqoOyZQKp+IefWX0livu7ZgQaWvKyugiVBR/UkGjh8S8f2M3ybS9o4pqplDfIdwB0o9WSP0AgGLGn4yQBm7+ICKR34U6WRIu10yxIQTVlbQ96C875exYqn4ykE+xorpe7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322306; c=relaxed/simple;
	bh=8OV+VAZZ7dNDf3Whe2RC4s0eAI8cTeKw9wnvWG2aWTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKV7wDqcLPN9Dp/y5av3xK2lAvRVLVkkbWysfL30CEfPUaypae9E7TKbB7+TF0eM4fJlRcHQo77KpSbSzI+6xdhqbyxMj54MNcstb2eSYOOeg5OmXceNmK+MjbXHT7FzTc7ySQPC7itfJudfldrryi2++IlrJ3wVQl4PtlIlr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdzJMhJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8157FC43390;
	Sun, 24 Mar 2024 23:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322306;
	bh=8OV+VAZZ7dNDf3Whe2RC4s0eAI8cTeKw9wnvWG2aWTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdzJMhJ9jwl67j/D7H+uoVAgu/bb7YyDKdY0ROy+xqDWnAU7/uUSx1qdUbbRGuVve
	 6IgxBKteKqlnoMci3TWQgR/mJD8tATRC+kR2f9pESxD25TjM5w50SXMrTdx1UJ7qKu
	 ri2Slpt1QvOCQDIN/q8HresfTZ+5o3y6F3ebnpTRf++xeBEpIf+dOKHPp4IGLZKSXW
	 rLt03zawUYFD3x7fH5xrtyxveMx6+2Jzz82SmD9DFKRgL0gvzhpvHqg/KcDsMgbWnt
	 cjYTEd3YnBiKceZJ6otwMGJ4mvD594V49zIv6i5XKcf8S7RgW1EcgUMuIxKuhCeTG/
	 S0Qb0GGTEQpVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@seco.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 389/451] usb: phy: generic: Get the vbus supply
Date: Sun, 24 Mar 2024 19:11:05 -0400
Message-ID: <20240324231207.1351418-390-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 3dc5c04e7cbf9..953df04b40d40 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -265,6 +265,13 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 			return -EPROBE_DEFER;
 	}
 
+	nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
+	if (PTR_ERR(nop->vbus_draw) == -ENODEV)
+		nop->vbus_draw = NULL;
+	if (IS_ERR(nop->vbus_draw))
+		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
+				     "could not get vbus regulator\n");
+
 	nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
 	if (PTR_ERR(nop->vbus_draw) == -ENODEV)
 		nop->vbus_draw = NULL;
-- 
2.43.0


