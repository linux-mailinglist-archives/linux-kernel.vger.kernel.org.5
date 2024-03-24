Return-Path: <linux-kernel+bounces-115208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57829889355
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896F71C2E644
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3B330DCD6;
	Mon, 25 Mar 2024 01:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ9qgCw8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287F2944B6;
	Sun, 24 Mar 2024 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324287; cv=none; b=h/QZIHp5mVEiwsiO4j1s7z1uNeTpuldCS0b+pHx2FnOHPO+sIH3NMepZF6S1kyD4SvvDkFKMOi5NmurCDOX3OxOoajx3Y+V6p+VlJv7O3SZxfHrUa2Z3xQLUKFSzvmSEgS3rpN3pts4AQy9H4rsyA9B9QmzDWitd1G52uiDFqs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324287; c=relaxed/simple;
	bh=FaKGe9dFoSMlkOYS7BvtaFwqewWRRVHkf5kCa79y7HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDgMh2o5NPsHS0kde8/c2gy5xbOnv8WdakEAvdXCQqfXis1iMLWfGumVnJIHD+VxaA33HsrMrGRhdDxdy+XLQ1JRXjXcfcshXCaDPq0l0Cz8+ijPC7bEn4HVfN1yxZT0eCiyShPjst5+FbtfmGfORwNFTh/e1eqd72k/chaFTx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJ9qgCw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07E2C433C7;
	Sun, 24 Mar 2024 23:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324287;
	bh=FaKGe9dFoSMlkOYS7BvtaFwqewWRRVHkf5kCa79y7HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJ9qgCw8W2F6RUJbfcsC2YOohzv53IaSmLfO3dQ/pxIAv2bc0BhYhbizIgi4crN4h
	 JZNWjeD8ItqvTAFUa4ez/x2XyPDKQdGXz72CWRvP1H0FOaig9zdxWAYUmFUbtDuB/Q
	 k507i7kWUkAosubrNCP8fniQhkMcUJWzPLbhAcQiEVqU9vN5+BEc9SQEWPnnQbgJl1
	 6clpw7Hoik9F2lfWPvvAsnctpFMuvxgVk+jAhyFGOPx9PCGQJ6uSMzL8fivdsJJHLg
	 3+WbYHtqWgLNzv6P36NNgcElq+pNptAMGi2HkYLOLnLNHDQL1oGafaGE9PV3IufqG4
	 IWFvt5aY4Wx+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/148] nfp: flower: handle acti_netdevs allocation failure
Date: Sun, 24 Mar 2024 19:48:47 -0400
Message-ID: <20240324235012.1356413-64-sashal@kernel.org>
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

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 84e95149bd341705f0eca6a7fcb955c548805002 ]

The kmalloc_array() in nfp_fl_lag_do_work() will return null, if
the physical memory has run out. As a result, if we dereference
the acti_netdevs, the null pointer dereference bugs will happen.

This patch adds a check to judge whether allocation failure occurs.
If it happens, the delayed work will be rescheduled and try again.

Fixes: bb9a8d031140 ("nfp: flower: monitor and offload LAG groups")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Reviewed-by: Louis Peens <louis.peens@corigine.com>
Link: https://lore.kernel.org/r/20240308142540.9674-1-duoming@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/flower/lag_conf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
index bf10598f66ae0..1b5e0cef97713 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
@@ -336,6 +336,11 @@ static void nfp_fl_lag_do_work(struct work_struct *work)
 
 		acti_netdevs = kmalloc_array(entry->slave_cnt,
 					     sizeof(*acti_netdevs), GFP_KERNEL);
+		if (!acti_netdevs) {
+			schedule_delayed_work(&lag->work,
+					      NFP_FL_LAG_DELAY);
+			continue;
+		}
 
 		/* Include sanity check in the loop. It may be that a bond has
 		 * changed between processing the last notification and the
-- 
2.43.0


