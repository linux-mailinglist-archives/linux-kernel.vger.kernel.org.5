Return-Path: <linux-kernel+bounces-113034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073BE8880F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19301F2364B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C7713B7AC;
	Sun, 24 Mar 2024 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa9nLK38"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3E13B789;
	Sun, 24 Mar 2024 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319844; cv=none; b=GFLgRTzPg3NORZXmpWW8xlz6BE4SLwZzYgAx7Ku13XwW17YdBjJDvTTlgYE/+fe4ChK2vLNQTWngFN7uW03iBIgYf7Y7u9xr2RnOLbZE5OBCR64KxHw6ZAcGpZoKlYLLCSdUthHvsIjkotNATCwLdBGvdn1VdkEmMEDO242noo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319844; c=relaxed/simple;
	bh=RQrolhc/4neGjp94YqluMsQFQZd5V1OjoECo2SmYWsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhZRJhFclxVlr+IcdsP1qAEYmfN44y6YPuYYYKyt78HNr/QvgGQvGkqbOSp46O1w1cFlSHc00ryXe0070vF7sV8XhEsvzZDzCXejEMhiw2nS5zK6bNK98XKn92/vMIe7lfUNtJM2BjBdigqp0ntq34TtuM4I1oGCt05TOJ7XQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa9nLK38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A0AC43399;
	Sun, 24 Mar 2024 22:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319844;
	bh=RQrolhc/4neGjp94YqluMsQFQZd5V1OjoECo2SmYWsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oa9nLK38Zy6K6uNyruhiS1s6AozBrf2ryei3juou4B+vNfJ1Ut9DQJX+14rAjHi4/
	 p1QUTKrrT+udefM6G3IYgBAqTeGuTUkt7uv1Brb5t+fjaZlbBU8fss5m/mvXN3sP6K
	 dC8X71TcW9YO8cgJBF3nmr3/HQRDXkDVRrGiv+bDU2OuhuZPKDFKy3/liQrkNZ/cYJ
	 yraEwaAYJKJ9pADpIGYL6wU9jz+Kpi/86cOVyfMAfRmQNdOOJjwHudcjHOxrLAst5x
	 Oe9OJXbR1uJHWk5+8BuAlfdbLJ+DsS57VSOrWhdSbKxPgmIZrOUgX74Zj+gvu7UeUC
	 lnh9FXdQQr7/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 147/715] wifi: libertas: fix some memleaks in lbs_allocate_cmd_buffer()
Date: Sun, 24 Mar 2024 18:25:26 -0400
Message-ID: <20240324223455.1342824-148-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


