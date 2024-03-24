Return-Path: <linux-kernel+bounces-115246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD12888DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7919A1C29FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46071CD9C4;
	Mon, 25 Mar 2024 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7YFjK9+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F26297D69;
	Sun, 24 Mar 2024 23:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324349; cv=none; b=IccQt1DEp49CGgeAKSq8GenwqZYjFs/moW6Pw0cNyvh8E6UJfSmcnv3+vibmmcgmAqXjrItTVlY7L2t8n26wHlJWoS15FZQhE2j+dEhGTWxe4Z+UE1763NzTMyXME9LuIbRa8RfzsnuUtyMGBe6m46QHRg1/agKPR+PHpnugpNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324349; c=relaxed/simple;
	bh=yQrRVRg9O4wS1MvntWCu1dUYsbk/+L2CI1WsSOqBqYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqYB5ETyzp7YQ30fPON3mTZtnVfxfawGAdYCbAe0CQmG91bgg6olcD+y19cNplJOCTbVBSp5lcfjRBA5LYzY14AWR0QjKrE2AJCkR4nru1RCdcxd0r/CubVFIe0v3INhHw5U5tcUu1hzgwmHLXY1n2Rvu3FrTU4qv+oU09KOCO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7YFjK9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A1FC43390;
	Sun, 24 Mar 2024 23:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324348;
	bh=yQrRVRg9O4wS1MvntWCu1dUYsbk/+L2CI1WsSOqBqYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7YFjK9+aMLu2WcDK6j1P0OicW2/MJ6kGnuUdtvJiN52nDciVSczrTOj96eHYw6Z/
	 MKHzie6vjMBZ0mxfpKbPxr4HwxBYm22jfEDsfxxAgIYPNfjs9a9OuDmCtevH0ezwBI
	 eD56GLhl10EBCrWyUf1Tr3r8+f0S05Vr4+qaKudFCS2bMhgYqdt67WMmh+JEKpEvDD
	 91DuAKF3G7mMqDJ2jpQD2Ej5hqaYs3lPrH9ksDFaPcpRjQrDbSLFzFy6D3/W/ew3Or
	 F6aYuT1K1X+kqnmhVqiFi2UVMcpXO6jub50urGnKjygvbObSBIwT1oFmO0s1D/FCUJ
	 AAuqQ+eul5N0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 117/148] media: go7007: fix a memleak in go7007_load_encoder
Date: Sun, 24 Mar 2024 19:49:41 -0400
Message-ID: <20240324235012.1356413-118-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index c7b5a3321cd74..15f78d3ce3bac 100644
--- a/drivers/media/usb/go7007/go7007-driver.c
+++ b/drivers/media/usb/go7007/go7007-driver.c
@@ -88,7 +88,7 @@ static int go7007_load_encoder(struct go7007 *go)
 	const struct firmware *fw_entry;
 	char fw_name[] = "go7007/go7007fw.bin";
 	void *bounce;
-	int fw_len, rv = 0;
+	int fw_len;
 	u16 intr_val, intr_data;
 
 	if (go->boot_fw == NULL) {
@@ -117,9 +117,11 @@ static int go7007_load_encoder(struct go7007 *go)
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


