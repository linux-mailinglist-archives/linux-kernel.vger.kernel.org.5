Return-Path: <linux-kernel+bounces-114669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1C7888C77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A87EB2CADE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA8F2AE8DF;
	Sun, 24 Mar 2024 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCbHsJXv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73815ECC4;
	Sun, 24 Mar 2024 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322310; cv=none; b=YNNZ+4zCJjrDsHFbN8+irC7TfeTLMmyt9uV59F91vuCgPl9J+Ri+raapcmcyyJG9Ch9JEabQGNxyxvWFPzDxAJm3MUVZaJcbTbUVjir0gal0KIE8o9C5C/IpQbDdSxofILiXuyOcswqvLoV80dw/SLEsSBTewe3RdRAOCWvOEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322310; c=relaxed/simple;
	bh=0tn7JdnpqsNxmICS9PEs5ksvyKLvc9+5NgJKMZwIkTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xg5S9Uh6hd5Tr7OM0DINShNRLTiU1Wp+/3bcRK47QCjtXrU5StB8XewIMC6xoy4xoG83wHDN3lpxhBCj6g7LdiDRiwgHeOIPZLd7p3YKjrHximnZH/gy/eZEK+LGB0CP6ZufBsDJPCJhtIS1BBXPnYXuiwaC50Lkh82nl9Q6ILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCbHsJXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70275C433C7;
	Sun, 24 Mar 2024 23:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322309;
	bh=0tn7JdnpqsNxmICS9PEs5ksvyKLvc9+5NgJKMZwIkTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCbHsJXvEFU3nGOqZZpH1J+BsWRa5xO2j/CJILQyZQW2HSKcaHmzEU/zGIVlarohp
	 EY5t6uqcDhJ7J/8QeFkjGOk35xhv0KoWz+z8Ucej3JIZOgbTBtnW0pGQnrpPthaA+C
	 MAbpf/RHcRCzvPlVhRe67a24XTtkQlFAUEerjVL1e1FNIcM2iDxCDAOFAikELmqEGW
	 FVlJKOFsmFR3JbyOGUKUbx8tT6XadKgeT/szwS6j0ykHZkRuUoo9gWGbN93gMVVEoi
	 6HzqyNWz4r8zMek2QCs2lZT7zeFSlhZJ+tQq1hpu1DlLFg1wy2VQrZTgmU5OkkW12l
	 CSSyZfyr9xf8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 392/451] tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT
Date: Sun, 24 Mar 2024 19:11:08 -0400
Message-ID: <20240324231207.1351418-393-sashal@kernel.org>
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
index aa2c51b84116f..589daed19e625 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -996,11 +996,10 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
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


