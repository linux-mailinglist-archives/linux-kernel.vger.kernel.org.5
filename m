Return-Path: <linux-kernel+bounces-113791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BFA88869F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2536B1F250EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3C712F392;
	Sun, 24 Mar 2024 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOkHQqq4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118EE128387;
	Sun, 24 Mar 2024 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320807; cv=none; b=D7SzlXZZnIVTdFmUR+o+7te1o1uzk3V3Ts9zWFL0gECLeZRmIg6thMxVS3+WC7SDHdombUizPD4s3VBJODMPnbpfASysKUOmWWEBVCi9/T2ineDHN8XVZOj5bxR8hZCqt9XH8av0Npzg2sS0qDuD3mCtVVSB3b+bigzv59zJph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320807; c=relaxed/simple;
	bh=vP825Ku2Y5fpQtvsySFA7Z6w4KP+omheovnqVtB+F0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOWUv6niJnwPUmwVp6ZMr6FKJ6e08pAfVWa97jNID7hdXgrFC3TE2ZVP6DYvM+JUDBq6gvqnZghlFfWsNyXJOKwOKZGxtccUeyZSuzTnem0lIGjVfrAVH5AJZ8FX3dDB0X/QEN/Dae79I8nHkmKQEVWxEyTkvpSc4jiPom/v8pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOkHQqq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EB4C433F1;
	Sun, 24 Mar 2024 22:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320805;
	bh=vP825Ku2Y5fpQtvsySFA7Z6w4KP+omheovnqVtB+F0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aOkHQqq43/VKJKvJ/yDp5mXXOjSblQKx5PND+3hpWDWkxxN0IDfVqbGeozV9Zfm++
	 v2dVEhRG9kmUS/TCXQ/gH8JV/6mAM0ZdKPLTvnghacjAhUqdoCmdhLW0KHyUkFDPc5
	 bDk1lT4Ywixz31QEF3+DB7f0deqvYagOxjauYUauo0a5LDFpWbACSbebq2FRhRKgU8
	 BG7SyCNKW09wCegHE4uVkAhLRoAUSY8+Iol84QdLghFhMBhyGSOCWRtSahdHgh1KU+
	 WNJ1OXtSPJT0mqeumFzt/HVXk9eBnROi4269jsWFgVS6B8xwNcfAdCFogFFOIRrEqa
	 RdJGzx+qOySiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jijie Shao <shaojijie@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 370/713] net: hns3: fix wrong judgment condition issue
Date: Sun, 24 Mar 2024 18:41:36 -0400
Message-ID: <20240324224720.1345309-371-sashal@kernel.org>
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


