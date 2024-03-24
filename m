Return-Path: <linux-kernel+bounces-113505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF1D8884D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27B02848A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D239C1BA661;
	Sun, 24 Mar 2024 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEy2McVm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA6C1BAC50;
	Sun, 24 Mar 2024 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320307; cv=none; b=LP6m2IEHrlPEchGElEazlb0LYRbUp5114Jy2ssdgFzerMWwK155dZrWzPvEYPnsO+Wle0PmU//Pg9ncvnAV9XBIk8lu4FcA3AHBg86xPNubOKp2wxMU9RYjMe3smm6q/O4sxkvqyltXfue3Pu8KTTvDZEaO0O/WkUkQYwH6vkMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320307; c=relaxed/simple;
	bh=jAH25uVIxCgxMKNGJbcjK9baw41+QQ1dB6fGxMGjdnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yn1l8oQe2w8W9SvIRHdbiDdUGIjJy7MXStGvqBbGbAj7uMUNvI3tvkat/33dix8SjXOo0nEy4Fs8m3i2WO2p9wtKw088jvlN/hebvgVM4KMU8dC4tT4FNuTLmBA63cS80PhnC//N54xUB+n6sFzWEWh1/3Kwcg60iA8GPYabqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEy2McVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E756CC43394;
	Sun, 24 Mar 2024 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320306;
	bh=jAH25uVIxCgxMKNGJbcjK9baw41+QQ1dB6fGxMGjdnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEy2McVmcdfyJW3me8G2LtYB/KFL+MvGIal0qkTplrS9sz3440jStCjRzi6K56oat
	 oGdpZrecmSUGbWFJPbkWOvtTmm4f25EoubIWpVH/j+glMmEDU2eK6r8s0YIbvPpVPB
	 JCPKQaNU3C5M5ErmVEenRkjCSm7/jWNAarPYPbDmTC1Si789/cDUCR5Y+o1vnN6mdy
	 tX/EGtxiG/LL3DTItGXmtoGOCO76pKgl4uIDQVXRkku4cz1bG0PzowydjTYmRg41cp
	 Gs5XS8tnO6GPFohRZ3tBhLpBKJ172rl/DRwEHiFfBDqPXIMrxhKzw14j4YyxMUzYl/
	 bs6wAKWVYSEFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 614/715] tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT
Date: Sun, 24 Mar 2024 18:33:13 -0400
Message-ID: <20240324223455.1342824-615-sashal@kernel.org>
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
index 71d17d804fdab..6fdb32b833466 100644
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


