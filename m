Return-Path: <linux-kernel+bounces-116348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0957889E66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C7B1F3784E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C89229918D;
	Mon, 25 Mar 2024 03:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxDniNk9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB9A1856D9;
	Sun, 24 Mar 2024 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324368; cv=none; b=NYbxvLg9nX3gzaB+y8FEeUqLgPhAdMCuXuQjlW5hT+Vjt06fUNvHDsYYmpXX5jgjW3WHw4l7lwM2HdlGaPCJ3IYfSBqM4ceWGHVbDgg79EcKRDjyxzmmVm6WdoL4B5EFdi2EimgGMoPxQwstIH0ZhJ0VxrADUkAV1cVc0TwYJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324368; c=relaxed/simple;
	bh=nKQoc1DwiUrnUcoKk605gJP8MdHJHIWy+wH2tgP474o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/mTGMxkSvEbu+P/0+ssd5vxBeH5Q2QXNRwCJ7bQh8DB6IXW84DweaEzDr1aT7xDJUtIc4Mkl8cE8ho6BZWA4oC/av3gJMA2mcuAO1KmZUf3GojMl0PcMnNm6fB1UpYsFFYy3Pu02lSTxQHu6nxR84R0AiXO5CDm5/uGfv12qrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxDniNk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9CBC433F1;
	Sun, 24 Mar 2024 23:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324367;
	bh=nKQoc1DwiUrnUcoKk605gJP8MdHJHIWy+wH2tgP474o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxDniNk9JZDTBIyaAu2ezjBLnglSRHnyrFoVrwOwgsLC7zLc2wQzQ9ZEF+lX131x3
	 +BPmtrD2X3zZDG450mLhVXKMhXQ7CxpJjdSS83KxgGo0hu0XbSMiOJgHwGMqHegj4g
	 9YLbiBMD48RMMXQBVSJCNME3mNHaDg7pqcECeaVj7DlHiQ6pcs+PRAGboMlOruEXRE
	 pFB415D6xdqmVcr6MAS8EV/BPBc6XmB3ilUF1ClusdiR9SWXmpD0p3yWHe5tDQBIy/
	 fBe4Z2GgYO94nZmM15ndXGxvNTLThBqJ3idW+Keucs4olLGc+6hAcrOd/ek0hHxjml
	 3lioDmmD98Zow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@seco.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 134/148] usb: phy: generic: Get the vbus supply
Date: Sun, 24 Mar 2024 19:49:58 -0400
Message-ID: <20240324235012.1356413-135-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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


