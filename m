Return-Path: <linux-kernel+bounces-115152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D65888D78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904E31F2A552
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0C428F3DE;
	Mon, 25 Mar 2024 01:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxdJ04Uv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908828ECCC;
	Sun, 24 Mar 2024 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324171; cv=none; b=LUMi7BsFbLoinhZS1ckVZKMc7mmppRu4aXYzHedpKknF8L+n6iWdeE3hJkjhLGl7cSAYYXR2FxxQhgqCHy5i1oUP85SProLvSA/lNRFso3bCMaLt28uQstSM291Ojd2w2rjulBReBzCH8BXfSoJNbHRMwQpMm+RGkbN/x1sLKd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324171; c=relaxed/simple;
	bh=6++RCpH2hCFj5OF3LzO27qxjf79fu8qDIIPUQYtLPu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnNYWb1dzSVS1S5NkFP3ZINfwyIrMUHUZaEnbx6Fez5gNtSkERm+7SOqhJv6UXUuyP63HwQdzgBapZP/b1/oJaUPSg27+rh9vv1pzE6FrhRZsobAwlqUXwRBFA2UrYU6+XiCHxsv4JoD3JZSwrxKi4jbBrvKRjB7zQ2diOBJlLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxdJ04Uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF73BC433F1;
	Sun, 24 Mar 2024 23:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324170;
	bh=6++RCpH2hCFj5OF3LzO27qxjf79fu8qDIIPUQYtLPu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxdJ04UvI/8GHFUMp4kM2v28LZSlHMM0Be1SZUvaB1GA9SVwYVkbI67xgYcY71hAO
	 hSj1bCM2MlgBHNBv+zHZ4jfJhsGt/urP4PU5LR0rpDF+ZF65zebqT9CDgU2PokSJiL
	 RIh0hVBynb7z9a3UinK6OnUwTia6YjqB4G221hslqDuvlmuMC+b4M8JRkr3JVRXEZ3
	 up8f43N/sq+Ie6aGw4xYKkIUDwnvEKyXq8WcH40pkFqDXFxLFGevZzaspd2Fxirfyc
	 E/fJwJC4+z9eW9UfARkkezexUplZpLJBo4H2mMspcffA/o/7PmPIOv4TjBfzZn8VqH
	 BaK52XixxRofw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 163/183] tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT
Date: Sun, 24 Mar 2024 19:46:16 -0400
Message-ID: <20240324234638.1355609-164-sashal@kernel.org>
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
 drivers/tty/serial/samsung.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 24f9bd9101662..78d97dbfc18a8 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -800,11 +800,10 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
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


