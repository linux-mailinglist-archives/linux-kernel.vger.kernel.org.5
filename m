Return-Path: <linux-kernel+bounces-116317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 457E58895EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A04299468
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2625E07E;
	Mon, 25 Mar 2024 03:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMQHYtHA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B5183BB0;
	Sun, 24 Mar 2024 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324260; cv=none; b=IGPLTGArB1IUIcDhuhF8p6c7Fq7312em9aaTH5QaCrfbrTmdNLgBkdMnt5CgETtHdyXPTXiyx6zWBlyLxV0QB48WKUGD+4X1bkWeYO9ekz/nMONG+XWTVpNLiHybG+kwUOEwMvI5CTKwglYNKUW1YW8nrowKu/qj9NbYY+TLtjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324260; c=relaxed/simple;
	bh=QjY6aZN1hS5n+MvNAri57QJpxl0NRj7LaNQvjtQ+YUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KywZkPvvmSU7ChQVsOWCyckUXH98sawdVNqfvt44EM9F5ik/iyi2CagadmPIB9XSrisxueZXyNIaWoja5VHdOU0Qwabeups663tVaA6fY3Vmfu6AaGUgs6D2UMZuZ525tDkOzCDmJL0AyasW/2EABrahC/RPUXgANb+OBxXb1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMQHYtHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F3AC433B1;
	Sun, 24 Mar 2024 23:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324260;
	bh=QjY6aZN1hS5n+MvNAri57QJpxl0NRj7LaNQvjtQ+YUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMQHYtHAI7dYa+fGdRvArYO03MWgFzDpKy+uWRVXrW+BoaxYy+729BcvGYqcNmERI
	 mcqr0qeKqrIEqzQDgSohKZugHrF3lfiY/p1m+qW7fWIBVUlzhI/sV3qIKcrOku1l6s
	 zK0dMXZJCzmIJ8wNCS0prB6mTWVODtfkCmzVKngg4aZLi9PVL/6phvSD/Z4buO6XM7
	 ZvpIumV8teBQB9DEX5Tcw/IbkvlNLhBYSgcBUCX23prxwGHPzcdjiMU2+N1JvYwis0
	 brT7DEN9lTnX4/M8H5tBGplOAVe+6oHWaCxb5yeLUtkVMwXgWt3OjVDU1IbGoMIv28
	 52h1OySjkuJJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 040/148] wifi: libertas: fix some memleaks in lbs_allocate_cmd_buffer()
Date: Sun, 24 Mar 2024 19:48:24 -0400
Message-ID: <20240324235012.1356413-41-sashal@kernel.org>
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

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit 5f0e4aede01cb01fa633171f0533affd25328c3a ]

In the for statement of lbs_allocate_cmd_buffer(), if the allocation of
cmdarray[i].cmdbuf fails, both cmdarray and cmdarray[i].cmdbuf needs to
be freed. Otherwise, there will be memleaks in lbs_allocate_cmd_buffer().

Fixes: 876c9d3aeb98 ("[PATCH] Marvell Libertas 8388 802.11b/g USB driver")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240126075336.2825608-1-alexious@zju.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/libertas/cmd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/cmd.c b/drivers/net/wireless/marvell/libertas/cmd.c
index c1f4229187378..d1984f03fdfca 100644
--- a/drivers/net/wireless/marvell/libertas/cmd.c
+++ b/drivers/net/wireless/marvell/libertas/cmd.c
@@ -1132,7 +1132,7 @@ int lbs_allocate_cmd_buffer(struct lbs_private *priv)
 		if (!cmdarray[i].cmdbuf) {
 			lbs_deb_host("ALLOC_CMD_BUF: ptempvirtualaddr is NULL\n");
 			ret = -1;
-			goto done;
+			goto free_cmd_array;
 		}
 	}
 
@@ -1140,8 +1140,17 @@ int lbs_allocate_cmd_buffer(struct lbs_private *priv)
 		init_waitqueue_head(&cmdarray[i].cmdwait_q);
 		lbs_cleanup_and_insert_cmd(priv, &cmdarray[i]);
 	}
-	ret = 0;
+	return 0;
 
+free_cmd_array:
+	for (i = 0; i < LBS_NUM_CMD_BUFFERS; i++) {
+		if (cmdarray[i].cmdbuf) {
+			kfree(cmdarray[i].cmdbuf);
+			cmdarray[i].cmdbuf = NULL;
+		}
+	}
+	kfree(priv->cmd_array);
+	priv->cmd_array = NULL;
 done:
 	return ret;
 }
-- 
2.43.0


