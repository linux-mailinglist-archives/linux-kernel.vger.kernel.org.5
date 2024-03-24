Return-Path: <linux-kernel+bounces-114418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C96888A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3430F1C28A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7F8279863;
	Sun, 24 Mar 2024 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5ferkp1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB38915574D;
	Sun, 24 Mar 2024 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321833; cv=none; b=uguN1UBGcIsrghxe8/ks/cgJOmFHoSczlDRfEyYEDgTLmhD1DanN8sIMLeGoQLKqjO5ciNcKRG9As3JyEbw/v3wjnMJ+nFJmiH/01NEgB5FiQ5yKy4UiGo3GDNh0y6PBE4/j0udenDbv5jJ3l4AiVpGr9B8ht68jxH3kI73/cSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321833; c=relaxed/simple;
	bh=f2WAONAyaGu/mywiSi78/xx1tKvqBV4wdKArYHGhmSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=St0ow7ZvxUXzDKjmC12/o3XPqUIe0VxuIIyDAuNzXAHEmTpgrzA7XDAcDMIpu2QZSJdC4aOI3HBYT3PA8mGpEPblJxyW6U2T0MCxBLOmvw84bUnThRcI5F4YSqPSRRnMn0wqadwYTebKxINYbudt604HN4HaphhIcmi7slAKjtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5ferkp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECE1C433F1;
	Sun, 24 Mar 2024 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321832;
	bh=f2WAONAyaGu/mywiSi78/xx1tKvqBV4wdKArYHGhmSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5ferkp1P3o6f72XU/g1ZXH5d/H3I3AkDU7B9cBSfvwswxRWGNhJlZMX9JVU6+2Fd
	 //s7VQBcIUjYb+d58nEOva0OTKRZvCDmejVYSikhYYORDmKqnH3Gq3u/2UH3xy/+bV
	 bOePidO1ZvFPyVYaGN+72cIOgzgFhmEmdIQHmSMGo4LCT/UGpVzl0MSubdYgU62JTg
	 YVlANU5WlXv3EcU+Z5U9Pw34xEzzA5gIP3Qmec48aMwePGNsLUcnmYHQAcj2Ptn6KC
	 2JwGakDzmFsYvIgRcev/ftK5UmFB151Ur9ehQO0rBV1SwPI21xCoOzp95f9fF5A6h9
	 +Ph+G/rcp315A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 561/638] tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT
Date: Sun, 24 Mar 2024 18:59:58 -0400
Message-ID: <20240324230116.1348576-562-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 07fb8a9dac633..5a4d88e134715 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -990,11 +990,10 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
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


