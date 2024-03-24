Return-Path: <linux-kernel+bounces-114350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF5B888FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337A0B2EA03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B6F26B82C;
	Sun, 24 Mar 2024 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WI6XOu9b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A021413D;
	Sun, 24 Mar 2024 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321737; cv=none; b=gU3oXHFfKw9DCgQB1lcjNtdbnDIOaxnQi46IuqbVPl8kIUQnh+KR1MMDuzGHWRBGYBV7IRY9cftDYf2ldiJ2VrYC8Q4xQYE4jFA2n3dmgHGIAzjtIfgqCGr/Xet5a8jfDJhn7Yah6KahX99wxMCN1XtoRnq/2jDA4I7JiOQyxnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321737; c=relaxed/simple;
	bh=TLyEqfyntQ6dgjomKdKwyWv+EdNOs2VIapsu7gTdO5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3L6HNCRRBwr2FpX353QLwrrXuHX0i+k6dOAt+v0YS07SYXWW3YxK+McmmqfXMArg5SXjVHudrWJhXa4PXwsOxR/AiFEWsxbHjTfFTkyt4H5Wcs6qVJJe1Odbx5a6H+tDc7M6mPhuDrYJVbo6U6rx72HMeECRdvH/6phbXyj86c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WI6XOu9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6E4C43399;
	Sun, 24 Mar 2024 23:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321736;
	bh=TLyEqfyntQ6dgjomKdKwyWv+EdNOs2VIapsu7gTdO5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WI6XOu9bzLb0GHcmGXPA5dkpImKZ3Da8E2St0sOgFcCbtPppjzyPLMdtuRZcXJMTq
	 98PUVZymOVZcdkn4YT6tS6EJhILm7JyMqjmmNvjnKY49NxPB6TpQx20IsCEGdJ4bbU
	 veR5fkBSiYMPZri20gCO1v0dK0TeKDYIpZ1ztAOBqS1Kr6vKRrJLOUsU+5HlYOWUzw
	 HfxCVCoK0bXtkHwr9wJWPy6lRT7vxDcx/gBHu3mQ2WmSwzmlV1C9yfAPRwBNZVV7yW
	 lQS+gE7HhGEHIA1sPCKwBlbWA8xRTOEq6H+YLHpV3eDoR5koaZjBBZSdR5/mVOH7hJ
	 hV10Ym1H0iH7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 464/638] media: go7007: fix a memleak in go7007_load_encoder
Date: Sun, 24 Mar 2024 18:58:21 -0400
Message-ID: <20240324230116.1348576-465-sashal@kernel.org>
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

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit b9b683844b01d171a72b9c0419a2d760d946ee12 ]

In go7007_load_encoder, bounce(i.e. go->boot_fw), is allocated without
a deallocation thereafter. After the following call chain:

saa7134_go7007_init
  |-> go7007_boot_encoder
        |-> go7007_load_encoder
  |-> kfree(go)

go is freed and thus bounce is leaked.

Fixes: 95ef39403f89 ("[media] go7007: remember boot firmware")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/go7007/go7007-driver.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/go7007/go7007-driver.c b/drivers/media/usb/go7007/go7007-driver.c
index 0c24e29843048..eb03f98b2ef11 100644
--- a/drivers/media/usb/go7007/go7007-driver.c
+++ b/drivers/media/usb/go7007/go7007-driver.c
@@ -80,7 +80,7 @@ static int go7007_load_encoder(struct go7007 *go)
 	const struct firmware *fw_entry;
 	char fw_name[] = "go7007/go7007fw.bin";
 	void *bounce;
-	int fw_len, rv = 0;
+	int fw_len;
 	u16 intr_val, intr_data;
 
 	if (go->boot_fw == NULL) {
@@ -109,9 +109,11 @@ static int go7007_load_encoder(struct go7007 *go)
 	    go7007_read_interrupt(go, &intr_val, &intr_data) < 0 ||
 			(intr_val & ~0x1) != 0x5a5a) {
 		v4l2_err(go, "error transferring firmware\n");
-		rv = -1;
+		kfree(go->boot_fw);
+		go->boot_fw = NULL;
+		return -1;
 	}
-	return rv;
+	return 0;
 }
 
 MODULE_FIRMWARE("go7007/go7007fw.bin");
-- 
2.43.0


