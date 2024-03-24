Return-Path: <linux-kernel+bounces-115255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1173E889374
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4209D1C2DDEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66143165C8;
	Mon, 25 Mar 2024 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0nVSGV9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBB71FD5C5;
	Sun, 24 Mar 2024 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324369; cv=none; b=Sn6NrSPYJrQ49vvaksbCEiJj0q0f11QIW/kNSeu4wUdNoQSBNFRPNRIz6Lnke+HF2NijDv814nAKYlN4E72VjxKGj7agcQcn2Pz4apxTVL9zB9XV3jTapMEJ5Sq//a7mASKMpGnveZNzxglZ1SFy5mFhgx+tYV574Z5Bn8lrLAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324369; c=relaxed/simple;
	bh=06xuqTypK2d+lu+sZouf0JkP/CjeANELuavDeS4nOX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTLZ6WgUK1GL16X6RiqDtM37IKd87DyCH8SpV45zTr5DzC4VQYltA+wbhNuRILc0IVgwU7CBMgJcRDtr+2sbYf3pvHnX4Yw2YLR1tjj1460471dUnRzCW/1xQ3crZRHNe0I3KLBIoYEqm6gxKGovA94YR2jV29lYzU6LVQFjvxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0nVSGV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E415DC433C7;
	Sun, 24 Mar 2024 23:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324369;
	bh=06xuqTypK2d+lu+sZouf0JkP/CjeANELuavDeS4nOX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0nVSGV9DT26Kfn6OZ3R9g5qKJcagoOzQJrufx70nMxRUc7+ugckzjZYylgbmf+Kj
	 h0kQh6F24ovfKb0Y2qtzIJxp7qD2qkSPZ3rc2bPKFE3rGaOaludjTbIErPrdL6lK/w
	 ENcB+MJLjjDkH7VzhA1/g5K5lATe5/OXOgBlJGZ2j2MaRniKcWLUwXz+zJWgUp/XCc
	 GZ9fY/x3KBKiFXU1NmaIqt+Y0ecX5Z3FCHu3h51o5riIQZAAyaVPZTFWGn/3agk+B2
	 HtcWvIrRT+XsA6KpPB4iT9NvFHAfaAiPlHynqlYEMXfgFfGSzuGAQvba/hakcX+DtH
	 HHrWbfE7Hzz7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 136/148] tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT
Date: Sun, 24 Mar 2024 19:50:00 -0400
Message-ID: <20240324235012.1356413-137-sashal@kernel.org>
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
index 5f1f52cc63951..c76bf1c11e6fd 100644
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


