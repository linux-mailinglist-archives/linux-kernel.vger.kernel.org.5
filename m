Return-Path: <linux-kernel+bounces-113382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 909988883E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302A5B2370E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F921A0AE5;
	Sun, 24 Mar 2024 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLlcXKWp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7051A03CF;
	Sun, 24 Mar 2024 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320183; cv=none; b=kEBu+0PzOP/4XwC+39ccVtV85GxKtk1VZgt4AztaEZhYJPdtcC9xZ3ChTdjoioynAEg9MQa+uKNGMSGIkQL03NQ/+uSoNr0kGP7M4BG5InOHiJo598bZKKzBisSQKTkpn5unapRwlXE8EHe+nPpe9kB1FOs9bEyNeij1Zp39e7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320183; c=relaxed/simple;
	bh=TLyEqfyntQ6dgjomKdKwyWv+EdNOs2VIapsu7gTdO5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPYWg3AL8LTeCdPbwOmUhu8SC6e2NS/sK/q0LsCQIb6nUxLMYmeG/IpCipax380auZUlNrd8ymbbs2Kgq0Sxm0qAbQuMIwcQXDhmaWywpVfbKmkiMyQMUfi2t9CZ5ApmCgqfyGIh47gnvw6U6gn/8aXq5LZ2Jq3TFcAO6/FEhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLlcXKWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBF0C433C7;
	Sun, 24 Mar 2024 22:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320183;
	bh=TLyEqfyntQ6dgjomKdKwyWv+EdNOs2VIapsu7gTdO5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLlcXKWpfnSvjS4wfInjBG6jYYmvB+dcJKHCl2/SiFYc9XfY2zf81LWZfFuhyLdws
	 xbtVZN/ejlrQIYh2zKFc6dHuVq31KZyEWhNzqvAJ+fLuzpsLh2y++nXCxkfQZWOLz+
	 9Aa9JO4o8aMseeHJcxZ3MFpfqQlUP7KTjm7bjF58XfwI6zONBsI+hnOvJNFtT3a9iO
	 2RgNCrSfhnRmOpiuJxecAR3F7O/LXprxhH0y1kFCFqWoug1LqJve0J4CZV3TYzqZdg
	 Bzxs0gs/ig9TjVKPKVa9lL4wo3BtptDB6aNNckfuZYpzVhI5az4JUhx8+Kyx5iqmW7
	 bIEOzzu0k6rng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 491/715] media: go7007: fix a memleak in go7007_load_encoder
Date: Sun, 24 Mar 2024 18:31:10 -0400
Message-ID: <20240324223455.1342824-492-sashal@kernel.org>
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


