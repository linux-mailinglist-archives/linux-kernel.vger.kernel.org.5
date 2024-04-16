Return-Path: <linux-kernel+bounces-146288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDE38A633A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EA0283421
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684203BB24;
	Tue, 16 Apr 2024 05:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbER8nYL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7A3539C;
	Tue, 16 Apr 2024 05:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246512; cv=none; b=Tw48Rx4DFH3FliS4a4gpTNYknqT3ynBp3ZLz1DUNv10aW3v/oh+TOZPhSRb3q2fCUqjoinSbNqQsikTjPkxREIUJAY6WQoYlzjXiHEB66Dl4y4cU+3js0n7a2uEF7R+k/cESXArkBAuTI9lSASL7VimRHWNmY7rr/h0e8EhSVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246512; c=relaxed/simple;
	bh=TenS7osWv9s/9Jh6uxGzY8R47mJAGgM3ek3C2c2/Yho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQrv0sLJXvc6xCDy6cBgiJRFEzmjokfbCFl80B/qDP0pkSgRhC4k0cOqQwt3mlDui8etkZr1zi5nM6QoLeAfygQaKx7LYBWfIexdGSIseWnvzQTPZO679a+tS38o4YTiDe5hPjl16cKvUa0t4qp1GCzWaCYp/VGvQqYFFVKJAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbER8nYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC4AC113CE;
	Tue, 16 Apr 2024 05:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713246510;
	bh=TenS7osWv9s/9Jh6uxGzY8R47mJAGgM3ek3C2c2/Yho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZbER8nYLUIIjS30NXjJqeds3Ul9G382K+Go27g16/LkqOliUU2PcQbgsZ7IwVvPQB
	 AvpNaz1cli8oqhHZWJJnULv7FWqPsLzHGW/ntcCQTkCP87G4atKjmkVRZok/QHp07I
	 R65Of2LEoRmDC0O/0gSeiMm7/PJUX0jIikO6fvjaVMeXb0oD2UZxMBacBGXuPpGOL/
	 XuKWsqTFXsNO6SESO2ZjELkmC2A0GgsJCCRtO42v0FglZEN7LSM8VhPfrPDOj98Viy
	 Ikxqi9XqxbXNGjNGLvnL536ZmKVPxi+imFyZWeeLasK+K2+Jz2Qs+Fpd6WihkgMQt3
	 yJGntA62YB6Rg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH] serial: meson+qcom: don't advance the kfifo twice
Date: Tue, 16 Apr 2024 07:48:25 +0200
Message-ID: <20240416054825.6211-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <1dd9e3a1-29d0-4628-9b6a-b7e9fc09bf0f@samsung.com>
References: <1dd9e3a1-29d0-4628-9b6a-b7e9fc09bf0f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Marek reports, that the -next commit 1788cf6a91d9 (tty: serial: switch
from circ_buf to kfifo) broke meson_uart and qcom_geni_serial. The
commit mistakenly advanced the kfifo twice: once by
uart_fifo_get()/kfifo_out() and second time by uart_xmit_advance().

To advance the fifo only once, drop the superfluous uart_xmit_advance()
from both.

To count the TX statistics properly, use uart_fifo_out() in
qcom_geni_serial (meson_uart_start_tx() already uses that).

I checked all other uses of uart_xmit_advance() and they appear correct:
either they are finishing DMA transfers or are after peek/linear_ptr
(i.e. they do not advance fifo).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
---
 drivers/tty/serial/meson_uart.c       | 1 -
 drivers/tty/serial/qcom_geni_serial.c | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 4587ed4d4d5d..8eb586ac3b0d 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -162,7 +162,6 @@ static void meson_uart_start_tx(struct uart_port *port)
 			break;
 
 		writel(ch, port->membase + AML_UART_WFIFO);
-		uart_xmit_advance(port, 1);
 	}
 
 	if (!kfifo_is_empty(&tport->xmit_fifo)) {
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7814982f1921..2bd25afe0d92 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -855,7 +855,6 @@ static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
 					     unsigned int chunk)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
-	struct tty_port *tport = &uport->state->port;
 	unsigned int tx_bytes, remaining = chunk;
 	u8 buf[BYTES_PER_FIFO_WORD];
 
@@ -863,8 +862,7 @@ static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
 		memset(buf, 0, sizeof(buf));
 		tx_bytes = min(remaining, BYTES_PER_FIFO_WORD);
 
-		tx_bytes = kfifo_out(&tport->xmit_fifo, buf, tx_bytes);
-		uart_xmit_advance(uport, tx_bytes);
+		tx_bytes = uart_fifo_out(uport, buf, tx_bytes);
 
 		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
 
-- 
2.44.0


