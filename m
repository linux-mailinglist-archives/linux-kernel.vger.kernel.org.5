Return-Path: <linux-kernel+bounces-116285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70588895DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C19299BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E413CB8F4;
	Mon, 25 Mar 2024 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4pidBnE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A345038;
	Sun, 24 Mar 2024 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324139; cv=none; b=eSDrR+OKO6oJAHis5qpKaXoNt1wMKGPzkgE4kRm9hZuXLCF60QNYKTvKHP0fYQkLzqpFMbHE6v0MZKo5ZLxTuZ2KL/x4Q4MPpdazohA8FevMPzYhToSBYiBMxU2xq0CpbJlR8ks7EFOlJsqizM52GWJCPF4hNBRZotvnQGyZdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324139; c=relaxed/simple;
	bh=jsmquPFMRbDY+YIiRzxqSApPUWnYvWRIhZBNozaJxdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZ5ExVJuBtkD7MdkD10ViDza4J8AUuCIdhAYr4l/CPZOs43RMNDEgDVnSVNuPfuf+laUhhylxXyeOPy/Wgdi7w2A6Fz3mVGtDJcDanH+A6iZZX0GEEOR8KQPvBeyWVo+LmZaOFajBFiFhqIfKAyEl7IhvAv/OGeC3tN92RvIa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4pidBnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFA3C43394;
	Sun, 24 Mar 2024 23:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324138;
	bh=jsmquPFMRbDY+YIiRzxqSApPUWnYvWRIhZBNozaJxdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4pidBnEUkma08rSoMmieUz4ertTD43nwIXPQvCUdbT/Nal6Gqk4PUdoHbFs06Dz+
	 S/gKgY0dwPuVbkm21l1EaMRsJOYdyrXO5AuBcRuRfqmt00ixSxpWzPWczTZqqNwhfF
	 7BFGNt0B9FmyS731EWmvxg2hs4Hdyd93VtJaiYi4JUf91R8ffmpauVJ/HtrcWmQ/kb
	 5noBEJH5HVem0e1P1/HMX5w3suLH3gohAQLP+pwr14K+uil5083j37KkKeFEhGPuBm
	 Fmqe6d+TTdh9pn+51y0OZGUaAZj3Fwk4FwTabQkCJeC2+LPCzs+MUqvlkXREYkG3xE
	 Fku1PZqMhRtqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 135/183] media: go7007: fix a memleak in go7007_load_encoder
Date: Sun, 24 Mar 2024 19:45:48 -0400
Message-ID: <20240324234638.1355609-136-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index b9302d77d6c83..8ee0d5ea84157 100644
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


