Return-Path: <linux-kernel+bounces-107343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FBD87FB41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E30282955
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C480380023;
	Tue, 19 Mar 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRp4ugkN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C957FBC3;
	Tue, 19 Mar 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842027; cv=none; b=MP9meu602JUdRf1g/rXkTeZecaKzTByvuf1WQ9fwBJPyxLLajYL4vjGomtVhXSdgqyLxWo+1Zd6DeVaQzY8ZAUpX9xR25AUGJH0VMgw8KiKCR8R5aNLxbLmO8whs5W+gK8FcpUrlIblAMjSdMGBS+86vrTYdYxk0/HGZH+Sd0ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842027; c=relaxed/simple;
	bh=9yRltj2u1toAe8XDEiaX+4QhmVeUjmlStdgTFG4DGqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwtbG3wz0cTXnaidnCDw3o8QYMgkGDtE5ep8F7ql1xnqtYUzjDHEenjl8k1oUSvlGZFmA81yP1KWF1DJgQ2hBDY61JS/KmFXVDFxQwKQjIUoacXpdRBO1OlUsHRHTrhADQKTw7Bp8hnBL0qYVxhOCsRQzCwvU5Q+BppU6BzX6pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRp4ugkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EE4C433F1;
	Tue, 19 Mar 2024 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710842026;
	bh=9yRltj2u1toAe8XDEiaX+4QhmVeUjmlStdgTFG4DGqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRp4ugkNp0NW9CcymBrhtn4v9kTsrkmiwSFpbZ5wZ89Pc04e/n+EVY8RxH+tyjq44
	 ZPm2pPKXM+L5AxlttLmIAi/73qTvf8Yczxv0iJAvGoxiSEBUFhrEm19dqTvcQ2brAm
	 qRIctQ2mZhXC11BF5st98J6hQuG7bV38q1XQcre/NgV/zhoDRPEDBLW3BmhhJs64Qr
	 WGnc0EAgWKzPISLx5gYVVyEtUyGHsglMSzTxHAwonEeaTO+9P7xc8BqMA7xziPHmfn
	 M0YmhxJ7ZxGBZ5aNCc/13R4LS7i5K+eiN5owkh6ubps5NKUWKah9tSS561SiMLuBYP
	 gaTZFTHumP/EQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [RFT 10/15] tty: 8250_omap: use dmaengine_prep_slave_sg()
Date: Tue, 19 Mar 2024 10:53:10 +0100
Message-ID: <20240319095315.27624-12-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319095315.27624-1-jirislaby@kernel.org>
References: <20240319095315.27624-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparatory for the serial-to-kfifo switch. kfifo understands
only scatter-gatter approach, so switch to that.

No functional change intended, it's just dmaengine_prep_slave_single()
inline expanded.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_omap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 66901d93089a..879e77b30701 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1140,6 +1140,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 	struct omap8250_priv		*priv = p->port.private_data;
 	struct circ_buf			*xmit = &p->port.state->xmit;
 	struct dma_async_tx_descriptor	*desc;
+	struct scatterlist sg;
 	unsigned int	skip_byte = 0;
 	int ret;
 
@@ -1191,9 +1192,11 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 		skip_byte = 1;
 	}
 
-	desc = dmaengine_prep_slave_single(dma->txchan,
-			dma->tx_addr + xmit->tail + skip_byte,
-			dma->tx_size - skip_byte, DMA_MEM_TO_DEV,
+	sg_init_table(&sg, 1);
+	sg_dma_address(&sg) = dma->tx_addr + xmit->tail + skip_byte;
+	sg_dma_len(&sg) = dma->tx_size - skip_byte;
+
+	desc = dmaengine_prep_slave_sg(dma->txchan, &sg, 1, DMA_MEM_TO_DEV,
 			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
 		ret = -EBUSY;
-- 
2.44.0


