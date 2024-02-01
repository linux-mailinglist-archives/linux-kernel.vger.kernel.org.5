Return-Path: <linux-kernel+bounces-47992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34558455D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DF01C22D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519AD15CD62;
	Thu,  1 Feb 2024 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUaKph8x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCFC15CD43;
	Thu,  1 Feb 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784963; cv=none; b=BvyUuW2DkfPPzitmBCuFKmnQPrThAVoHBtsiN65Nek53ZmSTO5Gys3X8KAWYqYNXJZGuDnU8BnXicjicx/JwLjWjb+iqKFGcOui+sWgnXfEvFKi0fcgWL7YpxuuQcPranDTRCv4tA/mKw6ec65cDu2m8Ija8IK7lAQBzZVNRYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784963; c=relaxed/simple;
	bh=o3j5KqVdt8Au5j0om5ZdjUVuI6rkV1Y9G2/tHqdbaOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAHCmmGJt79+NfelF7Yz4nd83ohqrjVmhry5XmKVsBKgH1QmH8aRArD3qqQQUxb4NVCm0Nmk3P4tRzDw5UVI15jJqhw90u9VpSuiUAj0hFnJdbrVaXaUuvrVTxox/M8e6fVk59vEmWCO2pM4uqIzSnNn6sZJDTfheNERYcU15kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUaKph8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C3BC433C7;
	Thu,  1 Feb 2024 10:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706784963;
	bh=o3j5KqVdt8Au5j0om5ZdjUVuI6rkV1Y9G2/tHqdbaOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUaKph8xPqGQ3Q0JdaB99nurQQt85rvSlaTcysObhdRWMIaXD28BaQ4epSB/Ew7LV
	 LZDaEHppz9Ead7F5/mp6Ej7Hoax0ufsG+QDrF9Gu9GXiLXJiOCApISxcsSo0WEl/AQ
	 OU5FVpDkPDHKLjBSVT6J4Ee8SXQurdriEBhR3YzbssZxs8EgOP0fyMNa7lYnOPJAnR
	 RKxFkYavoMKxrId9fR5kdWgnjDR9AFEAMLE7O+OYzNhGExRXSy08LFDQKbVfiUQ+yf
	 3qYM1xNEM+VMxEYcubJNH8ZSNWi8tNcO4v5QRh/31xdHTdzDXyd1OtiCypTPBxS7B/
	 YxrmA8FOKz+AA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Emil Kronborg <emil.kronborg@protonmail.com>
Subject: [PATCH v2 2/2] serial: mxs-auart: fix tx
Date: Thu,  1 Feb 2024 11:55:57 +0100
Message-ID: <20240201105557.28043-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201105557.28043-1-jirislaby@kernel.org>
References: <20240201105557.28043-1-jirislaby@kernel.org>
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


