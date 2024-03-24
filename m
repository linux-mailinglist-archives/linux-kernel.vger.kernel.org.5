Return-Path: <linux-kernel+bounces-115379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191F58896CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7B31C30693
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4035D1F73A1;
	Mon, 25 Mar 2024 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LONUrSd7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D843F1D8BBC;
	Sun, 24 Mar 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320645; cv=none; b=p+X2suZhtOP/UbAIV6YJO4WWGde6Vo3jtHopg3D3quypwoajsyUgsLgHkuJlE1cyU7krOgBZxlnqVZwrHoXMWO+1WQJJhVOVFZ2U3EtX9UgoC+M/zqltRUl/XM5Ekh8nATbohEyCFak5FddVmky1EpMmzyx8oA7EoK/PKf//iqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320645; c=relaxed/simple;
	bh=RQrolhc/4neGjp94YqluMsQFQZd5V1OjoECo2SmYWsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gmjz5YCoywLd1/jFDnqJvtUDbk0Pd5JXB5c+3r+AxTlIw/u86aLjqBpgW1tZgLiOXE+dh6XHRi331CZ524HpV3g1jbYl/ictimJPqnLCaNQ/ItYF0BJZEptUkjPAsm2SPSKfXWVOuhLU+wXAVv21W23FlVSaZ+yTbqN+BU+BAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LONUrSd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23034C433C7;
	Sun, 24 Mar 2024 22:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320644;
	bh=RQrolhc/4neGjp94YqluMsQFQZd5V1OjoECo2SmYWsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LONUrSd7d6pPoqBDP/ig0MCnFCnPvu8hBf9jWMFzWHkn4FbhmxQqSgp6AhI/HS7Pr
	 CgDGUiAYvk/qlsVv5Ry2L6hLXQuGpey/a25dv3vfMexjY9jBtRhYJGLBKBA1AADfVX
	 t8zmNeHaoZ7A1gHbyyqtATCe+RxuYFxCdMXwgtLAccg2X3wMVOVLIe3KMKMkbJINF3
	 visNqmXLFlVGjgVPwaNzx5W1qsl1HT7yIBUOZeqPqeA96PHDMuVnKOm5Vu7rHSTy5t
	 b7ZdOnSi7FqL/HgufA+X7+i7mPoQWr8kjh4PEdlayO2yiYOdfu0IOrTMeBdaqOwG3o
	 1yCQUIY62Amag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 206/713] wifi: libertas: fix some memleaks in lbs_allocate_cmd_buffer()
Date: Sun, 24 Mar 2024 18:38:52 -0400
Message-ID: <20240324224720.1345309-207-sashal@kernel.org>
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
index 104d2b6dc9af6..5a525da434c28 100644
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


