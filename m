Return-Path: <linux-kernel+bounces-114511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C37C889037
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDB01C2BE43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E9C181B8D;
	Sun, 24 Mar 2024 23:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atAkYU6m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C854229D67;
	Sun, 24 Mar 2024 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322141; cv=none; b=ARzosdFFB2OZ7Drfb3FxvS6ULlgu1HGFq1GIozfCGHX1Y2jRM96cehFayobiqFWbAqZ8lGpCgDx4aLaw2MYq6GdkILB2Xps3k4gwcQ+KcEHwtLcaqNs2pZ6+8GcWObv7UD27FY7DfBCaCA88LSf+sf9WVcxnL+yjjbIBLIbPrk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322141; c=relaxed/simple;
	bh=vP825Ku2Y5fpQtvsySFA7Z6w4KP+omheovnqVtB+F0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWQturihNrEpErU0rd1rGD3ymqfmqYh995VLolViqdNNRAxI/+smOyxJ3WWnbluCd4FwFutRV0Gd8XFd+CSoZ5C1okoFU8CioN8qcts/uiHbVwEOeFCq0NroQrx7Ey2nP67d6nbUcimxI0ay6+BbxJtY7GknzWKUi/hIHCoaG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atAkYU6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284B9C433F1;
	Sun, 24 Mar 2024 23:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322139;
	bh=vP825Ku2Y5fpQtvsySFA7Z6w4KP+omheovnqVtB+F0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atAkYU6mJ07Ql7Ec053X/2OqNgPLB10nAv6OuRu6PWUp61ZarEX1pFp/NxjWDqJ0p
	 Oa360ipJtKldcgKosj+zyDVcQmjE/ML0vHhgeeBmrfSjjiTtC5cHp+S9XGOWmESoP0
	 a9VFQS5/1ZQudQIdh26APMI74hSi64TDEsjEG3dIYMXWazBPO/QtOtsyWTfyeRppWs
	 Xa9PHF+aOvmhTF5g4r7WG87EsgWyneepiyXYL7gB+ivdMgFvr6WB6PK2mFF4SnojxG
	 rEHm5VZ8vKUG4dfnGe7TdCUpIJoKgGMniRD0yK6eKDhS2Q4MAlFNivO2gOPRKYWerY
	 M6WN19zEOjnUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jijie Shao <shaojijie@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 216/451] net: hns3: fix wrong judgment condition issue
Date: Sun, 24 Mar 2024 19:08:12 -0400
Message-ID: <20240324231207.1351418-217-sashal@kernel.org>
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

From: Jijie Shao <shaojijie@huawei.com>

[ Upstream commit 07a1d6dc90baedcf5d713e2b003b9e387130ee30 ]

In hns3_dcbnl_ieee_delapp, should check ieee_delapp not ieee_setapp.
This path fix the wrong judgment.

Fixes: 0ba22bcb222d ("net: hns3: add support config dscp map to tc")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c b/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
index 3b6dbf158b98d..f72dc0cee30e5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
@@ -76,7 +76,7 @@ static int hns3_dcbnl_ieee_delapp(struct net_device *ndev, struct dcb_app *app)
 	if (hns3_nic_resetting(ndev))
 		return -EBUSY;
 
-	if (h->kinfo.dcb_ops->ieee_setapp)
+	if (h->kinfo.dcb_ops->ieee_delapp)
 		return h->kinfo.dcb_ops->ieee_delapp(h, app);
 
 	return -EOPNOTSUPP;
-- 
2.43.0


