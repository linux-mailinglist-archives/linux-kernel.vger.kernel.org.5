Return-Path: <linux-kernel+bounces-114938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EE38892AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDACF29DFCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EC61BE808;
	Mon, 25 Mar 2024 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhRygCRK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E033178CF4;
	Sun, 24 Mar 2024 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323688; cv=none; b=f5p8n3LUB9TeqE9tCKTsIzfDW7wAWsia6zFFnCqdpgDEUb0uR4EqSf0CKHh/Me4mKbLqJu1qv06Z9+z3nR9JUmRxbu/PKcR+MUVJX8VsSdYlwtjy0v2WdUMPFACLudaP6+ekbRqhY0RbyU9v5RcuDS+VTYA4yX48thN4YHnDI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323688; c=relaxed/simple;
	bh=eTI9IOKkvtOB8T26gH1qSqbthfn8ohH424sihv1I7Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcMKKnz0FSJEcpihT9j9U5qtVUDkJDVQGJyyOIMJ2y6V47Ci9YEqyeNARDsmQ1Lp2kv8g8bD92IvcXwC/r9+Mzm7kzMnP/sT8eeooFG7+DJ79KNZ9upfYmvlywvrNht6Azni/CciFJaXP/NYIgdFbLb5UBWYwFI239ufHWSK/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhRygCRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8B0C43394;
	Sun, 24 Mar 2024 23:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323687;
	bh=eTI9IOKkvtOB8T26gH1qSqbthfn8ohH424sihv1I7Fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhRygCRK7TsEPYYVv2fNrSNSB7ceVC/9F96IwLvB9t3HsBbrGm+kLUf2Bdb0NXkEq
	 ByTdXwDbW0fyhNFxdWgj9IRh0+20k9SjxF/mlNW4jjVYjaiVsWrxi+pxThEevzLfXu
	 Q3vVfBixKxbG4snzstZgvjgSW6Zens8mcjAB8rW0MIEsbyirZ2KoRP2ZwjLap7p84Z
	 +pAuW3NVa4eDZUWvP9yZa5KaU26MwjUp5ZV5CeoPigtQ/9cvw0QJ+mJd8Sddir0uOZ
	 ahgpDz8CoESRzcI7C9ddWpxsbyrmJLa/sFuhf1hAxih/mzS3sHbKVjc8uo4GA0ZD0v
	 2FGQVj4ydNlEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 059/238] wifi: libertas: fix some memleaks in lbs_allocate_cmd_buffer()
Date: Sun, 24 Mar 2024 19:37:27 -0400
Message-ID: <20240324234027.1354210-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index a4d9dd73b2588..db9a852fa58a3 100644
--- a/drivers/net/wireless/marvell/libertas/cmd.c
+++ b/drivers/net/wireless/marvell/libertas/cmd.c
@@ -1133,7 +1133,7 @@ int lbs_allocate_cmd_buffer(struct lbs_private *priv)
 		if (!cmdarray[i].cmdbuf) {
 			lbs_deb_host("ALLOC_CMD_BUF: ptempvirtualaddr is NULL\n");
 			ret = -1;
-			goto done;
+			goto free_cmd_array;
 		}
 	}
 
@@ -1141,8 +1141,17 @@ int lbs_allocate_cmd_buffer(struct lbs_private *priv)
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


