Return-Path: <linux-kernel+bounces-114242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B7E888956
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D861A1C27D37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2610815AAA2;
	Sun, 24 Mar 2024 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqkLk4vg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB015217C;
	Sun, 24 Mar 2024 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321595; cv=none; b=UM/WiVX0TtGh9yRFDgdw6Pj437MV6cs6AD0SdlpTP/Ld4jhYhEbEW+QJo0DS9PGjHz8+rDbMAV6nJOvjMrFMC+dKA8dDXE1qloxdnigaFA+izMZP7RgBJRWlDWd6B4emBmdiyn/JwcRdx9Psi5z/yjlRaJQOc/u7TctECg/9Ytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321595; c=relaxed/simple;
	bh=i8GOse0XXSOTUuw/dmIRAVxphC44VuT3GLlF3HCDOdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3gS/evJIfZnASY6TOvugSqNaT15ot5fso7p2nSnc909e/iI9tcW6X9upqvVJTfCyFoJadhBWg54gmGJMpIRz6gCjE/assUAEdIuqbNpoafNRYBt/GBwrEU5FFKNvGjdJZKHXT4yMyvk5ZlTI5m/ojlx6Hug1MH19GoxwbxQtGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqkLk4vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC6BC43399;
	Sun, 24 Mar 2024 23:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321595;
	bh=i8GOse0XXSOTUuw/dmIRAVxphC44VuT3GLlF3HCDOdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oqkLk4vg4QFWPVdT7CK14fM7jQu39Y7b6axFWsC56WhMEgXj/e3vmGgZgr2tukJoQ
	 O/uxtZHcLg4FnwKdDqCEaNOK7F9O8Moo3VkB9sN3QGTMBQ0FM+92HJZNDfBt2BDefN
	 fsztcGAzskMR/y6ytbPqt0wWGHETaCkAungFLXkaUICiKCaS0WpJbg02fLnapoh2M0
	 fJbUnmykiK0B9IRAtguUbUiAZyPJyo8o1rDwg+MLztTHyyVfDLSTr200memh89MKiI
	 u4a3aPsKKXwsUaIOPRJBobtkt9lSKXs5IwxKusMGwjnqFJRK8ug96KvRubbXTZ42VB
	 no80d69UHyj6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jie Wang <wangjie125@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 325/638] net: hns3: fix port duplex configure error in IMP reset
Date: Sun, 24 Mar 2024 18:56:02 -0400
Message-ID: <20240324230116.1348576-326-sashal@kernel.org>
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

From: Jie Wang <wangjie125@huawei.com>

[ Upstream commit 11d80f79dd9f871a52feba4bf24b5ac39f448eb7 ]

Currently, the mac port is fixed to configured as full dplex mode in
hclge_mac_init() when driver initialization or reset restore. Users may
change the mode to half duplex with ethtool,  so it may cause the user
configuration dropped after reset.

To fix it, don't change the duplex mode when resetting.

Fixes: 2d03eacc0b7e ("net: hns3: Only update mac configuation when necessary")
Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a61d9fd732b96..f1ca2cda2961e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2892,7 +2892,10 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 	int ret;
 
 	hdev->support_sfp_query = true;
-	hdev->hw.mac.duplex = HCLGE_MAC_FULL;
+
+	if (!test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		hdev->hw.mac.duplex = HCLGE_MAC_FULL;
+
 	ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.speed,
 					 hdev->hw.mac.duplex, hdev->hw.mac.lane_num);
 	if (ret)
-- 
2.43.0


