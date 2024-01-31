Return-Path: <linux-kernel+bounces-46406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926FC843F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E82628ED10
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BC078B7F;
	Wed, 31 Jan 2024 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SahpwqEd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99778B41;
	Wed, 31 Jan 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703244; cv=none; b=ALGaYXQF4BkdFbpA1Y8TcJfgGfht9u/wftvvGgjdhFOOCisBs9m2rXBq7zsztZRL5E/RxBexrYY3Mc1BqE27Od5VYWtbvaqbUBmOP+Fc3ft8fjT8DNvw7X288ve/jGVGgqGOFaNB3VZXgnV9z64k74tCwGZiCwKjNDrgnsBoW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703244; c=relaxed/simple;
	bh=o3j5KqVdt8Au5j0om5ZdjUVuI6rkV1Y9G2/tHqdbaOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRh79B/C9BAa3Zud6LFigHFc+hZziyof0u7srkvBbLl3oaFHWbXZQCU90GZ5K+qtVAXKsHw3pv4yG1zmPtolbhuYEQ4wSAKxe16miCQ6z3VItxVSwBGkORsXfg4xE3QpySQSV7FMOxV52841F0GN+JyvxpkBWR07uowAgozEPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SahpwqEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAA1C43399;
	Wed, 31 Jan 2024 12:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706703244;
	bh=o3j5KqVdt8Au5j0om5ZdjUVuI6rkV1Y9G2/tHqdbaOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SahpwqEdTvM3SHNx1R87KGgn4n70GQorsMKOi4qMXnpXH9DCHc/gUOFnAA7Hv9JXr
	 TWS/zZZffVBtvWgHiOyRSFpDsE1eu4iQ5rQxwAGraQi/S7qz4F3lt8vDpjaJe7uj5y
	 5bgJ62Vba1wSW0sHB/lbiucoK0kuAlyYEOnnCDXcVXgoS7/Mx5sawyianz2eDaIpQy
	 p/0ktREpwXAY3npV4KuKqZzvluyluZu3PRoEUNxkl9o7XUV8ruIJBO8+4C4lgnSrZA
	 NNXy+iABZiV3GyCMdz2GbLxO78c97Ukhu+X/jyCZip0ylWByG2ab+KSrSS0DH6EjZK
	 RWl+WGdjz0mDw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Emil Kronborg <emil.kronborg@protonmail.com>
Subject: [PATCH 2/2] serial: mxs-auart: fix tx
Date: Wed, 31 Jan 2024 13:13:58 +0100
Message-ID: <20240131121359.7855-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131121359.7855-1-jirislaby@kernel.org>
References: <20240131121359.7855-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emil reports:
  After updating Linux on an i.MX28 board, serial communication over
  AUART broke. When I TX from the board and measure on the TX pin, it
  seems like the HW fifo is not emptied before the transmission is
  stopped.

MXS performs weird things with stop_tx(). The driver makes it
conditional on uart_tx_stopped().

So the driver needs special handling. Pass the brand new UART_TX_NOSTOP
to uart_port_tx_flags() and handle the stop on its own.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reported-by: Emil Kronborg <emil.kronborg@protonmail.com>
Fixes: 2d141e683e9a ("tty: serial: use uart_port_tx() helper")
Closes: https://lore.kernel.org/all/miwgbnvy3hjpnricubg76ytpn7xoceehwahupy25bubbduu23s@om2lptpa26xw/
---
 drivers/tty/serial/mxs-auart.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 3ec725555bcc..4749331fe618 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -605,13 +605,16 @@ static void mxs_auart_tx_chars(struct mxs_auart_port *s)
 		return;
 	}
 
-	pending = uart_port_tx(&s->port, ch,
+	pending = uart_port_tx_flags(&s->port, ch, UART_TX_NOSTOP,
 		!(mxs_read(s, REG_STAT) & AUART_STAT_TXFF),
 		mxs_write(ch, s, REG_DATA));
 	if (pending)
 		mxs_set(AUART_INTR_TXIEN, s, REG_INTR);
 	else
 		mxs_clr(AUART_INTR_TXIEN, s, REG_INTR);
+
+	if (uart_tx_stopped(&s->port))
+               mxs_auart_stop_tx(&s->port);
 }
 
 static void mxs_auart_rx_char(struct mxs_auart_port *s)
-- 
2.43.0


