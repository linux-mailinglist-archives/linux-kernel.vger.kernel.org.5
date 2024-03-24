Return-Path: <linux-kernel+bounces-113887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0E5888728
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC2C293C78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E925F20D5DF;
	Sun, 24 Mar 2024 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNsVyuYk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300E12AAFF;
	Sun, 24 Mar 2024 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320957; cv=none; b=Y8EHQRLuq4uYBxEtoddx37WubpfLnMqtjKTATqXrjvDt98tpDSGgyIjDx9DzPNAiRu845w1h26WrLpYnSSweXSUTrkZghqy5kKg+f4yC0WNIQXufxrxinXybnM+Ck6z5qy+71ipSwUOe83e1+kTF5LDb3BkTypeJpy8VTNoDW0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320957; c=relaxed/simple;
	bh=TLyEqfyntQ6dgjomKdKwyWv+EdNOs2VIapsu7gTdO5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdjJRoDHG8xyFchlyJiYIXyi0O7xxiaZEzvyZNY4Q+uAEmSL9ruIqDyjMtacLUf4wtQiYDiocSLLNdcJ9MJsCqAIMfLLrKxslyEzNQeicA6vl29KppukbVjpHqfADW3+AxYOb68h9SvJQG9RgnN8hNTFs1Je9/kXf/nI98V/s9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNsVyuYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5392FC433C7;
	Sun, 24 Mar 2024 22:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320956;
	bh=TLyEqfyntQ6dgjomKdKwyWv+EdNOs2VIapsu7gTdO5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNsVyuYk7dSXxPifUiIV/PNwjLkogfke11OH3EcgK+CGoMGgk0UBycw6n07Wx8J2T
	 jylewWH/VninvW5AN1VFUSfMAk28MH+lT36bAAiCtwIjkkNbVqhbXYt5kfLQG0kmGy
	 CHCH/Iyht3zDsN47eiNXgG2zyh/GihKBPEoZnvlbzro1Pjz6syY6XmVTUqL2+vfOJx
	 NkFJgTfqioB4czrvoL6KGNNXfvMMfG3XdEhcPWX8YdMnscle2AuY685YYlho/Qt6+U
	 jDzj8HOyEZ7tXdPrWTN12Np7AEpGBsLZsCN1fCMAAcvBBfvKRAiUFtEu57XNo8Bya0
	 9SCBWM4M50NDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 519/713] media: go7007: fix a memleak in go7007_load_encoder
Date: Sun, 24 Mar 2024 18:44:05 -0400
Message-ID: <20240324224720.1345309-520-sashal@kernel.org>
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


