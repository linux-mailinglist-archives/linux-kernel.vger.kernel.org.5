Return-Path: <linux-kernel+bounces-115150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8226889327
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C0B295857
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC49303492;
	Mon, 25 Mar 2024 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMGQyiCI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5433B28ECAB;
	Sun, 24 Mar 2024 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324168; cv=none; b=k/Du24tZfCY5sLtmy44XWPNqX1ipfRZ9hUgKepKYbXO6p739F8Q2GVC+a3OfQaeRj/olEMB6VEW58sie92lBx7qlh3x65Ht+lAkZQEpmfOE6nqyGIpYkIx/mT9cBrYrtmfMdJ4iRPSsRXL8KDcpUxMXU7iSEWpghNT8Au6ar/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324168; c=relaxed/simple;
	bh=nKQoc1DwiUrnUcoKk605gJP8MdHJHIWy+wH2tgP474o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZweHXqrP4UddpN1qINsUHm7kzgMxMtKvG9a0FHgcrYDvIcgyGdl/IPvmNwMa+ZXkfTOm8y1c7807eApYpkm5DyXfP/2j2Z35zuZ4EQ9DhYO1mvsf2vDCnqkaQG9nSxjz9R1HSwJCwQFjQ1FNOUuchThuvM5OB1M4iBuuOd5Jr1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMGQyiCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2676CC433C7;
	Sun, 24 Mar 2024 23:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324167;
	bh=nKQoc1DwiUrnUcoKk605gJP8MdHJHIWy+wH2tgP474o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMGQyiCI2r4S+5XK7Rm9TYuDoBdDouZiGd07bQ5CXBFyp4yre5mhxC8Cvkmm3s9Vs
	 SDG0V2/dQuXHNXGLIletfPjvhcWHAAZQAUS9IGIF3YXUTJAGapgikkNMPwJwUu41wh
	 vllCWL7YZAsX7UvFgpB5xllYJE8LgwDzXeesJQGOj0eboBLKpOSqv7v4BYCH6j1YTP
	 V2P4IhwaUe4Pj+grWifkjXCZeskFREkeS+5ERqNpIOaPe+txRg9ggSgHmlhIvsTatl
	 jT7KA6cjAU9YPQ6CPcI1yeqPO+DdTj9piPgeJtzXG6Auv2jqIlait8qJVLnA3v2ENn
	 i2x1RnH6G2qsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@seco.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 160/183] usb: phy: generic: Get the vbus supply
Date: Sun, 24 Mar 2024 19:46:13 -0400
Message-ID: <20240324234638.1355609-161-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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

[ Upstream commit 03e607cbb2931374db1825f371e9c7f28526d3f4 ]

While support for working with a vbus was added, the regulator was never
actually gotten (despite what was documented). Fix this by actually
getting the supply from the device tree.

Fixes: 7acc9973e3c4 ("usb: phy: generic: add vbus support")
Cc: stable <stable@kernel.org>
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Link: https://lore.kernel.org/r/20220425171412.1188485-3-sean.anderson@seco.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/phy/phy-generic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index a53b89be53248..8a04b157f19f3 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -283,6 +283,13 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop,
 			return -EPROBE_DEFER;
 	}
 
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


