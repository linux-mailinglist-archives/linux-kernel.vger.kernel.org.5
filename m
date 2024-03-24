Return-Path: <linux-kernel+bounces-115798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7908897FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0949529D76E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5CB15887A;
	Mon, 25 Mar 2024 03:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDHCLKzN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4A535C9;
	Sun, 24 Mar 2024 23:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322053; cv=none; b=Re/UeIcolsVm76BanwpNJTaASiMCKrkznYgSit69e1iymKoNsIKyOrcZRQUefF5/d+iSspK5f6tkGUVlr8wV2vrPa1bdjtSWiqV0eIwSshRlKX2UZ4/PWUtSzTfg6v2MKM1XGuVu/RDloiYRtwoC71Hd+xqTFfvpTrQeCxHOPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322053; c=relaxed/simple;
	bh=RQrolhc/4neGjp94YqluMsQFQZd5V1OjoECo2SmYWsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1PGlt5e8Rs7yACtYba1hz9llABqXqfahtH/587aEJ42LC+NS+qZoJ3xE2P/ri9d94AhbGLot2/M2T/Yso92mIoO1sgyj//AEYU8yYZr1NrrxL17TBOozJyOFLprXihbd4ryj6qUTh/X5QZuDX1PwJbJdtS4jWDCn0eIjeB7Iu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDHCLKzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AA6C433C7;
	Sun, 24 Mar 2024 23:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322053;
	bh=RQrolhc/4neGjp94YqluMsQFQZd5V1OjoECo2SmYWsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PDHCLKzNam0XTkhdRL1OAp+DHraP3kaFOLqUggHrUB5Rp5nuaK6w2wDf8dnHHGT3p
	 jY/oSEZYlKK8MLaozjSnvq9/QcmQqaUqLZTYE7LADDQQiVqEuFKgJFmENdqHc5lHYt
	 sXHgvHSnlcZbIe6CI9cYgHrDUnmfdIp9pZEMxJVTwhrYnOCKqGYKXZX9i+oQXo9KrI
	 MRmbc5GwIgtHidTBB70eBLGd0TS39Jh4VUnVrS4ln5VqBlu6szWFrsA+BMZ9FNQM/x
	 D/oVKEw5uHzsLSkRGtNZzS/EHJiGtk2eSzORT5Lr16MRxl4PPtGvitmkTUdhXxdIgJ
	 BBp4ZNFNdyJ1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 126/451] wifi: libertas: fix some memleaks in lbs_allocate_cmd_buffer()
Date: Sun, 24 Mar 2024 19:06:42 -0400
Message-ID: <20240324231207.1351418-127-sashal@kernel.org>
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


