Return-Path: <linux-kernel+bounces-114595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C035888B35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791A61C28661
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8779429E1CC;
	Sun, 24 Mar 2024 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg2pV+mw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44E2319CD;
	Sun, 24 Mar 2024 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322246; cv=none; b=swUY03k4z2rY308uHLEaGJ+vWM044yODWxLYSRjuJ+m43qjO8D6jADgZAIGcWgSXJ9c5yTTO0L9ipZwyfDCyMXgT6J9oHZZuc1/JM9G4FEAUL6Ce9+Peqm0VhNNWdR9LeR6GK7id8xwwaTrTpHpka/LTTGDpCBqZG88OJvosN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322246; c=relaxed/simple;
	bh=TLyEqfyntQ6dgjomKdKwyWv+EdNOs2VIapsu7gTdO5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkSH51qBD/71EMBxCfXHlCuB/R2+GG16RoWeDWlAsFp00SBoUkoKMXBXNVuWnLWHzsfv+TU3mCiP96vZe1qxmO14WhWrDQQlzFtsamTkO07Vbmv1YTKCITmzL5e2bMbBOIzLWCeAZNI+VMvlRE1dXQoTM1f7U9YoOqU5KkdE/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg2pV+mw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2A9C433F1;
	Sun, 24 Mar 2024 23:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322244;
	bh=TLyEqfyntQ6dgjomKdKwyWv+EdNOs2VIapsu7gTdO5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cg2pV+mwHqErjhVj2MhnLPK659KywRrX+Dgo5h8x7vci/LnJP29z8Ys/04G549Ec6
	 P9kaqt719NljTpWGRlDqMomdJ/p7zGmye7cDJCkUqrm4KRTnSXdER+K+XcOKwkKbud
	 Fpit/s9BhlN+TnV0jz5AhKGbbsTeaIdKp7gNqRnrzr52kgNZ53f77w07IPpxDCOm6w
	 gMzJMGeQRSG5zMjdXqlA44+5ZuMRWwdUIOupFT2CW62xFOz3XItPptVgVctce2IVhq
	 pwXQ1wbkBWQyQQqBgerj/8r7P+bqOkYYefSsN3F+1JLWFhzsnOBDMapEhpV4LembQM
	 bn4RiyxZgyieg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 326/451] media: go7007: fix a memleak in go7007_load_encoder
Date: Sun, 24 Mar 2024 19:10:02 -0400
Message-ID: <20240324231207.1351418-327-sashal@kernel.org>
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


