Return-Path: <linux-kernel+bounces-114861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961368891D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BD31C2D6F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B437C2C8AF6;
	Mon, 25 Mar 2024 00:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbF10tF1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D827BBDB;
	Sun, 24 Mar 2024 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323526; cv=none; b=oIpevjogb2Qw+peaIUDEZ5vsoBVL1jsmd5Z0IcPLlq4V659SddthjKXOUYC5PdW9r+uHs2IEiOQ8oWJ7ZWQ0Xzx4b5wXqqdT6vE1MYvHh3B4vjw9fT6XD7YJtTlDADlsGa43DjUJhrsUNJft/N0ov2QnPMEua8aJQtn/CrgomKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323526; c=relaxed/simple;
	bh=X1cmmr4RfhomyDJsZCk6Jfrkx98hI1Q3e6kuxotVY7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPHf3qFluI4WuNuk6N4IWA0xBKhVeppjXeRvf7/mMG0ovXw3lOGAWG2kjicAeKSOhTIzWbkSdaVlxdLvgrLxobMToUL0Yvy3uuqHQ6HDPh6uIu/q/yAO8UNi9B3SJqNWDPcF5eNxfbV5CTc4OPPy96QX5BeTcPKyXJtiTIy2qZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbF10tF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEEBC433C7;
	Sun, 24 Mar 2024 23:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323525;
	bh=X1cmmr4RfhomyDJsZCk6Jfrkx98hI1Q3e6kuxotVY7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbF10tF13pYxSMgdw+p7VsCl8GW1pgyzn0/rdY3WuyvcvB/BfGur9m2ndqmMjvzCM
	 UVkjpNxl+Yh/BqLxKNprDXDSaPmxzh7JnSBZZXut9a9isJGUGMr/VZua/v9m/OiUfH
	 ZuMcwi9cu9JXglDCPRqhbJLKxCxA7fLZfAXBee/UtryxjlhtUegAMZlZg++qs4i8h5
	 /F+BwrVot0MTbTtupfGMF7n+cAwp+s4iLvIFQum/pYUn5cQmNO6C3XWCbuTIVyqstW
	 LrlmYwWA9/4xkNzed6AtS/14lJYYk69YrTEfWXt9IDG40hqdFr8+UiJgsxOiQIMkPW
	 tBAdyfc+BAfew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 232/317] media: go7007: fix a memleak in go7007_load_encoder
Date: Sun, 24 Mar 2024 19:33:32 -0400
Message-ID: <20240324233458.1352854-233-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 6650eab913d81..3c66542ce284a 100644
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


