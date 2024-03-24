Return-Path: <linux-kernel+bounces-115554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C178889C59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06471F3646B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533CF24CB5B;
	Mon, 25 Mar 2024 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq4GcX9I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F7112C7FA;
	Sun, 24 Mar 2024 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321059; cv=none; b=pZlT9+eXzd/J8ZnUIGVuwfr8Ihyb4vpSlKjPW+HUbiO8Gv+7Kgnvjbay1fQXiMvizPNRlvdtkvM4LdFZVVAvXf4ytQrTZ0oiqsi+rx7OtU15sIfzwlJuEwrifJtwTuRPRLOsxMmDpV/VaxbSfKmRqMAcqVPyVJqbHNUX1GSsZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321059; c=relaxed/simple;
	bh=zwUzAYaODXUuLSoh8bMxnP8uZUATi/z+9DEgZAogWqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2D+sItm0d8ZYD1crh0HfVKDJ2SlCcb5CKvMOwC5PzaDqTn8UCx/tU7FiSZ2TlbtZw8DoDnCu2tPeT5AlshwA2lUKOYE0azumRO7h3pXKtU8bkCtQXtauFrDMwWPuWOtPZWHv2oreaXG+jjYxtPBd8S8tSUOy1u9dR9G02vyT4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eq4GcX9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EB6C433F1;
	Sun, 24 Mar 2024 22:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321058;
	bh=zwUzAYaODXUuLSoh8bMxnP8uZUATi/z+9DEgZAogWqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eq4GcX9IzRIEbPArSzuGyHf3q9PPmm/OvoMVxx/UKB9Yx9VfPUC6yGd+XyrxDtuNo
	 zv44VMtrv9kDI96l4vSRvZ3vYT6BbwaVMNqFSlySM90EwXn/RlWHtUZyqaLg83AgC0
	 vCvbepowgYd/JkXP0BbCTCTHBADM8M28aKiu9XywDOtJJbdKZ/e62/KENigxAdHgha
	 JEJVqn+Wifi+jwqZU5JZZphUapdBtsjSOVbT+3atGFYXUNHbEgo0BZUOOZzf5kUPXb
	 3oy1CmN2YXnClQUwm+0tfINIwrBY0z8VBqQ5TGIQW51O4BN1hUDHNVbfk9abngq/8x
	 BqhazniTKSIWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@seco.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 622/713] usb: phy: generic: Get the vbus supply
Date: Sun, 24 Mar 2024 18:45:48 -0400
Message-ID: <20240324224720.1345309-623-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 770081b828a42..b855d291dfe6b 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -268,6 +268,13 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
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


