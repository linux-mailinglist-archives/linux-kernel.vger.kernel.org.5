Return-Path: <linux-kernel+bounces-116195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A04889D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522AE1F36C33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15463BAA51;
	Mon, 25 Mar 2024 03:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKosLWJZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362F17C6B4;
	Sun, 24 Mar 2024 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323797; cv=none; b=nqoR9JNRrXnqbWxsqXDTAJScHG4iFEoMfMc+lfj+67ac/kVrxWLQf5GyqhUChLZvjpv7/bwMh0BHRYBHvIMCt0zmPH4OAqnzV3DS0Nr4ooXA2ofmkMqlWtWnAQDmVTheEqklYxIgusejqDYUPi4ppLG8wjphvKdimoY1HvD8Bq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323797; c=relaxed/simple;
	bh=X1cmmr4RfhomyDJsZCk6Jfrkx98hI1Q3e6kuxotVY7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsqXqquORCNg/mfHlZwyNpEWQIDAxdfjJaAo9JDbqAnm+Rh7Tx84CktyN5cgUaDQk82K51TEmKjBbKPMcnVcbL4AkVlCtEm7m7w6GKtlR6dbdBKWVkWBEKw2xXOIHuCQBEUc626KXlrRg+zaqVUi+2v3tyK0yBW9FCNywURdoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKosLWJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F723C43394;
	Sun, 24 Mar 2024 23:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323796;
	bh=X1cmmr4RfhomyDJsZCk6Jfrkx98hI1Q3e6kuxotVY7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKosLWJZKOP15RUYm8hWFtWm7GDTepwGa64P3KPzcK4WeHl/JgT1AcrRZYnXf+IVL
	 8MsdijdE2S3TW9uUsQ0Y8vBFM4vHVvJ0sVzSKjRfTF7X/76q4dC6JroI/XZcEvUClC
	 phT7lBBJko+I9AoNOSGKNlVVNsciyiaBMvpwFN8zHBD9Y8JqC0rWfl6NixzqNqfRCD
	 GAr50A6Dc70d04NX5tzYH17N4DfWuhfpiXekj3AvRa3sgVU54ARMCV6zMkNKLmPnLN
	 OoaesJZbBEc86BuKSgRxrQw0VbgteiAfi8mT6XVCpOQk98+lZM4ISs8kSBC4/wymSz
	 tXpADwP2DsCew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 174/238] media: go7007: fix a memleak in go7007_load_encoder
Date: Sun, 24 Mar 2024 19:39:22 -0400
Message-ID: <20240324234027.1354210-175-sashal@kernel.org>
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


