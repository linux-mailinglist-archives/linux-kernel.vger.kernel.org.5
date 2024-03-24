Return-Path: <linux-kernel+bounces-114406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E72888FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A4A290717
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA8513F43F;
	Sun, 24 Mar 2024 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LILdpnX3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF61155721;
	Sun, 24 Mar 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321830; cv=none; b=mXqKDMdAxIJDJJqjZT7c+OcI6K2LpZUT7jbYY7tljKcluyV2sbO6lIoijbbY5Utj9t8UVbcz72KL1Z9Le2InpJZwVJCykH9n21NUzzdMVh39M61AFw0nzEWxflajOK96bYy2xSpmQZgtqgAIneLGfMohd/bqkmJ3o4Nhm4VyfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321830; c=relaxed/simple;
	bh=zwUzAYaODXUuLSoh8bMxnP8uZUATi/z+9DEgZAogWqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBAIqoByg2sW4KY3v0L6FituGcUSndzrbsiEf8fSVwRoPSa2gBNShRt8XdX+ixDWWqIddYDlWy5jCEaq/Z5HZ5x6qrj/whWi21JBe0lLpuvvW/TCEXf2z0QTQ8iivlvzt0j9FguLIOMGjGdPxBrbun79ucWTwXjWD8AGOpTh8ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LILdpnX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084DEC433C7;
	Sun, 24 Mar 2024 23:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321829;
	bh=zwUzAYaODXUuLSoh8bMxnP8uZUATi/z+9DEgZAogWqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LILdpnX3JeAQItPAFnuV8BUC0LSyFfwyo0q1q72DBESDZIMUgXvM0ybppIiuCma0b
	 DtvXOMm4VLmmcf4jUPwk9Pus98doeGCOJiJEyrNGYcK5k7k0fqMpaTTLW0bJCSGmE4
	 K9Bfnin1LBOLb1gZ/j1mOZToVxwXxXdAUJrvY8AbkIQFb3/IqxE3qMSLVoVBsdd+W/
	 IJdExY9ApA9OlMJkCvkt9JXVQ5hBgVP0PN/aZxQ2hHfeisW4dmGN8WW75EfzfiIcr6
	 tc5H4UhZQ3ySD5AjjjnsrEzYtXBxyYE5zuoaaw7Hp9+zGAscQejeUj/zVz00XL9NmF
	 j5PeX29E3GVbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@seco.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 558/638] usb: phy: generic: Get the vbus supply
Date: Sun, 24 Mar 2024 18:59:55 -0400
Message-ID: <20240324230116.1348576-559-sashal@kernel.org>
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


