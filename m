Return-Path: <linux-kernel+bounces-116097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 233E0889BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD334B2C7CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23607181B95;
	Mon, 25 Mar 2024 03:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMyUXeSh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA227DE0F;
	Sun, 24 Mar 2024 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323574; cv=none; b=qMFF2lEFwsDAgEtje7JjiTndhsiphW3Cknsq4GHBq/gF2LHvYiGsu+SWMd+b4EZ5XLEoCaDBZZDnHdelhvQ0sgtOjThQBGUmRSoxhqioKh07jXkuxwH3cSqfPMTAXr1uoCUF23M9JxHwIMJXMhPd7BtYOHmzMwkHNL/ECsMfIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323574; c=relaxed/simple;
	bh=gZlmWmYHeEPssd+jm6Q0rdE6stob/+WnvKW/S/OzDzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPTI754ARl5FHKyNihHoG542X0B8i3kVE/Df8q7Pxua/OPHdu1Y35VgWvCg8DUSmwRHjkYONgPPrLwc+ZjgQRYXpwfqKn1H40Fb5FYFmjWi7oIaLnSpJKzNYXj/6Ecn5z2AKuVZZ/Txs+hsgirn+kajfKLcxdsK+bfsGaDcwk5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMyUXeSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13ACC43390;
	Sun, 24 Mar 2024 23:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323573;
	bh=gZlmWmYHeEPssd+jm6Q0rdE6stob/+WnvKW/S/OzDzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMyUXeShIr48kE1lTlL40QU0yY5rLEP7UzPB/0SJwGlxbo5FXqjoODhaReaURIDtr
	 GTIlhld8cAqdZd/Dwl8uqTSbjKAjFQmPw+eYfjGG5y8tbOJzsRQ2aBCQT9Q38ttNvs
	 lzIkiLckP9ODTq8ycyIQ80zCei6F77AV6+e0RH1Zq7/MiFZOk9v+X1Hw9KzItWxpRC
	 Ttkel4Gydmo4aRxrG5xf/XhC2BS0i/ER6kZcx3pgxmgZ3WXw977JfTzWK7ZyIuVduV
	 2KAAxzX1uFdzLQrOXUxMFRPsAsBiCR6JL5wV/SNqSc+2jUMDh5QrXIhs02Yq7SO0R/
	 u/9k/VGipTZBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 280/317] tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT
Date: Sun, 24 Mar 2024 19:34:20 -0400
Message-ID: <20240324233458.1352854-281-sashal@kernel.org>
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
index 09b2b40b63c4d..7d3630ddebb39 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -991,11 +991,10 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
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


