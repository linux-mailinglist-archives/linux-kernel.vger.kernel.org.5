Return-Path: <linux-kernel+bounces-114241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED57888955
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A911F2F352
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500D715AAA1;
	Sun, 24 Mar 2024 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUvdypTT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF74152174;
	Sun, 24 Mar 2024 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321594; cv=none; b=EuX9PhdkplbY4LdBiF4xUH5rHBglrc439HpxvtYju3gaQFmFUxJ2pD/Xb0V/nqm9dX9NtIYwWnV0P9ue6i7xrTTzZ67tKaycv/XMTyUnRYVOp5OOPEjuf8mc4oVp90f/y9rGCgyvc6o5bnZQzSAEX1I4cZUeU/de3y+HfEtDWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321594; c=relaxed/simple;
	bh=vP825Ku2Y5fpQtvsySFA7Z6w4KP+omheovnqVtB+F0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qz8n/ONco6Sjw/nx3Ie3P/YD9Dj95Ozd7bmzecZgNLw7tEzhv5qcQt/u+uiST/RxahsBvA/ZEY81CLaFN3Wu1hIeF7lLbqroBjODc9EJ1kMq1YHpnhQgaYSUxKtkAdwIeU8gvmeBhAjbbfLA5t1U383yITuvuqxIj55zrUyppYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUvdypTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FBBC433C7;
	Sun, 24 Mar 2024 23:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321593;
	bh=vP825Ku2Y5fpQtvsySFA7Z6w4KP+omheovnqVtB+F0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FUvdypTTnGVuLO8XjDjMoaJpXkeZbxhJYFsHBkW+ndMtwsU+9Lxd6r9kRDUmZHKRe
	 OY0HKfVqowx3xHF8euaNGAMlx5J6j8tUX4YbLlUVJiV/9Yj0DpypFvyNWf28a1ZzXu
	 P83DFAYgqi0NOQJK24+BHHXXxN76qqhgxCPpNwAyv0fr1dRSZrBjGaZkcZJKAhGImA
	 Du/QkQ5cmuZ1d3Vp/aoE7KV3rm320LZ+hNfqhA8bvaCDimoWSYWx7KebzulWGf3Cxy
	 DlZ8RN4E9bRmYmKLMyVUPOxittBgF+6paRCBipai5MTRlpiEeogiG3z7aN5X1Pen+8
	 qofNgsi73ykxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jijie Shao <shaojijie@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 323/638] net: hns3: fix wrong judgment condition issue
Date: Sun, 24 Mar 2024 18:56:00 -0400
Message-ID: <20240324230116.1348576-324-sashal@kernel.org>
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


