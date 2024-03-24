Return-Path: <linux-kernel+bounces-113949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E3D888783
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31841F25BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA101F0961;
	Sun, 24 Mar 2024 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9CPzo4V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1214B076;
	Sun, 24 Mar 2024 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321062; cv=none; b=B943b7umW/ISCdrbXrNbxHzDVJsPIJKVx/tcwzQ8ZppsvsSBRvLq/OoorlPaUWAFrx2CxszOAbCBfnW/hvXAs3n8MCmyYZlFi6qUvmGNBU4kA3C9Xbvv7IJuscgBKn4zOAdwJCTHLiNuugnuQSLOhXeOtwxeX9YvUx0k5Wgzzww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321062; c=relaxed/simple;
	bh=3CRWekLwFioJeZgnXz6vAQ0PCM/tVBdgdeT6ULdDfkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqPT8CYLb6AgSogJVuOPl5A14/vkVCFGDYdo6Cmi8Vyc7NVbKWsRaZKrVz8nKuqgnIwMrkAORTMxmWEvty0EvVoEjVToE5URMLaNr2MYE/Vf4fTt16EZi9P0+Zqe3mvp0nKBIifXl/NUolCXyFzqzt7G+kSG9AfVEJMHXWAyZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9CPzo4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A7DC43390;
	Sun, 24 Mar 2024 22:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321061;
	bh=3CRWekLwFioJeZgnXz6vAQ0PCM/tVBdgdeT6ULdDfkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9CPzo4VMLnjdA+7JCDLnYEVW0Fzv40HmzYVmkysW7jii1gIyGymGtGbC4OeOQCv+
	 TQhmQ7QVfE4qG86o/+6t6bgbrFRdP9nMCv2+SwrBGhtGzPiTjNbMTbG4Ei0jkmmiGJ
	 nLVdZfuX/YzxGJl6v9Go/27B8VDvJ0Ym21PUZjTAIxrO3GsXNePDDw+QQ+dd2yP+Ua
	 7f2eZK0HfVUnN6BUyukFIX7/+YcwnAWPDSTJ/RUK4qRFiOmwAMXkDaQkwKHROh+Bsp
	 FqQdWgU39k4BEjpD9HA7VLh7RCNRmQ7ii+UcYV3a3dURZvEEApFFbWtLBJg2ciE4Uj
	 t9h0w9+eJAewQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 625/713] tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT
Date: Sun, 24 Mar 2024 18:45:51 -0400
Message-ID: <20240324224720.1345309-626-sashal@kernel.org>
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

From: Tudor Ambarus <tudor.ambarus@linaro.org>

[ Upstream commit 314c2b399288f0058a8c5b6683292cbde5f1531b ]

The core expects for tx_empty() either TIOCSER_TEMT when the tx is
empty or 0 otherwise. s3c24xx_serial_txempty_nofifo() might return
0x4, and at least uart_get_lsr_info() tries to clear exactly
TIOCSER_TEMT (BIT(1)). Fix tx_empty() to return TIOCSER_TEMT.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Link: https://lore.kernel.org/r/20240119104526.1221243-2-tudor.ambarus@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 3bd552841cd28..06d140c9f56cf 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -987,11 +987,10 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 		if ((ufstat & info->tx_fifomask) != 0 ||
 		    (ufstat & info->tx_fifofull))
 			return 0;
-
-		return 1;
+		return TIOCSER_TEMT;
 	}
 
-	return s3c24xx_serial_txempty_nofifo(port);
+	return s3c24xx_serial_txempty_nofifo(port) ? TIOCSER_TEMT : 0;
 }
 
 /* no modem control lines */
-- 
2.43.0


